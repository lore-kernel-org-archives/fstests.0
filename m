Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D31C433ED
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2404D61139
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhDOJQK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232045AbhDOJQK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Apr 2021 05:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618478147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sO1fL4ehsR6nG7S6/q1DJpk6P+Ovt5svOza0Uzk4S1s=;
        b=UkmC+Y5O5uHXytkqMkiDLoJcvth7vn3STEQDF6aDjHuTAlY2CtSJyOdoBYjX+SH1NRbaYv
        eMeyx4kF0jZz6D88aFqJOhHe4ZnRBholZmjWcWhGeWd+Xr6v5xotMvAN7Y0TaMpPTly0Kl
        ZhT1a1pCQ2JS9USYeist0xasMlBN8KY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-OYA0-qDvMIuuMG62aRe7CQ-1; Thu, 15 Apr 2021 05:15:45 -0400
X-MC-Unique: OYA0-qDvMIuuMG62aRe7CQ-1
Received: by mail-wr1-f72.google.com with SMTP id v20-20020a5d59140000b02901028c7a1f7dso2441769wrd.18
        for <fstests@vger.kernel.org>; Thu, 15 Apr 2021 02:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sO1fL4ehsR6nG7S6/q1DJpk6P+Ovt5svOza0Uzk4S1s=;
        b=UK7ntxkcVXN+x0x2Y1Zt5ptV1TKl5qAYMIVQiUpLz1HScDz+20kWvaRI7S4wM70bxM
         tUs+lWIUzJpJ0oQIVk7POszb33V5c0nxFt2g3cT0AGxDEtfTUYXs4UoSg1zCczTptPci
         pVdCiWHjO2wXXJSh/BXrIAVcEGzDZEUWgFxLeFa1+XYNwhhtktJRHEu34ByHOqjh6uGH
         20CowbjV6XNJUj4uHTkHJElzVN5g2DukMPAQ2uXQhJYD9Snu14y/lNdYRQGAdydpw7Cl
         iYFDM1LFfokRauniPA3xFXY6stfTnvwJF0b3TDreVcBPC9YVABPJJq8Su/OGvZRn8ql7
         0HIQ==
X-Gm-Message-State: AOAM533DhGQsNN1sc7KAEFpbcSp1pqudUp/AbCiz6yH8dFRf6nMiYWIf
        xBq5y9WVIodJQSwS/S71WY3ymlW3YLvYLXekNz7F8UEUs/Cva2S1yLUk9XE1IKm9e9h6XMybjDo
        qzyq8ZyjJbG/HRj2lsg==
X-Received: by 2002:a1c:35c6:: with SMTP id c189mr2084336wma.127.1618478143968;
        Thu, 15 Apr 2021 02:15:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymHReLIupLfHtB/TBOllWl0k2xdAjuIYmT+ZeSQC385DdY5hE6pd3fQmhiIkmBl/RSJLp/hA==
X-Received: by 2002:a1c:35c6:: with SMTP id c189mr2084324wma.127.1618478143850;
        Thu, 15 Apr 2021 02:15:43 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id 200sm1732409wmb.1.2021.04.15.02.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 02:15:43 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] common: hide permision warning from mkswap for
 exfat
To:     Eric Sandeen <sandeen@sandeen.net>, fstests@vger.kernel.org
Cc:     zlang@redhat.com, guan@eryu.me
References: <20210330220005.56019-1-preichl@redhat.com>
 <20210330220005.56019-3-preichl@redhat.com>
 <54667422-1a39-7a78-5dda-e417d0323f52@sandeen.net>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <08ba4497-34c1-e028-a149-4d75a03e0a1c@redhat.com>
Date:   Thu, 15 Apr 2021 11:15:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <54667422-1a39-7a78-5dda-e417d0323f52@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 4/7/21 7:03 PM, Eric Sandeen wrote:
> On 3/30/21 5:00 PM, Pavel Reichl wrote:
>> exfat does not support posix file permisions, so warning from mkswap is
>> inavitable. This patch hides the warning message so the test won't fail.
>>
>> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> 
> hah, I never even thought about swap on exfat ;)
> 
> Assuming it actually works other than this warning, maybe you don't need to
> special case it for exfat? If so just filter that warning for everyone (in the
> same way that the CHATTR isn't special cased for btrfs; we just ignore
> failures there, because they don't matter).
> 
> If there's a real need to special case exfat that's fine, but it might
> be better to not litter special cases around if they aren't material
> to the test.
> 
> also, maybe there is some risk to 2>&1 >> seqres "eating" any other
> potential errors? Or maybe my bash fu is weak. ;)
> 
> I /think/ this will do the trick but give it a shot. It should filter only
> the one string from stderr, and send all of stdout to $seqres.full
> 
> # Ignore permission complaints on filesystems that don't support perms
> $MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full

Works nice, thanks for the hint.

I also applied these comments on patch #3.


> 
> -Eric
> 
>> ---
>>  common/rc | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 9cdfe21c..2d658711 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2392,7 +2392,13 @@ _format_swapfile() {
>>  	# Swap files must be nocow on Btrfs.
>>  	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
>>  	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
>> -	$MKSWAP_PROG "$fname" >> $seqres.full
>> +	if [ "$FSTYP" = "exfat" ]; then
>> +		# exfat does not support posix file permisions, so warning is
>> +		# to be expected
>> +		$MKSWAP_PROG "$fname" 2>&1 | grep -v 'insecure permission' >> $seqres.full
>> +	else
>> +		$MKSWAP_PROG "$fname" >> $seqres.full
>> +	fi
>>  }
>>  
>>  # Check that the filesystem supports swapfiles
>>
> 

