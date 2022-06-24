Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AF0C43334
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 15:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiFXP1I (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiFXP1F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 11:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF840517EA
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656084423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SfxKYTjphbavSvBNYvCqznKhwv1Ip+H53mD+3pMhBRI=;
        b=cdvZ9qWbm83cjlVd9LLBMAm5RZlziO6j82JdfYXVYT8b4zqVUIeY8As8D7Wf5360L6P5Dn
        u/eGbpI+MjKtk2v0NkSZDq/MPUEZCrURXI6Npx5vL7L0bOWS7CKaZLOLB76OC0vYaRqJDj
        CLW2EFZ2u1rSWtAHN/7ZiBQ8J7pq7hk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-_uhp6Cl5O-6kQY0Nmyl45A-1; Fri, 24 Jun 2022 11:27:02 -0400
X-MC-Unique: _uhp6Cl5O-6kQY0Nmyl45A-1
Received: by mail-qk1-f200.google.com with SMTP id bm2-20020a05620a198200b006a5dac37fa2so2934239qkb.16
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 08:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SfxKYTjphbavSvBNYvCqznKhwv1Ip+H53mD+3pMhBRI=;
        b=LLJUoYVnhfi6ux+7xFXdUd4wdCGL+jIlbPj9Bezzx2Z/gp8qh4AByCn1UQDGAW4/bi
         R/1U7T+xWjBnMDh8PqNFI8axqS2sRnK2BE1K3vPrCrE9xjObUJsoZ5N8VxFhpVGnpGsu
         yOwDbekVnAFeuIsVQMkcXYfAEAGkMQ58gwS4F6Gs0PXpjgtCNNgJdi9e/Rq+U4++MPIX
         JiSpXGnF/Hfm+KhIIgNW/3lmr5fKYeIEBFoKQ9a4ikGAhLat2TtzzMaNdwYa2krMFjfu
         Fv5MSWKtayfRODdwS/HThVrkdOU6W+a8Yu07UVcYC+/RjbayeAhuY8qkAyevpA9aweHO
         9c1g==
X-Gm-Message-State: AJIora8KfexpRZuKBtCoveSf16Z3MM1jNDQBzOagngqRnFKuEbzqwgPU
        eNe0oyEJWwnPYBmIfJMDH8FZvVBlVwTJ+shAjS6kgxtwpz79lNy76ZiZvD4Whf0jpq/SRwCQpWt
        fGa2ON3oD0NcxP09ehdU5987oigwz4/B7YoFfroE9zFj6QHt2uJ04PryW8wlt5+mYSA==
X-Received: by 2002:a05:620a:27d1:b0:6a7:5ab4:4e71 with SMTP id i17-20020a05620a27d100b006a75ab44e71mr10948976qkp.5.1656084421818;
        Fri, 24 Jun 2022 08:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uy+GLL6PCDvFeZyYse4xGEBynXNJ/iTcBYI2vzN2dG0frmVb6PsoH4mzXBNgr4mewmg65FEg==
X-Received: by 2002:a05:620a:27d1:b0:6a7:5ab4:4e71 with SMTP id i17-20020a05620a27d100b006a75ab44e71mr10948949qkp.5.1656084421393;
        Fri, 24 Jun 2022 08:27:01 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r4-20020ac84244000000b00317ca023e33sm1120879qtm.80.2022.06.24.08.26.59
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 08:27:00 -0700 (PDT)
Date:   Fri, 24 Jun 2022 23:26:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fstests: add missing _require_freeze() to tests
Message-ID: <20220624152656.lz3dnufxy3mla4m7@zlang-mailbox>
References: <20220621173729.2135249-1-amir73il@gmail.com>
 <20220621173729.2135249-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621173729.2135249-2-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 21, 2022 at 08:37:27PM +0300, Amir Goldstein wrote:
> And add a few tests that use freeze to the freeze group
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Although there were some different points about if "318, 325, 422, 438"
should be in freeze group, I don't mind having them in freeze group personally.
So ...

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/119 | 1 +
>  tests/xfs/318 | 3 ++-
>  tests/xfs/325 | 3 ++-
>  tests/xfs/422 | 3 ++-
>  tests/xfs/438 | 2 +-
>  tests/xfs/517 | 1 +
>  6 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/119 b/tests/xfs/119
> index a1180371..b6f96601 100755
> --- a/tests/xfs/119
> +++ b/tests/xfs/119
> @@ -20,6 +20,7 @@ _begin_fstest log v2log auto freeze
>  _supported_fs xfs
>  
>  _require_scratch
> +_require_freeze
>  
>  # this may hang
>  sync
> diff --git a/tests/xfs/318 b/tests/xfs/318
> index 38c7aa60..be93f9ab 100755
> --- a/tests/xfs/318
> +++ b/tests/xfs/318
> @@ -7,7 +7,7 @@
>  # Simulate free extent errors with a file write and a file remove.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw
> +_begin_fstest auto quick rw freeze
>  
>  # Override the default cleanup function.
>  _cleanup()
> @@ -26,6 +26,7 @@ _supported_fs xfs
>  _require_scratch
>  _require_error_injection
>  _require_xfs_io_error_injection "rmap_finish_one"
> +_require_freeze
>  
>  blksz=65536
>  blks=64
> diff --git a/tests/xfs/325 b/tests/xfs/325
> index 5b26b2b3..c6861fbc 100755
> --- a/tests/xfs/325
> +++ b/tests/xfs/325
> @@ -8,7 +8,7 @@
>  # Inject an error during extent freeing to test log recovery.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone freeze
>  
>  # Override the default cleanup function.
>  _cleanup()
> @@ -29,6 +29,7 @@ _require_cp_reflink
>  _require_scratch_reflink
>  _require_error_injection
>  _require_xfs_io_error_injection "free_extent"
> +_require_freeze
>  
>  blksz=65536
>  blks=30
> diff --git a/tests/xfs/422 b/tests/xfs/422
> index 175253aa..a83a66df 100755
> --- a/tests/xfs/422
> +++ b/tests/xfs/422
> @@ -9,7 +9,7 @@
>  # activity, so we can't have userspace wandering in and thawing it.
>  #
>  . ./common/preamble
> -_begin_fstest dangerous_scrub dangerous_online_repair
> +_begin_fstest dangerous_scrub dangerous_online_repair freeze
>  
>  _register_cleanup "_cleanup" BUS
>  
> @@ -24,6 +24,7 @@ _require_xfs_scratch_rmapbt
>  _require_xfs_io_command "scrub"
>  _require_xfs_io_error_injection "force_repair"
>  _require_command "$KILLALL_PROG" killall
> +_require_freeze
>  
>  echo "Format and populate"
>  _scratch_mkfs > "$seqres.full" 2>&1
> diff --git a/tests/xfs/438 b/tests/xfs/438
> index c3008b1c..cfe75bd8 100755
> --- a/tests/xfs/438
> +++ b/tests/xfs/438
> @@ -21,7 +21,7 @@
>  # Fixed by upstream commit 373b058 ("xfs: Properly retry failed dquot
>  # items in case of error during buffer writeback")
>  . ./common/preamble
> -_begin_fstest auto quick quota
> +_begin_fstest auto quick quota freeze
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/517 b/tests/xfs/517
> index 88c4f43b..f7f9a8a2 100755
> --- a/tests/xfs/517
> +++ b/tests/xfs/517
> @@ -29,6 +29,7 @@ _supported_fs xfs
>  _require_xfs_scratch_rmapbt
>  _require_xfs_io_command "fsmap"
>  _require_command "$KILLALL_PROG" killall
> +_require_freeze
>  
>  echo "Format and populate"
>  _scratch_mkfs > "$seqres.full" 2>&1
> -- 
> 2.25.1
> 

