Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF10C47087
	for <linux-fstests@archiver.kernel.org>; Fri, 28 May 2021 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13EF61186
	for <linux-fstests@archiver.kernel.org>; Fri, 28 May 2021 11:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbhE1L7y (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 May 2021 07:59:54 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:58896 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233262AbhE1L7y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 May 2021 07:59:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UaN4K2f_1622203096;
Received: from bogon(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UaN4K2f_1622203096)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 May 2021 19:58:18 +0800
Date:   Fri, 28 May 2021 19:58:16 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/xfs: Fix _require_scratch_xfs_shrink bug
Message-ID: <YLDa2Hc/1jlmi02P@bogon>
References: <1622194870-2085-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1622194870-2085-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 28, 2021 at 05:41:10PM +0800, Yang Xu wrote:
> Since local declaration can't pass function return value, this
> helper never detects whether kernel or xfsprogs supports
> xfs shrink feature successfully. Fit it by separating declaration
> and assignment of local variables.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(It seems a post-modified occasional issue since I didn't
 use a local variable here in the original patchset...)

Thanks,
Gao Xiang

> ---
>  common/xfs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/common/xfs b/common/xfs
> index d7f2a005..c5e39427 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -820,7 +820,8 @@ _require_scratch_xfs_shrink()
>  	. $tmp.mkfs
>  	_scratch_mount
>  	# here just to check if kernel supports, no need do more extra work
> -	local errmsg=$($XFS_GROWFS_PROG -D$((dblocks-1)) "$SCRATCH_MNT" 2>&1)
> +	local errmsg
> +	errmsg=$($XFS_GROWFS_PROG -D$((dblocks-1)) "$SCRATCH_MNT" 2>&1)
>  	if [ "$?" -ne 0 ]; then
>  		echo "$errmsg" | grep 'XFS_IOC_FSGROWFSDATA xfsctl failed: Invalid argument' > /dev/null && \
>  			_notrun "kernel does not support shrinking"
> -- 
> 2.27.0
> 
