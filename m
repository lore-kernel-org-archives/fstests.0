Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BF0CCA47B
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Jul 2022 15:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbiGNPqS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiGNPqS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Jul 2022 11:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC697AE4E
        for <fstests@vger.kernel.org>; Thu, 14 Jul 2022 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657813575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nU7zfWEWXnIHysvTFuctDerofUMRFZ0vV8sV3Sp5wAQ=;
        b=DPHxGSO3sL3O/3qFRbTAeQJ3FClxcNvz8KTTP3veJRFoE+X1Z4oq9rH6o4fdM0QQWzftSQ
        nmEpfWwyOjgvtbRSJOeyCkm1Fx0hvVn+3gkxIAOLdEHuJR+fFOq8AWh9gQ/9oS1Cjysytl
        jhbn9Jj/CnkA/R01mvoPjMBpKM1ErNY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-GjhY3bvMONa18cy6p8nMEw-1; Thu, 14 Jul 2022 11:46:14 -0400
X-MC-Unique: GjhY3bvMONa18cy6p8nMEw-1
Received: by mail-qt1-f198.google.com with SMTP id m6-20020ac866c6000000b002f52f9fb4edso1743173qtp.19
        for <fstests@vger.kernel.org>; Thu, 14 Jul 2022 08:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nU7zfWEWXnIHysvTFuctDerofUMRFZ0vV8sV3Sp5wAQ=;
        b=Q7bVxkEjsb/MbwMZ9H3NR68QYelFargPAFcYKjIs2lNASFKYS8sJgRTrqsM2qqEjjm
         9MvlnQnUGKGoPx2NZZY7d5QKIiIoGEPOLj3IfSMTC7DleAtoXvqhXKhvX3Qb91jVXSvF
         AenWPE7W84i6iC2NCxAPF3Rm3UdRHckHTtkDnUtGSq6B6nkc1DybiBXclZZG21sS+zDD
         6zo5n/oSiZ5sjE8OkBF+x3bcadqrSi+CqmuBIiSMcW5fG5ieBLTk9VddFmgRvibCv7SG
         2yV27lZ4AKpGU0kv0gaQSNzqDbVSjR6Pk8NIfdyVa+g/7Quzq57FpPK1sc9Emv8y9OMW
         8UiQ==
X-Gm-Message-State: AJIora+mUXcTxz8+bgMfg8LmIuRnixp+QXfio9YEOMaaN5xUaSmkuQzX
        IMovUdOt5uWgukmpDhlY1OmGxAQkEge0aBB/qHwDYCNHKxD/nfSI71S90s39gVTMNF3QYTUdnaZ
        1tcr3/dlRewmuDbbdnA==
X-Received: by 2002:ac8:584e:0:b0:31d:29c8:4296 with SMTP id h14-20020ac8584e000000b0031d29c84296mr8337309qth.51.1657813574378;
        Thu, 14 Jul 2022 08:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uwdXBkUkMY2RlfELdM+3QtIGx7EPxIboN1AE3hxKYkkFtqb35zpDrCzhyEexm2i0md/HHGbg==
X-Received: by 2002:ac8:584e:0:b0:31d:29c8:4296 with SMTP id h14-20020ac8584e000000b0031d29c84296mr8337277qth.51.1657813574012;
        Thu, 14 Jul 2022 08:46:14 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f7-20020ac87f07000000b0031e9ab4e4cesm1762470qtk.26.2022.07.14.08.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:46:13 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:46:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ext4: resize fs after resize_inode without e2fsck
Message-ID: <20220714154607.qq6cqgvncxhsn66w@zlang-mailbox>
References: <20220713092859.3881376-1-sunke32@huawei.com>
 <20220713092859.3881376-2-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713092859.3881376-2-sunke32@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 13, 2022 at 05:28:58PM +0800, Sun Ke wrote:
> Forget to run requested e2fsck after resize_inode, then resize fs, it
> will trigger off null pointer.
> 
> Regression test for commit b55c3cd102a6 ext4: add reserved GDT blocks
> check.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  tests/ext4/057     | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/057.out |  3 +++
>  2 files changed, 47 insertions(+)
>  create mode 100755 tests/ext4/057
>  create mode 100644 tests/ext4/057.out
> 
> diff --git a/tests/ext4/057 b/tests/ext4/057
> new file mode 100755
> index 00000000..44dae76c
> --- /dev/null
> +++ b/tests/ext4/057
> @@ -0,0 +1,44 @@
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
> +_begin_fstest auto resize quick
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs ext4
> +_fixed_by_kernel_commit b55c3cd102a6 \
> +	"ext4: add reserved GDT blocks check"
> +
> +_require_scratch
> +_require_command "$TUNE2FS_PROG" tune2fs
> +_require_command "$RESIZE2FS_PROG" resize2fs
> +_require_scratch_size $((1024 * 1024)) #kB
> +
> +# set fs size 512M
> +dev_size=$((512 * 1024 * 1024))
> +_scratch_mkfs_sized $dev_size >> $seqres.full 2>&1
> +
> +# forget to run requested e2fsck after resize_inode
> +$TUNE2FS_PROG -O ^resize_inode $SCRATCH_DEV | grep -w "e2fsck"
> +
> +_scratch_mount
> +
> +# resize fs will trigger NULL pointer in ext4_flex_group_add
> +$RESIZE2FS_PROG $SCRATCH_DEV 1G >> $seqres.full 2>&1
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/057.out b/tests/ext4/057.out
> new file mode 100644
> index 00000000..4784ad7e
> --- /dev/null
> +++ b/tests/ext4/057.out
> @@ -0,0 +1,3 @@
> +QA output created by 057
> +Please run e2fsck -f on the filesystem.

If you hope to match this line, means this case isn't "Silence is golden".

I don't know why you'd to have this line, it looks not suit to be golden
image. If you'd like to make sure current ext4 supports "resize_inode"
feature, you can use:
  _require_scratch_ext4_feature resize_inode

Thanks,
Zorro

> +Silence is golden
> -- 
> 2.13.6
> 

