Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50659C4338F
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Aug 2021 14:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156F761028
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Aug 2021 14:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhHHOMU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Aug 2021 10:12:20 -0400
Received: from out20-51.mail.aliyun.com ([115.124.20.51]:38448 "EHLO
        out20-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhHHOMT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Aug 2021 10:12:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437668|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.156402-0.000821057-0.842777;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Kx1mh1I_1628431919;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Kx1mh1I_1628431919)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sun, 08 Aug 2021 22:11:59 +0800
Date:   Sun, 8 Aug 2021 22:11:59 +0800
From:   Eryu Guan <guan@eryu.me>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: quota state command should report upg grace times
 separately
Message-ID: <YQ/mL8E6GKMSPdWd@desktop>
References: <20210806051012.1640342-1-zlang@redhat.com>
 <20210806185910.GF3601425@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806185910.GF3601425@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 06, 2021 at 11:59:10AM -0700, Darrick J. Wong wrote:
> On Fri, Aug 06, 2021 at 01:10:12PM +0800, Zorro Lang wrote:
> > Regression test for d8a94546 ("xfs_quota: state command should report
> > ugp grace times"). When give "-ugp" or "-a" options to xfs_quota
> > state command, it should report grace times for all three types
> > separately.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/xfs/175     | 33 +++++++++++++++++++++++++++++++++
> >  tests/xfs/175.out | 21 +++++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> >  create mode 100755 tests/xfs/175
> >  create mode 100644 tests/xfs/175.out
> > 
> > diff --git a/tests/xfs/175 b/tests/xfs/175
> > new file mode 100755
> > index 00000000..0b7d81ec
> > --- /dev/null
> > +++ b/tests/xfs/175
> > @@ -0,0 +1,33 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 175
> > +#
> > +# Regression test for d8a94546 ("xfs_quota: state command should report
> 
> Might be worth saying explicitly that this is an xfsprogs commit.

I'll fix that on commit, Zorro, there's no need to resend.

> 
> > +# ugp grace times"). When give "-ugp" or "-a" options to xfs_quota state
> > +# command, it should report grace times for all three types separately.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick quota
> > +
> > +# real QA test starts here
> > +_supported_fs xfs
> > +_require_scratch
> > +_require_quota
> > +
> > +# Format filesystem and set up quota limits
> > +_scratch_mkfs > $seqres.full
> > +_qmount_option "grpquota"
> > +_scratch_mount >> $seqres.full
> > +
> > +$XFS_QUOTA_PROG -x -c 'timer -u 5d' $SCRATCH_MNT
> > +# xfs_quota state -ugp or -a should report times for all three types separately.
> > +echo "* state -ugp:"
> > +$XFS_QUOTA_PROG -x -c 'state -ugp' $SCRATCH_MNT | grep 'grace time'
> > +echo "* state -a:"
> > +$XFS_QUOTA_PROG -x -c 'state -a' $SCRATCH_MNT | grep 'grace time'
> 
> Logic looks fine to me.
> 
> With the comment fixed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks for review!

Eryu

> 
> --D
> 
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/xfs/175.out b/tests/xfs/175.out
> > new file mode 100644
> > index 00000000..83247e21
> > --- /dev/null
> > +++ b/tests/xfs/175.out
> > @@ -0,0 +1,21 @@
> > +QA output created by 175
> > +* state -ugp:
> > +Blocks grace time: [--------]
> > +Inodes grace time: [--------]
> > +Realtime Blocks grace time: [--------]
> > +Blocks grace time: [5 days]
> > +Inodes grace time: [5 days]
> > +Realtime Blocks grace time: [5 days]
> > +Blocks grace time: [--------]
> > +Inodes grace time: [--------]
> > +Realtime Blocks grace time: [--------]
> > +* state -a:
> > +Blocks grace time: [--------]
> > +Inodes grace time: [--------]
> > +Realtime Blocks grace time: [--------]
> > +Blocks grace time: [5 days]
> > +Inodes grace time: [5 days]
> > +Realtime Blocks grace time: [5 days]
> > +Blocks grace time: [--------]
> > +Inodes grace time: [--------]
> > +Realtime Blocks grace time: [--------]
> > -- 
> > 2.31.1
> > 
