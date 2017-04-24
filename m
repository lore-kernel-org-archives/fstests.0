Received: from sandeen.net ([63.231.237.45]:38362 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S972118AbdDXTiE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 24 Apr 2017 15:38:04 -0400
Subject: Re: [PATCH] xfs/288: test xfs_growfs to ensure rejection if target
 isn't mounted
References: <20170424150935.28707-1-billodo@redhat.com>
 <20170424163450.GC5190@birch.djwong.org>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5cef928d-9840-6d5e-79e2-2b337a8fb0dd@sandeen.net>
Date: Mon, 24 Apr 2017 14:38:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170424163450.GC5190@birch.djwong.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Bill O'Donnell <billodo@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 4/24/17 11:34 AM, Darrick J. Wong wrote:
> On Mon, Apr 24, 2017 at 10:09:35AM -0500, Bill O'Donnell wrote:
>> The manpage for xfs_growfs specifies that the file/dir to be
>> grown must be mounted. This is a test to ensure that if the
>> target isn't mounted, the command is rejected. The test covers
>> absolute paths and relative paths, including symbolic links
>> and bind mounts.
>>
>> Signed-off-by: Bill O'Donnell <billodo@redhat.com>
>> ---
>>  tests/xfs/288     | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/xfs/288.out | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/xfs/group   |   1 +
>>  3 files changed, 241 insertions(+)
>>  create mode 100755 tests/xfs/288
>>  create mode 100644 tests/xfs/288.out
>>
>> diff --git a/tests/xfs/288 b/tests/xfs/288
>> new file mode 100755
>> index 0000000..628f753
>> --- /dev/null
>> +++ b/tests/xfs/288
>> @@ -0,0 +1,121 @@
>> +#! /bin/bash
>> +# FS QA Test 288
>> +#
>> +# Test to ensure xfs_growfs command rejects non-existent mount points
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +    umount $tmpdir
>> +    umount $tmpbind
>> +    rmdir $tmpdir
>> +    rm -f $tmpsymlink
>> +    rmdir $tmpbind
>> +    rm -f $tmp
>> +    rm -f $tmpfile
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs xfs
>> +_supported_os Linux
>> +_require_test
>> +_require_loop
>> +
>> +tmpfile=$TEST_DIR/fsfile
>> +tmpdir=$TEST_DIR/tmpdir
>> +tmpsymlink=$TEST_DIR/tmpsymlink.$$
>> +tmpbind=$TEST_DIR/tmpbind.$$
>> +
>> +mkdir -p $tmpdir || _fail "!!! failed to create temp mount dir"
>> +
>> +echo "=== mkfs.xfs ==="
>> +mkfs.xfs -d file,name=$tmpfile,size=64m -f
> 
> $MKFS_XFS_PROG -d file...
> 
>> +
>> +echo "=== truncate ==="
>> +truncate --size=128m $tmpfile
>> +
>> +echo "=== xfs_growfs - unmounted, command should be rejected ==="
>> +xfs_growfs $tmpdir
> 
> $XFS_GROWFS_PROG $tmpdir
> 
>> +
>> +echo "=== xfs_growfs - check relative path, unmounted ==="
>> +cd $TEST_DIR
>> +xfs_growfs ./tmpdir
>> +
>> +echo "=== xfs_growfs - no path, unmounted ==="
>> +cd $TEST_DIR
>> +xfs_growfs tmpdir
>> +
>> +echo "=== mount ==="
>> +mount -o loop $tmpfile $tmpdir || _fail "!!! failed to loopback mount"
>> +
>> +echo "=== xfs_growfs - mounted ==="
>> +xfs_growfs $tmpdir
>> +
>> +echo "=== xfs_growfs - check relative path ==="
>> +cd $TEST_DIR
>> +xfs_growfs ./tmpdir
> 
> So this growfs invocation should succeed, correct?  I see agcount
> doubling but $tmpfile doesn't get expanded... such that all the
> following growfses have no space to grow the fs, but they also don't
> spit out error messages.
> 
> (Just talking myself through this test...)

There may be no need to actually grow the filesystem to test this
behavior; nothing about this part of the tool differentiates between
xfs_growfs -n (information on current filesystem, no change) and
bare xfs_growfs (i.e. actually grow it ...) right?  And same man page
for both, specifying "shall be given a mount point to operate on."

> Also wondering if this test ought to keep expanding $testfile one AG at
> a time prior to every growfs test so that test success is keyed off of
> seeing a "data blocks changed from XXX to YYY" message, just in case the
> layout ever shifts...

*shrug* using xfs_growfs -n will test the "does it pass or fail based on
on whether it's given a mountpoint" and the actual geometry output won't
really matter much...

Growing it is fine too, but it may not be needed.  As long as it's consistent,
I think.

-Eric
