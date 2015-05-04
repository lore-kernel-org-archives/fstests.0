Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:63473 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282AbbEDGkZ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 4 May 2015 02:40:25 -0400
Date: Mon, 4 May 2015 16:39:52 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/326: basic copy_file_range() correctness
Message-ID: <20150504063952.GG15810@dastard>
References: <1428709268-27499-1-git-send-email-zab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1428709268-27499-1-git-send-email-zab@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zach Brown <zab@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 10, 2015 at 04:41:08PM -0700, Zach Brown wrote:
> Add basic tests for the copy_file_range() syscall that's being
> developed.  This relies on having added copy_file_range() support to
> xfs_io in xfsprogs.
> 
> This is a very rough draft.  Feedback welcome!
> 
> Signed-off-by: Zach Brown <zab@redhat.com>
> ---
>  tests/generic/326   | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/group |  1 +

Missing the golden output file.

> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_supported_os Linux
> +_require_test

_require_xfs_io_command copy_file_range

> +
> +src="$TEST_DIR/src"
> +dst="$TEST_DIR/dst"

Seeing this is on the test device, the files may already exist so
you should remove them to give us a known good starting point.

Also, add $seq to the filename so that we know what test created the
files.

> +$XFS_IO_PROG -ftc "pwrite -S 0x12 0 128k" "$src" | _filter_xfs_io

Add a "-c fsync" to ensure the file is on disk.

> +od -x "$src"

I'd just md5sum the file; if there's a mismatch, the dev can then
look at it in more detail...

> +echo "extend destination file"
> +$XFS_IO_PROG -ftc "copy_file_range -i $src -s 0 -t 0 $((128 * 1024))" "$dst" \
> +	| _filter_xfs_io

-t 0 128k ?

Also, the truncate of the destination file is not obvious here,
which is another good reason to rm -rf to begin with.
> +od -x "$dst"


> +echo "copy into previously written region"
> +$XFS_IO_PROG -ft -c "pwrite -S 0xef 0 128k" "$dst" \
> +	-c "copy_file_range -i $src -s 0 -t 0 $((128 * 1024))" \
> +	| _filter_xfs_io
> +od -x "$dst"

The truncate makes this a write into a delalloc region.

Add a fsync after the write to make it a copy into a written region.

> +echo "copy into fallocate"
> +$XFS_IO_PROG -ft -c "falloc 0 128k" "$dst" \
> +	-c "copy_file_range -i $src -s 0 -t 0 $((128 * 1024))" \
> +	| _filter_xfs_io
> +od -x "$dst"

"copy into preallocated region"

> +echo "copy from likely sparse source"
> +$XFS_IO_PROG -ft -c "pwrite -S 0x56 96k 32k" "$src"  \
> +	-c "pwrite -S 0x34 0 32k" | _filter_xfs_io

fsync.

> +$XFS_IO_PROG -ftc "copy_file_range -i $src -s 0 -t 0 $((128 * 1024))" "$dst" \
> +	| _filter_xfs_io
> +od -x "$dst"
> +
> +echo "source at eof"
> +$XFS_IO_PROG -ftc \
> +	"copy_file_range -i $src -s $((128 * 1024)) -t 0 $((128 * 1024))" \
> +	"$dst" | _filter_xfs_io

What is this supposed to leave? An empty file? If so, md5sum will
still verify that...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
