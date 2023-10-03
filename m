Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D98E748FA
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Oct 2023 17:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjJCRjc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 3 Oct 2023 13:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJCRjb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Oct 2023 13:39:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F9895
        for <fstests@vger.kernel.org>; Tue,  3 Oct 2023 10:39:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48209C433C7;
        Tue,  3 Oct 2023 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696354767;
        bh=zgtlYinofr+9fWtQh146DdzYp++zfCqvJh5v6tgYTnA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QM/DG5mozgvSIE3ehruqVZTZD8EcD3M678DpO5mV2sYQXR1WY3JEjyNjGePk2uPSc
         YZSTixKvtVAuLwXBrSjpNHqxV4giD+lfVFO9RvwvtIsM6xqXgaGhXkgHEY/J8xfm/X
         PafwNtLaMZ8eA5ww4EcC0EIpQBS4t9KM9oD175jHR4NniKTU0J/S505Hwru+2wmYgb
         NSr3gsq8IMfDhIEy/c0zlZqW5U/kroPLzPhpqywGGzRe1Rafi3zjSBmKG+7re7Wd/a
         gocotaSVhXGx3cVoOB5I/noGoAJiid6fwh/PnvRNVLhmNu5Uhjou1jxzdBxI8ZvPpS
         arO7JtwWY8Hvw==
Message-ID: <3645c31d33685a444265ab65fddad3ba596224cb.camel@kernel.org>
Subject: Re: [PATCH][RESEND] generic/478: add F_UNLCK testing
From:   Jeff Layton <jlayton@kernel.org>
To:     Stas Sergeev <stsp2@yandex.ru>, fstests@vger.kernel.org
Cc:     Murphy Zhou <xzhou@redhat.com>, Zorro Lang <zlang@redhat.com>
Date:   Tue, 03 Oct 2023 13:39:25 -0400
In-Reply-To: <20230925110027.2141499-1-stsp2@yandex.ru>
References: <20230925110027.2141499-1-stsp2@yandex.ru>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, 2023-09-25 at 16:00 +0500, Stas Sergeev wrote:
> F_UNLCK can be used with F_OFD_GETLK to get the locks from
> particular fd. This patch adds testing for that functionality.
>=20
> The following options are added to t_ofd_locks:
> -u selects F_UNLCK for testing
> -G sets the unix socket name for fd receive
> -S sets the unix socket name for fd send
> -U sets the message to be printed if the requested functionality
>    unsupported.
>=20
> Test works as follows:
> - locker process sets the lock and sends an fd via unix socket
> - lock-tester process receives an fd and uses F_UNLCK to check the lock
> - the test is provided with a "success" message that it should print
>   only if the tested functionality is not supported. In that case
>   printing a "success" message avoids the test failure on older kernels.
>=20
> To allow passing the "success" messages with spaces, eval has to be
> used in a shell script when starting the test case.
>=20
> CC: fstests@vger.kernel.org
> CC: Murphy Zhou <xzhou@redhat.com>
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Zorro Lang <zlang@redhat.com>
>=20
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> ---
>  src/t_ofd_locks.c     | 183 +++++++++++++++++++++++++++++++++++++++---
>  tests/generic/478     |  24 ++++--
>  tests/generic/478.out |  15 ++++
>  3 files changed, 204 insertions(+), 18 deletions(-)
>=20

Sorry for the long review delay. It's been a busy cycle.

> diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> index 58cb0959..a78fd575 100644
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
> @@ -134,7 +136,7 @@ static void usage(char *arg0)
>  	printf("\t-F : clone with CLONE_FILES in setlk to setup test condition\=
n");
>  	printf("\t-d : dup and close in setlk\n");
>  	printf("\twithout both -F/d, use clone without CLONE_FILES\n");
> -	printf("\t-r/-w : set/get rdlck/wrlck\n");
> +	printf("\t-r/-w/-u : set/get rdlck/wrlck/unlck\n");

No explanation of -G/-S/-U ?

>  	printf("\t-o num : offset start to lock, default 0\n");
>  	printf("\t-l num : lock length, default 10\n");
>  	printf("\t-R/-W : open file RDONLY/RDWR\n\n");
> @@ -164,6 +166,117 @@ static int child_fn(void* p)
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
> @@ -184,10 +297,14 @@ int main(int argc, char **argv)
>  	struct semid_ds sem_ds;
>  	struct sembuf sop;
>  	int opt, ret;
> +	int rcv_sock =3D -1;
> +	const char *snd_sock_name =3D NULL;
> +	const char *unsup_msg =3D NULL;
> +	int unlck_unsup =3D 0;
> =20
>  	//avoid libcap errno bug
>  	errno =3D 0;
> -	while((opt =3D getopt(argc, argv, "sgrwo:l:PRWtFdK:")) !=3D -1) {
> +	while((opt =3D getopt(argc, argv, "sgrwuo:l:PRWtFdK:G:S:U:")) !=3D -1) =
{
>  		switch(opt) {
>  		case 's':
>  			lock_cmd =3D 1;
> @@ -201,6 +318,9 @@ int main(int argc, char **argv)
>  		case 'w':
>  			lock_rw =3D 1;
>  			break;
> +		case 'u':
> +			lock_rw =3D 2;
> +			break;
>  		case 'o':
>  			lock_start =3D atoi(optarg);
>  			break;
> @@ -228,6 +348,15 @@ int main(int argc, char **argv)
>  		case 'K':
>  			semkey =3D strtol(optarg, NULL, 16);
>  			break;
> +		case 'G':
> +			rcv_sock =3D bind_unix(optarg);
> +			break;
> +		case 'S':
> +			snd_sock_name =3D optarg;
> +			break;
> +		case 'U':
> +			unsup_msg =3D optarg;
> +			break;
>  		default:
>  			usage(argv[0]);
>  			return -1;
> @@ -256,17 +385,27 @@ int main(int argc, char **argv)
>  		getlk_macro =3D F_GETLK;
>  	}
> =20
> -	if (lock_rw =3D=3D 1)
> +	switch (lock_rw) {
> +	case 1:
>  		flk.l_type =3D F_WRLCK;
> -	else
> +		break;
> +	case 0:
>  		flk.l_type =3D F_RDLCK;
> +		break;
> +	case 2:
> +		flk.l_type =3D F_UNLCK;
> +		break;
> +	}
> =20

nit: fix the ordering above? Not sure why you decided to do 1,0,2...

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
> @@ -322,6 +461,9 @@ int main(int argc, char **argv)
>  		if (fcntl(fd, setlk_macro, &flk) < 0)
>  			err_exit("setlkw", errno);
> =20
> +		if (snd_sock_name)
> +			send_fd(snd_sock_name, fd);
> +
>  		if (use_dup =3D=3D 1) {
>  			/* dup fd and close the newfd */
>  			int dfd =3D dup(fd);
> @@ -400,13 +542,30 @@ int main(int argc, char **argv)
>  		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
>  			err_exit("wait sem0 0", errno);
> =20
> -		if (fcntl(fd, getlk_macro, &flk) < 0)
> -			err_exit("getlk", errno);
> +		if (rcv_sock !=3D -1) {
> +			fd =3D recv_fd(rcv_sock);
> +			close(rcv_sock);
> +			if (fd =3D=3D -1)
> +				err_exit("SCM_RIGHTS", errno);
> +		}
> +
> +		if (fcntl(fd, getlk_macro, &flk) < 0) {
> +			if (lock_rw =3D=3D 2 && errno =3D=3D EINVAL)
> +				unlck_unsup++;
> +			else
> +				err_exit("getlk", errno);
> +		}
> =20
>  		/* set sem1 =3D 0 (getlk done) */
>  		semu.val =3D 0;
>  		if (semctl(semid, 1, SETVAL, semu) =3D=3D -1)
>  			err_exit("set sem1 0", errno);
> +		if (unlck_unsup) {
> +			if (unsup_msg)
> +				puts(unsup_msg);
> +			close(fd);
> +			return 0;
> +		}
> =20
>  		/* check result */
>  		switch (flk.l_type) {
> diff --git a/tests/generic/478 b/tests/generic/478
> index 419acc94..1399aa6f 100755
> --- a/tests/generic/478
> +++ b/tests/generic/478
> @@ -128,9 +128,9 @@ do_test()
>  	soptions=3D"$1 -K $SEMKEY"
>  	goptions=3D"$2 -K $SEMKEY"
>  	# -s : do setlk
> -	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> +	eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
>  	# -g : do getlk
> -	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> +	eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
>  		tee -a $seqres.full
>  	wait $!
>  	rm_sem
> @@ -140,8 +140,8 @@ do_test()
>  	soptions=3D"$1 -F -K $SEMKEY"
>  	goptions=3D"$2 -K $SEMKEY"
>  	# with -F, new locks are always file to place
> -	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> -	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> +	eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> +	eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
>  		tee -a $seqres.full
>  	wait $!
>  	rm_sem
> @@ -150,8 +150,8 @@ do_test()
>  	# add -d to dup and close
>  	soptions=3D"$1 -d -K $SEMKEY"
>  	goptions=3D"$2 -K $SEMKEY"
> -	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> -	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> +	eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> +	eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
>  		tee -a $seqres.full
>  	wait $!
>  	rm_sem
> @@ -197,6 +197,11 @@ do_test "-s -w -o 0 -l 10 -P" "-g -r -o 5 -l 20" "wr=
lck" "unlck" "unlck"
>  # setlk posix wrlck [0,9], getlk rdlck [20,29]
>  do_test "-s -w -o 0 -l 10 -P" "-g -r -o 20 -l 10" "unlck" "unlck" "unlck=
"
> =20
> +# setlk wrlck [0,9], getlk unlck [0,9]
> +do_test "-s -w -o 0 -l 10 -W -S /tmp/fstests.sock" "-g -u -o 0 -l 10 -W =
-G /tmp/fstests.sock -U get\ wrlck" "wrlck" "wrlck" "wrlck"
> +# setlk wrlck [0,9], getlk unlck [20,29]
> +do_test "-s -w -o 0 -l 10 -S /tmp/fstests.sock" "-g -u -o 20 -l 10 -G /t=
mp/fstests.sock -U lock\ could\ be\ placed" "unlck" "unlck" "unlck"
> +
>  # setlk rdlck [0,9], getlk wrlck [0,9], open RDONLY
>  do_test "-s -r -o 0 -l 10 -R" "-g -w -o 0 -l 10 -R" "rdlck" "unlck" "rdl=
ck"
>  # setlk rdlck [0,9], getlk wrlck [5,24], open RDONLY
> @@ -204,6 +209,13 @@ do_test "-s -r -o 0 -l 10 -R" "-g -w -o 5 -l 20 -R -=
P" "rdlck" "unlck" "rdlck"
>  # setlk posix rdlck [0,9], getlk wrlck [5,24], open RDONLY
>  do_test "-s -r -o 0 -l 10 -R -P" "-g -w -o 5 -l 20 -R" "rdlck" "unlck" "=
unlck"
> =20
> +# setlk rdlck [0,9], getlk unlck [0,9], open RDONLY
> +do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 0 -l 10 -R =
-G /tmp/fstests.sock -U get\ rdlck" "rdlck" "rdlck" "rdlck"
> +# setlk posix rdlck [0,9], getlk unlck [5,24], open RDONLY
> +do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 5 -l 20 -R =
-G /tmp/fstests.sock -U get\ rdlck" "rdlck" "rdlck" "rdlck"
> +# setlk rdlck [0,9], getlk unlck [20,29], open RDONLY
> +do_test "-s -r -o 0 -l 10 -R -S /tmp/fstests.sock" "-g -u -o 20 -l 10 -R=
 -G /tmp/fstests.sock -U lock\ could\ be\ placed" "unlck" "unlck" "unlck"
> +
>  # setlk rdlck [0,9], getlk wrlck [0,9]
>  do_test "-s -r -o 0 -l 10" "-g -w -o 0 -l 10" "rdlck" "unlck" "rdlck"
>  # setlk rdlck [0,9], getlk posix wrlck [5,24]
> diff --git a/tests/generic/478.out b/tests/generic/478.out
> index 0b4b344a..f3ca2473 100644
> --- a/tests/generic/478.out
> +++ b/tests/generic/478.out
> @@ -29,6 +29,12 @@ lock could be placed
>  lock could be placed
>  lock could be placed
>  lock could be placed
> +get wrlck
> +get wrlck
> +get wrlck
> +lock could be placed
> +lock could be placed
> +lock could be placed
>  get rdlck
>  lock could be placed
>  get rdlck
> @@ -39,6 +45,15 @@ get rdlck
>  lock could be placed
>  lock could be placed
>  get rdlck
> +get rdlck
> +get rdlck
> +get rdlck
> +get rdlck
> +get rdlck
> +lock could be placed
> +lock could be placed
> +lock could be placed
> +get rdlck
>  lock could be placed
>  get rdlck
>  get rdlck

The problem here is that old kernels are going to fail the new tests,
and it's going to be hard to engineer the output of 478 to account for
that.

I think instead of extending generic/478, you should add these in a new
testcase, and roll a _requires_ofd_getlk_unlck test or something that
allows older kernels to skip this test. The modifications to
t_ofd_locks.c look fine overall though.

--=20
Jeff Layton <jlayton@kernel.org>
