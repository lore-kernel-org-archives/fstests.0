Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6E7C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 13:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiF2NMi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiF2NMh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 09:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB0361834B
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656508356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PLuhfw6+kCRD8avC+rO3ccblLFA+VsDuouz7Hs/Ly4k=;
        b=IeXnOOpXM5KN3MWGe3rm7ObhFbm0jQoZiscMgBV7GARlM1iD88iNls7/uJkhwHk9rNn+vH
        pzahV2o8YDnVukhlfsWChcNo5zfhy2r6HZ4YeI6TEyIphDEx3E1Pkp0t9lo5w6A2aHDrDj
        Z4Jbbo5UytD/7WfR7oG4nMrzu5ZFPPg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-QZlR1pJxMJispeQNlGHSpg-1; Wed, 29 Jun 2022 09:12:34 -0400
X-MC-Unique: QZlR1pJxMJispeQNlGHSpg-1
Received: by mail-qv1-f72.google.com with SMTP id q7-20020ad44347000000b00472a9743e69so741936qvs.17
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 06:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PLuhfw6+kCRD8avC+rO3ccblLFA+VsDuouz7Hs/Ly4k=;
        b=e18+ca0qfu46i1tIEwxTVuPma6RDj2oBBpKALjuann3+oXqQdVTpMOBj3KK0SwcdZH
         TqCPMhbh8NzoPzFs50b8+6jcal6jETmVhD7LTWCPwBiQ8OoEcQ0Emhld1Ib+r24Dtlyj
         gDsXcJQzX3dVRRvAgDnfCjNI+UxsAlvOe6tfo2G8l8oi6XmhVW0hq1XLxvuYoValY64y
         4zcdqgBn0spm/RNuuIjfuWv7k2w+o+nATZo4sQmge6u+PIO7tRAu/q0e35W7l3zR7o1H
         hJBssDkph58O0vWvi5KDMso3VQsjIFUXHbb0vtUSeplrjrVHEn7I97Zp6bVWHmu0rSxd
         8duQ==
X-Gm-Message-State: AJIora8r3tvIlOzFHqeqE0v2sXzk/QXI3iSuZ3VtIqQJGD6hPvb1/zLP
        jjlbxRSG/yEGRiwiC3wIPISltnoQG26CZzOMqSRVty/gDkbQ2KlouJxZu5Yyxld94GY3Whb7gtL
        KK+BWQvc9Arg5m8zdAA==
X-Received: by 2002:a05:620a:2546:b0:6a7:a299:15cf with SMTP id s6-20020a05620a254600b006a7a29915cfmr1924215qko.28.1656508353727;
        Wed, 29 Jun 2022 06:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u5Lz+pslG8nO6Vx4/Fh+aXPr//8cmgbh6nXR7qFIi08goT8kodtMrArTezPJnofi3PpNpwkg==
X-Received: by 2002:a05:620a:2546:b0:6a7:a299:15cf with SMTP id s6-20020a05620a254600b006a7a29915cfmr1924198qko.28.1656508353442;
        Wed, 29 Jun 2022 06:12:33 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y9-20020a05620a25c900b006a370031c3esm13485608qko.106.2022.06.29.06.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 06:12:32 -0700 (PDT)
Date:   Wed, 29 Jun 2022 21:12:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH -v3 3/7] ext4/045: _require_dumpe2fs doesn't take any
 arguments so remove them
Message-ID: <20220629131228.7dudpbveafjc4kvu@zlang-mailbox>
References: <20220629124540.175775-1-tytso@mit.edu>
 <20220629124540.175775-4-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629124540.175775-4-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 29, 2022 at 08:45:36AM -0400, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/ext4/045 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/045 b/tests/ext4/045
> index ee7c0de3..4f0ad4aa 100755
> --- a/tests/ext4/045
> +++ b/tests/ext4/045
> @@ -22,7 +22,7 @@ _supported_fs ext4
>  _require_scratch
>  _require_test_program "t_create_short_dirs"
>  _require_test_program "t_create_long_dirs"
> -_require_dumpe2fs "$DUMPE2FS_PROG" dumpe2fs
> +_require_dumpe2fs
>  
>  echo "Silence is golden"
>  
> -- 
> 2.31.0
> 

