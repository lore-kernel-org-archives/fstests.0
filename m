Received: from mx1.redhat.com ([209.132.183.28]:57022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbdFBEh1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 2 Jun 2017 00:37:27 -0400
Date: Fri, 2 Jun 2017 12:37:25 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] btrfs/144: quota exhausts prematurely with direct I/O
Message-ID: <20170602043725.GE23805@eguan.usersys.redhat.com>
References: <20170601190348.7617-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170601190348.7617-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: fstests@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 01, 2017 at 02:03:48PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> While performing direct I/O in small blocksizes, the
> quota gets exhausted prematurely. In the test, we are
> trying to create ~180M file with a block size of 512 bytes
> using direct I/O on a subvolume which is allocated 200M.
> 
> This test is currently failing.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  tests/btrfs/144     | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/144.out |  3 +++
>  tests/btrfs/group   |  1 +
>  3 files changed, 74 insertions(+)
>  create mode 100755 tests/btrfs/144
>  create mode 100644 tests/btrfs/144.out
> 
> diff --git a/tests/btrfs/144 b/tests/btrfs/144
> new file mode 100755
> index 00000000..34156716
> --- /dev/null
> +++ b/tests/btrfs/144
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# FS QA Test 144
> +#
> +# Check if btrfs quota limits are not reached when direct writes
> +# are performed in small blocks.
> +#
> +# This test is currently failing.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 SUSE. All Rights Reserved.
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
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
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
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch

_require_odirect

> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +SUBVOL=$SCRATCH_MNT/subvol
> +
> +_run_btrfs_util_prog subvolume create $SUBVOL
> +_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +_run_btrfs_util_prog qgroup limit -e 200M $SUBVOL
> +
> +
> +# Direct write file within 200M limits
> +
> +dd if=/dev/zero of=$SUBVOL/file1 count=36000 bs=512 oflag=direct 

36000 * 512 => ~18M in size, you meant 360000 for ~180M?

And I guess this would fail if the underlying device is 4k-sector
device, bs should be determined by `_min_dio_alignment $SCRATCH_DEV`

And xfs_io is preferred,

$XFS_IO_PROG -fd -c "pwrite -b $bs 0 180M" $SUBVOL/file1 | _filter_xfs_io

But test still passed on 4.12-rc1 kernel even if I change file size to
180M, is this expected?

wrote 188743680/188743680 bytes at offset 0
180 MiB, 368640 ops; 0:05:41.00 (540.313 KiB/sec and 1080.6257 ops/sec)

Thanks,
Eryu

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/144.out b/tests/btrfs/144.out
> new file mode 100644
> index 00000000..49244bdb
> --- /dev/null
> +++ b/tests/btrfs/144.out
> @@ -0,0 +1,3 @@
> +QA output created by 144
> +36000+0 records in
> +36000+0 records out
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 6f19619e..1de7c161 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -145,3 +145,4 @@
>  141 auto quick
>  142 auto quick
>  143 auto quick
> +144 auto quick qgroup
> -- 
> 2.12.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
