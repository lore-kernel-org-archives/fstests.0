Received: from userp2130.oracle.com ([156.151.31.86]:39402 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeI3HRw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Sep 2018 03:17:52 -0400
Subject: Re: [PATCH v5] test unaligned punch hole at ENOSPC
References: <1538146248-1759-1-git-send-email-anand.jain@oracle.com>
 <1538182287-9297-1-git-send-email-anand.jain@oracle.com>
 <CAL3q7H5psaV-gXWRykvhvTdV8m7EtZi=O-x4-fepcpS1p7HNpQ@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <0f198429-f9ab-13d3-2d30-c0a65ee6c8b9@oracle.com>
Date: Sun, 30 Sep 2018 08:46:31 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5psaV-gXWRykvhvTdV8m7EtZi=O-x4-fepcpS1p7HNpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 09/30/2018 12:40 AM, Filipe Manana wrote:
> On Sat, Sep 29, 2018 at 1:52 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Try to punch hole with unaligned size and offset when the FS is
>> full. Mainly holes are punched at locations which are unaligned
>> with the file extent boundaries when the FS is full by data.
>> As the punching holes at unaligned location will involve
>> truncating blocks instead of just dropping the extents, it shall
>> involve reserving data and metadata space for delalloc and data
>> alloc fails as the FS is full.
>>
>> btrfs_punch_hole()
>>   btrfs_truncate_block()
>>     btrfs_check_data_free_space() <-- ENOSPC
>>
>> We don't fail punch hole if the holes are aligned with the file
>> extent boundaries as it shall involve just dropping the related
>> extents.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v4->v5:
>>   Update the change log
>>   Drop the directio option for xfs_io
> 
> Except for the direct IO and change log, all my previous comments and
> questions weren't addressed/ answered.
> Thanks.

Ah. Now I notice there were two emails, I completely missed the other 
email. Will review. Thanks for pointing out.

Thanks, Anand


>> v3->v4:
>>   Add to the group punch
>> v2->v3:
>>   Add _require_xfs_io_command "fpunch"
>>   Add more logs to $seqfull.full
>>     mount options and
>>     group profile info
>>   Add sync after dd upto ENOSPC
>>   Drop fallocate -p and use xfs_io punch to create holes
>>   Use a testfile instead of filler file so that easy to trace
>> v1->v2: Use at least 256MB to test.
>> This test case fails on btrfs as of now.
>>   tests/btrfs/172     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/172.out |  2 ++
>>   tests/btrfs/group   |  1 +
>>   3 files changed, 77 insertions(+)
>>   create mode 100755 tests/btrfs/172
>>   create mode 100644 tests/btrfs/172.out
>>
>> diff --git a/tests/btrfs/172 b/tests/btrfs/172
>> new file mode 100755
>> index 000000000000..1ecf01d862a2
>> --- /dev/null
>> +++ b/tests/btrfs/172
>> @@ -0,0 +1,74 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2018 Oracle. All Rights Reserved.
>> +#
>> +# FS QA Test 172
>> +#
>> +# Test if the unaligned (by size and offset) punch hole is successful when FS
>> +# is at ENOSPC.
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1       # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -f $tmp.*
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
>> +_require_xfs_io_command "fpunch"
>> +
>> +_scratch_mkfs_sized $((256 * 1024 *1024)) >> $seqres.full
>> +
>> +# max_inline helps to create regular extent
>> +_scratch_mount "-o max_inline=0,nodatacow"
>> +
>> +cat /proc/self/mounts | grep $SCRATCH_DEV >> $seqres.full
>> +$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
>> +
>> +extent_size=$(_scratch_btrfs_sectorsize)
>> +unalign_by=512
>> +echo extent_size=$extent_size unalign_by=$unalign_by >> $seqres.full
>> +
>> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 $((extent_size * 10))" \
>> +                                       $SCRATCH_MNT/testfile >> $seqres.full
>> +
>> +echo "Fill fs upto ENOSPC" >> $seqres.full
>> +dd status=none if=/dev/zero of=$SCRATCH_MNT/filler bs=512 >> $seqres.full 2>&1
>> +sync
>> +
>> +hole_offset=0
>> +hole_len=$unalign_by
>> +$XFS_IO_PROG -f -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
>> +
>> +hole_offset=$(($extent_size + $unalign_by))
>> +hole_len=$(($extent_size - $unalign_by))
>> +$XFS_IO_PROG -f -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
>> +
>> +hole_offset=$(($extent_size * 2 + $unalign_by))
>> +hole_len=$(($extent_size * 5))
>> +$XFS_IO_PROG -f -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
>> +
>> +# success, all done
>> +echo "Silence is golden"
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/172.out b/tests/btrfs/172.out
>> new file mode 100644
>> index 000000000000..ce2de3f0d107
>> --- /dev/null
>> +++ b/tests/btrfs/172.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 172
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index feffc45b6564..45782565c3b7 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -174,3 +174,4 @@
>>   169 auto quick send
>>   170 auto quick snapshot
>>   171 auto quick qgroup
>> +172 auto quick punch
>> --
>> 1.8.3.1
>>
> 
> 
