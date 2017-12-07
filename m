Received: from mout.gmx.net ([212.227.15.19]:55368 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbdLGAny (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 6 Dec 2017 19:43:54 -0500
Subject: Re: [PATCH] fstests: btrfs: Add test case to check if btrfs can
 handle full fs trim correctly
References: <20171129061419.18310-1-wqu@suse.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ece8114b-4b46-f3c4-f7ae-7fd92a116a87@gmx.com>
Date: Thu, 7 Dec 2017 08:43:43 +0800
MIME-Version: 1.0
In-Reply-To: <20171129061419.18310-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7fjKSHOML4sPOPxun34sEsKgIKIvrNT1q"
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7fjKSHOML4sPOPxun34sEsKgIKIvrNT1q
Content-Type: multipart/mixed; boundary="iPLqjG1XMUOFHDtJwTbCI2QrUncjOWbtE";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
Message-ID: <ece8114b-4b46-f3c4-f7ae-7fd92a116a87@gmx.com>
Subject: Re: [PATCH] fstests: btrfs: Add test case to check if btrfs can
 handle full fs trim correctly
References: <20171129061419.18310-1-wqu@suse.com>
In-Reply-To: <20171129061419.18310-1-wqu@suse.com>

--iPLqjG1XMUOFHDtJwTbCI2QrUncjOWbtE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping.

Any comment on this?

Thanks,
Qu

On 2017=E5=B9=B411=E6=9C=8829=E6=97=A5 14:14, Qu Wenruo wrote:
> Ancient commit f4c697e6406d ("btrfs: return EINVAL if start > total_byt=
es in
> fitrim ioctl") introduced a regression where btrfs may fail to trim any=

> free space in existing block groups.
>=20
> It's caused by confusion with btrfs_super_block->total_bytes and btrfs
> logical address space.
> Unlike physical address, any aligned bytenr in range [0, U64_MAX) is
> valid in btrfs logical address space, and it's chunk mapping mechanism
> of btrfs to handle the logical<->physical mapping.
>=20
> The test case will craft a btrfs with the following features:
> 0) Single data/meta profile
>    Make trimmed bytes reporting and chunk allocation more predictable.
>=20
> 1) All chunks start beyond super_block->total_bytes (1G)
>    By relocating these blocks several times.
>=20
> 2) Unallocated space is less than 50% of the whole fs
>=20
> 3) Fragmented data chunks
>    Data chunks will be full of fragments, 50% of data chunks will be
>    free space.
>=20
> So in theory fstrim should be able to trim over 50% space of the fs.
> (after fix, 64% of the fs can be trimmed)
> While the regression makes btrfs only able to trim unallocated space,
> which is less than 50% of the total space.
> (without fix, it's only 31%)
>=20
> Fixed by patch named "btrfs: Ensure btrfs_trim_fs can trim the whole fs=
".
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/155     | 120 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/btrfs/155.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 123 insertions(+)
>  create mode 100755 tests/btrfs/155
>  create mode 100644 tests/btrfs/155.out
>=20
> diff --git a/tests/btrfs/155 b/tests/btrfs/155
> new file mode 100755
> index 00000000..6918f093
> --- /dev/null
> +++ b/tests/btrfs/155
> @@ -0,0 +1,120 @@
> +#! /bin/bash
> +# FS QA Test 155
> +#
> +# Check if btrfs can correctly trim free space in block groups
> +#
> +# An ancient regression prevent btrfs from trimming free space inside
> +# existing block groups, if bytenr of block group starts beyond
> +# btrfs_super_block->total_bytes.
> +# However all bytenr in btrfs is in btrfs logical address space,
> +# where any bytenr in range [0, U64_MAX] is valid.
> +#
> +# Fixed by patch named "btrfs: Ensure btrfs_trim_fs can trim the whole=
 fs".
> +#
> +#---------------------------------------------------------------------=
--
> +# Copyright (c) 2017 SUSE Linux Products GmbH.  All Rights Reserved.
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
> +here=3D`pwd`
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
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_fstrim
> +
> +# 1024fs size
> +fs_size=3D$((1024 * 1024 * 1024))
> +
> +# Use small files to fill half of the fs
> +file_size=3D$(( 1024 * 1024 ))
> +nr_files=3D$(( $fs_size / $file_size / 2))
> +
> +# Force to use single data and meta profile.
> +# Since the test relies on fstrim output, which will differ for differ=
ent
> +# profiles
> +_scratch_mkfs -b $fs_size -m single -d single > /dev/null
> +_scratch_mount
> +
> +_require_batched_discard "$SCRATCH_MNT"
> +
> +for n in $(seq -w 0 $(( $nr_files - 1))); do
> +	$XFS_IO_PROG -f -c "pwrite 0 $file_size" "$SCRATCH_MNT/file_$n" \
> +		> /dev/null
> +done
> +
> +# Flush all buffer data into disk, to trigger chunk allocation
> +sync
> +
> +# Now we have take at least 50% of the filesystem, relocate all chunks=
 twice
> +# so all chunks will start after 1G in logical space.
> +# (Btrfs chunk allocation will not rewind to reuse lower space)
> +_run_btrfs_util_prog balance start --full-balance "$SCRATCH_MNT"
> +
> +# To avoid possible false ENOSPC alert on v4.15-rc1, seems to be a
> +# reserved space related bug (maybe related to outstanding space rewor=
k?),
> +# but that's another story.
> +sync
> +
> +_run_btrfs_util_prog balance start --full-balance "$SCRATCH_MNT"
> +
> +# Now remove half of the files to make some holes for later trim.
> +# While still keep the chunk space fragmented, so no chunk will be fre=
ed
> +rm $SCRATCH_MNT/file_*[13579] -f
> +
> +# Make sure space is freed
> +sync
> +
> +trimmed=3D$($FSTRIM_PROG -v "$SCRATCH_MNT" | _filter_fstrim)
> +echo "Trimmed=3D$trimmed total_size=3D$fs_size ratio=3D$(($trimmed * 1=
00 / $fs_size))%" \
> +	>> $seqres.full
> +
> +# For correct full fs trim, both unallocated space (less than 50%)
> +# and free space in existing block groups (about 25%) should be trimme=
d.
> +# If less than 50% is trimmed, then only unallocated space is trimmed.=

