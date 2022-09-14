Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9A4ECAAD3
	for <linux-fstests@archiver.kernel.org>; Wed, 14 Sep 2022 06:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiINGGY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 14 Sep 2022 02:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiINGGX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Sep 2022 02:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD18A6567A
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 23:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663135580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEJVt/aSk85Ga0VJqlwpFm7sMse4riuEryaDQ+NEg5U=;
        b=i40/s9op/SY1JvaAxsMV6GUxTGC0NZFHLMvajNtJ/zQ4cP29WHRwXpdyoRAqjsWw20rrzF
        XNWJFbNdFPfbz4mBW9RmXHQqDw8lPscE+Mn8EqhY7wW/RNZiSbHsbVEXXrRMaGfomDtm0l
        gfoGU2qt/F8vonZmUAYEpNzytjL3qEM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-135-WKwy0YgoOMGnmZsEa2GX0g-1; Wed, 14 Sep 2022 02:06:18 -0400
X-MC-Unique: WKwy0YgoOMGnmZsEa2GX0g-1
Received: by mail-qv1-f69.google.com with SMTP id lx4-20020a0562145f0400b00496ecf45ac4so9613269qvb.7
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 23:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qEJVt/aSk85Ga0VJqlwpFm7sMse4riuEryaDQ+NEg5U=;
        b=JOYUQOqtHI8/NsrI31AMMRz02vmGkCa0rcSHXzYIoVEJ66L6bKKBXNmDDk8ebqs+Z0
         puvfq1OR1tTIGkB2pFi3eniHTtPpBdsKEkqxhMJbMyv9dYgMkJfkGUpupDN6m61btR6U
         AWEbxjFxp1RkgWkMPw5QRZNcHdC0ljqHPf6OHOFY7EqgCbu7a5fn4WRB9jj3BCQjRLmZ
         Lzx2qM74aoQDSWBOXJYUZbfWPt8mO5UiXAlxE/0sgw1N3r/c+k18P0E7lAVrfsaP58wj
         wI9qTt57UThsDuAryS1C9V0gj/19rgioFQX5jJPYk13RVlYAk0RqUqmFr1ccUm69qvy3
         Deaw==
X-Gm-Message-State: ACgBeo3/p2/G+Tp6O72J6ZNvYXn6kS1ZoRlXKuBDXOq3bu9n2w4G8zEQ
        Kw6by5gLftDJsFFlUGzJ8uJnPESydshqdAyFSAylaCl3zsJ4LTjaCmWJhpy580rNnX9Xf7ZmuRF
        GZDs4pS8hMP2HbV+dUA==
X-Received: by 2002:a05:622a:ce:b0:343:55cf:443c with SMTP id p14-20020a05622a00ce00b0034355cf443cmr31586450qtw.218.1663135577912;
        Tue, 13 Sep 2022 23:06:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7+nGMktGnuqF5/zrJRT9u6Yxaxvp7Ju5m2bPdksz6gPO5vcel10SA40AKCUsw/q0hLsplwsQ==
X-Received: by 2002:a05:622a:ce:b0:343:55cf:443c with SMTP id p14-20020a05622a00ce00b0034355cf443cmr31586438qtw.218.1663135577678;
        Tue, 13 Sep 2022 23:06:17 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bs14-20020a05620a470e00b006b58d8f6181sm1143515qkb.72.2022.09.13.23.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 23:06:17 -0700 (PDT)
Date:   Wed, 14 Sep 2022 14:06:13 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/1] generic: test i_blocks for truncated large files
Message-ID: <20220914060613.f7srzq6mzple6coj@zlang-mailbox>
References: <20220913125801.56366-1-preichl@redhat.com>
 <20220913125801.56366-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913125801.56366-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 13, 2022 at 02:58:01PM +0200, Pavel Reichl wrote:
> This is a regression test for an incorrect computation of i_blocks for
> truncated files larger than 4 GiB. Bug was filed for exFAT.
> 
> Test is based on reproducer provied by Christophe Vu-Brugier as part
> of kernel patch-fix submission.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---

This version looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/698     | 48 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/698.out |  2 ++
>  2 files changed, 50 insertions(+)
>  create mode 100755 tests/generic/698
>  create mode 100644 tests/generic/698.out
> 
> diff --git a/tests/generic/698 b/tests/generic/698
> new file mode 100755
> index 00000000..337df6c5
> --- /dev/null
> +++ b/tests/generic/698
> @@ -0,0 +1,48 @@
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
> +$XFS_IO_PROG -f -c "pwrite -W 0 5G" $junk_file > /dev/null
> +
> +truncate -s $((4 * 1024 * 1024 * 1024)) $junk_file
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

