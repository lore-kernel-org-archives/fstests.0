Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B79BC2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9BE61401
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhEYQGi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230422AbhEYQGh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 May 2021 12:06:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A37AC61400;
        Tue, 25 May 2021 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621958707;
        bh=fr4/BQnwum0PGcTBPxeqCHhlYiqm5Yyy2QM88S32yM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMZoZALivYtN0pyh00mrAVkASXL039CmQZTD7jvXval4KhEsK2E5YkxNOdbd0CZcd
         /L2Z/UgB4EIaOTsnvGJw8lVaMr+EDXaAK6HEoy5h2z+CXWu9q4aJmuEodded/o5Zhs
         /JsH6WMo5ZpYXhGX7vM5bEV3FJvOYZTN0zg/34NeYCA3hM3Su/0fHBNcG7p961Yb07
         wLBY0fc5VYpySHHOAHZn5KylpwFHqfcDJXvDH8vOvffe+0kfEQvzNb9yqm/YcU+6k8
         SsJaY5K37KBuJDvV+OK4lsXMCQppTfUn8hCPrCzhVKyzN9oI0Hm1f5O4OuWrCpFDdv
         c0+GqEZNVMFog==
Date:   Tue, 25 May 2021 09:05:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/config: remove default 4k blocksize from
 XFS_MKFS_OPTIONS
Message-ID: <20210525160507.GA202095@locust>
References: <20210525044642.552682-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525044642.552682-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 12:46:41PM +0800, Zorro Lang wrote:
> xfstests set "-bsize=4k" to XFS_MKFS_OPTIONS by default, then give
> it to MKFS_OPTIOPNS. So MKFS_OPTIOPNS always contains "-bsize=4k"
> except we set XFS_MKFS_OPTIONS manually.
> 
> It's useless to set XFS_MKFS_OPTIONS to "-bsize=4096" by default,
> especially that will cause all cases with _scratch_mkfs_blocksized()
> always fail as "-b size option respecified", when test on XFS. For
> exmaple: generic/222
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

/me wonders what the historical context is (a) for having an
$FSTYP-specific MKFS_OPTIONS variable, and (b) for setting bsize=4096
here.  All I can say is that I've tripped over this numerous times and
wouldn't really mind if it went away. :P

Acked-by: Darrick J. Wong <djwong@kernel.org>

(acked in the sense that I'm not /opposed/ but really really wants to
know the historical reasons)

--D

> ---
>  common/config | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index a47e462c..ecd59fae 100644
> --- a/common/config
> +++ b/common/config
> @@ -60,7 +60,6 @@ export EMAIL=root@localhost    # where auto-qa will send its status messages
>  export HOST_OPTIONS=${HOST_OPTIONS:=local.config}
>  export CHECK_OPTIONS=${CHECK_OPTIONS:="-g auto"}
>  export BENCH_PASSES=${BENCH_PASSES:=5}
> -export XFS_MKFS_OPTIONS=${XFS_MKFS_OPTIONS:=-bsize=4096}
>  export TIME_FACTOR=${TIME_FACTOR:=1}
>  export LOAD_FACTOR=${LOAD_FACTOR:=1}
>  export DEBUGFS_MNT=${DEBUGFS_MNT:="/sys/kernel/debug"}
> -- 
> 2.31.1
> 
