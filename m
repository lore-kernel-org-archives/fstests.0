Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A775AC4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Nov 2022 19:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiKNTT0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Nov 2022 14:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKNTTZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Nov 2022 14:19:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18CE21260
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 11:19:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F091B8047E
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 19:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D672BC433C1;
        Mon, 14 Nov 2022 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668453554;
        bh=heP3RBisnS43KUxCKVTtUE+TvqYw74JtxjIpT9ClHIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6YjbSNMYxtVGOQjWiPuL1+ZjJlfiehYc9BJIjAs1tEZ5y7YYuxThJCK1ZODbyA3i
         KzMiYHgjOhWzB7zTLZ8AyOj/weFlIgB0OmCLLXmcjnx6kYLdv/Rpy/LYGh2fMBUpeV
         7pIDbdq5opaQWNrklCNXVf4kGnq++bUspfCMBgMgGE9SNVcgPdTkO9oOVwbRZxAkdq
         7AZALqYXPb1TYe2Yh79yCWA+nOGsHCWPL8OlduT+RvQOnBRW5WJm3pcN2YpOFcB7Lr
         ES6+yhQvxRPgmKn5XGkpMvrDCHyS8WbqzpPnsGv0u0AtcYDNLAh62VcJhk5chFSa/S
         RSxUkm1KtM2Lg==
Date:   Mon, 14 Nov 2022 11:19:14 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     zlang@redhat.com, fstests@vger.kernel.org, bfoster@redhat.com,
        y-goto@fujitsu.com
Subject: Re: [PATCH v2 1/2] common/dmlogwrites: Extend _log_writes_init() to
 accept the specified length
Message-ID: <Y3KUsts+VNTBGcaX@magnolia>
References: <1668414903-13-1-git-send-email-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668414903-13-1-git-send-email-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 14, 2022 at 08:35:02AM +0000, Xiao Yang wrote:
> It is unnecssary to always create a dm-log-writes device
> based on the entire size of the target/underlying device.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/dmlogwrites | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index 9fa1c977..c1c85de9 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -59,14 +59,28 @@ _require_log_writes_dax_mountopt()
>  	fi
>  }
>  
> +# Set up a dm-log-writes device
> +#
> +# blkdev: the specified target device
> +# length(optional): the mapped length in bytes
> +# Note that the entire size of the target device will be used
> +# if length is not specified.
>  _log_writes_init()
>  {
> -	blkdev=$1
> +	local blkdev=$1
> +	local length=$2
> +	local BLK_DEV_SIZE
>  
>  	[ -z "$blkdev" ] && _fail \
>  	"block dev must be specified for _log_writes_init"
>  
> -	local BLK_DEV_SIZE=`blockdev --getsz $blkdev`
> +	if [ -z "$length" ]; then
> +		BLK_DEV_SIZE=`blockdev --getsz $blkdev`
> +	else
> +		local blksz=`blockdev --getss $blkdev`
> +		BLK_DEV_SIZE=$((length / blksz))
> +	fi
> +
>  	LOGWRITES_NAME=logwrites-test
>  	LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
>  	LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $blkdev $LOGWRITES_DEV"
> -- 
> 2.34.1
> 
