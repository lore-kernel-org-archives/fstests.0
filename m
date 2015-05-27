Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36231 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbbE0DeI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 26 May 2015 23:34:08 -0400
Date: Wed, 27 May 2015 11:34:04 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs: tests extent size hint size overflows
Message-ID: <20150527033404.GE3672@dhcp-13-216.nay.redhat.com>
References: <1432694617-23525-1-git-send-email-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432694617-23525-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 27, 2015 at 12:43:37PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> in certain cases, the extent size hints can cause maximum extent
> size overflows resulting in extent tree corruptions. This test
> exercises the original reproducer, and another corner case
> demonstrated to expose problems on 1k block size filesystems.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/xfs/074     | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/074.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 96 insertions(+)
>  create mode 100755 tests/xfs/074
>  create mode 100644 tests/xfs/074.out
> 
> diff --git a/tests/xfs/074 b/tests/xfs/074
> new file mode 100755
> index 0000000..810a1a0
> --- /dev/null
> +++ b/tests/xfs/074
> @@ -0,0 +1,93 @@
> +#! /bin/bash
> +# FS QA Test 074-extsz-hints-vs-maxextlen
> +#
> +# Check some extent size hint boundary conditions that can result in
> +# MAXEXTLEN overflows.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2015 Red Hat, Inc. All Rights Reserved.
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
> +_cleanup()
> +{
> +	cd /
> +	_destroy_loop_device $LOOP_DEV
> +	rm -f $tmp.* $LOOP_FILE
> +}
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_supported_os Linux
> +
> +rm -f $seqres.full
> +
> +_require_test
> +_require_xfs_io_command "falloc"
> +
> +# we use loop devices for this so that we can create large files for prealloc
> +# without having to care about the underlying device size.
> +_require_loop
> +
> +LOOP_FILE=$TESTDIR/$seq.img
> +LOOP_MNT=$TESTDIR/$seq.mnt

This should be $TEST_DIR, TESTDIR is empty and ends up in /074.mnt

> +mkdir -p $LOOP_MNT
> +$XFS_IO_PROG -ft -c "truncate 1t" $LOOP_FILE 2>&1 > $seqres.full

This will leave stderr to stdout, then only stdout goes to $seqres.full
I see "+ fallocate: No space left on device" when testing.

"command >$seqres.full 2>&1" will do the work.

> +LOOP_DEV=`_create_loop_device $LOOP_FILE`
> +
> +_mkfs_dev -d size=40051712b,agcount=4 -l size=32m $LOOP_DEV
> +_mount $LOOP_DEV $LOOP_MNT
> +
> +# Corrupt the BMBT by creating extents larger than MAXEXTLEN
> +$XFS_IO_PROG -ft \
> +	-c "extsize 16m" \
> +	-c "falloc 0 30g" \
> +	$LOOP_MNT/foo 2>&1 > $seqres.full

Here too, and should append to $seqres.full with ">>"

> +
> +umount $LOOP_MNT
> +_check_xfs_filesystem $LOOP_DEV none none

I think '_check_scratch_fs $LOOP_DEV' is eaiser, it accepts optional
device argument to check and deal with SCRATCH_LOG and SCRATCH_RT
internally.

> +
> +_mkfs_dev -f -l size=32m $LOOP_DEV
> +_mount $LOOP_DEV $LOOP_MNT
> +
> +# check we trim both ends of the extent approproiately; this will fail
> +# on 1k block size filesystems without the correct fixes in place.
> +$XFS_IO_PROG -ft \
> +	-c "extsize 1g" \
> +	-c "falloc 1023m 2g" \
> +	$LOOP_MNT/foo 2>&1 > $seqres.full

And here.

> +
> +umount $LOOP_MNT
> +_check_xfs_filesystem $LOOP_DEV none none
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/xfs/074.out b/tests/xfs/074.out
> new file mode 100644
> index 0000000..81a0d24
> --- /dev/null
> +++ b/tests/xfs/074.out
> @@ -0,0 +1,2 @@
> +QA output created by 074-extsz-hints-vs-maxextlen

This should be "QA output created by 074"

Thanks,
Eryu
> +Silence is golden
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 848a1bd..c211fc1 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -71,6 +71,7 @@
>  071 rw auto
>  072 rw auto prealloc quick
>  073 copy auto
> +074 quick auto prealloc rw
>  078 growfs auto quick
>  080 rw ioctl
>  081 deprecated # log logprint quota
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
