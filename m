Received: from userp2120.oracle.com ([156.151.31.85]:36672 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeBWVyY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Feb 2018 16:54:24 -0500
Date: Fri, 23 Feb 2018 13:54:20 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/444: test log replay after XFS_IOC_SWAPEXT
Message-ID: <20180223215420.GE14582@magnolia>
References: <9227d8db-faf6-5c19-239b-074c7f5cfc00@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9227d8db-faf6-5c19-239b-074c7f5cfc00@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 23, 2018 at 12:33:41PM -0600, Eric Sandeen wrote:
> This is a mashup of xfs/042 and some of the log replay tests;
> it checks whether the log can be replayed if we crash immediately
> after an xfs_fsr / XFS_IOC_SWAPEXT.
> 
> Hint: it can't.  It fails because the temporary donor inode has
> been deleted and has invalid mode 0 when we try to replay its
> swapext operation.  Kernel patches to fix it will follow soon.

Hmm, does this filesystem have rmap enabled or not?

Different swapext strategy in play depending on the answer to that
question.

Maybe I should wait for patches to show up. :P

--D

> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/tests/xfs/444 b/tests/xfs/444
> new file mode 100755
> index 0000000..e88438a
> --- /dev/null
> +++ b/tests/xfs/444
> @@ -0,0 +1,144 @@
> +#! /bin/bash
> +# FS QA Test No. 444
> +#
> +# xfs_fsr QA tests
> +# create a large fragmented file and check that xfs_fsr doesn't 
> +# produce an unreplayable log after an unclean shutdown.
> +#
> +# Copied from xfs/042
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
> +# Copyright (c) 2018 Red Hat, Inc.  All Rights Reserved.
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
> +set +x
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +
> +_cleanup()
> +{
> +    _scratch_unmount
> +    rm -f $tmp.*
> +}
> +trap "_cleanup ; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_supported_os Linux
> +
> +_require_scratch
> +
> +[ "$XFS_FSR_PROG" = "" ] && _notrun "xfs_fsr not found"
> +
> +# Test performs several operations to produce a badly fragmented file, then
> +# create enough contiguous free space for xfs_fsr to defragment the fragmented
> +# file:
> +#
> +# - create fs with 3 minimum sized (16Mb) allocation groups
> +# - create 16x1MB contiguous files which will become large free space extents
> +#   when deleted
> +# - put a small "space" between each of the 16 contiuguous files to ensure we
> +#   have separated free space extents
> +# - fill the remaining free space with a "fill file"
> +# - mount/unmount/fill remaining free space with a pad file
> +# - punch alternate single block holes in the the "fill file" to create
> +#   fragmented free space.
> +# - use fill2 to generate a very large fragmented file
> +# - delete the 16 large contiguous files created initially
> +# - run xfs_fsr on the filesystem
> +# - check checksums for remaining files
> +
> +rm -f $seqres.full
> +_do_die_on_error=message_only
> +
> +echo -n "Make a 48 megabyte filesystem on SCRATCH_DEV and mount... "
> +_scratch_mkfs_xfs -dsize=48m,agcount=3 2>&1 >/dev/null || _fail "mkfs failed"
> +_scratch_mount || _fail "mount failed" 
> +
> +echo "done"
> +
> +echo -n "Reserve 16 1Mb unfragmented regions... "
> +for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
> +do
> +	_do "$XFS_IO_PROG -f -c \"resvsp 0 1m\" $SCRATCH_MNT/hole$i"
> +	_do "$XFS_IO_PROG -f -c \"resvsp 0 4k\" $SCRATCH_MNT/space$i"
> +	_do "xfs_bmap -vp $SCRATCH_MNT/hole$i"
> +done
> +echo "done" 
> +
> +# set up filesystem
> +echo -n "Fill filesystem with fill file... "
> +for i in `seq 0 1 31`; do
> +	_do "$XFS_IO_PROG -f -c \"falloc ${i}m 1m\" $SCRATCH_MNT/fill"
> +done
> +_do "xfs_bmap -vp $SCRATCH_MNT/fill"
> +echo "done"
> +# flush the filesystem - make sure there is no space "lost" to pre-allocation
> +_do "_scratch_unmount"
> +_do "_scratch_mount"
> +echo -n "Use up any further available space... "
> +_do "$XFS_IO_PROG -f -c \"falloc 0 1m\" $SCRATCH_MNT/pad"
> +echo "done"
> +
> +# create fragmented file
> +#_do "Delete every second file" "_cull_files"
> +echo -n "Punch every second 4k block... "
> +for i in `seq 0 8 32768`; do
> +	# This generates excessive output that significantly slows down the
> +	# test. It's not necessary for debug, so just bin it.
> +	$XFS_IO_PROG -f -c "unresvsp ${i}k 4k" $SCRATCH_MNT/fill \
> +								> /dev/null 2>&1
> +done
> +_do "xfs_bmap -vp $SCRATCH_MNT/fill"
> +_do "sum $SCRATCH_MNT/fill >$tmp.fillsum1"
> +echo "done"
> +
> +echo -n "Create one very large file... "
> +_do "src/fill2 -d nbytes=16000000,file=$SCRATCH_MNT/fragmented"
> +echo "done"
> +_do "xfs_bmap -v $SCRATCH_MNT/fragmented"
> +_do "sum $SCRATCH_MNT/fragmented >$tmp.sum1"
> +_do "Remove other files" "rm -rf $SCRATCH_MNT/{pad,hole*}"
> +
> +# defragment
> +_do "Run xfs_fsr on filesystem" "$XFS_FSR_PROG -v $SCRATCH_MNT/fragmented"
> +_do "xfs_bmap -v $SCRATCH_MNT/fragmented"
> +
> +echo "godown"
> +src/godown -v -f $SCRATCH_MNT >> $seqres.full
> +
> +echo "unmount"
> +_scratch_unmount
> +
> +echo "mount with replay"
> +_scratch_mount $mnt >>$seqres.full 2>&1 \
> +    || _fail "mount failed: $mnt $MOUNT_OPTIONS"
> +
> +# success, all done
> +echo "xfs_fsr tests passed."
> +status=0 ; exit
> diff --git a/tests/xfs/444.out b/tests/xfs/444.out
> new file mode 100644
> index 0000000..a0e7cd5
> --- /dev/null
> +++ b/tests/xfs/444.out
> @@ -0,0 +1,13 @@
> +QA output created by 444
> +Make a 48 megabyte filesystem on SCRATCH_DEV and mount... done
> +Reserve 16 1Mb unfragmented regions... done
> +Fill filesystem with fill file... done
> +Use up any further available space... done
> +Punch every second 4k block... done
> +Create one very large file... done
> +Remove other files... done
> +Run xfs_fsr on filesystem... done
> +godown
> +unmount
> +mount with replay
> +xfs_fsr tests passed.
> diff --git a/tests/xfs/group b/tests/xfs/group
> index e2397fe..85033b5 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -441,3 +441,4 @@
>  441 auto quick clone quota
>  442 auto stress clone quota
>  443 auto quick ioctl fsr
> +444 auto quick fsr log
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
