Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE655C47096
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Jun 2021 14:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49D161420
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Jun 2021 14:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhFFOI6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Jun 2021 10:08:58 -0400
Received: from out20-27.mail.aliyun.com ([115.124.20.27]:58237 "EHLO
        out20-27.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhFFOI4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Jun 2021 10:08:56 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.100074|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00784735-0.000381769-0.991771;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KOPSavF_1622988424;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KOPSavF_1622988424)
          by smtp.aliyun-inc.com(10.147.41.178);
          Sun, 06 Jun 2021 22:07:05 +0800
Date:   Sun, 6 Jun 2021 22:07:04 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, yuchao0@huawei.com
Subject: Re: [PATCH] generic/042: f2fs-utils 1.14.0 needs at least 52 MB
Message-ID: <YLzWiH5RwHFdEWIQ@desktop>
References: <20210601082005.1352814-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601082005.1352814-1-sunke32@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 01, 2021 at 04:20:05AM -0400, Sun Ke wrote:
> f2fs-utils 1.9.0 needs at least 38 MB space for f2fs image. However,
> f2fs-utils 1.14.0 needs at least 52 MB. Not sure if it will change again.
> But at least we need to configure mininum size of f2fs image to 52MB now.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  tests/generic/042 | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/042 b/tests/generic/042
> index ee0e4b400c71..bf3b4180b1a2 100755
> --- a/tests/generic/042
> +++ b/tests/generic/042
> @@ -43,9 +43,12 @@ _crashtest()
>  	file=$mnt/file
>  	size=25M
>  
> -	# 25M is too small for f2fs.
> +	# f2fs-utils 1.9.0 needs at least 38 MB space for f2fs image. However,
> +	# f2fs-utils 1.14.0 needs at least 52 MB. Not sure if it will change
> +	# again. But at least we need to configure mininum size of f2fs image
> +	# to 52MB now.

It'd be better to specify a slightly bigger fs size for f2fs then. I
don't think this test depends on the fs size, just that smaller size
makes test run faster.

Maybe 64M or 128M, any suggestions from f2fs folks?

Thanks,
Eryu

>  	if [ $FSTYP == "f2fs" ]; then
> -		size=38M
> +		size=52M
>  	fi
>  
>  	# Create an fs on a small, initialized image. The pattern is written to
> -- 
> 2.25.4
