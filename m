Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF88CC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 17 May 2022 07:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiEQHyw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 03:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiEQHyv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 03:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4885D43493
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652774089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yxpva85gTLFulQ3lnG9lKQhEBc6b4+zx45FyX/LknR8=;
        b=ZxzA17bswHnl/9f7YYnnPMd6pCkBw6zbrHTDWFd5Gvo5pAf0ywvbuJNBSMEIO/T+IVURke
        3BuyWIzsxTTrge0F1Vdx4s7Z0Zen0Kd6IWCGAXMfuRCYjs5QOKUM6rDteQ4ZZyubwzDZyY
        2GvSJ7FtE8+xS5jQmNO3AGYcMmyq8Kw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-iphnOqRZPuihzPr00sQAkQ-1; Tue, 17 May 2022 03:54:48 -0400
X-MC-Unique: iphnOqRZPuihzPr00sQAkQ-1
Received: by mail-qt1-f199.google.com with SMTP id m6-20020ac866c6000000b002f52f9fb4edso9231250qtp.19
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 00:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Yxpva85gTLFulQ3lnG9lKQhEBc6b4+zx45FyX/LknR8=;
        b=Gh2cYUpoQKsEut8thvqX60BSJNGdnEPXykf13xi0rFy4k7x++ykGf9ezv+IcSDrcFx
         aqGeY5sJ5irF3SdoHeEJW/gTu0mzmwzd6HzJRqtoF+w7KFeLiW62kiGx4EXCIPSBtv8s
         LmZWkmsbqtq5cczly7qvGq2xvfJWIbXnrxmovePx/sJw2oS2jz3adP7up7Oe0BYlROx8
         mzz1z+zVtOfFH0TNbkivMGamtqExN+yOPSf+DlPBhm/6bEYbc/ucLi37BJhhwE6bC+ZV
         NrsqGBfCll8LFlD2/QKvLjEzsBoTNGuhTRx0MMiMRx7lhRctTX/1FOWCbNTV/YpAoo4M
         NGbA==
X-Gm-Message-State: AOAM5338eFY2DnKlBMHWT1wRNcp/bb2tI7dOwKrzD70DxrnVyJasNQY3
        DbHhBxm/6ZK7Y92UN3kEdgJzhqzTSVrSn+Hdr2BoKz3hHZr2AQG8D+N0CRkTwpkodb4+BdrPPoQ
        btGPKvmO5JCKhIFXy3g==
X-Received: by 2002:a05:6214:2503:b0:461:cb74:3fad with SMTP id gf3-20020a056214250300b00461cb743fadmr8475266qvb.63.1652774087639;
        Tue, 17 May 2022 00:54:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypgTu+IEpL65tRdlMURsYqRWFJRI6/7xHn2mwTNTJqj5OW5SeY7lKB8NeGHwSI/zR1Zk0PuA==
X-Received: by 2002:a05:6214:2503:b0:461:cb74:3fad with SMTP id gf3-20020a056214250300b00461cb743fadmr8475257qvb.63.1652774087410;
        Tue, 17 May 2022 00:54:47 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t7-20020ac87387000000b002f39b99f6b1sm7170738qtp.75.2022.05.17.00.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 00:54:46 -0700 (PDT)
Date:   Tue, 17 May 2022 15:54:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: add a btrfs read_repair group
Message-ID: <20220517075441.jik7xhwordzq4ydf@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20220517063502.3017563-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517063502.3017563-1-hch@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 17, 2022 at 08:35:02AM +0200, Christoph Hellwig wrote:
> Add a new group to run all tests the exercise the btrfs read_repair code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

There's not objection from me to add this new group for btrfs. If btrfs forks
have more review points, feel free to point out.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  doc/group-names.txt | 1 +
>  tests/btrfs/140     | 2 +-
>  tests/btrfs/141     | 2 +-
>  tests/btrfs/142     | 2 +-
>  tests/btrfs/143     | 2 +-
>  tests/btrfs/150     | 2 +-
>  tests/btrfs/157     | 2 +-
>  tests/btrfs/215     | 2 +-
>  8 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/group-names.txt b/doc/group-names.txt
> index e8e3477e..ef411b5e 100644
> --- a/doc/group-names.txt
> +++ b/doc/group-names.txt
> @@ -88,6 +88,7 @@ punch			fallocate FALLOC_FL_PUNCH_HOLE
>  qgroup			btrfs qgroup feature
>  quota			filesystem usage quotas
>  raid			btrfs RAID
> +read_repair		btrfs error correction on read failure
>  realtime		XFS realtime volumes
>  recoveryloop		crash recovery loops
>  redirect		overlayfs redirect_dir feature
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index 66efc126..c680fe0a 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -12,7 +12,7 @@
>  #	commit 2e949b0a5592 ("Btrfs: fix invalid dereference in btrfs_retry_endio")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index ca164fdc..9fdcb2ab 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -13,7 +13,7 @@
>  #	Commit 9d0d1c8b1c9d ("Btrfs: bring back repair during read")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index c88cace9..58d01add 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -13,7 +13,7 @@
>  #	commit 97bf5a5589aa ("Btrfs: fix segmentation fault when doing dio read")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 8f086ee8..71db861d 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -20,7 +20,7 @@
>  #	commit 9d0d1c8b1c9d ("Btrfs: bring back repair during read")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/150 b/tests/btrfs/150
> index 986c8069..c5e9c709 100755
> --- a/tests/btrfs/150
> +++ b/tests/btrfs/150
> @@ -11,7 +11,7 @@
>  #	Btrfs: fix kernel oops while reading compressed data
>  #
>  . ./common/preamble
> -_begin_fstest auto quick dangerous
> +_begin_fstest auto quick dangerous read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index ae56f3e1..343178b7 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -21,7 +21,7 @@
>  # Btrfs: make raid6 rebuild retry more
>  #
>  . ./common/preamble
> -_begin_fstest auto quick raid
> +_begin_fstest auto quick raid read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> index cbcd60e0..0dcbce2a 100755
> --- a/tests/btrfs/215
> +++ b/tests/btrfs/215
> @@ -9,7 +9,7 @@
>  # 814723e0a55a ("btrfs: increment device corruption error in case of checksum error")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick read_repair
>  
>  # Import common functions.
>  . ./common/filter
> -- 
> 2.30.2
> 

