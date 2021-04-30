Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6EEC433ED
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Apr 2021 16:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C579761420
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Apr 2021 16:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhD3QSE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 30 Apr 2021 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhD3QSE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 30 Apr 2021 12:18:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAC3C06174A;
        Fri, 30 Apr 2021 09:17:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 6F8491F43AD7
Subject: Re: [PATCH] generic/631: Add a check for extended attributes
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        krisman@collabora.com, preichl@redhat.com, kernel@collabora.com,
        willy@infradead.org
References: <20210430102656.64254-1-shreeya.patel@collabora.com>
 <20210430151757.GK1251862@magnolia>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <cf8d5a01-a435-8f78-7ed2-095def679134@collabora.com>
Date:   Fri, 30 Apr 2021 21:47:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210430151757.GK1251862@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 30/04/21 8:47 pm, Darrick J. Wong wrote:
> On Fri, Apr 30, 2021 at 03:56:56PM +0530, Shreeya Patel wrote:
>> Test case 631 fails for filesystems like exfat or vfat or any other
>> which does not support extended attributes.
>>
>> The main reason for failure is not being able to mount overlayfs
>> with filesystems that do not support extended attributes.
>> mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir
>>
>> Above command would return an error as -
>> /var/mnt/scratch/merged0: wrong fs type, bad option, bad superblock on overlay,
>> missing codepage or helper program, or other error.
>>
>> dmesg log reports the following -
>> overlayfs: filesystem on '/var/mnt/scratch/upperdir1' not supported
>>
>> As per the overlayfs documentation -
>> "A wide range of filesystems supported by Linux can be the lower filesystem,
>> but not all filesystems that are mountable by Linux have the features needed
>> for OverlayFS to work. The lower filesystem does not need to be writable.
>> The lower filesystem can even be another overlayfs.
>> The upper filesystem will normally be writable and if it is it must support
>> the creation of trusted.* and/or user.* extended attributes, and must provide
>> valid d_type in readdir responses, so NFS is not suitable.
> Does this test also need to check for d_type support?


It already does that.


>> A read-only overlay of two read-only filesystems may use any filesystem type."
>>
>> As per the above statements from the overlayfs documentation, it is clear that
>> filesystems that do not support extended attributes would not work with overlayfs.
>> This is why we see the error in dmesg log for upperdir1 which had an exfat filesystem.
> (Please wrap the commit messages at 75 columns, per SubmittingPatches.)


Sure, will send a v2.


>> Hence, add a check for extended attributes which would avoid running this tests for
>> filesystems that are not supported.
>>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Regardless, this seems like a reasonable change, so:
>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>


Thanks


> --D
>
>> ---
>>   tests/generic/631 | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/generic/631 b/tests/generic/631
>> index c43f3de3..c7f0190e 100755
>> --- a/tests/generic/631
>> +++ b/tests/generic/631
>> @@ -39,10 +39,12 @@ _cleanup()
>>   
>>   # get standard environment, filters and checks
>>   . ./common/rc
>> +. ./common/attr
>>   
>>   # real QA test starts here
>>   _supported_fs generic
>>   _require_scratch
>> +_require_attrs
>>   test "$FSTYP" = "overlay" && _notrun "Test does not apply to overlayfs."
>>   _require_extra_fs overlay
>>   
>> -- 
>> 2.30.2
>>
