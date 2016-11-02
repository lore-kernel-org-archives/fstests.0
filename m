Received: from cn.fujitsu.com ([59.151.112.132]:63546 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752046AbcKBKbN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Nov 2016 06:31:13 -0400
Subject: Re: [PATCH] generic: create and delete files repeatedly to exercise
 ENOSPC behaviour
References: <1477999170-20026-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
 <20161102012713.GE9920@dastard>
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Message-ID: <5819BEE2.6040201@cn.fujitsu.com>
Date: Wed, 2 Nov 2016 18:24:34 +0800
MIME-Version: 1.0
In-Reply-To: <20161102012713.GE9920@dastard>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

hi,

On 11/02/2016 09:27 AM, Dave Chinner wrote:
> On Tue, Nov 01, 2016 at 07:19:30PM +0800, Wang Xiaoguang wrote:
>> In btrfs, sometimes though the number of created files' consumed disk space
>> are not larger than fs's free space, we can still get some ENOSPC error, it
>> may be that btrfs does not try hard to reclaim disk space(I have sent kernel
>> patch to resolve this kind of enospc error. Note, this false enospc error
>> will not always happen even in kernel without my fixing patch).
>>
>> Currently only in btrfs, I get this ENOSPC error, xfs and ext4 work well.
> .....
>> +RUN_TIME=$((600 * $TIME_FACTOR))
>> +fs_size=$((15 * 1024 * 1024 * 1024))
>> +_scratch_mkfs_sized $fs_size > $seqres.full 2>&1
>> +_scratch_mount > $seqres.full 2>&1
>> +
>> +testfile1=$SCRATCH_MNT/testfile1
>> +testfile2=$SCRATCH_MNT/testfile2
>> +filesize1=$(((fs_size * 80) / 100))
>> +filesize2=$(((fs_size * 5) / 100))
>> +
>> +do_test()
>> +{
>> +	while [ -f $SCRATCH_MNT/run ]; do
>> +		$XFS_IO_PROG -fc "pwrite 0 $filesize1" $testfile1 > /dev/null
>> +		$XFS_IO_PROG -fc "pwrite 0 $filesize2" $testfile2 > /dev/null
>> +		rm -f $testfile1 $testfile2
>> +	done
>> +}
> What are you trying to test here that other ENOSPC tests
> don't exercise? Why cant you just use preallocation to trigger
> ENOSPC repeatedly instead of writing data? That would allow multiple
> iterations per second, not one every few minutes...
Yes, generic/102 just does this job, sorry.

Regards,
Xiaoguang Wang

>
> Cheers,
>
> Dave.



