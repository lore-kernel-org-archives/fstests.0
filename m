Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD46C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Jul 2022 15:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiGGPBd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbiGGPBN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Jul 2022 11:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B46F4506C
        for <fstests@vger.kernel.org>; Thu,  7 Jul 2022 08:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657206063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEjwd7d59Vip+XraEkqJOwMdNpzSZr9zewfDBOcV6A4=;
        b=DgzqCDVdK8it0eMe/pp7J4aKbHJdyemA1OPBwm1i3+EShPuw7VwrYuQzTEl0HOBD3eguFa
        hJRWl3TOVxwnqB3LU+/VAsAKBK+U2OVUAaqygz0xhb1wP9nOLYWvj5FPbFfl5Wsj38H06i
        QgDVRYimER4lqNNmuRrdPh9p6zd6nGU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-2y1FK9rfMyKHSK5z0-CzLA-1; Thu, 07 Jul 2022 11:00:59 -0400
X-MC-Unique: 2y1FK9rfMyKHSK5z0-CzLA-1
Received: by mail-qk1-f198.google.com with SMTP id bm2-20020a05620a198200b006a5dac37fa2so18074828qkb.16
        for <fstests@vger.kernel.org>; Thu, 07 Jul 2022 08:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rEjwd7d59Vip+XraEkqJOwMdNpzSZr9zewfDBOcV6A4=;
        b=B/kjX5TeBcC5/BqS35trwZdPOk1Phe3u9yigJyRCdZ6gEXVT908yrhrZm8N1VDComG
         MaACzxuqyw+tnRoEIiOHje+JzbvhkqOhUmD854LiU9cwipwfnJhhX1XFmGgFKbuHvf4x
         PLAHSmmCwWd6E+fRlcvcGksZ5UOGx8PohsCsfEiV3QUbTR95HPLZskzjUWZU+oGDzgqe
         L9YUbk+NCVFJnUm3K2IUF5e2ETJnzCOWxwj/RrTZICostwBE7KuOO0i439NXsvC2YYYx
         Hygx9GLCGMG+PTmzwHIX5tGqNZ8GNHmjFpqKJVEUMcuPfhTcLD21HU1H6H0NuwMG+78A
         re7Q==
X-Gm-Message-State: AJIora/OPPg49G0V1qUKqcAQYYdr0pQBLpxyDjXIbvOBM4W41HOdxUG+
        2AuP5AZNWdFQ2bMZ5yQM6SYLmftSOdOP0H2VtRmtQiB7hrk9Xxu+mA+TqGQjb3zy8Rh+uiO4mZg
        gM4U5H2D2Fn7SLSsr2g==
X-Received: by 2002:ad4:5ccd:0:b0:473:10b5:d4d4 with SMTP id iu13-20020ad45ccd000000b0047310b5d4d4mr10103186qvb.19.1657206058766;
        Thu, 07 Jul 2022 08:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tMIiiYJIWUSPOWDxnpBbuUzbGHf3Eji2CByZN7i5YMfNUo16INBToMAJpiFNhui+M5T9aCDg==
X-Received: by 2002:ad4:5ccd:0:b0:473:10b5:d4d4 with SMTP id iu13-20020ad45ccd000000b0047310b5d4d4mr10103107qvb.19.1657206058143;
        Thu, 07 Jul 2022 08:00:58 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a284400b006a787380a5csm33370111qkp.67.2022.07.07.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 08:00:57 -0700 (PDT)
Date:   Thu, 7 Jul 2022 23:00:52 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4/057: resize fs after resize_inode without e2fsck
Message-ID: <20220707150052.a624coefjchegzm6@zlang-mailbox>
References: <20220707135917.373342-1-sunke32@huawei.com>
 <20220707135917.373342-2-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707135917.373342-2-sunke32@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 07, 2022 at 09:59:16PM +0800, Sun Ke wrote:
> Forget to run requested e2fsck after resize_inode, then resize fs, it
> will trigger off null pointer.
> 
> Regression test for commit b55c3cd102a6 ext4: add reserved GDT blocks
> check
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---

Don't use a fixed case number for a new case. It might not be "057" when
I merge it.

>  tests/ext4/057     | 41 +++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/057.out |  2 ++
>  2 files changed, 43 insertions(+)
>  create mode 100755 tests/ext4/057
>  create mode 100644 tests/ext4/057.out
> 
> diff --git a/tests/ext4/057 b/tests/ext4/057
> new file mode 100755
> index 00000000..dacc14be
> --- /dev/null
> +++ b/tests/ext4/057
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test 057
> +#
> +# Forget to run requested e2fsck after resize_inode, then resize fs,
> +# it will trigger off null pointer.
> +#
> +# Regression test for commit
> +# b55c3cd102a6 ext4: add reserved GDT blocks check
> +#
> +. ./common/preamble
> +_begin_fstest auto

This's a "resize" related test, and I think it'll be "quick" enough if you
use smaller fs size to test.

> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs ext4
> +_require_scratch

_fixed_by_kernel_commit() is recommended, if this's a known regression test.

> +_require_command "$TUNE2FS_PROG" tune2fs
> +_require_command "$RESIZE2FS_PROG" resize2
                                             ^^
resize2fs ?

> +
> +
> +# set fs size 3G
> +dev_size=$((3 * 1024 * 1024 * 1024))
> +_scratch_mkfs_sized $dev_size >/dev/null 2>&1
> +
> +# forget to run requested e2fsck after resize_inode
> +$TUNE2FS_PROG -O ^resize_inode $SCRATCH_DEV >/dev/null 2>&1
> +
> +_scratch_mount
> +
> +# resize fs from 3G to 8G

This comment is useless. You can describe what's expected, and what
kind of bug might be trigger at here.

> +$RESIZE2FS_PROG $SCRATCH_DEV 8G >/dev/null 2>&1

Better to print to $seqres.full, to help debug if need.

Better use _require_scratch_size at beginning, to make sure you have enough
space. BTW, do you really need such big size to trigger this bug? Better to
figure out if you can use smaller size (e.g. 512m to 1g) to help this
case always can be run, even with small test devices.

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/057.out b/tests/ext4/057.out
> new file mode 100644
> index 00000000..185023c7
> --- /dev/null
> +++ b/tests/ext4/057.out
> @@ -0,0 +1,2 @@
> +QA output created by 057
> +Silence is golden
> -- 
> 2.13.6
> 

