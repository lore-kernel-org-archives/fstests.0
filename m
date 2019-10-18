Return-Path: <SRS0=Q9mn=YL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF28CA9EA0
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Oct 2019 08:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCAE222BD
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Oct 2019 08:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNn+t/gY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632841AbfJRIkE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:40:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42232 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfJRIkD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Oct 2019 04:40:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so3424437pff.9
        for <fstests@vger.kernel.org>; Fri, 18 Oct 2019 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QB8YxI0N/Vw5dS2AAVZbbh6MiANShwBm0ABBdHhctl8=;
        b=QNn+t/gYljanBLuHdp9lHMpixxtpsW3fAxLcy7Mb4f6BiTiS2toPdjuck92/IP8ihH
         Ef+91RzEFIjkUl9/TzH8CnBs3QPnb7Ju9LAQIT+1JVIR/8pkSJhmXiQ/XdfDMr2xsAsi
         +kF2tyFxdUb8pAgIwYw59JWMd0lhLDzZbv2J6sfaARTETVvGlWIDBPdpdOCnell4SvTy
         IQGlVIv1Cl3lAWuwjdbYUHx9YXZ3yvEyff9l8bjBQ+y1+FpQeRxb71AcqitS8LnX0lJS
         7EsNd+VeBVnse5rSCDd5K/PW5JnB+pih9c7uu53IozhiTTs0lv92SqR5DScpf1/1hY54
         4S5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QB8YxI0N/Vw5dS2AAVZbbh6MiANShwBm0ABBdHhctl8=;
        b=sVgNylOcMw3VC/FUBQOU40/Gckq4TgqWaw3ULfAi9Y4bd5sX5CBHultXTZbO7LoIeS
         KIswk5ywBbT6WsonhQv6c+YQcKq+SiDMuPbOwf/U27EMkBOlFQjbZNJjEen5j4a9YGZB
         rS89kuut+SYH3Y+lkOEW4cavQORATe2ZevnH0DY3Sz2vMeG9kLiiPdpsyRsBblGGBrhp
         g+k+i8ma7ZOWkhjEb3FzVowrruUl/O8IjLPAfbcADEbI2PTuhRBtGFQ8enEUaMSzUtC8
         s+vs462Ko154tDuh7vMsvB6StgehU510zlHW8vadWNSATny3UAZCf+Qg9AnjPssy11VU
         LEtQ==
X-Gm-Message-State: APjAAAVgDwQ3pTxZbr6RwTwLBEqksRr5WxjNacNIkb67fzhFzOUWA15I
        cZKhnab2r44/YwvNCiWSunc=
X-Google-Smtp-Source: APXvYqy5VpAxE2+uRSaLsVuKHNaA99tf9NxpWLpT5y0+NOpIHG5PsHE2/fvF7Vm3X1BNn7n+r8FAEg==
X-Received: by 2002:a62:ee01:: with SMTP id e1mr5352636pfi.3.1571388002484;
        Fri, 18 Oct 2019 01:40:02 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id a13sm6339494pfg.10.2019.10.18.01.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:40:02 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:39:55 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/469: Skip the test if fallocate keep_size is not
 supported
Message-ID: <20191018083951.GJ2622@desktop>
References: <20191016105347.16650-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016105347.16650-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 16, 2019 at 07:53:47PM +0900, Misono Tomohiro wrote:
> This test requires fallocate keep_size. So, skip the test if
> a target FS does not support the function to avoid false negative.
> 
> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Would you please paste the false failure you've seen? I can't recall I
hit such failures, and I think fsx would just disable unsupported
operations and don't cause failure, it just prints a message to stderr,
and we already redirect stderr to $seqres.full in run_fsx in 469.

Thanks,
Eryu

> ---
>  tests/generic/469 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/469 b/tests/generic/469
> index 47fdf0cf..0c6f8ae5 100755
> --- a/tests/generic/469
> +++ b/tests/generic/469
> @@ -40,6 +40,7 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> +_require_xfs_io_command "falloc" "-k"
>  
>  run_fsx()
>  {
> -- 
> 2.21.0
> 
