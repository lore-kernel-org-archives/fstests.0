Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D129C636D6
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Feb 2023 17:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBVRZM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Feb 2023 12:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBVRZL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Feb 2023 12:25:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450C141080
        for <fstests@vger.kernel.org>; Wed, 22 Feb 2023 09:24:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0AFC8219E2;
        Wed, 22 Feb 2023 17:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677086676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pO5eN2qlb/esKJDsIyNjfLp3gm2EQWDGCQaxIm7pQN8=;
        b=DtCTe+t82WavhGPJTwtfbsjvMzTZhmcKltDByfc2tSXM70XRf0FNnRRxXH9PPRure8zHnf
        wYXtdYRNL5uxl3eEL+7XJwzG/E7Rh4QobyPIkS3r+aCG+0gju60+HzZ1BpZQ0BzKS64heY
        ps2CgIxfDMIwHW26IH9DWbRUmsIhSCs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD86B139DB;
        Wed, 22 Feb 2023 17:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zsNVNNNP9mM+agAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 22 Feb 2023 17:24:35 +0000
Message-ID: <5a6a05f9-e007-8b5a-3775-757b4568ccca@suse.com>
Date:   Wed, 22 Feb 2023 18:24:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] README: Add tiny note concerning required scratch
 devs for btrfs testing
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
References: <20230131123839.16084-1-gniebler@suse.com>
 <20230131123839.16084-3-gniebler@suse.com>
 <20230206145207.kik5cczepdlgmexa@zlang-mailbox>
 <f8d78191-089f-4407-dd2d-17f7e3be2580@suse.com>
 <20230218062641.vbfvo6lqfgtwiyth@zlang-mailbox>
Content-Language: en-US
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <20230218062641.vbfvo6lqfgtwiyth@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Am 18.02.23 um 07:26 schrieb Zorro Lang:
> On Mon, Feb 06, 2023 at 05:29:14PM +0100, Gabriel Niebler wrote:
>> Am 06.02.23 um 15:52 schrieb Zorro Lang:
>>> On Tue, Jan 31, 2023 at 01:38:39PM +0100, Gabriel Niebler wrote:
>>>> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
>>>> ---
>>>>    README | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/README b/README
>>>> index 008d3875..574cdd34 100644
>>>> --- a/README
>>>> +++ b/README
>>>> @@ -127,7 +127,7 @@ Setup Environment
>>>>        - device contents will be destroyed.
>>>>    4. (optional) Create SCRATCH device pool.
>>>> -    - needed for BTRFS testing
>>>> +    - needed for BTRFS testing (some tests require up to 5 disks of 10GB each)
>>>
>>> Not sure about this part, so btrfs recommend 5 disks of 10GB each in
>>> SCRATCH_DEV_POOL, to run all btrfs related tests? Does anyone know that?
>>> Or can you provide the subcase names which need "5 disks of 10GB each",
>>> to help to check and review?
>>
>> Of course (and thanks for asking, as it turns out my recollection was
>> slightly wrong on that one):
>>
>> To begin with, btrfs/011[1] states the "5 disks" requirement in the lengthy
>> comment at the top of the file:
>> """
>> # The amount of tests done depends on the number of devices in the
>> # SCRATCH_DEV_POOL. For full test coverage, at least 5 devices should
>> # be available (e.g. 5 partitions).
>> ""
>> ... but it doesn't say anything about device size.
>>
>> btrfs/027[2] however checks the presence of 5 devices in $SCRATCH_DEV_POOL
>> directly in code and also runs a check to ensure that all of these devices
>> are *of the same size*.
>>
>> And then there are at least two tests that require $SCRATCH_DEV to be 10GB
>> or more in size:
>> - btrfs/079[3], which writes a 10G file to $SCRATCH_MNT and
>> - btrfs/253[4], which directly creates a 10G FS on $SCRATCH_DEV.
>>
>> *Taken together*, this means that for full btrfs test coverage, one needs a
>> $SCRATCH_DEV_POOL with at least 5 devices of equal size in it and that size
>> has to be at least 10GB.
>>
>> But that makes the remark wrong, strictly speaking, as there's no single
>> test that requires "at least 5 devices of 10GB each".
>>
>> How about this: "(for full btrfs test coverage, use at least 5 devices of
>> equal size and at least 10GB)"
> 
> Even for now 10GB is enough, but we can't always assue that. There's not a clear
> restriction about that. I think we can skip this sub-patch. At least we don't
> give others a recommendation which isn't assured by ourselves. So how about only
> merge the 1st patch.

Fine by me. Users will figure it out when running the tests and reading 
the skip reasons.
