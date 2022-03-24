Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A57BC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Mar 2022 15:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351227AbiCXPPB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Mar 2022 11:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243416AbiCXPO7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Mar 2022 11:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C854549688
        for <fstests@vger.kernel.org>; Thu, 24 Mar 2022 08:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7E90617A0
        for <fstests@vger.kernel.org>; Thu, 24 Mar 2022 15:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F38C340EC;
        Thu, 24 Mar 2022 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648134805;
        bh=7cqY1oUejD6yQEJPSvocVjsIEZ8iTiVh3q8dKb73/Jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSmRY5PFbJje1FTpgdbA2XaeVlIWMCKRuZ3zUeELG695PeolNfvatMmwVV6HNUjGd
         KN9fcWOCjkwP9jDc2v77rfnfepVGERi9muurQ+HmV4EscPAed9ehcasdRh2CuMu/tO
         zN8swmMrY04GUGbWPih5b8MQRfinrZgnqAKJqlomp4BCshzc1ZFXs0XZ8lqanTvGC4
         l7RyGife7KNx8EnMPsKFLLtvOw1N7Aycmc9aNIaIrFVwhPdKREbVdwMIy5Bzbg4s6b
         X27ScmgLQrYpiAj4M6a8evPyWLF0/RwuNaglxE8OzkjP5XeoGbKbp0GeefF4fzW9FP
         TO1pdyABSw/GQ==
Date:   Thu, 24 Mar 2022 08:13:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     fstests@vger.kernel.org, nitheshshetty@gmail.com,
        p.raghav@samsung.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        mcgrof@kernel.org, Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH] generic/108: use blockdev utility to calculate physical
 and logical block size
Message-ID: <20220324151324.GR8200@magnolia>
References: <CGME20220323181155epcas5p4892cb43ae57077d34f56baa848f152ce@epcas5p4.samsung.com>
 <20220323180643.29164-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323180643.29164-1-nj.shetty@samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 23, 2022 at 11:36:43PM +0530, Nitesh Shetty wrote:
> Reading sysfs to get physical and logical block fails,
> if SCRATCH_DEV is partitioned device.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
>  tests/generic/108 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/108 b/tests/generic/108
> index db0e9bd0..efe66ba5 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -42,8 +42,8 @@ _require_non_zoned_device $SCRATCH_DEV
>  lvname=lv_$seq
>  vgname=vg_$seq
>  
> -physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> -logical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/logical_block_size)
> +physical=`blockdev --getpbsz $SCRATCH_DEV`
> +logical=`blockdev --getss $SCRATCH_DEV`

LGTM
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  # _get_scsi_debug_dev returns a scsi debug device with 128M in size by default
>  SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 300`
> -- 
> 2.25.1
> 
