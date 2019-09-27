Received: from mail-pg1-f195.google.com ([209.85.215.195]:46889 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfI0Bhy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Sep 2019 21:37:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so2505189pgm.13
        for <fstests@vger.kernel.org>; Thu, 26 Sep 2019 18:37:53 -0700 (PDT)
Date: Fri, 27 Sep 2019 09:37:46 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] generic: fallocate two bytes at block boundary
Message-ID: <20190927013744.GY2622@desktop>
References: <20190926165145.9161-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926165145.9161-1-mreitz@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Max Reitz <mreitz@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 26, 2019 at 06:51:45PM +0200, Max Reitz wrote:
> Allocating two bytes at a block boundary with fallocate should allocate
> both blocks involved.  Test this by writing data to both bytes
> afterwards and see whether the on-disk size increases (it should not).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

I notice that XFS fails this test with v5.3 kernel, so I guess this is a
targeted regression test? Do you have a (pending) patch/commit that
could be referenced in the commit log and/or test description? So we
could know which patch/commit fixed this particular failure.

> ---
> v2:
> - Use _get_file_block_size instead of manual stat -fc '%S'
> - Use xfs_io instead of fallocate/dd
>   (and require falloc support)
> - Add the ' B' that was missing as allocated_size_after's unit in the
>   error message
> ---
>  tests/generic/568     | 63 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/568.out |  4 +++
>  tests/generic/group   |  1 +
>  3 files changed, 68 insertions(+)
>  create mode 100755 tests/generic/568
>  create mode 100644 tests/generic/568.out
> 
> diff --git a/tests/generic/568 b/tests/generic/568
> new file mode 100755
> index 00000000..df67daf4
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
> +_require_xfs_io_command "falloc"
> +
> +testfile="$SCRATCH_MNT/testfile"
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount

Seems you don't need $SCRATCH_DEV at all. Just create the test file on
$TEST_DEV in $TEST_DIR, e.g.

testfile="$TEST_DIR"/falloctest-$seq
rm -f $testfile

> +
> +# Fallocate 2 bytes across a block boundary
> +block_size=$(_get_file_block_size "$SCRATCH_MNT")
> +$XFS_IO_PROG -f -c "falloc $((block_size - 1)) 2" "$testfile"
> +
> +# Both the first blocks should be allocated now.  Check that by
> +# inquiring whether the file grows when we write to the two bytes we
> +# have just fallocated.
> +
> +allocated_size_before=$(($(stat -c '%b * %B' "$testfile")))
> +
> +$XFS_IO_PROG -c "pwrite $((block_size - 1)) 2" "$testfile" \
> +	| _filter_xfs_io | sed -e "s/$((block_size - 1))/block_size - 1/"
> +
> +allocated_size_after=$(($(stat -c '%b * %B' "$testfile")))
> +
> +if [ $allocated_size_after -gt $allocated_size_before ]; then
> +	echo "ERROR: File grew from ${allocated_size_before} B to" \
> +	     "${allocated_size_after} B when writing to the fallocated range."
> +else
> +	echo "OK: File did not grow."
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/568.out b/tests/generic/568.out
> new file mode 100644
> index 00000000..435a9630
> --- /dev/null
> +++ b/tests/generic/568.out
> @@ -0,0 +1,4 @@
> +QA output created by 568
> +wrote 2/2 bytes at offset block_size - 1
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
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

Add 'prealloc' group as well.

Thanks for the test!

Eryu
> -- 
> 2.21.0
> 
