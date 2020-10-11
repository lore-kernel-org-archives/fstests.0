Return-Path: <SRS0=fsOW=DS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93446C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Oct 2020 05:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57392221FF
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Oct 2020 05:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgJKFG1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Oct 2020 01:06:27 -0400
Received: from out20-87.mail.aliyun.com ([115.124.20.87]:45008 "EHLO
        out20-87.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJKFG0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Oct 2020 01:06:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1059748|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.152949-0.000629597-0.846421;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IhgIvsj_1602392783;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IhgIvsj_1602392783)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sun, 11 Oct 2020 13:06:23 +0800
Date:   Sun, 11 Oct 2020 13:06:23 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/611: Filter getfattr output
Message-ID: <20201011050622.GV3853@desktop>
References: <1602382464-1230-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602382464-1230-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Oct 11, 2020 at 10:14:24AM +0800, Yang Xu wrote:
> When using old version(such as getfattr 2.4.46) getfattr command, it
> has the following output,
> 
> touch file
> setfattr -n user.a file
> getfattr --absolute-names -n user.a file
> user.a
> 
> on new getfattr, it reports the following output,
> getfattr --absolute-names -n user.a file
> user.a=""

There's an helper to do this, _getfattr, so use it here instead of bare
$GETFATTR_PROG. For details please refer to commit 794f4594fbf4
("fstests: filter redundant output by getfattr")

Thanks,
Eryu

> 
> Filter doubt quotes and equals, so this case can pass.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/generic/611     | 2 +-
>  tests/generic/611.out | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/611 b/tests/generic/611
> index f4158bb3..c697b39a 100755
> --- a/tests/generic/611
> +++ b/tests/generic/611
> @@ -51,7 +51,7 @@ touch "${localfile}"
>  _scratch_cycle_mount
>  
>  # If the target bug isn't fixed, getfattr fails
> -${GETFATTR_PROG} --absolute-names -n user.a $localfile | grep 'user.a'
> +${GETFATTR_PROG} --absolute-names -n user.a $localfile | grep 'user.a' | sed 's/=""//g'
>  
>  status=0
>  exit
> diff --git a/tests/generic/611.out b/tests/generic/611.out
> index 1ab12434..8ccf52f0 100644
> --- a/tests/generic/611.out
> +++ b/tests/generic/611.out
> @@ -1,2 +1,2 @@
>  QA output created by 611
> -user.a=""
> +user.a
> -- 
> 2.23.0
> 
> 
