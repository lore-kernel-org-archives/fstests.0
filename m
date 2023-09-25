Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF94CE7A81
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Sep 2023 11:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjIYLA5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjIYLAz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Sep 2023 07:00:55 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D8AB
        for <fstests@vger.kernel.org>; Mon, 25 Sep 2023 04:00:43 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:9e93:0:640:2a79:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id A3E97600A1;
        Mon, 25 Sep 2023 14:00:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id c0MpEr1WtmI0-CMC5KlSj;
        Mon, 25 Sep 2023 14:00:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695639640; bh=TmnEOuD3YCra2vD7adfHFrZA11saVdNXsVPIkJMLwQM=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=v8PXWesIJK2A6TmCVSK5btw5kEz94w73eRARfzbWNnARbu2p/9g0vkToz5rQAbZ/Y
         /11cSom4s+cI5cuVb9muvoHKyYlaWJT7ufFI6p45Ni9P4TbSBPRJMgrDOfuOBqQ6yq
         xvjAlhE/0I8H/o0ibFnlaph4GRpqlgdSPs91G5s8=
Authentication-Results: mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     fstests@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Murphy Zhou <xzhou@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH][RESEND] generic/478: add F_UNLCK testing
Date:   Mon, 25 Sep 2023 16:00:27 +0500
Message-Id: <20230925110027.2141499-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

F_UNLCK can be used with F_OFD_GETLK to get the locks from
particular fd. This patch adds testing for that functionality.

The following options are added to t_ofd_locks:
-u selects F_UNLCK for testing
-G sets the unix socket name for fd receive
-S sets the unix socket name for fd send
-U sets the message to be printed if the requested functionality
   unsupported.

Test works as follows:
- locker process sets the lock and sends an fd via unix socket
- lock-tester process receives an fd and uses F_UNLCK to check the lock
- the test is provided with a "success" message that it should print
  only if the tested functionality is not supported. In that case
  printing a "success" message avoids the test failure on older kernels.

To allow passing the "success" messages with spaces, eval has to be
used in a shell script when starting the test case.

CC: fstests@vger.kernel.org
CC: Murphy Zhou <xzhou@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Zorro Lang <zlang@redhat.com>

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
---
 src/t_ofd_locks.c     | 183 +++++++++++++++++++++++++++++++++++++++---
 tests/generic/478     |  24 ++++--
 tests/generic/478.out |  15 ++++
 3 files changed, 204 insertions(+), 18 deletions(-)

diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
index 58cb0959..a78fd575 100644
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
@@ -134,7 +136,7 @@ static void usage(char *arg0)
 	printf("\t-F : clone with CLONE_FILES in setlk to setup test condition\n");
 	printf("\t-d : dup and close in setlk\n");
 	printf("\twithout both -F/d, use clone without CLONE_FILES\n");
-	printf("\t-r/-w : set/get rdlck/wrlck\n");
+	printf("\t-r/-w/-u : set/get rdlck/wrlck/unlck\n");
 	printf("\t-o num : offset start to lock, default 0\n");
 	printf("\t-l num : lock length, default 10\n");
 	printf("\t-R/-W : open file RDONLY/RDWR\n\n");
@@ -164,6 +166,117 @@ static int child_fn(void* p)
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
@@ -184,10 +297,14 @@ int main(int argc, char **argv)
 	struct semid_ds sem_ds;
 	struct sembuf sop;
 	int opt, ret;
+	int rcv_sock = -1;
+	const char *snd_sock_name = NULL;
+	const char *unsup_msg = NULL;
+	int unlck_unsup = 0;
 
 	//avoid libcap errno bug
 	errno = 0;
