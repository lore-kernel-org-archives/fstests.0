Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BF7C7618A
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Mar 2023 14:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjCTOFO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjCTOEu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Mar 2023 10:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DAA4EC9
        for <fstests@vger.kernel.org>; Mon, 20 Mar 2023 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679321044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/PSB6Nsz7o8LHZj2T/kpSDL6QgnL3s1fRiM33zhd6LU=;
        b=GxDKgxQG1ZCIcKwlAeJRmlGiFu2BeK+wu0Tf71Y58mpG3dppikLB724eBA7s16YB1eTdvo
        n1vjWf1tHazUglxHm36ZXFhcKBSEGGSZiYi6rPljIm+Aj/0fpQb1+H/juD3FrKHXkBrEZ3
        aV5mLhD3bmDdumN8Dk1u5zE2vYMjghU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-UZfyYVb0OXKknVOb22iiRA-1; Mon, 20 Mar 2023 10:03:58 -0400
X-MC-Unique: UZfyYVb0OXKknVOb22iiRA-1
Received: by mail-pf1-f198.google.com with SMTP id h66-20020a628345000000b00625e0121e40so6301261pfe.1
        for <fstests@vger.kernel.org>; Mon, 20 Mar 2023 07:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679321036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PSB6Nsz7o8LHZj2T/kpSDL6QgnL3s1fRiM33zhd6LU=;
        b=jkJqZt0DtjN+GKeeJfVG5LYQ4zWJJlnEaCD8/X/TKN3dpZriw62oe/Qp7kAlLHJV8r
         64rLFWSgctXm8jPIih2sfFdFzGLqgAEOiijCd9B64CfCWzci45qb6VJ274qkeHvV2hYt
         xEwW7v+lgDDvvyzuGRXQMfAo6Az4npvgqMCjc1xHF1xWIAvVDVW6a1gZCPuxh2sFewB7
         dz3rBdyiFJxihLXlCa+UhezDz7dklmx/4D7tzZmDVtqbOFiQWncnfWSnAndTY8HhD15L
         3KYn5/YCjNZ9gIvZBPiFD4MPB6a5Xmg/its6txib6ywHWh1CwpZmCmVyly0VsODKms2o
         hvBg==
X-Gm-Message-State: AO0yUKXXDzorL2h3EszhGpefu5tE8dSyOXIs2n56Sv7m0GGiJnLT2fMO
        x17wYmyfWqYZS4/JFl8qI+WPDxGqC3g/s609dvFmcWiGQhyZ/dJ4ckU16TiOPHrGVVJYSMdxPxN
        YRkmzjVIqlSrQza7lFtdgtaFAtlYQ
X-Received: by 2002:a05:6a21:78a0:b0:cc:d891:b2b1 with SMTP id bf32-20020a056a2178a000b000ccd891b2b1mr24225879pzc.35.1679321035891;
        Mon, 20 Mar 2023 07:03:55 -0700 (PDT)
X-Google-Smtp-Source: AK7set/7e8M6ZokI1Ye9mDyLHcYZBN4Vsk5V84q+FdXMxIosct0x/PnqqcGN5j8bnunPzRCguDt7sQ==
X-Received: by 2002:a05:6a21:78a0:b0:cc:d891:b2b1 with SMTP id bf32-20020a056a2178a000b000ccd891b2b1mr24225840pzc.35.1679321035455;
        Mon, 20 Mar 2023 07:03:55 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i20-20020aa79094000000b005abbfa874d9sm5946971pfa.88.2023.03.20.07.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:03:54 -0700 (PDT)
Date:   Mon, 20 Mar 2023 22:03:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 0/3] xfstests: make fscrypt-crypt-util self-tests work
 with OpenSSL 3.0
Message-ID: <20230320140350.w4gg32a4f2kpv62s@zlang-mailbox>
References: <20230319193847.106872-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319193847.106872-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Mar 19, 2023 at 12:38:44PM -0700, Eric Biggers wrote:
> This series makes the algorithm self-tests in fscrypt-crypt-util (which
> are not compiled by default) work with OpenSSL 3.0.  Previously they
> only worked with OpenSSL 1.1.
> 
> Eric Biggers (3):
>   fscrypt-crypt-util: fix HKDF self-test with latest OpenSSL
>   fscrypt-crypt-util: use OpenSSL EVP API for AES self-tests
>   fscrypt-crypt-util: fix XTS self-test with latest OpenSSL
> 
>  src/fscrypt-crypt-util.c | 46 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 9 deletions(-)
> 
> -- 

I'm not familiar with fscrypt changes, but from the commit log of 3 patches,
this patchset looks good to me. If there's not more review points from
linux-fscrypt@, I'll merge this patchset.

Just one tiny review point, I'd like to keep using same comment format, especially
in same source file. As src/fscrypt-crypt-util.c generally use "/* ... */", so
I'll change your "//..." to "/* ... */" when I merge it, if you don't mind.

Thanks,
Zorro

> 2.40.0
> 

