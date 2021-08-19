Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF745C4338F
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 14:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D221361130
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 14:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbhHSO5J (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:57:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33276 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbhHSO5J (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Aug 2021 10:57:09 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B22B321EF5
        for <fstests@vger.kernel.org>; Thu, 19 Aug 2021 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629384991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53O5cuihZ4pAqNE7l7eS/xjdR3wdHcT4Wp2CUjJpFbE=;
        b=I//Cb1j8pG4AcwBx5yGEV2l3rUVFm9pZ5yx3iyEWYqK0ZnPBu5WWSjJ2ofr+yx9/q5F5zT
        fKm2IBfcViHW4RR8uRGF1y3Y3vsZ6eiZB9v3VwfxkQeZXRMEjzYBRQ5M3ZamwVf/aw3MCB
        BkGuM9auaXY3XScyfLj7CPHyaJygYS4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 95E4413A10
        for <fstests@vger.kernel.org>; Thu, 19 Aug 2021 14:56:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id geC7IR9xHmFBEwAAGKfGzw
        (envelope-from <nborisov@suse.com>)
        for <fstests@vger.kernel.org>; Thu, 19 Aug 2021 14:56:31 +0000
Subject: Re: [PATCH] generic/70: Use scratch device instead of test.
To:     fstests@vger.kernel.org
References: <20210819131355.304528-1-nborisov@suse.com>
 <20210819150050.jweulrtgjeh57wac@fedora>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <0b70908b-9b9f-d606-1d49-45bee40df1ea@suse.com>
Date:   Thu, 19 Aug 2021 17:56:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819150050.jweulrtgjeh57wac@fedora>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 19.08.21 г. 18:00, Zorro Lang wrote:
> On Thu, Aug 19, 2021 at 04:13:55PM +0300, Nikolay Borisov wrote:
>> At the end of the test the fsstress work dir is deleted, this suggests
>> the test really requires a scratch device and not a test device. Change
>> it accordingly.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
> 
> Hmm... is there any more specific reasons to explain why have to change this
> TEST_DIR to SCRATCH_MNT? For example, this test hit ENOSPC in TEST_DIR, or
> it takes too much time to remove $TEST_DIR/fsstress in _cleanup, or use
> SCRATCH_DEV can cover more things, and so on. I think more specific reason
> can help to push this patch be merged. After all there's not a rule says
> if a case don't need to keep its work dir, then must use SCRATCH_DEV. Except
> the maintainer is more inclined to accept that :)

None of the reasons above, I just thought that stuff in $TEST_DEV lives
there so that it can simulate an 'aging' system. In this case this
doesn't seem to be the reason for it as we delete everything.

This patch might very well be moot.
> 
> Thanks,
> Zorro
> 
>>  tests/generic/070 | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/generic/070 b/tests/generic/070
>> index 678344fa011d..c98f445ae4b8 100755
>> --- a/tests/generic/070
>> +++ b/tests/generic/070
>> @@ -13,7 +13,6 @@ _begin_fstest attr udf auto quick stress
>>  _cleanup()
>>  {
>>      cd /
>> -    rm -rf $TEST_DIR/fsstress
>>      rm -f $tmp.*
>>  }
>>  
>> @@ -24,11 +23,14 @@ _cleanup()
>>  # real QA test starts here
>>  _supported_fs generic
>>  
>> -_require_test
>> +_require_scratch
>>  _require_attrs
>>  
>> +_scratch_mkfs >/dev/null 2>&1
>> +_scratch_mount
>> +
>>  FSSTRESS_ARGS=`_scale_fsstress_args \
>> -	-d $TEST_DIR/fsstress \
>> +	-d $SCRATCH_MNT \
>>  	-f allocsp=0 \
>>  	-f freesp=0 \
>>  	-f bulkstat=0 \
>> @@ -40,5 +42,7 @@ FSSTRESS_ARGS=`_scale_fsstress_args \
>>          -p 1 -n 10000 -S c`
>>  $FSSTRESS_PROG $FSSTRESS_ARGS >$seqres.full 2>&1
>>  
>> +_scratch_unmount
>> +
>>  status=$?
>>  exit
>> -- 
>> 2.17.1
>>
> 
