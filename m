Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9358AC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Dec 2021 19:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbhLJT7D (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 14:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbhLJT7D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 14:59:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF316C061746
        for <fstests@vger.kernel.org>; Fri, 10 Dec 2021 11:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N6ZA7o5bfpONrDibkQdHukB24t2Sk8MrOWiNMFJFClc=; b=Y8IWd7vUgwpjqkylCfLspLqleY
        rbPSaxoPNNVdKHE5Y8jf9RC6nwIe60KI+vZpTOD/IuW4MgVQFz5XxEIRZoVnr9TItwXGgQiaU2zq2
        maFW2Phnai7rwt7QvGUiFb7XBxsqQFuQ2pnaqIKGZ+uxR27xmqv5DDRB5sCtOgqDb6z1dcgVc6GVP
        10sbKKGw2bEQpPE5IoLzCx6/4Sja8QxEZ8X1ZTffe/d6CeqsZjO3ulRmdO8ABy9LbL+wlIxtGLCak
        nYom+zI7JNH5CzhIp9NUluXTJOWhLWL6jqA66pp5ICDSPpiSl5SBPH4VGQQzPqiFD75GpV5fkZNv4
        DDPu6mJw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvlzK-003dec-L0
        for fstests@vger.kernel.org; Fri, 10 Dec 2021 19:55:26 +0000
Date:   Fri, 10 Dec 2021 11:55:26 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/module: fix patient module remover when module is
 not present
Message-ID: <YbOwrpa7SoJqErvZ@bombadil.infradead.org>
References: <20211115232834.4121190-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115232834.4121190-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Poke

On Mon, Nov 15, 2021 at 03:28:34PM -0800, Luis Chamberlain wrote:
> When module is not present and the open coded patient module
> remover is called we'll end up in a loop which never ends.
> Fix this.
> 
> I actually found this issue not in fstests, but when applying this
> open coded solution to blktests. In fstest we tend to only call
> module remove when we have a module loaded. blktests is different,
> and so I immediately spotted the issue there.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/module | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/common/module b/common/module
> index ead0f881..6efab71d 100644
> --- a/common/module
> +++ b/common/module
> @@ -180,6 +180,8 @@ _patient_rmmod()
>  				continue
>  			fi
>  			let max_tries=$max_tries-1
> +		else
> +			break
>  		fi
>  	done
>  
> -- 
> 2.33.0
> 
