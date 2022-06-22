Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC2AC43334
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jun 2022 12:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiFVMlb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jun 2022 08:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiFVMl3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jun 2022 08:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54E6EB7D
        for <fstests@vger.kernel.org>; Wed, 22 Jun 2022 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655901687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uLo1WWe+TV6yoFwSPtualLcPJ/nDhzhge17SIH0mu0k=;
        b=eIkCuDA8Xd3Ke8jdvoZyCE0bGIs5Bb46BBaMrolIwG8AmQLsHYlV+BVEts6XamOp7PHSHf
        E1rWQ3UCQjUQEwAkDw6sijkCW8+XbSuUDL2rbhkgsZnXGvSrP22dHHkc8LtR0fo1CmFJR8
        bpFB3+ONeZXFgfMt+x6oipucrHmvX2k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-kVMCrTCbOSaO8ZlizI0-cQ-1; Wed, 22 Jun 2022 08:41:26 -0400
X-MC-Unique: kVMCrTCbOSaO8ZlizI0-cQ-1
Received: by mail-qv1-f71.google.com with SMTP id mr11-20020a056214348b00b004705c0cb439so2954014qvb.19
        for <fstests@vger.kernel.org>; Wed, 22 Jun 2022 05:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uLo1WWe+TV6yoFwSPtualLcPJ/nDhzhge17SIH0mu0k=;
        b=h504I9Vkb/MvqVoGBoryrtPrPNEjNlH359QQrMxdzk5Dn6cGja46woHh2wUvoP7aqA
         kmDW4ulQh5LRJkiTbRoGFH79jRhxiPcI2aNzCnKTt3UFC19t80uN0NuS8u+eD+UQ7snI
         Hw0xGpCxUCoubqQp3mY/8xxWwH9ZrpYMDMiY1GUP2CPnRNcfMMnzDDvrCQalujui6UAh
         NefWjSVjBkOE4t1KbEWdw/2BmEqqZe0vGjf2H2Dz9F27MYqhqkEU8Fkx28p4JdL2KcYe
         fdDsR2OyrkE4FRV6wux3hUmxGoidNCo4XJWpVyJF7SG/bHQ6CQEfRsYfoFWTW7VRM1xL
         qD7Q==
X-Gm-Message-State: AJIora/E71kymAkW4lW6UhDBtE8W3pmeOsJI4pVbWnr0mVotkNS7Bqz/
        QThb56eQ9CNZx5KZqj1QVi6i6sM9dQHIxgraOsV/8hHpvDiIR/gYSvjekkCQRQbiNo/HmXPp4aD
        HZ15hSa6mv0Zx/7G1lQ==
X-Received: by 2002:a37:a149:0:b0:6ae:e754:75bb with SMTP id k70-20020a37a149000000b006aee75475bbmr901357qke.417.1655901685669;
        Wed, 22 Jun 2022 05:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8d4b1gGvlPEPMw7d2pY6QKg125A4PV7B+A5DewfbUWEnVCf5d2Gd+ww3Y0t8TbyqJWARXJA==
X-Received: by 2002:a37:a149:0:b0:6ae:e754:75bb with SMTP id k70-20020a37a149000000b006aee75475bbmr901341qke.417.1655901685420;
        Wed, 22 Jun 2022 05:41:25 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y17-20020a37f611000000b006a69f6793c5sm15241448qkj.14.2022.06.22.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 05:41:24 -0700 (PDT)
Date:   Wed, 22 Jun 2022 20:41:18 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: test read repair on a corrupted compressed
 extent
Message-ID: <20220622124118.mkawtc3n2quhi42l@zlang-mailbox>
References: <20220622045844.3219390-1-hch@lst.de>
 <20220622045844.3219390-5-hch@lst.de>
 <20220622092140.GA26204@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622092140.GA26204@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 22, 2022 at 11:21:40AM +0200, Christoph Hellwig wrote:
