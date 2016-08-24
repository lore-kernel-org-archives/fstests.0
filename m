Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56370 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932407AbcHXSUe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Aug 2016 14:20:34 -0400
Subject: Re: [PATCH] btrfs/131: send test for rename+recycled ino
References: <1471974718-1430-1-git-send-email-jbacik@fb.com>
 <20160824095345.GS27776@eguan.usersys.redhat.com>
From: Josef Bacik <jbacik@fb.com>
Message-ID: <f76d7747-a653-98d3-f2d8-1bfd68cc0c58@fb.com>
Date: Wed, 24 Aug 2016 14:18:41 -0400
MIME-Version: 1.0
In-Reply-To: <20160824095345.GS27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 08/24/2016 05:53 AM, Eryu Guan wrote:
> On Tue, Aug 23, 2016 at 01:51:58PM -0400, Josef Bacik wrote:
>> This is a test for a problem I hit with send/receive.  If you mount with -o
>> inode_cache it is possible to recycle inode numbers, and btrfs assumes that when
>> you have a recycled inode number that it's parent directory won't be needing a
>> rename, but this is not the case.  Without the patch to fix this problem this
>> test will panic the box if ASSERT() is turned on, otherwise it'll simply fail
>> the fssum.
>>
>> Signed-off-by: Josef Bacik <jbacik@fb.com>
>> ---
>>  tests/btrfs/131     | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/btrfs/131.out |  2 ++
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 94 insertions(+)
>>  create mode 100644 tests/btrfs/131
>>  create mode 100644 tests/btrfs/131.out
>>
>> diff --git a/tests/btrfs/131 b/tests/btrfs/131
>> new file mode 100644
>> index 0000000..596adc1
>> --- /dev/null
>> +++ b/tests/btrfs/131
>> @@ -0,0 +1,91 @@
>> +#! /bin/bash
>> +# FS QA Test 131
>> +#
>> +# Make sure btrfs handles send/receive of a file that has been destroyed and
>> +# recreated with a recycled inode number and a renamed parent directory.  This
>> +# is a test for a fix based on the patch
>> +#
>
> A trailing whitespace in above line :)
>
>> +# Btrfs: handle pending renames with recycled inodes properly
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Facebook. All Rights Reserved.
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
>> +tmp=`mktemp -d`
>
> Usually we define "tmp=/tmp/$$", and tests and some common helpers use
> $tmp.xxx for tmp files. I think we should keep the consistency across
> tests.
>
> $tmp is used as a tmp dir to store the btrfs send data, I think we can
> send the data to some dir in $TEST_DIR, e.g.
>
> send_dir=$TEST_DIR/btrfs_send_$seq
>
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	rm -fr $tmp
>
> Then clean the send dir here, as well as $tmp.*
>
> 	cd /
> 	rm -rf $send_dir
> 	rm -f $tmp.*
>
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
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch
>> +_require_fssum
>> +
>> +_scratch_mkfs > /dev/null 2>&1
>> +_scratch_mount "-o inode_cache"
>
> Need some comments to explain why mount with "-o inode_cache" option.
>
>> +
>> +_run_btrfs_util_prog subvolume create $SCRATCH_MNT/base
>> +mkdir $SCRATCH_MNT/base/b
>> +mkdir $SCRATCH_MNT/base/a
>> +mv $SCRATCH_MNT/base/b $SCRATCH_MNT/base/a
>> +
>> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/base \
>> +	$SCRATCH_MNT/snap1
>> +_run_btrfs_util_prog send $SCRATCH_MNT/snap1 -f $tmp/1.snap
>> +
>> +mv $SCRATCH_MNT/base/a $SCRATCH_MNT/base/c
>> +rmdir $SCRATCH_MNT/base/c/b
>> +
>> +# We need to sync to make sure the inode number is recycled
>> +sync
>> +mkdir $SCRATCH_MNT/base/c/b
>> +
>> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/base $SCRATCH_MNT/snap2
>> +run_check $FSSUM_PROG -A -f -w $tmp/fssum $SCRATCH_MNT/snap2
>> +
>> +_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2 -f $tmp/2.snap
>> +
>> +_scratch_unmount
>> +_scratch_mkfs > /dev/null 2>&1
>> +_scratch_mount
>> +
>> +_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
>> +_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
>> +run_check $FSSUM_PROG -r $tmp/fssum $SCRATCH_MNT/snap2
>
> I did see assert failure (and kernel crash) on kernel with ASSERT turned
> on, but I didn't see fssum reporting failures on kernel with ASSERT
> turned off. Did I miss anything?
>
> [root@dhcp-66-86-11 xfstests]# ./check -s btrfs  btrfs/131
> SECTION       -- btrfs
> RECREATING    -- btrfs on /dev/sda5
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 dhcp-66-86-11 4.8.0-rc2
> MKFS_OPTIONS  -- /dev/sda6
> MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 /dev/sda6 /mnt/testarea/scratch
>
> btrfs/131 1s ... 1s
> Ran: btrfs/131
> Passed all 1 tests
>
> SECTION       -- btrfs
> =========================
> Ran: btrfs/131
> Passed all 1 tests
>

Huh I must have run when I had debugging stuff still in my script, you are right 
this does work fine with ASSERT()'s turned off.  That's fine, I still want to 
have this test here since it did trigger that ASSERT().  I'll go through and fix 
up the things you pointed out, thanks!

Josef

