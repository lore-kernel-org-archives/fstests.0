Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF30618E34
	for <fstests@vger.kernel.org>; Sat, 11 Nov 2023 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="KdJJ8csh"
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Nov 2023 08:19:24 PST
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d203])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50693A9B
	for <fstests@vger.kernel.org>; Sat, 11 Nov 2023 08:19:24 -0800 (PST)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward203b.mail.yandex.net (Yandex) with ESMTP id 7843E64182
	for <fstests@vger.kernel.org>; Sat, 11 Nov 2023 19:13:09 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:4081:0:640:557:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTP id E23466098C;
	Sat, 11 Nov 2023 19:13:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0DjfoHMBWCg0-tnvcDXRX;
	Sat, 11 Nov 2023 19:13:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1699719182; bh=3zrnevZ43Omw8xtRK0CizppvjJxhRy8Kel1LD3KxJLU=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=KdJJ8cshW+jjPbCElNor7yr3A2A+pgkUM+TneZEvhtR0w/piIqyAfwfL3aSDNrxRd
	 OiBFIsJ/25TcIpfmDplIKik7bgEjsax4XSEsOLcrCx9FkPb8ABQ8hLMtoGHuOIQMM1
	 k6H1faOvG1WH/lreG80BpBpuRoqAEdSZumO3FjDE=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: fstests@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Murphy Zhou <xzhou@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] generic/733: add F_OFD_GETLK/F_UNLCK testing
Date: Sat, 11 Nov 2023 21:12:50 +0500
Message-Id: <20231111161250.1099595-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

F_UNLCK can be used with F_OFD_GETLK to get the locks from
particular fd. This patch adds a new test, generic/733,
to check that functionality.

The following options are added to t_ofd_locks:
-u selects F_UNLCK for testing
-G sets the unix socket name for fd receive
-S sets the unix socket name for fd send

Test works as follows:
- locker process sets the lock and sends an fd via unix socket
- lock-tester process receives an fd and uses F_UNLCK to check the lock

Changes in v3:
- use generic/733, as 732 is already taken.

CC: fstests@vger.kernel.org
CC: Murphy Zhou <xzhou@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Zorro Lang <zlang@redhat.com>

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
---
 common/ofdlk          |  61 +++++++++++++++
 common/rc             |   7 ++
 src/t_ofd_locks.c     | 169 +++++++++++++++++++++++++++++++++++++++---
 tests/generic/478     |  59 +--------------
 tests/generic/733     |  60 +++++++++++++++
 tests/generic/733.out |  16 ++++
 6 files changed, 303 insertions(+), 69 deletions(-)
 create mode 100644 common/ofdlk
 create mode 100755 tests/generic/733
 create mode 100644 tests/generic/733.out

diff --git a/common/ofdlk b/common/ofdlk
new file mode 100644
index 00000000..4a4dbcb3
--- /dev/null
+++ b/common/ofdlk
@@ -0,0 +1,61 @@
+#
+# Common functions for OFD lock tests
+#
+
+mk_ofdlk_sem()
+{
+	SEMID=$(ipcmk -S 2 | cut -d ":" -f 2 | tr -d '[:space:]')
+	if [ -z "$SEMID" ]; then
+		echo "ipcmk failed"
+		exit 1
+	fi
+	SEMKEY=$(ipcs -s | grep $SEMID | cut -d " " -f 1)
+	if [ -z "$SEMKEY" ]; then
+		echo "ipcs failed"
+		exit 1
+	fi
+}
+
+rm_ofdlk_sem()
+{
+	ipcrm -s $SEMID 2>/dev/null
+}
+
+do_test()
+{
+	local soptions
+	local goptions
+	# print options and getlk output for debug
+	echo $* >> $seqres.full 2>&1
+	mk_ofdlk_sem
+	soptions="$1 -K $SEMKEY"
+	goptions="$2 -K $SEMKEY"
+	# -s : do setlk
+	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
+	# -g : do getlk
+	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
+		tee -a $seqres.full
+	wait $!
+	rm_ofdlk_sem
+
+	mk_ofdlk_sem
+	# add -F to clone with CLONE_FILES
+	soptions="$1 -F -K $SEMKEY"
+	goptions="$2 -K $SEMKEY"
+	# with -F, new locks are always file to place
+	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
+	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
+		tee -a $seqres.full
+	wait $!
+	rm_ofdlk_sem
+
+	mk_ofdlk_sem
+	# add -d to dup and close
+	soptions="$1 -d -K $SEMKEY"
+	goptions="$2 -K $SEMKEY"
+	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
+	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
+		tee -a $seqres.full
+	wait $!
+	rm_ofdlk_sem
+}
diff --git a/common/rc b/common/rc
index 259a1ffb..7a557620 100644
--- a/common/rc
+++ b/common/rc
@@ -4242,6 +4242,13 @@ _require_ofd_locks()
 	[ $? -eq 22 ] && _notrun "Require OFD locks support"
 }
 
