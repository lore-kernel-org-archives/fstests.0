Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4C6C001B0
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jul 2023 04:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjGXE42 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jul 2023 00:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXE42 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jul 2023 00:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B7AE41
        for <fstests@vger.kernel.org>; Sun, 23 Jul 2023 21:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690174537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rlutq8Z7KDhlUXfrK5vwQPEoqf3nu5Bflb9MQCA4ltI=;
        b=jR/4y4EJocQZK96jBPNV4W2L/9TxSO7grjgsXRYXZ5nl8be+DWJwf/z0Dox+Ies6b0Ul5n
        2B+V2y121yovLK4pH56t29zli1en8GMd+dORju6sbEa+2nWxEcaSXEBp2tSt7gqSpiyUBV
        sgvnoZarMuCM34o05T8hxRXprwd2XFM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-yI1zpjXHP_WL-V_fXE_tYw-1; Mon, 24 Jul 2023 00:55:34 -0400
X-MC-Unique: yI1zpjXHP_WL-V_fXE_tYw-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7872be95468so303564339f.1
        for <fstests@vger.kernel.org>; Sun, 23 Jul 2023 21:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690174534; x=1690779334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlutq8Z7KDhlUXfrK5vwQPEoqf3nu5Bflb9MQCA4ltI=;
        b=hwc3NO4GE9wxhPt58gOOVfBSlYgg5THge0+voq8VwXnBmTm2M5CycJeHQOcUNOhwZ4
         pL0u9Al7LvtyxfN1/yWGeOMoZm8s+RRoPL9Caj11n5rIvya/iUWpgq+f2CtASThEXwdT
         cPqT0+k5bl10cbfrd+QUjJWho3/El6W7og2Gm1QaAe7Q8RBneG7/PJlI5fTJqqjmvHQC
         31oGKfIc2IMt8/yf/2EmcuEd4NLGHraOjwg7ySGhFMU4wchy9b+ZwT9Ww0pgKEh5tQO+
         nE/JaDaokUzuWqsozDSauDPlwdJElUE0SxZTk/F48m6wRQgyDbDOKJTvOspDCConouyW
         BYUw==
X-Gm-Message-State: ABy/qLY0as+8knCB1889CXXfK+doPXm8tUrmYy5VduLSNlDhkQBqDF3L
        IHgfbN0yH3EGbJdEav3xydeE9c381u9VgcAnIrGUzq4SZMMwcaodgq1NRCEQN8XmZmYm6quAEaG
        SVFroXOwpJbJT6DdEjw==
X-Received: by 2002:a05:6e02:1103:b0:348:d70e:b7f0 with SMTP id u3-20020a056e02110300b00348d70eb7f0mr756162ilk.32.1690174534179;
        Sun, 23 Jul 2023 21:55:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHMW9PBYZZnSySVxXp2kK0+VdMZQ7SLoFpSK9lxWDc7LixiJQpyR/jom3Qk3I3/vlLJWhaExw==
X-Received: by 2002:a05:6e02:1103:b0:348:d70e:b7f0 with SMTP id u3-20020a056e02110300b00348d70eb7f0mr756149ilk.32.1690174533947;
        Sun, 23 Jul 2023 21:55:33 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jh6-20020a170903328600b001aad714400asm7770244plb.229.2023.07.23.21.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 21:55:33 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:55:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs/294: reject zoned devices for now
Message-ID: <20230724045530.mhtb3fnbdodpvfjb@zlang-mailbox>
References: <20230724030423.92390-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724030423.92390-1-wqu@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 24, 2023 at 11:04:23AM +0800, Qu Wenruo wrote:
> The test case itself is utilizing RAID5/6, which is not yet supported on
> zoned device.
> 
> In the future we would use raid-stripe-tree (RST) feature, but for now
> just reject zoned devices completely.
> 
> And since we're here, also update the _fixed_by_kernel_commit lines, as
> the proper fix is already merged upstream.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Oh, good, you've sent this patch, ignore my reply to last patch.
Looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  tests/btrfs/294 | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/294 b/tests/btrfs/294
> index 61ce7d97..d7d13646 100755
> --- a/tests/btrfs/294
> +++ b/tests/btrfs/294
> @@ -16,11 +16,15 @@ _begin_fstest auto raid volume
>  
>  # Modify as appropriate.
>  _supported_fs btrfs
> +
> +# No zoned support for RAID56 yet.
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
>  _require_scratch_dev_pool 8
>  _fixed_by_kernel_commit a7299a18a179 \
>  	"btrfs: fix u32 overflows when left shifting @stripe_nr"
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> -	"btrfs: use a dedicated helper to convert stripe_nr to offset"
> +_fixed_by_kernel_commit cb091225a538 \
> +	"btrfs: fix remaining u32 overflows when left shifting stripe_nr"
>  
>  _scratch_dev_pool_get 8
>  
> -- 
> 2.41.0
> 

