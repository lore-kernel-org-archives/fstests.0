Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2614C43334
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Jul 2022 15:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiGHPU0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Jul 2022 11:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbiGHPUZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jul 2022 11:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 713A81C92F
        for <fstests@vger.kernel.org>; Fri,  8 Jul 2022 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657293623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0aso+p9eGYq+v6pFUF5uQ/7lDmfNnHm1Xte8Fgyvtc8=;
        b=XCLF6ctvvasQMQjm0CxZM9ymRG5z4kdy0dSN04kGcGqGyKKY6FCn804C2qixIoCZoGHlI/
        q4qJYveaLONWnY3GuUOoQbgGioJhyJU9rTezWgo3farSIvrc0oA5TxbyBsP8GAiGa6q9rZ
        UBxRfc6BhuB9kKmM7yd5p40/hEhxmgI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-XVTx9F9FPuGNtCrxOqnyKQ-1; Fri, 08 Jul 2022 11:20:22 -0400
X-MC-Unique: XVTx9F9FPuGNtCrxOqnyKQ-1
Received: by mail-qt1-f197.google.com with SMTP id o22-20020ac87c56000000b0031d4ab81b21so14940503qtv.1
        for <fstests@vger.kernel.org>; Fri, 08 Jul 2022 08:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0aso+p9eGYq+v6pFUF5uQ/7lDmfNnHm1Xte8Fgyvtc8=;
        b=X3OmFLQSWtFUH0Z+/rmqeD4erTOV7y/hH1g6FEYb2purKYLLSy8zzlkCT+91iuaUZA
         exrJGJk3EGQYXkHE+4HX5vGp1qFHM2cOUvT3vC268S8DKHgGpi5Btz9Vg7ulz7LKQ3NV
         es/Y+knDTy4Me0hyh3JiFCTE/rhfDtd25fNS3je7Igb++Zd6Eus89oEhaRmY0ZE1vPyx
         /M4KRNC4ZZ5QulHbwYWQz6XO8Fg3DGWqVERVHd6j4SG6RPAStv8vjci7XDEm0oW+2C8H
         nb9GuZ8liUeMro8sK7iIRxelBkoNDyGKGk0GuXUbSV0XQMFhic+4CfxNVP5MmEZOgJNF
         hfgg==
X-Gm-Message-State: AJIora/9Xq3bY3l1/xj4Vd5X6glA0IXHYZ/0XHOCq5MYJMOWhqS5zEHh
        5zvJCVl19JTtvbmx6/yAd8B7Xw4RPnu1dpX9UvIxv9xX2Hjq6qSKOAQbdQDT3TQS4Tuq3ZUPbmR
        MGlKtYRm6kaGNNj5Z+A==
X-Received: by 2002:a05:622a:410:b0:319:4e26:d0bd with SMTP id n16-20020a05622a041000b003194e26d0bdmr3396847qtx.593.1657293621341;
        Fri, 08 Jul 2022 08:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vMObtzyqvcRumQ8pV8PwKAmWMleYQXJ9j77N3yQrCpG6LuJL9UPGjEQByjfTJlQdyJMOgjzQ==
X-Received: by 2002:a05:622a:410:b0:319:4e26:d0bd with SMTP id n16-20020a05622a041000b003194e26d0bdmr3396822qtx.593.1657293621009;
        Fri, 08 Jul 2022 08:20:21 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b19-20020ae9eb13000000b006aee672937esm33742276qkg.37.2022.07.08.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 08:20:20 -0700 (PDT)
Date:   Fri, 8 Jul 2022 23:20:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ext4: set 256 blocks in a block group then apply
 io pressure
Message-ID: <20220708152014.bifm4u2wmdwj3mnf@zlang-mailbox>
References: <20220708112155.2639551-1-sunke32@huawei.com>
 <20220708112155.2639551-3-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708112155.2639551-3-sunke32@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 08, 2022 at 07:21:55PM +0800, Sun Ke wrote:
> Set 256 blocks in a block group, then inject I/O pressure, it will
> trigger off kernel BUG in ext4_mb_mark_diskspace_used.
> 
> Regression test for commit a08f789d2ab5 ext4: fix bug_on
> ext4_mb_use_inode_pa.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  tests/ext4/058     | 33 +++++++++++++++++++++++++++++++++
>  tests/ext4/058.out |  2 ++
>  2 files changed, 35 insertions(+)
>  create mode 100755 tests/ext4/058
>  create mode 100644 tests/ext4/058.out
> 
> diff --git a/tests/ext4/058 b/tests/ext4/058
> new file mode 100755
> index 00000000..b718c1ac
> --- /dev/null
> +++ b/tests/ext4/058
> @@ -0,0 +1,33 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test 058
> +#
> +# Set 256 blocks in a block group, then inject I/O pressure,
> +# it will trigger off kernel BUG in ext4_mb_mark_diskspace_used
> +#
> +# Regression test for commit
> +# a08f789d2ab5 ext4: fix bug_on ext4_mb_use_inode_pa 
> +#
> +. ./common/preamble
> +_begin_fstest auto

quick ?

> +
> +# real QA test starts here
> +
> +_supported_fs ext4
> +_fixed_by_kernel_commit a08f789d2ab5 \
> +	"ext4: fix bug_on ext4_mb_use_inode_pa"
> +_require_scratch
> +
> +# set 256 blocks in a block group
> +_scratch_mkfs -g 256 >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +$FSSTRESS_PROG -d $SCRATCH_MNT/stress -n 1000 >> $seqres.full

Use "2>&1", if you'd like to avoid some fsstress error output break golden image.

BTW, just for make, are you sure this can reproduce that bug? Due to that fix
commit said:
...
    we can easily reproduce this problem with the following commands:
            `fallocate -l100M disk`
            `mkfs.ext4 -b 1024 -g 256 disk`
            `mount disk /mnt`
            `fsstress -d /mnt -l 0 -n 1000 -p 1`
...

It uses "-l 0" to loop run fsstress until hit the bug. You removed the '-l 0',
so are you sure one round `fsstress -n 1000` is enough to reproduce this bug
stably?

Thanks,
Zorro

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/058.out b/tests/ext4/058.out
> new file mode 100644
> index 00000000..fb5ca60b
> --- /dev/null
> +++ b/tests/ext4/058.out
> @@ -0,0 +1,2 @@
> +QA output created by 058
> +Silence is golden
> -- 
> 2.13.6
> 

