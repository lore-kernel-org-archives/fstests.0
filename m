Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C34DECAAD2
	for <linux-fstests@archiver.kernel.org>; Fri,  2 Sep 2022 02:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiIBCAn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 1 Sep 2022 22:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiIBCAm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Sep 2022 22:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E28D5007C
        for <fstests@vger.kernel.org>; Thu,  1 Sep 2022 19:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662084039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nchLC9q9Cqj8zfIGBjKbwfzCwDv99l0+65Juf1id85I=;
        b=Ohctx6peNsC5SzaJQQ6rc/ZUO1qgamSLND3Jd/XG6mBydkfZMXH0VPvEVKra13PhRSLCpL
        m3zCUQYqXIvHVKR55VnY589k1puWbbS059pG2Djp/RIlr6ztEpylM7Y9DJngVcQsndwgMO
        6hcsHbK1m/UqpFiGn8Tq9o/hNcAoBP0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-_jDOQicCOpaZZ5if2XMsuA-1; Thu, 01 Sep 2022 22:00:38 -0400
X-MC-Unique: _jDOQicCOpaZZ5if2XMsuA-1
Received: by mail-qk1-f199.google.com with SMTP id az11-20020a05620a170b00b006bc374c71e8so815953qkb.17
        for <fstests@vger.kernel.org>; Thu, 01 Sep 2022 19:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nchLC9q9Cqj8zfIGBjKbwfzCwDv99l0+65Juf1id85I=;
        b=hJAQFVktkTIcIEE/lXf2KaJhpc2x0Fs2xT6fZ+FVqmNDMpiiLhxiOgZBJ1wrF1pUGh
         hYZSjeU5wy48aSvc/arN/opFP2riIm9FHBUintjNDj+w6Cu56qUfmgxOiuX0MDJd9jyK
         cDt/ZAASPHlfZ4CgGm3B8NszB+xUr3qavkV7C3Z82KoOBOm6b3/mxutjtkiu+KDt8SAK
         L1MWp6EwKGbLes63LLSTWIzjreI86lPhz9WqtTdxg19TeWuLYe+2DnN7J6Tmk/FYVAvr
         AlVRSLH2LzFgY581p0V75BR23NOcBLGh+ny9Doe9ZcYbdrNNVPrl0boBgZ3LOvWW9NdE
         dptg==
X-Gm-Message-State: ACgBeo1xSOYLYzYAMvL07mk8Wtmn4Rbu4I4VELB8hIJ3ug6YrPzZ2xUk
        DPFuMfEU0ad6um5uUv6tTXKd2AkMYutOECJ7uMK5B7oxuJRU/kJ4gWwu37+T3ybjf/9hJFlFwnt
        9vLU1OKG5ZxEPkMmUPQ==
X-Received: by 2002:a05:6214:3013:b0:496:dd8c:84bb with SMTP id ke19-20020a056214301300b00496dd8c84bbmr26788376qvb.23.1662084037914;
        Thu, 01 Sep 2022 19:00:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5LrlBWGvT+dqH7zwskvoviWdW2m+JCvy03JbdW+7x1IjizFc+jEwEF02r7BGYwusx2/aID1g==
X-Received: by 2002:a05:6214:3013:b0:496:dd8c:84bb with SMTP id ke19-20020a056214301300b00496dd8c84bbmr26788358qvb.23.1662084037575;
        Thu, 01 Sep 2022 19:00:37 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b006b929a56a2bsm472748qkg.3.2022.09.01.19.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 19:00:37 -0700 (PDT)
Date:   Fri, 2 Sep 2022 10:00:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: remove 'seek' group from btrfs/007
Message-ID: <20220902020030.oho6ssdrdzjy66pw@zlang-mailbox>
References: <bc7149309a8eca5999f22477a838602023094cb8.1662048451.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc7149309a8eca5999f22477a838602023094cb8.1662048451.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 01, 2022 at 05:12:25PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs/007 does not test lseek, it tests send/receive and lseek is not
> exercised anywhere in this test. So just remove it from the 'seek' group.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

This 'seek' group is brought in by below commit:

  commit 6fd9210bc97710f81e5a7646a2abfd11af0f0c28
  Author: Christoph Hellwig <hch@lst.de>
  Date:   Mon Feb 18 10:05:03 2019 +0100

      fstests: add a seek group

So I'd like to let Christoph help to double check it.

Thanks,
Zorro


>  tests/btrfs/007 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/007 b/tests/btrfs/007
> index ed7d143a..c4a8d9d0 100755
> --- a/tests/btrfs/007
> +++ b/tests/btrfs/007
> @@ -13,7 +13,7 @@
>  owner=list.btrfs@jan-o-sch.net
>  
>  . ./common/preamble
> -_begin_fstest auto quick rw metadata send seek
> +_begin_fstest auto quick rw metadata send
>  
>  # Override the default cleanup function.
>  _cleanup()
> -- 
> 2.35.1
> 

