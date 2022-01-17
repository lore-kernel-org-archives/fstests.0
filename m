Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85239C43217
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Jan 2022 17:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbiAQRQE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Jan 2022 12:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241427AbiAQRNW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Jan 2022 12:13:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B6AC0617BA
        for <fstests@vger.kernel.org>; Mon, 17 Jan 2022 09:07:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60585611D9
        for <fstests@vger.kernel.org>; Mon, 17 Jan 2022 17:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF706C36AEC;
        Mon, 17 Jan 2022 17:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642439278;
        bh=otxc99klB8vz6DUKqEdXx30h0VUfYMtyCP2bI4UGy9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mEG5xkNfii8CLMVUGSuV6vxGNolLFZtp8g7FDVaYRIQxr4WumCLUEDXbr7eFl1M9B
         mdGY8yBuVHwVzklXbWdPwI2kMYSNyh+xdvgRwH8X+hJ/u0K4mEJ9zxERWxA8OXmJOC
         +VuF8N1hxBToYggyNLCfGwOvIMNuGT3NueLk9Yn8L2J48JVrkveDQkSuR0eNumTkId
         ecOR1i5r36lLVmcdIlXFOuTJDqOcdGSp5+1Km+j8ykt4NXl0qX4kn0ie+/25rJGsXK
         jQDMArBeYIliqA8cAnFK5ATH8SjWtdYdiGBSUVUSd8IEgrd25+ZfrN8DL9eUecNYKX
         w2LBDlQHkFjAQ==
Date:   Mon, 17 Jan 2022 09:07:58 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull
 call
Message-ID: <20220117170758.GA13514@magnolia>
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jan 17, 2022 at 03:36:54PM +0800, Yang Xu wrote:
> On my test machine, ext4/033 fails even use the non-overflow size.
> It reports invalid new size when using strtoull because errno is 1.
> 
> As man-pages said "Since  strtoul()  can legitimately return 0 or ULONG_MAX
> (ULLONG_MAX for strtoull()) on both success and failure, the calling program
> should set errno to 0 before the call, and then determine if an error occurred
> by checking whether errno has a nonzero value after the call".
> 
> So add a step to set errno to 0 before strtoull call.
> 
> Fixes: 92b9c0dedace ("ext4/033: test EXT4_IOC_RESIZE_FS by calling the ioctl directly")
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  src/ext4_resize.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/ext4_resize.c b/src/ext4_resize.c
> index 1ac51e6f..39e16529 100644
> --- a/src/ext4_resize.c
> +++ b/src/ext4_resize.c
> @@ -35,6 +35,7 @@ int main(int argc, char **argv)
>  		return 1;
>  	}
>  
> +	errno = 0;
>  	new_size = strtoull(argv[2], &tmp, 10);
>  	if ((errno) || (*tmp != '\0')) {
>  		fprintf(stderr, "%s: invalid new size\n", argv[0]);
> -- 
> 2.23.0
> 
