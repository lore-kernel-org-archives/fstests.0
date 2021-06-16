Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71604C48BE6
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Jun 2021 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5F761359
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Jun 2021 13:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhFPNpe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233535AbhFPNp1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Jun 2021 09:45:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA3A46100A;
        Wed, 16 Jun 2021 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623851000;
        bh=Rj3dRcfjtk6/OoUIlEbiBnXdcPY4Msj49PzbROb3PyQ=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
        b=AfA6y4Ugyv5rC+LD6iEH/XO+qrLU3nXEal63XPHip0DocfwbcJJyzntFf9XQ5hXuW
         FuUHyhly5LMYy5cjPCQVXxZoBOiE9vTjScuVrtLlgNA/LS/W3dhfGjls6wCv8Zubn9
         +45TC6zmFpMbZF/abxqwmzPsPEEVDSy8fCfNNFMyzOtCV6BJoW8Tf0f8v/MiH9lPlJ
         KzDjXZJG9V8xyWppZ+1+trc4v+aQwCODR7Km5gFAlR0LsokdjWy4KIF/6Pa5sLq1J1
         4/ZNo7pRFOe1x5gSWj1fvAeIzqALJMfQPUUzF7GfIeS8fwKCk2qZAGySPMGBz/dXPV
         oB3kycVKF3WSA==
Subject: Re: [f2fs-dev] [PATCH] generic/260: f2fs is also special
To:     Sun Ke <sunke32@huawei.com>
References: <20210611112211.1408767-1-sunke32@huawei.com>
 <20210611112211.1408767-3-sunke32@huawei.com>
 <87024647-0ece-929d-8aa6-8dab9609159c@huawei.com>
From:   Chao Yu <chao@kernel.org>
Cc:     fstests@vger.kernel.org, guan@eryu.me, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net
Message-ID: <6362f24f-35d1-7e5b-c3cc-d6cbb18947fe@kernel.org>
Date:   Wed, 16 Jun 2021 21:43:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87024647-0ece-929d-8aa6-8dab9609159c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2021/6/15 11:29, Sun Ke wrote:
> to linux-f2fs-devel@lists.sourceforge.net
> 
> 在 2021/6/11 19:22, Sun Ke 写道:
>> It seem that f2fs also special like btrfs.
>>
>>   [+] Default length with start set (should succeed)
>>   [+] Length beyond the end of fs (should succeed)
>>   [+] Length beyond the end of fs with start set (should succeed)
>> +After the full fs discard 0 bytes were discarded however the file system is 12882804736 bytes long.
>> +It seems that fs logic handling len argument overflows

Well, the root cause is f2fs can tag a special flag TRIMMED_FLAG to
indicate the whole filesystem is trimmed, so after mkfs/fstrim(),
following fstrim() won't trim any block.

Can you please update commit message and add comments in script?

Thanks,

>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>> I am not sure about that. o(╯□╰)o
>>
>>   tests/generic/260 | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/generic/260 b/tests/generic/260
>> index 8021aa68..6bd861d2 100755
>> --- a/tests/generic/260
>> +++ b/tests/generic/260
>> @@ -100,7 +100,7 @@ fi
>>   # It is because btrfs does not have not-yet-used parts of the device
>>   # mapped and since we got here right after the mkfs, there is not
>>   # enough free extents in the root tree.
>> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
>> +if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ] && [ $FSTYP != "f2fs" ]; then
>>       status=1
>>       echo "After the full fs discard $bytes bytes were discarded"\
>>            "however the file system is $(_math "$fssize*1024") bytes long."
>> @@ -160,7 +160,7 @@ _scratch_mount
>>   # mapped and since we got here right after the mkfs, there is not
>>   # enough free extents in the root tree.
>>   bytes=$($FSTRIM_PROG -v -l$len $SCRATCH_MNT | _filter_fstrim)
>> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
>> +if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ] && [ $FSTYP != "f2fs" ]; then
>>       status=1
>>       echo "It seems that fs logic handling len argument overflows"
>>   fi
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
