Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:8773 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751396AbaI2Dcr (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 28 Sep 2014 23:32:47 -0400
Date: Mon, 29 Sep 2014 13:32:44 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/053: test for stale data exposure via
 falloc/writeback interaction
Message-ID: <20140929033244.GL4758@dastard>
References: <1411756349-4537-1-git-send-email-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411756349-4537-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 26, 2014 at 02:32:29PM -0400, Brian Foster wrote:
> XFS buffered I/O writeback has a subtle race condition that leads to
> stale data exposure if the filesystem happens to crash after delayed
> allocation blocks are converted on disk and before data is written back
> to said blocks.
> 
> Use file allocation commands to attempt to reproduce a related, but
> slightly different variant of this problem. The associated falloc
> commands can lead to partial writeback that converts an extent larger
> than the range affected by falloc. If the filesystem crashes after the
> extent conversion but before all other cached data is written to the
> extent, stale data can be exposed.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> This fell out of a combination of a conversation with Dave about XFS
> writeback and buffer/cache coherency and some hacking I'm doing on the
> XFS zero range implementation. Note that fpunch currently fails the
> test. Also, this test is XFS specific primarily due to the use of
> godown.
.....
> +_crashtest()
> +{
> +	cmd=$1
> +	img=$SCRATCH_MNT/$seq.img
> +	mnt=$SCRATCH_MNT/$seq.mnt
> +	file=$mnt/file
> +
> +	# Create an fs on a small, initialized image. The pattern is written to
> +	# the image to detect stale data exposure.
> +	$XFS_IO_PROG -f -c "truncate 0" -c "pwrite 0 25M" $img \
> +		>> $seqres.full 2>&1
> +	$MKFS_XFS_PROG $MKFS_OPTIONS $img >> $seqres.full 2>&1
> +
> +	mkdir -p $mnt
> +	mount $img $mnt
> +
> +	echo $cmd
> +
> +	# write, run the test command and shutdown the fs
> +	$XFS_IO_PROG -f -c "pwrite -S 1 0 64k" -c "$cmd 60k 4k" $file | \
> +		_filter_xfs_io

So at this point the file is correctly 64k in size in memory.

> +	./src/godown -f $mnt

And here you tell godown to flush the log, so if there's a
transaction in the that sets the inode size to 64k.

> +	umount $mnt
> +	mount $img $mnt

Then log recovery will set the file size to 64k, and:

> +
> +	# we generally expect a zero-sized file (this should be silent)
> +	hexdump $file

This comment is not actually correct. I'm actually seeing 64k length
files after recovery in 2 of 3 cases being tested, so I don't think
this is a correct observation.

Some clarification of what is actually being tested is needed
here. 

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
