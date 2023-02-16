Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D999AC636CC
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Feb 2023 14:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBPOvA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Feb 2023 09:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPOu7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Feb 2023 09:50:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C37F4AFC7
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2023 06:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676559009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RiVhPlbe4gRv7YFLubskNVaVH/ZPqeFrGIt5DjV9jo4=;
        b=BTIaVF2+hqeFbd1JkIF1dWKWf9PbMCSWeU6egCFVTbVFA8+Agi1o2PkTza8Pjfgv9ATZd/
        UJnVwFpDIJgMDUcj5wazgEt5+KGEVx9HN4pgNeMKgANUa7UbXu5i34Vgu76LFZM4uwEaSX
        pCKS+BEQl/y96p/U5LiF7AgJFuUInxs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-vtdLhwXGNGiI5W-Y5P7fyA-1; Thu, 16 Feb 2023 09:49:59 -0500
X-MC-Unique: vtdLhwXGNGiI5W-Y5P7fyA-1
Received: by mail-pj1-f69.google.com with SMTP id g8-20020a17090ace8800b0023487c793d0so1315539pju.7
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2023 06:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiVhPlbe4gRv7YFLubskNVaVH/ZPqeFrGIt5DjV9jo4=;
        b=2GKx6myxBSe1rqfzrbS6amdYpU5qmvJnIditNRSPT7+yZiQmb5Kg+f1X/UfdoZ7M32
         CFoO2xtRS1aecoHfGW2726riBLTwuC5DLg+l8rctbl2Gy8fmPVrKbN2BTQRHcLtPP8vE
         ZddX7pDnUC4TddVPYpA1xPwg67yOxw8wcf4zlagOkYMYJbFOQX2/uVzdKwuGkZeKoQoI
         zlcb/3O8ZqDPPVGW2F3HECV6twhkcAmFQn9EfZbt+8addTe45up6shpA1h5yCAYs/9HW
         mJB+rhSHqU5NZnbja2iei3cYv27J7WP0SmjalSb0eBUzHWYr9uwQvO3zX07fie2e4kp0
         81RQ==
X-Gm-Message-State: AO0yUKUvWOwB1Y4yi5jpPvO5Fr4hiJPTy1sOiLgIeYRwXKCZ4nI/NVt8
        /7irapNIj2hQSZLJ/M7A0nhaYKi7b51GAQINTwrYOSCILqQKcGo9vsZyUbhlR8nBbVwawZ9xSoy
        gkfsvOvquOmtSpzQALw==
X-Received: by 2002:a62:1843:0:b0:575:b783:b6b3 with SMTP id 64-20020a621843000000b00575b783b6b3mr5661651pfy.28.1676558998650;
        Thu, 16 Feb 2023 06:49:58 -0800 (PST)
X-Google-Smtp-Source: AK7set/I4E9K5CrqACVw793oaJ+z5zMeMbO1Vl7zBYMpOKaGfA3Q4XhsI9+6R/jIYR/r0gY+VEZDrQ==
X-Received: by 2002:a62:1843:0:b0:575:b783:b6b3 with SMTP id 64-20020a621843000000b00575b783b6b3mr5661628pfy.28.1676558998247;
        Thu, 16 Feb 2023 06:49:58 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n20-20020aa79054000000b005a8a9950363sm1392220pfo.105.2023.02.16.06.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:49:57 -0800 (PST)
Date:   Thu, 16 Feb 2023 22:49:52 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v6] btrfs: test block group size class loading logic
Message-ID: <20230216144952.wcr7r3hdesu2x2le@zlang-mailbox>
References: <160e7557f66a6a34fd052d6834909aa02a702956.1676503163.git.boris@bur.io>
 <CAL3q7H42GK2xu9ZSAKiDUG8ZRJzgudk-3DHE9f95Sqwc0iPKyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H42GK2xu9ZSAKiDUG8ZRJzgudk-3DHE9f95Sqwc0iPKyQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 16, 2023 at 12:11:39PM +0000, Filipe Manana wrote:
