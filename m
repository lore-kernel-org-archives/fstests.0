Received: from mail-pf1-f194.google.com ([209.85.210.194]:33247 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDNLE7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Apr 2019 07:04:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id h5so7227852pfo.0
        for <fstests@vger.kernel.org>; Sun, 14 Apr 2019 04:04:58 -0700 (PDT)
Date: Sun, 14 Apr 2019 19:04:51 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/478: should wait until dup success or fail
Message-ID: <20190414110451.GM2824@desktop>
References: <1554975321-121948-1-git-send-email-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554975321-121948-1-git-send-email-zhangxiaoxu5@huawei.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 11, 2019 at 05:35:21PM +0800, ZhangXiaoxu wrote:
> When test on nfs, maybe failed as below:
>   wait sem0 0: Resource temporarily unavailable
>   set sem0 0: Invalid argument
>   exit rmid: Invalid argument
>=20
> It means getlk routine wait sem0 timeout, because the setlk routine
> maybe take too long time on =E2=80=98fcntl=E2=80=99 or 'dup'.
>=20
> So, let wait on sem0 in getlk routine until the setlk routine success
> or fail.
>=20
> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  src/t_ofd_locks.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> index e3b15dd..32e90c0 100644
> --- a/src/t_ofd_locks.c
> +++ b/src/t_ofd_locks.c
> @@ -414,9 +414,7 @@ int main(int argc, char **argv)
>  		sop.sem_num =3D 0;
>  		sop.sem_op =3D 0;
>  		sop.sem_flg =3D 0;
> -		ts.tv_sec =3D 5;
> -		ts.tv_nsec =3D 0;
> -		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> +		if (semtimedop(semid, &sop, 1, NULL) =3D=3D -1)

We set a timeout value on purpose in the first place, to avoid hanging
the whole test if the setlk process went wrong.

And I didn't reproduce it on NFS. Do I need any special NFS
configuration?

Thanks,
Eryu

>  			err_exit("wait sem0 0", errno);
> =20
>  		if (fcntl(fd, getlk_macro, &flk) < 0)
> --=20
> 2.7.4
>=20
