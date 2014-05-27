Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:11399 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752197AbaE0Bmb (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 26 May 2014 21:42:31 -0400
Date: Tue, 27 May 2014 11:42:15 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfstests: test speculative preallocation reclaim on
 ENOSPC
Message-ID: <20140527014215.GA6677@dastard>
References: <1400849911-46606-1-git-send-email-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400849911-46606-1-git-send-email-bfoster@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Fri, May 23, 2014 at 08:58:31AM -0400, Brian Foster wrote:
> XFS can allocate significant amounts of space to files via speculative
> preallocation. Such preallocation may not be reclaimed automatically on
> file close() if a file is repeatedly opened and extended. For smaller
> filesystems with relatively large and slow growing files, this
> preallocation can linger for some time, including contributing to out of
> space conditions.
> 
> Create a situation where an fs is near out of space while several files
> still have lingering, significant preallocations. Verify that new
> writers reclaim the preallocated space rather than return ENOSPC.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> Hi all,
> 
> This test is associated with the recently posted eofblocks scan on
> ENOSPC series. It currently fails and should pass with the
> aforementioned patches applied. Thanks.
> 
> Brian
> 
>  tests/xfs/014     | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/014.out |  95 ++++++++++++++++++++++++++++++++++++
>  tests/xfs/group   |   1 +
>  3 files changed, 237 insertions(+)
>  create mode 100755 tests/xfs/014
>  create mode 100644 tests/xfs/014.out
> 
> diff --git a/tests/xfs/014 b/tests/xfs/014
> new file mode 100755
> index 0000000..53bc9e1
> --- /dev/null
> +++ b/tests/xfs/014
> @@ -0,0 +1,141 @@
> +#!/bin/bash
> +# FS QA Test No. xfs/014
> +#
> +# Test the behavior of XFS dynamic speculative preallocation at ENOSPC
> +# conditions. Speculative preallocation allocates post-EOF space to files as
> +# they are extended. This test creates conditions that bypass natural low space
> +# preallocation throttling and verifies that when no other space is available,
> +# writers reclaim the preallocated space and do not fail with premature ENOSPC.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2014 Red Hat, Inc.  All Rights Reserved.
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
> +#
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
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +_cleanup()
> +{
> +	cd /
> +	umount $SCRATCH_MNT 2>/dev/null
> +	rm -f $tmp.*
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# create a file that is likely to retain speculative preallocation after close
> +_spec_prealloc_file()
> +{
> +	file=$1
> +
> +	rm -f $file
> +
> +	# a few file extending open-write-close cycles should be enough to
> +	# trigger the fs to retain preallocation. write 256k in 32k intervals to
> +	# be sure
> +	for i in $(seq 0 32768 262144)
> +	do
> +		$XFS_IO_PROG -fc "pwrite $i 32k" $file | _filter_xfs_io
> +	done
> +
> +	# write a 4k aligned amount of data to keep the calculations simple
> +	$XFS_IO_PROG -c "pwrite 0 128m" $file | _filter_xfs_io
> +
> +	size=`stat -c "%s" $file`
> +	blocks=`stat -c "%b" $file`
> +	blocksize=`stat -c "%B" $file`
> +
> +	prealloc_size=$((blocks * blocksize - size))
> +	if [ $prealloc_size -eq 0 ]
> +	then
> +		echo "Warning: No speculative preallocation for $file." \
> +			"Check use of the allocsize= mount option."
> +	fi
> +
> +	# keep a running total of how much preallocation we've created
> +	TOTAL_PREALLOC=$((TOTAL_PREALLOC + prealloc_size))
> +}
> +
> +_consume_free_space()
> +{
> +	dir=$1
> +
> +	# calculate the rough amount of free space in MB
> +	fsblocksize=`$XFS_IO_PROG -x -c "statfs" $dir | grep f_bsize | \
> +			awk '{ print $3 }'`
> +	blocksavail=`$XFS_IO_PROG -x -c "statfs" $dir | grep f_bavail | \
> +			awk '{ print $3 }'`
> +	freesp=$((fsblocksize * blocksavail / 1024 / 1024))
> +
> +	# allocate all but 10MB
> +	freesp=$((freesp - 10))
> +	$XFS_IO_PROG -fc "falloc 0 ${freesp}M" $dir/spc
> +}
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_supported_os Linux
> +
> +_require_scratch
> +_require_xfs_io_command "falloc"
> +
> +rm -f $seqres.full
> +
> +# 10GB fs
> +_scratch_mkfs_xfs_opts "-d size=$((1024*1024*1024 * 10))" | \
> +	 _filter_mkfs 2>> $seqres.full

Which will fail on a few of my test machines because they only have
4GB scratch devices (ram disks).

What I think is better here is to use a sparse file on the scratch
device and mount via loopback. Most of the space is being used by
fallocate, so it will never get written. hence this test will fit in
most scratch devices without needing to worry about the size of the
filesystem being tested....

> +_scratch_mount
> +
> +# make sure the background eofblocks scanner doesn't interfere
> +orig_sp_time=`cat /proc/sys/fs/xfs/speculative_prealloc_lifetime`
> +echo 9999 > /proc/sys/fs/xfs/speculative_prealloc_lifetime
> +
> +# create a few files with relatively significant preallocation
> +TOTAL_PREALLOC=0
> +for i in $(seq 0 3)
> +do
> +	_spec_prealloc_file $SCRATCH_MNT/pre$i
> +done
> +
> +# consume most of the remaining free space in the fs to put us near ENOSPC
> +_consume_free_space $SCRATCH_MNT
> +
> +# start a few background writers to consume the bulk of the space that has been
> +# previously preallocated to other files. this space should be reclaimed such
> +# these writers complete without hitting ENOSPC
> +write_size=$((TOTAL_PREALLOC / 2 / 4))
> +for i in $(seq 0 3)
> +do
> +	$XFS_IO_PROG -fc "pwrite 0 $write_size" $SCRATCH_MNT/file.$i | \
> +		_filter_xfs_io &
> +done
> +wait
> +
> +echo $orig_sp_time > /proc/sys/fs/xfs/speculative_prealloc_lifetime
> +umount $SCRATCH_MNT

I'd recommend checking the filesystem here as well.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
