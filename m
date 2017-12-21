Received: from mx1.mpynet.fi ([82.197.21.84]:52996 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752658AbdLUNwE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 21 Dec 2017 08:52:04 -0500
Subject: Re: [PATCH] common/encrypt: Create an encrypted equivalent of
 _scratch_mkfs_sized
References: <1513792000-25462-1-git-send-email-ari@tuxera.com>
 <20171221013802.GP5858@dastard>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <1a058cb8-b2c0-39b5-e65d-d77264c37a54@tuxera.com>
Date: Thu, 21 Dec 2017 15:52:00 +0200
MIME-Version: 1.0
In-Reply-To: <20171221013802.GP5858@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi!

Thank you for your comments. Please see below.

On 12/21/2017 03:38 AM, Dave Chinner wrote:
> On Wed, Dec 20, 2017 at 07:46:40PM +0200, Ari Sundholm wrote:
>> Test case generic/399 hardcodes "-O encrypt" in MKFS_OPTIONS when
>> calling _scratch_mkfs_sized, which only works with the mkfs of certain
>> filesystems. Create a new helper, _scratch_mkfs_sized_encrypted, for
>> handling the differences between the mkfs tools of different
>> filesystems. It also allows those filesystems whose mkfs doesn't accept
>> "-O encrypt" to skip the test gracefully until proper support is added
>> for them in the helper.
>>
>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>> ---
>>   common/encrypt    | 12 ++++++++++++
>>   tests/generic/399 |  3 +--
>>   2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/encrypt b/common/encrypt
>> index a6fd89d..189c59e 100644
>> --- a/common/encrypt
>> +++ b/common/encrypt
>> @@ -81,6 +81,18 @@ _scratch_mkfs_encrypted()
>>   	esac
>>   }
>>   
>> +_scratch_mkfs_sized_encrypted()
>> +{
>> +	case $FSTYP in
>> +	ext4|f2fs)
>> +		MKFS_OPTIONS="$MKFS_OPTIONS -O encrypt" _scratch_mkfs_sized $*
>> +		;;
> 
> This does not need to screw around with MKFS_OPTIONS. This:
> 
> 		_scratch_mkfs_sized -O encrypt $*
> 
> Will do just fine.

Hmm, I don't see how that could work. At the moment, _scratch_mkfs_sized 
only takes and uses two arguments, one of which is optional. AFAICS, all 
additional mkfs options need to be passed using MKFS_OPTIONS to 
_scratch_mkfs_sized.

As for using $* instead of $1 $2, I am hoping that will avoid having to 
change this new function even if the usage of _scratch_mkfs_sized changes.

> Also, _scratch_mkfs_encrypted() supports UBIFS, and this new
> function doesn't. Seems like it should to me...

_scratch_mkfs_sized does not support ubifs, though, so the operation 
would _notrun anyway. I'm not familiar with ubifs or its tools, but I'll 
see if I can find out how to implement support for ubifs in 
_scratch_mkfs_sized.

> Cheers,
> 
> Dave.
> 

Thanks,
Ari Sundholm
ari@tuxera.com
