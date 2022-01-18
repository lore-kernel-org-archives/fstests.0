Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57585C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 11:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiARLX3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiARLX2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 06:23:28 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC57C061574
        for <fstests@vger.kernel.org>; Tue, 18 Jan 2022 03:23:28 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id p11-20020a4adfcb000000b002dd4a3e84beso5841308ood.4
        for <fstests@vger.kernel.org>; Tue, 18 Jan 2022 03:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iDwZ7XuZWYQPFU0R7LfxkEApJ4+8HOKg09sERdeGhnM=;
        b=JmsnrU0LxtcDD/O2k2w+tnWn51sUnTIq+uELmEMNnB5VhcExI/Wqc+pIXfpg+zkE1G
         ObMvYQMBw4uw08AkwxJIZOjRZsWNCM04lZ8+NBMjlTH0DPDTRyIlmrVlmdyYz3MOxaZk
         VVhTEecQu5zdNRAsGSf6+y8tN+FrF9a9ckiQ83pXVK2xG3n+IB2c2ARKUKF60SmL/9N+
         8PBZcgXyX0LovEhEPwYoYoqcmDafmyQRvDoZBCyiQlT/ZWeCno/GTwbasz4JrNwg+K21
         78afYJoLuUmkQbCyDBjkzeGcz6gBqMuKS91lAqzKtQ3437ztVQNshEMlu0WrXpXuXLB2
         yDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iDwZ7XuZWYQPFU0R7LfxkEApJ4+8HOKg09sERdeGhnM=;
        b=Orj2YcBimlhG3JaABOg3ZBQWudffiStDCGyVmCeXlyMPnfscAszmxiG3FRVzovKxDk
         PMPUjnKEEtlpMtpOn9heHngDDBhTimvJ3J1Gdx7FYcxEdnIJUARxPZS3JDO/46fnYQC1
         iVPAEKyW+c2kZYg2rK1waVNvsy12TxyKGmUVS3KfycttzjQanX1NPXbdQQvbnOJXiDnJ
         faZTJgMsLPBi8HWbti60EyPcXsS48f9uCyfhryg2z/dR8BObhacWeRmrIKii+x8morJR
         rPBCqoyLRvVIkPfViCajgrS+PFpVNxTrTA71ccTP48T1XD1nU5viDsMr3ys6+V9z926J
         b12g==
X-Gm-Message-State: AOAM530UD4hEfrJlyqUXfUz0FlNDrxqe3PgD0qB0/r/s+0+0Z+Pl5cYS
        oFBwADzycpXU+Qh2bujAVHwdDg==
X-Google-Smtp-Source: ABdhPJx73K7W5fLXomQaZZXJOZlgueYohejotrFA4w9EmtMFsRyR0xopMq+j/HbU1Vdgh752eqrJCg==
X-Received: by 2002:a4a:c44b:: with SMTP id h11mr17855190ooq.54.1642505007923;
        Tue, 18 Jan 2022 03:23:27 -0800 (PST)
Received: from ?IPV6:2804:431:c7cb:989a:d7f1:4df2:e2ef:5281? ([2804:431:c7cb:989a:d7f1:4df2:e2ef:5281])
        by smtp.gmail.com with ESMTPSA id p24sm6823716oto.32.2022.01.18.03.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 03:23:27 -0800 (PST)
Message-ID: <eef02950-b7c2-8ab8-1e19-165383fa99b9@linaro.org>
Date:   Tue, 18 Jan 2022 08:23:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Content-Language: en-US
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "fweimer@redhat.com" <fweimer@redhat.com>
Cc:     "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com>
 <YeY6Uh8I7RlsCicw@mit.edu> <61E64FED.2010906@fujitsu.com>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
In-Reply-To: <61E64FED.2010906@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

  

On 18/01/2022 02:27, xuyang2018.jy--- via Libc-alpha wrote:
> on 2022/1/18 11:56, Theodore Ts'o wrote:
>> On Tue, Jan 18, 2022 at 02:43:26AM +0000, xuyang2018.jy@fujitsu.com wrote:
>>>> You're right of course, but out of curiosity, which C library are you
>>>> using?
>>> I use glibc-2.34.
>>
>> Hmm, ok.  I'm using glibc 2.31, and in this particular program, errno
>> shouldn't have been set by any prior system call.  I'm guessing maybe
>> it was something in crt0 which ended up setting errno?
> It maybe a glibc bug.
> I cc glibc mailing list and see whether they have met this problem.
> 
> @Florian
> 
> Now, I use glibc-2.34 and run the following program[1] but the errno is 
> not 0 in the beginning. So is this a known bug on glibc-2.34(Theodore 
> doesn't meet this problem on glicb-2.31)?
> 
> [1]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/ext4_resize.c

The errno should be only set on a failure, no function shall set errno
to 0 (it is a POSIX definition which glibc adheres).  The application
need to explicitly set errno to 0 before the function call to check if 
an error occurs.

So you need to do:

  errno = 0
  new_size = strtoull(argv[2], &tmp, 10);
  if ((errno) || (*tmp != '\0')) {
    ...
  }

