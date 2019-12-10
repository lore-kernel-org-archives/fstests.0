Return-Path: <SRS0=DfEV=2A=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267C1C43603
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Dec 2019 18:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF61120838
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Dec 2019 18:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="BKjQt4LP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfLJSmN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:42:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33635 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfLJSmN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Dec 2019 13:42:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id c13so221575pls.0
        for <fstests@vger.kernel.org>; Tue, 10 Dec 2019 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hYonU0ZBVzIZogNNtFncp9JVEITK1ibbwogpkkXsdR8=;
        b=BKjQt4LP9UOG9uHqefSOMOSwr9jQOQo9E2XHU7F+BWyye+OdngJAcLKR/6PUffnnMH
         cFxIKADwTzMvcVeNR+xCTp+5G4X+3T4J3QJEg18bnypP3iQwVesMdFNSqA9JcZO/a0W6
         tBj3Y+QG587eiI8ebfFd2iHmkdfw43JFblCRXMnaLXqvGLPyYbqhPDWHWgC0BkJqagkf
         FSyjA2E75oJzB/9HksXLz7ShxWV8MyLvjdzMw1A3jhz57qDIswSbBUdYZm56FDzW52dS
         zyFqd6Ha2bygLPiMZjbw689t+VOEHuo0qJIyXwGyNxdMg4fzbUylV0/QWvdNGbARCkb7
         32rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hYonU0ZBVzIZogNNtFncp9JVEITK1ibbwogpkkXsdR8=;
        b=HtXVkr7UTh2+U7j1IE8LdTQNbozLRPWSvjYqp/HASeHzvbBbqaWO1/qmNcSTbcjrlw
         DR/EqH5i3GAkD757HlmzE26GEaK7hCj/uPoztVoPJcb/dVq6SrH3sCbRmEN3jybetQ9U
         TfewSt3UyekVbhwtVRIHtPLl8rJHfu61K8tKUcgK03qBPj8ifGR7OjR7Rf6LkLfH3iub
         tZ4W2JtsVMZV0NwbOy8T+vUFIiyax7tqe5gLz5FOD0G8CRhV3uNigVg2xmHJzjZg4K31
         VjAxUyLFbmLu6sBsn/B1ByUnkUZk3nQygkBgjy0TF3LKIJHyaeDq4Y5SvLE/nfKI2j2u
         mOjA==
X-Gm-Message-State: APjAAAWufRAquMJjFplbTrH3Zi0jlhk4HVNhPSXr23W1E8FGCbGfjKrD
        0HPKU1l+eVjkhOQ+vqUd8o3N8w==
X-Google-Smtp-Source: APXvYqx7Om20lYby2/Ttd5FRX48tLQN6nyQvqZ6CQV6ZD4ZjPZwylMcD7ew+sIsT9TfQaS2+K+wtsg==
X-Received: by 2002:a17:90a:cb8c:: with SMTP id a12mr7136435pju.71.1576003332570;
        Tue, 10 Dec 2019 10:42:12 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:c519])
        by smtp.gmail.com with ESMTPSA id a13sm4381474pfc.40.2019.12.10.10.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:42:11 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:42:10 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/590: add _require_xfs_io_command "falloc"
Message-ID: <20191210184210.GC204474@vader>
References: <20191209171452.16170-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209171452.16170-1-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 09, 2019 at 05:14:52PM +0000, Luis Henriques wrote:
> Without this check the test will fail with message:
> 
>   fallocate: Operation not supported
> 
> Instead, with this _require_xfs_io_command, the test will be skipped
> instead if falloc isn't supported.

Thanks, I missed this.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  tests/generic/590 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/590 b/tests/generic/590
> index 80a665c6b001..2670fe99d21f 100755
> --- a/tests/generic/590
> +++ b/tests/generic/590
> @@ -34,6 +34,7 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch_nocheck
> +_require_xfs_io_command "falloc"
>  
>  maxextlen=$((0x1fffff))
>  bs=4096
