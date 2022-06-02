Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71861C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 00:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiFBAw1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiFBAw1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 20:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B44DEB1
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A0FF61567
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 00:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B19FC385A5;
        Thu,  2 Jun 2022 00:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654131145;
        bh=A6H5tyKdR/lfnfPsAtodUQpj9yBf5+Sc6qHRWL+ppVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oj1BIWs/Y3nRWZxQAERwGS8oqNN+Nd0iDbdF/hr/mbQe81A43RvYPo5e/YyPDkLyy
         moimDSbi91jn99KRtWYt9m17YO9Qyvl4f6p/elbbQtJLoV5AcgxkbqomI4ky64GIQY
         XNOXorjOyGOQAWUHsGFzbSMNQuQWKORZ6qwGL9EoY6DHCtsiStFn/mJ0lUctEq5voR
         tu3iJkroKxasSTAUYZnWYSRkpaAG0varA0t2nJMxGEubiiZXdW2nAuKbNqrSumn1TL
         DKOr4jXV9VKseku+c9oBfHC8G4l+cKxurxd11KQFVAyD5c+jGrC6rOyIbJtqgS0/3Q
         3HiJxaWVrb5sw==
Date:   Wed, 1 Jun 2022 17:52:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 6/8] xfs/070: filter the bad sb magic number error
Message-ID: <YpgJyQyILBw99tBr@magnolia>
References: <20220602003126.2903779-1-david@fromorbit.com>
 <20220602003126.2903779-7-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602003126.2903779-7-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 02, 2022 at 10:31:24AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Lastest XFS kernel makes the superblock bad magic number error
> message more meaningful, and that's being picked up by xfsprogs in
> very short order. And, of course, the error is output by xfs_repair,
> too, and it's been captured in the golden output of a test. Fix it
> by filtering the output back down to the old message.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Heh, I had a patch just like this one!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/repair | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/repair b/common/repair
> index 5a957f4e..463ef9db 100644
> --- a/common/repair
> +++ b/common/repair
> @@ -90,6 +90,7 @@ s/(superblock) (\d+)/\1 AGNO/;
>  s/(AG \#)(\d+)/\1AGNO/;
>  s/(reset bad sb for ag) (\d+)/\1 AGNO/;
>  s/(unknown block state, ag )(\d+)(, blocks? )(\d+)/\1AGNO\3AGBNO/;
> +s/^Superblock has (bad magic number) 0x.*/\1/;
>  /^Note - quota info will be regenerated on next quota mount.$/ && next;
>  	print;'
>  }
> -- 
> 2.35.1
> 
