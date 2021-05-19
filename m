Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ED7C433ED
	for <linux-fstests@archiver.kernel.org>; Wed, 19 May 2021 23:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48C66135C
	for <linux-fstests@archiver.kernel.org>; Wed, 19 May 2021 23:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhESXZ5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 May 2021 19:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhESXZ4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 May 2021 19:25:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A467610CB;
        Wed, 19 May 2021 23:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621466676;
        bh=QoiOBsQ0NDMNh5qVzoFJnzpXRZ21iQbGFX1PP4cpVxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZjvD6n2nLUnC7jeFcd6kTKrnlo2v40j5TMhYThXZdHUHVuMl+Kcbec3ufXzO1P9I
         nbOpCzge7MySCrf4VqcttgO5n4y1GseRP6h6CVCaOy+YkUJu2DWbQjyj21AxXvzMzj
         olu8OoayPuXModMPQrgbe7CaI5PSM0FgDAXZ1jrkZIFvA5WEmbZM7YMY1fMbUrnqv2
         Jk4AWaeQh30460+YehoSNKIJ+1WB6iwpNu5ySh/fkxIJNmn79Fpk8+P33F5c8EEv+v
         3SoQGk8k5CskHEDAzFcBUMUUT4D6Pfe+nQg1+uqhtZObZE9snlpQ0qr7VWzfBEhRtV
         pW8gCN3gaFoag==
Date:   Wed, 19 May 2021 16:24:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     chenlong <chenlongcl.chen@huawei.com>
Cc:     fstests@vger.kernel.org, guaneryu@gmail.com, tytso@mit.edu
Subject: Re: [PATCH] ext4/048: Add new regression test
Message-ID: <20210519232435.GE9648@magnolia>
References: <20210519031015.14005-1-chenlongcl.chen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210519031015.14005-1-chenlongcl.chen@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 19, 2021 at 11:10:15AM +0800, chenlong wrote:
> Check the block group zero and prevent initializing reserved inodes.
> But in some special cases, the reserved inode may not all belong to
> the group zero, it may exist into the second group if we format 
> filesystem below.
> mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
> So, it will end up triggering a false positive report of a corrupted
> file system
> 
> It's a regression test for commit a149d2a5cabb.
> 
> Signed-off-by: Chen Long <chenlongcl.chen@huawei.com>
> ---
>  tests/ext4/048     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/048.out |  5 +++++
>  tests/ext4/group   |  1 +
>  3 files changed, 56 insertions(+)
>  create mode 100755 tests/ext4/048
>  create mode 100644 tests/ext4/048.out
> 
> diff --git a/tests/ext4/048 b/tests/ext4/048
> new file mode 100755
> index 00000000..56801579
> --- /dev/null
> +++ b/tests/ext4/048
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test 048
> +#
> +# Regression test for commit:
> +# a149d2a5cabb(ext4: fix check to prevent false positive report of incorrect
> +# used inodes)
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +    cd /
> +    rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_require_scratch
> +
> +echo "+ create scratch fs"
> +_scratch_mkfs_ext4 -b 4096 -g 8192 -N 1024 -I 4096 >> $seqres.full 2>&1
> +
> +echo "+ mount fs"
> +_scratch_mount -o errors=remount-ro
> +sleep 5

Why do we need to sleep here?  Won't _scratch_mount return nonzero if
the (buggy) kernel thought the fs was corrupt?

Also, won't the grep below catch that the fs didn't mount?

> +
> +echo "+ check mountpoint status"
> +cat /proc/self/mounts | grep ${SCRATCH_MNT} | \

Careful here, if someone sets SCRATCH_MNT=/u, this will match another
mount for /usr.  At the bare minimum you want 'grep -w' here, I think.

--D

> +    $AWK_PROG '{print $4}' | grep -oE '^rw,' | tee -a $seqres.full
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/048.out b/tests/ext4/048.out
> new file mode 100644
> index 00000000..16e50e86
> --- /dev/null
> +++ b/tests/ext4/048.out
> @@ -0,0 +1,5 @@
> +QA output created by 048
> ++ create scratch fs
> ++ mount fs
> ++ check mountpoint status
> +rw,
> diff --git a/tests/ext4/group b/tests/ext4/group
> index ceda2ba6..82b77efb 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -50,6 +50,7 @@
>  045 auto dir
>  046 auto prealloc quick
>  047 auto quick dax
> +048 auto quick
>  271 auto rw quick
>  301 aio auto ioctl rw stress defrag
>  302 aio auto ioctl rw stress defrag
> -- 
> 2.18.0.huawei.25
> 
