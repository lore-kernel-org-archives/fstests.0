Received: from mx1.redhat.com ([209.132.183.28]:36800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdCPHtv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Mar 2017 03:49:51 -0400
Date: Thu, 16 Mar 2017 15:49:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests: xfs/191 update
Message-ID: <20170316074941.GS14226@eguan.usersys.redhat.com>
References: <20170315163347.29743-1-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315163347.29743-1-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 15, 2017 at 05:33:47PM +0100, Jan Tulak wrote:
> The removed 'do_mkfs_pass -l size=3D4096b' was against man page
> (-b section). Other entries are things that weren't covered before.
>=20
> Specifically, a standalone "-l size=3D4096b" should fail, because:
> To  specify any options on the command line in units of filesys=E2=80=90
> tem blocks, this option must be  specified  first  so  that  the
> filesystem block size is applied consistently to all options.
>=20
> Signed-off-by: Jan Tulak <jtulak@redhat.com>

This looks fine to me. But I'd like some reviews from xfs developers
too. (cc'd linux-xfs@vger.kernel.org).

Thanks,
Eryu

> ---
>  tests/xfs/191-input-validation | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-valid=
ation
> index 5de55170..e22f9bfc 100755
> --- a/tests/xfs/191-input-validation
> +++ b/tests/xfs/191-input-validation
> @@ -114,6 +114,9 @@ do_mkfs_fail -d sectsize=3D2foo $SCRATCH_DEV
>  do_mkfs_fail -l sectsize=3Dnggh $SCRATCH_DEV
>  do_mkfs_fail -l sectsize=3D2nggh $SCRATCH_DEV
> =20
> +# option respecification should fail
> +do_mkfs_fail -d agcount=3D32,agcount=3D32 $SCRATCH_DEV
> +
>  # conflicting sector/block sizes
>  do_mkfs_fail -s size=3D512 -d sectsize=3D1024 $SCRATCH_DEV
>  do_mkfs_fail -s size=3D512 -l sectsize=3D1024 $SCRATCH_DEV
> @@ -191,6 +194,12 @@ do_mkfs_fail -d sectsize=3D512s,agsize=3D65536s $S=
CRATCH_DEV
> =20
>  reset_fsimg
> =20
> +# some sectsize/blocksize combinations
> +do_mkfs_pass -s size=3D512 -b size=3D8s $SCRATCH_DEV
> +do_mkfs_fail -s size=3D512s $SCRATCH_DEV
> +
> +reset_fsimg
> +
>  # file section, should pass
>  do_mkfs_pass $fsimg
>  do_mkfs_pass -d file=3D0 $SCRATCH_DEV
> @@ -218,7 +227,6 @@ reset_fsimg
>  # log section, should pass
>  do_mkfs_pass -l size=3D$logsize -d size=3D$fssize $SCRATCH_DEV
>  do_mkfs_pass -l agnum=3D2 $SCRATCH_DEV
> -do_mkfs_pass -l size=3D4096b $SCRATCH_DEV
>  do_mkfs_pass -l sectsize=3D512 $SCRATCH_DEV
>  do_mkfs_pass -l sunit=3D64 $SCRATCH_DEV
>  do_mkfs_pass -l sunit=3D64 -d sunit=3D8,swidth=3D8 $SCRATCH_DEV
> @@ -237,6 +245,7 @@ do_mkfs_pass -l version=3D2 -m crc=3D0 $SCRATCH_DEV
>  do_mkfs_pass -l version=3D2 $SCRATCH_DEV
> =20
>  # log section, should fail
> +do_mkfs_fail -l size=3D4096b $SCRATCH_DEV
>  do_mkfs_fail -l size=3D${fssize}b $SCRATCH_DEV
>  do_mkfs_fail -l size=3D${fssize}s $SCRATCH_DEV
>  do_mkfs_fail -l size=3D${fssize}yerk $SCRATCH_DEV
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
