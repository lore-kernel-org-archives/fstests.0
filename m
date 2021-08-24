Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC853C4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 15:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B8561246
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 15:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhHXPPP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235683AbhHXPPN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 24 Aug 2021 11:15:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7218761246;
        Tue, 24 Aug 2021 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629818069;
        bh=4/LpOK85hGHN2CuOr1v3T1ZLNtK0sl/+Uib4Fwonbxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nucNc0QP9vU5f2hV6mst+nGQt+DMYvwsEkNXvXtccT7RVGNFdm4VDgu+pCZjdSpse
         D8JbsDJBjDvhZ/gla+fK0a+qYIqfMFOs1xH+WJYGZn/ihUs3w6n0EDFrRMc0lvNH4w
         JyTiEmUFP7XQ0yE0MlB4OC+XQNheSNXzfFDRsU/I20iypjaG7VXtTOJ3CtZ7Tl6UuK
         wH4C9hpo3lWFPLJs2VbORFiJsZjeOxyFbqfERQoD1u3GXeLr2iq4S4d379OWLvfM9a
         gVm/9PDsJWsD0Gy9ZHsqzntdMrfVS/jWTW5NhYECvrv95d1VF4r1JzT9WsKJnTExcl
         dIJXYhs+agVJg==
Date:   Tue, 24 Aug 2021 08:14:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     fstests@vger.kernel.org, ddouwsma@redhat.com
Subject: Re: [PATCH v3] tests/xfs: check available blocks after log recovery
 on ro mount
Message-ID: <20210824151428.GG12612@magnolia>
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
 <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
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

This mount will fail if the test runner configured an external log or a
realtime device, because you didn't specify those devices to the mount
call.  Either this needs _require_nonexternal or $(_scratch_options
mount) needs to be injected into the command line.

--D

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
> +fdb1=$(_get_available_space $SCRATCH_MNT)
> +_scratch_unmount
> +
> +# Repair
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
> 
