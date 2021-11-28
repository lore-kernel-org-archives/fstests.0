Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30667C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Nov 2021 15:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358013AbhK1PTE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Nov 2021 10:19:04 -0500
Received: from out20-1.mail.aliyun.com ([115.124.20.1]:44553 "EHLO
        out20-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358015AbhK1PRE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Nov 2021 10:17:04 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0743744|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0484499-0.00328946-0.948261;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.M-gc1lN_1638112426;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.M-gc1lN_1638112426)
          by smtp.aliyun-inc.com(10.147.42.241);
          Sun, 28 Nov 2021 23:13:46 +0800
Date:   Sun, 28 Nov 2021 23:13:46 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4: test for illegal memory access caused by quota
 index information error
Message-ID: <YaOcqudzWtouGZro@desktop>
References: <20211125080036.2211159-1-sunke32@huawei.com>
 <YaOY/GaQzMdCfrrR@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaOY/GaQzMdCfrrR@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Nov 28, 2021 at 10:58:04PM +0800, Eryu Guan wrote:
> On Thu, Nov 25, 2021 at 04:00:36PM +0800, Sun Ke wrote:
> > The quota index information in the image is tampered, causing illegal
> > memory access.
> > It is a regression test for Kernel commit 9bf3d2033129 quota: check block
> > number when reading the block in quota file and commit d0e36a62bd4c
> > quota: correct error number in free_dqentry().
> > 
> > Signed-off-by: Sun Ke <sunke32@huawei.com>
> > ---
> >  tests/ext4/054     | 36 ++++++++++++++++++++++++++++++++++++
> >  tests/ext4/054.out |  1 +
> >  2 files changed, 37 insertions(+)
> >  create mode 100755 tests/ext4/054
> >  create mode 100644 tests/ext4/054.out
> > 
> > diff --git a/tests/ext4/054 b/tests/ext4/054
> > new file mode 100755
> > index 00000000..286b5ecb
> > --- /dev/null
> > +++ b/tests/ext4/054
> > @@ -0,0 +1,36 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Huawei.  All Rights Reserved.
> > +#
> > +# FS QA Test 054
> > +#
> > +# Regression test for kernel
> > +# commit 9bf3d2033129 quota: check block number when reading the block in quota file
> > +# commit d0e36a62bd4c quota: correct error number in free_dqentry()
> 
> Better to describe the test in test description as well, e.g. what's the
> bug and summarise how we're going to test it.
> 
> > +#
> > +# The test is based on a testcase from Zhang Yi <yi.zhang@huawei.com>.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto
> 
> In 'quota' group as well
> 
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_require_scratch
> > +_supported_fs ext4
> > +_require_user fsgqa
> > +_require_user fsgqa2
> 
> _require_command "$DEBUGFS_PROG" debugfs
> 
> and use $DEBUGFS_PRG in the test.
> 
> > +
> > +_scratch_mkfs "-F -O quota -b 1024" > $seqres.full 2>&1
> 
> Is 1k block size a required condition to reproduce the bug? Or the
> following debugfs command requires 1k fs?
> 
> > +debugfs -w -R "zap_block -o 0 -l 1 -p 6 -f <3> 1" $SCRATCH_DEV >> $seqres.full 2>&1

Also, this corrupts the filesystem, and post-test fsck complains fs
corruption.

We need _require_scratch_nocheck instead of _require_scratch

Thanks,
Eryu

> 
> Some comments are welcomed to describe the detailed test steps, e.g.
> explain what's the purpose of this debugfs command.
> 
> > +_scratch_mount >> $seqres.full 2>&1
> > +chown fsgqa:fsgqa $SCRATCH_MNT >> $seqres.full 2>&1
> > +touch $SCRATCH_MNT/foo >> $seqres.full 2>&1
> > +rm -f $SCRATCH_MNT/foo
> > +chown fsgqa2:fsgqa2 $SCRATCH_MNT >> $seqres.full 2>&1
> 
> And why we need to chown fsgqa:fsgqa first and rm the file and chown to
> fsgqa2 later.
> 
> > +
> > +umount $SCRATCH_MNT
> 
> Is this required to trigger the bug? If not, this could be removed,
> SCRATCH_DEV will be umounted after each test.
> 
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/ext4/054.out b/tests/ext4/054.out
> > new file mode 100644
> > index 00000000..03e258bb
> > --- /dev/null
> > +++ b/tests/ext4/054.out
> > @@ -0,0 +1 @@
> > +QA output created by 054
> 
> Need "Silence is golden" to indicate this test doesn't print any output.
> 
> Thanks,
> Eryu
> 
> > -- 
> > 2.13.6
