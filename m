Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:29964 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752782AbeEGWhP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 May 2018 18:37:15 -0400
Date: Tue, 8 May 2018 08:37:12 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: test inobt/on disk free state mismatches
Message-ID: <20180507223711.GI10363@dastard>
References: <20180506225352.4415-1-david@fromorbit.com>
 <20180507165418.GE4116@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507165418.GE4116@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 07, 2018 at 09:54:18AM -0700, Darrick J. Wong wrote:
> On Mon, May 07, 2018 at 08:53:52AM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Fuzzing has recently uncovered a couple of conditions where we don't
> > detect corruptions that reallocate already allocated inodes. This
> > test exercises those cases, and checks that we shut down the
> > filesystem appropriately when such a corruption occurs.
> > 
> > Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> > ---
> >  tests/xfs/450     | 73 +++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/450.out | 26 +++++++++++++++++
> >  tests/xfs/group   |  1 +
> >  3 files changed, 100 insertions(+)
> >  create mode 100755 tests/xfs/450
> >  create mode 100644 tests/xfs/450.out
> > 
> > diff --git a/tests/xfs/450 b/tests/xfs/450
> > new file mode 100755
> > index 000000000000..bac001690d60
> > --- /dev/null
> > +++ b/tests/xfs/450
> > @@ -0,0 +1,73 @@
> > +#! /bin/bash
> > +# FS QA Test 450
> > +#
> > +# Catch inobt/on disk inode free state mismatches on V4 filesystems
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2018 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#-----------------------------------------------------------------------
> > +#
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs xfs
> > +_supported_os Linux
> > +
> > +# we intentionally corrupt the filesystem, so don't check it after the test
> > +_require_scratch_nocheck
> > +
> > +# on success, we'll get a shutdown filesystem with a really noisy log message
> > +# due to transaction cancellation.  Hence we don't want to check dmesg here.
> > +_disable_dmesg_check
> > +
> > +_require_xfs_mkfs_crc
> > +_scratch_mkfs -m crc=0 > $seqres.full 2>&1
> 
> We require mkfs to support crc but then turn it off?  Seeing as this is
> a v4 test I'd have expected this also to run on old xfsprogs that only
> supports v4. <confused>

Yup, copied that from another test that does exactly the same thing.
We have to do that to build v4 filesystems on modern xfsprogs that
default to v5, but using -m crc without a check for that
functionality will break the test on older xfsprogs....

> > +
> > +# corrupt an inode in the root inode chunk
> > +root_ino=`$XFS_DB_PROG -c "sb 0" -c "p rootino" $SCRATCH_DEV`
> 
> root_ino=$(_scratch_xfs_get_metadata_field 'rootino' 'sb 0')

Oh, didn't know that existed.

> > +corrupt_ino=$((root_ino + 15))
> > +$XFS_DB_PROG -x -c "inode $corrupt_ino" -c "write core.mode 0100644" $SCRATCH_DEV
> 
> _scratch_xfs_set_metadata_field 'core.mode' 0100644 "inode $corrupt_ino"

ditto.  Will fix.

Cheers,

dave.
-- 
Dave Chinner
david@fromorbit.com
