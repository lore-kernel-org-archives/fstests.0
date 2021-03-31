Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A135C433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 31 Mar 2021 07:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC578619AB
	for <linux-fstests@archiver.kernel.org>; Wed, 31 Mar 2021 07:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhCaHRn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 31 Mar 2021 03:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233830AbhCaHRW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 Mar 2021 03:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617175041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zb+oOaCKp7a/C/I0b5gBfSBwqJ3Ya/T0OtaeB9z/Akw=;
        b=NmDfbIYjjxXph9zoQzFkcnkEe0NNqbSUlTbo6ihJ2Wxt2Vjml0ssOiiKBk+z6xdIM8HzPl
        yLsYrt/Q0wFEsZdz06MZA3A6Sz7BpNSuOZJ2vLLQiZYm5C3+rdlyYXaEkMZuDXh12dy2RM
        4ygU2rP4F9ZODJAATGaSdOxP2lp5t1s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-oxqW04AiPqmKwrZpxbVRoA-1; Wed, 31 Mar 2021 03:17:19 -0400
X-MC-Unique: oxqW04AiPqmKwrZpxbVRoA-1
Received: by mail-wm1-f71.google.com with SMTP id b20so385618wmj.3
        for <fstests@vger.kernel.org>; Wed, 31 Mar 2021 00:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zb+oOaCKp7a/C/I0b5gBfSBwqJ3Ya/T0OtaeB9z/Akw=;
        b=dvI3Ug4plwa/Vt1SQqCvOvgquPpqSIMy889WbelQnDHVxT5nvdsUNImKJL7Aa6z16e
         Ue0hfD7A1PIgBIgAYvkcj+GRIjqCjD7Hjr49yq6G0/1ioNag0ehI2qo4hX5jreUDdjq+
         s7ZrdJrRhi51a0Hu7U6C2+JRrxBjQSpWetPoUubLu99pfazkBeUdY+AiBLK7cr3/PhwD
         dZNjeyrXX2Rn86nei5J6Evty5bAXNl4tnP66dnUwsj6IFGvxbqr24Zzkn0zEnwdDxK5u
         Wmvz5hXQvP5tVBkPdTcPJMnRKM/ilHRo9qFBspJ+Be/g56TfPpPbGRicEJkmLD2iw8PW
         bzKQ==
X-Gm-Message-State: AOAM5315VLU88OKilg3NUh48c+e4Y7JCY6irHytZlgNcCo750wKKB6H8
        NteXNnORf/mGSgZsPfCHU2ArgXXVIYQWB+UB5rK4W4JmOERsYuyvBrTuRxMDDbe1Wo7NVTLIrP9
        6+EcOsjsGCqktSfdUew1MyVr3u1zsTE+o4WpRRDoNBKukVk5ZfW5d9FBmqGTzxUuvSMFY
X-Received: by 2002:adf:f411:: with SMTP id g17mr1905466wro.22.1617175037814;
        Wed, 31 Mar 2021 00:17:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy2QAu0MBkhgj7psjnRMJUukZ4jBO35Ab6YtmgDTo3DG4M3ZLb3VCy5I5mY/3KjopmzciSyg==
X-Received: by 2002:adf:f411:: with SMTP id g17mr1905449wro.22.1617175037639;
        Wed, 31 Mar 2021 00:17:17 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id n7sm2691874wrv.71.2021.03.31.00.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 00:17:17 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] common/rc: Add _require_{chown,chmod,symlink}()
To:     Zorro Lang <zlang@redhat.com>
References: <20210330220005.56019-1-preichl@redhat.com>
 <20210330220005.56019-2-preichl@redhat.com>
 <20210331002521.GP13946@localhost.localdomain>
From:   Pavel Reichl <preichl@redhat.com>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Message-ID: <00b3414f-4833-f0f3-22de-984ad359a57c@redhat.com>
Date:   Wed, 31 Mar 2021 09:17:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210331002521.GP13946@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 3/31/21 2:25 AM, Zorro Lang wrote:
> On Wed, Mar 31, 2021 at 12:00:02AM +0200, Pavel Reichl wrote:
>> Add helper functions that ensure that test is only executed on file
>> systems that implement chown, chmod and symbolic links.
>>
>> +
>> +# check for a symbolic links support
>> +#
>> +_require_symlink()
>> +{
>> +	if [ "$FSTYP" = "exfat" ]; then
>> +		_notrun "symbolic links are not supported on $FSTYP"
>> +	fi
>> +}
> 
> There's _require_symlinks() in common/rc, I remember Eric used it for some
> exfat errors before. Does it work for you?
> 

Hi,

Thanks for the info! Yes, it works. I will fix it in the next version.

I'll just wait for more comments a few days...I guess.

Thanks!

Bye.

