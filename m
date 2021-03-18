Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57B4C433DB
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 16:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A37A64F45
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhCRQXA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232227AbhCRQWq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Mar 2021 12:22:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F7CF64F40;
        Thu, 18 Mar 2021 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616084566;
        bh=okdPbdUoNr0OvTYPBHVhmn9Mjk+a2Dn592HhRCV3pdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=is1pu32P8Fn2l/O1sWCL9SeO4PTX2W3qMIWmNArc+jC8oGb8FlSSoe/RzhWlcFDDP
         bQYSt0a6l5hmQbRLQvK+BlYOo8zFvL4yEbycLIf/3NXuXB0k5Bwfeh2h6AmmRN0G8C
         UWOhyQgoHeI0JbAEoDC8lZEbCPCNgfxQp6LEZnNy9WTkghbnDu6xEkzjftgPvN5MmH
         GwCRrwS5Y/vhGTItWXJOK2MGWy8Wh+nIdzLvi1Ro1teuisym2sQDjTOSYBSEMgI0lN
         OZ8u3wXtSKj9gO3mYjRTKpNWPJvcKNqjvxKQIRkCKSzIbGxN79vveJCPhks8ax2C1n
         U5FeK3wjysUng==
Date:   Thu, 18 Mar 2021 09:22:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] src/chprojid_fail.c: Fix undefined compile error on old
 kernel
Message-ID: <20210318162245.GA1670408@magnolia>
References: <1615975873-19206-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615975873-19206-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 17, 2021 at 06:11:13PM +0800, Yang Xu wrote:
> On old kernel, linux/fs.h doesn't include FS_IOC_FSGETXATTR and FS_IOC_FSGETXATTR
> ioctl flag. It also doesn't include fsxattr struct. To fix this error, just
> use global.h like fsstress.c.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Looks good to me, I already had a bug report this morning about this. :/

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  src/chprojid_fail.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/chprojid_fail.c b/src/chprojid_fail.c
> index 8c5b5fee..6d1e0fac 100644
> --- a/src/chprojid_fail.c
> +++ b/src/chprojid_fail.c
> @@ -15,6 +15,7 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <linux/fs.h>
> +#include "global.h"
>  
>  static char zerobuf[65536];
>  
> -- 
> 2.23.0
> 
