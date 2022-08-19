Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27E8C32771
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Aug 2022 14:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349074AbiHSOCQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 19 Aug 2022 10:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349043AbiHSOCP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Aug 2022 10:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20808100F0E
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660917733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1kby7/NcxIBB7/5VD+qii2qG7T73/SNQW5/TiGg6jOU=;
        b=C2MnmBsyMx+HGGK3qHghoZv+9baRRJFpod+R7ZOVmj4jbcxBz2eUdXmAOrvolfqCRG/XGq
        0JxWi/SC90w2a9leqUWt/gBrVp4+h4mVCut5lZteqB2aNaXupyH96H1+M9a1NufCtTkUjO
        DaVTtj3+K61PyK+FrMMf9lj1oMwIfos=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-505-HMWH5fUyN2ipERPPKFM1YA-1; Fri, 19 Aug 2022 10:02:11 -0400
X-MC-Unique: HMWH5fUyN2ipERPPKFM1YA-1
Received: by mail-qt1-f200.google.com with SMTP id fv24-20020a05622a4a1800b003445e593889so3459586qtb.2
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 07:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1kby7/NcxIBB7/5VD+qii2qG7T73/SNQW5/TiGg6jOU=;
        b=zYR5Iu1BFcUqVc0/m+LE7Ok3vDgRqO4PD4i9Z1vm+hFbi3yj5MqC+fiI/N6fRlvZd/
         qZIb1TPOFxLPeNZMR6nH28KMrobtCdf1zHZncT0Fq/25AwpIB8uktPezC3D4S+ugxwxR
         KRUwVBYKeE9640HQwWpZD9pTBJD0LVkN/fwtDeKTkxElvVG33sj6TnxF/OXxftlWKDqz
         6IP8HuBqXAi/8Lo2XFrBae6YbGN847ZoMG/CtxlV+h5svpBsL7JLEJICRe6nTUqeRpam
         sGgwcYvd1+SqsNOjKfWOOkxSv10hXKUKM40BCIe/Gb+UZUVz6Ll3lsGBBgfyUME6vPw6
         IQig==
X-Gm-Message-State: ACgBeo224KvSF1mbsmRK2ieGgtFhXcxGsbU9jhSenqFIOoXQNCJt107T
        p5nEat9U26XBxJKT+A+40DSAXNLps2kLxqLtX3S+5LlsFyXVaKie4MhvHmAavcQihi+aN2/A91v
        UXF3XgQ4A/FrZdhqL3A==
X-Received: by 2002:a05:620a:4055:b0:6bb:5a32:8bcf with SMTP id i21-20020a05620a405500b006bb5a328bcfmr5325510qko.62.1660917730899;
        Fri, 19 Aug 2022 07:02:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6c0yWOPOpSgM+5yei+nerx7VgTKjT8Ch5HOLOHWTq7XIEPdBTgEsrKLcIWRPDhptNBsCuOZw==
X-Received: by 2002:a05:620a:4055:b0:6bb:5a32:8bcf with SMTP id i21-20020a05620a405500b006bb5a328bcfmr5325449qko.62.1660917730102;
        Fri, 19 Aug 2022 07:02:10 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t22-20020a05622a149600b0033aac3da27dsm3290916qtx.19.2022.08.19.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:02:09 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:02:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic: test i_blocks for large files
Message-ID: <20220819140204.6xstolalyxfv6ec3@zlang-mailbox>
References: <Yvu+i1sxTD/KcVjL@magnolia>
 <20220818113905.402441-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818113905.402441-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 18, 2022 at 01:39:05PM +0200, Pavel Reichl wrote:
> This is a regression test for an incorrect
> computation of i_blocks for files larger than
> 4 GiB. Bug was filed for exFAT.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---

This version looks good to me, just a tiny problem, generic/693 has been taken
by current upstream xfstests for-next branch, would you mind rebasing this
patch to latest xfstests?

Anyway you can have:
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/693     | 47 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/693.out |  2 ++
>  2 files changed, 49 insertions(+)
>  create mode 100755 tests/generic/693
>  create mode 100644 tests/generic/693.out
> 
> diff --git a/tests/generic/693 b/tests/generic/693
> new file mode 100755
> index 00000000..29992ed0
> --- /dev/null
> +++ b/tests/generic/693
> @@ -0,0 +1,47 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
> +#
> +# FS QA Test 693
> +#
> +# Verify that i_blocks for files larger than 4 GiB have correct
> +# values.
> +#
> +# This test verifies the problem fixed in kernel with commit
> +# 0c336d6e33f4 exfat: fix incorrect loading of i_blocks for large files
> +#
> +. ./common/preamble
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
> +_require_test
> +_require_fs_space $TEST_DIR $((4 * 1024 * 1024)) #kB
> +
> +echo "Silence is golden"
> +
> +junk_dir=$TEST_DIR/$seq
> +junk_file=$junk_dir/junk
> +mkdir -p $junk_dir
> +
> +$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
> +
> +iblocks=`stat -c '%b' $junk_file`
> +
> +_test_cycle_mount
> +
> +iblocks_after_remount=`stat -c '%b' $junk_file`
> +
> +if [ "$iblocks" != "$iblocks_after_remount" ]; then
> +	echo "Number of blocks needs to be same: $iblocks, $iblocks_after_remount"
> +fi
> +
> +status=0
> +
> +exit
> diff --git a/tests/generic/693.out b/tests/generic/693.out
> new file mode 100644
> index 00000000..01884ea5
> --- /dev/null
> +++ b/tests/generic/693.out
> @@ -0,0 +1,2 @@
> +QA output created by 693
> +Silence is golden
> -- 
> 2.37.2
> 

