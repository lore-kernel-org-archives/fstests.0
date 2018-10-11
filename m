Received: from aserp2120.oracle.com ([141.146.126.78]:43332 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeJKKkP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Oct 2018 06:40:15 -0400
Subject: Re: [PATCH v2 3/9] geneirc/077 fix min size for btrfs
References: <1537849462-619-1-git-send-email-anand.jain@oracle.com>
 <1537849462-619-4-git-send-email-anand.jain@oracle.com>
 <20181006112507.GL17817@desktop>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <7874ee99-960a-e6c4-b710-d7a24bd9d64c@oracle.com>
Date: Thu, 11 Oct 2018 11:14:36 +0800
MIME-Version: 1.0
In-Reply-To: <20181006112507.GL17817@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 10/06/2018 07:25 PM, Eryu Guan wrote:
> On Tue, Sep 25, 2018 at 12:24:16PM +0800, Anand Jain wrote:
>> If btrfs need to be tested at its default blockgroup which is non-mixed,
>> then it needs at least 256mb.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> (Sorry for the late review..)

  Its fine. Sorry for the delay at my end too.

>> ---
>>   tests/generic/077 | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tests/generic/077 b/tests/generic/077
>> index ef6af18c83e3..ec236992513f 100755
>> --- a/tests/generic/077
>> +++ b/tests/generic/077
>> @@ -49,8 +49,7 @@ rm -f $seqres.full
>>   _scratch_unmount >/dev/null 2>&1
>>   echo "*** MKFS ***"                         >>$seqres.full
>>   echo ""                                     >>$seqres.full
>> -SIZE=`expr 50 \* 1024 \* 1024`
>> -_scratch_mkfs_sized $SIZE                   >>$seqres.full 2>&1 \
>> +_scratch_mkfs_sized $((256 * 1024 *1024))   >>$seqres.full 2>&1 \
>>   	|| _fail "mkfs failed"
> 
> Hmm, this test copies "/lib/modules/" to fill the original 50M
> filesystem (which seems a bad way to me)

Yep. I didn't like either. I started using the _populate_fs() but then 
was doubtful if it still meets the objective of this test case as it 
used the dd instead of cp. Moreover it kind of getting diverged from 
what's the object of this patch. If needed we could fix the cp approach 
in a separate patch so that we shall have better tracking.

> "
> # Something w/ enough data to fill 50M of fs...
> filler=/lib/modules/
> ...
> echo "*** populate filesystem, pass #1" | tee -a $seqres.full
> cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
> ...
> "
> 
> It works most of the time as "/lib/modules" is usually larger than 50M,
> but it may not fullfil the fs with 256M size.
> 
> I think we should fix the way to fill the fs too.

  Right. There are two iterations of cp. So a check if the assigned 
filler is big enough to fill the 256M will suffice, as we already 
_notrun the test if empty filler.

Pls find v2 for review.

Thanks, Anand

> Thanks,
> Eryu
> 
>>   _scratch_mount
>>   mkdir $SCRATCH_MNT/subdir
>> -- 
>> 1.8.3.1
>>
