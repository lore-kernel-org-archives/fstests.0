Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAEDEB64DA
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Jul 2023 12:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjGEM0P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Jul 2023 08:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGEM0O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Jul 2023 08:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA6DF7
        for <fstests@vger.kernel.org>; Wed,  5 Jul 2023 05:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B48161549
        for <fstests@vger.kernel.org>; Wed,  5 Jul 2023 12:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367C8C433C7;
        Wed,  5 Jul 2023 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688559972;
        bh=QMQbhYvD9K+E/42APumtSFwzdGy0dBx+vIvmRj6EU9Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lP2pbDqa1ATQvKtrLKWYIR/jThSEQuXpr7qlib+AiRk079zsrQl0s9cbbUwQzXOOc
         Ehk+hwJ4EGR7hJb6Ls61gbn3ZBzgptBfsZvHOrnqHWVSeBax37yEb0ti/4wfqVxLy8
         mxsnm/Kim9BSpr2XLNeteUH+/h7/H+tceSdqTevT/VmiEF8aJeQPmQu/dxcSyqyVon
         9Qo/hUeBTSaBJrKLH2CUhhgfcPGOuyeY3dtWePvjLJlHbSJoUZL0YcOd3evtaLN/bB
         CRj2yAXja7iQqYfFLoiTOml8suhEwwGsnPgugWj8Uqrp4l8oU7tf2YDrAdQCZr2e5h
         RIxyoVzMpKglA==
Message-ID: <6ee5c9ee42388d2a2e25bf80b3d7db9c09384867.camel@kernel.org>
Subject: Re: [PATCH] t_ofd_locks: fix initialization sequence
From:   Jeff Layton <jlayton@kernel.org>
To:     Stas Sergeev <stsp2@yandex.ru>, fstests@vger.kernel.org
Cc:     Xiong Zhou <xzhou@redhat.com>
Date:   Wed, 05 Jul 2023 08:26:10 -0400
In-Reply-To: <20230630094051.3765376-1-stsp2@yandex.ru>
References: <20230630094051.3765376-1-stsp2@yandex.ru>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, 2023-06-30 at 14:40 +0500, Stas Sergeev wrote:
> Currently IPC_RMID was attempted on a semid returned after failed
> semget() with flags=3DIPC_CREAT|IPC_EXCL. So nothing was actually removed=
.
> To get a proper semid, this patch retries semget() without IPC_EXCL.
>=20

Nice catch.

