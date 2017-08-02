Received: from mx1.redhat.com ([209.132.183.28]:55242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbdHBHAd (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 2 Aug 2017 03:00:33 -0400
Date: Wed, 2 Aug 2017 15:00:30 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] generic/449: make the test effective against xfs
Message-ID: <20170802070030.GT9167@eguan.usersys.redhat.com>
References: <20170801045528.GA4696@debian.home>
 <20170802041933.GB7310@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802041933.GB7310@debian.home>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 02, 2017 at 01:19:34AM -0300, Ernesto A. Fern=C3=A1ndez wrote=
:
> Setting acls on an xfs filesystem will succeed even after running out
> of space for user attributes. Use trusted attributes instead. Also spee=
d
> up the test by setting large values for the attributes.
>=20
> Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.c=
om>
> ---
> Changes in v2:
>   - The check for xfs actually worked for all filesystems, as Eryu Guan
>     noticed. So the test is now much more straightforward.

Thanks for the update!

>=20
>  tests/generic/449 | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/generic/449 b/tests/generic/449
> index fb776b3..f5aad22 100755
> --- a/tests/generic/449
> +++ b/tests/generic/449
> @@ -66,9 +66,17 @@ touch $TFILE
>  chmod u+rwx $TFILE
>  chmod go-rwx $TFILE
> =20
> +# The content of this file will be used as the value of the attributes
> +VFILE=3D$SCRATCH_MNT/valuefile
> +touch $VFILE
> +$XFS_IO_PROG -c "pwrite -S 0x2E 0 1k" $VFILE >>$seqres.full 2>&1
> +

I think this VFILE is not needed, because ..

>  # Try to run out of space so setfacl will fail
>  $XFS_IO_PROG -c "pwrite 0 50m" $TFILE >>$seqres.full 2>&1
>  i=3D1
> +while $SETFATTR_PROG -n trusted.$i -v $(cat $VFILE) $TFILE &>/dev/null=
; do

we can use something like $(perl -e 'print "a"x1024') to generate 1k
attr value.

I can fix it at commit time if this looks OK to you.

Thanks,
Eryu

> +	((++i))
> +done
>  j=3D1
>  ret=3D0
>  while [ $ret -eq 0 ]; do
> @@ -77,7 +85,7 @@ while [ $ret -eq 0 ]; do
>  		# On btrfs, setfattr will sometimes fail when free space is
>  		# low, long before it's actually exhausted. Insist until it
>  		# fails consistently.
> -		$SETFATTR_PROG -n user.$i"x"$j $TFILE &>/dev/null
> +		$SETFATTR_PROG -n trusted.$i"x"$j $TFILE &>/dev/null
>  		ret=3D$(( $ret && $? ))
>  		((++j))
>  	done
> --=20
> 2.1.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
