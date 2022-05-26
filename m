Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DE2C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 26 May 2022 06:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiEZGvQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 May 2022 02:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbiEZGvP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 May 2022 02:51:15 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0BEB488
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 23:51:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c1so779302qkf.13
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 23:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0g6XDEbX05UslLYsn1dUCe1tn//dcoUbDdx21KRU2Qs=;
        b=jBru6tpp5x7RcbhnEC0bhZxcCAsg3Cg0i3k6Od/OeWWyQEYR2wVNulDhu51ryGtl2y
         e9onl/YvWQv6EMTsUtqGwmTFqwDJYsb0z3lJdYKvf1zMibLO3vt6ZDX4k/q0OKOaTb3I
         +aRF155Q8acePx+kFEyIFpj9b73wT7wMweUXUiE6jlLAqe+ePEwrKmge571MkaBubGIs
         wtdHWrkoxUWXDFvtaAaueY2dK39HNyx+oiF5Tkcj9vo6Mx/xnh8/HD0HGINt5qoI2H7T
         nXKE80oDusXoo9M3v6RgbxCJbwYBfxVZvuxPxXywP491ZYO5ghywgqq8gdHAq2ZqnCX7
         m1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0g6XDEbX05UslLYsn1dUCe1tn//dcoUbDdx21KRU2Qs=;
        b=cN/hdGrODRYz4UFcNvK03TBmyv2L9V9vUtdnAJSseUlM2QjqLfkyJ/qdMmnqEfiPoV
         ndHLhj+CgQOMFOyy5a7LnRnKL1REtOdMIlFoKZeV+T3XOm55llw051ms8KX+abSonBbD
         22KSkjrbO6jGwNL/sQh2HOFJuVIQX9iammk4gZpPG8tf/pRCLWm6P1OdH31a8D5sZRIC
         5wvalmcYWGl2LjnthCkdyRD3cwkPQXohVCOYzZSSZfjfhv4Km4NYK8d2Xt7Pns/UItfL
         rjMURiNelMWrZO+W7O5O5OHq3ap5hAJh4uJKeNvCaRW/YzLqhwJX2QDTIPdhvYadwCSS
         oLsQ==
X-Gm-Message-State: AOAM5304mWb+veWKlM1qsIAItJopbFq33KoL268tR8wzgltdw02RFzWG
        Y94YluI4pH8LfQjRdxIM74z6moP/HfKeXiZeDQZCocbHDWc=
X-Google-Smtp-Source: ABdhPJz1zju2VHffFp2/sxBURA3HphnXKi7PLjaA8BckwNdWeTXVqQhS820t3Pp0O22ly6NMhh8ObYX06tAEhcgUKf4=
X-Received: by 2002:a37:6cc2:0:b0:6a3:769c:e5ba with SMTP id
 h185-20020a376cc2000000b006a3769ce5bamr14169519qkc.19.1653547872801; Wed, 25
 May 2022 23:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220525073427.3355242-3-zlang@kernel.org> <20220526012317.3624914-1-zlang@kernel.org>
In-Reply-To: <20220526012317.3624914-1-zlang@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 May 2022 09:51:01 +0300
Message-ID: <CAOQ4uxg94oN6DyxCiM-x0_Kwtbpo0Cbi5yARDQxxOOODHLOrBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tests: remove redundant common/$FSTYP importing
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 26, 2022 at 9:47 AM Zorro Lang <zlang@kernel.org> wrote:
>
> As fstests intensively source specific common/$FSTYP files in
> common/rc, at the beginning of ./check running. Each single case
> doesn't need to import that again.
>
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---

Looks fine.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>
> I removed "./common/filter" in btrfs/258 uncarefully, fix that in this V2.
>
> Thanks,
> Zorro
>
>  tests/btrfs/177 | 1 -
>  tests/btrfs/258 | 1 -
>  tests/btrfs/259 | 1 -
>  tests/xfs/422   | 1 -
>  tests/xfs/423   | 1 -
>  tests/xfs/517   | 1 -
>  6 files changed, 6 deletions(-)
>
> diff --git a/tests/btrfs/177 b/tests/btrfs/177
> index 2fd11e89..7b004b83 100755
> --- a/tests/btrfs/177
> +++ b/tests/btrfs/177
> @@ -10,7 +10,6 @@
>  _begin_fstest auto quick swap balance
>
>  . ./common/filter
> -. ./common/btrfs
>
>  # Modify as appropriate.
>  _supported_fs btrfs
> diff --git a/tests/btrfs/258 b/tests/btrfs/258
> index 158eaf79..da073333 100755
> --- a/tests/btrfs/258
> +++ b/tests/btrfs/258
> @@ -10,7 +10,6 @@
>  . ./common/preamble
>  _begin_fstest auto defrag quick
>
> -. ./common/btrfs
>  . ./common/filter
>
>  # real QA test starts here
> diff --git a/tests/btrfs/259 b/tests/btrfs/259
> index e7bd8ddd..92d0b9a6 100755
> --- a/tests/btrfs/259
> +++ b/tests/btrfs/259
> @@ -12,7 +12,6 @@ _begin_fstest auto quick defrag
>
>  # Import common functions.
>  . ./common/filter
> -. ./common/btrfs
>
>  # real QA test starts here
>
> diff --git a/tests/xfs/422 b/tests/xfs/422
> index 77db492e..175253aa 100755
> --- a/tests/xfs/422
> +++ b/tests/xfs/422
> @@ -17,7 +17,6 @@ _register_cleanup "_cleanup" BUS
>  . ./common/filter
>  . ./common/fuzzy
>  . ./common/inject
> -. ./common/xfs
>
>  # real QA test starts here
>  _supported_fs xfs
> diff --git a/tests/xfs/423 b/tests/xfs/423
> index be56f311..c9dfaece 100755
> --- a/tests/xfs/423
> +++ b/tests/xfs/423
> @@ -18,7 +18,6 @@ _register_cleanup "_cleanup" BUS
>  . ./common/filter
>  . ./common/fuzzy
>  . ./common/inject
> -. ./common/xfs
>
>  # real QA test starts here
>  _supported_fs xfs
> diff --git a/tests/xfs/517 b/tests/xfs/517
> index 512f795f..88c4f43b 100755
> --- a/tests/xfs/517
> +++ b/tests/xfs/517
> @@ -23,7 +23,6 @@ _cleanup()
>  . ./common/filter
>  . ./common/fuzzy
>  . ./common/inject
> -. ./common/xfs
>
>  # real QA test starts here
>  _supported_fs xfs
> --
> 2.31.1
>
