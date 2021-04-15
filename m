Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4988C433ED
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2FF61139
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhDOJOr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhDOJOq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Apr 2021 05:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618478063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOuf0yvj8qBC78a8w4Iq5X0GkIScvnP3bSVL6pkdp1A=;
        b=cu/ZcvYS2S3mtAq6JwG0k6vZkn7UI1rP1IZ7EsJBt8/RjZRo7mWUpJSew47FiJcwLfv5iW
        kkqqaljkXgbVP+G5ozZ+qV78953vVxtQRzSeZC08E3sjo+q9c8PIJJmicDqapQlc8MqkW8
        EtSTg9hcXU7Bygn9x/wlUp5svJx/HVM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-msVrSjPZNCeAF6ChHOjsiA-1; Thu, 15 Apr 2021 05:14:21 -0400
X-MC-Unique: msVrSjPZNCeAF6ChHOjsiA-1
Received: by mail-wm1-f69.google.com with SMTP id t83-20020a1cc3560000b029011f8f517694so2669342wmf.3
        for <fstests@vger.kernel.org>; Thu, 15 Apr 2021 02:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOuf0yvj8qBC78a8w4Iq5X0GkIScvnP3bSVL6pkdp1A=;
        b=MjVXEBLiviMSzPwlCCW5ftej6yvnx2RkaTnms+KHBZm8TnUfSm3uYvHU9WvG26PDpX
         MUHg90MZqfDXwc7SR2QZPd9UUINgL8v2ku2VBGsrMzcKZccbJgYgJ27V/MW7A5oEN14g
         Ku4YzJjG0246LPe67Y4RsevEEMAXiu0YujClJVgGq0tF+3cwuuSfBbEA/dpNhe9MzkiI
         ceDwXa1I0sMFryDuOJR1YGShaAW/mH9tYqkwyG+u3Ukbw4aP2gQTyNmjzU247AMfYga+
         oZbrfFLw7q5qTpPwCwiF+XKbRQS1Nwnpp86CRT5reyyEacC9nkOTDts0pCyVKbe0vKPh
         eFSA==
X-Gm-Message-State: AOAM531qbKO0NlyxXA6W/aZzwvZ+vHhM3aoNxurnYe6f6S7249w6UBKs
        tH/brsc3+DiuDbDH3yg5OHPoA17RGe8vlqoJwCWs3p6v7EugJXLKRKMMRf44Ma+e+GgjvofoojO
        cmM9syU6ULcJ38o1XJA==
X-Received: by 2002:a1c:804d:: with SMTP id b74mr2041683wmd.15.1618478060804;
        Thu, 15 Apr 2021 02:14:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa+ts2/7sdWXs1MOoG+kU3pFYx+1m2gYWpRalZb+xcwyGIJuM49bKAFGhCbC49O+9Hbj2ZqA==
X-Received: by 2002:a1c:804d:: with SMTP id b74mr2041672wmd.15.1618478060679;
        Thu, 15 Apr 2021 02:14:20 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id i4sm2088644wrx.56.2021.04.15.02.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 02:14:20 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] generic/003: Amend the test for exfat
To:     Eric Sandeen <sandeen@sandeen.net>, fstests@vger.kernel.org
Cc:     zlang@redhat.com, guan@eryu.me
References: <20210330220005.56019-1-preichl@redhat.com>
 <20210330220005.56019-5-preichl@redhat.com>
 <47a498f6-ae69-7518-717c-8010bf917980@sandeen.net>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <011aa529-4c22-be21-9966-72f66b640cdd@redhat.com>
Date:   Thu, 15 Apr 2021 11:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <47a498f6-ae69-7518-717c-8010bf917980@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 4/7/21 8:03 PM, Eric Sandeen wrote:
> On 3/30/21 5:00 PM, Pavel Reichl wrote:
>> Update the test so it can be run even for exfat which has 2 seconds
>> granularity for access_time and does not have a timestamp for
>> metadata change.
>>
>> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> 
> This looks a whole lot like what I was playing with earlier.  :)

good :-)

> 
> Can you run it say 20 times in a row, and make sure that you don't get
> spurious failures by sleeping for /exactly/ the atime granularity?

I tried that for tens of times and no failure. However, since sleep() does not require integer as the parameter, in the next revision I'll propose something as a 2.1 instead of the 2 to be on the safe side, OK?

> 
> Thanks,
> -Eric
> 

