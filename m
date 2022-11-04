Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4BDC433FE
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Nov 2022 18:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKDSnS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 4 Nov 2022 14:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiKDSnP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 Nov 2022 14:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47124091D
        for <fstests@vger.kernel.org>; Fri,  4 Nov 2022 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667587336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=87pnTEOF9biYELkFBauUjDZYG1+CC7aKhvv46Owzjic=;
        b=TZ9JWZHN6NqND+yOX0tHklvSUfHs174671Cg9ctZC2SQgM7d0hzt5jp6F7HlrxAauubGMs
        YlFtnnoC5JZmXpuim7a1e+sh4WlFW+XaFJbI0Ao4Dd9vxyR3TsqO7LMqjSFyh5+CgiV+i3
        qVLiXzKTXm7WoPOYU2jFOIz6y5mcsSY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-x_MRCRpINwupN3E3s9xRKw-1; Fri, 04 Nov 2022 14:42:14 -0400
X-MC-Unique: x_MRCRpINwupN3E3s9xRKw-1
Received: by mail-wm1-f71.google.com with SMTP id ay40-20020a05600c1e2800b003cf8aa16377so2646578wmb.7
        for <fstests@vger.kernel.org>; Fri, 04 Nov 2022 11:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87pnTEOF9biYELkFBauUjDZYG1+CC7aKhvv46Owzjic=;
        b=Sk9frxzcqZ0E0krYUWKz4ygujWe1Gs67rKajvVVp4esyeXq3E/t4aL+CrWFPvjjDgG
         jKfWQVGNIaCK6T6gBocElMyN+TqG4lTKpkmaNP1xHsDMuN9y2+peHC9hUsNGtn009nua
         gJWlM8+DDas0BCHPhBcp6sC+3CfdA9CuRKbK+jVeLqBBLD/ob397vAmm0gYO+uE/g/MN
         m8hC8/lemq0ZwoKY3qGxwS7JHrq2Lz4TNNfWiEB0QzxdLa306oZvnGBtyodbdi5Jsevd
         Ibnw/De/nKtAvc9lAutIg4Wn1JjNxE1WMYTFB4GitPCefzEhYsCx/3kHXqEsCfOGORc7
         34kg==
X-Gm-Message-State: ACrzQf1SAuJtRZsJjz4Lx9rtHe0UYy02gervozK3m7fzph7zkpF7YnFr
        11G6roGt894rZ4cdBRvv+BRruan6A6rOp2MrXGV0yWpjvPJiKAH9Rslrl8TvRyS2Y4/N/FA5yT2
        LczPxpRrah+3wF4e/
X-Received: by 2002:a7b:cc13:0:b0:3cf:8297:d61 with SMTP id f19-20020a7bcc13000000b003cf82970d61mr13620959wmh.160.1667587333313;
        Fri, 04 Nov 2022 11:42:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4NA2+0N/kvJL4Q/IIzqQDJXya3171CEFvrgUB939lSOBPFDvlZ04D6Pvu9k8wOCSu1fjf+bQ==
X-Received: by 2002:a7b:cc13:0:b0:3cf:8297:d61 with SMTP id f19-20020a7bcc13000000b003cf82970d61mr13620947wmh.160.1667587333092;
        Fri, 04 Nov 2022 11:42:13 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id bw9-20020a0560001f8900b00236c1f2cecesm49989wrb.81.2022.11.04.11.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:42:12 -0700 (PDT)
Date:   Fri, 4 Nov 2022 19:42:10 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [xfstests PATCH 1/3] common/verity: fix
 _fsv_have_hash_algorithm() with required signatures
Message-ID: <20221104184210.2subqvek25q3rvqg@aalbersh.remote.csb>
References: <20221104064742.167326-1-ebiggers@kernel.org>
 <20221104064742.167326-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104064742.167326-2-ebiggers@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 03, 2022 at 11:47:40PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> _fsv_have_hash_algorithm() uses _fsv_enable() without a signature, so it
> always fails when called while fs.verity.require_signatures=1.  This
> happens in generic/577, which tests file signing.  This wasn't noticed
> because it just made part of generic/577 always be skipped.
> 
> Fix this by making _fsv_have_hash_algorithm() temporarily set
> fs.verity.require_signatures to 0.
> 
> Since the previous value needs to be restored afterwards, whether it is
> 0 or 1, also make some changes to the fs.verity.require_signatures
> helper functions to allow the restoration of the previous value, rather
> than the value that existed at the beginning of the test.
> 
> Finally, make a couple related cleanups: make _fsv_have_hash_algorithm()
> always delete the file it works with, and also update the similar code
> in _require_scratch_verity().
> 
> Reported-by: Andrey Albershteyn <aalbersh@redhat.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  common/verity | 69 ++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 23 deletions(-)
> 

Looks good.
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

