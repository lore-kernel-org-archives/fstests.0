Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330C4C04A68
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Jul 2022 03:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiG1Dyp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Jul 2022 23:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiG1Dyo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jul 2022 23:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C516275C2
        for <fstests@vger.kernel.org>; Wed, 27 Jul 2022 20:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 288B1619DA
        for <fstests@vger.kernel.org>; Thu, 28 Jul 2022 03:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FB9C433D7;
        Thu, 28 Jul 2022 03:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658980482;
        bh=HvxrAxT3aupU1l0x5tusTc81evXIaOng+HJ2km0s22k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIKD8bw0eACgRSzjq8yrTjAq1E51J65atJDZbOD88BU0GuwcHkYJJKFtcCWWBo+RI
         2bjdF83WXPJADJ8hBDt/mtWZUCvnJi4hqwc6gFEoBd6v7NEkOzjN/cQOIDlkLl4YWb
         ECGP0V7AfmtFHHB7tRMFpx7wz1yhrBDBXK//iaP+i/DfrY93uOrtEgytkxY0V3IIwb
         Z5UWk+On2IzzD1g7IanCxBH30mJba2wb605s39HhWRjHMrEjAL03Io4Fc242WHkbXv
         Fau+GQ/IL3IMlaffEH0zpAgpSOmTeUkzDGDhqFspD7HsvMNWBi8RHc7u9DUkOmMOvL
         /xwpqS0D9BO7g==
Date:   Wed, 27 Jul 2022 20:54:42 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/191: Add missing xfsprogs commit
Message-ID: <YuIIggUZXat6Lp2F@magnolia>
References: <1658982991-3860-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658982991-3860-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 28, 2022 at 12:36:31PM +0800, Yang Xu wrote:
> xfs_repair also needs to think empty xattr leaf block isn't corruption, so
> case can pass.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Yep, thanks.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/191 | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/191 b/tests/xfs/191
> index c568f90e..a10077fe 100755
> --- a/tests/xfs/191
> +++ b/tests/xfs/191
> @@ -11,9 +11,11 @@
>  # operations don't stumble over them, and that xfs_repair will offer to remove
>  # the entire xattr fork if the root xattr leaf block is empty.
>  #
> -# Regression test for kernel commit:
> -#
> +# Regression test for
> +# kernel commit:
>  # 7be3bd8856fb ("xfs: empty xattr leaf header blocks are not corruption")
> +# xfsprogs commit:
> +# f50d3462c654 ("xfs_repair: ignore empty xattr leaf blocks")
>  #
>  . ./common/preamble
>  _begin_fstest auto quick attr
> @@ -28,6 +30,7 @@ _supported_fs xfs
>  _require_scratch
>  _require_scratch_xfs_crc # V4 is deprecated
>  _fixed_by_kernel_commit 7be3bd8856fb "xfs: empty xattr leaf header blocks are not corruption"
> +_fixed_by_git_commit xfsprogs f50d3462c654 "xfs_repair: ignore empty xattr leaf blocks"
>  
>  _scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
>  cat $tmp.mkfs >> $seqres.full
> -- 
> 2.23.0
> 
