Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0722FC43334
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 17:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355954AbiFARmw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 13:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352351AbiFARmv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 13:42:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BE159BB9
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 10:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B743B81BBB
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102E3C385A5;
        Wed,  1 Jun 2022 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654105368;
        bh=XcTmFfGECSGSARfGTgUuLfLLszN1Z1/S0iz90zDFlHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHaPfwbNyQr7Xn+jshWQHLOp6wa1iD+bZtpUxrt8MK+SCDv89L18u50M60oD8od90
         DfZLO0GTFTB+ZTbjLM65qSRTjTwiu4VMIuSlnHWnxQNF3L5WHOJvpprEX9kP01b8Ez
         5eahSeV/+erqsgHDJmyg/ZbzA/n34huAnt4O46yUsPAAzGYNg2W5F3FJVQuH+FkxJ+
         Mfgm20LMyFYGuwPuSRsShvs9aYtVcTLQBmznUfBKbNPc9Eon/O/+3D18Egag+nsbvw
         dd4YpdHnjauKK1iS5cPYS9fxTJocFjECW28cdJ486a2xbYlKhFlkzpz1x5LyNcFfpT
         mShwWUsVmZVeA==
Date:   Wed, 1 Jun 2022 10:42:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 5/5] gitignore: ignore missed binary files in src
Message-ID: <YpelF6kKlbxd6K7i@magnolia>
References: <20220601063730.1726879-1-zlang@kernel.org>
 <20220601063730.1726879-6-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601063730.1726879-6-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 01, 2022 at 02:37:30PM +0800, Zorro Lang wrote:
> Add  src/dmiperf and src/t_locks_execve into .gitignore file
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  .gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 88c79412..24bde45c 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -77,6 +77,7 @@ tags
>  /src/dirhash_collide
>  /src/dirperf
>  /src/dirstress
> +/src/dmiperf

Removed in commit c13150fe ("src/dmiperf: Remove obsolete dmiperf")

>  /src/e4compact
>  /src/ext4_resize
>  /src/fault
> @@ -146,6 +147,7 @@ tags
>  /src/t_getcwd
>  /src/t_holes
>  /src/t_immutable
> +/src/t_locks_execve

Removed in commit fd2366c6 ("fstests: remove generic/484")

--D

>  /src/t_mmap_collision
>  /src/t_mmap_cow_race
>  /src/t_mmap_dio
> -- 
> 2.31.1
> 
