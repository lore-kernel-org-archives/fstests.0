Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82FCC433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Oct 2022 06:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJRGQZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Oct 2022 02:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJRGQY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Oct 2022 02:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75678E0F4
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 23:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666073781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phBXmzGErESKTu0vjy0+QyYVr0FNIn//Dc6kGC6lv1o=;
        b=aGVwBcmLzLSr2YAF8OHczQwLNBg/j+z0v/ysV5Uvo4K/4iXYsWQbuuqBKr0Rur+kaQmYgM
        3boDiQ/UKk3XL54V8CbJfnPq89SV6e0N6VE6BeRSHFtBwcxaUq/mA0wM0a7P3hDBse4Jl+
        rf9VYF90dktX4G+fX7BMpxF8SCagEzY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259-3mHzh1tTMQiEbAuLJ1qWAQ-1; Tue, 18 Oct 2022 02:16:19 -0400
X-MC-Unique: 3mHzh1tTMQiEbAuLJ1qWAQ-1
Received: by mail-pj1-f69.google.com with SMTP id gz13-20020a17090b0ecd00b0020d67a4e6e5so5533662pjb.3
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 23:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phBXmzGErESKTu0vjy0+QyYVr0FNIn//Dc6kGC6lv1o=;
        b=CyxQJA3YN+pDhHeWWtFZRdsCa7yT26A8UVxS1DYKxJadYiRMYwnsuISxBXa/PJEDIJ
         aTVO2uPtAtfCaY5Ced/Vqs0hHZu1fM0ESqvzxMys/cjprHuc9KRdiXjQ0WXMhRMtS/6p
         X0fWbaUXybKwM+DeKx3/R4pRPLnE2kX1oftVKdg0UDdEi5XHevGq7eyBGaqgjelC/THF
         K97U897XgkJgNOvlV5dAwJmE0sz1Fkn9oll1c//4TGY2MnjuRJ5xJgzma/AHTZU+gYuz
         /X8drnMGk3nFxSm5X8eyC1rT/L6IOohtSgKlR6SZBpIp61IlWvrJhKmBCIttNNNhtB28
         zl8w==
X-Gm-Message-State: ACrzQf0FvZCvIHzsKVWFLOWGWG2nQVegDsFqId9tmfT6nyRoPICDDZB7
        +jOd9ubTMBEqCS4hEGiNZTLhr1QZrO77FySYv09jjPbbB8eahj37qOqWm5J2boJXpGJ360sDGkP
        kFlJJK7WAwzRnV2Gpdw==
X-Received: by 2002:a17:902:b093:b0:185:4aa1:402c with SMTP id p19-20020a170902b09300b001854aa1402cmr1501915plr.92.1666073778131;
        Mon, 17 Oct 2022 23:16:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7CL2OYM3DhJatI7FJy3YjR/N+dwWBCOOrQHsPVObTEjWMoEkEuSD9f3f6kSZW4lk8JJOGv8Q==
X-Received: by 2002:a17:902:b093:b0:185:4aa1:402c with SMTP id p19-20020a170902b09300b001854aa1402cmr1501890plr.92.1666073777774;
        Mon, 17 Oct 2022 23:16:17 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g17-20020aa79dd1000000b0053e5daf1a25sm8308745pfq.45.2022.10.17.23.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 23:16:17 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:16:13 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     brauner@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] Add more suid/sgid related cases to perms group
Message-ID: <20221018061613.ul7nqupy3g34vjqe@zlang-mailbox>
References: <1666066330-2006-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666066330-2006-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 18, 2022 at 12:12:10PM +0800, Yang Xu wrote:
> Just use the following ways to look for these cases
> 1) grep -nsr suid or grep -nsr sgid
> 2) grep -nsr chmod | grep "+s"
> 3) grep -nsr ISUID/ISGID then search execute program ie(vfstest/idmapped_mounts)
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/generic/193 | 2 +-
>  tests/generic/355 | 2 +-
>  tests/generic/673 | 2 +-
>  tests/generic/674 | 2 +-
>  tests/generic/683 | 2 +-
>  tests/generic/684 | 2 +-
>  tests/generic/685 | 2 +-
>  tests/generic/686 | 2 +-
>  tests/generic/687 | 2 +-
>  tests/overlay/015 | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)

According to the definition of "perms" group:
  perms                   access control and permission checking

It's not only about suid/sgid. I try to check more (roughly), find below
cases[1] might be related with "perms", please double check and add more proper
cases into perms group (if there're more).

Thanks,
Zorro

[1]
generic/099, generic/105, generic/128, generic/237, generic/314, generic/318,
generic/319, generic/362, generic/363, generic/364, generic/365, generic/366,
generic/367, generic/368, generic/369, generic/370, generic/375, generic/444,
generic/698, generic/699, overlay/004, overlay/008, overlay/023

> 
> diff --git a/tests/generic/193 b/tests/generic/193
> index ddaff69b..e2710b07 100755
> --- a/tests/generic/193
> +++ b/tests/generic/193
> @@ -7,7 +7,7 @@
>  # Test permission checks in ->setattr
>  #
>  . ./common/preamble
> -_begin_fstest metadata auto quick
> +_begin_fstest metadata auto quick perms
>  
>  _register_cleanup "_cleanup_files"
>  tag="added by qa $seq"
> diff --git a/tests/generic/355 b/tests/generic/355
> index 4bc69eeb..7c108d1b 100755
> --- a/tests/generic/355
> +++ b/tests/generic/355
> @@ -7,7 +7,7 @@
>  # Test clear of suid/sgid on direct write.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick perms
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/673 b/tests/generic/673
> index 4d8dc07e..6d1f49ea 100755
> --- a/tests/generic/673
> +++ b/tests/generic/673
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a reflink.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick
> +_begin_fstest auto clone quick perms
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/674 b/tests/generic/674
> index a3130249..c3ff1b7b 100755
> --- a/tests/generic/674
> +++ b/tests/generic/674
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a deduplication.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick
> +_begin_fstest auto clone quick perms
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/683 b/tests/generic/683
> index 4c93346d..302f8bb2 100755
> --- a/tests/generic/683
> +++ b/tests/generic/683
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a fallocate.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick
> +_begin_fstest auto clone quick perms
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/684 b/tests/generic/684
> index 03481e69..19ccb228 100755
> --- a/tests/generic/684
> +++ b/tests/generic/684
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a fpunch.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick
> +_begin_fstest auto clone quick perms
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/685 b/tests/generic/685
> index 6a108842..a58eccda 100755
> --- a/tests/generic/685
> +++ b/tests/generic/685
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a fzero.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick
> +_begin_fstest auto clone quick perms
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/686 b/tests/generic/686
> index 4279f76b..ef9ea47a 100755
> --- a/tests/generic/686
> +++ b/tests/generic/686
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a finsert.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick
> +_begin_fstest auto clone quick perms
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/687 b/tests/generic/687
> index 78cb6202..f4a1c1bb 100755
> --- a/tests/generic/687
> +++ b/tests/generic/687
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a fcollapse.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick
> +_begin_fstest auto clone quick perms
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/overlay/015 b/tests/overlay/015
> index fd23e373..f0c05579 100755
> --- a/tests/overlay/015
> +++ b/tests/overlay/015
> @@ -7,7 +7,7 @@
>  # SGID bit inheritance over whiteout.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick whiteout
> +_begin_fstest auto quick whiteout perms
>  
>  # Import common functions.
>  . ./common/filter
> -- 
> 2.27.0
> 

