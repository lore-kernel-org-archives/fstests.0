Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2B0CA0FE1
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Sep 2023 15:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbjIAPpu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 Sep 2023 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjIAPpt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Sep 2023 11:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770FC10E4
        for <fstests@vger.kernel.org>; Fri,  1 Sep 2023 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693583106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7XbrD8tGCXtvHoxqcZU7UP0/DK8Ou+8tHuvT5PdzIc=;
        b=RMzBDaGGsSRb84CnBQYvwd/5K4xHBUZiTUd3iehW7lD3wVeGZwPJC4M+KIoBgGz14SUfgU
        1Jrd9Ckpn2Uwzh4yMgcLNe2oKUDH3CIa4oROajrQ+MfA/jv8oBuAsi2IgwTQsPgaUkydKB
        bncX5CXswKpRd0uM6p97ev5coKXB5FM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-3MUPtxz-O9a6UuV8Oo7E2g-1; Fri, 01 Sep 2023 11:45:05 -0400
X-MC-Unique: 3MUPtxz-O9a6UuV8Oo7E2g-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26f51613d05so2449720a91.2
        for <fstests@vger.kernel.org>; Fri, 01 Sep 2023 08:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693583104; x=1694187904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7XbrD8tGCXtvHoxqcZU7UP0/DK8Ou+8tHuvT5PdzIc=;
        b=LQVf4bycwm4XjcNPW+jFbCjjr7uJsj6FgZcdnZyFwvA2lpFp2+aRVqrefjJRathZAG
         B2hd0/DpajsDl+W/xgX9Z5VSRXtOC2lthodogydWo2x6vOK2zXvwGvf2d7vlAndGEgk4
         sfMw6g4htDjoMMxuWokKRLMsZvOcBnXpwNGs50oZOkG4hTifAqQWMTYq2tsUY6h8itIT
         tPUwgTHfGh04X08R+WnCMZUELaxBzApM9RP9AjU38XF4OGcLReCxDEJpPvwjapuayta/
         V85b7mJ0j3C2pw7cUOD97/0lB0JzmEQfWRszPbosGBRTvE41WX2kxBFh+Fa2Izqwvq+Z
         GtjA==
X-Gm-Message-State: AOJu0Ywypccn+ALNSSTP7jlRhx3ESs1LUtaADYrCnDphTrLdIekeMw3e
        RgPs4djwzsFgIRZJMXnqam3u87s2m6RPOZ2yk8SwMAyqKiw+lbfRg440ulGW7UiAtZv1io9UBxt
        3cd5fDQFA6wrpydUEVA==
X-Received: by 2002:a17:90a:6649:b0:259:10a8:2389 with SMTP id f9-20020a17090a664900b0025910a82389mr2421054pjm.35.1693583104256;
        Fri, 01 Sep 2023 08:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwy2w4BVdve0afH794Zr0zj/YRLJ5XM1fM83AAHAZyvWHGGEbZEtK+07wjGJK2/F1p1ELiWw==
X-Received: by 2002:a17:90a:6649:b0:259:10a8:2389 with SMTP id f9-20020a17090a664900b0025910a82389mr2421044pjm.35.1693583103952;
        Fri, 01 Sep 2023 08:45:03 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090a2a0a00b002694fee879csm5122185pjd.36.2023.09.01.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 08:45:03 -0700 (PDT)
Date:   Fri, 1 Sep 2023 23:45:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] generic/61[67]: support SOAK_DURATION
Message-ID: <20230901154500.4mv37y4uafbzjy7n@zlang-mailbox>
References: <169335094811.3534600.13011878728080983620.stgit@frogsfrogsfrogs>
 <169335095385.3534600.13449847282467855019.stgit@frogsfrogsfrogs>
 <20230901145331.GP28186@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901145331.GP28186@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 01, 2023 at 07:53:31AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Now that I've finally gotten liburing installed on my test machine, I
> can actually test io_uring.  Adapt these two tests to support
> SOAK_DURATION so I can add it to that too.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
> v2: add to soak group
> ---

Thanks! This version looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/616 |    3 ++-
>  tests/generic/617 |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/616 b/tests/generic/616
> index 538b480ba7..5b0b02c5e4 100755
> --- a/tests/generic/616
> +++ b/tests/generic/616
> @@ -8,7 +8,7 @@
>  # fsx ops to limit the testing time to be an auto group test.
>  #
>  . ./common/preamble
> -_begin_fstest auto rw io_uring stress
> +_begin_fstest auto rw io_uring stress soak
>  
>  # Import common functions.
>  . ./common/filter
> @@ -33,6 +33,7 @@ fsx_args+=(-N $nr_ops)
>  fsx_args+=(-p $((nr_ops / 100)))
>  fsx_args+=(-o $op_sz)
>  fsx_args+=(-l $file_sz)
> +test -n "$SOAK_DURATION" && fsx_args+=(--duration="$SOAK_DURATION")
>  
>  run_fsx "${fsx_args[@]}" | sed -e '/^fsx.*/d'
>  
> diff --git a/tests/generic/617 b/tests/generic/617
> index 3bb3112e99..a977870023 100755
> --- a/tests/generic/617
> +++ b/tests/generic/617
> @@ -8,7 +8,7 @@
>  # fsx ops to limit the testing time to be an auto group test.
>  #
>  . ./common/preamble
> -_begin_fstest auto rw io_uring stress
> +_begin_fstest auto rw io_uring stress soak
>  
>  # Import common functions.
>  . ./common/filter
> @@ -39,6 +39,7 @@ fsx_args+=(-r $min_dio_sz)
>  fsx_args+=(-t $min_dio_sz)
>  fsx_args+=(-w $min_dio_sz)
>  fsx_args+=(-Z)
> +test -n "$SOAK_DURATION" && fsx_args+=(--duration="$SOAK_DURATION")
>  
>  run_fsx "${fsx_args[@]}" | sed -e '/^fsx.*/d'
>  
> 

