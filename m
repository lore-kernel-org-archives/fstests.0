Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435AFCDB465
	for <linux-fstests@archiver.kernel.org>; Mon, 16 Oct 2023 18:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJPSla (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 Oct 2023 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPSl3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Oct 2023 14:41:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ACFAC
        for <fstests@vger.kernel.org>; Mon, 16 Oct 2023 11:41:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7595FC433C8;
        Mon, 16 Oct 2023 18:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697481685;
        bh=SRyKwv6T+U/ECS932Om/SbQIzH/p5zsJ+ld57S0EmeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzXr/X8HwZtOCZG1droM4hZJxlRq9QWiRF1FiqkDzeIzl8Zym1u8H0x43E7iWLyRr
         JQaXMVn8zqDZVk+Ae/SdWZ8Zs/9ZDyq+w9A5+rMsPJWhsnnVXKf4G501j3BJ9J2oAE
         uzrazy/XbPFwvM7ESitjCl+OLv4RE5NoN2yM3xpRBCjHfsTX3Y8Gv78ztayR4pBS1b
         rSa2uXW/UFHMkI96jS+Dd5molcj2QRm5DAQ2Dsl5QGSh7cGI5+xVPATEyBONLwQDbp
         mlZsjM3NsNQeJx5BvsbgR9b1RhZ6OF5emC/pxXWacGUqtL6Ak0SfxHlfUYNJEAAdhf
         Ky4wmiYETTi7w==
Date:   Mon, 16 Oct 2023 11:41:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: add missing _require_scratch calls
Message-ID: <20231016184124.GB11391@frogsfrogsfrogs>
References: <20231016131103.966920-1-hch@lst.de>
 <20231016131103.966920-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016131103.966920-2-hch@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 16, 2023 at 03:11:03PM +0200, Christoph Hellwig wrote:
> Add _require_scratch to a bunch of test that were using $SCRATCH_DEV
> without that check.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/184 | 1 +
>  tests/xfs/192 | 1 +
>  tests/xfs/200 | 1 +
>  tests/xfs/204 | 1 +
>  tests/xfs/232 | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/tests/xfs/184 b/tests/xfs/184
> index 3bdd86ad..97f529f6 100755
> --- a/tests/xfs/184
> +++ b/tests/xfs/184
> @@ -19,6 +19,7 @@ _begin_fstest auto quick clone fiemap unshare
>  
>  # real QA test starts here
>  _supported_fs xfs
> +_require_scratch
>  _require_scratch_delalloc
>  _require_scratch_reflink

Oops.  That _require_scratch_delalloc could've gone beneath the
_require_scratch_reflink to take advantage of the _require_scratch call
in _require_scratch_reflink.

That said ... maybe _require_scratch_* calls should require the caller
to have _require_scratch'd beforehand?  And perhaps all
_require_scratch_* functions should complain if
${RESULT_DIR}/require_scratch doesn't already exist.

For this patch, though, everything looks fine:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


>  _require_cp_reflink
> diff --git a/tests/xfs/192 b/tests/xfs/192
> index eb577f15..ef7da55b 100755
> --- a/tests/xfs/192
> +++ b/tests/xfs/192
> @@ -19,6 +19,7 @@ _begin_fstest auto quick clone fiemap unshare
>  
>  # real QA test starts here
>  _supported_fs xfs
> +_require_scratch
>  _require_scratch_delalloc
>  _require_scratch_reflink
>  _require_cp_reflink
> diff --git a/tests/xfs/200 b/tests/xfs/200
> index b51b9a54..a9d6ce1b 100755
> --- a/tests/xfs/200
> +++ b/tests/xfs/200
> @@ -21,6 +21,7 @@ _begin_fstest auto quick clone fiemap unshare
>  
>  # real QA test starts here
>  _supported_fs xfs
> +_require_scratch
>  _require_scratch_delalloc
>  _require_scratch_reflink
>  _require_cp_reflink
> diff --git a/tests/xfs/204 b/tests/xfs/204
> index 7d6b79a8..7dacfa2d 100755
> --- a/tests/xfs/204
> +++ b/tests/xfs/204
> @@ -21,6 +21,7 @@ _begin_fstest auto quick clone fiemap unshare
>  
>  # real QA test starts here
>  _supported_fs xfs
> +_require_scratch
>  _require_scratch_delalloc
>  _require_scratch_reflink
>  _require_cp_reflink
> diff --git a/tests/xfs/232 b/tests/xfs/232
> index 59bbc436..0cb26fa1 100755
> --- a/tests/xfs/232
> +++ b/tests/xfs/232
> @@ -30,6 +30,7 @@ _cleanup()
>  
>  # real QA test starts here
>  _supported_fs xfs
> +_require_scratch
>  _require_scratch_delalloc
>  _require_xfs_io_command "cowextsize"
>  _require_scratch_reflink
> -- 
> 2.39.2
> 
