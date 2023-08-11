Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7939C001DB
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Aug 2023 11:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjHKLkA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Aug 2023 07:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjHKLj7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Aug 2023 07:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63778270C
        for <fstests@vger.kernel.org>; Fri, 11 Aug 2023 04:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE7E067004
        for <fstests@vger.kernel.org>; Fri, 11 Aug 2023 11:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2309C433C7;
        Fri, 11 Aug 2023 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691753997;
        bh=xSNsubibott6gcd7ueUX92oylwo3BpDbUkorNkHiCqo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Pd48b37BQ7cNMRmKxvSP6Udeuc1mja9Alg3RhrErPGsYjeFtrj/MZwjxnsDpPrdM9
         xxX8RpCivYeeQg2sn5mJQY7hfHkl67PfDeIOGG6Z6PeQAF8hYtLotC9+ELNsxeWcXt
         aKv+iuSbIS+smbkwiYfNFHLwH1MxKAdA15QbWHwGeXBIKjGTI1E8TydJHG2K/sw/Ju
         xDh3DQos83u7dy5k10ns3mWF/sbHtgcDFjr+1MMLmhBoGQSs6WhALg0SJKJ2oXFV5i
         xf/2IGhqK1pi3rLbHzDTEOZyyP5nkPpKzGQrW6ZzYA87Pi9gvK2CmeGxH/VECJB1tW
         luT2+QXtCGbgQ==
Message-ID: <39b107687d005752cdf41bc4be33d9bb5e7908cc.camel@kernel.org>
Subject: Re: [PATCH 1/2] t_ofd_locks: fix stalled semaphore handling
From:   Jeff Layton <jlayton@kernel.org>
To:     Stas Sergeev <stsp2@yandex.ru>, fstests@vger.kernel.org
Cc:     Murphy Zhou <xzhou@redhat.com>, Zorro Lang <zlang@redhat.com>
Date:   Fri, 11 Aug 2023 07:39:55 -0400
In-Reply-To: <20230801175220.1558342-2-stsp2@yandex.ru>
References: <20230801175220.1558342-1-stsp2@yandex.ru>
         <20230801175220.1558342-2-stsp2@yandex.ru>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 2023-08-01 at 22:52 +0500, Stas Sergeev wrote:
> Currently IPC_RMID was attempted on a semid returned after failed
> semget() with flags=3DIPC_CREAT|IPC_EXCL. So nothing was actually removed=
.
>=20
> This patch introduces the much more reliable scheme where the wrapper
> script creates and removes semaphores, passing a sem key to the test
> binary via new -K option.
>=20
> This patch speeds up the test ~5 times by removing the sem-awaiting
> loop in a lock-getter process. As the semaphore is now created before
> the test process started, there is no need to wait for anything.
>=20
> CC: fstests@vger.kernel.org
> CC: Murphy Zhou <xzhou@redhat.com>
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Zorro Lang <zlang@redhat.com>
>=20
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> ---
>  src/t_ofd_locks.c | 77 +++++++++++++++--------------------------------
>  tests/generic/478 | 37 ++++++++++++++++++++---
>  2 files changed, 58 insertions(+), 56 deletions(-)
>=20
> diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> index e77f2659..88ef2690 100644
> --- a/src/t_ofd_locks.c
> +++ b/src/t_ofd_locks.c
> @@ -87,8 +87,6 @@ static void err_exit(char *op, int errn)
>  	fprintf(stderr, "%s: %s\n", op, strerror(errn));
>  	if (fd > 0)
>  		close(fd);
> -	if (semid > 0 && semctl(semid, 2, IPC_RMID) =3D=3D -1)
> -		perror("exit rmid");
>  	exit(errn);
>  }
> =20
> @@ -180,16 +178,16 @@ int main(int argc, char **argv)
>  	int setlk_macro =3D F_OFD_SETLKW;
>  	int getlk_macro =3D F_OFD_GETLK;
>  	struct timespec ts;
> -	key_t semkey;
> +	key_t semkey =3D -1;
>  	unsigned short vals[2];
>  	union semun semu;
>  	struct semid_ds sem_ds;
>  	struct sembuf sop;
> -	int opt, ret, retry;
> +	int opt, ret;
> =20
>  	//avoid libcap errno bug
>  	errno =3D 0;
> -	while((opt =3D getopt(argc, argv, "sgrwo:l:PRWtFd")) !=3D -1) {
> +	while((opt =3D getopt(argc, argv, "sgrwo:l:PRWtFdK:")) !=3D -1) {
>  		switch(opt) {
>  		case 's':
>  			lock_cmd =3D 1;
> @@ -227,6 +225,9 @@ int main(int argc, char **argv)
>  		case 'd':
>  			use_dup =3D 1;
>  			break;
> +		case 'K':
> +			semkey =3D strtol(optarg, NULL, 16);
> +			break;
>  		default:
>  			usage(argv[0]);
>  			return -1;
> @@ -276,37 +277,15 @@ int main(int argc, char **argv)
>  		err_exit("test_ofd_getlk", errno);
>  	}
> =20
> -	if((semkey =3D ftok(argv[optind], 255)) =3D=3D -1)
> +	if (semkey =3D=3D -1)
> +		semkey =3D ftok(argv[optind], 255);
> +	if (semkey =3D=3D -1)
>  		err_exit("ftok", errno);
> =20
>  	/* setlk, and always init the semaphore at setlk time */
>  	if (lock_cmd =3D=3D 1) {
> -		/*
> -		 * Init the semaphore, with a key related to the testfile.
> -		 * getlk routine will wait untill this sem has been created and
> -		 * iniialized.
> -		 *
> -		 * We must make sure the semaphore set is newly created, rather
> -		 * then the one left from last run. In which case getlk will
> -		 * exit immediately and left setlk routine waiting forever.
> -		 * Also because newly created semaphore has zero sem_otime,
> -		 * which is used here to sync with getlk routine.
> -		 */
> -		retry =3D 0;
> -		do {
> -			semid =3D semget(semkey, 2, IPC_CREAT|IPC_EXCL);
> -			if (semid < 0 && errno =3D=3D EEXIST) {
> -				/* remove sem set after one round of test */
> -				if (semctl(semid, 2, IPC_RMID, semu) =3D=3D -1)
> -					err_exit("rmid 0", errno);
> -				retry++;
> -			} else if (semid < 0)
> -				err_exit("semget", errno);
> -			else
> -				retry =3D 10;
> -		} while (retry < 5);
> -		/* We can't create a new semaphore set in 5 tries */
> -		if (retry =3D=3D 5)
> +		semid =3D semget(semkey, 2, 0);
> +		if (semid < 0)
>  			err_exit("semget", errno);
> =20
>  		/* Init both new sem to 1 */
> @@ -382,35 +361,29 @@ int main(int argc, char **argv)
>  		ts.tv_nsec =3D 0;
>  		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
>  			err_exit("wait sem1 0", errno);
> -
> -		/* remove sem set after one round of test */
> -		if (semctl(semid, 2, IPC_RMID, semu) =3D=3D -1)
> -			err_exit("rmid", errno);
>  		close(fd);
>  		exit(0);
>  	}
> =20
>  	/* getlck */
>  	if (lock_cmd =3D=3D 0) {
> -		/* wait sem created and initialized */
> -		retry =3D 5;
> -		do {
> -			semid =3D semget(semkey, 2, 0);
> -			if (semid !=3D -1)
> -				break;
> -			if (errno =3D=3D ENOENT && retry) {
> -				sleep(1);
> -				retry--;
> -				continue;
> -			} else {
> -				err_exit("getlk_semget", errno);
> -			}
> -		} while (1);
> +		semid =3D semget(semkey, 2, 0);
> +		if (semid < 0)
> +			err_exit("getlk_semget", errno);
> +
> +		/*
> +		 * Wait initialization complete.
> +		 */
> +		ret =3D -1;
>  		do {
> +			if (ret !=3D -1)
> +				usleep(100000);
>  			memset(&sem_ds, 0, sizeof(sem_ds));
>  			semu.buf =3D &sem_ds;
> -			ret =3D semctl(semid, 0, IPC_STAT, semu);
> -		} while (!(ret =3D=3D 0 && sem_ds.sem_otime !=3D 0));
> +			ret =3D semctl(semid, 1, GETVAL, semu);
> +			if (ret =3D=3D -1)
> +				err_exit("wait sem1 1", errno);
> +		} while (ret !=3D 1);
> =20
>  		/* wait sem0 =3D=3D 0 (setlk and close fd done) */
>  		sop.sem_num =3D 0;
> diff --git a/tests/generic/478 b/tests/generic/478
> index 480762d2..419acc94 100755
> --- a/tests/generic/478
> +++ b/tests/generic/478
> @@ -99,33 +99,62 @@ _require_ofd_locks
>  $XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
>  	$TEST_DIR/testfile >> $seqres.full 2>&1
> =20
> +mk_sem()
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

Given that you're now creating the semaphore before launching the test
program, do you need to clean it up if the shell script dies
abnormally?=A0

IOW, do you need to trap on SIGTERM or something and call rm_sem() ?

>  do_test()
>  {
> -	local soptions=3D"$1"
> -	local goptions=3D"$2"
> +	local soptions
> +	local goptions
>  	# print options and getlk output for debug
>  	echo $* >> $seqres.full 2>&1
> +	mk_sem
> +	soptions=3D"$1 -K $SEMKEY"
> +	goptions=3D"$2 -K $SEMKEY"
>  	# -s : do setlk
>  	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
>  	# -g : do getlk
>  	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
>  		tee -a $seqres.full
>  	wait $!
> +	rm_sem
> =20
> +	mk_sem
>  	# add -F to clone with CLONE_FILES
> -	soptions=3D"$1 -F"
> +	soptions=3D"$1 -F -K $SEMKEY"
> +	goptions=3D"$2 -K $SEMKEY"
>  	# with -F, new locks are always file to place
>  	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
>  	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
>  		tee -a $seqres.full
>  	wait $!
> +	rm_sem
> =20
> +	mk_sem
>  	# add -d to dup and close
> -	soptions=3D"$1 -d"
> +	soptions=3D"$1 -d -K $SEMKEY"
> +	goptions=3D"$2 -K $SEMKEY"
>  	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
>  	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
>  		tee -a $seqres.full
>  	wait $!
> +	rm_sem
>  }
> =20
>  # Always setlk at range [0,9], getlk at range [0,9] [5,24] or [20,29].

Seems like a reasonable change overall, and I like not having to
micromanage the semaphore inside the C program. The cleanup thing can be
fixed after the fact if it's even necessary.

Reviwed-by: Jeff Layton <jlayton@kernel.org>
