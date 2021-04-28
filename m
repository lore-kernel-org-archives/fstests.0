Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F830C433B4
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 04:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3369613F4
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 04:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhD1EIa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Apr 2021 00:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhD1EIa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Apr 2021 00:08:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 897CD613ED;
        Wed, 28 Apr 2021 04:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619582865;
        bh=2maRGlUGnDUaCpfVsFw9z8vOz8I6Fm8VCVjc2SATn6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iAtb11Ptrz6iErnNOxul3K/MOF8igeLc8Mamnn1Eq68UYPvyCB85jgMF6HY+9ou9Y
         E65AFri6ldC116bAtcv58IXZYKO0MRB8fi7cXoen+RflOP/S9VW+JTA+l5UYWDBUwC
         8CEwrEVGKaKlM7K8bHj0g96CxjJ/fnUyYwtMqfL50BanmJs3F66KPVaD51674EWVa7
         Cgc1/AdEy/OwpYESO+sFYXBhY3uihcDaND/k7gS5omcZ+IjYA8yP6xU8UkTVjeFaCA
         m4P+mfQP/43LK48yqrp/qgG8N1lRxgOiEsxgSrzvIMpKqRjDHzFORuyW5llGcpZAWn
         APp1D2g+IkJ9w==
Date:   Tue, 27 Apr 2021 21:07:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     XiaoLi Feng <xifeng@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: not run swapfile test for DAX
Message-ID: <20210428040744.GI3122235@magnolia>
References: <20210424161523.4786-1-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424161523.4786-1-xifeng@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 25, 2021 at 12:15:23AM +0800, XiaoLi Feng wrote:
> From: Xiaoli Feng <xifeng@redhat.com>
> 
> DAX doesn't support swapfile. Without this patch,
> _require_scratch_swapfile always returns fail for fsdax. Now
> change to notrun.
> 
> Signed-off-by: Xiaoli Feng <xifeng@redhat.com>

Sorry about my earlier mutterings, I forgot that I'm (still) so far
behind on sending fstests patches upstream that I hadn't actually gotten
to the one that fixes this.  Hence my earlier questions about "can't you
just use the existing S_DAX check?" make no sense.

> ---
>  common/rc | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 11ff7635..c3c40f30 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2461,8 +2461,13 @@ _require_scratch_swapfile()
>  	case "$FSTYP" in
>  	ext2|ext3|ext4|xfs)
>  		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> -			_scratch_unmount
> -			_fail "swapon failed for $FSTYP"
> +			if _check_s_dax "$SCRATCH_MNT/swap" 1 >/dev/null; then
> +				_scratch_unmount
> +				_notrun "swapfiles are not supported"
> +			else
> +				_scratch_unmount
> +				_fail "swapon failed for $FSTYP"
> +			fi
>  		fi
>  		;;
>  	*)
> @@ -3326,6 +3331,7 @@ _check_s_dax()
>  {
>  	local target=$1
>  	local exp_s_dax=$2
> +	local ret=0
>  
>  	local attributes=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
>  
> @@ -3347,9 +3353,12 @@ _check_s_dax()
>  
>  	if [ $exp_s_dax -eq 0 ]; then
>  		(( attributes & 0x00200000 )) && echo "$target has unexpected S_DAX flag"
> +		(( attributes & 0x00200000 )) && ret=1
>  	else
>  		(( attributes & 0x00200000 )) || echo "$target doesn't have expected S_DAX flag"
> +		(( attributes & 0x00200000 )) || ret=2

Though I suppose if we want to pick nits here, it's kind of silly to
test this twice:

		if (( attributes & 0x00200000 )); then
			echo "$target doesn't have expected S_DAX_flag"
			return 2
		fi

OTOH, that's fairly minor so:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  	fi
> +	return $ret
>  }
>  
>  _check_xflag()
> -- 
> 2.18.1
> 
