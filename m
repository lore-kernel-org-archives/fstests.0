Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D4AC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 12:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241866AbiARM0R (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbiARM0P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 07:26:15 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E57C061574
        for <fstests@vger.kernel.org>; Tue, 18 Jan 2022 04:26:14 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bb37so483180oib.1
        for <fstests@vger.kernel.org>; Tue, 18 Jan 2022 04:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8DL98jpPDIapok3iVjptY4URlfPRkdaQT3iYbJ7cflk=;
        b=kJVGnCllwxJOcGcB8SNf3brLM6Ei+Q7QFXbIZHD/tK/xkXMgFajFVhyAOpug0PDXIB
         YowyhaD52lR7z0Z51L1u4OlzMpFQX7nk/bi0YKVxnKL1/PQuPx9lTNP9PghAo52SJLRV
         ZuRPJxScH1zRawa2mmUwiUp7ou9QnXU0D8EF6HtYEEnxDQ5qBKC4lKf9yqfZTD3QQ19A
         JqWLnEc4gl1xXQb1ReDMU1eikZ2LAUS6grYiLuiSiplrYLJ80ILv08Dmo+piar3qPq08
         RlVSk6/4/9QhJ+5g13lmRHp9y1LgfbVlUq4lXa5feC9m5gHO4Vh1e9lSFOOHNH49IFu2
         06AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8DL98jpPDIapok3iVjptY4URlfPRkdaQT3iYbJ7cflk=;
        b=CLLv3IrrKx/So/Jq8EL3YpaFvuhvPaXQRYhpqdHpe1yd44sTOFEl8MdmgMCgX+xgkz
         AA5iBF7kS6PN8mVzudFglFntqQH5ZZb2BlSFvvaoVL/a8eZ+9Q+j3TxluZcCn+feQr9K
         0Q2AYINJ7yBIAVsFc8hjgbUye99l2pn/wMxuBrXNdDQF3+/ye0Eb5OHwafMyGf3jlDt7
         INpEoCJPgwOb+Z7yY8amFBh+MfdYah9MPbG9zXF13q0z+ZjRVsyJwfNpwpiMHoLsU9/T
         QXcXgpCJnSZB4L3bX+171OZxpeuv5xfXiIwrTDcgWUH8cGJ+P41ki1328H4KIysT8oLN
         BKcQ==
X-Gm-Message-State: AOAM531IM/qQVjonNwJFcZ9bRlQ/mNENxmMy30AAVW3MINbuzARCKPIC
        7QHWin5U+rjGEAUGLWbz7pgk0A==
X-Google-Smtp-Source: ABdhPJzmGtdsq/2V3RCQUTyczew9Hs59o6dpXHa8aoMrJHjKWkzeNqMrdvUVYC3KaqHtUxna/hQYhQ==
X-Received: by 2002:aca:aa03:: with SMTP id t3mr15641958oie.167.1642508773977;
        Tue, 18 Jan 2022 04:26:13 -0800 (PST)
Received: from ?IPV6:2804:431:c7cb:989a:d7f1:4df2:e2ef:5281? ([2804:431:c7cb:989a:d7f1:4df2:e2ef:5281])
        by smtp.gmail.com with ESMTPSA id 186sm7988930oig.28.2022.01.18.04.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 04:26:13 -0800 (PST)
Message-ID: <3eb845c3-6278-87c5-a6c5-5d7f28ce296c@linaro.org>
Date:   Tue, 18 Jan 2022 09:26:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Content-Language: en-US
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com>
 <YeY6Uh8I7RlsCicw@mit.edu> <61E64FED.2010906@fujitsu.com>
 <eef02950-b7c2-8ab8-1e19-165383fa99b9@linaro.org>
 <87wnixjndg.fsf@oldenburg.str.redhat.com>
 <496a3521-5a0c-b3ae-29bb-02fd0056525b@linaro.org> <875yqh8d2i.fsf@igel.home>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
In-Reply-To: <875yqh8d2i.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 18/01/2022 09:04, Andreas Schwab wrote:
> On Jan 18 2022, Adhemerval Zanella wrote:
> 
>> I think this is a implementation detail, I am not aware that either C or
>> POSIX now states it should initialized to any specific value (in fact, 
>> POSIX at Issue 5 [1] has removed the 'The value of errno is 0 at program 
>> start-up' on its description).
> 
> It's still part of the C standard, though.
> 

And I think it is error-prone, since it requires caller to handle two 
different assumptions (whether the function is called after program 
initialization or after errno might be clobbered).
