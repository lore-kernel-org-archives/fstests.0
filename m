Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43626 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbbBRKVV (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 18 Feb 2015 05:21:21 -0500
Message-ID: <54E4679C.7030309@fedoraproject.org>
Date: Wed, 18 Feb 2015 10:21:16 +0000
From: Andrew Price <andyp@fedoraproject.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] xfstests: fix a typo in _require_block_device()
References: <1424069440-14957-1-git-send-email-zhaolei@cn.fujitsu.com> <20150218012139.GO4251@dastard>
In-Reply-To: <20150218012139.GO4251@dastard>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 18/02/15 01:21, Dave Chinner wrote:
> On Mon, Feb 16, 2015 at 02:50:39PM +0800, Zhaolei wrote:
>> From: Zhao Lei <zhaolei@cn.fujitsu.com>
>>
>> We need to check "$1" instead "$SCRATCH_DEV" in this function.
>> And make tabs same with other code.
>>
>> Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
>> ---
>>   common/rc | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 7449a1d..76522d4 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1284,13 +1284,13 @@ _require_command()
>>   # $1 - device
>>   _require_block_device()
>>   {
>> -	if [ -z "$1" ]; then
>> -		echo "Usage: _require_block_device <dev>" 1>&2
>> -		exit 1
>> -	fi
>> -	if [ "`_is_block_dev $SCRATCH_DEV`" == "" ]; then
>> -		_notrun "require $1 to be valid block disk"
>> -	fi
>> +    if [ -z "$1" ]; then
>> +	echo "Usage: _require_block_device <dev>" 1>&2
>> +	exit 1
>> +    fi
>> +    if [ "`_is_block_dev $1`" == "" ]; then
>> +	_notrun "require $1 to be valid block disk"
>> +    fi
>>   }
>
> The change is fine - the reformating of the code is not. 8 space
> tabs

To be clear, do you mean 8 spaces or single tabs?

Andy

> for all new code and all new modifications, please.
>
> Cheers,
>
> Dave.
>

