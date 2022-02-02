Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACC5C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Feb 2022 17:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiBBRqw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Feb 2022 12:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiBBRqw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Feb 2022 12:46:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7264AC061714
        for <fstests@vger.kernel.org>; Wed,  2 Feb 2022 09:46:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11B1C6182A
        for <fstests@vger.kernel.org>; Wed,  2 Feb 2022 17:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60104C004E1;
        Wed,  2 Feb 2022 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643824011;
        bh=bKZs2w26YmdyDrpJab5outALP8dHu6jN9xz91DUbqco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZXsbiL0Z7uqzt1pxCX+Zld6WqtHMfzmbyo+8f0n3qOph2Sc+bRwQVCJzpcrMswOV
         bAVUiuWJSaPz2D+W2Etpq4vfH3VtM2gBgDNRUEgsb8ZTylxCgwMDRztEuse5ZYLCyy
         EO+IA84cTxz1E2YRxcerr+wRCHFIL/h0rPtj8+rs0jq12zlEnF5KpjqTYAynP6nZKC
         +G/3EKG8DAJnAHFk23i+qMq1kjK2igNtupLBzO/jhanDlo5ADXjlNSNVew4BgvPCJ5
         FsAB6HS3uXR5giC57TjA61dI1hMN/Ioorcil0PlR3qOE3FKvsXkSR6dbgE2Ui081CW
         by+AQa/Rf/rzA==
Date:   Wed, 2 Feb 2022 09:46:50 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstest: add more tests to the metadump group
Message-ID: <20220202174650.GB8288@magnolia>
References: <20220202073831.854055-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202073831.854055-1-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 02, 2022 at 06:38:31PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Because they use metadump and I want to test metadump more easily.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

LGTM,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/129 | 2 +-
>  tests/xfs/234 | 2 +-
>  tests/xfs/253 | 2 +-
>  tests/xfs/284 | 2 +-
>  tests/xfs/291 | 2 +-
>  tests/xfs/336 | 2 +-
>  tests/xfs/432 | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/xfs/129 b/tests/xfs/129
> index df977552..90887d54 100755
> --- a/tests/xfs/129
> +++ b/tests/xfs/129
> @@ -9,7 +9,7 @@
>  # said block.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone metadump
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/234 b/tests/xfs/234
> index a61681ab..6ff2f228 100755
> --- a/tests/xfs/234
> +++ b/tests/xfs/234
> @@ -9,7 +9,7 @@
>  # said block.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rmap punch
> +_begin_fstest auto quick rmap punch metadump
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/253 b/tests/xfs/253
> index a96a2c17..1899ce52 100755
> --- a/tests/xfs/253
> +++ b/tests/xfs/253
> @@ -18,7 +18,7 @@
>  # that is already in use (and no other name is available to use).
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick metadump
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/284 b/tests/xfs/284
> index 9d75bcec..fa7bfdd0 100755
> --- a/tests/xfs/284
> +++ b/tests/xfs/284
> @@ -8,7 +8,7 @@
>  # on mounted XFS to make sure they refuse to proceed.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick dump copy db mkfs repair
> +_begin_fstest auto quick dump copy db mkfs repair metadump
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/291 b/tests/xfs/291
> index bbc6f2b9..6d5e247e 100755
> --- a/tests/xfs/291
> +++ b/tests/xfs/291
> @@ -7,7 +7,7 @@
>  # Test xfs_repair on fragmented multi-block dir2 fs
>  #
>  . ./common/preamble
> -_begin_fstest auto repair
> +_begin_fstest auto repair metadump
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/336 b/tests/xfs/336
> index 279830b5..6592419d 100755
> --- a/tests/xfs/336
> +++ b/tests/xfs/336
> @@ -7,7 +7,7 @@
>  # Exercise metadump on realtime rmapbt preservation.
>  #
>  . ./common/preamble
> -_begin_fstest auto rmap realtime
> +_begin_fstest auto rmap realtime metadump
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/432 b/tests/xfs/432
> index 40cb2474..86012f0b 100755
> --- a/tests/xfs/432
> +++ b/tests/xfs/432
> @@ -14,7 +14,7 @@
>  # threshold to 2^21 blocks, make sure we never do that again.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick dir metadata
> +_begin_fstest auto quick dir metadata metadump
>  
>  # Override the default cleanup function.
>  _cleanup()
> -- 
> 2.33.0
> 
