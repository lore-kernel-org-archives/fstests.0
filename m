Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:46820 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754429AbbFQVoQ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2015 17:44:16 -0400
Date: Thu, 18 Jun 2015 07:44:13 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic: busy loop of dd and rm test
Message-ID: <20150617214413.GH10224@dastard>
References: <1433983955-2591-1-git-send-email-wangyf-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433983955-2591-1-git-send-email-wangyf-fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Yanfeng <wangyf-fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 11, 2015 at 08:52:35AM +0800, Wang Yanfeng wrote:
> generic/326 is a case about testing whether writing failed on
> NO_SPACE in a busy loop of write and delete when disk almost full.
> It is a long-term problem since very beginning in btrfs, and has been
> fixed by patchset titled "btrfs: Fix no_space on dd and rm loop" from
> zhaolei@cn.fujitsu.com.
> 
> Signed-off-by: Wang Yanfeng <wangyf-fnst@cn.fujitsu.com>
....
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# FS QA Test No. 326
> +#
> +# TEST busy loop of write and delete in a filesystem.
> +# Sometimes writes will failed on NO_SPACE when disk almost full
> +# in btrfs. It is long-term problem since very beginning for btrfs
> +#
> +# This issue was fixed by the following linux kernel patch
> +#
> +# btrfs: Fix no_space on dd and rm loop < from zhaolei@cn.fujitsu.com >
> +#	btrfs: Fix NO_SPACE bug caused by delayed-iput
> +#	btrfs: Support busy loop of write and delete
> +#	btrfs: add WARN_ON() to check is space_info op current
> +#	btrfs: Set relative data on clear btrfs_block_group_cache->pinned
> +#	btrfs: Adjust commit-transaction condition to avoid NO_SPACE more
> +#	btrfs: Fix tail space processing in find_free_dev_extent()
> +#	btrfs: fix condition of commit transaction
> +#	btrfs: wait for delayed iputs on no space

This list of kernel commits does not belong in the test. If you
really need to put this anywhere, it belongs in the commit
message.

> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +status=1
> +trap "exit \$status" 0 1 2 3 15

Why did you remove the "tmp=/tmp/$$" line from the new test
template?

> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_need_to_be_root
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +
> +rm -f $seqres.full
> +
> +dev_size=$((512 * 1024 * 1024))

So a 512MB filesystem...

> +_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
> +_scratch_mount
> +file_size_m=$(($dev_size * 75 / 100 / 1024 / 1024))

and a ~400MB file, right? So you don't actually need this
magic calculation, because:

> +for ((i = 0; i < 10; i++)); do
> +	echo "loop $i" >>$seqres.full
> +
> +	dd if=/dev/zero of="$SCRATCH_MNT"/file0 bs=1M count="$file_size_m" \
> +	>>$seqres.full 2>&1 || _fail "dd failed"

You shouldn't be using dd for this, nor should you be using _fail:

	$XFS_IO_PROG -f -c "pwrite -b 1m 0 400m" $SCRATCH_MNT"/file0 | \
		_filter_xfs_io | _filter_scratch

If the write fails, then xfs_io will dump an unexpected error
message to the output, and the golden output mismatch will fail the
test.


> +	rm -f "$SCRATCH_MNT"/file0 || _fail "rm failed"

Same here - rm will output an error that will be caughti if it
fails...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
