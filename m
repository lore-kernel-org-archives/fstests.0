Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73CDC4332F
	for <linux-fstests@archiver.kernel.org>; Fri, 16 Dec 2022 19:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLPTOW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 16 Dec 2022 14:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiLPTOV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Dec 2022 14:14:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0CB6AD4C
        for <fstests@vger.kernel.org>; Fri, 16 Dec 2022 11:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671217997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1bwQiGabmBjHPNRTkAkQlpGAffFVs1cMlAkDeaPPLU=;
        b=b6inYiConDl0OxKMIt0KByr8DZAtdcqyQ4qXnwTrPPnlBkjVeCU0J1h/FKMBeqrMnL6GGL
        XbL+OLUImSUXu2D5U19mok4937BqryhEmXiSd32AfjONINiQSkpXKjeW4u5OcjY6rdOFZq
        +qzIKa5r9OqQIWdgG6C4ZdKL1cBabb0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-324-9cWd5iFgMLKUSA693PqVCw-1; Fri, 16 Dec 2022 14:13:15 -0500
X-MC-Unique: 9cWd5iFgMLKUSA693PqVCw-1
Received: by mail-pg1-f199.google.com with SMTP id j21-20020a63fc15000000b00476d6932baeso1994158pgi.23
        for <fstests@vger.kernel.org>; Fri, 16 Dec 2022 11:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1bwQiGabmBjHPNRTkAkQlpGAffFVs1cMlAkDeaPPLU=;
        b=zVjMqFXaY45gbV89XfHzZaYWMcBaLg1NWGc5Ya2HmyIrxMUyI0vzxzzhUnSORc+IUv
         LBFmte9d9Oh/at705XhJFosI2iMnEQRBWJcL87ogBqK+1zZ64hjYHxlsC+DIo5FXO0NK
         xX4PHBfLxDkHMXh8tieA65ea8DBvUdmiMBcxYJtCIDLTd/RwaHlOKq0ThPV8cXntXG4B
         BpVczgx0YkrEKRfPpCuyOPQ7ZjTFiMz3bAGV+saMmBd5Di+FxllrJD3Ar7qXAXY8MMpU
         fbz2dflqIRwmCeV/KgFqwoBoocLnFGFgqJ+ByRu9mKLFoIAR0VbJ9IGk0ewwKOt6CCUK
         5Chg==
X-Gm-Message-State: ANoB5pnZfBoL/9Lbo1JShGpaaB2T1csMozbNGQ1I1MbjSS2hpBRh5/V8
        XFVPWiWjuDxITL1c6+wpUwJJYkWmTdRB38NxpvAzamyskABEW3Mo77tUuKS85Uf71EGtGqJOajw
        Ou3U+mELzkRJGukHB9w==
X-Received: by 2002:a17:902:9683:b0:189:c93c:e5e6 with SMTP id n3-20020a170902968300b00189c93ce5e6mr35114315plp.33.1671217994540;
        Fri, 16 Dec 2022 11:13:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf48faDA/36Hh4LqJETb9zUcUzIQHXGHR3uds5+l3RrkL1/HkHapgMwqch4mjLP2+EYn2gUneA==
X-Received: by 2002:a17:902:9683:b0:189:c93c:e5e6 with SMTP id n3-20020a170902968300b00189c93ce5e6mr35114301plp.33.1671217994220;
        Fri, 16 Dec 2022 11:13:14 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b001868981a18esm1996911plj.6.2022.12.16.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 11:13:13 -0800 (PST)
Date:   Sat, 17 Dec 2022 03:13:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v1] src/vfs/utils: Reset errno to zero when detect
 O_TMPFILE
Message-ID: <20221216191309.2vmrkjjyrazqc5ht@zlang-mailbox>
References: <1671078101-15585-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1671078101-15585-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 15, 2022 at 12:21:41PM +0800, Yang Xu wrote:
> For some filesystem that doesn't support O_TMPFILE, it will pass
> ENOTSUP errno to upper layer. so it will report the following error:
> QA output created by 696
> vfstest.c: 1818: setgid_create_umask - Success - failure: is_setgid
> vfstest.c: 2421: run_test - Operation not supported - failure...
> 
> To fix this, just reset errno before return.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

I never hit this failure before, but this change make sense to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/vfs/utils.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/src/vfs/utils.c b/src/vfs/utils.c
> index 6db7a11d..8b000506 100644
> --- a/src/vfs/utils.c
> +++ b/src/vfs/utils.c
> @@ -921,10 +921,12 @@ bool openat_tmpfile_supported(int dirfd)
>  
>  	fd = openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
>  	if (fd == -1) {
> -		if (errno == ENOTSUP)
> +		if (errno == ENOTSUP) {
> +			errno = 0; /* Don't report misleading errno. */
>  			return false;
> -		else
> +		} else {
>  			return log_errno(false, "failure: create");
> +		}
>  	}
>  
>  	if (close(fd))
> -- 
> 2.27.0
> 