> So while this test properly documents the current behavior, it failed
> to grasp how broken that behavior ist: the current read repair code
> writes back the uncompressed data to disk even for a compressed extent,
> and this test verified the behavior.
> 
> Below is a correct test that fails on current mainline.  I'll send fixes
> but right now they depend on a lot of prep work.
> 
> ---
> From 6b6c505f75c6c7cc15359f14053b1db43e3d3091 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Wed, 22 Jun 2022 06:55:36 +0200
> Subject: btrfs: test read repair on a corrupted compressed extent
> 
> Exercise read repair on a corrupted compressed sector.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/btrfs/270     | 82 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/270.out |  7 ++++
>  2 files changed, 89 insertions(+)
>  create mode 100755 tests/btrfs/270
>  create mode 100644 tests/btrfs/270.out
> 
> diff --git a/tests/btrfs/270 b/tests/btrfs/270
> new file mode 100755
> index 00000000..5b73fb15
> --- /dev/null
> +++ b/tests/btrfs/270
> @@ -0,0 +1,82 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
                   ^^^^^^^^^^^
Is it a wrong copy&paste ?

> +#
> +# FS QA Test 270
> +#
> +# Regression test for btrfs buffered read repair of compressed data.

If this's a regression test, I'd like to see the fix be reviewed/acked
at first :)

Thanks,
Zorro

> +#
> +. ./common/preamble
> +_begin_fstest auto quick read_repair compress
> +
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_require_btrfs_command inspect-internal dump-tree
> +_require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2
> +
> +get_physical()
> +{
> +	local logical=$1
> +	local stripe=$2
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> +		grep $logical -A 6 | \
> +		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$6 }"
> +}
> +
> +get_devid()
> +{
> +	local logical=$1
> +	local stripe=$2
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> +		grep $logical -A 6 | \
> +		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
> +}
> +
> +get_device_path()
> +{
> +	local devid=$1
> +	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
> +}
> +
> +
> +echo "step 1......mkfs.btrfs"
> +_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
> +_scratch_pool_mkfs "-d raid1 -b 1G" >>$seqres.full 2>&1
> +_scratch_mount -ocompress
> +
> +# Create a file with all data being compressed
> +$XFS_IO_PROG -f -c "pwrite -S 0xaa -W -b 128K 0 128K" \
> +	"$SCRATCH_MNT/foobar" | _filter_xfs_io_offset
> +
> +logical_in_btrfs=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +physical=$(get_physical ${logical_in_btrfs} 1)
> +devid=$(get_devid ${logical_in_btrfs} 1)
> +devpath=$(get_device_path ${devid})
> +
> +_scratch_unmount
> +echo "step 2......corrupt file extent"
> +echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
> +	>> $seqres.full
> +dd if=$devpath of=$TEST_DIR/$seq.dump.good skip=$physical bs=1 count=4096 \
> +	2>/dev/null
> +$XFS_IO_PROG -c "pwrite -S 0xbb -b 4K $physical 4K" $devpath > /dev/null
> +
> +_scratch_mount
> +
> +echo "step 3......repair the bad copy"
> +_btrfs_buffered_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
> +
> +_scratch_unmount
> +
> +echo "step 4......check if the repair worked"
> +dd if=$devpath of=$TEST_DIR/$seq.dump skip=$physical bs=1 count=4096 \
> +	2>/dev/null
> +cmp -bl $TEST_DIR/$seq.dump.good $TEST_DIR/$seq.dump
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/270.out b/tests/btrfs/270.out
> new file mode 100644
> index 00000000..6d744c02
> --- /dev/null
> +++ b/tests/btrfs/270.out
> @@ -0,0 +1,7 @@
> +QA output created by 270
> +step 1......mkfs.btrfs
> +wrote 131072/131072 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +step 2......corrupt file extent
> +step 3......repair the bad copy
> +step 4......check if the repair worked
> -- 
> 2.30.2
> 

