Received: from aserp1040.oracle.com ([141.146.126.69]:19885 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdGMQsK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jul 2017 12:48:10 -0400
Date: Thu, 13 Jul 2017 09:45:28 -0700
From: Liu Bo <bo.li.liu@oracle.com>
Subject: Re: [PATCH] btrfs: test direct IO write against raid5/6 filesystems
Message-ID: <20170713164527.GF12913@lim.localdomain>
Reply-To: bo.li.liu@oracle.com
References: <20170713141040.2341-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170713141040.2341-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 13, 2017 at 03:10:40PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that a direct IO write works against raid5/6 filesystems and that
> after the write operation we are able to read back the correct data
> and scrub operations don't find any errors.
> 
> This test is motivated by a regression introduced in the merge window
> for the 4.13 linux kernel, which was undetected by the current set of
> test cases. The issue is fixed by the following patch:
> 
>   "Btrfs: fix write corruption due to bio cloning on raid5/6"
> 

Thanks for the testcase.

Reviewed-by: Liu Bo <bo.li.liu@oracle.com>

-liubo
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/148     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/148.out | 23 +++++++++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 109 insertions(+)
>  create mode 100755 tests/btrfs/148
>  create mode 100644 tests/btrfs/148.out
> 
> diff --git a/tests/btrfs/148 b/tests/btrfs/148
> new file mode 100755
> index 00000000..45aa577a
> --- /dev/null
> +++ b/tests/btrfs/148
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# FS QA Test No. btrfs/148
> +#
> +# Test that direct IO writes work on RAID5 and RAID6 filesystems.
> +#
> +#-----------------------------------------------------------------------
> +#
> +# Copyright (C) 2017 SUSE Linux Products GmbH. All Rights Reserved.
> +# Author: Filipe Manana <fdmanana@suse.com>
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
> +# real QA test starts here
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_scratch_dev_pool 4
> +
> +_scratch_dev_pool_get 4
> +
> +rm -f $seqres.full
> +
> +test_direct_io_write()
> +{
> +	local mkfs_options=$1
> +
> +	_scratch_pool_mkfs $mkfs_options >>$seqres.full 2>&1
> +	_scratch_mount
> +
> +	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo \
> +		| _filter_xfs_io
> +
> +	# Now read back the same data, we expect to get what we wrote before.
> +	echo "File data after direct IO write:"
> +	od -t x1 $SCRATCH_MNT/foo | _filter_scratch
> +	_scratch_cycle_mount
> +	echo "File data after umounting and mounting again the filesystem:"
> +	od -t x1 $SCRATCH_MNT/foo | _filter_scratch
> +
> +	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> +	if [ $? -ne 0 ]; then
> +		echo "Scrub found errors" | tee -a $seqres.full
> +	fi
> +
> +	_scratch_unmount
> +}
> +
> +echo "Testing RAID5..."
> +test_direct_io_write "-m raid5 -d raid5"
> +echo "Testing RAID6..."
> +test_direct_io_write "-m raid6 -d raid6"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/148.out b/tests/btrfs/148.out
> new file mode 100644
> index 00000000..c4178f66
> --- /dev/null
> +++ b/tests/btrfs/148.out
> @@ -0,0 +1,23 @@
> +QA output created by 148
> +Testing RAID5...
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +File data after direct IO write:
> +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +4000000
> +File data after umounting and mounting again the filesystem:
> +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +4000000
> +Testing RAID6...
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +File data after direct IO write:
> +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +4000000
> +File data after umounting and mounting again the filesystem:
> +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +4000000
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 2eb540e7..eb4cb653 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -150,3 +150,4 @@
>  145 auto quick send
>  146 auto quick
>  147 auto quick send
> +148 auto quick
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
