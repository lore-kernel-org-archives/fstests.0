Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB24C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Dec 2021 04:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhLQEVE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 23:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232885AbhLQEUt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 23:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639714845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kUcCnZRWUCvBA3e+Dn6K4wl951aJesp9uOPECzTolc0=;
        b=VUgqVSHo3bgzHmmY8xbnB0jEo2oiPabJLC6ENriyMpjIbaDvPen1d65rDBefnAi2btqoql
        kSpQJkT+D5PKCO4ic9CP4w0iynSQmYyIw4H3IsfrbQgZ1m0qjt8HpqCD6e9pRjMKuo6MRF
        0aV09uKlss532/55+cDjGHrJNUjSIHU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-EV4YiIoNOwG3ABm1wMp8Kg-1; Thu, 16 Dec 2021 23:20:44 -0500
X-MC-Unique: EV4YiIoNOwG3ABm1wMp8Kg-1
Received: by mail-pj1-f69.google.com with SMTP id o21-20020a17090a9f9500b001b105598e71so855840pjp.6
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 20:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=kUcCnZRWUCvBA3e+Dn6K4wl951aJesp9uOPECzTolc0=;
        b=8M/mOu7tPIdrASUzt0wJkGbvB/xnVLhJcLYrLI8XxYQtkJMvkp6JZWkQ2X5fS2Xcin
         hlPz4XMTBzHL67Ny7BCa6tV3xiix3qh6tjG/qyhzhNCJOhHpvHuCCsSVtlsIiNU7vn/l
         1U83Nf9flqSfLDYkzNFFZNKxDf6SUE5nn5yR7uy1rJkdhjAMyeKH0M1btNXYtOeFer/7
         wEwjnLjtZYWDgKUi4QJcDbpdKmA98Df2R94N9e5hmdLHI2sC8F/mYJiUgWh4bQQmmgi3
         xSbDfV8lALXvXPKehaEdSjBF8h3iGmWGudG1GvNM3Ip47TEf1iXbWgD4xl3hb3Y3ldAB
         JREQ==
X-Gm-Message-State: AOAM531yV7s4NyR2QjILjv08HdKNzK0xbkREkBSRDcbLGqXnp8IbvtDP
        bVO5QEKCV18KxHJCYL3R6qMYO412I/Dd/8cj1VDhrdX39pJSRvjVgNYVJ95IiFIkCRkO5ozd7gs
        xXjm+k8HWlstBs0BaTQ==
X-Received: by 2002:aa7:8b18:0:b0:4a7:ef66:3b6d with SMTP id f24-20020aa78b18000000b004a7ef663b6dmr1331449pfd.13.1639714843046;
        Thu, 16 Dec 2021 20:20:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyr/OamZEzaD+a+MB0SuVs0PKMw8CoLyuFNFW9o6+0vs9wWuUpvVvcffxETI3X4WchZ/Z9aCQ==
X-Received: by 2002:aa7:8b18:0:b0:4a7:ef66:3b6d with SMTP id f24-20020aa78b18000000b004a7ef663b6dmr1331426pfd.13.1639714842726;
        Thu, 16 Dec 2021 20:20:42 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 145sm6778286pgd.0.2021.12.16.20.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:20:42 -0800 (PST)
Date:   Fri, 17 Dec 2021 12:20:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/2] Add support for using liburing xattr
Message-ID: <20211217042038.d4qif7z2rsk56joz@zlang-mailbox>
Mail-Followup-To: Stefan Roesch <shr@fb.com>, fstests@vger.kernel.org,
        kernel-team@fb.com
References: <20211216184319.851514-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216184319.851514-1-shr@fb.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 16, 2021 at 10:43:17AM -0800, Stefan Roesch wrote:
> This adds support for using the xattr implementation in liburing.
> 
> Patch 1: fstress: add suport for using liburing setxattr
>   Uses the liburing setxattr implementation in fsstress.
> 
> Patch 2: fstress: add suport for using liburing getxattr
>   Uses the liburing getxattr implementation in fsstress.
> 
> There are two additional patch series related to this:
> - io_uring: add xattr support
> - liburing: add xattr support
> 
> ---
> V4: - fix a whitespace/tab issue
> V3: - Rebased patch series.
> V2: - Introduce dedicated functions for uring getxattr and
>       uring setxattr, so they are not automatically linked
>       in if liburing is available.
> 
> *** BLURB HERE ***
> 
> Stefan Roesch (2):
>   fstress: add suport for using liburing setxattr
>   fstress: add suport for using liburing getxattr

The code logic of this patchset looks good to me. But just notice that the
subject should be "fsstress", not "fstress", you can ask if Eryu would like
to help to change that when he merge the patch :-D

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  ltp/fsstress.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 116 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 13dd19cee4298ffc323737029ca36f70f52f88e9
> -- 
> 2.30.2
> 

