Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003E9C25B47
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Oct 2023 12:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbjJ0MQT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 Oct 2023 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345420AbjJ0MQS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Oct 2023 08:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C3110A
        for <fstests@vger.kernel.org>; Fri, 27 Oct 2023 05:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698408931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmcBpkcMtUzkFnS0Z4xfn2QsFi+vB2x0NJn50Z9ibvY=;
        b=YbjE2CSNFPTUYCqHhZq5MFHQl9aAqHg7u0I43jWCiAqprEmXZfNl41Cl5u+UeS8Gol/iUi
        liSTrsI187hH7tG1y2QUEqaKwEGF7hX5mUxA5Jfoay5+s68X4JLwYCvPvw6nhlNI2cRMAN
        kQ3hPNyv1lmcpxT0PSMtgXza0z97i5o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-nIUcKLLZNAm8xNAPGEhzcA-1; Fri, 27 Oct 2023 08:15:29 -0400
X-MC-Unique: nIUcKLLZNAm8xNAPGEhzcA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso6018785ad.1
        for <fstests@vger.kernel.org>; Fri, 27 Oct 2023 05:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698408928; x=1699013728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmcBpkcMtUzkFnS0Z4xfn2QsFi+vB2x0NJn50Z9ibvY=;
        b=Dk5cebQZsJr8lXCV3KTAtqnR9TWMYAGa3GZZb9tViGM6G5JrshJzzTE5UjDF5uu07A
         j02FFGIMy78jYNkU/MLBBEW9WqL4tkzWhf0b4taiU/Xd6LmYoJ+RL6zR2sf/BzhP+YQJ
         aHC2peZLud320nBNN+nOok7eP1YGbAPN6eKDmcX/S7MFLfOIq2tDlpVOSotTVMNx5Ozd
         QeFFCt6BNddhuXD+f24NB2iEz7C4cgrQeUMU6Trucqeo+MvmE7v57YsTL0yfzWgmAl2g
         YWQPySCxVLj5YsIijbc4WJgyLPqEebvo4oUnoiuiILucBml1dASXvc7OpJUNS6E86iz6
         TOPg==
X-Gm-Message-State: AOJu0YwXOVMAltw9ygdnypkJRQMjqp0QXet8d6Vyi15eiBDOiF+bg0O/
        pdAtBVVL0/ZCCwFd5WjiFygtzVGVYVdw1gkS8FsVBKVyr/X/gHzn159qyjZb5ps/cK8uaGhg1B8
        0jyfI2coPBUYZbPChxI8+dPxDXsi37vg=
X-Received: by 2002:a17:902:dcc5:b0:1cc:b3f:dd81 with SMTP id t5-20020a170902dcc500b001cc0b3fdd81mr1928418pll.67.1698408928352;
        Fri, 27 Oct 2023 05:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoLJf/9t+MxP2adSki0TQVAXmyVyTSsD8IcnwXQzAwyeGADdDb8gCK5sui/PYuTQpwtmJnPA==
X-Received: by 2002:a17:902:dcc5:b0:1cc:b3f:dd81 with SMTP id t5-20020a170902dcc500b001cc0b3fdd81mr1928401pll.67.1698408928020;
        Fri, 27 Oct 2023 05:15:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ik30-20020a170902ab1e00b001cc2c7a30e0sm49063plb.159.2023.10.27.05.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:15:27 -0700 (PDT)
Date:   Fri, 27 Oct 2023 20:15:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: test snapshotting a subvolume that was just
 created
Message-ID: <20231027121524.247ewzfnns3otte4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <3149ccc2900f5574a046e675a6db79b019af2bac.1697718086.git.fdmanana@suse.com>
 <c0b651af75a999cb1356e64d936080b65067ae56.1698146559.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b651af75a999cb1356e64d936080b65067ae56.1698146559.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 24, 2023 at 12:23:46PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that snapshotting a new subvolume (created in the current transaction)
> that has a btree with a height > 1, works and does not result in a fs
> corruption.
> 
> This exercises a regression introduced in kernel 6.5 by the kernel commit:
> 
>   1b53e51a4a8f ("btrfs: don't commit transaction for every subvol create")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
> 
> v2: Add git commit ID for the kernel fix, as it was merged yesterday into
>     Linus' tree. Also fixed a typo and included Josef's Reviewed-by tag.

Thanks for doing this!

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/btrfs/302     | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/302.out |  4 +++
>  2 files changed, 65 insertions(+)
>  create mode 100755 tests/btrfs/302
>  create mode 100644 tests/btrfs/302.out
> 
> diff --git a/tests/btrfs/302 b/tests/btrfs/302
> new file mode 100755
> index 00000000..f3e6044b
> --- /dev/null
> +++ b/tests/btrfs/302
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 302
> +#
> +# Test that snapshotting a new subvolume (created in the current transaction)
> +# that has a btree with a height > 1, works and does not result in a filesystem
> +# corruption.
> +#
> +# This exercises a regression introduced in kernel 6.5 by the kernel commit:
> +#
> +#    1b53e51a4a8f ("btrfs: don't commit transaction for every subvol create")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick snapshot subvol
> +
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_fssum
> +
> +_fixed_by_kernel_commit eb96e221937a \
> +	"btrfs: fix unwritten extent buffer after snapshotting a new subvolume"
> +
> +# Use a filesystem with a 64K node size so that we have the same node size on
> +# every machine regardless of its page size (on x86_64 default node size is 16K
> +# due to the 4K page size, while on PPC it's 64K by default). This way we can
> +# make sure we are able to create a btree for the subvolume with a height of 2.
> +_scratch_mkfs -n 64K >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
> +
> +# Create a few empty files on the subvolume, this bumps its btree height to 2
> +# (root node at level 1 and 2 leaves).
> +for ((i = 1; i <= 300; i++)); do
> +	echo -n > $SCRATCH_MNT/subvol/file_$i
> +done
> +
> +# Create a checksum of the subvolume's content.
> +fssum_file="$SCRATCH_MNT/checksum.fssum"
> +$FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
> +
> +# Now create a snapshot of the subvolume and make it accessible from within the
> +# subvolume.
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
> +		 $SCRATCH_MNT/subvol/snap | _filter_scratch
> +
> +# Now unmount and mount again the fs. We want to verify we are able to read all
> +# metadata for the snapshot from disk (no IO failures, etc).
> +_scratch_cycle_mount
> +
> +# The snapshot's content should match the subvolume's content before we created
> +# the snapshot.
> +$FSSUM_PROG -r $fssum_file $SCRATCH_MNT/subvol/snap
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
> new file mode 100644
> index 00000000..8770aefc
> --- /dev/null
> +++ b/tests/btrfs/302.out
> @@ -0,0 +1,4 @@
> +QA output created by 302
> +Create subvolume 'SCRATCH_MNT/subvol'
> +Create a readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol/snap'
> +OK
> -- 
> 2.40.1
> 

