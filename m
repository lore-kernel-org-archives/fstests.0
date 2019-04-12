Received: from mout.gmx.net ([212.227.17.20]:34799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfDLHPg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 12 Apr 2019 03:15:36 -0400
Subject: Re: [PATCH RFC] fstests: generic/077: fix populate fs use _fill_fs()
References: <20190412052418.22206-1-anand.jain@oracle.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <91949b01-d016-f732-265b-77a397a1efbe@gmx.com>
Date: Fri, 12 Apr 2019 15:15:25 +0800
MIME-Version: 1.0
In-Reply-To: <20190412052418.22206-1-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BpJ4qmCH949WG6u4zZER2hlWiemmZnWS0"
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BpJ4qmCH949WG6u4zZER2hlWiemmZnWS0
Content-Type: multipart/mixed; boundary="kAriEelbh5SPnFyGqyo8QgiETQDCDwJoR";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Message-ID: <91949b01-d016-f732-265b-77a397a1efbe@gmx.com>
Subject: Re: [PATCH RFC] fstests: generic/077: fix populate fs use _fill_fs()
References: <20190412052418.22206-1-anand.jain@oracle.com>
In-Reply-To: <20190412052418.22206-1-anand.jain@oracle.com>

--kAriEelbh5SPnFyGqyo8QgiETQDCDwJoR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/4/12 =E4=B8=8B=E5=8D=881:24, Anand Jain wrote:
> Test case generic/077 uses files under /lib or /usr to fill SCRATCH_MNT=
=2E
> If /usr or /lib is below 256mb then test fails to run, or if these dirs=

> are too large it takes a long time for the cp to finish. On my machine
> it takes 645sec.

Wait for a minute, ths fs is only 256M sized, if it takes you over 10
minutes, there must be something else wrong.

>=20
> This patch propose to use the common/populate function _fill_fs() to
> write files into the target directory instead. However I am not too
> sure about the motivation of this test case in the first place, and
> why does it wanted to cp /usr or /lib,

To my eyes, it's using /usr or /lib just for it's mostly full/contains a
lot of files for most systems.

> and why fs should become full?

Maybe to hit certain ENOSPC corner case for ACL/xattr, just my guess.

> Any idea? Thanks.

Use populate_fs is definitely the right move.

However I have some concern below.

[snip]
>  echo "*** set default ACL"
>  setfacl -R -dm u:fsgqa:rwx,g::rwx,o::r-x,m::rwx $SCRATCH_MNT/subdir
> =20
> -echo "*** populate filesystem, pass #1" | tee -a $seqres.full
> -cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
> -
> -echo "*** populate filesystem, pass #2" | tee -a $seqres.full
> -cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
> +blksz=3D"$(_get_block_size $SCRATCH_MNT/subdir)"
> +echo "*** populate filesystem" | tee -a $seqres.full
> +echo "*** fill_fs $fs_size $SCRATCH_MNT/subdir $blksz 0" >> $seqres.fu=
ll
> +_fill_fs $fs_size $SCRATCH_MNT/subdir $blksz 0 >> $seqres.full 2>&1

Unlike the original behavior, which do 2 passes and the 2nd pass will
overwrite previous files.

While after your modification, it's no longer the case.

At least we should try to replay the 1st run to mimic the original behavi=
or.

Thanks,
Qu

> =20
>  _check_scratch_fs
> =20
> diff --git a/tests/generic/077.out b/tests/generic/077.out
> index eae7226ab29c..9c143c902a2c 100644
> --- a/tests/generic/077.out
> +++ b/tests/generic/077.out
> @@ -1,7 +1,6 @@
>  QA output created by 077
>  *** create filesystem
>  *** set default ACL
> -*** populate filesystem, pass #1
> -*** populate filesystem, pass #2
> +*** populate filesystem
>  *** all done
>  *** unmount
>=20


--kAriEelbh5SPnFyGqyo8QgiETQDCDwJoR--

--BpJ4qmCH949WG6u4zZER2hlWiemmZnWS0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlywOw0ACgkQwj2R86El
/qgGZQf8Cvq/9+VJjQ/tjXy5UzCyZiyFfvrtf3MnSxRUcSwj0EL/mFECBiwA0f9K
PPpfzYhdh1fXJbVEdIa58O8U2uupNSLWOVL/pBOhEXX04W5PtX+56nWSYFd2kJrt
os0H/ZLt+6pG/mMrIjlMnDmGwguXk3ynT1U5DQt0Xwwcv8ibJX4ljXfHPMkmoft/
b5k2LR+7xXg0WCOA3Mbu5c/uc7q1cmxQo/eDUXJzT3A/7+3sFXwHnQakB5PNf6K2
18/5F9MBDO65gUYh72/qtcGq/sgG6TEWTDCZSI9tPIdwcJKZsRxM6ip45IHnRGVh
4RVDt+d9E7y8EqsdawQ4Hy+X1OVufw==
=n/II
-----END PGP SIGNATURE-----

--BpJ4qmCH949WG6u4zZER2hlWiemmZnWS0--
