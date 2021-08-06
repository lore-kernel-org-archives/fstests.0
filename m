Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE25C4338F
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Aug 2021 18:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C8A61159
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Aug 2021 18:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhHFS71 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233111AbhHFS71 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 6 Aug 2021 14:59:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B1C960EE9;
        Fri,  6 Aug 2021 18:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628276351;
        bh=LRWFieUXNa+lIkNJdPpNh5/6wNc9ewc2rrvGB9J7SMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtKx9hiZLqSPKpfuEWxIR/HFiiQ/Taz9zYiL2GKreNUqQWK4ryOVWe6R7nq9VqBbD
         b6r+uB3sPKmD3rlYaGa7ZYeM4QE0cIW/AdcKv+Zi4HQjVmT37UZCRjbiN6YO9RrYXx
         0fppy82ZFhcl6nlyMEMMCpzMZ+nQBZbZ8cktLR4sWlOXpuu8VnxeolN279gtXZUugf
         Z9MIy51xFqxpwXngrHvGZiMkpToU/2xfMK4kLkbY1mBmc3ggCR5Fzl8gWZWatduEdb
         AL38dzFuyz/rc51CW6HqG5nGktwpGsMFJoFLz5kNDcKA8fPV0Xj3pELlmvAWt7G5NJ
         O8iFEUPxUW3YA==
Date:   Fri, 6 Aug 2021 11:59:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: quota state command should report upg grace times
 separately
Message-ID: <20210806185910.GF3601425@magnolia>
References: <20210806051012.1640342-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806051012.1640342-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 06, 2021 at 01:10:12PM +0800, Zorro Lang wrote:
> Regression test for d8a94546 ("xfs_quota: state command should report
> ugp grace times"). When give "-ugp" or "-a" options to xfs_quota
> state command, it should report grace times for all three types
> separately.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/xfs/175     | 33 +++++++++++++++++++++++++++++++++
>  tests/xfs/175.out | 21 +++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100755 tests/xfs/175
>  create mode 100644 tests/xfs/175.out
> 
> diff --git a/tests/xfs/175 b/tests/xfs/175
> new file mode 100755
> index 00000000..0b7d81ec
> --- /dev/null
> +++ b/tests/xfs/175
> @@ -0,0 +1,33 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 175
> +#
> +# Regression test for d8a94546 ("xfs_quota: state command should report

Might be worth saying explicitly that this is an xfsprogs commit.

> +# ugp grace times"). When give "-ugp" or "-a" options to xfs_quota state
> +# command, it should report grace times for all three types separately.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick quota
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_require_scratch
> +_require_quota
> +
> +# Format filesystem and set up quota limits
> +_scratch_mkfs > $seqres.full
> +_qmount_option "grpquota"
> +_scratch_mount >> $seqres.full
> +
> +$XFS_QUOTA_PROG -x -c 'timer -u 5d' $SCRATCH_MNT
> +# xfs_quota state -ugp or -a should report times for all three types separately.
> +echo "* state -ugp:"
> +$XFS_QUOTA_PROG -x -c 'state -ugp' $SCRATCH_MNT | grep 'grace time'
> +echo "* state -a:"
> +$XFS_QUOTA_PROG -x -c 'state -a' $SCRATCH_MNT | grep 'grace time'

Logic looks fine to me.

With the comment fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/175.out b/tests/xfs/175.out
> new file mode 100644
> index 00000000..83247e21
> --- /dev/null
> +++ b/tests/xfs/175.out
> @@ -0,0 +1,21 @@
> +QA output created by 175
> +* state -ugp:
> +Blocks grace time: [--------]
> +Inodes grace time: [--------]
> +Realtime Blocks grace time: [--------]
> +Blocks grace time: [5 days]
> +Inodes grace time: [5 days]
> +Realtime Blocks grace time: [5 days]
> +Blocks grace time: [--------]
> +Inodes grace time: [--------]
> +Realtime Blocks grace time: [--------]
> +* state -a:
> +Blocks grace time: [--------]
> +Inodes grace time: [--------]
> +Realtime Blocks grace time: [--------]
> +Blocks grace time: [5 days]
> +Inodes grace time: [5 days]
> +Realtime Blocks grace time: [5 days]
> +Blocks grace time: [--------]
> +Inodes grace time: [--------]
> +Realtime Blocks grace time: [--------]
> -- 
> 2.31.1
> 
