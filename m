Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA88C6FD18
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Mar 2023 16:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjC2Qw6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Mar 2023 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjC2Qwz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Mar 2023 12:52:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB975FFA
        for <fstests@vger.kernel.org>; Wed, 29 Mar 2023 09:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3941F61DC5
        for <fstests@vger.kernel.org>; Wed, 29 Mar 2023 16:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928A9C433D2;
        Wed, 29 Mar 2023 16:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680108773;
        bh=qrouq3sMkhjRGEJOOrxy+Z2jQRyAZk+NBsfZ3ZGNH2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9WsjLYXga6bbo9QXY56ek8emAM1X5F879Z66feCftXTWZZav0Zg9oII5xXrKFUfu
         mhs4JnhoyiXRfREh7FtxhHXfRCCRCUaExne18GotnuXJa/3Jz8Vx965ZAEy7roez8j
         fqtBnUplX0y8s6T6wWDna4JDmrc09wCE3EUp4TjxHMcVPAbQhEJPyNPD0eVG+1Hdo9
         gVySDLUKdytrjy3iyNx0qbDjiteusD9SgwQoHc41EY8ENUZ7K25tqRPb7xX/8Pw3nL
         UWFBiVGg/A0UhfV7Xv96qrYYMGkjJwYErNF1yGAmMxZCiJ8wd1O8XNd6eGROTvQtPP
         FWQML/dVu615w==
Date:   Wed, 29 Mar 2023 09:52:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] common: switch _get_{available,total}_space
 accounting to units of single bytes
Message-ID: <20230329165253.GC16170@frogsfrogsfrogs>
References: <20230329155236.81521-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329155236.81521-1-ailiop@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 29, 2023 at 05:52:36PM +0200, Anthony Iliopoulos wrote:
> xfs/220 relies on detecting free space changes after truncation of
> single filesystem blocks, and this fails when the fs block size is 512b.
> 
> By default df is counting 1024b block units and as such is not reporting
> any change in the number of available blocks after freeing just a 512b
> block.
> 
> Switch the _get_available_space df reporting block size from units of
> 1024b blocks directly to single bytes in order to make free space
> accounting fine-grained and independent of any fs block size
> assumptions.
> 
> Do the same for _get_available_space, since there is no reason for
> having an additional conversion step.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  common/rc | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> v2: incorporate changes from reviews by djwong and zlang
> * change reporting directly to bytes and avoid conversion step
>   altogether
> * do the same for _get_available_space
> 
> diff --git a/common/rc b/common/rc
> index 90749343f3c4..9e4475c0f429 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4208,9 +4208,7 @@ _get_available_space()
>  		echo "Usage: _get_available_space <mnt>"
>  		exit 1
>  	fi
> -	local avail_kb;
> -	avail_kb=`$DF_PROG $1 | tail -n1 | awk '{ print $5 }'`
> -	echo $((avail_kb * 1024))
> +	$DF_PROG -B 1 $1 | tail -n1 | awk '{ print $5 }'
>  }
>  
>  # get the total space in bytes
> @@ -4221,9 +4219,7 @@ _get_total_space()
>  		echo "Usage: _get_total_space <mnt>"
>  		exit 1
>  	fi
> -	local total_kb;
> -	total_kb=`$DF_PROG $1 | tail -n1 | awk '{ print $3 }'`
> -	echo $(($total_kb * 1024))
> +	$DF_PROG -B 1 $1 | tail -n1 | awk '{ print $3 }'

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  }
>  
>  # return device size in kb
> -- 
> 2.35.3
> 
