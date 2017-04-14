Received: from mx1.redhat.com ([209.132.183.28]:34192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbdDNDum (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 13 Apr 2017 23:50:42 -0400
Date: Fri, 14 Apr 2017 11:50:40 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/288: test fragmented multi-fsb readdir
Message-ID: <20170414035040.GC8951@eguan.usersys.redhat.com>
References: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 13, 2017 at 03:28:02PM -0500, Eric Sandeen wrote:
> Test for the patch I just sent to the xfs list,
> xfs: handle array index overrun in xfs_dir2_leaf_readbuf()
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> the .out file is very big; We could probably live without
> it, since the test is just looking for a hang or a KASAN
> splat.

If failure is a hang, then I agree that probably we don't need the long
.out file :)

> 
> diff --git a/tests/xfs/288 b/tests/xfs/288
> new file mode 100755
> index 0000000..537b45b
> --- /dev/null
> +++ b/tests/xfs/288
> @@ -0,0 +1,119 @@
> +#! /bin/bash
> +# FS QA Test 288
> +#
> +# Test readdir on fragmented multi-fsb dir blocks
> +#
> +# If the readahead map ends with a partial multi-fsb dir
> +# block, the loop at the end of xfs_dir2_leaf_readbuf() may
> +# walk off the end of the mapping array, read garbage,
> +# corrupt the loop control counter, and never return.
> +#
> +# Failure is a hang; KASAN should also catch this.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
> +# Author: Eric Sandeen <sandeen@redhat.com>
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
> +# Modify as appropriate.
> +_supported_fs xfs
> +_supported_os Linux
> +_require_scratch
> +_require_test_program "punch-alternating"
> +
> +# We want to override mkfs with a very specific geometry
> +$MKFS_XFS_PROG -f -d size=512m -n size=8192 -i size=1024 $SCRATCH_DEV  \
> +	> $seqres.full 2>&1 || _fail "mkfs failed"

_scratch_mkfs "-d size=512m -n size=8192 -i size=1024" || _fail ...

should just do the work. If there's any mkfs options conflicts between
MKFS_OPTIONS and this local-specified mkfs options, _scratch_mkfs would
try mkfs again without MKFS_OPTIONS.

Or further, set MKFS_OPTIONS to empty before _scratch_mkfs call, if it's
not relevant in this test?

> +
> +_scratch_mount
> +
> +# Make a ton of mostly-empty inode clusters so we can always
> +# make more inodes
> +mkdir $SCRATCH_MNT/tmp
> +for I in `seq 1 10000`; do touch $SCRATCH_MNT/tmp/$I; done

"echo > somefile" might be faster. Replace all touch with echo in this
test?

> +
> +# These mostly-empty clusters will live here:
> +mkdir $SCRATCH_MNT/clusters
> +for I in `seq 1 32 10000`; do
> +	mv $SCRATCH_MNT/tmp/$I $SCRATCH_MNT/clusters;
> +done
> +rm -rf $SCRATCH_MNT/tmp
> +
> +# Make our test dir with a couple blocks, should be contiguous
> +mkdir $SCRATCH_MNT/testdir
> +# roughly 20 chars per file
> +for I in `seq 1 100`; do
> +	touch $SCRATCH_MNT/testdir/12345678901234567890$I;
> +done
> +
> +# Now completely fragment freespace.
> +# Consume most of it:
> +xfs_io -f -c "falloc 0 400m" $SCRATCH_MNT/fillfile ||
> +	_fail "Could not allocate space"
> +
> +# File to fragment:
> +xfs_io -f -c "falloc 0 70m" $SCRATCH_MNT/fragfile ||
> +	_fail "Could not allocate space"

s/xfs_io/$XFS_IO_PROG/

And I think we can continue the test even if falloc failed, no harm to
run more tests in this 'error' path.

> +
> +df -h $SCRATCH_MNT > $seqres.full 2>&1
> +
> +# Fill remaining space; let this run to failure
> +dd if=/dev/zero of=$SCRATCH_MNT/spacefile1 oflag=direct > $seqres.full 2>&1
> +# Fragment our all-consuming file
> +./src/punch-alternating $SCRATCH_MNT/fragfile > $seqres.full 2>&1
> +
> +# Punching might have freed up large-ish swaths of metadata
> +# Consume hopefully any remaining contiguous freespace
> +# (and then some for good measure)
> +dd if=/dev/zero of=$SCRATCH_MNT/spacefile2 bs=1M count=64 > $seqres.full 2>&1
> +xfs_io -c fsync $SCRATCH_MNT/spacefile2 > $seqres.full 2>&1
> +
> +# Now populate the directory so that it must allocate these
> +# fragmented blocks
> +for I in `seq 1 1400`;
> +	do touch $SCRATCH_MNT/testdir/12345678901234567890$I;

Place "do" at the end of last line?

> +done
> +
> +# Now traverse that ugly thing!
> +find $SCRATCH_MNT/testdir
> +

If we want to verify we get all the right files back from testdir,
probably we can take an md5 checksum of the find output, instead of
dumping all these files. (not tested, but I think should work)

find $SCRATCH_MNT/testdir | sort | _filter_scratch | md5sum

Thanks,
Eryu
