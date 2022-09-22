Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F787C54EE9
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 14:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiIVOGa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIVOG3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 10:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D371AEF0B6
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663855586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaV3FcAeyOL1OdRHWWs6rhuQezcDbRxKhi0c6zaE0No=;
        b=AF1fdDHtLr2vRR3qi7lNPifG2A9UcwbDf+6rpWdQwsc3LFoh31IFY7AaX9+r1RC61AuJyq
        YihO9nvY/dGhxKedZF6et39IkQROVxRJ/Ah7OnoffGdzpSzvyg6l5HVLqU62/IFTVtU14C
        n7hGhgzoNEnFG61MmBCIPBYWHAOdOPc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-383-bcYrrFEsNZmZVvSQHx8Jzw-1; Thu, 22 Sep 2022 10:06:24 -0400
X-MC-Unique: bcYrrFEsNZmZVvSQHx8Jzw-1
Received: by mail-qv1-f69.google.com with SMTP id k10-20020ad4450a000000b004aa116eebe8so6449102qvu.5
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 07:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AaV3FcAeyOL1OdRHWWs6rhuQezcDbRxKhi0c6zaE0No=;
        b=ld5HBJ8iy39WJMSDy03UMKFv2i6WOhEwK8FG55xTXsIzFcefk4AjTw0IViu9PtGn68
         FyKkoxfLH/ijLl628fw5VlsjcyKKXD7nAtoDsowCLjZ9CrXQVElaGW+Ct3Xpgxg6Ut8O
         D4lek/XgDVUPBzhyLwhpV8vnviAvtFozvfqJtoTdELGAJY9nj8RxFcYg/MKzvZtrIEBj
         0UuRYLg83ePhtWTy2nCAir7tBb5wM+X5DZeHoZPmF2ghVlAwMU8J2i5fEieCGAGjmrmG
         HeXEvcoJQXJkm/a/0GqgXH7LW6tYhB035QYZ+uKDmlbAAbt3qHL2AfPRLZySjhgH9NMP
         jo9A==
X-Gm-Message-State: ACrzQf11lb6JQeHr46t7uXDBxR0z8N6R8+XbuqiXgW7FDae7hPN2B8x+
        4MuQo/3+JSv2U5COeat7uHrVNN0QR6eBTBP09o0Sh+FSRVxZCbVP1kXbUbm63nlfUR+XJQSO8Oj
        XNl8jdVe1QtnWZybL+Q==
X-Received: by 2002:a05:6214:29e3:b0:4ad:5de4:accd with SMTP id jv3-20020a05621429e300b004ad5de4accdmr2564858qvb.60.1663855583568;
        Thu, 22 Sep 2022 07:06:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5pq7CXtS/zffCAxB4z3ws3Kbt7UxmkkWqy5fIMZZ+5sfsAXLBFF1xqtAPv9QRaOqkxp26oew==
X-Received: by 2002:a05:6214:29e3:b0:4ad:5de4:accd with SMTP id jv3-20020a05621429e300b004ad5de4accdmr2564825qvb.60.1663855583265;
        Thu, 22 Sep 2022 07:06:23 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bs13-20020a05620a470d00b006b5d9a1d326sm4063584qkb.83.2022.09.22.07.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 07:06:23 -0700 (PDT)
Date:   Thu, 22 Sep 2022 22:06:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v5 2/2] generic: test i_blocks for truncated large files
Message-ID: <20220922140619.gmli4v24pn5zbise@zlang-mailbox>
References: <20220922063836.974796-1-preichl@redhat.com>
 <20220922063836.974796-3-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922063836.974796-3-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 08:38:36AM +0200, Pavel Reichl wrote:
> This is a regression test for an incorrect computation of i_blocks for
> truncated files larger than 4 GiB. Bug was filed for exFAT.
> 
> Test is based on reproducer provied by Christophe Vu-Brugier as part
> of kernel patch-fix submission.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/generic/698     | 51 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/698.out |  2 ++
>  2 files changed, 53 insertions(+)
>  create mode 100755 tests/generic/698
>  create mode 100644 tests/generic/698.out
> 
> diff --git a/tests/generic/698 b/tests/generic/698
> new file mode 100755
> index 00000000..6aeea64e
> --- /dev/null
> +++ b/tests/generic/698
> @@ -0,0 +1,51 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
> +#
> +# FS QA Test 698
> +#
> +# Verify that i_blocks for truncated files larger than 4 GiB have correct
> +# values.
> +#
> +# This test verifies the problem fixed in kernel with commit
> +# 92fba084b79e exfat: fix i_blocks for files truncated over 4 GiB
> +#
> +. ./common/preamble
> +. ./common/filter
> +
> +_begin_fstest auto
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.* $junk_dir
> +}
> +
> +_supported_fs generic
> +_fixed_by_kernel_commit 92fba084b79e \
> +	"exfat: fix i_blocks for files truncated over 4 GiB"
> +
> +_require_test
> +_require_fs_space $TEST_DIR $((5 * 1024 * 1024)) #kB
> +
> +junk_dir=$TEST_DIR/$seq
> +junk_file=$junk_dir/junk
> +mkdir -p $junk_dir
> +
> +_create_file_sized 5G $junk_file
> +if [ $? -ne 0 ]; then
> +	echo "Could not create 5G test file"
> +fi

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +truncate -s 4G $junk_file
> +
> +block_size=`stat -c '%B' $junk_file`
> +iblocks_after_truncate=`stat -c '%b' $junk_file`
> +iblocks_expected=$((4 * 1024 * 1024 * 1024 / $block_size))
> +
> +_within_tolerance "Number of allocated blocks after truncate" $iblocks_after_truncate $iblocks_expected 1% -v
> +
> +status=0
> +
> +exit
> diff --git a/tests/generic/698.out b/tests/generic/698.out
> new file mode 100644
> index 00000000..cbb02d37
> --- /dev/null
> +++ b/tests/generic/698.out
> @@ -0,0 +1,2 @@
> +QA output created by 698
> +Number of allocated blocks after truncate is in range
> -- 
> 2.37.3
> 

