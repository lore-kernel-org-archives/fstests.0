Received: from szxga07-in.huawei.com ([45.249.212.35]:34268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729146AbeJ2TWp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 29 Oct 2018 15:22:45 -0400
Subject: Re: [PATCH v3] generic/508: fix to check inode creation time feature
 on scratch mountpoint
References: <20181027015520.7355-1-yuchao0@huawei.com>
 <20181027032801.GH6311@dastard>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <a519cbed-3f03-8023-01ad-0b7416638e69@huawei.com>
Date: Mon, 29 Oct 2018 18:34:34 +0800
MIME-Version: 1.0
In-Reply-To: <20181027032801.GH6311@dastard>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org, chao@kernel.org
List-ID: <fstests@vger.kernel.org>

On 2018/10/27 11:28, Dave Chinner wrote:
> On Sat, Oct 27, 2018 at 09:55:20AM +0800, Chao Yu wrote:
>> _require_btime() just check inode creation time feature on TEST_DIR
>> mountpoint, but generic/508 needs to do that check on SCRATCH_MNT
>> mountpoint. Let's add _require_scratch_btime() for that, meanwhile
>> handling scratch_{mkfs,mount,umount} inside the function to decouple
>> with caller.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v3:
>> - hanlde scratch mkfs/mount/umount inside _require_scratch_btime
>> - relocate _require_scratch_btime
>>  common/rc         | 14 ++++++++++++++
>>  tests/generic/508 |  2 +-
>>  2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index b4987a9cd7f7..a882fada7d02 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3851,6 +3851,20 @@ _require_btime()
>>  	rm -f $TEST_DIR/test_creation_time
>>  }
>>  
>> +_require_scratch_btime()
>> +{
>> +	_require_scratch
>> +	_scratch_mkfs > /dev/null 2>&1
>> +	_scratch_mount
>> +
>> +	$XFS_IO_PROG -f $SCRATCH_MNT/test_creation_time -c "statx -v" \
>> +		| grep btime >>$seqres.full 2>&1 || \
>> +		_notrun "inode creation time not supported by this filesystem"
>> +	rm -f $SCRATCH_MNT/test_creation_time
> 
> No need to remove that file - it's going to get mkfs'd again,
> anyway.

That's correct, I just saw Eryu has fixed this in upstream, so I think I
don't need to send v4...

> 
> Otherwise looks fine. I'm not a fan of all these require_scratch
> rules having to run mkfs, but I can live with it.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Thanks for the review. :)

Thanks,

> 
