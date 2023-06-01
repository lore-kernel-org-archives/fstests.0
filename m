Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37721C7EE23
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Jun 2023 09:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjFAJ6c (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 1 Jun 2023 05:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjFAJ6b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Jun 2023 05:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1FB18F
        for <fstests@vger.kernel.org>; Thu,  1 Jun 2023 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685613453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U+fOkF81GGBT+XwLUqOJ0uwq202pRZkLvnKPMCcnTy4=;
        b=RV/CGFxRtShqa8Z+WSgtINXT2nA367mcizDuswF9NpOjx+q1XwK36MmSjE5YCGqxcZ2VNL
        7Y+BVmwDbQusouC8R0xqExPNurd0G5YihCpcHKtHTjY9G3dHzbe9K2EmsZByCoJWwdIRvj
        o9cvfguq8pZFdfUru7noTShs8+brRgE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-sjdD1et8PY-AVrr0BUIpOw-1; Thu, 01 Jun 2023 05:57:32 -0400
X-MC-Unique: sjdD1et8PY-AVrr0BUIpOw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-64d138bd73aso317652b3a.0
        for <fstests@vger.kernel.org>; Thu, 01 Jun 2023 02:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613451; x=1688205451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+fOkF81GGBT+XwLUqOJ0uwq202pRZkLvnKPMCcnTy4=;
        b=TYsLJmI+gx2D8OuhjySyV9NDk8JAmBgBUd3n4i/CIMe+jzlPEa55HY9CLTCINGR0nE
         zM+sef0Z+qxhnEXZPXntH83GyWvmj6KT1RjiWGK7e6za5JHYjuDRkW0ZQBy6m01rzsEW
         5Fu7gC1JESXZfnumWfOjyyok/mMlTUckIaEW7MyHD4M8UplMC/9VjFG1ArXo8sE2kx9f
         X3zkI6l5ISmM1zlsMVHw9WK3r3kWXtkNV5KX5EUaXn8Wf7RpqITi2UHK8itEYOVk4FW+
         ryePPlJDRVIxOatP18eVn49x67nfUPfFxzmO4fye+3QJ98lkJx9h0QjA+3u3/DSo3AXv
         Jpug==
X-Gm-Message-State: AC+VfDzeKRRmRllql9qP880gGTuQdAI9uuXPJHOqJQMA2zGJeYpEMhKL
        bU0INsISrKm1bvAa3udxJXThdC6Z80srAZl/N/cHsB0fwSZw3MVRAxeMP3WOb5ixY6m1q1wqjM3
        xHG8X7vp3p5FFHnbzIqhRw84c6rnRCoU=
X-Received: by 2002:a05:6a00:1741:b0:644:d220:64ac with SMTP id j1-20020a056a00174100b00644d22064acmr7289188pfc.2.1685613450877;
        Thu, 01 Jun 2023 02:57:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44lmB0CY8jK+0Ua129WxwxFhRTX4yjhp01RpMPcZJa2b+thgtFpSLgWxexvZl5EyqNmksCsA==
X-Received: by 2002:a05:6a00:1741:b0:644:d220:64ac with SMTP id j1-20020a056a00174100b00644d22064acmr7289178pfc.2.1685613450606;
        Thu, 01 Jun 2023 02:57:30 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j22-20020aa79296000000b0064f4aeedaa2sm4715801pfa.105.2023.06.01.02.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:57:30 -0700 (PDT)
Date:   Thu, 1 Jun 2023 17:57:26 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/506: fix to call _scratch_enable_pquota()
Message-ID: <20230601095726.74ojdhdrhdkqwdh7@zlang-mailbox>
References: <20230529131741.2642570-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529131741.2642570-1-chao@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 29, 2023 at 09:17:41PM +0800, Chao Yu wrote:
> Otherwise, this testcase will fail due to project quota feature is not
> enabled in the image.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/generic/506 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/506 b/tests/generic/506
> index ec91af78..d4aac68b 100755
> --- a/tests/generic/506
> +++ b/tests/generic/506
> @@ -31,6 +31,7 @@ _require_quota
>  _require_scratch_shutdown
>  
>  _scratch_mkfs >/dev/null 2>&1
> +_scratch_enable_pquota

Make sense,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _require_metadata_journaling $SCRATCH_DEV
>  _qmount_option "prjquota"
>  _qmount
> -- 
> 2.40.1
> 

