Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833AAC433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6164661058
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 14:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhKAORu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Nov 2021 10:17:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48808 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAORu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Nov 2021 10:17:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD23B1FD73
        for <fstests@vger.kernel.org>; Mon,  1 Nov 2021 14:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635776115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wq9SIW3c1AwTNI/NQly9uPItYQFNecchqOfuKA8w0hI=;
        b=KEDYIKzY39jJ1poKXg/Ql/7v7Tm0axkBMjPzIAMHzVybMsQUAAdGX9EFICSz9TwOJPKuxf
        vz4xmU7VrzjAhVw2SxmqZgjynYXSEBbWJ3CsTLo0THV81LaAXxANuAjHkvcDavNX9pgZBE
        Dz4y9Up2Z7Y2MCMI+cHZbcU9BvdVu+Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC2511342A
        for <fstests@vger.kernel.org>; Mon,  1 Nov 2021 14:15:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lzbDKnP2f2GKHwAAMHmgww
        (envelope-from <nborisov@suse.com>)
        for <fstests@vger.kernel.org>; Mon, 01 Nov 2021 14:15:15 +0000
Subject: Re: [PATCH] common/rc: Fix check for SCRATCH_DEV_POOL presence in
 _scratch_dev_pool_get
To:     fstests@vger.kernel.org
References: <20211101133511.383232-1-nborisov@suse.com>
 <20211101135658.385131-1-nborisov@suse.com>
 <20211101142656.cgsxbanon2nvozqa@fedora>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <49c85719-88ca-b621-eab9-983237cc3cc8@suse.com>
Date:   Mon, 1 Nov 2021 16:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211101142656.cgsxbanon2nvozqa@fedora>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 1.11.21 г. 16:26, Zorro Lang wrote:
> On Mon, Nov 01, 2021 at 03:56:58PM +0200, Nikolay Borisov wrote:
>> Current check is buggy because it can never trigger as even if
>> SCRATCH_DEV_POOL is not defined config_ndevs will get a value of 0 from
>> 'wc -w', this in turn makes 'typeset -p config_ndevs' always return 0,
>> triggering the existing check a noop.
>>
>> Fix this by explicitly checking for the presence of SCHRATC_DEV_POOL
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>
>> Eryu,
>>
>> Please use this patch as it's a more proper fix
>>
>>  common/rc | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 7f693d3922e8..07b69880eea6 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -917,15 +917,15 @@ _scratch_dev_pool_get()
>>  		_fail "Usage: _scratch_dev_pool_get ndevs"
>>  	fi
>>
>> -	local test_ndevs=$1
>> -	local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
>> -	local -a devs="( $SCRATCH_DEV_POOL )"
>> -
>> -	typeset -p config_ndevs >/dev/null 2>&1
>> +	typeset -p SCRATCH_DEV_POOL >/dev/null 2>&1
>>  	if [ $? -ne 0 ]; then
>>  		_fail "Bug: cant find SCRATCH_DEV_POOL ndevs"
>>  	fi
>>
>> +	local test_ndevs=$1
>> +	local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
>> +	local -a devs="( $SCRATCH_DEV_POOL )"
> 
> Yes, the logic of:
>      "local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
>       typeset -p config_ndevs >/dev/null 2>&1"
> looks weird.

I can only speculate the idea was that `echo $SCRATCH_DEV_POOL| wc -w`
would fail to declare config_ndevs hence typeset -p config_ndevs would
return != 0, however that's not what is happening.

> 
> Checking SCRATCH_DEV_POOL makes sense to me.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> 
>> +
>>  	if [ $config_ndevs -lt $test_ndevs ]; then
>>  		_notrun "Need at least test requested number of ndevs $test_ndevs"
>>  	fi
>> --
>> 2.17.1
>>
> 
