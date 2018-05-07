Received: from userp2130.oracle.com ([156.151.31.86]:44302 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeEGQyW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 May 2018 12:54:22 -0400
Date: Mon, 7 May 2018 09:54:18 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: test inobt/on disk free state mismatches
Message-ID: <20180507165418.GE4116@magnolia>
References: <20180506225352.4415-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506225352.4415-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 07, 2018 at 08:53:52AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Fuzzing has recently uncovered a couple of conditions where we don't
> detect corruptions that reallocate already allocated inodes. This
> test exercises those cases, and checks that we shut down the
> filesystem appropriately when such a corruption occurs.
> 
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/xfs/450     | 73 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/450.out | 26 +++++++++++++++++
>  tests/xfs/group   |  1 +
>  3 files changed, 100 insertions(+)
>  create mode 100755 tests/xfs/450
>  create mode 100644 tests/xfs/450.out
> 
> diff --git a/tests/xfs/450 b/tests/xfs/450
> new file mode 100755
> index 000000000000..bac001690d60
> --- /dev/null
> +++ b/tests/xfs/450
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# FS QA Test 450
> +#
> +# Catch inobt/on disk inode free state mismatches on V4 filesystems
> +#
> +#-----------------------------------------------------------------------
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
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +_supported_fs xfs
> +_supported_os Linux
> +
> +# we intentionally corrupt the filesystem, so don't check it after the test
> +_require_scratch_nocheck
> +
> +# on success, we'll get a shutdown filesystem with a really noisy log message
> +# due to transaction cancellation.  Hence we don't want to check dmesg here.
> +_disable_dmesg_check
> +
> +_require_xfs_mkfs_crc
> +_scratch_mkfs -m crc=0 > $seqres.full 2>&1

We require mkfs to support crc but then turn it off?  Seeing as this is
a v4 test I'd have expected this also to run on old xfsprogs that only
supports v4. <confused>

> +
> +# corrupt an inode in the root inode chunk
> +root_ino=`$XFS_DB_PROG -c "sb 0" -c "p rootino" $SCRATCH_DEV`

root_ino=$(_scratch_xfs_get_metadata_field 'rootino' 'sb 0')

(xfs_db gets cranky if you don't feed it the external log device)

> +corrupt_ino=$((root_ino + 15))
> +$XFS_DB_PROG -x -c "inode $corrupt_ino" -c "write core.mode 0100644" $SCRATCH_DEV

_scratch_xfs_set_metadata_field 'core.mode' 0100644 "inode $corrupt_ino"

--D

> +
> +_scratch_mount
> +
> +# The corrupt inode should be tripped over during these initial file creates.
> +touch $SCRATCH_MNT/file{0,1,2,3,4,5}{0,1,2,3,4,5} 2>&1 | _filter_scratch
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/450.out b/tests/xfs/450.out
> new file mode 100644
> index 000000000000..379a8d6f6ec9
> --- /dev/null
> +++ b/tests/xfs/450.out
> @@ -0,0 +1,26 @@
> +QA output created by 450
> +core.mode = 0100644
> +touch: cannot touch 'SCRATCH_MNT/file20': Structure needs cleaning
> +touch: cannot touch 'SCRATCH_MNT/file21': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file22': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file23': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file24': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file25': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file30': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file31': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file32': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file33': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file34': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file35': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file40': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file41': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file42': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file43': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file44': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file45': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file50': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file51': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file52': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file53': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file54': Input/output error
> +touch: cannot touch 'SCRATCH_MNT/file55': Input/output error
> diff --git a/tests/xfs/group b/tests/xfs/group
> index d62345fc8f96..aeb8ba963ade 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -440,5 +440,6 @@
>  441 auto quick clone quota
>  442 auto stress clone quota
>  443 auto quick ioctl fsr
> +450 auto quick 
>  444 auto quick
>  445 auto quick filestreams
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
