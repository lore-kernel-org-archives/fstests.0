Received: from mout.gmx.net ([212.227.15.15]:54856 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753593AbdJaAVv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Oct 2017 20:21:51 -0400
Subject: Re: [PATCH] btrfs: test if receive with qgroups corrupts metadata
References: <20171030223245.21877-1-jmaggard@netgear.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <aa5fa4b1-8be6-bc54-e2ba-b0d949d6f9e5@gmx.com>
Date: Tue, 31 Oct 2017 08:21:35 +0800
MIME-Version: 1.0
In-Reply-To: <20171030223245.21877-1-jmaggard@netgear.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cfoHUF47qiHbKXQLXJeTqxRAD7B1hUm0H"
Sender: fstests-owner@vger.kernel.org
To: Justin Maggard <jmaggard10@gmail.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: Justin Maggard <jmaggard@netgear.com>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cfoHUF47qiHbKXQLXJeTqxRAD7B1hUm0H
Content-Type: multipart/mixed; boundary="M3Jp1a1X3lGS8eG5DSSTmHAS7Bi9UOKEU";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Justin Maggard <jmaggard10@gmail.com>, fstests@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Cc: Justin Maggard <jmaggard@netgear.com>
Message-ID: <aa5fa4b1-8be6-bc54-e2ba-b0d949d6f9e5@gmx.com>
Subject: Re: [PATCH] btrfs: test if receive with qgroups corrupts metadata
References: <20171030223245.21877-1-jmaggard@netgear.com>
In-Reply-To: <20171030223245.21877-1-jmaggard@netgear.com>

--M3Jp1a1X3lGS8eG5DSSTmHAS7Bi9UOKEU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2017=E5=B9=B410=E6=9C=8831=E6=97=A5 06:32, Justin Maggard wrote:
> This test case does some concurrent send/receives with qgroups enabled.=

> Currently (4.14-rc7) this usually results in btrfs check errors, and
> often also results in a WARN_ON in record_root_in_trans().
>=20
> Bisecting points to 6426c7ad697d (btrfs: qgroup: Fix qgroup accounting
> when creating snapshot) as the culprit.

Thanks for the report, I'll look into it.

BTW can this only be reproduced by concurrent run?
Will single thread also cause the problem?

Thanks,
Qu
>=20
> Signed-off-by: Justin Maggard <jmaggard@netgear.com>
> ---
>  tests/btrfs/152     | 102 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/btrfs/152.out |  13 +++++++
>  tests/btrfs/group   |   1 +
>  3 files changed, 116 insertions(+)
>  create mode 100755 tests/btrfs/152
>  create mode 100644 tests/btrfs/152.out
>=20
> diff --git a/tests/btrfs/152 b/tests/btrfs/152
> new file mode 100755
> index 0000000..ebb88ed
> --- /dev/null
> +++ b/tests/btrfs/152
> @@ -0,0 +1,102 @@
> +#! /bin/bash
> +# FS QA Test No. btrfs/152
> +#
> +# Test that incremental send/receive operations don't corrupt metadata=
 when
> +# qgroups are enabled.
> +#
> +#---------------------------------------------------------------------=
--
> +#
> +# Copyright (c) 2017 NETGEAR, Inc.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,=

> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#---------------------------------------------------------------------=
--
> +#
> +
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +tmp=3D/tmp/$$
> +status=3D1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Enable quotas
> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +
> +# Create 2 source and 4 destination subvolumes
> +for subvol in subvol1 subvol2 recv1_1 recv1_2 recv2_1 recv2_2; do
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/$subvol | _filter_scra=
tch
> +done
> +mkdir $SCRATCH_MNT/subvol{1,2}/.snapshots
> +touch $SCRATCH_MNT/subvol{1,2}/foo
> +
> +# Create base snapshots and send them
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
> +	$SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
> +	$SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
> +for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
> +	$BTRFS_UTIL_PROG send $SCRATCH_MNT/subvol1/.snapshots/1 2> /dev/null =
| \
> +		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} | _filter_scratch
> +done
> +
> +# Now do 10 loops of concurrent incremental send/receives
> +for i in `seq 1 10`; do
> +	prev=3D$i
> +	curr=3D$((i+1))
> +
> +	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
> +		$SCRATCH_MNT/subvol1/.snapshots/${curr} > /dev/null
> +	($BTRFS_UTIL_PROG send -p $SCRATCH_MNT/subvol1/.snapshots/${prev} \
> +		$SCRATCH_MNT/subvol1/.snapshots/${curr} 2> /dev/null | \
> +		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/recv1_1) > /dev/null &
> +	($BTRFS_UTIL_PROG send -p $SCRATCH_MNT/subvol1/.snapshots/${prev} \
> +		$SCRATCH_MNT/subvol1/.snapshots/${curr} 2> /dev/null | \
> +		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/recv1_2) > /dev/null &
> +
> +	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
> +		$SCRATCH_MNT/subvol2/.snapshots/${curr} > /dev/null
> +	($BTRFS_UTIL_PROG send -p $SCRATCH_MNT/subvol2/.snapshots/${prev} \
> +		$SCRATCH_MNT/subvol2/.snapshots/${curr} 2> /dev/null | \
> +		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/recv2_1) > /dev/null &
> +	($BTRFS_UTIL_PROG send -p $SCRATCH_MNT/subvol2/.snapshots/${prev} \
> +		$SCRATCH_MNT/subvol2/.snapshots/${curr} 2> /dev/null | \
> +		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/recv2_2) > /dev/null &
> +	wait
> +done
> +
> +_scratch_unmount
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/152.out b/tests/btrfs/152.out
> new file mode 100644
> index 0000000..a95bb57
> --- /dev/null
> +++ b/tests/btrfs/152.out
> @@ -0,0 +1,13 @@
> +QA output created by 152
> +Create subvolume 'SCRATCH_MNT/subvol1'
> +Create subvolume 'SCRATCH_MNT/subvol2'
> +Create subvolume 'SCRATCH_MNT/recv1_1'
> +Create subvolume 'SCRATCH_MNT/recv1_2'
> +Create subvolume 'SCRATCH_MNT/recv2_1'
> +Create subvolume 'SCRATCH_MNT/recv2_2'
> +Create a readonly snapshot of 'SCRATCH_MNT/subvol1' in 'SCRATCH_MNT/su=
bvol1/.snapshots/1'
> +Create a readonly snapshot of 'SCRATCH_MNT/subvol2' in 'SCRATCH_MNT/su=
bvol2/.snapshots/1'
> +At subvol 1
> +At subvol 1
> +At subvol 1
> +At subvol 1
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index e17c275..fb94461 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -154,3 +154,4 @@
>  149 auto quick send compress
>  150 auto quick dangerous
>  151 auto quick
> +152 auto quick metadata qgroup send
>=20


--M3Jp1a1X3lGS8eG5DSSTmHAS7Bi9UOKEU--

--cfoHUF47qiHbKXQLXJeTqxRAD7B1hUm0H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAln3wg8XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qig4Af+LbeDpbzDzmveXJJ4XtXkfVyx
o/l9Ro1udULCbDznxLlxnDWU7geQy3IaHNTDK0IxqrvCVOIQaTiVb/zYKyF6GV3w
6xfbztsZ1JWgxK4IZf9qmu4o7w0LaJ1VgZ4Nwm7vDiwoc+vaZ+nz8oEPvzO5q65F
NXWfAU1rLgcNiRQlWErmBGn2yqGZop/E9itxTIS7W2w8dql5JSFBTh80t4jtqgB8
n/flaj1WAFJe6l/txgqzK925BCxX/tBWhEt1r3Jr4CR4SzitgHoBYd27CF59wyW6
YjjXZr73cfA6RkLWTDxcSZwr0+voCTAJS7HoTZufhKGavXPuTjkPJMBQVKZooA==
=kwsT
-----END PGP SIGNATURE-----

--cfoHUF47qiHbKXQLXJeTqxRAD7B1hUm0H--
