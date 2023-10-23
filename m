Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E24EC004C0
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Oct 2023 15:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjJWPyw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Oct 2023 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjJWPyv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Oct 2023 11:54:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1361DBC
        for <fstests@vger.kernel.org>; Mon, 23 Oct 2023 08:54:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91522C433C8;
        Mon, 23 Oct 2023 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698076488;
        bh=CGrhAiiiF4rG7x7StVKAcZ6/SYCnVg2BWgsd5qEub3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUq3IJWdeOGiYzjIHW8P00Ud20txIMzO5DRuKUVmxazf7jU6LG2Yafqi8/CgnASTX
         OEswP0BxDUETPji9dHPG0d1x8HxgePZBEbjiYtdCuSH0FIdBlhm1y+MMnVmcJb9YUP
         TIdRJd42JmtbLMbIufEPiIRywvftUjI1alCxr3WUYz8b3Pl6cm8NxxEHpwEikbsYAP
         lxMm3nBUUHgxyypURnQut/Bzk5/NRY1e8UbkBs+f3dgiOK8ADKoTqp5YpIyjH2fzyf
         IJDvlvb87nLfN3q7lQnMObipUol1sxBpHjTzu5LLCxkKbK8gtMNCSA4kUERf76wj9/
         fstjNU8LzSEEg==
Date:   Mon, 23 Oct 2023 08:54:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/563: create the loop dev with the same block
 size as the scratch dev
Message-ID: <20231023155447.GG11391@frogsfrogsfrogs>
References: <20231022215529.2202150-1-tytso@mit.edu>
 <20231022215529.2202150-3-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022215529.2202150-3-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Oct 22, 2023 at 05:55:29PM -0400, Theodore Ts'o wrote:
> The generic/563 test creates the loop device using $SCRATCH_DEV
> directly.  We need to create the loop device with the same logical
> block size.  Otherwise, the loop device will always be created with
> the default logical block size of 512, and if its underlying backing
> store has a different logical block size, then mkfs may create a file
> system in the loop device that will fail to mount.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks fine to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc         | 10 ++++++++--
>  tests/generic/563 |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 8d7179567..01f065a9f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4246,9 +4246,15 @@ _require_userns()
>  
>  _create_loop_device()
>  {
> -	local file=$1 dev
> -	dev=`losetup -f --show $file` || _fail "Cannot assign $file to a loop device"
> +	local file=$1
> +	local blocksize=$2
> +	local dev
> +
> +	if [ -n "$blocksize" ]; then
> +		blocksize="-b $blocksize"
> +	fi
>  
> +	dev=`losetup -f $blocksize --show $file` || _fail "Cannot assign $file to a loop device"
>  	# Try to enable asynchronous directio mode on the loopback device so
>  	# that writeback started by a filesystem mounted on the loop device
>  	# won't be throttled by buffered writes to the lower filesystem.  This
> diff --git a/tests/generic/563 b/tests/generic/563
> index f98c6e42b..7e6bab49e 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -89,7 +89,7 @@ reset()
>  
>  # cgroup I/O accounting doesn't work on partitions. Use a loop device to rule
>  # that out.
> -LOOP_DEV=$(_create_loop_device $SCRATCH_DEV)
> +LOOP_DEV=$(_create_loop_device $SCRATCH_DEV $(blockdev --getss $SCRATCH_DEV))
>  smajor=$((0x`stat -L -c %t $LOOP_DEV`))
>  sminor=$((0x`stat -L -c %T $LOOP_DEV`))
>  
> -- 
> 2.31.0
> 
