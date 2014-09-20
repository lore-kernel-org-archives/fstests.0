Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:56249 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751292AbaITXpE (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 20 Sep 2014 19:45:04 -0400
Date: Sun, 21 Sep 2014 09:45:00 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/062: add xfs unwritten extent data corruption
 reproducer
Message-ID: <20140920234500.GK4267@dastard>
References: <1411150385-32121-1-git-send-email-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411150385-32121-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 19, 2014 at 02:13:05PM -0400, Brian Foster wrote:
> XFS had a data corruption problem where writeback of pages to unwritten
> extents would fail to run unwritten extent conversion at I/O completion.
> This causes subsequent reads of written, but unconverted regions to
> return zeroes. This occurs on sub-page block size filesystems when
> writeback contends for the inode lock (e.g., with a file writer).
> 
> Add a test that creates the conditions to reproduce the data corruption
> and detect it by looking for unwritten extents after all said extents
> have been overwritten.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> Hi all,
> 
> Here's a test for the data corruption issue I sent a fix for yesterday:
> 
> 	http://oss.sgi.com/archives/xfs/2014-09/msg00259.html
> 
> It took a little time to improve the effectiveness of the test, but I've
> been able to run it in current form for 90+ iterations without a false
> negative (e.g., test passes when it shouldn't) on my setup. It runs in
> ~30s when there is no failure.
> 
> Brian
> 
>  tests/xfs/062     | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/062.out |   5 +++
>  tests/xfs/group   |   1 +
>  3 files changed, 120 insertions(+)
>  create mode 100755 tests/xfs/062
>  create mode 100644 tests/xfs/062.out

There's nothing XFS specific about this test. Yes, it exposes a bug
on XFS, but every filesystem should be able to run and pass this
test.

> 
> diff --git a/tests/xfs/062 b/tests/xfs/062
> new file mode 100755
> index 0000000..61f8cf4
> --- /dev/null
> +++ b/tests/xfs/062
> @@ -0,0 +1,114 @@
> +#! /bin/bash
> +# FS QA Test No. 062
> +#
> +# This test implements a data corruption scenario on XFS filesystems with
> +# sub-page sized blocks and unwritten extents. Inode lock contention during
> +# writeback of pages to unwritten extents leads to failure to convert those
> +# extents on I/O completion. This causes data corruption as unwritten extents
> +# are always read back as zeroes.
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
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15

Always need to set $tmp here. It's used by things like
_scratch_mkfs.

> +
> +_cleanup()
> +{
> +	cd /
> +	kill -9 $syncpid > /dev/null 2>&1

wait
rm -f $tmp.*

> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/punch
> +
> +# real QA test starts here
> +
> +_syncloop()
> +{
> +	while [ true ]
> +	do
> +		sync
> +	done

while [....]; do
	.....
done

> +}
> +
> +# Modify as appropriate.
> +_supported_fs xfs
> +_supported_os Linux
> +_require_scratch
> +_require_xfs_io_command "falloc"

_require_xfs_io_command "fiemap"

> +
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount
> +
> +# run background sync thread
> +_syncloop &
> +syncpid=$!
> +
> +for iters in $(seq 1 100)
> +do
> +	rm -f $SCRATCH_MNT/file
> +
> +	# create a delalloc block in each page of the first 64k of the file
> +	for pgoff in $(seq 0 0x1000 0xf000)
> +	do
> +		offset=$((pgoff + 0xc00))
> +		$XFS_IO_PROG -fc "pwrite $offset 0x1" $SCRATCH_MNT/file \
> +			 > /dev/null 2>&1
> +	done

	for .... ; do
		.....
	done

is the normal way of doing this. Also it's worth splitting the
xfs_io command across multiple lines as you have done later on to
make it more readable. Maybe, also, redirect the output to
$seqres.full so it's there for debugging failures rather than
/dev/null.

> +
> +	# preallocate the first 64k and overwite, writing past 64k to contend
> +	# with writeback
> +	$XFS_IO_PROG \
> +		-c "falloc 0 0x10000"	\
> +		-c "pwrite 0 0x100000"	\
> +		-c "fsync"		\
> +		$SCRATCH_MNT/file > /dev/null 2>&1
> +
> +	# Check for unwritten extents. We should have none since we wrote over
> +	# the entire preallocated region and ran fsync.
> +	xfs_bmap -v $SCRATCH_MNT/file | _filter_bmap | grep unwritten \
> +		> /dev/null 2>&1

Use $XFS_IO_PROG -c "fiemap -v" and dump the output to $seqres.full.

> +	if [ $? == 0 ]
> +	then
> +		xfs_bmap -v $SCRATCH_MNT/file
> +		break
> +	fi

	if [...]; then.

That's also a failure, right? So shouldn't it set status=1 and exit,
leaving the cleanup function to kill and wait for everything to
finish?

> +done
> +
> +echo $iters iterations
> +
> +kill $syncpid
> +wait
> +
> +# clear page cache and dump the file
> +_scratch_unmount
> +_scratch_mount

_scratch_remount

> +hexdump $SCRATCH_MNT/file
> +
> +_scratch_unmount
> +_check_scratch_fs

Don't need to do that anymore.

> +
> +status=0
> +exit
> diff --git a/tests/xfs/062.out b/tests/xfs/062.out
> new file mode 100644
> index 0000000..420f2e4
> --- /dev/null
> +++ b/tests/xfs/062.out
> @@ -0,0 +1,5 @@
> +QA output created by 062
> +100 iterations
> +0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
> +*
> +0100000
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 09bce15..685cbe7 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -57,6 +57,7 @@
>  059 dump ioctl auto quick
>  060 dump ioctl auto quick
>  061 dump ioctl auto quick
> +062 auto quick

and the rw group, too.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
