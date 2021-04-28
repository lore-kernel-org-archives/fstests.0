Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A017AC43462
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 17:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B7561443
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 17:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbhD1RkN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Apr 2021 13:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242637AbhD1Rj3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Apr 2021 13:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619631521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zmW6jAmqt0ECy49Md7z7mvAReCGWbouCKZBWTGRM3Ts=;
        b=CAncoEZMJoO8sdfVebczC7HW1NJPCzTca1b68eykVRuWGHjKxXKpRDJmIICI7sz6uuQYdt
        DaMWCqvBeECZwpcAViT665MzPlX25vfuS3o7pmPIMhsRODan5vxvOiSL6TPnmQMnnC3L0t
        8gGPtEfu0rJUiVQRs7ttLfFdyTV9TjI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-xNk-NqPpN4eDEjgKpJz5Tw-1; Wed, 28 Apr 2021 13:38:39 -0400
X-MC-Unique: xNk-NqPpN4eDEjgKpJz5Tw-1
Received: by mail-qv1-f70.google.com with SMTP id b10-20020a0cf04a0000b02901bda1df3afbso4193246qvl.13
        for <fstests@vger.kernel.org>; Wed, 28 Apr 2021 10:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zmW6jAmqt0ECy49Md7z7mvAReCGWbouCKZBWTGRM3Ts=;
        b=cyW97GPPjW17+42ndsMBWBk0REFJjLVI62eVKfAdA5ZOqfA8l6WZi6ALWsEG83UHXN
         c6XOpgi8scHbU+OhLw7dI+3HYl/U1cqekCZ5Fnw5zuqDf1oemT96cz7UCzJngpc38yHD
         T+dklodIhGrR4VlkrwwucI1689wGRsml4DUBt4cfkZ7o8oVxJu0TH1TqptMdP0Sg0VF4
         IVEvUDkPAoH0l+s2ASgkjY2M5LtfxzY3M1UwaPWo9K8Hh09JeHGHglQxfqXUdSc/Dn21
         1qE41LugLfQmDzbRjMOotK9dQjirtU8eZYCr0QR2u0c04iYFbLx3GShNuTEkrex/fpvo
         QulQ==
X-Gm-Message-State: AOAM531hOCcYLJNgXURSUWscZDGC8Jyb7V3kNqDWgQLn+ODQm4HUK6r2
        nCqtRjuLpdgk+OQrkhuZFpoF+vv88P+HgLMjrde4yDzRJ37zDHIdsnO0LWq99JXhgIemPQbb49r
        7KLmtNvZn4RTy/+bRHA==
X-Received: by 2002:a37:ef07:: with SMTP id j7mr14009124qkk.425.1619631519088;
        Wed, 28 Apr 2021 10:38:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjPP+p8jTypGrqH1boFUObEoXaSsZuCL/ZHbKmoDXsJiXImXQFrrkl4F51gj+WlZFF4+4eKw==
X-Received: by 2002:a37:ef07:: with SMTP id j7mr14009108qkk.425.1619631518918;
        Wed, 28 Apr 2021 10:38:38 -0700 (PDT)
Received: from bfoster ([98.216.211.229])
        by smtp.gmail.com with ESMTPSA id g16sm472943qtv.64.2021.04.28.10.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:38:38 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:38:36 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     guaneryu@gmail.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 2/2] xfs/010: filter out bad finobt levels complaint
Message-ID: <YImdnOkvoIjnMPCr@bfoster>
References: <161958291787.3452247.15296911612919535588.stgit@magnolia>
 <161958292995.3452247.16052548384852587095.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161958292995.3452247.16052548384852587095.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 27, 2021 at 09:08:50PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Since we're adding to xfs_repair the ability to warn about bad finobt
> levels, filter that out.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/xfs/010 |    1 +
>  1 file changed, 1 insertion(+)
> 
> 
> diff --git a/tests/xfs/010 b/tests/xfs/010
> index 95cc2555..a9394077 100755
> --- a/tests/xfs/010
> +++ b/tests/xfs/010
> @@ -114,6 +114,7 @@ _corrupt_finobt_root $SCRATCH_DEV
>  
>  filter_finobt_repair() {
>  	sed -e '/^agi has bad CRC/d' \
> +	    -e '/^bad levels/d' \
>  	    -e '/^bad finobt block/d' | \
>  		_filter_repair_lostblocks
>  }
> 