-	while((opt = getopt(argc, argv, "sgrwo:l:PRWtFdK:")) != -1) {
+	while((opt = getopt(argc, argv, "sgrwuo:l:PRWtFdK:G:S:U:")) != -1) {
 		switch(opt) {
 		case 's':
 			lock_cmd = 1;
@@ -201,6 +318,9 @@ int main(int argc, char **argv)
 		case 'w':
 			lock_rw = 1;
 			break;
+		case 'u':
+			lock_rw = 2;
+			break;
 		case 'o':
 			lock_start = atoi(optarg);
 			break;
@@ -228,6 +348,15 @@ int main(int argc, char **argv)
 		case 'K':
 			semkey = strtol(optarg, NULL, 16);
 			break;
+		case 'G':
+			rcv_sock = bind_unix(optarg);
+			break;
+		case 'S':
+			snd_sock_name = optarg;
+			break;
+		case 'U':
+			unsup_msg = optarg;
+			break;
 		default:
 			usage(argv[0]);
 			return -1;
@@ -256,17 +385,27 @@ int main(int argc, char **argv)
 		getlk_macro = F_GETLK;
 	}
 
-	if (lock_rw == 1)
+	switch (lock_rw) {
+	case 1:
 		flk.l_type = F_WRLCK;
-	else
+		break;
+	case 0:
 		flk.l_type = F_RDLCK;
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
@@ -322,6 +461,9 @@ int main(int argc, char **argv)
 		if (fcntl(fd, setlk_macro, &flk) < 0)
 			err_exit("setlkw", errno);
 
+		if (snd_sock_name)
+			send_fd(snd_sock_name, fd);
+
 		if (use_dup == 1) {
 			/* dup fd and close the newfd */
 			int dfd = dup(fd);
@@ -400,13 +542,30 @@ int main(int argc, char **argv)
 		if (semtimedop(semid, &sop, 1, &ts) == -1)
 			err_exit("wait sem0 0", errno);
 
-		if (fcntl(fd, getlk_macro, &flk) < 0)
-			err_exit("getlk", errno);
+		if (rcv_sock != -1) {
+			fd = recv_fd(rcv_sock);
+			close(rcv_sock);
+			if (fd == -1)
+				err_exit("SCM_RIGHTS", errno);
+		}
+
+		if (fcntl(fd, getlk_macro, &flk) < 0) {
+			if (lock_rw == 2 && errno == EINVAL)
+				unlck_unsup++;
+			else
+				err_exit("getlk", errno);
+		}
 
 		/* set sem1 = 0 (getlk done) */
 		semu.val = 0;
 		if (semctl(semid, 1, SETVAL, semu) == -1)
 			err_exit("set sem1 0", errno);
+		if (unlck_unsup) {
+			if (unsup_msg)
+				puts(unsup_msg);
+			close(fd);
+			return 0;
+		}
 
 		/* check result */
 		switch (flk.l_type) {
diff --git a/tests/generic/478 b/tests/generic/478
index 419acc94..1399aa6f 100755
--- a/tests/generic/478
+++ b/tests/generic/478
@@ -128,9 +128,9 @@ do_test()
 	soptions="$1 -K $SEMKEY"
 	goptions="$2 -K $SEMKEY"
 	# -s : do setlk
-	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
+	eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
 	# -g : do getlk
-	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
+	eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
 		tee -a $seqres.full
 	wait $!
 	rm_sem
@@ -140,8 +140,8 @@ do_test()
 	soptions="$1 -F -K $SEMKEY"
 	goptions="$2 -K $SEMKEY"
 	# with -F, new locks are always file to place
-	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
-	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
+	eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
+	eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
 		tee -a $seqres.full
 	wait $!
 	rm_sem
@@ -150,8 +150,8 @@ do_test()
 	# add -d to dup and close
 	soptions="$1 -d -K $SEMKEY"
 	goptions="$2 -K $SEMKEY"
-	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
-	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
+	eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
+	eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
 		tee -a $seqres.full
 	wait $!
 	rm_sem
@@ -197,6 +197,11 @@ do_test "-s -w -o 0 -l 10 -P" "-g -r -o 5 -l 20" "wrlck" "unlck" "unlck"
 # setlk posix wrlck [0,9], getlk rdlck [20,29]
 do_test "-s -w -o 0 -l 10 -P" "-g -r -o 20 -l 10" "unlck" "unlck" "unlck"
 
+# setlk wrlck [0,9], getlk unlck [0,9]
+do_test "-s -w -o 0 -l 10 -W -S /tmp/fstests.sock" "-g -u -o 0 -l 10 -W -G /tmp/fstests.sock -U get\ wrlck" "wrlck" "wrlck" "wrlck"
+# setlk wrlck [0,9], getlk unlck [20,29]
+do_test "-s -w -o 0 -l 10 -S /tmp/fstests.sock" "-g -u -o 20 -l 10 -G /tmp/fstests.sock -U lock\ could\ be\ placed" "unlck" "unlck" "unlck"
+
 # setlk rdlck [0,9], getlk wrlck [0,9], open RDONLY
 do_test "-s -r -o 0 -l 10 -R" "-g -w -o 0 -l 10 -R" "rdlck" "unlck" "rdlck"
 # setlk rdlck [0,9], getlk wrlck [5,24], open RDONLY
@@ -204,6 +209,13 @@ do_test "-s -r -o 0 -l 10 -R" "-g -w -o 5 -l 20 -R -P" "rdlck" "unlck" "rdlck"
 # setlk posix rdlck [0,9], getlk wrlck [5,24], open RDONLY
 do_test "-s -r -o 0 -l 10 -R -P" "-g -w -o 5 -l 20 -R" "rdlck" "unlck" "unlck"
 
+# setlk rdlck [0,9], getlk unlck [0,9], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 0 -l 10 -R -G /tmp/fstests.sock -U get\ rdlck" "rdlck" "rdlck" "rdlck"
+# setlk posix rdlck [0,9], getlk unlck [5,24], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 5 -l 20 -R -G /tmp/fstests.sock -U get\ rdlck" "rdlck" "rdlck" "rdlck"
+# setlk rdlck [0,9], getlk unlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 20 -l 10 -R -G /tmp/fstests.sock -U lock\ could\ be\ placed" "unlck" "unlck" "unlck"
+
 # setlk rdlck [0,9], getlk wrlck [0,9]
 do_test "-s -r -o 0 -l 10" "-g -w -o 0 -l 10" "rdlck" "unlck" "rdlck"
 # setlk rdlck [0,9], getlk posix wrlck [5,24]
diff --git a/tests/generic/478.out b/tests/generic/478.out
index 0b4b344a..f3ca2473 100644
--- a/tests/generic/478.out
+++ b/tests/generic/478.out
@@ -29,6 +29,12 @@ lock could be placed
 lock could be placed
 lock could be placed
 lock could be placed
+get wrlck
+get wrlck
+get wrlck
+lock could be placed
+lock could be placed
+lock could be placed
 get rdlck
 lock could be placed
 get rdlck
@@ -39,6 +45,15 @@ get rdlck
 lock could be placed
 lock could be placed
 get rdlck
+get rdlck
+get rdlck
+get rdlck
+get rdlck
+get rdlck
+lock could be placed
+lock could be placed
+lock could be placed
+get rdlck
 lock could be placed
 get rdlck
 get rdlck
-- 
2.40.1

