Received: from userp2130.oracle.com ([156.151.31.86]:36720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfCUUXt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Mar 2019 16:23:49 -0400
Date: Thu, 21 Mar 2019 13:23:48 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] Add new tests/generic/536: intermittent I/O errors must
 not corrupt a filesystem
Message-ID: <20190321202348.GA1180@magnolia>
References: <20190321103045.6441-1-edvin.torok@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190321103045.6441-1-edvin.torok@citrix.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>
Cc: fstests@vger.kernel.org, Mark Syms <Mark.Syms@citrix.com>, Tim Smith <Tim.Smith@citrix.com>, Ross Lagerwall <Ross.Lagerwall@citrix.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 21, 2019 at 10:30:46AM +0000, Edwin T=F6r=F6k wrote:
> Based on tests/generic/347.
>=20
> In our lab we've found that if multiple iSCSI connection errors are
> detected (without completely loosing the iSCSI connection) then the GFS=
2
> filesystem becomes corrupt due to differences in filesystem and device =
blocksizes.
> Add a test that explicitly checks for this by simulating I/O errors
> deterministically with dm-thin.

How is this different from generic/475?  Is there something specific to
thin pools here (vs. using dm-error to simulate the errors)?

--D

> Changing the blocksize to 512 would make this test pass on GFS as well.
>=20
> This test causes I/O errors on purpose, and thus it is expected that a =
filesystem
> might withdraw itself, or remount readonly.
> However when mounting the filesystem again it should be usable,
> without corruption (i.e. immediately unmount itself again).
>=20
> Tested that this passes on ext4 and fails on GFS2.

> CC: Mark Syms <Mark.Syms@citrix.com>
> CC: Tim Smith <Tim.Smith@citrix.com>
> CC: Ross Lagerwall <Ross.Lagerwall@citrix.com>
> Signed-off-by: Edwin T=F6r=F6k <edvin.torok@citrix.com>
> ---
>  common/dmthin         |  6 ++++
>  tests/generic/536     | 80 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/536.out |  2 ++
>  tests/generic/group   |  1 +
>  4 files changed, 89 insertions(+)
>  create mode 100755 tests/generic/536
>  create mode 100644 tests/generic/536.out
>=20
> diff --git a/common/dmthin b/common/dmthin
> index 7946e9a7..28f2ef9c 100644
> --- a/common/dmthin
> +++ b/common/dmthin
> @@ -41,6 +41,12 @@ _dmthin_check_fs()
>  	_check_scratch_fs $DMTHIN_VOL_DEV
>  }
> =20
> +_dmthin_cycle_mount()
> +{
> +	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +	_dmthin_mount
> +}
> +
>  # Set up a dm-thin device on $SCRATCH_DEV
>  #
>  # All arguments are optional, and in this order; defaults follows:
> diff --git a/tests/generic/536 b/tests/generic/536
> new file mode 100755
> index 00000000..0e8d137e
> --- /dev/null
> +++ b/tests/generic/536
> @@ -0,0 +1,80 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. generic/536
> +#
> +# Test that intermittent IO errors during pwrite do not cause filesyst=
em corruption
> +
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +
> +status=3D1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +BACKING_SIZE=3D$((500 * 1024 * 1024 / 512))	# 500M
> +VIRTUAL_SIZE=3D$((10 * $BACKING_SIZE))		# 5000M
> +GROW_SIZE=3D$((100 * 1024 * 1024 / 512))		# 100M
> +
> +_cleanup()
> +{
> +	_dmthin_cleanup
> +	rm -f $tmp.*
> +}
> +
> +_setup_thin()
> +{
> +	_dmthin_init $BACKING_SIZE $VIRTUAL_SIZE
> +	_dmthin_set_queue
> +	_mkfs_dev $DMTHIN_VOL_DEV
> +	_dmthin_mount
> +}
> +
> +_workout()
> +{
> +	# Overfill it by a bit
> +	for I in `seq 1 500`; do
> +		$XFS_IO_PROG -f -c "pwrite -W 0 1M" $SCRATCH_MNT/file$I &>/dev/null
> +	done
> +
> +	sync
> +
> +	_dmthin_grow  $GROW_SIZE
> +
> +	# Write a little more, but don't fill
> +	for I in `seq 501 510`; do
> +		$XFS_IO_PROG -f -c "pwrite 0 1M" $SCRATCH_MNT/file$I &>/dev/null
> +	done
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/dmthin
> +
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch_nocheck
> +_require_dm_target thin-pool
> +
> +_setup_thin
> +
> +# trigger IO errors, the filesystem may be remounted RO or withdrawn, =
this is expected
> +_workout
> +
> +# now remount the filesystem without triggering IO errors,
> +# and check that the filesystem is not corrupt
> +_dmthin_cycle_mount
> +# ls --color makes ls stat each file, which finds the corruption
> +ls --color=3Dalways $SCRATCH_MNT/ >/dev/null || _fail "Failed to list =
filesystem after remount"
> +ls --color=3Dalways $SCRATCH_MNT/ >/dev/null || _fail "Failed to list =
filesystem after remount"
> +ls --color=3Dalways $SCRATCH_MNT/ >/dev/null || _fail "Failed to list =
filesystem after remount"
> +_dmthin_cleanup
> +
> +echo "=3D=3D=3D completed"
> +
> +status=3D0
> +exit
> diff --git a/tests/generic/536.out b/tests/generic/536.out
> new file mode 100644
> index 00000000..5140d261
> --- /dev/null
> +++ b/tests/generic/536.out
> @@ -0,0 +1,2 @@
> +QA output created by 536
> +=3D=3D=3D completed
> diff --git a/tests/generic/group b/tests/generic/group
> index 78b9b45d..a346dfab 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -538,3 +538,4 @@
>  533 auto quick attr
>  534 auto quick log
>  535 auto quick log
> +536 auto quick rw thin
> --=20
> 2.19.1
>=20
