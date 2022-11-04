Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D1BC4332F
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Nov 2022 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiKDSt1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 4 Nov 2022 14:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKDSt0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 Nov 2022 14:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD1635D
        for <fstests@vger.kernel.org>; Fri,  4 Nov 2022 11:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667587704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mde2FRatgPfjmIMVUyfH0PQ0jV7GiEeuYgCYkwcnHzY=;
        b=FAZUP1O6NFX3YSy23qVwFSzJPa30e4bczkk/RspMUWNsU72AGsIeGwZpzVMZc/bx7tmmdg
        geNB7L5blTNkW/2tYjrk3SfMtHN2kI2hkVKXDnaVVM7WVDkYwQwa1s1WrnWosI2RACHV6p
        R+ZbA00p+nqdzj1BQIF/Pv9uE8KxqhI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-600-IKT7NertOwiXfvUFbiOm6A-1; Fri, 04 Nov 2022 14:48:23 -0400
X-MC-Unique: IKT7NertOwiXfvUFbiOm6A-1
Received: by mail-wm1-f69.google.com with SMTP id h204-20020a1c21d5000000b003cf4e055442so2703669wmh.1
        for <fstests@vger.kernel.org>; Fri, 04 Nov 2022 11:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mde2FRatgPfjmIMVUyfH0PQ0jV7GiEeuYgCYkwcnHzY=;
        b=NZf16y9RwjjJwlwK7cjr4fLtClxE2yJCxc/uljhxGOArFeFxzKeu9dqR7lBgUKPZ6u
         XLw92UTDZ+zHW1kI6O3dsqpTqi6XeAF2abL2bc2tu4Ou2uXyJd1Z1j+a/n5Ls8TLsgNj
         KLRfFZFLtxW/239EkNHUyzgrB6qAuJx0WYeeA6Z+CdYM/1DnXAZ8XyI+I/mN4os/GigR
         Uomj1OpTzXbhydHs5I+b6uFJ/2nDDkhSz0jtKw2PG8CxqjuY7zIfUwidoFZuTgXmdHxx
         azmZlWUcqfjol7zqSEjo/Bqy0CsqH7AjJQczaFp4F4XW6u3DeHbRYztghWq69LHbRdvA
         PMuQ==
X-Gm-Message-State: ACrzQf1kqB6Rdjj3WC8SQww5H0CBgE0NeNJz3VWB2OI35vsMwe8GdtQY
        JIuLCt22TPEDTUgrsDqCQVjPel65Ojl3FPJRq75NK3NRbylxDKCL77mHIunMnvyYa6aabed8X/8
        PCHAsbiIAKuqrNeTr
X-Received: by 2002:a05:600c:6885:b0:3c2:9da1:5034 with SMTP id fn5-20020a05600c688500b003c29da15034mr25091816wmb.38.1667587701927;
        Fri, 04 Nov 2022 11:48:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5davz+z1NKstbBS3+6/K+hXGnzx4eGHTX7Zpt803TIHFZbSp1zck0b3uyqlUEbKhUU9mbT/w==
X-Received: by 2002:a05:600c:6885:b0:3c2:9da1:5034 with SMTP id fn5-20020a05600c688500b003c29da15034mr25091809wmb.38.1667587701767;
        Fri, 04 Nov 2022 11:48:21 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id h1-20020adffd41000000b0022da3977ec5sm31141wrs.113.2022.11.04.11.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:48:21 -0700 (PDT)
Date:   Fri, 4 Nov 2022 19:48:19 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [xfstests PATCH 3/3] tests: fix some tests for systems with
 fs.verity.require_signatures=1
Message-ID: <20221104184819.qcae57xlsnxjx3gg@aalbersh.remote.csb>
References: <20221104064742.167326-1-ebiggers@kernel.org>
 <20221104064742.167326-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104064742.167326-4-ebiggers@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 03, 2022 at 11:47:42PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Some of the newer verity tests don't work properly on systems where
> fs.verity.require_signatures is enabled, either because they forget to
> disable it at the beginning of the test, or they forget to re-enable it
> afterwards, or both.  Fix this.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  tests/btrfs/290   | 9 +++++++++
>  tests/btrfs/291   | 2 ++
>  tests/generic/624 | 8 ++++++++
>  tests/generic/692 | 8 ++++++++
>  4 files changed, 27 insertions(+)
> 

Looks good. I haven't run btrfs tests but change looks ok.
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

