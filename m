Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1ABE7C4E7
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Oct 2023 17:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjJDRnq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 4 Oct 2023 13:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjJDRnp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Oct 2023 13:43:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2D1BD
        for <fstests@vger.kernel.org>; Wed,  4 Oct 2023 10:43:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFC5C433C9;
        Wed,  4 Oct 2023 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696441420;
        bh=a9JgtH9ZVFNSRh4pxN0MaufmGgrRJ8BvZ1IxMoiR65g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hHwiHL7VE+/57gLBGJp4FMdkjT2j2FzC5Ng4441bsF6NAn1uLvWrCjQWa2icasXdb
         H9H76BR5/52JvREN5y6VSdblRNuAVXNDt9HCdV8jNEnG1NbSG3Cs8ir/1d6FW85AyR
         QOxN2PnSI9SEd9KafYYhO5N91cSpmRuH9q1Wqqq8aPqUFmx6KbsdgzJlb8wf2F108z
         5YsfjALCUs4Ker5I8VvmdGlTbf8FcSb//NaSOAaovnlhldq2iTcy3JeY7uqXF47Gb3
         04hWawluzgLguh0TBGOueUSZDa7uP1N8n4kepIbW52YyVhNcWqPp14Vac5vTzROToO
         0jVNwz4Gko/1Q==
Message-ID: <1185704fb150f69fd6a1fea006cc80e50927584b.camel@kernel.org>
Subject: Re: [PATCH] generic/732: add F_OFD_GETLK/F_UNLCK testing
From:   Jeff Layton <jlayton@kernel.org>
To:     Stas Sergeev <stsp2@yandex.ru>, fstests@vger.kernel.org
Cc:     Murphy Zhou <xzhou@redhat.com>, Zorro Lang <zlang@redhat.com>
Date:   Wed, 04 Oct 2023 13:43:39 -0400
In-Reply-To: <20231004173042.222644-1-stsp2@yandex.ru>
References: <20231004173042.222644-1-stsp2@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, 2023-10-04 at 22:30 +0500, Stas Sergeev wrote:
> F_UNLCK can be used with F_OFD_GETLK to get the locks from
> particular fd. This patch adds a new test, generic/732,
> to check that functionality.
>=20
> The following options are added to t_ofd_locks:
> -u selects F_UNLCK for testing
> -G sets the unix socket name for fd receive
> -S sets the unix socket name for fd send
>=20
> Test works as follows:
> - locker process sets the lock and sends an fd via unix socket
> - lock-tester process receives an fd and uses F_UNLCK to check the lock
>=20
> CC: fstests@vger.kernel.org
> CC: Murphy Zhou <xzhou@redhat.com>
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Zorro Lang <zlang@redhat.com>
>=20
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> ---
>  common/ofdlk          |  61 +++++++++++++++
>  common/rc             |   4 +-
>  src/t_ofd_locks.c     | 169 +++++++++++++++++++++++++++++++++++++++---
>  tests/generic/478     |  59 +--------------
>  tests/generic/732     |  60 +++++++++++++++
>  tests/generic/732.out |  16 ++++
>  6 files changed, 298 insertions(+), 71 deletions(-)
>  create mode 100644 common/ofdlk
>  create mode 100755 tests/generic/732
>  create mode 100644 tests/generic/732.out
>=20
> diff --git a/common/ofdlk b/common/ofdlk
> new file mode 100644
> index 00000000..0cdd2250
> --- /dev/null
> +++ b/common/ofdlk
> @@ -0,0 +1,61 @@
> +#
> +# Common functions for OFD lock tests
> +#
> +
> +mk_sem()

These are too generically named for functions that sit in common. Can
you rename these to something more distinct?