> This opens up a race: if the lock-tester grabbed the old sem before
> lock-setter used that magic to remove it, then the lock-tester will
> remain with removed sem.
>=20
> Additionally locker was waiting for sem_otime on sem0 to became
> non-zero after incrementing sem0 himself. So sem_otime was never
> 0 at the time of checking it.
>=20
> So basically the code was all wrong.
> This patch:
> - fixes RMID after IPC_EXCL to actually remove the sem
> - moves the increment of sem1 to the lock-tester site, and the
>   lock-setter waits for that event
> - replaces the wait loop on sem_otime with GETVAL, adding a small sleep.
> - lock-tester during the init sequence checks for removed sem, and
>   if it is - retries the init from semget()
>=20
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> ---
>  src/t_ofd_locks.c | 73 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 26 deletions(-)
>=20
> diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> index e77f2659..daa6f96c 100644
> --- a/src/t_ofd_locks.c
> +++ b/src/t_ofd_locks.c
> @@ -297,6 +297,7 @@ int main(int argc, char **argv)
>  			semid =3D semget(semkey, 2, IPC_CREAT|IPC_EXCL);
>  			if (semid < 0 && errno =3D=3D EEXIST) {
>  				/* remove sem set after one round of test */
> +				semid =3D semget(semkey, 2, IPC_CREAT);
>  				if (semctl(semid, 2, IPC_RMID, semu) =3D=3D -1)
>  					err_exit("rmid 0", errno);
>  				retry++;
> @@ -315,32 +316,29 @@ int main(int argc, char **argv)
>  		semu.array =3D vals;
>  		if (semctl(semid, 2, SETALL, semu) =3D=3D -1)
>  			err_exit("init sem", errno);
> -		/* Inc both new sem to 2 */
> -		sop.sem_num =3D 0;
> -		sop.sem_op =3D 1;
> -		sop.sem_flg =3D 0;
> -		ts.tv_sec =3D 5;
> -		ts.tv_nsec =3D 0;
> -		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> -			err_exit("inc sem0 2", errno);
> -		sop.sem_num =3D 1;
> -		sop.sem_op =3D 1;
> -		sop.sem_flg =3D 0;
> -		ts.tv_sec =3D 5;
> -		ts.tv_nsec =3D 0;
> -		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> -			err_exit("inc sem1 2", errno);
> =20
>  		/*
> -		 * Wait initialization complete. semctl(2) only update
> -		 * sem_ctime, semop(2) will update sem_otime.
> +		 * Wait initialization complete.
>  		 */
>  		ret =3D -1;
>  		do {
> +			if (ret !=3D -1)
> +				usleep(100000);
>  			memset(&sem_ds, 0, sizeof(sem_ds));
>  			semu.buf =3D &sem_ds;
> -			ret =3D semctl(semid, 0, IPC_STAT, semu);
> -		} while (!(ret =3D=3D 0 && sem_ds.sem_otime !=3D 0));
> +			ret =3D semctl(semid, 1, GETVAL, semu);
> +			if (ret =3D=3D -1)
> +				err_exit("wait sem1 2", errno);
> +		} while (ret !=3D 2);
> +
> +		/* Inc sem0 to 2 */
> +		sop.sem_num =3D 0;
> +		sop.sem_op =3D 1;
> +		sop.sem_flg =3D 0;
> +		ts.tv_sec =3D 5;
> +		ts.tv_nsec =3D 0;
> +		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> +			err_exit("inc sem0 2", errno);
> =20
>  		/* place the lock */
>  		if (fcntl(fd, setlk_macro, &flk) < 0)
> @@ -393,10 +391,26 @@ int main(int argc, char **argv)
>  	/* getlck */
>  	if (lock_cmd =3D=3D 0) {
>  		/* wait sem created and initialized */
> +again:
>  		retry =3D 5;
>  		do {
>  			semid =3D semget(semkey, 2, 0);
> -			if (semid !=3D -1)
> +			ret =3D -1;
> +			if (semid !=3D -1) do {
> +				if (ret !=3D -1)
> +					usleep(100000);
> +				memset(&sem_ds, 0, sizeof(sem_ds));
> +				semu.buf =3D &sem_ds;
> +				ret =3D semctl(semid, 0, GETVAL, semu);
> +				if (ret =3D=3D -1 && (errno =3D=3D EINVAL
> +					       || errno =3D=3D EIDRM)) {
> +					/* sem removed */
> +					goto again;
> +				}
> +				if (ret =3D=3D -1)
> +					break;
> +			} while (ret !=3D 1);
> +			if (ret =3D=3D 1)
>  				break;
>  			if (errno =3D=3D ENOENT && retry) {
>  				sleep(1);
> @@ -406,11 +420,15 @@ int main(int argc, char **argv)
>  				err_exit("getlk_semget", errno);
>  			}
>  		} while (1);
> -		do {
> -			memset(&sem_ds, 0, sizeof(sem_ds));
> -			semu.buf =3D &sem_ds;
> -			ret =3D semctl(semid, 0, IPC_STAT, semu);
> -		} while (!(ret =3D=3D 0 && sem_ds.sem_otime !=3D 0));
> +
> +		/* inc sem1 to 2 (initialization completed) */
> +		sop.sem_num =3D 1;
> +		sop.sem_op =3D 1;
> +		sop.sem_flg =3D 0;
> +		ts.tv_sec =3D 5;
> +		ts.tv_nsec =3D 0;
> +		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> +			err_exit("inc sem1 2", errno);
> =20
>  		/* wait sem0 =3D=3D 0 (setlk and close fd done) */
>  		sop.sem_num =3D 0;
> @@ -418,8 +436,11 @@ int main(int argc, char **argv)
>  		sop.sem_flg =3D 0;
>  		ts.tv_sec =3D 5;
>  		ts.tv_nsec =3D 0;
> -		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> +		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1) {
> +			if (errno =3D=3D EIDRM || errno =3D=3D EINVAL)
> +				goto again;
>  			err_exit("wait sem0 0", errno);
> +		}
> =20
>  		if (fcntl(fd, getlk_macro, &flk) < 0)
>  			err_exit("getlk", errno);

(cc'ing Murphy)

The patch looks reasonable to me at first glance, though I confess I'm
no expert in semaphore handling.

Acked-by: Jeff Layton <jlayton@kernel.org>
