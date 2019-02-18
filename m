Received: from szxga06-in.huawei.com ([45.249.212.32]:48814 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbfBRGdq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 18 Feb 2019 01:33:46 -0500
Subject: Re: [PATCH v2] generic/299: limit max file size
References: <20190218015741.7996-1-yuyufen@huawei.com>
 <20190218035601.GD9805@dastard>
From: yuyufen <yuyufen@huawei.com>
Message-ID: <fa7a022c-866b-8bea-12f4-8170b19752f0@huawei.com>
Date: Mon, 18 Feb 2019 14:33:36 +0800
MIME-Version: 1.0
In-Reply-To: <20190218035601.GD9805@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 2019/2/18 11:56, Dave Chinner wrote:
> On Mon, Feb 18, 2019 at 09:57:41AM +0800, Yufen Yu wrote:
>> For some filesystem, such as vfat, the max support file size
>> is 4G. We limit the max size and let the test go on running.
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   common/rc         | 9 +++++++++
>>   tests/generic/299 | 5 +++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index e5da6484..94148029 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3785,6 +3785,15 @@ _require_scratch_feature()
>>   	esac
>>   }
>>   
>> +# get mount point filesystem max file size
>> +_get_file_max_size()
>> +{
>> +	local mnt_point=$1
>> +
>> +	bits=`getconf FILESIZEBITS ${mnt_point}`
>> +	echo "$((2**bits-1))"
>> +}
> Did you test this?
>
> $ echo "$((2**64-1))"
> -1

Sorry for my carelessness.

> $
>
>>   # The maximum filesystem label length, /not/ including terminating NULL
>>   _label_get_max()
>>   {
>> diff --git a/tests/generic/299 b/tests/generic/299
>> index c4d74fc8..175aa6f2 100755
>> --- a/tests/generic/299
>> +++ b/tests/generic/299
>> @@ -33,6 +33,11 @@ NUM_JOBS=$((4*LOAD_FACTOR))
>>   BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
>>   FILE_SIZE=$((BLK_DEV_SIZE * 512))
>>   
>> +# filesystem limit max file size
>> +max_file_size=$(_get_file_max_size $SCRATCH_MNT)
>> +FILE_SIZE=$([ $max_file_size -le $FILE_SIZE ] && \
>> +		echo "$max_file_size" || echo "$FILE_SIZE")
>> +
> It's much easier to read if you use if/then:
>
> max_file_size=$(_get_file_max_size $SCRATCH_MNT)
> if [ $max_file_size -lt $FILE_SIZE ]; then
> 	FILE_SIZE=$max_file_size
> fi

OK.

Yufen
Thanks.

> Cheers,
>
> Dave.

.