> +{
> +	SEMID=3D$(ipcmk -S 2 | cut -d ":" -f 2 | tr -d '[:space:]')
> +	if [ -z "$SEMID" ]; then
> +		echo "ipcmk failed"
> +		exit 1
> +	fi
> +	SEMKEY=3D$(ipcs -s | grep $SEMID | cut -d " " -f 1)
> +	if [ -z "$SEMKEY" ]; then
> +		echo "ipcs failed"
> +		exit 1
> +	fi
> +}
> +
> +rm_sem()
> +{
> +	ipcrm -s $SEMID 2>/dev/null
> +}
> +
> +do_test()
> +{
> +	local soptions
> +	local goptions
> +	# print options and getlk output for debug
> +	echo $* >> $seqres.full 2>&1
> +	mk_sem
> +	soptions=3D"$1 -K $SEMKEY"
> +	goptions=3D"$2 -K $SEMKEY"
> +	# -s : do setlk
> +	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> +	# -g : do getlk
> +	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> +		tee -a $seqres.full
> +	wait $!
> +	rm_sem
> +
> +	mk_sem
> +	# add -F to clone with CLONE_FILES
> +	soptions=3D"$1 -F -K $SEMKEY"
> +	goptions=3D"$2 -K $SEMKEY"
> +	# with -F, new locks are always file to place
> +	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> +	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> +		tee -a $seqres.full
> +	wait $!
> +	rm_sem
> +
> +	mk_sem
> +	# add -d to dup and close
> +	soptions=3D"$1 -d -K $SEMKEY"
> +	goptions=3D"$2 -K $SEMKEY"
> +	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> +	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> +		tee -a $seqres.full
> +	wait $!
> +	rm_sem
> +}
> diff --git a/common/rc b/common/rc
> index 1618ded5..1111fc12 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4222,8 +4222,8 @@ _require_ofd_locks()
>  	# EINVAL will be returned.
>  	_require_test_program "t_ofd_locks"
>  	touch $TEST_DIR/ofd_testfile
> -	$here/src/t_ofd_locks -t $TEST_DIR/ofd_testfile > /dev/null 2>&1
> -	[ $? -eq 22 ] && _notrun "Require OFD locks support"
> +	$here/src/t_ofd_locks -t $1 $TEST_DIR/ofd_testfile > /dev/null 2>&1
> +	[ $? -eq 22 ] && _notrun "Require OFD locks support $2"
>  }
>=20
>=20

Instead of adding extra parameters to this function, it would be better
to just add a new _require_ofd_getlk_unlck() function that does what's
needed for this test. There may be other testcases that require that
functionality and its more self-documenting for later users.

