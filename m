Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C74C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Apr 2022 08:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbiD0IJX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Apr 2022 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359408AbiD0IJB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Apr 2022 04:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89208B871
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651046748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uG2V/WA0WBDQP7RakIlijzfJe0G0K3WMFVV0MG5B8HY=;
        b=icIF5Y19fD4rSmRq0Nk3wuhnw9A/HdZDp3FZPn6N/y/e1Km1BB4oW4rw3oZ1gA8ZsjZb89
        I/F13nyRtRpqZL/+eruu3taX4ZMKt+LpxmTEdl7dy3PylsaMEDSZGxTl9zVuo/OqdkYHEB
        zTE+SNn82gjPqSM2eHqPDdDCdp62PXg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-mqq5eaNIO4utAESYOE5Vjw-1; Wed, 27 Apr 2022 04:05:46 -0400
X-MC-Unique: mqq5eaNIO4utAESYOE5Vjw-1
Received: by mail-qt1-f197.google.com with SMTP id f22-20020ac840d6000000b002dd4d87de21so607756qtm.23
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 01:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uG2V/WA0WBDQP7RakIlijzfJe0G0K3WMFVV0MG5B8HY=;
        b=sSQ+0k/4T0YofNUsovRhFU0W7q6/1RO2jTYA6E8O9ZzodJ2VGwy1WNwxozLejbLwzI
         D8TDzybrgOU1ej6nOCVzeH6k/FnXeBB/Epk18XbvgcZxdojA+4/tv5CWUMDmLelIUhDw
         +o9uGKxyvfec7tZ1l/DH7dknsiKru27L6JHFCQgFqaEOm3c7hq2gfGNzvFlkx+B4K0Wc
         YyR6dYCe7/h6bSelhxcnoAp/p5H4ulOGOVZ/uuOXh7M0fPg5xBdoAFaD5D5Gz++Gan91
         svKvwaxGZ2FKFwbUmF2pOxCd34oNFGEZWDePPMiSEsJXzJJuQOj+sa5cUiKQm9vxAHBQ
         1WIQ==
X-Gm-Message-State: AOAM531S3wSVqpyFzkM0v9TMAsWVRk1qfte+L7YSgsYkapZQC5+V/TSq
        s3DJcUb8q4lYNeSr3SZG3MevY0ut+jBT5kLT5sQgwOOIhKUO8+bE2OR4ozRtWJHYoWB3YLgyQ+N
        o0Zm8UmzEGdUu8C/vxw==
X-Received: by 2002:a05:6214:2266:b0:456:2c5a:b45f with SMTP id gs6-20020a056214226600b004562c5ab45fmr13812409qvb.24.1651046745977;
        Wed, 27 Apr 2022 01:05:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+U4dffUVTv+Vx2Ke5RGMQ1g1/6fkSOKAdDpzQF93PB8QlsFhGWKTCSRRXeZXR7wpYoIXk/w==
X-Received: by 2002:a05:6214:2266:b0:456:2c5a:b45f with SMTP id gs6-20020a056214226600b004562c5ab45fmr13812401qvb.24.1651046745751;
        Wed, 27 Apr 2022 01:05:45 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c10-20020ae9e20a000000b0069f88d14596sm1045926qkc.97.2022.04.27.01.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 01:05:45 -0700 (PDT)
Date:   Wed, 27 Apr 2022 16:05:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/054,ext4/055: don't run when using DAX
Message-ID: <20220427080540.o7tu3nz6g5ch6xpt@zlang-mailbox>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
References: <20220427005209.4188220-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427005209.4188220-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 26, 2022 at 08:52:09PM -0400, Theodore Ts'o wrote:
> The ext4/054 and ext4/055 tests create a scratch file system with a 1k
> block size.  This is not compatible with mounting with the DAX option,
> which requires a block size equal to the page size (which is 4k on
> x86).
> 
> Also, the ext4/054 test doesn't use the test device, so remove the
> _require_test declaration.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

Hi Ted,

Thanks for point out this issue. I got a little question about this patch,
feel free to correct me if that's wrong.

"The DAX code currently only supports files with a block size equal to your
kernel's PAGE_SIZE" [1], so I suppose any cases with smaller blocksize (< pagesize)
should "_exclude_scratch_mount_option dax".

And if this supposition is right, we'd better do "skipping dax testing if blocksize
is less than pagesize" in a common helper. Good news is we have _scratch_mkfs_blocksized.
So how about do:
  if [ $blocksize < $pagesize ];then
      _exclude_scratch_mount_option dax
  fi
in _scratch_mkfs_blocksized? then let ext4/054 and ext4/055 turn to use _scratch_mkfs_blocksized.

Thanks,
Zorro


[1]
https://www.kernel.org/doc/Documentation/filesystems/dax.txt

>  tests/ext4/054 | 2 +-
>  tests/ext4/055 | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/ext4/054 b/tests/ext4/054
> index 9a11719f..6c722f32 100755
> --- a/tests/ext4/054
> +++ b/tests/ext4/054
> @@ -19,8 +19,8 @@ _begin_fstest auto quick dangerous_fuzzers
>  
>  # real QA test starts here
>  _supported_fs ext4
> -_require_test
>  _require_scratch_nocheck
> +_exclude_scratch_mount_option dax
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "pwrite"
>  _require_xfs_io_command "fsync"
> diff --git a/tests/ext4/055 b/tests/ext4/055
> index 8f466f1b..1ae42b89 100755
> --- a/tests/ext4/055
> +++ b/tests/ext4/055
> @@ -17,8 +17,9 @@
>  _begin_fstest auto quota
>  
>  # real QA test starts here
> -_require_scratch_nocheck
>  _supported_fs ext4
> +_require_scratch_nocheck
> +_exclude_scratch_mount_option dax
>  _require_user fsgqa
>  _require_user fsgqa2
>  _require_command "$DEBUGFS_PROG" debugfs
> -- 
> 2.31.0
> 

