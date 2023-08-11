Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D603C001B0
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Aug 2023 11:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjHKLvc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Aug 2023 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjHKLvb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Aug 2023 07:51:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB05BF5
        for <fstests@vger.kernel.org>; Fri, 11 Aug 2023 04:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CBFE65D97
        for <fstests@vger.kernel.org>; Fri, 11 Aug 2023 11:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D6FC433C8;
        Fri, 11 Aug 2023 11:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691754689;
        bh=evTWq/pEOKQifr28BPBrAgm0ZLpKMYV6BWhAvo8QAj0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D9YyVAab+QJlSsAZlxx3+eTypOZkHm6Th9ucPhkg+TkaEp+1ztw0qys7wwpthxqt2
         J5Gh0OujtWwEbRxV/x+5r0VlTFE6UITiwLvyPcYGQLDX7hWtQvnOUXCzHq1OME79Fd
         VvruXgFeA+2bAI3jSbp3ypolItOjoKH6LJHgcM7p6l6RplAc7MaJLOQity+eZ8xkYj
         iN7kL8Fcg7GaV5l8te6tISv2m6AOxDNh/p/89cv5ID/dbIzTiL1pZMRAPXPZwVkUt0
         2oiC+jX8rDCfrELUV6nAiljn7ypjAjm9BDXuJWq6SrHQ/kcvuilU5a21lzaBKGLYnD
         cU/zSy8e1i+OA==
Message-ID: <379f0c40ee8b2c420733e206f3a66470d34c81b3.camel@kernel.org>
Subject: Re: [PATCH 2/2] t_ofd_locks: fix sem initialization sequence
From:   Jeff Layton <jlayton@kernel.org>
To:     Stas Sergeev <stsp2@yandex.ru>, fstests@vger.kernel.org
Cc:     Murphy Zhou <xzhou@redhat.com>, Zorro Lang <zlang@redhat.com>
Date:   Fri, 11 Aug 2023 07:51:28 -0400
In-Reply-To: <20230801175220.1558342-3-stsp2@yandex.ru>
References: <20230801175220.1558342-1-stsp2@yandex.ru>
         <20230801175220.1558342-3-stsp2@yandex.ru>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 2023-08-01 at 22:52 +0500, Stas Sergeev wrote:
> The locker was waiting for sem_otime on sem0 to became non-zero after
> incrementing sem0 himself. So sem_otime was never 0 at the time of
> checking it, so the check was redundant/wrong.
>=20
> This patch:
> - moves the increment of sem1 to the lock-tester site
> - lock-setter waits for that sem1 event, for which this patch replaces
>   the wait loop on sem_otime with GETVAL loop, adding a small sleep
> - increment of sem0 to 2 moved past that sem1 event. That sem0 event
>   is currently not used/waited.
>=20
> This guarantees that the lock-setter is working only after lock-getter
> is fully initialized.
>=20
> CC: fstests@vger.kernel.org
> CC: Murphy Zhou <xzhou@redhat.com>
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Zorro Lang <zlang@redhat.com>
>=20
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> ---
>  src/t_ofd_locks.c | 44 +++++++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
>=20
> diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> index 88ef2690..58cb0959 100644
> --- a/src/t_ofd_locks.c
> +++ b/src/t_ofd_locks.c
> @@ -294,32 +294,29 @@ int main(int argc, char **argv)
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
> @@ -385,6 +382,15 @@ int main(int argc, char **argv)
>  				err_exit("wait sem1 1", errno);
>  		} while (ret !=3D 1);
> =20
> +		/* inc sem1 to 2 (initialization completed) */
> +		sop.sem_num =3D 1;
> +		sop.sem_op =3D 1;
> +		sop.sem_flg =3D 0;
> +		ts.tv_sec =3D 5;
> +		ts.tv_nsec =3D 0;
> +		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> +			err_exit("inc sem1 2", errno);
> +
>  		/* wait sem0 =3D=3D 0 (setlk and close fd done) */
>  		sop.sem_num =3D 0;
>  		sop.sem_op =3D 0;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
