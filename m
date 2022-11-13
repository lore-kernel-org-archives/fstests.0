Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F93C4332F
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Nov 2022 17:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiKMRy3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Nov 2022 12:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMRy3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Nov 2022 12:54:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E8ED11C
        for <fstests@vger.kernel.org>; Sun, 13 Nov 2022 09:54:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9126660B02
        for <fstests@vger.kernel.org>; Sun, 13 Nov 2022 17:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41ACC433D6;
        Sun, 13 Nov 2022 17:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668362066;
        bh=ms9NnC+jS5tVOYHp5IDDqtxW5Yux11EhZpz1PPBjPa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IodnrzWoR+ZhHL+wZ8qZwH+tevyKoUUpxFq32NkgG+AMHoTD+yh7RaiFOW/SXps7g
         3/+mmCJU5rPuZAP2i25k08QUh17nGuVKtlboHfCj71UalftOgMNswFzp/vkne1ckq3
         d8D/vQTKHPGLNxdiJ+EwcVyFZXlgIE7BpKMdtzMGaLJx9RqS+1NfSLCPJu1kQZRXOr
         2MKDfrz4h/T600//aXLXCBZakwNysvkkNbZjyxsFh455FLYBiGsZKQcVK9t0ubu6S7
         w57fT+FI2hoxgYxqyovOb65HBSGkZSmyUmyRRdneK70HO4g3OKuiuI1rxycj8NQI+d
         bnIcIvtlBlQfw==
Date:   Sun, 13 Nov 2022 09:54:26 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "zlang@redhat.com" <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH RESEND 1/2] common/dmlogwrites: Extend _log_writes_init()
 to accept the specified size
Message-ID: <Y3EvUgtux4tP1tdY@magnolia>
References: <20221023064810.847110-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023064810.847110-1-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Oct 23, 2022 at 06:48:13AM +0000, yangx.jy@fujitsu.com wrote:
> It is unnecssary to always create a log-writes device based on
> the size of the entire underlying device.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  common/dmlogwrites | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index 9fa1c977..d7b23cec 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -61,12 +61,20 @@ _require_log_writes_dax_mountopt()
>  
>  _log_writes_init()
>  {
> -	blkdev=$1
> +	local blkdev=$1
> +	local range=$2

Range is a length in ... bytes?  The unit ought to be recorded in a
comment for this function.

With that fixed, this looks ok to me
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +	local BLK_DEV_SIZE
>  
>  	[ -z "$blkdev" ] && _fail \
>  	"block dev must be specified for _log_writes_init"
>  
> -	local BLK_DEV_SIZE=`blockdev --getsz $blkdev`
> +	if [ -z "$range" ]; then
> +		BLK_DEV_SIZE=`blockdev --getsz $blkdev`
> +	else
> +		local blksz=`blockdev --getss $blkdev`
> +		BLK_DEV_SIZE=$((range / blksz))
> +	fi
> +
>  	LOGWRITES_NAME=logwrites-test
>  	LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
>  	LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $blkdev $LOGWRITES_DEV"
> -- 
> 2.34.1
