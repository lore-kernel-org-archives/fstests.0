Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB6DC433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 00:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiFBAwK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiFBAwJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 20:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C85CEB1
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA439615AF
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 00:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31827C385B8;
        Thu,  2 Jun 2022 00:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654131127;
        bh=bZLJgkJFT/6Pzzd3vrS8qtTnmlhvbRmRxJ6dytlPLEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eADV2lg/ecKlVtCvGLD+18vDZU4p1/A0fsvRksjbWsCG5DoME2ijPXy6CPGHFL4hX
         W9lng+3suzoKna25uyE3d8pM1oyLShh+41QbsbqzpYOVzU7ri0g7mO0ubyFjn/lAQ2
         hNpRO9wme+e3yjz6g/iskCTNuVft8C/taxL0VDfAlsz8ojy1/uuDorbQ3rKUuLtmzw
         206SehE0N8bYc2zy+GYAPfZO//GwHPvT67UCX07HDHO4lCVGpP9VbmcNgnBgx6znho
         WbTwtUkv2DMJ1ZOQOFdfxQHyeNZAq5H9cEQwYv4u2dK34TDV9zQDrZlzMfcX+QYGfl
         TIkRsYlNETl4w==
Date:   Wed, 1 Jun 2022 17:52:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 5/8] xfs/538: fix fsstress scaling
Message-ID: <YpgJtmddTl1bO6Fo@magnolia>
References: <20220602003126.2903779-1-david@fromorbit.com>
 <20220602003126.2903779-6-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602003126.2903779-6-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 02, 2022 at 10:31:23AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> _scale_fsstress_args() does time/load scaling of parameters. Doing
> it also in the test causes exponential scaling instead of linear
> scaling as the time/load parameters are meant to do.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Yep.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/538     | 36 +++++++++++++++++-------------------
>  tests/xfs/538.out |  3 +--
>  2 files changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/xfs/538 b/tests/xfs/538
> index e0102f48..2b5e97e5 100755
> --- a/tests/xfs/538
> +++ b/tests/xfs/538
> @@ -47,25 +47,23 @@ done
>  echo "Inject bmap_alloc_minlen_extent error tag"
>  _scratch_inject_error bmap_alloc_minlen_extent 1
>  
> -echo "Scale fsstress args"
> -args=$(_scale_fsstress_args -p $((LOAD_FACTOR * 75)) -n $((TIME_FACTOR * 1000)))
> -
> -echo "Execute fsstress in background"
> -$FSSTRESS_PROG -d $SCRATCH_MNT $args \
> -		 -f bulkstat=0 \
> -		 -f bulkstat1=0 \
> -		 -f fiemap=0 \
> -		 -f getattr=0 \
> -		 -f getdents=0 \
> -		 -f getfattr=0 \
> -		 -f listfattr=0 \
> -		 -f mread=0 \
> -		 -f read=0 \
> -		 -f readlink=0 \
> -		 -f readv=0 \
> -		 -f stat=0 \
> -		 -f aread=0 \
> -		 -f dread=0 > /dev/null 2>&1
> +echo "Execute fsstress"
> +$FSSTRESS_PROG -d $SCRATCH_MNT \
> +		$(_scale_fsstress_args -p 75 -n 1000) \
> +		-f bulkstat=0 \
> +		-f bulkstat1=0 \
> +		-f fiemap=0 \
> +		-f getattr=0 \
> +		-f getdents=0 \
> +		-f getfattr=0 \
> +		-f listfattr=0 \
> +		-f mread=0 \
> +		-f read=0 \
> +		-f readlink=0 \
> +		-f readv=0 \
> +		-f stat=0 \
> +		-f aread=0 \
> +		-f dread=0 > /dev/null 2>&1
>  
>  # success, all done
>  status=0
> diff --git a/tests/xfs/538.out b/tests/xfs/538.out
> index 85932c82..97ebc314 100644
> --- a/tests/xfs/538.out
> +++ b/tests/xfs/538.out
> @@ -3,5 +3,4 @@ Format and mount fs
>  Consume free space
>  Create fragmented filesystem
>  Inject bmap_alloc_minlen_extent error tag
> -Scale fsstress args
> -Execute fsstress in background
> +Execute fsstress
> -- 
> 2.35.1
> 
