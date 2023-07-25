Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B13C001DE
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Jul 2023 15:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGYPdp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Jul 2023 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGYPdo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Jul 2023 11:33:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBF91BF8
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2023 08:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D920617AF
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2023 15:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957F3C433C8;
        Tue, 25 Jul 2023 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690299222;
        bh=pM1YF8kaQ1Xw/ACVR/xe2t2NVD8/bWDWRBmJi31bWsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvvSg9uFOyr8wnSmQrLJCLEqQMnWEq3r3ozyBtc8VQ0YgcUM4pZ4te+qvGq0ssezp
         YvEovLvP+tck0hHwmHn0G7xwGh5wYzUdpEJVOuFEfhk/GSFuV5fpKIMqBhUW7NDF0f
         M+n4N1yYSsTbTYbYxfxXhc6hrE56Y9S55uo77mZ8hUGALgPKccPz1xeubwBnoQ59Ob
         tk1GbuLVllGYr9xaF22cNtaoVcA7XGWA420T6FSkpTfN4flJ1Tkvi1USLTPqsLqHQr
         kP2zkGlrnaqAzaaWYdHXMgkyWgk+XseCcAPeo79gqrWo+pABfRUTEQZ4fAlrsyFHmJ
         hABzgeGFGNJGg==
Date:   Tue, 25 Jul 2023 08:33:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic: add a test for device removal without dirty
 data
Message-ID: <20230725153341.GE11340@frogsfrogsfrogs>
References: <20230724152927.33094-1-hch@lst.de>
 <20230724152927.33094-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724152927.33094-3-hch@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 24, 2023 at 08:29:27AM -0700, Christoph Hellwig wrote:
> Test the removal of the underlying device when the file system still
> does not have dirty data.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, yay functional testing :)
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/731     | 58 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/731.out |  2 ++
>  2 files changed, 60 insertions(+)
>  create mode 100755 tests/generic/731
>  create mode 100644 tests/generic/731.out
> 
> diff --git a/tests/generic/731 b/tests/generic/731
> new file mode 100755
> index 00000000..e1400d06
> --- /dev/null
> +++ b/tests/generic/731
> @@ -0,0 +1,58 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
> +# Copyright (c) 2023 Christoph Hellwig
> +#
> +# Test proper file system shut down when the block device is removed underneath
> +# and it has no dirty data.
> +#
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_cleanup()
> +{
> +	cd /
> +	$UMOUNT_PROG $SCSI_DEBUG_MNT >>$seqres.full 2>&1
> +	_put_scsi_debug_dev
> +	rm -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/scsi_debug
> +
> +# We don't actually use the test device, but we need a block based fs
> +_require_test
> +_require_block_device $TEST_DEV
> +_supported_fs generic
> +_require_scsi_debug
> +
> +SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 256`
> +test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
> +echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
> +
> +run_check _mkfs_dev $SCSI_DEBUG_DEV
> +
> +SCSI_DEBUG_MNT="$TEST_DIR/scsi_debug_$seq"
> +rm -rf $SCSI_DEBUG_MNT
> +mkdir $SCSI_DEBUG_MNT
> +run_check _mount $SCSI_DEBUG_DEV $SCSI_DEBUG_MNT
> +
> +# create a test file
> +$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" $SCSI_DEBUG_MNT/testfile >>$seqres.full
> +
> +# open a file descriptor for reading the file
> +exec 3< $SCSI_DEBUG_MNT/testfile
> +
> +# drop all caches and delete the scsi debug device
> +echo 3 > /proc/sys/vm/drop_caches
> +echo 1 > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/delete
> +
> +# try to read from the file, which should give us -EIO
> +cat <&3 > /dev/null
> +
> +# close the file descriptor to not block unmount
> +exec 3<&-
> +
> +status=0
> +exit
> diff --git a/tests/generic/731.out b/tests/generic/731.out
> new file mode 100644
> index 00000000..102c0522
> --- /dev/null
> +++ b/tests/generic/731.out
> @@ -0,0 +1,2 @@
> +QA output created by 731
> +cat: -: Input/output error
> -- 
> 2.39.2
> 