> =20
>  _require_test_lsattr()
> diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> index 58cb0959..8d63b80b 100644
> --- a/src/t_ofd_locks.c
> +++ b/src/t_ofd_locks.c
> @@ -14,6 +14,8 @@
>  #include <sys/wait.h>
>  #include <sys/ipc.h>
>  #include <sys/sem.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> =20
>  /*
>   * In distributions that do not have these macros ready in glibc-headers=
,
> @@ -134,10 +136,13 @@ static void usage(char *arg0)
>  	printf("\t-F : clone with CLONE_FILES in setlk to setup test condition\=
n");
>  	printf("\t-d : dup and close in setlk\n");
>  	printf("\twithout both -F/d, use clone without CLONE_FILES\n");
> -	printf("\t-r/-w : set/get rdlck/wrlck\n");
> +	printf("\t-r/-w/-u : set/get rdlck/wrlck/unlck\n");
>  	printf("\t-o num : offset start to lock, default 0\n");
>  	printf("\t-l num : lock length, default 10\n");
>  	printf("\t-R/-W : open file RDONLY/RDWR\n\n");
> +	printf("\t-G path : unix socket path for fd reception\n\n");
> +	printf("\t-S path : unix socket path for fd sending\n\n");
> +	printf("\t-t : test run, try to perform lock and report\n\n");
>  	printf("\tUsually we run a setlk routine in background and then\n");
>  	printf("\trun a getlk routine to check. They must be paired, or\n");
>  	printf("\ttest will hang.\n\n");
> @@ -164,6 +169,117 @@ static int child_fn(void* p)
>  	return 0;
>  }
> =20
> +static int connect_unix(const char *sname)
> +{
> +	struct sockaddr_un addr =3D { .sun_family =3D AF_UNIX };
> +
> +	int unix_sock =3D socket(AF_UNIX, SOCK_DGRAM, 0);
> +	if (unix_sock =3D=3D -1)
> +		return -1;
> +
> +	strncpy(addr.sun_path, sname, sizeof(addr.sun_path) - 1);
> +	if (connect(unix_sock, (struct sockaddr *)&addr, sizeof(addr)) =3D=3D -=
1)
> +	{
> +		close(unix_sock);
> +		perror("connect()");
> +		return -1;
> +	}
> +
> +	return unix_sock;
> +}
> +
> +static int send_fd(const char *sname, int fd)
> +{
> +	int ret;
> +	int unix_sock;
> +	struct iovec iov =3D {.iov_base =3D ":)", // Must send at least one byt=
e
> +			    .iov_len =3D 2};
> +
> +	union {
> +		char buf[CMSG_SPACE(sizeof(fd))];
> +		struct cmsghdr align;
> +	} u;
> +
> +	struct msghdr msg =3D {.msg_iov =3D &iov,
> +			     .msg_iovlen =3D 1,
> +			     .msg_control =3D u.buf,
> +			     .msg_controllen =3D sizeof(u.buf)};
> +
> +	struct cmsghdr *cmsg =3D CMSG_FIRSTHDR(&msg);
> +	*cmsg =3D (struct cmsghdr){.cmsg_level =3D SOL_SOCKET,
> +				 .cmsg_type =3D SCM_RIGHTS,
> +				 .cmsg_len =3D CMSG_LEN(sizeof(fd))};
> +
> +	memcpy(CMSG_DATA(cmsg), &fd, sizeof(fd));
> +
> +	unix_sock =3D connect_unix(sname);
> +	if (unix_sock =3D=3D -1) {
> +		perror("sendmsg()");
> +		return -1;
> +	}
> +	ret =3D sendmsg(unix_sock, &msg, 0);
> +	close(unix_sock);
> +	if (ret =3D=3D -1)
> +		perror("sendmsg()");
> +	return ret;
> +}
> +
> +static int bind_unix(const char *sname)
> +{
> +	struct sockaddr_storage storage =3D {};
> +	struct sockaddr_un *addr;
> +	int sock;
> +
> +	sock =3D socket(AF_UNIX, SOCK_DGRAM, 0);
> +	if (sock =3D=3D -1)
> +		return -1;
> +	addr =3D (struct sockaddr_un *)&storage;
> +	addr->sun_family =3D AF_UNIX;
> +	strncpy(addr->sun_path, sname, sizeof(addr->sun_path) - 1);
> +	unlink(sname);
> +	if (bind(sock, (struct sockaddr *)addr, SUN_LEN(addr)) =3D=3D -1) {
> +		perror("bind()");
> +		close(sock);
> +		return -1;
> +	}
> +	return sock;
> +}
> +
> +static int recv_fd(int sock)
> +{
> +	struct msghdr msg;
> +	struct cmsghdr *cmsghdr;
> +	struct iovec iov;
> +	ssize_t nbytes;
> +	int *p;
> +	char buf[CMSG_SPACE(sizeof(int))], c[16];
> +	struct cmsghdr *cmsgp;
> +
> +	iov.iov_base =3D &c;
> +	iov.iov_len =3D sizeof(c);
> +	cmsghdr =3D (struct cmsghdr *)buf;
> +	cmsghdr->cmsg_len =3D CMSG_LEN(sizeof(int));
> +	cmsghdr->cmsg_level =3D SOL_SOCKET;
> +	cmsghdr->cmsg_type =3D SCM_RIGHTS;
> +	msg.msg_name =3D NULL;
> +	msg.msg_namelen =3D 0;
> +	msg.msg_iov =3D &iov;
> +	msg.msg_iovlen =3D 1;
> +	msg.msg_control =3D cmsghdr;
> +	msg.msg_controllen =3D CMSG_LEN(sizeof(int));
> +	msg.msg_flags =3D 0;
> +
> +	nbytes =3D recvmsg(sock, &msg, 0);
> +	if (nbytes =3D=3D -1)
> +		return -1;
> +
> +	cmsgp =3D CMSG_FIRSTHDR(&msg);
> +	p =3D (int *)CMSG_DATA(cmsgp);
> +	if (!p)
> +		return -1;
> +	return *p;
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int posix =3D 0;
> @@ -184,10 +300,12 @@ int main(int argc, char **argv)
>  	struct semid_ds sem_ds;
>  	struct sembuf sop;
>  	int opt, ret;
> +	int rcv_sock =3D -1;
> +	const char *snd_sock_name =3D NULL;
> =20
>  	//avoid libcap errno bug
>  	errno =3D 0;
> -	while((opt =3D getopt(argc, argv, "sgrwo:l:PRWtFdK:")) !=3D -1) {
> +	while((opt =3D getopt(argc, argv, "sgrwuo:l:PRWtFdK:G:S:")) !=3D -1) {
>  		switch(opt) {
>  		case 's':
>  			lock_cmd =3D 1;
> @@ -201,6 +319,9 @@ int main(int argc, char **argv)
>  		case 'w':
>  			lock_rw =3D 1;
>  			break;
> +		case 'u':
> +			lock_rw =3D 2;
> +			break;
>  		case 'o':
>  			lock_start =3D atoi(optarg);
>  			break;
> @@ -228,6 +349,12 @@ int main(int argc, char **argv)
>  		case 'K':
>  			semkey =3D strtol(optarg, NULL, 16);
>  			break;
> +		case 'G':
> +			rcv_sock =3D bind_unix(optarg);
> +			break;
> +		case 'S':
> +			snd_sock_name =3D optarg;
> +			break;
>  		default:
>  			usage(argv[0]);
>  			return -1;
> @@ -256,17 +383,27 @@ int main(int argc, char **argv)
>  		getlk_macro =3D F_GETLK;
>  	}
> =20
> -	if (lock_rw =3D=3D 1)
> -		flk.l_type =3D F_WRLCK;
> -	else
> +	switch (lock_rw) {
> +	case 0:
>  		flk.l_type =3D F_RDLCK;
> +		break;
> +	case 1:
> +		flk.l_type =3D F_WRLCK;
> +		break;
> +	case 2:
> +		flk.l_type =3D F_UNLCK;
> +		break;
> +	}
> =20
> -	if (open_rw =3D=3D 0)
> -		fd =3D open(argv[optind], O_RDONLY);
> -	else
> -		fd =3D open(argv[optind], O_RDWR);
> -	if (fd =3D=3D -1)
> -		err_exit("open", errno);
> +	if (rcv_sock =3D=3D -1) {
> +		if (open_rw =3D=3D 0) {
> +			fd =3D open(argv[optind], O_RDONLY);
> +		} else {
> +			fd =3D open(argv[optind], O_RDWR);
> +		}
> +		if (fd =3D=3D -1)
> +			err_exit("open", errno);
> +	}
> =20
>  	/*
>  	 * In a testun, we do a fcntl getlk call and exit
> @@ -322,6 +459,9 @@ int main(int argc, char **argv)
>  		if (fcntl(fd, setlk_macro, &flk) < 0)
>  			err_exit("setlkw", errno);
> =20
> +		if (snd_sock_name)
> +			send_fd(snd_sock_name, fd);
> +
>  		if (use_dup =3D=3D 1) {
>  			/* dup fd and close the newfd */
>  			int dfd =3D dup(fd);
> @@ -400,6 +540,13 @@ int main(int argc, char **argv)
>  		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
>  			err_exit("wait sem0 0", errno);
> =20
> +		if (rcv_sock !=3D -1) {
> +			fd =3D recv_fd(rcv_sock);
> +			close(rcv_sock);
> +			if (fd =3D=3D -1)
> +				err_exit("SCM_RIGHTS", errno);
> +		}
> +
>  		if (fcntl(fd, getlk_macro, &flk) < 0)
>  			err_exit("getlk", errno);
> =20
> diff --git a/tests/generic/478 b/tests/generic/478
> index 419acc94..580c260e 100755
> --- a/tests/generic/478
> +++ b/tests/generic/478
> @@ -88,6 +88,7 @@ _begin_fstest auto quick
> =20
>  # Import common functions.
>  . ./common/filter
> +. ./common/ofdlk
> =20
>  # Modify as appropriate.
>  _supported_fs generic
> @@ -99,64 +100,6 @@ _require_ofd_locks
>  $XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
>  	$TEST_DIR/testfile >> $seqres.full 2>&1
> =20
> -mk_sem()
> -{
> -	SEMID=3D$(ipcmk -S 2 | cut -d ":" -f 2 | tr -d '[:space:]')
> -	if [ -z "$SEMID" ]; then
> -		echo "ipcmk failed"
> -		exit 1
> -	fi
> -	SEMKEY=3D$(ipcs -s | grep $SEMID | cut -d " " -f 1)
> -	if [ -z "$SEMKEY" ]; then
> -		echo "ipcs failed"
> -		exit 1
> -	fi
> -}
> -
> -rm_sem()
> -{
> -	ipcrm -s $SEMID 2>/dev/null
> -}
> -
> -do_test()
> -{
> -	local soptions
> -	local goptions
> -	# print options and getlk output for debug
> -	echo $* >> $seqres.full 2>&1
> -	mk_sem
> -	soptions=3D"$1 -K $SEMKEY"
> -	goptions=3D"$2 -K $SEMKEY"
> -	# -s : do setlk
> -	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> -	# -g : do getlk
> -	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> -		tee -a $seqres.full
> -	wait $!
> -	rm_sem
> -
> -	mk_sem
> -	# add -F to clone with CLONE_FILES
> -	soptions=3D"$1 -F -K $SEMKEY"
> -	goptions=3D"$2 -K $SEMKEY"
> -	# with -F, new locks are always file to place
> -	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> -	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> -		tee -a $seqres.full
> -	wait $!
> -	rm_sem
> -
> -	mk_sem
> -	# add -d to dup and close
> -	soptions=3D"$1 -d -K $SEMKEY"
> -	goptions=3D"$2 -K $SEMKEY"
> -	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> -	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> -		tee -a $seqres.full
> -	wait $!
> -	rm_sem
> -}
> -
>  # Always setlk at range [0,9], getlk at range [0,9] [5,24] or [20,29].
>  # To open file RDONLY or RDWR should not break the locks.
>  # POSIX locks should be released after closed fd, so it wont conflict
> diff --git a/tests/generic/732 b/tests/generic/732
> new file mode 100755
> index 00000000..78f5bd44
> --- /dev/null
> +++ b/tests/generic/732
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 stsp2@yandex.ru
> +#
> +# FS QA Test 732
> +#
> +# Test OFD lock's F_UNLCK extension.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/ofdlk
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_test
> +_require_ofd_locks -gu "F_OFD_GETLK/F_UNLCK extension"
> +
> +# real QA test starts here
> +# prepare a 4k testfile in TEST_DIR
> +$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
> +	$TEST_DIR/testfile >> $seqres.full 2>&1
> +
> +# Always setlk at range [0,9], getlk at range [0,9] [5,24] or [20,29].
> +# To open file RDONLY or RDWR should not break the locks.
> +# POSIX locks should be released after closed fd, so it wont conflict
> +# with other locks in tests
> +
> +# -P : operate posix lock
> +# -w : operate on F_WRLCK
> +# -r : operate on F_RDLCK
> +# -R : open file RDONLY
> +# -W : open file RDWR
> +# -o : file offset where the lock starts
> +# -l : lock length
> +# -F : clone with CLONE_FILES in setlk
> +# -d : dup and close in setlk
> +
> +# setlk wrlck [0,9], getlk wrlck [0,9], expect
> +#    + wrlck when CLONE_FILES not set
> +#    + unlck when CLONE_FILES set
> +#    + wrlck when dup & close
> +
> +# setlk wrlck [0,9], getlk unlck [0,9]
> +do_test "-s -w -o 0 -l 10 -W -S /tmp/fstests.sock" "-g -u -o 0 -l 10 -W =
-G /tmp/fstests.sock" "wrlck" "wrlck" "wrlck"
> +# setlk wrlck [0,9], getlk unlck [20,29]
> +do_test "-s -w -o 0 -l 10 -S /tmp/fstests.sock" "-g -u -o 20 -l 10 -G /t=
mp/fstests.sock" "unlck" "unlck" "unlck"
> +
> +# setlk rdlck [0,9], getlk unlck [0,9], open RDONLY
> +do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 0 -l 10 -R =
-G /tmp/fstests.sock" "rdlck" "rdlck" "rdlck"
> +# setlk posix rdlck [0,9], getlk unlck [5,24], open RDONLY
> +do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 5 -l 20 -R =
-G /tmp/fstests.sock" "rdlck" "rdlck" "rdlck"
> +# setlk rdlck [0,9], getlk unlck [20,29], open RDONLY
> +do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 20 -l 10 -R=
 -G /tmp/fstests.sock" "unlck" "unlck" "unlck"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/generic/732.out b/tests/generic/732.out
> new file mode 100644
> index 00000000..98996904
> --- /dev/null
> +++ b/tests/generic/732.out
> @@ -0,0 +1,16 @@
> +QA output created by 732
> +get wrlck
> +get wrlck
> +get wrlck
> +lock could be placed
> +lock could be placed
> +lock could be placed
> +get rdlck
> +get rdlck
> +get rdlck
> +get rdlck
> +get rdlck
> +get rdlck
> +lock could be placed
> +lock could be placed
> +lock could be placed


I think the rest looks good though. Thanks for doing this.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
