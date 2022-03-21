Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C6DC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Mar 2022 20:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351651AbiCUUYL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353363AbiCUUXC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Mar 2022 16:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D40DBD36
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 13:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 808156116C
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 20:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D873FC340E8;
        Mon, 21 Mar 2022 20:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647894093;
        bh=uTFGItyroxvOa054l9iD6e7+BCQL/zHHCypA19UKfZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDqEEwyKevliAX77Fd7RtqjvTKf31ygKW5/Z2AZpdOiCmGiulwH+P05sGWk73i+ZY
         mMOWWtqCA56uIGurSoeH8chOtCOWVPZ2OJRWEJ5fv9JwxkUmDdhJR4Uk6DdPLvKYDw
         eop2Oi18XNLLJXYh9ZEE/UVXilOz/S9r0HDm6MfCOFjX7EgmTEEFOAXGRF8xXVrykU
         6rHw2ZjEqgOV8WP0k7w+EknFlIDHAC4mjwrNs+iV4MSzsc4StYxOyl/DZi15/CSniu
         NxFcZVO9FzIxtMXFaeLXWtuJWXKeiRPUfjFoX1fT48sLa0JuGz8/JRV9PTmBCVFjJu
         oS4uyao2L4Uzg==
Date:   Mon, 21 Mar 2022 13:21:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     fstests@vger.kernel.org, nitheshshetty@gmail.com,
        p.raghav@samsung.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        mcgrof@kernel.org
Subject: Re: [PATCH] generic/108: use sysfs values for logical,physical block
 size in scsi_debug
Message-ID: <20220321202133.GJ8200@magnolia>
References: <CGME20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd@epcas5p3.samsung.com>
 <20220301212947.28660-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301212947.28660-1-nj.shetty@samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 02, 2022 at 02:59:47AM +0530, Nitesh Shetty wrote:
> scsi_debug device used for test, is created with assumption of 512 bytes
> logical and physical block size.
> This causes error in lvcreate step, when SCRATCH_DEV device lba is not
> 512 bytes. This can be solved by reading block size from sysfs of device.
> If sysfs is missing fallback to 512 bytes as default.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  tests/generic/108 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/108 b/tests/generic/108
> index ad43269f..db0e9bd0 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -42,8 +42,11 @@ _require_non_zoned_device $SCRATCH_DEV
>  lvname=lv_$seq
>  vgname=vg_$seq
>  
> +physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> +logical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/logical_block_size)

This causes a regression if $SCRATCH_DEV is not a raw block device:

# SCRATCH_DEV=/dev/sda4 ./check generic/108
...
--- generic/108.out
+++ generic/108.out.bad
@@ -1,2 +1,4 @@
 QA output created by 108
+cat: /sys/block/sda4/queue/physical_block_size: No such file or directory
+cat: /sys/block/sda4/queue/logical_block_size: No such file or directory
 fsync: Input/output error

--D

> +
>  # _get_scsi_debug_dev returns a scsi debug device with 128M in size by default
> -SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 300`
> +SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 300`
>  test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
>  echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
>  
> 
> base-commit: 2ea74ba4e70b546279896e2a733c8c7f4b206193
> -- 
> 2.25.1
> 
