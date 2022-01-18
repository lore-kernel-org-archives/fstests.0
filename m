Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44C4C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 11:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiARLtr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbiARLto (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 06:49:44 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7452C061574
        for <fstests@vger.kernel.org>; Tue, 18 Jan 2022 03:49:44 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id s13-20020a4aa38d000000b002e28c5100cbso1878596ool.12
        for <fstests@vger.kernel.org>; Tue, 18 Jan 2022 03:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1VbBObOLLGqJfxH78ojnnRoimELGVhlYXEsooJEJja8=;
        b=iepxeQ6I6QO6Bmi1uDSj0mrBJeJV9L9xlh/IWyeN/8eIk6eovisQOaFAiDzaIE215f
         +BJ6iomzdcUQOR57uzXPGEPo6OZsNqMCmMHJ5DAu9eERaxqYiR/y54lc2lrTNW6eE85L
         4H9324AvunOXNRxT/To7wMtr4Xt3si/U/gYhYDV2eWBWq+YYoMUGzlJNd3g/trS2BEzg
         nirJJNyMMPxEOBGoDjjrQkSFTd1meLmP5CXjI0+0vsNocv5ZgsYCRPeNoBTGScKqJXH9
         eMzDL2uBT3qQR26pyqFQEsqnGj7np/S9f8wK2k+lt8fbS1ldXEzP//p7iJQfUcWtdgeO
         cg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1VbBObOLLGqJfxH78ojnnRoimELGVhlYXEsooJEJja8=;
        b=XxBAncMyq4kS9HZhl42MDYrvj9O+TXqGFdxB84atQFiBkfDo2QjsLG6/LwRREmIT9Z
         cicg8OItozIS3mgWCqC4foc263sIuqDRZ39m+B/+T1FP6+ZTdHz6d5PkDwDt8KZ7BqPS
         Fm+eifiqxMZPSkkeq0lII3ZymrUyeM02juajkCmR2P0uUJBsGGzBarqZgBqn970IDnvt
         SzG1DDVfZT8zySjxqm7K5MZ9g07nefvu3OPVpKgw+YcX2uM2ZerrfQ+/8XNL6eEKTKjM
         ceGBFxKHD6uUoxnCX21VAmm9Zx12oLQmEZf8Qgx8D0hRsS4N9of6RSHRyQpcQ7T5D84l
         PqFw==
X-Gm-Message-State: AOAM530j5cLhcTSi1SrrqiN9jFUKYg1gSltt+IHBaZiVu0A10u/5dPjt
        tBAT//OK2PW3Tu9jSK+U4hNCwg==
X-Google-Smtp-Source: ABdhPJykJNxmBhLGx+ncw7IyH2vlepizZEwbcY5RqpSOYyukNuR1LlRFsrYj4U27wshamgQPaWYhPg==
X-Received: by 2002:a4a:ac0a:: with SMTP id p10mr17732050oon.96.1642506583925;
        Tue, 18 Jan 2022 03:49:43 -0800 (PST)
Received: from ?IPV6:2804:431:c7cb:989a:d7f1:4df2:e2ef:5281? ([2804:431:c7cb:989a:d7f1:4df2:e2ef:5281])
        by smtp.gmail.com with ESMTPSA id i28sm6780997otf.12.2022.01.18.03.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 03:49:43 -0800 (PST)
Message-ID: <496a3521-5a0c-b3ae-29bb-02fd0056525b@linaro.org>
Date:   Tue, 18 Jan 2022 08:49:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com>
 <YeY6Uh8I7RlsCicw@mit.edu> <61E64FED.2010906@fujitsu.com>
 <eef02950-b7c2-8ab8-1e19-165383fa99b9@linaro.org>
 <87wnixjndg.fsf@oldenburg.str.redhat.com>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
In-Reply-To: <87wnixjndg.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 18/01/2022 08:26, Florian Weimer wrote:
> * Adhemerval Zanella:
> 
>>   
>>
>> On 18/01/2022 02:27, xuyang2018.jy--- via Libc-alpha wrote:
>>> on 2022/1/18 11:56, Theodore Ts'o wrote:
>>>> On Tue, Jan 18, 2022 at 02:43:26AM +0000, xuyang2018.jy@fujitsu.com wrote:
>>>>>> You're right of course, but out of curiosity, which C library are you
>>>>>> using?
>>>>> I use glibc-2.34.
>>>>
>>>> Hmm, ok.  I'm using glibc 2.31, and in this particular program, errno
>>>> shouldn't have been set by any prior system call.  I'm guessing maybe
>>>> it was something in crt0 which ended up setting errno?
>>> It maybe a glibc bug.
>>> I cc glibc mailing list and see whether they have met this problem.
>>>
>>> @Florian
>>>
>>> Now, I use glibc-2.34 and run the following program[1] but the errno is 
>>> not 0 in the beginning. So is this a known bug on glibc-2.34(Theodore 
>>> doesn't meet this problem on glicb-2.31)?
>>>
>>> [1]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/ext4_resize.c
>>
>> The errno should be only set on a failure, no function shall set errno
>> to 0 (it is a POSIX definition which glibc adheres).  The application
>> need to explicitly set errno to 0 before the function call to check if 
>> an error occurs.
> 
> While this is true, I think errno should still be 0 at the start of the
> program.

I think this is a implementation detail, I am not aware that either C or
POSIX now states it should initialized to any specific value (in fact, 
POSIX at Issue 5 [1] has removed the 'The value of errno is 0 at program 
start-up' on its description).

In any case, we set errno to be an uninitialized TLS variable.  Unless we
have a bug on .tbss initialization I think the issue is somewhere else.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/errno.html