> On Wed, Feb 15, 2023 at 11:37 PM Boris Burkov <boris@bur.io> wrote:
> >
> > Add a new test which checks that size classes in freshly loaded block
> > groups after a cycle mount match size classes before going down
> >
> > Depends on the kernel patch:
> > btrfs: add size class stats to sysfs
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Changelog:
> > v6:
> > Actually include changes for v5 in the commit.
> > v5:
> > Instead of using _fixed_by_kernel_commit, use require_fs_sysfs to handle
> > the needed sysfs file. The test is skipped on kernels without the file
> > and runs correctly on new ones.
> > v4:
> > Fix dumb typo in _fixed_by_kernel_commit (left out leading underscore
> > copy+pasting). Re-tested happy and sad case...
> >
> > v3:
> > Re-add fixed_by_kernel_commit, but for the stats patch which is
> > required, but not a fix in the strictest sense.
> >
> > v2:
> > Drop the fixed_by_kernel_commit since the fix is not out past the btrfs
> > development tree, so the fix is getting rolled in to the original broken
> > commit. Modified the commit message to note the dependency on the new
> > sysfs counters.
> >
> >
> >  tests/btrfs/283     | 50 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/283.out |  2 ++
> >  2 files changed, 52 insertions(+)
> >  create mode 100755 tests/btrfs/283
> >  create mode 100644 tests/btrfs/283.out
> >
> > diff --git a/tests/btrfs/283 b/tests/btrfs/283
> > new file mode 100755
> > index 00000000..2c26b41e
> > --- /dev/null
> > +++ b/tests/btrfs/283
> > @@ -0,0 +1,50 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 283
> > +#
> > +# Test that mounting a btrfs filesystem properly loads block group size classes.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick mount
> 
> I'm still curious why the 'mount' group, and I've asked for that before.
> 
> We aren't testing a new mount option, so it feels weird for me.

Agree, the "mount" group looks not make sense.

The btrfs/283 has been taken in v2023.02.05. So please make a rebase.

The "fixed_by_kernel_commit xxxx" part has been added and removed several times,
does this case need it or not? Or maybe you want a _wants_kernel_commit (just
ask for sure) ?

Others look good to me.

Thanks,
Zorro

> 
> Otherwise, it looks fine now. Thanks.
> 
> > +
> > +sysfs_size_classes() {
> > +       local uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
> > +       cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"
> > +}
> > +
> > +_supported_fs btrfs
> > +_require_scratch
> > +_require_btrfs_fs_sysfs
> > +_require_fs_sysfs allocation/data/size_classes
> > +
> > +f="$SCRATCH_MNT/f"
> > +small=$((16 * 1024))
> > +medium=$((1024 * 1024))
> > +large=$((16 * 1024 * 1024))
> > +
> > +_scratch_mkfs >/dev/null
> > +_scratch_mount
> > +# Write files with extents in each size class
> > +$XFS_IO_PROG -fc "pwrite -q 0 $small" $f.small
> > +$XFS_IO_PROG -fc "pwrite -q 0 $medium" $f.medium
> > +$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large
> > +# Sync to force the extent allocation
> > +sync
> > +pre=$(sysfs_size_classes)
> > +
> > +# cycle mount to drop the block group cache
> > +_scratch_cycle_mount
> > +
> > +# Another write causes us to actually load the block groups
> > +$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large.2
> > +sync
> > +
> > +post=$(sysfs_size_classes)
> > +diff <(echo $pre) <(echo $post)
> > +
> > +echo "Silence is golden"
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
> > new file mode 100644
> > index 00000000..efb2c583
> > --- /dev/null
> > +++ b/tests/btrfs/283.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 283
> > +Silence is golden
> > --
> > 2.39.1
> >
> 

