Received: from userp2130.oracle.com ([156.151.31.86]:40154 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfIZP5Y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Sep 2019 11:57:24 -0400
Date: Thu, 26 Sep 2019 08:55:13 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic: fallocate two bytes at block boundary
Message-ID: <20190926155513.GE9913@magnolia>
References: <20190926152927.2331-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926152927.2331-1-mreitz@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Max Reitz <mreitz@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 26, 2019 at 05:29:27PM +0200, Max Reitz wrote:
> Allocating two bytes at a block boundary with fallocate should allocate
> both blocks involved.  Test this by writing both bytes with dd
> afterwards and see whether the on-disk size increases (it should not).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/generic/568     | 63 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/568.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 66 insertions(+)
>  create mode 100755 tests/generic/568
>  create mode 100644 tests/generic/568.out
> 
> diff --git a/tests/generic/568 b/tests/generic/568
> new file mode 100755
> index 00000000..8fbdcda0
> --- /dev/null
> +++ b/tests/generic/568
> @@ -0,0 +1,63 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. generic/568
> +#
> +# Test that fallocating an unaligned range allocates all blocks
> +# touched by that range
> +#
> +seq=$(basename $0)
> +seqres="$RESULT_DIR/$seq"
> +echo "QA output created by $seq"
> +
> +here=$PWD
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f "$tmp".*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +
> +testfile="$SCRATCH_MNT/testfile"
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +# Fallocate 2 bytes across a block boundary
> +block_size=$(stat -fc '%S' "$SCRATCH_MNT")

block_size=$(_get_file_block_size $SCRATCH_MNT)

> +fallocate -o $((block_size - 1)) -l 2 "$testfile"

If you're going to use an external program, you need to gate the test on
whether or not the program's installed, by calling _require_command.

Though probably the easier way would be to use xfs_io since fstests
requires that xfsprogs be installed:

	$XFS_IO_PROG -f -c "falloc $((block_size - 1)) 2" $testfile

Though you do still have to put at the top of the test:

	_require_xfs_io_command "falloc"

Because not all filesystems support fallocate.

> +
> +# Both the first blocks should be allocated now.  Check that by
> +# inquiring whether the file grows when we write to the two bytes we
> +# have just fallocated.
> +
> +allocated_size_before=$(($(stat -c '%b * %B' "$testfile")))
> +
> +dd if=/dev/zero of="$testfile" bs=1 conv=notrunc \
> +    seek=$((block_size - 1)) count=2 \
> +    2>&1 | _filter_dd

$XFS_IO_PROG -c "pwrite $((block_size - 1)) 2" $testfile

> +
> +allocated_size_after=$(($(stat -c '%b * %B' "$testfile")))
> +
> +if [ $allocated_size_after -gt $allocated_size_before ]; then
> +	echo "ERROR: File grew from ${allocated_size_before} B to" \
> +	     "${allocated_size_after} when writing to the fallocated range."
> +else
> +	echo "OK: File did not grow."

Other than that, the logic makes sense to me.  Thanks for writing this
up!

--D

> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/568.out b/tests/generic/568.out
> new file mode 100644
> index 00000000..d8210882
> --- /dev/null
> +++ b/tests/generic/568.out
> @@ -0,0 +1,2 @@
> +QA output created by 568
> +OK: File did not grow.
> diff --git a/tests/generic/group b/tests/generic/group
> index 7cf4f6c4..24ab29bc 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -570,3 +570,4 @@
>  565 auto quick copy_range
>  566 auto quick quota metadata
>  567 auto quick rw punch
> +568 auto quick rw
> -- 
> 2.21.0
> 
