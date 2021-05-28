Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D7CC2B9F7
	for <linux-fstests@archiver.kernel.org>; Fri, 28 May 2021 16:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFE3613EB
	for <linux-fstests@archiver.kernel.org>; Fri, 28 May 2021 16:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbhE1QcJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 May 2021 12:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233887AbhE1QcI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 May 2021 12:32:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81D1461184;
        Fri, 28 May 2021 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622219433;
        bh=sezbhvXf3gFMILzwXrB06J9ciFxeJgBrvnrrm9ZM8jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7jfbusGwDM2vz786BAMU6hPYy80tSpQ75hnWWaCdF+qzX4S8QkLmxd0bvE588SOF
         pwVfhdVYP9sebYvxpjWjHWX3HGFyH2j+P8rKqFftkXqmNxQVbiky6k7lDyzwMk3vG3
         oVb2WWmxQXXf6s9IB+Iz2zIr+KLrpJSvJYcpHK6Aio9UU9DhIxhSIHl8AIqEsqAO2o
         gtRlO1NhvLczYjcjnI4PnArBBBB3enk/IAV/I9yjElJnnvSkD49PodvNJxuMMwHwDd
         2EcdMSWj3tz4LPjouVlWA/jcssf2wrVrjeNy0dHF6FFhD+wllFOno+I8ZXwEhKmR1z
         SHQfi1vjxA5tQ==
Date:   Fri, 28 May 2021 09:30:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH] xfs: fix check of whether the mkfs fail
Message-ID: <20210528163033.GO202144@locust>
References: <20210528094046.1920724-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528094046.1920724-1-sunke32@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 28, 2021 at 05:40:46AM -0400, Sun Ke wrote:
> The return value ("$?") is always the status of the last command in the pipe.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Heh, whooops.  Thanks for fixing this!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/070 | 3 ++-
>  tests/xfs/448 | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/070 b/tests/xfs/070
> index 8249c5c01cfd..9ef1e786a0a5 100755
> --- a/tests/xfs/070
> +++ b/tests/xfs/070
> @@ -84,7 +84,8 @@ _supported_fs xfs
>  _require_scratch_nocheck
>  _require_command "$KILLALL_PROG" killall
>  
> -_scratch_mkfs | _filter_mkfs > /dev/null 2> $tmp.mkfs || _fail "mkfs failed"
> +_scratch_mkfs | _filter_mkfs > /dev/null 2> $tmp.mkfs
> +test "${PIPESTATUS[0]}" -eq 0 || _fail "mkfs failed"
>  
>  . $tmp.mkfs # import agcount
>  
> diff --git a/tests/xfs/448 b/tests/xfs/448
> index 493d303e62cf..a11698fa2d8c 100755
> --- a/tests/xfs/448
> +++ b/tests/xfs/448
> @@ -47,7 +47,8 @@ _require_no_xfs_bug_on_assert
>  rm -f "$seqres.full"
>  
>  # Format and mount
> -_scratch_mkfs | _filter_mkfs > $seqres.full 2> $tmp.mkfs || _fail "mkfs failed"
> +_scratch_mkfs | _filter_mkfs > $seqres.full 2> $tmp.mkfs
> +test "${PIPESTATUS[0]}" -eq 0 || _fail "mkfs failed"
>  _scratch_mount
>  
>  # Get directory block size
> -- 
> 2.25.4
> 
