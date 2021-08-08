Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B909CC4320A
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Aug 2021 14:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C9E601FC
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Aug 2021 14:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhHHOgQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Aug 2021 10:36:16 -0400
Received: from out20-74.mail.aliyun.com ([115.124.20.74]:48347 "EHLO
        out20-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhHHOgO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Aug 2021 10:36:14 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07449193|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00871739-0.000593462-0.990689;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Kx21sbr_1628433353;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Kx21sbr_1628433353)
          by smtp.aliyun-inc.com(10.147.41.199);
          Sun, 08 Aug 2021 22:35:54 +0800
Date:   Sun, 8 Aug 2021 22:35:53 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: quota state command should report upg grace times
 separately
Message-ID: <YQ/ryebsyGy7vurG@desktop>
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
> +# ugp grace times"). When give "-ugp" or "-a" options to xfs_quota state
> +# command, it should report grace times for all three types separately.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick quota

Should source ./common/quota here

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

s/_scratch_mount/_qmount/

> +
> +$XFS_QUOTA_PROG -x -c 'timer -u 5d' $SCRATCH_MNT

Should set group quota timer, as we only enable grpquota above,
otherwise we hit "xfs_quota: cannot set timer: No such process" failre
here.

I fixed all on commit.

Thanks,
Eryu

> +# xfs_quota state -ugp or -a should report times for all three types separately.
> +echo "* state -ugp:"
> +$XFS_QUOTA_PROG -x -c 'state -ugp' $SCRATCH_MNT | grep 'grace time'
> +echo "* state -a:"
> +$XFS_QUOTA_PROG -x -c 'state -a' $SCRATCH_MNT | grep 'grace time'
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
