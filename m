Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21391C4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 05:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E346D6124B
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 05:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhHXFnV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 01:43:21 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:57455 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229885AbhHXFnU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Aug 2021 01:43:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UlThjnF_1629783742;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UlThjnF_1629783742)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Aug 2021 13:42:22 +0800
Date:   Tue, 24 Aug 2021 13:42:22 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        ddouwsma@redhat.com
Subject: Re: [PATCH v3] tests/xfs: check available blocks after log recovery
 on ro mount
Message-ID: <20210824054222.GR60846@e18g06458.et15sqa>
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
 <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 24, 2021 at 01:04:36PM +0800, Murphy Zhou wrote:
> And followed by a rw mount.
> 
> Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
> 
> Thanks Darrick very much for reviewing!
> 
> v2:
>    Add explaination of the issue
>    add xfs_force_bdev data $SCRATCH_MNT
>    use DF_PROG
>    Re numbered this test
> v3:
>    Add _require_scratch_shutdown
>    Use _get_available_space
>    Explain why does not use _scratch_mount
> 
>  tests/xfs/999     | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/999.out |  2 ++
>  2 files changed, 67 insertions(+)
>  create mode 100755 tests/xfs/999
>  create mode 100644 tests/xfs/999.out
> 
> diff --git a/tests/xfs/999 b/tests/xfs/999
> new file mode 100755
> index 00000000..0ce9989b
> --- /dev/null
> +++ b/tests/xfs/999
> @@ -0,0 +1,65 @@
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

Is this also a 'recoveryloop' test that excrises shutdown & log
recovery?

> +
> +# real QA test starts here
> +
> +_supported_fs xfs
> +_require_scratch
> +_require_scratch_shutdown
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +# Don't use _scratch_mount because we need to mount without SELinux context
> +# to reproduce this issue. If we mount with SELinux context, this testcase
> +# is not reproducing the original issue.
> +mount $SCRATCH_DEV $SCRATCH_MNT

$MOUNT_PROG

> +_xfs_force_bdev data $SCRATCH_MNT
> +
> +# Write test file
> +ls > $SCRATCH_MNT/testfile

I'd like write something into file explicitly, the output of ls command
may change in subtle way, e.g. iif we decide to run fstests with an
empty dir as $PWD in the future, then we write nothing into the file.

> +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +# Shutdown
> +$XFS_IO_PROG -x -c "shutdown -f" $SCRATCH_MNT

Does '_scratch_shutdown -f' work here?

> +
> +# Mount ReadOnly
> +_scratch_unmount
> +_scratch_mount -oro

_scratch_cycle_mount ro

> +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
> +# Umount and mount rw
> +_scratch_unmount
> +_scratch_mount

_scratch_cycle_mount

> +
> +# Get fdblocks before repair
> +fdb1=$(_get_available_space $SCRATCH_MNT)
> +_scratch_unmount
> +
> +# Repair

I find these "Mount ReadOnly" "Umount and mount rw" "Repair" comments
don't really help, they just describe what we're doing (which are
obvious in this test) not why we're doing it. It's better to describe
the reason of doing this repair.

Thanks,
Eryu

> +_repair_scratch_fs >> $seqres.full 2>&1
> +
> +# Re-mount
> +_scratch_mount
> +
> +# Get fdblocks after repair
> +fdb2=$(_get_available_space $SCRATCH_MNT)
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
