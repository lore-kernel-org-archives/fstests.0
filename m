Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7153FC433B4
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 10:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382BB61425
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 10:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhDWKL0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Apr 2021 06:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhDWKL0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Apr 2021 06:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619172650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mnKvUTAKb8BTKIMm4leN3BD5Isj52Tuk/KkSRxZBzAs=;
        b=bwG9kNFy43tYQb3W0BUtbFTYBw3/cOHPCHQNCqlYO515bH1A1xLEubP1BPUFVKnDeG/l1c
        Paw7SerOSZiwGFmc1E7X84YXM9JHtJuqMUYB48P8MRDVv81UehL5vMdmuuGYpxpVrSwodo
        E0ii3GPidvkldBr1cXOVrCUxsjOUIWk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-eV1yJKvvNJ6BF_vzoyhjzg-1; Fri, 23 Apr 2021 06:10:46 -0400
X-MC-Unique: eV1yJKvvNJ6BF_vzoyhjzg-1
Received: by mail-wm1-f69.google.com with SMTP id l6-20020a1c25060000b029010ee60ad0fcso6869411wml.9
        for <fstests@vger.kernel.org>; Fri, 23 Apr 2021 03:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mnKvUTAKb8BTKIMm4leN3BD5Isj52Tuk/KkSRxZBzAs=;
        b=chjSuu/sCoHedeXfOyWUNoff2DwmlOTr03YeEQQZSc+yJn4BGPUIA1exT0Rx8eBwYR
         ZSqgzqbAPeb1RqUfF2MTem1pi+PknJh/46Fr3zzQ2/4BcdsJ46uT3zzFTsrYLJMQ5MrP
         w7ZGu8Mtsda1ynWGPmPIbRRzBFM6m5XeAJXKmRDEc5IWhVrj+pzZ9TNNjodxz4PVuNB8
         9OhG8Pqqf1wer4wzNGS7zOiYmo91I7ySJl6wd+2zvhUuwbNbH3cCWi8MVQuQQ0w6s14J
         /LR3A+2+j4g3ThCV8aMGHIJITQDmjQUj37KcuDaodYBsb1EU+tTZKcPUU+R0A+y8kiEv
         6CtA==
X-Gm-Message-State: AOAM533vduX8Kk9K5MksYXUIBi8Qs7pP4pIQ02wZN8TcD40Z1cYLU4Cz
        Qwwvr23U2OHwxb65NaQXttcflnMbqgb6qX8NSV4jljhhARYT/V89wNjfSzw6cDWEl4ThR0ixsep
        cVi1V0SUCH2w4foGv3S9EtPoCMCz6zpqO/HJ7/fnTA2ix8pzsxeh50086mE4svkLsG5MY
X-Received: by 2002:a7b:cd95:: with SMTP id y21mr3436313wmj.85.1619172645341;
        Fri, 23 Apr 2021 03:10:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxauoRA7rR+LWHoc8FfMqAgugLmdkyZEHZYEBC+xZbjzYz6TjoAoOwIufmjfBfOotTDF1s2jw==
X-Received: by 2002:a7b:cd95:: with SMTP id y21mr3436292wmj.85.1619172645147;
        Fri, 23 Apr 2021 03:10:45 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id i133sm10486135wmi.40.2021.04.23.03.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 03:10:44 -0700 (PDT)
Subject: Re: [PATCH] generic/495: split the test
To:     Brian Foster <bfoster@redhat.com>
Cc:     fstests@vger.kernel.org
References: <20210420223044.51214-1-preichl@redhat.com>
 <YIBQeWVBJOj2PY0j@bfoster>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <42a9a826-9ac1-5666-4490-966886f5bc97@redhat.com>
Date:   Fri, 23 Apr 2021 12:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIBQeWVBJOj2PY0j@bfoster>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 4/21/21 6:19 PM, Brian Foster wrote:
> On Wed, Apr 21, 2021 at 12:30:44AM +0200, Pavel Reichl wrote:
...
>> +
>> +rm -f "$SCRATCH_MNT/swap"
> 
> This looks spurious now that the fs is initially clean. Otherwise LGTM:
> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> 

Hi Brian, thanks for the review - your comment was addressed in v2 of this patch, which is on the list already, thanks!

