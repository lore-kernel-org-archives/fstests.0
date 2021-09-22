Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EADAC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Sep 2021 17:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309DC611C9
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Sep 2021 17:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhIVR0A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236717AbhIVRZ7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Sep 2021 13:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632331469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+bksXzzMzFqrFw3Ruf1ZmWWJl+uWpXr5K83+H4GCT0=;
        b=TS+EU/u1EiS33VXtyE4eJR+LKSEEZf6XSTHr8tz2RwRSECbxvopeOAfxkc+tWPs2KxP/St
        Zo6TzcTKUjtj6Pi9nXWGQMHv7kCUQmGHRvElzfie0MdE48ylXlTI0WGn6Fn3iP4oeZ3lwq
        viiypvhjHSPNdltmr/zZFl4gJPTp71E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-5aQ7oT0gNMaYo7O5nSLh4Q-1; Wed, 22 Sep 2021 13:24:27 -0400
X-MC-Unique: 5aQ7oT0gNMaYo7O5nSLh4Q-1
Received: by mail-qt1-f197.google.com with SMTP id f34-20020a05622a1a2200b0029c338949c1so10363940qtb.8
        for <fstests@vger.kernel.org>; Wed, 22 Sep 2021 10:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5+bksXzzMzFqrFw3Ruf1ZmWWJl+uWpXr5K83+H4GCT0=;
        b=wbFSj0lZfSfBpDaRvDesjzTITm6r/bvBDeZ54jglTpJQ9qUqx3Qi7VYBReCs/f+UyG
         aLetjabnQJctAYcU/aLDhTA6RPdawxeDBPS43LmTII44mvGuV7veitErgUP9fPYeKldD
         D82XHGS29jhrsfjLAsd3FgWBJSaS9bfodoJ56Q0Csb2u+/ECwW8IpTY3BUA4Hs/3odNh
         cQjURCu8Ccy9Y3r4mIO1RrfcOWyGesyDJQzu23Hu2dQZ0s2LfG7ItzK/eUjBM7oFJI3N
         N9/WocGmM+AXTEMobUO/eXrh1TtwW0mNG/kOCDkC4JJFvltmC/VJ+LedXLqN8jC843VK
         cLNw==
X-Gm-Message-State: AOAM5335JYcE4JH0biU9fw3zMO12DZPFcQuYHHJzsFNRwJcODh9ZVkM+
        FkiKsvCCbi5zxuZayE7H7kqF6vkfUgNOS3JouxWNTGzemick2SHXZvCPNW0kHqzVKu2TLR/YK2A
        bctgTZECx0ZgpGPtUbQ==
X-Received: by 2002:a37:6708:: with SMTP id b8mr349778qkc.283.1632331467174;
        Wed, 22 Sep 2021 10:24:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDJyQ/QlmDbDz7TbORkHifzU1pQxBmX45KHLxSRIAUX04Z8ctzxrITB5YbTJm9UGQclb54iQ==
X-Received: by 2002:a37:6708:: with SMTP id b8mr349763qkc.283.1632331466978;
        Wed, 22 Sep 2021 10:24:26 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id m139sm2441016qke.18.2021.09.22.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 10:24:26 -0700 (PDT)
Date:   Wed, 22 Sep 2021 13:24:24 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org, kaixuxia <kaixuxia@tencent.com>
Subject: Re: [PATCH] fsstress: fix bogus compile warning do_renameat2()
Message-ID: <YUtmyFtlOCT09dG3@bfoster>
References: <20210921175059.1287420-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921175059.1287420-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 21, 2021 at 10:50:59AM -0700, Luis Chamberlain wrote:
> gcc complains with:
> 
> fsstress.c:4629:4: warning: 'oldparid' may be used uninitialized in this function [-Wmaybe-uninitialized]
>  4629 |    printf("%d/%d: rename source entry: id=%d,parent=%d\n",
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  4630 |     procid, opno, oldid, oldparid);
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fsstress.c:4629:4: warning: 'oldid' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> But the varaibles are sure to be initialized, it is just that the
> heuristics are broken since another check is used later which confuses
> gcc. So just initialize the variables, to shup the compile warning.
> 

https://www.urbandictionary.com/define.php?term=shup

Huh. :P

> Cc: kaixuxia <kaixuxia@tencent.com>
> Cc: Brian Foster <bfoster@redhat.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  ltp/fsstress.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index d2f09901..0d620d7b 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -4517,9 +4517,9 @@ do_renameat2(int opno, long r, int mode)
>  	flist_t		*flp;
>  	int		id;
>  	pathname_t	newf;
> -	int		oldid;
> +	int		oldid = 0;
>  	int		parid;
> -	int		oldparid;
> +	int		oldparid = 0;
>  	int		which;
>  	int		v;
>  	int		v1;
> -- 
> 2.30.2
> 