> +# BTW, without fix only 31% can be trimmed, while after fix it's 64%.
> +if [ $trimmed -lt $(( $fs_size / 2)) ]; then
> +	echo "Free space in block groups not trimmed"
> +	echo "Trimmed=3D$trimmed total_size=3D$fs_size ratio=3D$(($trimmed * =
100 / $fs_size))%"
> +fi
> +
> +echo "Silence is golden"
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/155.out b/tests/btrfs/155.out
> new file mode 100644
> index 00000000..d25dcd3b
> --- /dev/null
> +++ b/tests/btrfs/155.out
> @@ -0,0 +1,2 @@
> +QA output created by 155
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index c98cf823..86c7128e 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -157,3 +157,4 @@
>  152 auto quick metadata qgroup send
>  153 auto quick qgroup
>  154 auto quick
> +155 auto trim
>=20


--iPLqjG1XMUOFHDtJwTbCI2QrUncjOWbtE--

--7fjKSHOML4sPOPxun34sEsKgIKIvrNT1q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAloojr8XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qiqHgf/WrdOuKeNoRBtbXZiM8YNQRJp
u1pfe2F/ZwvWxs05zcByt8zNqUmXtlpDftlxYvPn2THlGQiW98voo2hTbrO3OOkq
mIM/nmiKMchzqwpkjPJfen0f6lrREYImXlcYQKH+bnqNtIHARnPwoDnsng7dGsm0
4tt1lydF5JvvemY9YJqoY4mQVbNqlqyJbCY3I+Tr+YPVGOhVsq+dIIZsjguZAAQO
c7Q+VslbpIU+yIsv15DhkhpnDcCXgxo/uk2rP6Vjbp+2jbA8g3VQ1JvJ3X31zTXr
Ikxk0Q6DHa8ObVPpOZ8+AsDdRNd95U8VtcKZL32To6k3z0RLZAc+n0d0/JjMYQ==
=2hkP
-----END PGP SIGNATURE-----

--7fjKSHOML4sPOPxun34sEsKgIKIvrNT1q--
