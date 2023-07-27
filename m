Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9790BC0015E
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Jul 2023 19:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjG0TSd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Jul 2023 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjG0TSc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Jul 2023 15:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DD72D4F
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2023 12:18:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B26F561F1F
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2023 19:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAF4C433C7;
        Thu, 27 Jul 2023 19:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690485505;
        bh=F4/8l+NlT0rDqvH9yfvERb9bd2NTHxx0FfiuZVCY5dM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZASjZx0DeZ/emKEyklHGhj9sQned2bSRJTvBiyX8EL3MXSCo1J3oMMjlvKJ4MSyD
         m03b+sK6dem9ScsNNIhsR0udwOnTcdA+q1i3SPcuIeHfbK1hXryJgIc+TtxnpTiYs/
         qfb0WdbjKcYMoUgnWB063l0/0ACG8Enj76pmcpNpNOVM7tmYpc7A7mlteVxPSag/uZ
         Z0L0RMFUltwhIGtuGlOw9BYD4PXim5kf4aaBCWyQBGznsEjm0XwnEgrUxZIjnsO8Qy
         ITrdAozCv8cc1Ag0yIud50X1QPNuYTZfg6asU+YSxdMmIFe1DrYBKko+r61Uy+gJFr
         0npdVnyXyR0Tg==
Date:   Thu, 27 Jul 2023 12:18:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: install soak_duration.awk
Message-ID: <20230727191824.GF11377@frogsfrogsfrogs>
References: <20230727190512.357064-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727190512.357064-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 27, 2023 at 03:05:12PM -0400, Theodore Ts'o wrote:
> Commit 3e85dd4fe423 ("misc: add duration for long soak tests") added a
> helper executable, soak_duration.awk, is which used by the check
> script if SOAK_DURATION is set.  This script translates a
> "human-firendly" time duration specifier, such as 4m or 2d into an
> integer number of seconds.  We need to make sure that this script is
> installed or the checks script will bomb out of SOAK_DURATION is set
> (and the fstests installation doesn't include a full set of fstests
> source, but just those files installed by "make install").
> 
> Fixes: 3e85dd4fe423 ("misc: add duration for long soak tests")
> Cc: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Oooooops,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  src/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/Makefile b/src/Makefile
> index 24cd47479..aff871d04 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -36,7 +36,8 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	uuid_ioctl
>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
> -	      btrfs_crc32c_forged_name.py popdir.pl popattr.py
> +	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> +	      soak_duration.awk
>  
>  SUBDIRS = log-writes perf
>  
> -- 
> 2.31.0
> 
