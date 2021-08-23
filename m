Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C1BC4338F
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Aug 2021 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81666136F
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Aug 2021 17:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhHWRn7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhHWRn7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Aug 2021 13:43:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B3D46126A;
        Mon, 23 Aug 2021 17:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629740596;
        bh=uqQW7fyjdNstyp9yXLvDxRZ9MJ+eukg2M8pRPLYtvf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lm05wudKNf4P9w+AxLOSSGblLHh59yMqLXgLgVBmX+zg0IhrvRBPoJvde1r1epOS4
         dxqZf0X5OqRDfJIzD7XZErCoTzuzzk4zBa65AkZYOAkO75vl5ocnjBTrjvOQSxIlV3
         OnzRpSWoiS2RcOQyhzukgFZy7USd2tg7Msh0C0FA8btLJO5eZzrjzCyA1MBwCbRRPg
         sEle6zKpiL814KuHGd1xbDU4K/79qSwfIsq9YJ78mdgM4LzIPR2CamGNk2kIpY3cLD
         fsvyw7RUG2XO1cLOV1ns/pOdcdbFeJuRe4vix3u42KouAJHBGWf9B9Jo+rRLRl0ayT
         +DIlHdBjqrcRw==
Date:   Mon, 23 Aug 2021 10:43:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     fstests@vger.kernel.org, ddouwsma@redhat.com
Subject: Re: [PATCH v2] tests/xfs: check available blocks after log recovery
 on ro mount
Message-ID: <20210823174316.GE12612@magnolia>
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 23, 2021 at 03:05:41PM +0800, Murphy Zhou wrote:
> And followed by a rw mount.
> 
> Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
> v2:
>    Add explaination of the issue
>    add xfs_force_bdev data $SCRATCH_MNT
>    use DF_PROG
>    Re numbered this test
> 
>  tests/xfs/999     | 61 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/999.out |  2 ++
>  2 files changed, 63 insertions(+)
>  create mode 100755 tests/xfs/999
>  create mode 100644 tests/xfs/999.out
> 
> diff --git a/tests/xfs/999 b/tests/xfs/999
> new file mode 100755
> index 00000000..c93ed770
> --- /dev/null
> +++ b/tests/xfs/999
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 RedHat All Rights Reserved.
> +#
> +# FS QA Test 999
> +#
> +# Testcase for kernel commit:
> +#   50d25484bebe xfs: sync lazy sb accounting on quiesce of read-only mounts
> +#
> +# After shutdown and readonly mount, a following read-write mount would
> +# get wrong number of available blocks. This is caused by unmounting the log
> +# on a readonly filesystem doesn't log the sb counters.
> +#
> +. ./common/preamble
> +_begin_fstest shutdown auto quick
> +
> +# real QA test starts here
> +
> +_supported_fs xfs
> +_require_scratch

Also needs
_require_scratch_shutdown

> +
> +_scratch_mkfs > $seqres.full 2>&1
> +mount $SCRATCH_DEV $SCRATCH_MNT

_scratch_mount?

> +_xfs_force_bdev data $SCRATCH_MNT
> +
> +# Write test file
> +ls > $SCRATCH_MNT/testfile
> +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +# Shutdown
> +$XFS_IO_PROG -x -c "shutdown -f" $SCRATCH_MNT
> +
> +# Mount ReadOnly
> +_scratch_unmount
> +_scratch_mount -oro
> +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
> +# Umount and mount rw
> +_scratch_unmount
> +_scratch_mount
> +
> +# Get fdblocks before repair
> +fdb1=$($DF_PROG $SCRATCH_MNT | tail -1 | $AWK_PROG '{print $4}')

fdb1=$(_get_available_space $SCRATCH_MNT) ?

> +_scratch_unmount
> +
> +# Repair
> +_repair_scratch_fs >> $seqres.full 2>&1
> +
> +# Re-mount
> +_scratch_mount
> +
> +# Get fdblocks after repair
> +fdb2=$($DF_PROG $SCRATCH_MNT | tail -1 | $AWK_PROG '{print $4}')

Here too.

With those bits fixed, I think this is in good shape for:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
> +echo fdb1 $fdb1 fdb2 $fdb2 >> $seqres.full 2>&1
> +
> +[ $fdb1 -ne $fdb2 ] && echo Wrong fdblocks: $fdb1 and $fdb2
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/xfs/999.out b/tests/xfs/999.out
> new file mode 100644
> index 00000000..3b276ca8
> --- /dev/null
> +++ b/tests/xfs/999.out
> @@ -0,0 +1,2 @@
> +QA output created by 999
> +Silence is golden
> -- 
> 2.20.1
> 
