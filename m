Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB4EC2B9F4
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 15:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CDD06199B
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 15:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhF1Pqn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Jun 2021 11:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235882AbhF1PqI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 28 Jun 2021 11:46:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AA0B61465;
        Mon, 28 Jun 2021 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624895022;
        bh=Ki5dU/9ixjqTaLiPX9cLcHvh79VaWT5CMfCzqE+9tNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r96Uu11on9l73SdDR5a/xxjkImdC9mIGlYlL2amejSmFKpAcRAJNvsSPfG+5gAaSx
         m3mLHTCdZop3odDf95CQ4jx4I/lZWOWqVtKlD/jjTdMEwl7QtT8nvjfXAHED6Tahng
         GKnn7aapY12Rc5vtEPMURrQOo4Ao6rzEBsAF8FjQDEv9kaI/uqJaaU6c1oHTgNbBlM
         EX9j55tLpAWspiqGUa1AHduHazGH0xTFVP1CTBBBYRyubv4BKvNsS4+nTqoC6kEpm2
         QHry3AcERHSY9OcyaPRPiPJa538wvKXJV9chAsYJeXdOGJqeaJ8zB/zYCx3abHbfjQ
         3LAjm20Ux/2kQ==
Date:   Mon, 28 Jun 2021 08:43:42 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs/504: Add scratch_mount before checking for
 xfs_scrub unicode support.
Message-ID: <20210628154342.GC13767@locust>
References: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
 <20210628085259.120666-2-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628085259.120666-2-anju@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 28, 2021 at 02:22:57PM +0530, Anju T Sudhakar wrote:
> We may not detect the error `Inappropriate ioctl for device`, while running
> `$XFS_IO_PROG -c "scrub probe" "$mountpoint"`, if scratch device is not
> mounted before invoking _check_xfs_scrub_does_unicode(). So do
> _scratch_mount before checking for xfs_scrub support.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Oops, heh, good catch!

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/504 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/xfs/504 b/tests/xfs/504
> index 40318314..291ee4e4 100755
> --- a/tests/xfs/504
> +++ b/tests/xfs/504
> @@ -21,8 +21,11 @@ _require_xfs_io_command 'label'
>  
>  echo "Silence is golden."
>  
> +_scratch_mkfs > /dev/null
> +_scratch_mount
>  want_scrub=
>  _check_xfs_scrub_does_unicode "$SCRATCH_MNT" "$SCRATCH_DEV" && want_scrub=yes
> +_scratch_unmount
>  
>  filter_scrub() {
>  	grep 'Unicode' | sed -e 's/^.*Duplicate/Duplicate/g'
> -- 
> 2.31.1
> 
