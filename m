Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5171AC433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 17 May 2021 15:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 363E160E0B
	for <linux-fstests@archiver.kernel.org>; Mon, 17 May 2021 15:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbhEQP63 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 May 2021 11:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343777AbhEQPwO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 17 May 2021 11:52:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03A2361057;
        Mon, 17 May 2021 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621266633;
        bh=8sukzHm0LQCcOjqJzEp2hks4dd6QqJk0CBcnQrZy7Ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGeOtPJHRbowYNoQ4qocjOOfcZ7gZGu3s9bDNJPcVUFb1Iy0NOPYG5QPpx1OtYSVe
         iCR+/c0raNHDfS8UtpKX/Gv96rIqbV0YaCXuh3yH2yyaAfCwWGGiVXBquMSiLGbBQY
         zjkt9wgCL8ndIuy/Sq0po7nc9YjyzzOnv25bG1iurHFwzOYSNZgUDCMeHjLcCsjUCJ
         WeMIQClOUk7QedPJYWpuJIMxATd7e7Na8SBz2/8KTnvt6vgidEH5T1KQtJPp2XEI8q
         kwaxMmfZfmEGc2BtebaOEGjVuyOu1lKT+vWSSAsAnPePaYMVpE7l1WFlwu0e4/r6Qb
         YPI1E1azmh3yg==
Date:   Mon, 17 May 2021 08:50:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: Add the appropriate _require helper
Message-ID: <20210517155032.GB9648@magnolia>
References: <1621222453-2824-1-git-send-email-huangjh.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621222453-2824-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 17, 2021 at 11:34:13AM +0800, Jinhui Huang wrote:
> 1.xfs/162 uses xfs_db -c 'fuzz' but forgets to check if the feature
> is supported. This will cause the case to fail on a system without
> fuzz support. so we add _require to check if the fuzz is supported.
> 
> 2.xfs/495 use _require_scratch_xfs_fuzz_fields to check the features
> required by field fuzzing, but some of the features are not used in
> this case like xfs_scrub, this will cause the case to skip on a system
> without xfs_scrub support, even if the features being uesd are supported.
> So we just need to use _require to check the features being used.
> 
> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>

These targeted fixes ought to be in separate patches, but otherwise they
look correct.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/162 | 2 ++
>  tests/xfs/495 | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/162 b/tests/xfs/162
> index e3257a3..c7c72d1 100755
> --- a/tests/xfs/162
> +++ b/tests/xfs/162
> @@ -31,6 +31,8 @@ _cleanup()
>  # real QA test starts here
>  _supported_fs xfs
>  _require_scratch_nocheck
> +_require_populate_commands
> +_require_xfs_db_command "fuzz"
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/xfs/495 b/tests/xfs/495
> index 6292b5e..a3b4fb2 100755
> --- a/tests/xfs/495
> +++ b/tests/xfs/495
> @@ -32,7 +32,9 @@ _cleanup()
>  
>  # real QA test starts here
>  _supported_fs xfs
> -_require_scratch_xfs_fuzz_fields
> +_require_scratch_nocheck
> +_require_populate_commands
> +_require_xfs_db_command "fuzz"
>  
>  echo "Format and populate"
>  _scratch_populate_cached nofill > $seqres.full 2>&1
> -- 
> 1.8.3.1
> 
