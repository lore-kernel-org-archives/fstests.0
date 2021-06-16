Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDDEC48BE5
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Jun 2021 13:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0263661241
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Jun 2021 13:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhFPNRs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhFPNRq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Jun 2021 09:17:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92CD661164;
        Wed, 16 Jun 2021 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623849340;
        bh=dZGU8gWrVEjcpi8gJBee47OaFc0kjuWd3YMGK0b5FhM=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
        b=mctm5ccVm1OdUd/+uZQSai00F1OTwsnd1a8s2FV/6RMCyrHUdMld4OKPHG94C+QrO
         TBiFi7rHw1DL8hzcdDaHEnHypzwAELq8FFJlOMNFc+BcPpN61Ta3pRnH4nocaQoV6I
         RscLvLMp+NdvlZSE7mxvtzyTSlYYyViGw76CqyvV4aK5rIs0HUv3AhhQK1RTf9eXlm
         TebUBTI3dmZelnUVpLwzUXjWn0uPioNSezpo2THB3OkTJGJ2KgINkyFQhAvcKbxyeQ
         VH/b3OLuu0dWxmANAsQ7hundklnI97hWlzuI6JvEthFBbbvvL+6deQXLSYhLiX7b8c
         d8GHnb4zRGvEg==
Subject: Re: [f2fs-dev] [PATCH] generic/103: leave more space for f2fs
To:     Sun Ke <sunke32@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20210611112211.1408767-1-sunke32@huawei.com>
 <20210611112211.1408767-2-sunke32@huawei.com>
 <1ea6a853-d892-4c3e-d023-72adc379b803@huawei.com>
From:   Chao Yu <chao@kernel.org>
Cc:     fstests@vger.kernel.org, guan@eryu.me, yuchao0@huawei.com
Message-ID: <aa3fef51-5633-800a-1d93-cbfb66453c2a@kernel.org>
Date:   Wed, 16 Jun 2021 21:15:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1ea6a853-d892-4c3e-d023-72adc379b803@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2021/6/15 11:28, Sun Ke wrote:
> to linux-f2fs-devel@lists.sourceforge.net
> 
> 在 2021/6/11 19:22, Sun Ke 写道:
>> It failed on f2fs:
>>       QA output created by 103
>>      +fallocate: No space left on device
>>       Silence is golden.
>>      ...
>>
>> Try to leave ~512KB, but during the fallocate, f2fs will be filled.
>> Provide error prompt: "fallocate: No space left on device".
>>
>> Leave more space for f2fs.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>> I add some test code
>>     +       df
>>             avail=`_get_available_space $SCRATCH_MNT`
>>     +       echo "avail = ${avail}"
>>             filesizekb=$((avail / 1024 - 512))
>>     +       echo "filesizekb = ${filesizekb}"
>>             $XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file
>>     +       df
>>     }
>>
>> f2fs:
>>     QA output created by 103
>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>     ...
>>     +/dev/sdb          12580864     553292    12027572   5% /mnt/scratch
>>     +avail = 12316233728
>>     +filesizekb = 12027060
>>     +fallocate: No space left on device
>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>     ...
>>     +/dev/sdb          12580864   12580864           0 100% /mnt/scratch
>>     Silence is golden.
>>
>> xfs:
>>     QA output created by 103
>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>     ...
>>     +/dev/sdb          12572672     120828    12451844   1% /mnt/scratch
>>     +avail = 12750688256
>>     +filesizekb = 12451332
>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>     ...
>>     +/dev/sdb          12572672   12572160         512 100% /mnt/scratch
>>     Silence is golden.
>>
>> ext4:
>>     QA output created by 103
>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>     ...
>>     +/dev/sdb          12319880      41048    11633304   1% /mnt/scratch
>>     +avail = 11912503296
>>     +filesizekb = 11632792
>>     +Filesystem       1K-blocks       Used   Available Use% Mounted on
>>     ...
>>     +/dev/sdb          12319880   11673844         508 100% /mnt/scratch
>>     Silence is golden.
>>
>> after change (f2fs)
>>     QA output created by 103
>>     Filesystem       1K-blocks       Used   Available Use% Mounted on
>>     ...
>>     /dev/sdb          12580864   12580396         468 100% /tmp/scratch
>>     Silence is golden.
>>
>>   tests/generic/103 | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/103 b/tests/generic/103
>> index b22b0159623e..dfce3870781c 100755
>> --- a/tests/generic/103
>> +++ b/tests/generic/103
>> @@ -40,10 +40,18 @@ rm -f $seqres.full
>>   _consume_freesp()
>>   {
>>       file=$1
>> +    leave=512
>> +
>> +    # Try to leave ~512KB, but during the fallocate, f2fs will be filled.
>> +    # Provide error prompt: "fallocate: No space left on device". Leave
>> +    # more space for f2fs.
>> +    if [ $FSTYP == "f2fs" ]; then
>> +        leave=12288
>> +    fi
>>       # consume nearly all available space (leave ~512kB)
>>       avail=`_get_available_space $SCRATCH_MNT`

         if [ $FSTYP == "f2fs" ]; then
                 left=$((left + avail / 1024000))
         fi

f2fs uses index(radix) tree as mapping metadata, its space overhead
is about one thousandth of the data, so can you please try above
calculation?

Thanks,

>> -    filesizekb=$((avail / 1024 - 512))
>> +    filesizekb=$((avail / 1024 - $leave))
>>       $XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file
>>   }
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
