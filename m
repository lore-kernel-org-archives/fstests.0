Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D792C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 11 May 2022 16:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245666AbiEKQnM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 May 2022 12:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbiEKQnL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 May 2022 12:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5E6062A1D
        for <fstests@vger.kernel.org>; Wed, 11 May 2022 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652287389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gyD0LuMwGH55iSnxhEA4ec7RPvLhktAlhNu2qGKmJrQ=;
        b=FvNcLYgyDaWdNGelWItgbtJrMr7RZONdHclJozg2/+SV4Lz84J/ZbvKcSupH7Kz0rXtlI7
        hgZlUqzQaaiLSBgDOzKh8GoOrmkpQqFTXk5zk3qvMkie8PRLEnZPlY2yFmyOfuYAkQX/0B
        Alct6cbw/89lBDBKDMPFzQocoyxG24M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-AWqqstPlOGynmQlFofaC3w-1; Wed, 11 May 2022 12:43:08 -0400
X-MC-Unique: AWqqstPlOGynmQlFofaC3w-1
Received: by mail-qt1-f197.google.com with SMTP id a11-20020a05622a02cb00b002f3d23bdca2so2005940qtx.5
        for <fstests@vger.kernel.org>; Wed, 11 May 2022 09:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gyD0LuMwGH55iSnxhEA4ec7RPvLhktAlhNu2qGKmJrQ=;
        b=ulQXW8pJCtSd65PxlXddAgKaXHxm0kgXWXaxAZkgVOPPBvNI4acGHVrGhkkF3Vvbbe
         k+v6k8WHaVfmvl8CtDrv8NXbeUgAz1KMStRzcOOyIj0wOTNEvGUE85QjkJJPgkdbD31B
         yk+4ci7Nj0VEWcH4GheEvHJXlAOszCCkPjV4AEVCKttyfQpMgwuDp3HS4Pm6HPTwGH/W
         73ws8xtTI/qUjzCfPmuoyqyx10MM+JQ6yVjv9cIjxnUqHqTTco+AqRflBjqxi9q7ttyz
         3fSwMYe2rg7UD3gnGNjjCEfdPQXOwAfsQgjgztIxQYfEHc4CWeEF1zpQ8DXKkRaqGOfU
         0ihA==
X-Gm-Message-State: AOAM531dF7X1hRqqqjoAXKoXKJfLDKDTjaVEEtcq8k7UG0hRfTeo0zLX
        hABlkWz2HjnW1G3tCg23WPW7tB00T7QXgk7gPpM26xO5/wBrJi2E4HTa8hrrerqYBAUvmA3htrR
        uKjTrRxyyt+VLg0ZXpQ==
X-Received: by 2002:a37:6786:0:b0:6a0:59f1:d8ae with SMTP id b128-20020a376786000000b006a059f1d8aemr14493212qkc.649.1652287387954;
        Wed, 11 May 2022 09:43:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0T65Ktfw4ud+QJxzp6yDV+7rBotrer5zpmcS58O+2AtEmMGoRYSztSfl8ztuPvRctxRPfkA==
X-Received: by 2002:a37:6786:0:b0:6a0:59f1:d8ae with SMTP id b128-20020a376786000000b006a059f1d8aemr14493202qkc.649.1652287387690;
        Wed, 11 May 2022 09:43:07 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k14-20020a05620a414e00b0069fc2a7e7a5sm1567394qko.75.2022.05.11.09.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:43:07 -0700 (PDT)
Date:   Thu, 12 May 2022 00:43:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] casefold: Fix expansion of seqres variable
Message-ID: <20220511164302.hfun2kqwqn4dwkub@zlang-mailbox>
Mail-Followup-To: Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org
References: <20220511163340.19969-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511163340.19969-1-krisman@collabora.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 11, 2022 at 12:33:40PM -0400, Gabriel Krisman Bertazi wrote:
> seqres is not properly expanded on these error paths, causing a file
> called seqres.full to be created instead.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

> changes since v1:
>   - Add whitespace between variable and std redirection (chinner)
> ---
>  common/casefold | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/casefold b/common/casefold
> index 9172d818125a..d9126f4c59e6 100644
> --- a/common/casefold
> +++ b/common/casefold
> @@ -25,7 +25,7 @@ _require_scratch_casefold()
>  		_notrun "$FSTYP does not support casefold feature"
>  	fi
>  
> -	if ! _scratch_mkfs_casefold &>>seqres.full; then
> +	if ! _scratch_mkfs_casefold &>> $seqres.full ; then
>  		_notrun "$FSTYP userspace tools do not support casefold"
>  	fi
>  
> @@ -33,7 +33,7 @@ _require_scratch_casefold()
>  	# defined by the userspace tools.  This will fail if
>  	# the userspace tool used a more recent encoding than the one
>  	# supported in kernel space.
> -	if ! _try_scratch_mount &>>seqres.full; then
> +	if ! _try_scratch_mount &>> $seqres.full ; then
>  		_notrun "kernel can't mount filesystem with the encoding set by userspace"
>  	fi
>  	_scratch_unmount
> -- 
> 2.36.1
> 

