Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C41C4361B
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Dec 2020 13:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B373822D03
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Dec 2020 13:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLFNWF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Dec 2020 08:22:05 -0500
Received: from out20-49.mail.aliyun.com ([115.124.20.49]:48149 "EHLO
        out20-49.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgLFNWF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Dec 2020 08:22:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=0.333949|-1;BR=01201311R151ee;CH=green;DM=|CONTINUE|false|;DS=SPAM|spam_ad|0.83018-0.000523727-0.169297;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.J3dcGwP_1607260876;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.J3dcGwP_1607260876)
          by smtp.aliyun-inc.com(10.147.43.95);
          Sun, 06 Dec 2020 21:21:17 +0800
Date:   Sun, 6 Dec 2020 21:21:16 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH] generic/506: require prjquota
Message-ID: <20201206132116.GT3853@desktop>
References: <20201202101521.15405-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202101521.15405-1-jencce.kernel@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 02, 2020 at 06:15:21PM +0800, Murphy Zhou wrote:
> To avoid false failure on overlayfs.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  tests/generic/506 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/506 b/tests/generic/506
> index d5b28cad..edcda6db 100755
> --- a/tests/generic/506
> +++ b/tests/generic/506
> @@ -42,6 +42,7 @@ rm -f $seqres.full
>  # real QA test starts here
>  _supported_fs generic
>  
> +_require_prjquota
>  _require_scratch
>  _require_scratch_shutdown

generic/506 already has _require_prjquota below, and it requires the
device to be mounted first.

_qmount_option "prjquota"                                                                                                                                                                                                                      
_qmount
_require_prjquota $SCRATCH_DEV

So would you please give more details on the failure you want to fix?

Thanks,
Eryu

>  
> -- 
> 2.20.1
