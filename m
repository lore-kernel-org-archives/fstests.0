Received: from szxga07-in.huawei.com ([45.249.212.35]:37687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbeJXPww (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Oct 2018 11:52:52 -0400
Subject: Re: [PATCH] common/rc: fix to check inode creation on scratch_mnt in
 _require_btime()
References: <20181024022645.74084-1-yuchao0@huawei.com>
 <20181024044541.GD6311@dastard>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <913e0917-11c0-c954-15f8-d814d1219407@huawei.com>
Date: Wed, 24 Oct 2018 15:25:55 +0800
MIME-Version: 1.0
In-Reply-To: <20181024044541.GD6311@dastard>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org, chao@kernel.org
List-ID: <fstests@vger.kernel.org>

On 2018/10/24 12:45, Dave Chinner wrote:
> On Wed, Oct 24, 2018 at 10:26:45AM +0800, Chao Yu wrote:
>> _require_btime() should check inode creation feature on SCRATCH_MNT
>> mountpoint intead of TEST_DIR mountpoint, otherwise generic/508 will
>> fail due to incorrect check of this function.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  common/rc | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index b4987a9cd7f7..5154241a5cee 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3845,10 +3845,10 @@ _dmsetup_create()
>>  
>>  _require_btime()
>>  {
>> -	$XFS_IO_PROG -f $TEST_DIR/test_creation_time -c "statx -v" \
>> +	$XFS_IO_PROG -f $SCRATCH_MNT/test_creation_time -c "statx -v" \
>>  		| grep btime >>$seqres.full 2>&1 || \
>>  		_notrun "inode creation time not supported by this filesystem"
>> -	rm -f $TEST_DIR/test_creation_time
>> +	rm -f $SCRATCH_MNT/test_creation_time
>>  }
> 
> This doesn't work. the scratch device is not mounted at the time
> generic/508 calls it.
> 
> If you are going to check the scratch device, the function needs to
> be called _require_scratch_btime and be called after
> scratch_mkfs/scratch_mount has been run by the test.
That's correct, I've fixed in v2, could you please help to check that?

Thanks,

> 
> Cheers,
> 
> Dave.
> 
