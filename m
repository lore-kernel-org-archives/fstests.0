Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCD5C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jan 2022 21:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiAMVJf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jan 2022 16:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiAMVJf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jan 2022 16:09:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46312C061574
        for <fstests@vger.kernel.org>; Thu, 13 Jan 2022 13:09:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05445B8239F
        for <fstests@vger.kernel.org>; Thu, 13 Jan 2022 21:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CF6C36AE3;
        Thu, 13 Jan 2022 21:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642108172;
        bh=a/rAhYXh3AaCdnq+B47w945GRdyktdSdplW39doIRBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djPXmPl6yjc4hfj/YcfIWtsLdTZwjfsYiFogvf9dmRFssZd9WfyOko9QBqbQWsjsy
         CvAP7VCr9/Kk2MctkwBdmoRv/Om7DRjOPYaIn7YFhrfBWGoB+LmrjTDD3ewdlPJbqN
         dvzKBrY4vJ4NVaq+JLPkEpv5nlSXXw72Oycg4tm4GbVbhPJETGgeJdAUWJFO7Mqeqy
         bABMyZW8Bnjv7MPK9VbPPj2RzpxCy1P83DBVpeDHRhpwIAbkyDOaraSFXEJ2F0gYt9
         QF1aqPAiJT+/4T7HcVPCUqa3gcDbFSyQUr/3I3pzs2if58Ot59hnC5H5WClcmJvU1G
         y+VhCswGlHvMQ==
Date:   Thu, 13 Jan 2022 13:09:32 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/670: allow _mread_range() races with
 reflink_range()
Message-ID: <20220113210932.GA19171@magnolia>
References: <20220112092846.1467088-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112092846.1467088-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 12, 2022 at 05:28:46PM +0800, Shiyang Ruan wrote:
> mread copies data one-byte-at-a-time, so it may races with
> reflink_range() who invalidates page cache of the dest file.
> Allow this race by adjusting the egrep regexp.
> 
> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks reasonable; I'll put this in the test system for tonight and
report back if I see anything strange.  I didn't see anything obvious
after a dozen or so rounds.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/670 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/670 b/tests/generic/670
> index 83fbd0b9..4a895d90 100755
> --- a/tests/generic/670
> +++ b/tests/generic/670
> @@ -40,7 +40,10 @@ _cp_reflink $testdir/file1 $testdir/file3
>  _scratch_cycle_mount
>  
>  fbytes() {
> -	egrep -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62)'
> +	# Different with generic/164,165, mread copies data from mmapped area
> +	# one-byte-at-a-time, which may cause races during reflink_range().
> +	# So the result of _mread_range() may be a mix of 61 and 62.
> +	egrep -v '((61|62) ){15}(61|62)'
>  }
>  
>  reader() {
> -- 
> 2.34.1
> 
> 
> 
