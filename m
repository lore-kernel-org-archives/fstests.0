Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C21EB64DA
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jul 2023 10:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjGRKft (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jul 2023 06:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGRKfs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jul 2023 06:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD14E4C
        for <fstests@vger.kernel.org>; Tue, 18 Jul 2023 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689676501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nCIqPE6q4VsCz+5hcrvY0ilBRMgruDWQxyBkRqO77Ck=;
        b=OLwPAIWozxFWmkWs7pd2dhMv99FSHk48WfTZPoC22Gn3f9Nsj7e48PZPIBz4Wwl3D2lV6h
        cY2bK7ifltd0nJJU+M091qvgLTeMW2x0b63bQuRoi3ZE0ymfAs//HKgMl9r2IlSfLnHJeP
        pdvnR5ZmgjAaW9+2SaEntvlypDBteLc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-U2MFS-PvOWqWSoHJ_Cxe9Q-1; Tue, 18 Jul 2023 06:35:00 -0400
X-MC-Unique: U2MFS-PvOWqWSoHJ_Cxe9Q-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b8b30f781cso28086885ad.2
        for <fstests@vger.kernel.org>; Tue, 18 Jul 2023 03:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689676497; x=1692268497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCIqPE6q4VsCz+5hcrvY0ilBRMgruDWQxyBkRqO77Ck=;
        b=i6BqJCqk23FfYuHpcDG036DHiq20wMrHMYwcIjVZfypQA/KveWxRVTqE6rvn9DVRU3
         g+dnu+JEpm8nVHp46EGVpbUNgrOIhj2pQiQRgOb3d/eZRBdCZ6mgddNRxCPyf6HI1sun
         s9RgkqaKXJYIBbR0EdsmsfWqkV8aT34UpnO4aX5H7cq4naz68Yuh0axnsAizE2Gj05yP
         u87J+Vlw2LR+k+U2ZJvC1SlSYxYMAonfwT02SmrNYx/jehbtIPyvL06VJ+fdhIeJElyx
         tl4cK39xddE8SYEW+1bl8s47xZUP52H/DBKXnDTa+yUpF4rIDD0NiFNpUik3LLRCCW93
         BiYQ==
X-Gm-Message-State: ABy/qLbVI0s7ChaATnWf4DwVRniqgq4dDgRq1GsqOhC4b+Au72EJahLc
        2hSU6eEHpZ0GOs+4yis+2mZZEXUHrZZjKFciyytFqwsj9IkksnEhULWDQYT0abkU9zAiFViTHLt
        eqtHkcBzwE790zBh+HJlrVjuy0PhP8EU=
X-Received: by 2002:a17:903:11c9:b0:1ae:10bc:4ae8 with SMTP id q9-20020a17090311c900b001ae10bc4ae8mr15352069plh.26.1689676497445;
        Tue, 18 Jul 2023 03:34:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHP0BNV159S0s8/EWSviAc7Pd/gCFi+83CNamy1CHxbYfLGznRCpwKdXImzGDfoZlkDBbUANA==
X-Received: by 2002:a17:903:11c9:b0:1ae:10bc:4ae8 with SMTP id q9-20020a17090311c900b001ae10bc4ae8mr15352054plh.26.1689676497034;
        Tue, 18 Jul 2023 03:34:57 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jk11-20020a170903330b00b001b8896cd57bsm1486032plb.269.2023.07.18.03.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 03:34:56 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:34:49 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230718103449.5gclk7getjbnwk5d@zlang-mailbox>
References: <20230711100931.175680-1-hch@lst.de>
 <20230711100931.175680-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711100931.175680-2-hch@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 11, 2023 at 12:09:30PM +0200, Christoph Hellwig wrote:
> Test the removal of the underlying device when the file system still
> has dirty data.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Thanks this new version! Sorry for the late review. Most of the cases look
good to me, just a bit picky reveiw points as below. (Same to patch 2/2).

>  tests/generic/730     | 57 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/730.out |  2 ++
>  2 files changed, 59 insertions(+)
>  create mode 100755 tests/generic/730
>  create mode 100644 tests/generic/730.out
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> new file mode 100755
> index 00000000..6fba31fc
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
> +	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
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
> +physical=`blockdev --getpbsz $SCRATCH_DEV`
> +logical=`blockdev --getss $SCRATCH_DEV`

There's not _require_scratch, so I doubt we should use SCRATCH_DEV directly.
How about use TEST_DEV (due to this case calls _require_test) ?

> +
> +SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 300`
> +test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
> +echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
> +
> +_mkfs_dev $SCSI_DEBUG_DEV

How about _fail if it fails?

> +
> +_mount $SCSI_DEBUG_DEV $SCRATCH_MNT

I don't know if mount can return non-zero without any output. If you hope to
check the return status, you can use run_check() in common/rc.

> +
> +# create a test file
> +$XFS_IO_PROG -f -c "pwrite 0 1M" $SCRATCH_MNT/testfile >>$seqres.full
> +
> +# open a file descriptor for reading the file
> +exec 3< $SCRATCH_MNT/testfile
> +
> +# delete the scsi debug device while it still has dirty data
> +echo 1 > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/delete

Is this file "/sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/delete" 100%
supported? Or we'd better to _notrun, not report pass.

(BTW, the `command` and $(command) are both work, but the $() is more recommended
in fstests (not mandatory:). If both formats are good, choose $(command).
http://mywiki.wooledge.org/BashFAQ/082)

Thanks,
Zorro

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