+_require_ofd_getlk_unlck()
+{
+	_require_ofd_locks
+	$here/src/t_ofd_locks -t -gu $TEST_DIR/ofd_testfile > /dev/null 2>&1
+	[ $? -eq 22 ] && _notrun "Require OFD locks F_OFD_GETLK/F_UNLCK extension"
+}
+
 _require_test_lsattr()
 {
 	local testio=$(lsattr -d $TEST_DIR 2>&1)
diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
index 58cb0959..8d63b80b 100644
--- a/src/t_ofd_locks.c
+++ b/src/t_ofd_locks.c
@@ -14,6 +14,8 @@
 #include <sys/wait.h>
 #include <sys/ipc.h>
 #include <sys/sem.h>
+#include <sys/socket.h>
+#include <sys/un.h>
 
 /*
  * In distributions that do not have these macros ready in glibc-headers,
@@ -134,10 +136,13 @@ static void usage(char *arg0)
 	printf("\t-F : clone with CLONE_FILES in setlk to setup test condition\n");
 	printf("\t-d : dup and close in setlk\n");
 	printf("\twithout both -F/d, use clone without CLONE_FILES\n");
-	printf("\t-r/-w : set/get rdlck/wrlck\n");
+	printf("\t-r/-w/-u : set/get rdlck/wrlck/unlck\n");
 	printf("\t-o num : offset start to lock, default 0\n");
 	printf("\t-l num : lock length, default 10\n");
 	printf("\t-R/-W : open file RDONLY/RDWR\n\n");
+	printf("\t-G path : unix socket path for fd reception\n\n");
+	printf("\t-S path : unix socket path for fd sending\n\n");
+	printf("\t-t : test run, try to perform lock and report\n\n");
 	printf("\tUsually we run a setlk routine in background and then\n");
 	printf("\trun a getlk routine to check. They must be paired, or\n");
 	printf("\ttest will hang.\n\n");
@@ -164,6 +169,117 @@ static int child_fn(void* p)
 	return 0;
 }
 
+static int connect_unix(const char *sname)
+{
+	struct sockaddr_un addr = { .sun_family = AF_UNIX };
+
+	int unix_sock = socket(AF_UNIX, SOCK_DGRAM, 0);
+	if (unix_sock == -1)
+		return -1;
+
+	strncpy(addr.sun_path, sname, sizeof(addr.sun_path) - 1);
+	if (connect(unix_sock, (struct sockaddr *)&addr, sizeof(addr)) == -1)
+	{
+		close(unix_sock);
+		perror("connect()");
+		return -1;
+	}
+
+	return unix_sock;
+}
+
+static int send_fd(const char *sname, int fd)
+{
+	int ret;
+	int unix_sock;
+	struct iovec iov = {.iov_base = ":)", // Must send at least one byte
+			    .iov_len = 2};
+
+	union {
+		char buf[CMSG_SPACE(sizeof(fd))];
+		struct cmsghdr align;
+	} u;
+
+	struct msghdr msg = {.msg_iov = &iov,
+			     .msg_iovlen = 1,
+			     .msg_control = u.buf,
+			     .msg_controllen = sizeof(u.buf)};
+
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+	*cmsg = (struct cmsghdr){.cmsg_level = SOL_SOCKET,
+				 .cmsg_type = SCM_RIGHTS,
+				 .cmsg_len = CMSG_LEN(sizeof(fd))};
+
+	memcpy(CMSG_DATA(cmsg), &fd, sizeof(fd));
+
+	unix_sock = connect_unix(sname);
+	if (unix_sock == -1) {
+		perror("sendmsg()");
+		return -1;
+	}
+	ret = sendmsg(unix_sock, &msg, 0);
+	close(unix_sock);
+	if (ret == -1)
+		perror("sendmsg()");
+	return ret;
+}
+
+static int bind_unix(const char *sname)
+{
+	struct sockaddr_storage storage = {};
+	struct sockaddr_un *addr;
+	int sock;
+
+	sock = socket(AF_UNIX, SOCK_DGRAM, 0);
+	if (sock == -1)
+		return -1;
+	addr = (struct sockaddr_un *)&storage;
+	addr->sun_family = AF_UNIX;
+	strncpy(addr->sun_path, sname, sizeof(addr->sun_path) - 1);
+	unlink(sname);
+	if (bind(sock, (struct sockaddr *)addr, SUN_LEN(addr)) == -1) {
+		perror("bind()");
+		close(sock);
+		return -1;
+	}
+	return sock;
+}
+
+static int recv_fd(int sock)
+{
+	struct msghdr msg;
+	struct cmsghdr *cmsghdr;
+	struct iovec iov;
+	ssize_t nbytes;
+	int *p;
+	char buf[CMSG_SPACE(sizeof(int))], c[16];
+	struct cmsghdr *cmsgp;
+
+	iov.iov_base = &c;
+	iov.iov_len = sizeof(c);
+	cmsghdr = (struct cmsghdr *)buf;
+	cmsghdr->cmsg_len = CMSG_LEN(sizeof(int));
+	cmsghdr->cmsg_level = SOL_SOCKET;
+	cmsghdr->cmsg_type = SCM_RIGHTS;
+	msg.msg_name = NULL;
+	msg.msg_namelen = 0;
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsghdr;
+	msg.msg_controllen = CMSG_LEN(sizeof(int));
+	msg.msg_flags = 0;
+
+	nbytes = recvmsg(sock, &msg, 0);
+	if (nbytes == -1)
+		return -1;
+
+	cmsgp = CMSG_FIRSTHDR(&msg);
+	p = (int *)CMSG_DATA(cmsgp);
+	if (!p)
+		return -1;
+	return *p;
+}
+
 int main(int argc, char **argv)
 {
 	int posix = 0;
@@ -184,10 +300,12 @@ int main(int argc, char **argv)
 	struct semid_ds sem_ds;
 	struct sembuf sop;
 	int opt, ret;
+	int rcv_sock = -1;
+	const char *snd_sock_name = NULL;
 
 	//avoid libcap errno bug
 	errno = 0;
-	while((opt = getopt(argc, argv, "sgrwo:l:PRWtFdK:")) != -1) {
+	while((opt = getopt(argc, argv, "sgrwuo:l:PRWtFdK:G:S:")) != -1) {
 		switch(opt) {
 		case 's':
 			lock_cmd = 1;
@@ -201,6 +319,9 @@ int main(int argc, char **argv)
 		case 'w':
 			lock_rw = 1;
 			break;
+		case 'u':
+			lock_rw = 2;
+			break;
 		case 'o':
 			lock_start = atoi(optarg);
 			break;
@@ -228,6 +349,12 @@ int main(int argc, char **argv)
 		case 'K':
 			semkey = strtol(optarg, NULL, 16);
 			break;
+		case 'G':
+			rcv_sock = bind_unix(optarg);
+			break;
+		case 'S':
+			snd_sock_name = optarg;
+			break;
 		default:
 			usage(argv[0]);
 			return -1;
@@ -256,17 +383,27 @@ int main(int argc, char **argv)
 		getlk_macro = F_GETLK;
 	}
 
-	if (lock_rw == 1)
-		flk.l_type = F_WRLCK;
-	else
+	switch (lock_rw) {
+	case 0:
 		flk.l_type = F_RDLCK;
+		break;
+	case 1:
+		flk.l_type = F_WRLCK;
+		break;
+	case 2:
+		flk.l_type = F_UNLCK;
+		break;
+	}
 
-	if (open_rw == 0)
-		fd = open(argv[optind], O_RDONLY);
-	else
-		fd = open(argv[optind], O_RDWR);
-	if (fd == -1)
-		err_exit("open", errno);
+	if (rcv_sock == -1) {
+		if (open_rw == 0) {
+			fd = open(argv[optind], O_RDONLY);
+		} else {
+			fd = open(argv[optind], O_RDWR);
+		}
+		if (fd == -1)
+			err_exit("open", errno);
+	}
 
 	/*
 	 * In a testun, we do a fcntl getlk call and exit
@@ -322,6 +459,9 @@ int main(int argc, char **argv)
 		if (fcntl(fd, setlk_macro, &flk) < 0)
 			err_exit("setlkw", errno);
 
+		if (snd_sock_name)
+			send_fd(snd_sock_name, fd);
+
 		if (use_dup == 1) {
 			/* dup fd and close the newfd */
 			int dfd = dup(fd);
@@ -400,6 +540,13 @@ int main(int argc, char **argv)
 		if (semtimedop(semid, &sop, 1, &ts) == -1)
 			err_exit("wait sem0 0", errno);
 
+		if (rcv_sock != -1) {
+			fd = recv_fd(rcv_sock);
+			close(rcv_sock);
+			if (fd == -1)
+				err_exit("SCM_RIGHTS", errno);
+		}
+
 		if (fcntl(fd, getlk_macro, &flk) < 0)
 			err_exit("getlk", errno);
 
diff --git a/tests/generic/478 b/tests/generic/478
index 419acc94..580c260e 100755
--- a/tests/generic/478
+++ b/tests/generic/478
@@ -88,6 +88,7 @@ _begin_fstest auto quick
 
 # Import common functions.
 . ./common/filter
+. ./common/ofdlk
 
 # Modify as appropriate.
 _supported_fs generic
@@ -99,64 +100,6 @@ _require_ofd_locks
 $XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
 	$TEST_DIR/testfile >> $seqres.full 2>&1
 
-mk_sem()
-{
-	SEMID=$(ipcmk -S 2 | cut -d ":" -f 2 | tr -d '[:space:]')
-	if [ -z "$SEMID" ]; then
-		echo "ipcmk failed"
-		exit 1
-	fi
-	SEMKEY=$(ipcs -s | grep $SEMID | cut -d " " -f 1)
-	if [ -z "$SEMKEY" ]; then
-		echo "ipcs failed"
-		exit 1
-	fi
-}
-
-rm_sem()
-{
-	ipcrm -s $SEMID 2>/dev/null
-}
-
-do_test()
-{
-	local soptions
-	local goptions
-	# print options and getlk output for debug
-	echo $* >> $seqres.full 2>&1
-	mk_sem
-	soptions="$1 -K $SEMKEY"
-	goptions="$2 -K $SEMKEY"
-	# -s : do setlk
-	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
-	# -g : do getlk
-	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
-		tee -a $seqres.full
-	wait $!
-	rm_sem
-
-	mk_sem
-	# add -F to clone with CLONE_FILES
-	soptions="$1 -F -K $SEMKEY"
-	goptions="$2 -K $SEMKEY"
-	# with -F, new locks are always file to place
-	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
-	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
-		tee -a $seqres.full
-	wait $!
-	rm_sem
-
-	mk_sem
-	# add -d to dup and close
-	soptions="$1 -d -K $SEMKEY"
-	goptions="$2 -K $SEMKEY"
-	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
-	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
-		tee -a $seqres.full
-	wait $!
-	rm_sem
-}
-
 # Always setlk at range [0,9], getlk at range [0,9] [5,24] or [20,29].
 # To open file RDONLY or RDWR should not break the locks.
 # POSIX locks should be released after closed fd, so it wont conflict
diff --git a/tests/generic/733 b/tests/generic/733
new file mode 100755
index 00000000..0e22f522
--- /dev/null
+++ b/tests/generic/733
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 stsp2@yandex.ru
+#
+# FS QA Test 733
+#
+# Test OFD lock's F_UNLCK extension.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Import common functions.
+. ./common/filter
+. ./common/ofdlk
+
+# Modify as appropriate.
+_supported_fs generic
+_require_test
+_require_ofd_getlk_unlck
+
+# real QA test starts here
+# prepare a 4k testfile in TEST_DIR
+$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
+	$TEST_DIR/testfile >> $seqres.full 2>&1
+
+# Always setlk at range [0,9], getlk at range [0,9] [5,24] or [20,29].
+# To open file RDONLY or RDWR should not break the locks.
+# POSIX locks should be released after closed fd, so it wont conflict
+# with other locks in tests
+
+# -P : operate posix lock
+# -w : operate on F_WRLCK
+# -r : operate on F_RDLCK
+# -R : open file RDONLY
+# -W : open file RDWR
+# -o : file offset where the lock starts
+# -l : lock length
+# -F : clone with CLONE_FILES in setlk
+# -d : dup and close in setlk
+
+# setlk wrlck [0,9], getlk wrlck [0,9], expect
+#    + wrlck when CLONE_FILES not set
+#    + unlck when CLONE_FILES set
+#    + wrlck when dup & close
+
+# setlk wrlck [0,9], getlk unlck [0,9]
+do_test "-s -w -o 0 -l 10 -W -S /tmp/fstests.sock" "-g -u -o 0 -l 10 -W -G /tmp/fstests.sock" "wrlck" "wrlck" "wrlck"
+# setlk wrlck [0,9], getlk unlck [20,29]
+do_test "-s -w -o 0 -l 10 -S /tmp/fstests.sock" "-g -u -o 20 -l 10 -G /tmp/fstests.sock" "unlck" "unlck" "unlck"
+
+# setlk rdlck [0,9], getlk unlck [0,9], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 0 -l 10 -R -G /tmp/fstests.sock" "rdlck" "rdlck" "rdlck"
+# setlk posix rdlck [0,9], getlk unlck [5,24], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 5 -l 20 -R -G /tmp/fstests.sock" "rdlck" "rdlck" "rdlck"
+# setlk rdlck [0,9], getlk unlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 20 -l 10 -R -G /tmp/fstests.sock" "unlck" "unlck" "unlck"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/733.out b/tests/generic/733.out
new file mode 100644
index 00000000..2b175f90
--- /dev/null
+++ b/tests/generic/733.out
@@ -0,0 +1,16 @@
+QA output created by 733
+get wrlck
+get wrlck
+get wrlck
+lock could be placed
+lock could be placed
+lock could be placed
+get rdlck
+get rdlck
+get rdlck
+get rdlck
+get rdlck
+get rdlck
+lock could be placed
+lock could be placed
+lock could be placed
-- 
2.40.1

