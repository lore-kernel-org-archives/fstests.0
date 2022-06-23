Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AD6C43334
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Jun 2022 18:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiFWSy7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Jun 2022 14:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiFWSy3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Jun 2022 14:54:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874BF1005D6
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 11:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72E34B824DE
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 18:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4BDC341C4;
        Thu, 23 Jun 2022 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656007217;
        bh=opozK4knM1BrYFP7FCWkGCVSKd2vMcJE+a7uC0MzDvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHoryF/RHUu63+3pVuhLud2qogcloONil5RB9S9km2i6pik07lUo7na0hAyzrwQfS
         /tAqtONRLRcLK40MKisevcviKSH0vI2pRtlfl2ySSlIdelk5ZfoF5eijDPH8/AyeZw
         66wa8eL8/tClVByq86fIQLOTRM6VaGtl4XVQpDVDZNSZDQxjyTkA7+GOTYpu9famNc
         ekbgUQT/RfjDQITQ69CZ2ZR/ruF7qAtHBM7ATHJp56lgytmMgsoWFqZrVw8lUE0fGV
         p55LrNRuitK4gYk3WhjCNTCH1IWX0FhS9s3TAF2tjQqoBs6kVps97YPb0quLEJS/gO
         uwo8SMdQxFpKQ==
Date:   Thu, 23 Jun 2022 11:00:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] fstests: add missing _require_freeze() to tests
Message-ID: <YrSqMByKUgHQllwN@magnolia>
References: <20220619134657.1846292-1-amir73il@gmail.com>
 <20220619134657.1846292-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619134657.1846292-2-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jun 19, 2022 at 04:46:54PM +0300, Amir Goldstein wrote:
> And add a few tests that use freeze to the freeze group
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  tests/xfs/119 | 1 +
>  tests/xfs/318 | 3 ++-
>  tests/xfs/325 | 3 ++-
>  tests/xfs/422 | 3 ++-
>  tests/xfs/438 | 2 +-
>  tests/xfs/517 | 1 +
>  6 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/119 b/tests/xfs/119
> index a1180371..b6f96601 100755
> --- a/tests/xfs/119
> +++ b/tests/xfs/119
> @@ -20,6 +20,7 @@ _begin_fstest log v2log auto freeze
>  _supported_fs xfs
>  
>  _require_scratch
> +_require_freeze
>  
>  # this may hang
>  sync
> diff --git a/tests/xfs/318 b/tests/xfs/318
> index 38c7aa60..be93f9ab 100755
> --- a/tests/xfs/318
> +++ b/tests/xfs/318
> @@ -7,7 +7,7 @@
>  # Simulate free extent errors with a file write and a file remove.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw
> +_begin_fstest auto quick rw freeze

Not sure why these tests (318, 325, 422, 438) are being added to the
freeze group -- they use freeze to force xfs to do background tasks
(inodegc, initializing quota, etc), but they are not themselves
functionality testing for filesystem freezing.

The _require_freeze additions look fine though.

--D

>  
>  # Override the default cleanup function.
>  _cleanup()
> @@ -26,6 +26,7 @@ _supported_fs xfs
>  _require_scratch
>  _require_error_injection
>  _require_xfs_io_error_injection "rmap_finish_one"
> +_require_freeze
>  
>  blksz=65536
>  blks=64
> diff --git a/tests/xfs/325 b/tests/xfs/325
> index 5b26b2b3..c6861fbc 100755
> --- a/tests/xfs/325
> +++ b/tests/xfs/325
> @@ -8,7 +8,7 @@
>  # Inject an error during extent freeing to test log recovery.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone freeze
>  
>  # Override the default cleanup function.
>  _cleanup()
> @@ -29,6 +29,7 @@ _require_cp_reflink
>  _require_scratch_reflink
>  _require_error_injection
>  _require_xfs_io_error_injection "free_extent"
> +_require_freeze
>  
>  blksz=65536
>  blks=30
> diff --git a/tests/xfs/422 b/tests/xfs/422
> index 175253aa..a83a66df 100755
> --- a/tests/xfs/422
> +++ b/tests/xfs/422
> @@ -9,7 +9,7 @@
>  # activity, so we can't have userspace wandering in and thawing it.
>  #
>  . ./common/preamble
> -_begin_fstest dangerous_scrub dangerous_online_repair
> +_begin_fstest dangerous_scrub dangerous_online_repair freeze
>  
>  _register_cleanup "_cleanup" BUS
>  
> @@ -24,6 +24,7 @@ _require_xfs_scratch_rmapbt
>  _require_xfs_io_command "scrub"
>  _require_xfs_io_error_injection "force_repair"
>  _require_command "$KILLALL_PROG" killall
> +_require_freeze
>  
>  echo "Format and populate"
>  _scratch_mkfs > "$seqres.full" 2>&1
> diff --git a/tests/xfs/438 b/tests/xfs/438
> index c3008b1c..cfe75bd8 100755
> --- a/tests/xfs/438
> +++ b/tests/xfs/438
> @@ -21,7 +21,7 @@
>  # Fixed by upstream commit 373b058 ("xfs: Properly retry failed dquot
>  # items in case of error during buffer writeback")
>  . ./common/preamble
> -_begin_fstest auto quick quota
> +_begin_fstest auto quick quota freeze
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/517 b/tests/xfs/517
> index 88c4f43b..f7f9a8a2 100755
> --- a/tests/xfs/517
> +++ b/tests/xfs/517
> @@ -29,6 +29,7 @@ _supported_fs xfs
>  _require_xfs_scratch_rmapbt
>  _require_xfs_io_command "fsmap"
>  _require_command "$KILLALL_PROG" killall
> +_require_freeze
>  
>  echo "Format and populate"
>  _scratch_mkfs > "$seqres.full" 2>&1
> -- 
> 2.25.1
> 
