Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCEBC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Oct 2021 20:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71EB161AEF
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Oct 2021 20:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355442AbhJAUr5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355332AbhJAUr4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Oct 2021 16:47:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AE5C061775
        for <fstests@vger.kernel.org>; Fri,  1 Oct 2021 13:46:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b78so13156504iof.2
        for <fstests@vger.kernel.org>; Fri, 01 Oct 2021 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3DybLe1RpzKsxnKzIBemCIAZ6AMadRGjezFEaPOKcoc=;
        b=0Mqo6jiy7LSz9NJceKhYYwz+bqIpqn86YEP1lSboYwJsyrCWFDv/zPuusAreK8LrbG
         dOBy6xQbCFWUnsJObIKSGUolFp5JpxVy+iZDnwfjQwkq9+j/kgq9Cfk/PddfFBicXVBe
         0rd4X6Fx2ne9F0PRJlCIOOIS/mZmvNqpFOZf1QSaBXxmORDRUi5cQDOZ7zlkH1Y+cgvA
         PMrEFuspnAugsz6ebvjI5S77M7PiekhFkEoeKAohXo+9ql6L2QtTwpe/hMrsKT4Z/G2l
         1mUOynhnX9wo/GgXxj7XF6oSFe6EhnG1TpL6naVXtsttClWegRM/ili06+pB91QSIPtq
         KFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3DybLe1RpzKsxnKzIBemCIAZ6AMadRGjezFEaPOKcoc=;
        b=fEV3t9v1HSHa1hXkMkIZVClilfuvNsiNY+FDurR7ZVDi8CjBH1oNgwUoH9PLrx9pk0
         RMveV8KzVwSvx6YV8v76mwgHYkABnQKh769GlZv5E2oaFjrib/lo0/+svVFH3CXXqfFv
         lVfI6+N83rdHREOE8ibLUxpDpunIoTCP1B/LkIYGBS0S5VR/raxj9yIJhgwHh1pjMgwV
         ZY+5z5cidqOZSqCk/UfrUB5p8AjsFWiAsOwHlrFUaKxQVW2S9jI+Ohtu0OpQu4IA40i+
         1dd5pvv9tpUdsHtTOeNVhM5jSm/+Loqut+pg4PQnm5ZktikhNwb3l/aRV1FhkWkxnGxg
         gDrA==
X-Gm-Message-State: AOAM530QUM5mtOf3W+Y/R22buIXJ1JlcbEU+8gCdPzHmSrsMxksM6/kJ
        jJt9hzHJLQOXTJ4eKj1NlDohww==
X-Google-Smtp-Source: ABdhPJxRF3HtTAPQy1InC/PX0rp3wBc3cCHRSp5RngTsCHkXQyq7cht+lu3OYkDNBl265bIMoy1VTA==
X-Received: by 2002:a6b:8b52:: with SMTP id n79mr40121iod.8.1633121171288;
        Fri, 01 Oct 2021 13:46:11 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o3sm4144856ilh.5.2021.10.01.13.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 13:46:10 -0700 (PDT)
Subject: Re: generic/095 failing in ext4 and xfs
To:     Luis Henriques <lhenriques@suse.de>, fstests@vger.kernel.org,
        fio@vger.kernel.org
References: <YVdBVdOjPLCayG1k@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <882f4c20-2e21-219b-0ca3-7e215e2d7cfa@kernel.dk>
Date:   Fri, 1 Oct 2021 14:46:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YVdBVdOjPLCayG1k@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 10/1/21 11:11 AM, Luis Henriques wrote:
> Hi!
> 
> I'm seeing generic/095 failing both with ext4 and xfs (but not on btrfs).
> Here's what I'm getting:
> 
> # cat results/generic/095.out.bad 
> QA output created by 095
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: read offset=51200, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: read offset=133120, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file2: Invalid argument: write offset=92160, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file2: Invalid argument: write offset=158720, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file2: Invalid argument: write offset=513024, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file2: Invalid argument: write offset=33792, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file2: Invalid argument: write offset=449536, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: read offset=45056, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: read offset=30720, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: write offset=222208, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: read offset=342016, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: write offset=177152, buflen=1024
> fio: pid=4090, got signal=11
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: write offset=43008, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: write offset=308224, buflen=1024
> fio: pid=4086, got signal=11
> Silence is golden
> 
> This was for ext4 but the output for xfs is similar.  Since fio is getting
> killed I suspect this may be an issue with this tool.  Thus I'm sending
> this to both fio and fstests mailing-lists.
> 
> I'm using a 5.15-rc3 kernel and fio-3.28.  Is anyone else seeing something
> similar?

Hmm, do older versions fail? I see Ted suggested that 3.27 doesn't, can
you give that a go? If that does work, would be great if you could try
and bisect it.

-- 
Jens Axboe

