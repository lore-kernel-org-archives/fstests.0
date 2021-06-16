Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5E4C48BE6
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Jun 2021 12:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA2C60249
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Jun 2021 12:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhFPMi0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Jun 2021 08:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231441AbhFPMi0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Jun 2021 08:38:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA7F561166;
        Wed, 16 Jun 2021 12:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623846979;
        bh=7ZuuEyAytr6xeZN/laWbjM8f3Jl75UtVgZnXZO8r/3I=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=IT/RWaekNClB4x0hI5oDif4Ctkd8wyqfqLWqrFyB33eb+JEx3VRISlO1psO3yRBst
         VPMWXpHbs2LBc+j299vAYXfFkMGJsRx18yONksG790pVtmB3WSVYvZq6vDSAN5cCwQ
         rrv9YtkLoM+fU5Z3S/SwNKQOttV9CB4Wp2Vli3vdfLmPzKeP0etZKjEt1mVj45MSib
         wQJaJ+oChewldcjzic0tJ7NWTuLEyAGM5fVhYU98Llt14gTJXvEuFXxCf/d6mq2dNW
         yH7l8J0gBQV5q26yt0LWxg8diLTUtYq7xoBn1ECWzTMUBHoKlC4h5KEdmPtP5nXeUs
         cVcAURzH+LRxQ==
Subject: Re: [f2fs-dev] [PATCH] common/rc: f2fs do not support metadata
 journaling
To:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org, guan@eryu.me,
        yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
References: <20210611112211.1408767-1-sunke32@huawei.com>
 <d95c4ac2-50a2-4f08-3940-ac0597266280@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <258b1228-2a8a-e4c1-cf6c-695f49c0cca0@kernel.org>
Date:   Wed, 16 Jun 2021 20:36:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d95c4ac2-50a2-4f08-3940-ac0597266280@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2021/6/15 11:25, Sun Ke wrote:
> 
> 
> 在 2021/6/11 19:22, Sun Ke 写道:
>> In generic/50, touch 100 files, go down the fs immediately, Then umount
>> and set the disk readi-only. Try to mount it again without \-o
>> norecovery\, it should fail, because it can not recovery on a read-only
>> device. But f2fs mount successfully and the test fail.
>>
>> f2fs seems do not support metadata journaling.

It looks not correct.

FYI,

https://lkml.org/lkml/2021/3/23/75

Thanks,

>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>
>> I am not very sure if f2fs do not support metadata journaling.
>>
>> ###
>> before change
>> ###
>> [root@localhost xfstests-dev]# ./check tests/generic/050
>> FSTYP         -- f2fs
>> PLATFORM      -- Linux/x86_64 localhost 5.12.0-rc5-next-20210330 #8 SMP Tue Jun 8 11:09:37 CST 2021
>> MKFS_OPTIONS  -- /dev/sdb
>> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /tmp/scratch
>>
>> generic/050 4s ... - output mismatch (see /root/work/xfstests-dev/results//generic/050.out.bad)
>>      --- tests/generic/050.out   2021-05-31 15:37:40.000000000 +0800
>>      +++ /root/work/xfstests-dev/results//generic/050.out.bad    2021-06-11 16:48:19.993000000 +0800
>>      @@ -13,9 +13,7 @@
>>       setting device read-only
>>       mounting filesystem that needs recovery on a read-only device:
>>       mount: device write-protected, mounting read-only
>>      -mount: cannot mount device read-only
>>       unmounting read-only filesystem
>>      -umount: SCRATCH_DEV: not mounted
>>       mounting filesystem with -o norecovery on a read-only device:
>>      ...
>>      (Run 'diff -u /root/work/xfstests-dev/tests/generic/050.out /root/work/xfstests-dev/results//generic/050.out.bad'  to see the entire diff)
>> Ran: generic/050
>> Failures: generic/050
>> Failed 1 of 1 tests
>>
>> ###
>> after change
>> ###
>> [root@localhost xfstests-dev]# ./check tests/generic/050
>> FSTYP         -- f2fs
>> PLATFORM      -- Linux/x86_64 localhost 5.12.0-rc5-next-20210330 #8 SMP Tue Jun 8 11:09:37 CST 2021
>> MKFS_OPTIONS  -- /dev/sdb
>> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb /tmp/scratch
>>
>> generic/050 4s ...  4s
>> Ran: generic/050
>> Passed all 1 tests
>>
>>
>>
>>   common/rc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index a0aa7300..428b8b80 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3543,7 +3543,7 @@ _has_metadata_journaling()
>>       fi
>>       case "$FSTYP" in
>> -    ext2|vfat|msdos|udf|exfat|tmpfs)
>> +    ext2|vfat|msdos|udf|exfat|tmpfs|f2fs)
>>           echo "$FSTYP does not support metadata journaling"
>>           return 1
>>           ;;
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
