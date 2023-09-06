Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF65EB8FD2
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Sep 2023 14:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjIFORk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Sep 2023 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIFORj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Sep 2023 10:17:39 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3365EE4C
        for <fstests@vger.kernel.org>; Wed,  6 Sep 2023 07:17:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-64f5aeb81d1so21391126d6.0
        for <fstests@vger.kernel.org>; Wed, 06 Sep 2023 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694009855; x=1694614655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vVv4Pn2KolI5jr1rFB9IEFFdFAgIZ03cLPhStfuRazs=;
        b=rOx57WnBwy2nsXuqQ7rl9R/wVB3Odw22UpC0kMxfm2SQrh5tV2ak1BIIF8c+QLIM2z
         /nJfswpn/XmRpomTSqMdm1AiA7+KeZKF9Ul19EaPeuhltmBcwy34k0y08AMfYbpFY5R6
         hdQjh5yTIC3gB/lRUH59Ltsl41FIO5s9TPdM/8HPhc0fJ1XOiZM5a2skEG38B1OAR/Pm
         O3exugEDhMCBvpUEBk97Pdq5cm8Q3NjqCW9/ngLv6Yb6Gwbx6kmXMRiLTkNlIdTYiixU
         x1jDxokgIPmFzBdkhmosZHr4//P4AhmxoWTJeLIqT0iCa5W7GiTCbgtJ3MYHHo7rMb3B
         Osmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694009855; x=1694614655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVv4Pn2KolI5jr1rFB9IEFFdFAgIZ03cLPhStfuRazs=;
        b=NIui74HtTjG95Y9WNXJDw2XfHyHlR2bfn1F8REslmy24Bw1TXZozMm4j8VSdAC/MXz
         YISLXo9t3ru3EuUAQ4rBjqsUPVfjNFA1ME1KcO36YQzcxAYHzOKxjAN63ztMlP2pgHvH
         mtnlKU9f47E6ds0vQ6G/B80J6KgY2kWBJqhK4IdsH71w+Nw+lRo6yNIbW+CQcS5uRWlY
         x3lG0JsYbbt/LMYxrbHUpD1egTYyV7qFqucWLJhwB5QDN+4klI0g88KpTQHtOhPPj6ai
         x0MJzmrwi3LyT0iNO3JQ4L7MpY4HNpMKvimyQO3i3UdotTlO9+3Pi5iLpVyCn+q0cX7X
         iIJg==
X-Gm-Message-State: AOJu0Ywak9l695HoWvAAG6IDRVCdnKuL2GkHoK9liy2tuKjYXKrEr+AC
        9PC/Doi/eYRn9m2rQrMe9ynM+KqaGSJMkmnBYOI=
X-Google-Smtp-Source: AGHT+IG42cHK8hHaXUlcZMvJPAWMXxeX+9Uxc4SLSR9ZmkPg7FPkUECbL0D37Fcnq1KWg105S0ddLA==
X-Received: by 2002:a0c:8cc4:0:b0:651:68f4:92e9 with SMTP id q4-20020a0c8cc4000000b0065168f492e9mr14996210qvb.11.1694009855269;
        Wed, 06 Sep 2023 07:17:35 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j9-20020a0cf309000000b0064f364f3584sm5474363qvl.97.2023.09.06.07.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:17:34 -0700 (PDT)
Date:   Wed, 6 Sep 2023 10:17:33 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, kernel@gpiccoli.net, kernel-dev@igalia.com,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: Add test for the single-dev feature
Message-ID: <20230906141733.GC1877831@perftesting>
References: <20230905200826.3605083-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905200826.3605083-1-gpiccoli@igalia.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 05, 2023 at 05:06:56PM -0300, Guilherme G. Piccoli wrote:
> The SINGLE_DEV btrfs feature allows to mount the same filesystem
> multiple times, at the same time. This is the fstests counter-part,
> which checks both mkfs/btrfstune (by mounting the FS twice), and
> also unsupported scenarios, like device replace / remove.
> 
> Suggested-by: Anand Jain <anand.jain@oracle.com>
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> V2:
> - Rebased against v2023.09.03 / changed test number to 301;
> 
> - Implemented the great suggestions from Anand, which definitely
> made the test more clear and concise;
> 
> -Cc'ing linux-btrfs as well.
> 
> Thanks in advance for reviews / comments!
> Cheers,
> 
> Guilherme
> 
> 
>  tests/btrfs/301     | 94 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/301.out |  5 +++
>  2 files changed, 99 insertions(+)
>  create mode 100755 tests/btrfs/301
>  create mode 100644 tests/btrfs/301.out
> 
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> new file mode 100755
> index 000000000000..5f8abdbe157a
> --- /dev/null
> +++ b/tests/btrfs/301
> @@ -0,0 +1,94 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Guilherme G. Piccoli (Igalia S.L.).  All Rights Reserved.
> +#
> +# FS QA Test 301
> +#
> +# Test for the btrfs single-dev feature - both mkfs and btrfstune are
> +# validated, as well as explicitly unsupported commands, like device
> +# removal / replacement.
> +#
> +. ./common/preamble
> +_begin_fstest auto mkfs quick
> +. ./common/filter

