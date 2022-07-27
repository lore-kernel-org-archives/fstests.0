Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B8EC04A68
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Jul 2022 12:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiG0MHp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Jul 2022 08:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiG0MHp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jul 2022 08:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 893531C123
        for <fstests@vger.kernel.org>; Wed, 27 Jul 2022 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658923660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EPqkkW3iptkB99T8sdQCA3opbpO1omuXsI7/ALoEDz8=;
        b=ikoFXbOrCEFXK+xueRJYGADSD32fa1JGiXe1ME1Fg+RPRImJhSVbLPndBK1XF6DKECxh1L
        6s3l45hO/Gt1d3lPgHVkf4xtVc7hrNyeYpSvB5zaJvA12pm1+RCu3xXOc/5Y2Qdr6CJgk6
        n756yVtD3txG08eQ2rXODQBWCSb7hl4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-rlaRf_fkMvSpgpBDP2c_PQ-1; Wed, 27 Jul 2022 08:07:39 -0400
X-MC-Unique: rlaRf_fkMvSpgpBDP2c_PQ-1
Received: by mail-oo1-f70.google.com with SMTP id a3-20020a4a9b03000000b004284ce89ac2so1500389ook.7
        for <fstests@vger.kernel.org>; Wed, 27 Jul 2022 05:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EPqkkW3iptkB99T8sdQCA3opbpO1omuXsI7/ALoEDz8=;
        b=DjL70WQ5zmOCIFHHRdeaOXQvMxdYFWF+W+vGNI0iWB/13N5d3sGdnSWzaEbDmvF994
         xripauWDlObvwMGhDMyVzzEi/hwBxH8LC5tFQtqRiOWNkfKIvnX/XMRKIoF802mtNIBH
         TjHCmJFVbqZjeRwPf+b7aa36Bazvw1NZZs71CV/o6Q3uBcfnF8lbM7N2kdp/kkFLMBsX
         qDqU3IM7/+WIDIG5s+G1xvCgmkrnuGqov+OFSxzXoB3Z5xlSaGxyNSjX/4u3XPeP42tO
         /XZ5f4sDfkfsq/JdM+Xp4eNCPtOA2rUwzxEJAm9Ja6AcE/UL4tGjTQJsbE67WkR8uYJy
         Mn9w==
X-Gm-Message-State: AJIora/OzvHI7UPoJz/V7+hjx/QP02U5CrCMCTu44zAlMo1DwoAHn6GT
        kJcUWAL9XtwgHDfkBM2WYxfH6AE+2jfOEfVu051DSDSLFoJSoqH6OPEqd4ldSZ+wY6v3F/Ublyj
        gFPNbebvTbn9MKq+0GQ==
X-Received: by 2002:a9d:162:0:b0:61c:af45:b49 with SMTP id 89-20020a9d0162000000b0061caf450b49mr7920760otu.34.1658923658686;
        Wed, 27 Jul 2022 05:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uMxVa9TSemyG8bX/wRpTlkADeke+Jg8TuhXUpjBUAuqJvHt/jftXcKghlbrm2bW4fSZMXFxQ==
X-Received: by 2002:a9d:162:0:b0:61c:af45:b49 with SMTP id 89-20020a9d0162000000b0061caf450b49mr7920750otu.34.1658923658392;
        Wed, 27 Jul 2022 05:07:38 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s6-20020a0568080b0600b0033a6939436bsm7089655oij.9.2022.07.27.05.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 05:07:37 -0700 (PDT)
Date:   Wed, 27 Jul 2022 20:07:32 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5] ext4: resize an ext4 which resize_inode feature is
 disabled but has reserved GDT blocks.
Message-ID: <20220727120732.3645x57voyfozujz@zlang-mailbox>
References: <20220727071140.3886185-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727071140.3886185-1-sunke32@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 27, 2022 at 03:11:40PM +0800, Sun Ke wrote:
> A regression test for b55c3cd102a6 ("ext4: add reserved GDT blocks
> check"). Make sure there's not kernel crash, if resize an ext4 which
> resize_inode feature is disabled but has reserved GDT blocks.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---

This version looks good to me, if no more review points from ext4 list,
I'll merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/ext4/057     | 41 +++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/057.out |  2 ++
>  2 files changed, 43 insertions(+)
>  create mode 100755 tests/ext4/057
>  create mode 100644 tests/ext4/057.out
> 
> diff --git a/tests/ext4/057 b/tests/ext4/057
> new file mode 100755
> index 00000000..969da377
> --- /dev/null
> +++ b/tests/ext4/057
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test 057
> +#
> +# A regression test for b55c3cd102a6 ("ext4: add reserved GDT blocks check").
> +# Make sure there's not kernel crash, if resize an ext4 which resize_inode
> +# feature is disabled but has reserved GDT blocks.
> +#
> +. ./common/preamble
> +_begin_fstest auto resize quick
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_fixed_by_kernel_commit b55c3cd102a6 \
> +	"ext4: add reserved GDT blocks check"
> +
> +_require_command "$RESIZE2FS_PROG" resize2fs
> +_require_command "$DEBUGFS_PROG" debugfs
> +_require_scratch_size_nocheck $((1024 * 1024))
> +
> +# Initalize a 512M ext4 fs with resize_inode feature disabled
> +dev_size=$((512 * 1024 * 1024))
> +MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
> +	>>$seqres.full 2>&1 || _fail "mkfs failed"
> +
> +# Force some reserved GDT blocks to trigger the bug
> +$DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
> +	>>$seqres.full 2>&1
> +$DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
> +	grep "Reserved GDT blocks"
> +
> +_scratch_mount
> +
> +# Expect no crash from this resize operation
> +$RESIZE2FS_PROG $SCRATCH_DEV 1G >> $seqres.full 2>&1
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/057.out b/tests/ext4/057.out
> new file mode 100644
> index 00000000..99423e16
> --- /dev/null
> +++ b/tests/ext4/057.out
> @@ -0,0 +1,2 @@
> +QA output created by 057
> +Reserved GDT blocks:      100
> -- 
> 2.13.6
> 

