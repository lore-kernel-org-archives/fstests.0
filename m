Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48246C433ED
	for <linux-fstests@archiver.kernel.org>; Sat, 17 Apr 2021 16:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1A46120C
	for <linux-fstests@archiver.kernel.org>; Sat, 17 Apr 2021 16:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhDQQz1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 17 Apr 2021 12:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236537AbhDQQz0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 17 Apr 2021 12:55:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AE0D610C7;
        Sat, 17 Apr 2021 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618678500;
        bh=PG5JHKtc6FZGNnpWp/QC1IJxc90YULSAUuOZgiRangU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dObjMuoziauZNO3hJzP0fc/IsCJQUkdD80FWe6a+Szte7PlDo2J6eWxDRY+KfX6ni
         +qj5JKyCkhFvnfupLZ8EJSVzkfOwJi9xXTPoed4ls8niGQAJ7sMJ2zirq32pF/pVAB
         auPHvxEklg1KHZih1ACdoNboPyjTYh7gaQdJEmsGfMnILAuetisFLpJrM3s1YU38AK
         i1l+At9o65L4A/bLdUzCCFbnv37xxulx8ht64VNORtKpZVId11aQhjl4V4wrQoF2pm
         kcaMeql3nEridymdcsaVa1N9hEIcfu3g76JG4r+4aNj0lDtaLANtYi5zPknvGUPPwy
         etGxouAZRP4aw==
Date:   Sat, 17 Apr 2021 09:54:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xifeng@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v1] common/rc: not run swapfile test for DAX
Message-ID: <20210417165458.GA3122235@magnolia>
References: <20210417164655.64065-1-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417164655.64065-1-xifeng@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Apr 17, 2021 at 12:46:55PM -0400, xifeng@redhat.com wrote:
> From: root <root@hp-dl385pg8-01.rhts.eng.pek2.redhat.com>
> 
> DAX doesn't support swapfile. Without this patch,
> _require_scratch_swapfile always returns fail for fsdax. Now
> change to notrun.
> 
> Signed-off-by: root <root@hp-dl385pg8-01.rhts.eng.pek2.redhat.com>

Who?

> ---
>  common/rc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 23f86ce6..d02b9f72 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2384,7 +2384,11 @@ _require_scratch_swapfile()
>  	ext2|ext3|ext4|xfs)
>  		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
>  			_scratch_unmount
> -			_fail "swapon failed for $FSTYP"
> +			if _normalize_mount_options | egrep -q "dax(=always| |$)"; then

Doesn't the STATX_ATTR_DAX test above take care of this?

--D

> +				_notrun "swapfiles are not supported"
> +			else
> +				_fail "swapon failed for $FSTYP"
> +			fi
>  		fi
>  		;;
>  	*)
> -- 
> 2.27.0
> 
