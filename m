Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D92C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 19:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357893AbiELTHH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 15:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357885AbiELTHF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 15:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE80C67D3D
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 12:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F2EF61BD9
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 19:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD14C34100;
        Thu, 12 May 2022 19:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652382422;
        bh=P5n+P8b0G/ki0nQK5307b2h+2RPOYbjlYRZlmFx5EzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BENJb1pe3BA8bYwxn7CqrD12JqmC6hs91GXA+CRFytt2KX4U4it6Ni67jovaDpEkB
         tv5a7YvJOqGFYrQkPChJmCJCKxrJl+U5XIoZYgEWwfxTGgqdcAPVVG0AmTR9aCkL72
         DnF7ueRIulU4Nnt/94IrY6Mai3ArdvVaapnXjJThWRCCN+KlE66sdglERz94u7reGy
         dYsa1VvYyDoAwvN+NlgLsmNTZmAC/X8+2ibvE2O2cyc2a3HzjFYkfhth93ruOKPudU
         nCftuzSgK15wLeTgYfIMBV6ilafEnZ55WfJkoGiPt5GB0D4xvrmoguOohky1xwUAeP
         rg/ITe3vP1wwA==
Date:   Thu, 12 May 2022 12:07:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 2/2] generic/603: use project quota create and restore
 common helpers
Message-ID: <20220512190702.GD27174@magnolia>
References: <20220512182203.2839593-1-zlang@kernel.org>
 <20220512182203.2839593-2-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512182203.2839593-2-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 13, 2022 at 02:22:03AM +0800, Zorro Lang wrote:
> As common/quota has _create_project_quota and _restore_project_quota
> helpers now, so replace local similar functions with them.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>

LGTM
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/603 | 36 ++----------------------------------
>  1 file changed, 2 insertions(+), 34 deletions(-)
> 
> diff --git a/tests/generic/603 b/tests/generic/603
> index b362a3d0..08ddcbf2 100755
> --- a/tests/generic/603
> +++ b/tests/generic/603
> @@ -13,7 +13,7 @@ _begin_fstest auto quick quota
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	restore_project
> +	_restore_project_quota
>  	cd /
>  	rm -f $tmp.*
>  }
> @@ -22,38 +22,6 @@ _cleanup()
>  . ./common/filter
>  . ./common/quota
>  
> -require_project()
> -{
> -	rm -f $tmp.projects $tmp.projid
> -	if [ -f /etc/projects ];then
> -		cat /etc/projects > $tmp.projects
> -	fi
> -	if [ -f /etc/projid ];then
> -		cat /etc/projid > $tmp.projid
> -	fi
> -
> -	cat >/etc/projects <<EOF
> -100:$SCRATCH_MNT/t
> -EOF
> -	cat >/etc/projid <<EOF
> -$qa_user:100
> -EOF
> -	PROJECT_CHANGED=1
> -}
> -
> -restore_project()
> -{
> -	if [ "$PROJECT_CHANGED" = "1" ];then
> -		rm -f /etc/projects /etc/projid
> -		if [ -f $tmp.projects ];then
> -			cat $tmp.projects > /etc/projects
> -		fi
> -		if [ -f $tmp.projid ];then
> -			cat $tmp.projid > /etc/projid
> -		fi
> -	fi
> -}
> -
>  init_files()
>  {
>  	local dir=$1
> @@ -157,7 +125,7 @@ BLOCK_SIZE=$(_get_file_block_size $SCRATCH_MNT)
>  rm -rf $SCRATCH_MNT/t
>  mkdir $SCRATCH_MNT/t
>  $XFS_IO_PROG -r -c "chproj 100" -c "chattr +P" $SCRATCH_MNT/t
> -require_project
> +_create_project_quota $SCRATCH_MNT/t 100 $qa_user
>  
>  echo "### Set up different grace timers to each type of quota"
>  UBGRACE=12
> -- 
> 2.31.1
> 
