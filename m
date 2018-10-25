Received: from szxga04-in.huawei.com ([45.249.212.190]:14117 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbeJYPrr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 Oct 2018 11:47:47 -0400
Subject: Re: [PATCH v2] generic/508: fix to check inode creation time feature
 on scratch mountpoint
References: <20181024072433.109167-1-yuchao0@huawei.com>
 <20181025021609.GG6311@dastard>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <df7dfea8-033b-9953-3f39-9784dfba8edf@huawei.com>
Date: Thu, 25 Oct 2018 15:16:14 +0800
MIME-Version: 1.0
In-Reply-To: <20181025021609.GG6311@dastard>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org, chao@kernel.org
List-ID: <fstests@vger.kernel.org>

On 2018/10/25 10:16, Dave Chinner wrote:
> On Wed, Oct 24, 2018 at 03:24:33PM +0800, Chao Yu wrote:
>> _require_btime() just check inode creation time feature on TEST_DIR
>> mountpoint, but generic/508 needs to do that check on SCRATCH_MNT
>> mountpoint. Let's add _require_scratch_btime() for that, meanwhile
>> moving the check behind scratch_mkfs/scratch_moun.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> As Dave Chinner suggested:
>> - introduce _require_scratch_btime() to check inode creation time
>> feature in scratch mountpoint, adjust generic/508 to use it.
>> - relocate the check behind scratch_mkfs/scratch_mount.
>>  common/rc         | 8 ++++++++
>>  tests/generic/508 | 2 +-
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index b4987a9cd7f7..111ba5410506 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3851,6 +3851,14 @@ _require_btime()
>>  	rm -f $TEST_DIR/test_creation_time
>>  }
>>  
>> +_require_scratch_btime()
>> +{
>> +	$XFS_IO_PROG -f $SCRATCH_MNT/test_creation_time -c "statx -v" \
>> +		| grep btime >>$seqres.full 2>&1 || \
>> +		_notrun "inode creation time not supported by this filesystem"
>> +	rm -f $SCRATCH_MNT/test_creation_time
>> +}
>> +
>>  init_rc
>>  
>>  ################################################################################
>> diff --git a/tests/generic/508 b/tests/generic/508
>> index b869b3a9c260..f1cda52fa44c 100755
>> --- a/tests/generic/508
>> +++ b/tests/generic/508
>> @@ -46,7 +46,6 @@ _supported_os Linux
>>  _require_test_lsattr
>>  _require_statx
>>  _require_xfs_io_command "statx" "-v"
>> -_require_btime
>>  
>>  _require_scratch
>>  _require_scratch_shutdown
>> @@ -59,6 +58,7 @@ testfile=$SCRATCH_MNT/testfile
>>  do_check()
>>  {
>>  	_scratch_mount
>> +	_require_scratch_btime
> 
> There is no need to check it every time the scratch device is
> mounted. Do the require checks up front befor the test starts
> after _scratch_mkfs has been run.

Oh, sorry, actually, I should do this check with more clean way.

Taking other existing _require_* function which needs scratch device being
mounted as an example, it may look more clean that adding mkfs/mount/umount
into _require_scratch_btime instead of coupling codes with main flow. Like:

_require_scratch_btime()
{
	_require_scratch
	_scratch_mkfs > /dev/null 2>&1
	_scratch_mount

	$XFS_IO_PROG -f $SCRATCH_MNT/test_creation_time -c "statx -v" \
		| grep btime >>$seqres.full 2>&1 || \
		_notrun "inode creation time not supported by this filesystem"
	rm -f $SCRATCH_MNT/test_creation_time

	_scratch_unmount
}

How do you think of this?

Thanks,

> 
> But, oh, what an inconsistent mess these scratch device require
> statements are.  Some just check the scratch device. Some mkfs the
> scratch device, mount it and then run tests. Others require that the
> scratch device is already made and mounted. It doesn't look like
> there's any consistency here, so it's no wonder test writers are
> getting this stuff wrong....
> 
> Cheers,
> 
> Dave.
> 
