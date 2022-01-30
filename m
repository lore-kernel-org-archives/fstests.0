Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6DAC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Jan 2022 04:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbiA3E4t (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 29 Jan 2022 23:56:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48008 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiA3E4r (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 29 Jan 2022 23:56:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CE4CB82807
        for <fstests@vger.kernel.org>; Sun, 30 Jan 2022 04:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A647C340E4;
        Sun, 30 Jan 2022 04:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643518605;
        bh=mTjtIZLB3msD0kfKTRjER28wco9oHNw8KVZdSQ9faNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOKAIpGTJczsPK1T6JQJYlJwlbgUYWBmL0L0X+mApLQPsWrw7pBMraP5JKIu4ISuE
         yw3i5mJAi7yRnoTyYdb6pahAEHZWBYCN2ru6pL3HAgvmgtDMzHsAKyBcm6iqN/MeVf
         fVhm4YmnuW2/JiVX+qlC7y8U1dli4W5Y1uxc4yEghhtiSa8G2J6HJrR/hRjsGO146i
         k0Yml6MP3xpgg/vcdFDH9AtTiBpIIge9n6diNet96VPbXAxDCNlD12105eJjj5kj0E
         FLnfFV/b1cdPZVkMhLT8lzaA3YLbOUpsfTJ6RkJPy/i/KUJgGpT/D35HKcBmFpM/+k
         EwFGipRUPKDGA==
Date:   Sat, 29 Jan 2022 20:56:44 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fsx: disable allocsp_calls if -F is specified
Message-ID: <20220130045644.GP13563@magnolia>
References: <20220129044431.1404283-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129044431.1404283-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jan 29, 2022 at 12:44:31PM +0800, Zorro Lang wrote:
> As the fsx.c source code says:
>   int     fallocate_calls = 1;            /* -F flag disables */
>   int     allocsp_calls = 1;              /* -F flag disables */
> 
> The allocsp_calls and fallocate_calls should be disabled, if the -F
> option is specified. But current fsx forgets to disable allocsp_calls
> as is documented.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi Darrick,
> 
> Please help to take a look. I'm not sure if you'd like to disable
> allocsp_calls by -F flag, or just copied that line then forgot to
> change the F to another ?

Nah, that's ... fine.  Thanks for fixing this.  I hate ALLOCSP. :)
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> Thanks,
> Zorro
> 
>  ltp/fsx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 520e53a2..3ee37fe8 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2835,6 +2835,7 @@ main(int argc, char **argv)
>  			break;
>  		case 'F':
>  			fallocate_calls = 0;
> +			allocsp_calls = 0;
>  			break;
>  		case 'K':
>  			keep_size_calls = 0;
> -- 
> 2.31.1
> 
