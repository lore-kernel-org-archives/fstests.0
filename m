Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E24C4332F
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Nov 2022 16:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiKWQ2s (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Nov 2022 11:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239129AbiKWQ2H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Nov 2022 11:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C789B8FF82
        for <fstests@vger.kernel.org>; Wed, 23 Nov 2022 08:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669220836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7BHeX9RJgO392P003KV1kq0bq3TinyMTYX+A0SsTNo=;
        b=bLQGS+doAYNbZGN6wc+R/0/kFzZFqCOu5lesgUYBunPxSAgGqA0WKfxrzB3mg453t3C/RP
        V2m1zya0SMO9fKrR08r0VXhGy5pFwITFxAhsItZuwrP+Eb9XINZjc6H+klsdiyIwa/l9ws
        6AzL7U7Lvju0kBQp0S2FkgxYuDfmt4k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-yPckqSEzMZSPr8XGJQedRA-1; Wed, 23 Nov 2022 11:27:14 -0500
X-MC-Unique: yPckqSEzMZSPr8XGJQedRA-1
Received: by mail-pl1-f198.google.com with SMTP id h16-20020a170902f55000b001871b770a83so13923112plf.9
        for <fstests@vger.kernel.org>; Wed, 23 Nov 2022 08:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7BHeX9RJgO392P003KV1kq0bq3TinyMTYX+A0SsTNo=;
        b=m8/dCAlsLfyi9mSn+jiqaDcF6k2V8ogtwiaee9zX9YZk4sUxYgqQsXb2QsPt3JEdxE
         JaQ6AvfJfRC1s6VYj6gDUq16iI4EuPE/24B8yx4vWO19RO/RWE7ROqh8JDbk3+gvgam/
         mflJFDO9MRBuxEU1LF7Jl4mYJSarNWG40OZ6i8dZy1Rv2x+bSAC7x4+64KW60Oj8kpou
         PnCWJ4zlQ84Pt9ggHPKV17mh3oggSpdSDA5q9gyvsK0oQRfmplAHVO9rmXb9HHJYOO6C
         JkHo/jLncg8dnuipQjrNyHIWsD1nfY7vctSxQaxSwgKkFmTJGAJy2Vs8VlkR1pDu3dYT
         VIFg==
X-Gm-Message-State: ANoB5pmxXqvFrJsPgW9IVysvCRaL/8tT0TgBKzjL30leoL2LDNAD4F9f
        j1lN4O/j+GYIsRVBdiOwiUab7mN/rfjQ+HzKg+8/lHdD0hhXbVf5q9z+z2ZJk08fSNeUi+n4PtF
        s8wDplsVSOOxO8MKXKw==
X-Received: by 2002:a62:6d02:0:b0:562:3411:cb3a with SMTP id i2-20020a626d02000000b005623411cb3amr9655269pfc.60.1669220833063;
        Wed, 23 Nov 2022 08:27:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf76qHWLc29H3Zj2fnbljcnGydWkEMobN8qGAIOq2xYP55ucLl7o497jVRcm5mOkd8QZheCPZA==
X-Received: by 2002:a62:6d02:0:b0:562:3411:cb3a with SMTP id i2-20020a626d02000000b005623411cb3amr9655251pfc.60.1669220832798;
        Wed, 23 Nov 2022 08:27:12 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001785fa792f4sm14534837plh.243.2022.11.23.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 08:27:12 -0800 (PST)
Date:   Thu, 24 Nov 2022 00:27:08 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/243: add _require_scratch_delalloc()
Message-ID: <20221123162708.5odsnr7woikadldn@zlang-mailbox>
References: <1669198883-16-1-git-send-email-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669198883-16-1-git-send-email-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 23, 2022 at 10:21:23AM +0000, Xiao Yang wrote:
> xfs/243 requires the delalloc feature of XFS so return [not run]
> when XFS with enabled DAX doesn't support it.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---

Looks good to me, this case starts to fail from xfs dax supports reflink.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/243 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/243 b/tests/xfs/243
> index 8f0c5939..739efe4a 100755
> --- a/tests/xfs/243
> +++ b/tests/xfs/243
> @@ -27,6 +27,7 @@ _begin_fstest auto quick clone punch
>  _supported_fs xfs
>  _require_xfs_debug
>  _require_scratch_reflink
> +_require_scratch_delalloc
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "cowextsize"
>  _require_xfs_io_command "fpunch"
> -- 
> 2.34.1
> 

