Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637FAC43334
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 15:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348186AbiF1PQg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348223AbiF1PQK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 11:16:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCFB2FFE1
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 08:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E63E60EBE
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 15:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FEFC3411D;
        Tue, 28 Jun 2022 15:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656429369;
        bh=cyVMHPEDn1ADFUzbH1X5LeJlTjkPl6cVx5DqicokwF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XycHNOt7m/FO5OZl1S63UPb8+btUeNn8uRldEsoL88cOG3aG9r0a2BfSuvt2xbtWH
         1gWXOBSawZ3zI25x2Wmq6AXSr/bb4Kayd6l8XNjpZ0nVmy0sIRUEvdAyEBSDG1oaRv
         upcQSnos1m8H0C5FjXOXAfGAZiPUjzUtHWod1rI6OHAzNuyXmYtZdMyugCtVcWfPCv
         SmTTxXBCLuXDrwWebE5YuJbYigNWaF9Hcu+sj8b46Yg9TJVybAXC+FToEsk5Nfuvdx
         4HUYzIF45E7qDE/ATP/Ij2Dhc24ZaUvOjTdR1WTdRZOJvn2j67YPc0NcjJaiInlFxU
         ZDEtpSZY6LnHw==
Date:   Tue, 28 Jun 2022 08:16:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [RFC PATCH v2 6/6] check: stash full/dmesg/out.bad files on rerun
Message-ID: <YrsbOCcAA5+dDjdl@magnolia>
References: <20220627222256.14175-1-ddiss@suse.de>
 <20220627222256.14175-7-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627222256.14175-7-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 28, 2022 at 12:22:56AM +0200, David Disseldorp wrote:
> These files would otherwise be overwritten.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Why not fold this into the previous patch?

--D

> ---
>  check | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/check b/check
> index 726c83d9..baf336da 100755
> --- a/check
> +++ b/check
> @@ -570,8 +570,17 @@ _stash_test_status() {
>  				      "$report_msg"
>  	fi
>  
> -	# only stash result for first failure (triggering loop)
> -	((loop_num > 1)) && return
> +	if ((loop_num > 0)); then
> +		# retain files which would be overwritten in subsequent reruns
> +		for i in "${REPORT_DIR}/${test_seq}.full" \
> +			 "${REPORT_DIR}/${test_seq}.dmesg" \
> +			 "${REPORT_DIR}/${test_seq}.out.bad"; do
> +			[ -f "$i" ] || continue
> +			cp "$i" "${i}.rerun$((loop_num - 1))"
> +		done
> +		# only stash result for first failure (triggering loop)
> +		((loop_num != 1)) && return
> +	fi
>  
>  	case "$test_status" in
>  	fail)
> -- 
> 2.35.3
> 
