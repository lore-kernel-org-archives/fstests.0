Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856E0C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 15:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiEPP1U (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbiEPP1P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 11:27:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D81276B
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 08:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FB32B8121B
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 15:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28227C385AA;
        Mon, 16 May 2022 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652714829;
        bh=UQqmKz2SXvG/OqfRAMD343UYcaGpdsnFwGgy8NzeWV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYYqSRWCoDTG7BjHXSO7h26U3E59pXXZin7rQEcjINh3ks/h4JjgTwT0TfPPV3xIN
         Cs1HZbe0XLNa4j/1HeE6qSmMlaxmi8jrqhLMZqTpn0enLorD6l1a52ga1PcEPkYUq5
         7Y7GHInUURs+xEonev14D2lHHt5EVHWndGaBC71i3l6H54IwuCrVjQEk6ByvcfVw8j
         tOggioBs99l+cikIE7PcFBRBviNWaUT2Dt+nqPENC2nTF736OknQeOt+kSdRtikpyg
         7y2nSFQhwIWStajLqhQVjzbg8Pioq5N2YKYRXawU6nEnOuF0ndcfJLAMadp1HuxQ/b
         DJNgryhJA1EUA==
Date:   Mon, 16 May 2022 08:27:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs/122: add attribute log formats to test output.
Message-ID: <YoJtTAFl/KXEAXzb@magnolia>
References: <20220516060807.1295102-1-david@fromorbit.com>
 <20220516060807.1295102-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516060807.1295102-3-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 16, 2022 at 04:08:06PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Now that we have merged logged attributes, add the attribute log
> format sizes to the on-disk structure size checking.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Looks correct,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/122.out | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> index 608faa4b..a56cbee8 100644
> --- a/tests/xfs/122.out
> +++ b/tests/xfs/122.out
> @@ -63,6 +63,8 @@ sizeof(struct xfs_attr3_leaf_hdr) = 80
>  sizeof(struct xfs_attr3_leafblock) = 88
>  sizeof(struct xfs_attr3_rmt_hdr) = 56
>  sizeof(struct xfs_attr_shortform) = 8
> +sizeof(struct xfs_attrd_log_format) = 16
> +sizeof(struct xfs_attri_log_format) = 40
>  sizeof(struct xfs_btree_block) = 72
>  sizeof(struct xfs_btree_block_lhdr) = 64
>  sizeof(struct xfs_btree_block_shdr) = 48
> -- 
> 2.35.1
> 
