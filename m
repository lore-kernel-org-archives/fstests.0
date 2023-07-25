Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962C0C001DE
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Jul 2023 15:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjGYPdL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Jul 2023 11:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGYPdL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Jul 2023 11:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32639E4
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2023 08:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCE7B6172B
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2023 15:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D176C433C8;
        Tue, 25 Jul 2023 15:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690299189;
        bh=kQsJCT+XRrgpmjisM2QEG2GvydqI9iHfLFBmHzV/5UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1NxIByKeh6fLCBdmxzzK8izs/JFXqO3pufb4FoGpwVOhAK7nw8Mt63CGQeiIKLOO
         kFD290oo+O3AxRZcg6p/x9Jyqle2whdIlM+4oHTum8V7KixHTIiRnvb0mXVgp99AQC
         4pyGiqjZb2BxsqC9bvQ9v2sqx/jPAF2i1ncIKlaJCs9hweNOWbzJ9cH1Yqv+nEoZ9k
         tPH7RYe5tZCWhnIIWQgcJXrgI7UTMMvKFU4suZTouRPeYOi5fLgUfZabZqtFuqC/x1
         PgsThne8cLg65ywgVjAju9hMKdd7lJ3l8Qr8vLIxtwrUF9W6562WcSvH8HC9URaP7C
         03x3WgyMlfeDQ==
Date:   Tue, 25 Jul 2023 08:33:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230725153308.GD11340@frogsfrogsfrogs>
References: <20230724152927.33094-1-hch@lst.de>
 <20230724152927.33094-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724152927.33094-2-hch@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 24, 2023 at 08:29:26AM -0700, Christoph Hellwig wrote:
> Test the removal of the underlying device when the file system still
> has dirty data.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/730     | 57 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/730.out |  2 ++
>  2 files changed, 59 insertions(+)
>  create mode 100755 tests/generic/730
>  create mode 100644 tests/generic/730.out
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> new file mode 100755
> index 00000000..11308cda
> --- /dev/null
> +++ b/tests/generic/730
> @@ -0,0 +1,57 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
> +# Copyright (c) 2023 Christoph Hellwig
> +#
> +# Test proper file system shut down when the block device is removed underneath
> +# and there is dirty data.
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
> +_supported_fs generic
> +
> +# We don't actually use the test device, but we need a block based fs
> +_require_test
> +_require_block_device $TEST_DEV
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
> +$XFS_IO_PROG -f -c "pwrite 0 1M" $SCSI_DEBUG_MNT/testfile >>$seqres.full
> +
> +# open a file descriptor for reading the file
> +exec 3< $SCSI_DEBUG_MNT/testfile
> +
> +# delete the scsi debug device while it still has dirty data
> +echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> +
> +# try to read from the file, which should give us -EIO
> +cat <&3 > /dev/null
> +
> +# close the file descriptor to not block unmount
> +exec 3<&-
> +
> +status=0
> +exit
> diff --git a/tests/generic/730.out b/tests/generic/730.out
> new file mode 100644
> index 00000000..79e96db8
> --- /dev/null
> +++ b/tests/generic/730.out
> @@ -0,0 +1,2 @@
> +QA output created by 730
> +cat: -: Input/output error
> -- 
> 2.39.2
> 
