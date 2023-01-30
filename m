Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBCDC54EAA
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 04:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjA3EvN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 Jan 2023 23:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbjA3Euu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Jan 2023 23:50:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB9512592
        for <fstests@vger.kernel.org>; Sun, 29 Jan 2023 20:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675054172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6z1eu5rovhiJyrakHESdj/dS1TaehQB7J6ADnmby9DA=;
        b=ApJKcBGg9kt9vT8jyQ3oS7FAmp8kZXXj3XIkQxlJF0nFlPVizLu/NO/qDVIQ8td1AjLCQf
        xbJniYeWk5Toy5O+vtNPdH1aQFAKumUF5sFhRL2Y/72z4VWO5+brn0JPoH+CkhgPB6NT83
        QE0PYXjP7hIugf6XwTHsq47ZqkD0GrY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-408-flem1yX6PYOTzwClk1Go4Q-1; Sun, 29 Jan 2023 23:49:31 -0500
X-MC-Unique: flem1yX6PYOTzwClk1Go4Q-1
Received: by mail-pl1-f199.google.com with SMTP id q5-20020a170902e30500b001967df62d0dso1390308plc.18
        for <fstests@vger.kernel.org>; Sun, 29 Jan 2023 20:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z1eu5rovhiJyrakHESdj/dS1TaehQB7J6ADnmby9DA=;
        b=da7GHykaNP9FMyNxguJaHTKzP9e9RlZeB62rplsYPTejsqoMoPgLFuuwwDoZvX6tc8
         0fnJTf1+vlNmsgOn1qTMTt3OwdbPotlnVnPLyeJ7Uhti/2S063qPsunZqjdAIjXwiUS3
         0c+AnX3obHCIUNMkuxubWJAo1vERI/MjCcqeQuSEZjzAoao0ZQVHIf4lUIo5sbmYrMA0
         YBGipN6PEsp6arxppEgNUjnhEZbstxnENOeEcxA3vJOZfhYhRJzH+DGQ0BpWCeLaRa2s
         oxI5FQ6omcnE0/RnoQg0rm395JW03G1T44XlKVCjb+ANJ8nwKbMKpW2s7EV3mFxG+Lxa
         wKrg==
X-Gm-Message-State: AFqh2krFAnvAqyaWgkYvFpea/7ZR5B7brwsunea4LuPAwCxwFEMtoeXV
        5iWAoxcNoIIZ+owuy/yuPY94nSVBrMqtSh3ADXCYZnj+vTqc282aawthA+421D2HzEONqXV7vxm
        AFkggL9vq/FEKj4+cBg==
X-Received: by 2002:a17:902:f650:b0:192:b43e:272 with SMTP id m16-20020a170902f65000b00192b43e0272mr55331511plg.53.1675054170315;
        Sun, 29 Jan 2023 20:49:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvQS7i8RPR3zwGah3SZt73f9s2/8lqD/rCgSXE5y4gSE9tRL70f7xPeGD3d+Vrri/VhAvn8rA==
X-Received: by 2002:a17:902:f650:b0:192:b43e:272 with SMTP id m16-20020a170902f65000b00192b43e0272mr55331500plg.53.1675054169988;
        Sun, 29 Jan 2023 20:49:29 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e80400b001960831d65dsm6660145plg.92.2023.01.29.20.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:49:29 -0800 (PST)
Date:   Mon, 30 Jan 2023 12:49:25 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: test block group size class loading logic
Message-ID: <20230130044925.jv23enewzb5xpdrl@zlang-mailbox>
References: <16b9a9042169c25a10dd1867cedd14849d00dca5.1674755053.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b9a9042169c25a10dd1867cedd14849d00dca5.1674755053.git.boris@bur.io>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 26, 2023 at 09:48:17AM -0800, Boris Burkov wrote:
> Add a new test which checks that size classes in freshly loaded block
> groups after a cycle mount match size classes before going down
> 
> Depends on the kernel patch:
> btrfs: add size class stats to sysfs
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v3:
> Re-add fixed_by_kernel_commit, but for the stats patch which is
> required, but not a fix in the strictest sense.
> 
> v2:
> Drop the fixed_by_kernel_commit since the fix is not out past the btrfs
> development tree, so the fix is getting rolled in to the original broken
> commit. Modified the commit message to note the dependency on the new
> sysfs counters.
> 
>  tests/btrfs/283     | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/283.out |  2 ++
>  2 files changed, 52 insertions(+)
>  create mode 100755 tests/btrfs/283
>  create mode 100644 tests/btrfs/283.out
> 
> diff --git a/tests/btrfs/283 b/tests/btrfs/283
> new file mode 100755
> index 00000000..d250a389
> --- /dev/null
> +++ b/tests/btrfs/283
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 283
> +#
> +# Test that mounting a btrfs filesystem properly loads block group size classes.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount
> +fixed_by_kernel_commit xxxxxxxx "btrfs: add size class stats to sysfs".

    +/root/git/xfstests/tests/btrfs/283: line 11: fixed_by_kernel_commit: command not found

It's "_fixed_by_kernel_commit", you missed the "_" prefix.

> +
> +sysfs_size_classes() {
> +	local uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
> +	cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"

I hit below error:
    +cat: /sys/fs/btrfs/7df0dfa8-b1cd-4646-bd30-8683bbf0a4f1/allocation/data/size_classes: No such file or directory
    +cat: /sys/fs/btrfs/7df0dfa8-b1cd-4646-bd30-8683bbf0a4f1/allocation/data/size_classes: No such file or directory

I think btrfs not always support the "allocation/data/size_classes" file. So
we need to check if current kernel supports that, and _notrun if not. The
_require_fs_sysfs might help you a bit.

Thanks,
Zorro

> +}
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_btrfs_fs_sysfs
> +
> +f="$SCRATCH_MNT/f"
> +small=$((16 * 1024))
> +medium=$((1024 * 1024))
> +large=$((16 * 1024 * 1024))
> +
> +_scratch_mkfs >/dev/null
> +_scratch_mount
> +# Write files with extents in each size class
> +$XFS_IO_PROG -fc "pwrite -q 0 $small" $f.small
> +$XFS_IO_PROG -fc "pwrite -q 0 $medium" $f.medium
> +$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large
> +# Sync to force the extent allocation
> +sync
> +pre=$(sysfs_size_classes)
> +
> +# cycle mount to drop the block group cache
> +_scratch_cycle_mount
> +
> +# Another write causes us to actually load the block groups
> +$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large.2
> +sync
> +
> +post=$(sysfs_size_classes)
> +diff <(echo $pre) <(echo $post)
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
> new file mode 100644
> index 00000000..efb2c583
> --- /dev/null
> +++ b/tests/btrfs/283.out
> @@ -0,0 +1,2 @@
> +QA output created by 283
> +Silence is golden
> -- 
> 2.39.1
> 

