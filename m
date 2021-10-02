Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004CCC433F5
	for <linux-fstests@archiver.kernel.org>; Sat,  2 Oct 2021 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDECB61A6F
	for <linux-fstests@archiver.kernel.org>; Sat,  2 Oct 2021 14:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhJBPBo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 2 Oct 2021 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhJBPBo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 2 Oct 2021 11:01:44 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C39C0613EC
        for <fstests@vger.kernel.org>; Sat,  2 Oct 2021 07:59:58 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i13so13674024ilm.4
        for <fstests@vger.kernel.org>; Sat, 02 Oct 2021 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TZyxmNqQL1CC4WybscJw+J5zGLbeE6TRONeXrpjz2XM=;
        b=nNSsV3kB7ba8hMKcUsSX4vjxFB31RED4GJ56HAc0HWFShst1etFI/AaqqZWF9or6fw
         VyUxTtqLqCqHKz7divvkwk+2UsJHnbqltJkZhBqdLtZ5SO1yP2fe+tIqZZgwnLko9vWe
         AEggyzQ0Pb8T56jyQ4+PKeHmzpfeb4I/+DCw52jHmOWXr7J7AB0QiWSeDmM/f+bkYCm2
         ZZmglHfjMnRXI09Q5YxfLhBYq5NwZOhZ9am6Bu4CbeQJESC2I25xXYnyI5YLIYejOIoG
         75467Y9pwHykYSB21PZHBoXQeitsFYgPifaST25FEE0LTPHsBPcSewRSYdMkZz5Qjlbf
         EIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TZyxmNqQL1CC4WybscJw+J5zGLbeE6TRONeXrpjz2XM=;
        b=cZ8N+wIFfpC86n1XsTYBfOXiEv9fb1FRx3eJ2r7D0XoRNi4irF3CXP4Qi+k1m6WP3/
         nXFFkwpuPAOCThI3taEqYzzYLx8CtrRHmnlpD4GeDPejS2xAyK68IfwbpDniUqsh+to5
         So4vg75Gb6ayOkBhkxp1huZmBbAeGG6IF4tYlMM4MkeQVxD27OhkLwiCla5EOeQbKgT7
         +B3iCrST1NEwUqd6PMOOZsPyzUFhx92c2hh8rW0JCp6svzScd9oq1AOc+++j0HAz0S5S
         cMJS8cP3xZrlggMIQ7XLcwz3QoSWmCD/skTZS30RWAf9A2WT+RA+orJf77AIC7jKbg8r
         VIGQ==
X-Gm-Message-State: AOAM530CME3oX9kjM5LQ3BwMejrAROhkCYln9qrX19u27YvfoBeDirOh
        pHx+ZT0aM0mxteyVfD6qge7rhA==
X-Google-Smtp-Source: ABdhPJzbYUpAN8B/MpO9vd19t1yCY2RrvnpHjiSHmr92ytS7935IiGxvcEZgDNpN0F7/QLiX/cWlsg==
X-Received: by 2002:a92:c605:: with SMTP id p5mr2161798ilm.218.1633186798102;
        Sat, 02 Oct 2021 07:59:58 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a12sm5642413ilb.66.2021.10.02.07.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 07:59:57 -0700 (PDT)
Subject: Re: generic/095 failing in ext4 and xfs
To:     Luis Henriques <lhenriques@suse.de>, Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, fio@vger.kernel.org
References: <YVdBVdOjPLCayG1k@suse.de>
 <882f4c20-2e21-219b-0ca3-7e215e2d7cfa@kernel.dk> <YVeE2ZVkpGbTKZpG@mit.edu>
 <86ee93vijj.fsf@orpheus.olymp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f867fa0-c3e9-6f65-d97f-4779c029ef81@kernel.dk>
Date:   Sat, 2 Oct 2021 08:59:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <86ee93vijj.fsf@orpheus.olymp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 10/2/21 4:16 AM, Luis Henriques wrote:
> "Theodore Ts'o" <tytso@mit.edu> writes:
> 
>> On Fri, Oct 01, 2021 at 02:46:09PM -0600, Jens Axboe wrote:
>>>
>>> Hmm, do older versions fail? I see Ted suggested that 3.27 doesn't, can
>>> you give that a go? If that does work, would be great if you could try
>>> and bisect it.
>>
>> I just tried fio 3.28, and it worked for me.  So I don't think it's
>> fio.
> 
> Awesome, thank you both for checking it out.  So, it's definitely
> something in my test environment.
> 
>> Luis, could it be related to a  kernel config option?
> 
> Yeah, it could be.  I've tested this on a rolling release (openSUSE TW),
> so it's definitely quite different from Debian 10.  It may take me a bit
> to figure out what's going on, but I'll start with this kernel config and
> report back any finding.
> 
> Again, thank you both for confirming it's working on your side.

Do you have a core file from fio? Would be interesting to get a
backtrace from it.

In terms of why it's failing, a guess would be that your device is using 4k
sectors and the test is trying to do 1k aligned dio. That would fail, but
it should not cause fio to crash...

-- 
Jens Axboe

