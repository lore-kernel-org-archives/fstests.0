Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B94C76196
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Mar 2023 16:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjC1QCk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Mar 2023 12:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjC1QCg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Mar 2023 12:02:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D2210273
        for <fstests@vger.kernel.org>; Tue, 28 Mar 2023 09:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79183B81DA3
        for <fstests@vger.kernel.org>; Tue, 28 Mar 2023 16:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BCEC433D2;
        Tue, 28 Mar 2023 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680019346;
        bh=Am1BAojwTuYEWn+iG4Ti4FgTaSNUmCzyIzh6cvmd9cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1lteZgjfiTWmBpJJ+CbfzT8+c13WBDok40Gll3FJTKqMjPVoxgQUZNWTCbcaQjy+
         ssq/QNLWTpSUPj+11TDRsMVNKkfmjzfQ78UmQpSjcyjpji++SiWBSWIcaBPHkCytcF
         XGBtu98RCYXqaZxPclsQIXVdbMs++nB8oSfo/FcotamJpwAlq5YoyWdQLO8JVJ73kP
         A0KgFc5ND37VTp/PEnf8Hub7Q5eORZ5mJzywbNHxOzlGZhjxXkiRO34RBOlgv3IKQb
         iP5iazC4QjKH1HNvOZQL+saB18B868e0iZ8s171diFrYmT9VtiEiUOQkvmCKQUKvpV
         xHShaddh/BE/Q==
Date:   Tue, 28 Mar 2023 09:02:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common: switch _get_available_space accounting to units
 of 512 bytes
Message-ID: <20230328160225.GB16170@frogsfrogsfrogs>
References: <20230328150104.129486-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328150104.129486-1-ailiop@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 28, 2023 at 05:01:04PM +0200, Anthony Iliopoulos wrote:
> xfs/220 relies on detecting free space changes after truncation of
> single filesystem blocks, and this fails when the fs block size is 512b.
> 
> By default df is counting 1024b block units and as such is not reporting
> any change in the number of available blocks after freeing just a 512b
> block.
> 
> Switch the df reporting block size from units of 1024b blocks to 512b
> blocks to accommodate accounting for smaller granularity fs block sizes.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 90749343f3c4..a32bbe3c0b5f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4209,8 +4209,8 @@ _get_available_space()
>  		exit 1
>  	fi
>  	local avail_kb;
> -	avail_kb=`$DF_PROG $1 | tail -n1 | awk '{ print $5 }'`
> -	echo $((avail_kb * 1024))
> +	avail_kb=`$DF_PROG --block-size=512 $1 | tail -n1 | awk '{ print $5 }'`
> +	echo $((avail_kb * 512))

Why not have df report the free space in bytes?

$DF_PROG -B 1 $1 | tail -n 1 | awk '{print $5}'

--D

>  }
>  
>  # get the total space in bytes
> -- 
> 2.35.3
> 
