Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E26C4320E
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 07:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6F660F46
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 07:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbhHaHj1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Aug 2021 03:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239838AbhHaHjZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Aug 2021 03:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630395510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZUJmQK3iLencUdpQqyvaV464gJfEcleERErEhvC43c=;
        b=h702Z5F8QYtOxEHg3k8Ky9z39nB1eb3bd0vc/Obtll0H8cmSJa5ioBllrjUfzcSVG7RgZb
        g47F7TZqSloqEQ6XZ1eCVx4yO1VsI37qzvj5gqMRn3RNmLOCm5cpbZpXKU9SO7M57s29B1
        2s3HOuaz3L0Optnyi4KAXkNJaWzdLMQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-xhAXUKbGOQa6w4i4TJjKBg-1; Tue, 31 Aug 2021 03:38:28 -0400
X-MC-Unique: xhAXUKbGOQa6w4i4TJjKBg-1
Received: by mail-ed1-f72.google.com with SMTP id b8-20020a056402350800b003c5e3d4e2a7so7824854edd.2
        for <fstests@vger.kernel.org>; Tue, 31 Aug 2021 00:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JZUJmQK3iLencUdpQqyvaV464gJfEcleERErEhvC43c=;
        b=hQEbNES7uUuH+M3Ad4CJpl0TATnAP/++E/7v6ok3dqZmJhYUNQJ5mQXIY5i0CdOc5E
         yjFiWm69iR6iUc04Tr5FMpQTRbIUrehyZ95Cw0PoKLZRHEFo+dVVUuwb2qU41hSIK1pR
         nV/+jan9kz31JzWsmxjZFjxkDNQbZ3dzkn1wUzdadjeGDoPFgOQcKTzVqvQrSSbX/B3z
         LG15aDNmNLdWxE9MfZCva6EIeHRq6cPw2YfFpQahEp/oqhQ78zm42kTStLT4GuflBFcf
         1bfu82UPCptAOFNAa1roHjPCRpoPYjRLNhvUBOISLCL3U9FL96NvI/PB1khyA18o3JdP
         8LoA==
X-Gm-Message-State: AOAM533Mmzh2A3v822Etk9U/qFOalLJ2tr48iPa85Nc/zrS1Wk9kx4CD
        ZUl9HZp4bd30hAhwBRlVI7IgTR192jGFkLvdryWM13Apztl3s5c0UYruMZ8xl+u6rApGhBb8/Ip
        EK+zSV07zr+jr7EFcDw==
X-Received: by 2002:a50:954c:: with SMTP id v12mr28215502eda.313.1630395507378;
        Tue, 31 Aug 2021 00:38:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg4FaBfMRnxD6vRLYTKNNHsGdB7Ik28LPK/SkkLhZqb/JJMpfms/VU1CEd8HfgGFlDzIK2gg==
X-Received: by 2002:a50:954c:: with SMTP id v12mr28215489eda.313.1630395507160;
        Tue, 31 Aug 2021 00:38:27 -0700 (PDT)
Received: from localhost.localdomain (243.206.broadband12.iol.cz. [90.179.206.243])
        by smtp.gmail.com with ESMTPSA id k12sm8752182edo.9.2021.08.31.00.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 00:38:26 -0700 (PDT)
Subject: Re: [PATCH] common/rc: fix MKSWAP_PROG quoting
To:     Murphy Zhou <xzhou@redhat.com>, fstests@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20210831030426.nwcoelcnshq4wrxx@xzhoux.usersys.redhat.com>
 <20210831052632.p4kaygjeujipo4w5@fedora>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <3d064e8a-514d-4a98-3db1-0de490107368@redhat.com>
Date:   Tue, 31 Aug 2021 09:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831052632.p4kaygjeujipo4w5@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 8/31/21 7:26 AM, Zorro Lang wrote:
> On Tue, Aug 31, 2021 at 11:04:26AM +0800, Murphy Zhou wrote:
>> After commit
>>    0e4dd8b9 common/rc: fix ignoring of errors on
>> we are getting this error message when running swapfiles tests:
>>    +./common/rc: line 2553: MKSWAP_PROG: command not found
>>
>> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
>> ---
>>   common/rc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 46b6b220..0597de13 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2550,7 +2550,7 @@ _format_swapfile() {
>>   	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
>>   	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
>>   	# Ignore permission complaints on filesystems that don't support perms
>> -	$(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
>> +	($MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
> The change history is:
>
> Commit 0c95c8ac tried to "hide permision warning", so did:
> -       $MKSWAP_PROG "$fname" >> $seqres.full
> +       # Ignore permission complaints on filesystems that don't support perms
> +       $MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full
>
> Then commit 0e4dd8b9 said "it broke older versions of bash such as 4.4.23", so tried
> to use "a $(foo) to run the executable":
> -       $MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full
> +       $(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
>
> Now this patch try to do ($FOO_PROG):
> ($MKSWAP_PROG "$fname" .....)
>
> I'm *not* a bash expert, if I'm wrong feel free to correct me:) If the original problem
> is trying to hide permision warning from stderr, and to avoid new syntax breaking old
> bash, Why we must struggle with this complex syntax which isn't compatible. How about:

Hi, sorry I do suck at bash, but:

>
> $MKSWAP_PROG "$fname" >> $seqres.full 2>&1 | grep -v "insecure permission"

 >> redirects stdout to the seqres.full and the 2>&1 redirects stderr to 
wherever stdout goes...so $MKSWAP_PROG "$fname" >> $seqres.full 2>&1 
sends both stdout and stderr to the file so nothing is piped to grep. Or 
do I miss something (which is entirely possible)?


Thanks!


>
> Or other better and compatible way ?
>
> Thanks,
> Zorro
>
>>   }
>>   
>>   _swapon_file() {
>> -- 
>> 2.20.1
>>

