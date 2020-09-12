Return-Path: <SRS0=iEcW=CV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CD3C433E2
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 06:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CCB21734
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 06:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZQbpmSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgILGxR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbgILGxP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Sep 2020 02:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599893594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r4ij5TzOX05scrhJQag63S6uIrFMicpLHmbtoxa7yn0=;
        b=hZQbpmSIQcAGf3wd6TbOEMXRx1JJN6w3T944ehjsYRMtOemOeRN0ML20L7/FbdfeDdgV76
        jZ48/R3DL4CdgYI1jJsA1oCts6OsoMA2xo1/rInhtSQazA+GkZ5Z3SQhuFF2+yeODZVkEF
        DaMFBfjPT2+ty3bHJWyRfHdoyAXiWxA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-kh3PGYtpMwWbUyHzJLoAPg-1; Sat, 12 Sep 2020 02:53:12 -0400
X-MC-Unique: kh3PGYtpMwWbUyHzJLoAPg-1
Received: by mail-wm1-f71.google.com with SMTP id m20so1383092wmg.6
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 23:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r4ij5TzOX05scrhJQag63S6uIrFMicpLHmbtoxa7yn0=;
        b=HNjgFL5xTImWNaXdSzOvSuONSBH8FzjM4MvY4GMnEsOCBmQPdFMeSUu8CE9uora4aj
         /wPivtVQ0SSdk5aKH6BG/kKkzC1yIwDapH2/oDzsEVg1XfrRguJeHNTPysA7J4/q/gD7
         8qxV9etTWhZixfE5p66krEmYt/YQ6J6w7R1tBZ1VxnrwBGLxxgzSvoX57U+Y47wzoZ3j
         ontxRyKxhCQ6MDLrFLf8Ps4xK9hSjLLfoHLTK82BtaJtdSm591HJL2aDBgXQm9I7Nnso
         +B9ZywQF0B/IMXpdhfRGmRzM0jbZfUdebPXpGbzCoX+qtbmx4hgk7dxorxh9Qv98EayO
         9Baw==
X-Gm-Message-State: AOAM532jqkZZM/n4VU8kwkwRASaSW6jiZjkCk7//YO8C9JIo9seyMpcY
        V/IvVQuVTkKHeCekDJ5/XxMt25EgdT/nXaurw95Arc3yG8gIGqOu9LxviUoWMXtYRLrvkcq1Kjq
        if1LxO7s2v37IbKVlHg==
X-Received: by 2002:a1c:a911:: with SMTP id s17mr5659322wme.77.1599893591006;
        Fri, 11 Sep 2020 23:53:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYHHBiTRlz/NhGTiwuiOl3k+E1ohrjP284vv+O3pC7wC8DJlRmyPKauNjcOvEWi6nhQWnEOQ==
X-Received: by 2002:a1c:a911:: with SMTP id s17mr5659311wme.77.1599893590808;
        Fri, 11 Sep 2020 23:53:10 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id s26sm8751309wmh.44.2020.09.11.23.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:53:10 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
To:     fstests@vger.kernel.org
References: <20200911221514.69318-1-preichl@redhat.com>
 <20200911221514.69318-2-preichl@redhat.com>
 <20200912044759.GI2937@dhcp-12-102.nay.redhat.com>
Cc:     Zorro Lang <zlang@redhat.com>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <96ad0f96-6195-0f6b-a5e8-9e1cb23cfd29@redhat.com>
Date:   Sat, 12 Sep 2020 08:53:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200912044759.GI2937@dhcp-12-102.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 9/12/20 6:47 AM, Zorro Lang wrote:
>> +# This test excercises the problem fixed in kernel with commit
>                  ^^ exercises?
Hi,

I 'took' this phrase from 'tests/generic/086', would:

'This test verifies the problem fixed in kernel with commit...' work better for you?

Thanks!

