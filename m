Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2EFC41513
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 21:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjHNVkp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 17:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjHNVkZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 17:40:25 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BEDE7E
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 14:40:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-564670fad4bso767721a12.1
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692049223; x=1692654023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8gYfVFJHY0AoOS4G/sL+SbmeF6+Tes/KWQvBSs7gUY=;
        b=sJZfgaGj5bY8CMYL7tPRKEzzPAnSBJZbN9IGdizR0eHlz6lnNC+V/9F1N7e0qKhmcu
         r38hAQPdvJvAjAbsiVpUvMocq6xi6dHG+sapC6+yWJ5Fm+zroNjnG7qm6pPeT2eDLO3m
         l4oVO3bGkht4DioXyrgACWDLNBqFMX8UxXbeO4ctJizpUxTWH9hOl7IPJuhC9xBeUfzz
         dkf7Nw6BLb5oAxpXzK3ae1t0jYhCRhSm2mpV3Se1szRirYTbyv9d6Qs2xmmsV1CrA0C5
         oALygkOy0VuToSZrw6PwejubPg7VndXomcjp6PZ12Jpnodg6lMfPTlgjhhBHb7nNKjAm
         vcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692049223; x=1692654023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8gYfVFJHY0AoOS4G/sL+SbmeF6+Tes/KWQvBSs7gUY=;
        b=RnmxVZAa77YWEogmjI2OSFXdT+zlQSXC6OsQDzDxgZAUlZywjwogigsQRRBZZn7gpl
         zU3kJDIpUGE9o1rIVJWfpm6LwhVvO25JFl9BM91UNtHWGbbmnnoaWKC7WvbC/ambZTgP
         X9FujMO2JxEntT48wQ7Tuo/0NppuiebNdXxIBeaBAc6i0iIdaM+BZvMIowur6YiGthPB
         h2wCYJn6Whnp4eoIiPM7TSgCe+cdcnjikoY39NtdgyTsnyj+ijcO5LSFLybJjmc8bQki
         hob1TRdmYOaHKTBPEmHnOj+I/yLFOshwO3VsxkkJF07yyAUZVZKvIePkXOFZqQbGpnOh
         pbQw==
X-Gm-Message-State: AOJu0YzOqkKO7und/iYBR/ShEJKdadP9ItlrzSr/0TVaBFuC5BvHxUn+
        Xz7xQYiTbEUzTSYIhYNuEVBePg==
X-Google-Smtp-Source: AGHT+IFyMA3G5DWP76o7aPHIs+EV5aHkqP2EzW+Girn4tNXH+bGDntBSpwRZF+YHp3dv2AEJZSkzog==
X-Received: by 2002:a17:903:2444:b0:1b8:2ba0:c9a8 with SMTP id l4-20020a170903244400b001b82ba0c9a8mr13217091pls.2.1692049223110;
        Mon, 14 Aug 2023 14:40:23 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b001bba373919bsm9861478plh.261.2023.08.14.14.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 14:40:22 -0700 (PDT)
Message-ID: <fa0e1d60-131d-44ed-beee-a49bd4fdca1a@kernel.dk>
Date:   Mon, 14 Aug 2023 15:40:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/471: Remove this broken case
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, tytso@mit.edu, shr@fb.com
References: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230814153753.GR11377@frogsfrogsfrogs>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230814153753.GR11377@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 8/14/23 9:37 AM, Darrick J. Wong wrote:
> On Mon, Aug 14, 2023 at 10:41:41PM +0800, Yang Xu wrote:
>> I remember this case fails on last year becuase of
>> kernel commit cae2de69 ("iomap: Add async buffered write support")
>> kernel commit 1aa91d9 ("xfs: Add async buffered write support").
>> as below:
>>      pwrite: Resource temporarily unavailable
>>      wrote 8388608/8388608 bytes at offset 0
>>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>     -RWF_NOWAIT time is within limits.
>>     +pwrite: Resource temporarily unavailable
>>     +(standard_in) 1: syntax error
>>     +RWF_NOWAIT took  seconds
>>
>> So For async buffered write requests, the request will return -EAGAIN
>> if the ilock cannot be obtained immediately.
>>
>> Here also a discussion[1] that seems generic/471 has been broken.
>>
>> Now, I met this problem in my linux distribution, then I found the above
>> discussion. IMO, remove this case is ok and then we can avoid to meet this
>> false report again.
>>
>> [1]https://lore.kernel.org/linux-xfs/b2865bd6-2346-8f4d-168b-17f06bbedbed@kernel.dk/
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> Fine with me, since nobody thinks this test does anything useful, nor
> has anyone made it do something useful.

It has never done anything useful, it's a test that was added so that
someone could say they had a test case for a kernel change that they
made. Killing it is the right choice, as I've argued for before.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

