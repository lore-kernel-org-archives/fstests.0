Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80987C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jul 2022 05:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiGSFVy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Jul 2022 01:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiGSFVw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jul 2022 01:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE58A2983F
        for <fstests@vger.kernel.org>; Mon, 18 Jul 2022 22:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658208110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2TexJ9jYTQdtpl62jhbcqjuXbNaXGSoyELQQ3gP4T3w=;
        b=bG4K/8sLUeFIXmr6xXYGe+JkmlaND2eVTOGFnmWXdyVQXcaB6vNNlIHKM7heuumUyfQB8z
        sVVgvazRb5sOTVjZJ5ik4UxTROCo8lifRImTeQAcCxlqHM+0DPmhRSc/EdU4nSACKBNH3H
        b4x5GxZpsLmGNvnNW5BxT3hc8nyFzR4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-JgZRcI9qOa6Edc0GUVVabw-1; Tue, 19 Jul 2022 01:21:49 -0400
X-MC-Unique: JgZRcI9qOa6Edc0GUVVabw-1
Received: by mail-qk1-f200.google.com with SMTP id br36-20020a05620a462400b006b5fa8e5dd5so1478788qkb.1
        for <fstests@vger.kernel.org>; Mon, 18 Jul 2022 22:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2TexJ9jYTQdtpl62jhbcqjuXbNaXGSoyELQQ3gP4T3w=;
        b=n8BzznXDPG/K23LvCTHw+XXhcTgrLykLEU2FpHrDnX5TakF/T5NI3sc8GnR8/Ge9Ml
         YeuGSoCGn3bRnF9GL41KD66twEHC5VByU8GbxcUrgm78E7r9DZuqcEsXZH/KM0B7hUbD
         4nk0VgUhLH56YDr2BFBmcOaaHCWN8ioYV3axY2hMiT5vSYlpagDsc1PtzPb32B4e2ghb
         T62kuBtMIXOy30dH2kVbWH5DGy9RxwY7ugEV0dm7WfR0cchekuDA4ppSTftgheGMzzU+
         C9L7aWffrBf3m30zL3iBRsc8bjP9OE1EQioFVU72XNbZYAQdm6bez3AUu3o9l9QiL8cO
         jkeg==
X-Gm-Message-State: AJIora8wnbs8UGdUHaFkvenCF2+/smFZoHyKL4vD9jyQeutfQ/waHC3O
        Q3uCxbfvh6A7nujY7ydJU3AVxMZmtNLQoQRC33udJMSK3M09o0hZDjvIeJrsEyRPXfLiIzuh1tD
        B7ppo5m3nx4U3brnrHA==
X-Received: by 2002:a05:620a:3ce:b0:6b5:b62c:c9f8 with SMTP id r14-20020a05620a03ce00b006b5b62cc9f8mr20059549qkm.620.1658208108627;
        Mon, 18 Jul 2022 22:21:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s638jdCdxONzvNZKL9b81oSM9IKWUjIF+UJULiMMKvPg7VV5tJ0TNbhAKpAH1U+n1Opmb8KQ==
X-Received: by 2002:a05:620a:3ce:b0:6b5:b62c:c9f8 with SMTP id r14-20020a05620a03ce00b006b5b62cc9f8mr20059541qkm.620.1658208108322;
        Mon, 18 Jul 2022 22:21:48 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m12-20020a05620a290c00b006b59ddb4bc5sm13907857qkp.84.2022.07.18.22.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:21:47 -0700 (PDT)
Date:   Tue, 19 Jul 2022 13:21:42 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs/191: test xfs_db get corrupted value
Message-ID: <20220719052142.nr75sxypecvhsdcs@zlang-mailbox>
References: <1657012808-2204-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1657012808-2204-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657012808-2204-2-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 05, 2022 at 05:20:08PM +0800, Yang Xu wrote:
> This is a regression test that xfs_db code doesn't clean up the
> LIBXFS_READBUF_SALVAGE call sites in set_cur so that we
> can't use the return value directly and scraping it out later.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/xfs/191     | 33 +++++++++++++++++++++++++++++++++
>  tests/xfs/191.out |  5 +++++

This seqnum has been taken, please rebase to latest xfstests for-next branch.

>  2 files changed, 38 insertions(+)
>  create mode 100755 tests/xfs/191
>  create mode 100644 tests/xfs/191.out
> 
> diff --git a/tests/xfs/191 b/tests/xfs/191
> new file mode 100755
> index 00000000..98e9e186
> --- /dev/null
> +++ b/tests/xfs/191
> @@ -0,0 +1,33 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> +#
> +# FS QA Test 191
> +#
> +# Regression test for xfsprogs commit
> +# f4afdcb0ad11 ("xfs_db: clean up the salvage read callsites in set_cur()")
> +#
> +# This case test xfs_db whether can get the new magicnum field value even we
> +# just have corrupted this field value.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick

This's a test for xfs_db, so add "db" test group please.

> +
> +# Import common functions.
> +. ./common/filter

Do you use any helpers in common/filter?

> +
> +# real QA test starts here
> +_supported_fs xfs

_require_scratch_nocheck ??

And ...

_fixed_by_git_commit xfsprogs f4afdcb0ad11 \
	"xfs_db: clean up the salvage read callsites in set_cur()"

Thanks,
Zorro

> +
> +_scratch_mkfs_xfs >>$seqres.full 2>&1
> +
> +# write the bad magicnum field value(0) to the superblock
> +_scratch_xfs_set_metadata_field "magicnum" "0" "sb 1"
> +
> +#Even magicnum filed has been corrupted, we still can read this filed value
> +_scratch_xfs_get_metadata_field "magicnum" "sb 1"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/191.out b/tests/xfs/191.out
> new file mode 100644
> index 00000000..71826198
> --- /dev/null
> +++ b/tests/xfs/191.out
> @@ -0,0 +1,5 @@
> +QA output created by 191
> +Allowing write of corrupted data with good CRC
> +magicnum = 0
> +bad magic number
> +0
> -- 
> 2.27.0
> 

