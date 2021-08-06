Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96573C4338F
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Aug 2021 18:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D32461167
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Aug 2021 18:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhHFS4C (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhHFS4C (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 6 Aug 2021 14:56:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CE996113B;
        Fri,  6 Aug 2021 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628276146;
        bh=sj+Fz6q6zfCRv6ZCbIvK0SrofePJpc9qfFQ/2e1Pyc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViSgkorViholDHlqLIzoqyF6A72d/nYmuvxOHxJoKjCEw6yQDe9DiIGIsVDNqPl1u
         zh013E9lw+0HlEWRn3vT1emUgTlod7+hM0FCypq4LuD90S7R4/VXVfQ2LoG5OYqTT/
         GWj7tOCwGPJKXMekSlpTlkNiEaVhjUFDGnZU3Hg+iKIukV6Oz/MJLkIK8ZFcMRELBw
         8CcDAOHGh3Q1VcPGLu36ehgrSCMfhJN4X0WFOFxHUk7YKmhNRg3gZLqRsvQC5wIiZ0
         FGTYaBJldCY9KveVCLkUX9XLH2WTCUJ9MLV7I7e/4CLpu1TqT6+HG8BbeWHqqyj3tr
         DR8APUdxaa2fA==
Date:   Fri, 6 Aug 2021 11:55:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     fstests@vger.kernel.org, ddouwsma@redhat.com
Subject: Re: [PATCH] tests/xfs: check avail blocks after log recovery on ro
 mount
Message-ID: <20210806185545.GE3601425@magnolia>
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 06, 2021 at 09:49:38AM +0800, Murphy Zhou wrote:
> And followed by a rw mount.
> 
> Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
>  tests/xfs/175     | 59 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/175.out |  2 ++
>  2 files changed, 61 insertions(+)
>  create mode 100755 tests/xfs/175
>  create mode 100644 tests/xfs/175.out
> 
> diff --git a/tests/xfs/175 b/tests/xfs/175
> new file mode 100755
> index 00000000..2a79a3d4
> --- /dev/null
> +++ b/tests/xfs/175
> @@ -0,0 +1,59 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 RedHat All Rights Reserved.
> +#
> +# FS QA Test 175
> +#
> +# Testcase for kernel commit:
> +#   50d25484bebe xfs: sync lazy sb accounting on quiesce of read-only mounts
> +#
> +# After shutdown and readonly mount, a following read-write mount would
> +# get wrong number of available blocks.

That's a description of the reproduction strategy, but the fault was
that unmounting the log on a readonly filesystem doesn't log the sb
counters.  I think it's worth mentioning that in the description.

Thanks for putting together a test case though. :)

> +#
> +. ./common/preamble
> +_begin_fstest shutdown auto quick
> +
> +# real QA test starts here
> +
> +_supported_fs xfs
> +_require_scratch
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +mount $SCRATCH_DEV $SCRATCH_MNT

_scratch_mount ?

Also, you probably want

_xfs_force_bdev data $SCRATCH_MNT

to force testfile to be created on the data device if the test runner
passed -d rtinherit=1 in MKFS_OPTS.

> +
> +# Write test file
> +ls > $SCRATCH_MNT/testfile
> +df --output=avail $SCRATCH_MNT >> $seqres.full 2>&1

$DF_PROG

> +
> +# Shutdown
> +$XFS_IO_PROG -x -c "shutdown -f" $SCRATCH_MNT
> +
> +# Mount ReadOnly
> +_scratch_unmount
> +_scratch_mount -oro
> +df --output=avail $SCRATCH_MNT >> $seqres.full 2>&1
> +# Umount and mount rw
> +_scratch_unmount
> +_scratch_mount
> +
> +# Get fdblocks before repair
> +fdb1=$(df --output=avail $SCRATCH_MNT | tail -1)
> +_scratch_unmount
> +
> +# Repair
> +_repair_scratch_fs >> $seqres.full 2>&1
> +
> +# Re-mount
> +_scratch_mount
> +
> +# Get fdblocks after repair
> +fdb2=$(df --output=avail $SCRATCH_MNT | tail -1)
> +
> +echo fdb1 $fdb1 fdb2 $fdb2 >> $seqres.full 2>&1
> +
> +[ $fdb1 -ne $fdb2 ] && echo Wrong fdblocks: $fdb1 and $fdb2

Looks reasonable enough to me.

--D

> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/xfs/175.out b/tests/xfs/175.out
> new file mode 100644
> index 00000000..3b4af34b
> --- /dev/null
> +++ b/tests/xfs/175.out
> @@ -0,0 +1,2 @@
> +QA output created by 175
> +Silence is golden
> -- 
> 2.20.1
> 