Normally we group all the require'd stuff together
> +_supported_fs btrfs
> +
> +_require_btrfs_mkfs_feature single-dev
> +_require_btrfs_fs_feature single_dev
> +
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 1
> +_spare_dev_get
> +
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_command "$WIPEFS_PROG" wipefs
> +
> +# Helper to mount a btrfs fs
> +# Arg 1: device
> +# Arg 2: mount point
> +mount_btrfs()
> +{
> +	$MOUNT_PROG -t btrfs $1 $2
> +	[ $? -ne 0 ] && _fail "mounting $1 on $2 failed"
> +}
> +
> +SPARE_MNT="${TEST_DIR}/${seq}/spare_mnt"
> +mkdir -p $SPARE_MNT
> +
> +
> +# Part 1
> +# First test involves a mkfs with single-dev feature enabled.
> +# If it succeeds and mounting that FS *twice* also succeeds,
> +# we're good and continue.
> +$WIPEFS_PROG -a $SCRATCH_DEV >> $seqres.full 2>&1
> +$WIPEFS_PROG -a $SPARE_DEV >> $seqres.full 2>&1
> +
> +_scratch_mkfs "-b 300M -O single-dev" >> $seqres.full 2>&1
> +dd if=$SCRATCH_DEV of=$SPARE_DEV bs=300M count=1 conv=fsync >> $seqres.full 2>&1
> +
> +mount_btrfs $SCRATCH_DEV $SCRATCH_MNT

You can just use _scratch_mount here, since you want to handle failures just

_scratch_mount || _fail "failed to mount scratch mount"

> +mount_btrfs $SPARE_DEV $SPARE_MNT

Instead use _mount here

_mount $SPARE_DEV $SPARE_MNT || _fail "failed to mount spare dev"

> +
> +$UMOUNT_PROG $SPARE_MNT
> +$UMOUNT_PROG $SCRATCH_MNT

_scratch_unmount

> +
> +
> +# Part 2
> +# Second test is similar to the first with the difference we
> +# run mkfs with no single-dev mention, and make use of btrfstune
> +# to set such feature.
> +$WIPEFS_PROG -a $SCRATCH_DEV >> $seqres.full 2>&1
> +$WIPEFS_PROG -a $SPARE_DEV >> $seqres.full 2>&1
> +
> +_scratch_mkfs "-b 300M" >> $seqres.full 2>&1
> +$BTRFS_TUNE_PROG --convert-to-single-device $SCRATCH_DEV
> +dd if=$SCRATCH_DEV of=$SPARE_DEV bs=300M count=1 conv=fsync >> $seqres.full 2>&1
> +
> +mount_btrfs $SCRATCH_DEV $SCRATCH_MNT

_scratch_mount

> +mount_btrfs $SPARE_DEV $SPARE_MNT

_mount

> +
> +$UMOUNT_PROG $SPARE_MNT
> +$UMOUNT_PROG $SCRATCH_MNT

_scratch_unmount

> +
> +
> +# Part 3
> +# Final part attempts to run some single-dev unsupported commands,
> +# like device replace/remove - it they fail, test succeeds!
> +mount_btrfs $SCRATCH_DEV $SCRATCH_MNT

_scratch_mount

> +
> +$BTRFS_UTIL_PROG device replace start $SCRATCH_DEV $SCRATCH_DEV $SCRATCH_MNT 2>&1 \
> +	| _filter_scratch
> +
> +$BTRFS_UTIL_PROG device remove $SCRATCH_DEV $SCRATCH_MNT 2>&1 \
> +	| _filter_scratch
> +
> +$UMOUNT_PROG $SCRATCH_MNT

_scratch_unmount

> +
> +_spare_dev_put
> +_scratch_dev_pool_put 1
> +
> +# success, all done
> +status=0
> +echo "Finished"

Don't need this bit.  Thanks,

Josef
