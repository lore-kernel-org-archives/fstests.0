Received: from mx1.redhat.com ([209.132.183.28]:34998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752020AbdGSDPx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Jul 2017 23:15:53 -0400
Date: Wed, 19 Jul 2017 11:15:51 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [xfstests PATCH v2] common/rc: support jfs in _scratch_mkfs_sized
Message-ID: <20170719031551.GZ2478@eguan.usersys.redhat.com>
References: <20170714220616.GA3975@debian.home>
 <20170719013708.GA6047@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170719013708.GA6047@debian.home>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: fstests@vger.kernel.org, jfs-discussion@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 18, 2017 at 10:37:10PM -0300, Ernesto A. Fern=C3=A1ndez wrote=
:
> Add support for jfs in _scratch_mkfs_sized. Fix the block size in 4096,
> which seems to be the only option in jfs_mkfs.
>=20
> Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.c=
om>
> ---
> I'm sorry, it seems I dropped a double semicolon. It worked the same of=
 course,
> but better to fix it.

Thanks for the update! I didn't catch it in my review either..

Eryu

>=20
>  common/rc | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/common/rc b/common/rc
> index fa1314c..c537ab4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1023,6 +1023,9 @@ _scratch_mkfs_sized()
>      ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4|ocfs2)
>  	def_blksz=3D`echo $MKFS_OPTIONS| sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
>  	;;
> +    jfs)
> +	def_blksz=3D4096
> +	;;
>      esac
> =20
>      [ -n "$def_blksz" ] && blocksize=3D$def_blksz
> @@ -1068,6 +1071,9 @@ _scratch_mkfs_sized()
>  	(( fssize <=3D 100 * 1024 * 1024 )) && mixed_opt=3D'--mixed'
>  	$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
>  	;;
> +    jfs)
> +	${MKFS_PROG}.$FSTYP $MKFS_OPTIONS $SCRATCH_DEV $blocks
> +	;;
>      reiser4)
>  	# mkfs.resier4 requires size in KB as input for creating filesystem
>  	$MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize $SCRATCH_DEV \
> --=20
> 2.1.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
