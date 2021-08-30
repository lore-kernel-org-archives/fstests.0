Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1908EC432BE
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Aug 2021 01:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA34D60F51
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Aug 2021 01:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhH3BOV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 Aug 2021 21:14:21 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:37737 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231401AbhH3BOU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Aug 2021 21:14:20 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 4C3321B804C
        for <fstests@vger.kernel.org>; Mon, 30 Aug 2021 11:13:26 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mKVrY-006W6m-Kp
        for fstests@vger.kernel.org; Mon, 30 Aug 2021 11:13:24 +1000
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1mKVrY-002vKR-Bp
        for fstests@vger.kernel.org; Mon, 30 Aug 2021 11:13:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/081: clean up snapshot devices correctly
Date:   Mon, 30 Aug 2021 11:13:24 +1000
Message-Id: <20210830011324.696984-1-david@fromorbit.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=MhDmnRu9jo8A:10 a=20KFwNOVAAAA:8 a=Zq6-yMx5sEe1Ta2TF9kA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

I recently updated the userspace on a DAX-capable test VM, and no
g/081 fails to release the SCRATCH_DEV correctly. g/081 fails on dax
capable devices because DM rejects one of the setup operations:

The 081.full output file shows setup failure and then snapshot
creation failure:

  Wiping xfs signature on /dev/pmem1.
  Physical volume "/dev/pmem1" successfully created.
  Volume group "vg_081" successfully created
  Logical volume "base_081" created.
  device-mapper: reload ioctl on  (251:0) failed: Invalid argument
  Failed to suspend logical volume vg_081/base_081.
  Device vg_081-base_081-real (251:1) is used by another device.
  Failed to revert logical volume vg_081/base_081.
  Aborting. Manual intervention required.
Failed to create snapshot
.....

And dmesg tells us the reload ioctl failed because:

[ 2977.522306] device-mapper: ioctl: can't change device type (old=3 vs new=1) after initial table load.

DM table types are:

enum dm_queue_mode {
        DM_TYPE_NONE             = 0,
        DM_TYPE_BIO_BASED        = 1,
        DM_TYPE_REQUEST_BASED    = 2,
        DM_TYPE_DAX_BIO_BASED    = 3,
};

which indicates that the original table is DAX_BIO based (correct,
this is a pmem device) but then one of the setup operations is for
a type that is not DAX capable. Hence it fails and then things go
bad.

But the test has actually created the snapshot device and it's COW
target, so now when the _cleanup() function is called, the vgremove
command fails because the VG is busy (still has snapshot devices
attached to it) and at this point $SCRATCH_DEV is now unusable
without manual cleanup.

Manual cleanup just needs to remove the snapshot and logical base
volumes before trying to remove the vg and pv.  With this change, we
now see the teardown do:

....
Failed to create snapshot
umount: /mnt/test/mnt_081: not mounted.
  Logical volume "snap_081" successfully removed
  Logical volume "base_081" successfully removed
  Volume group "vg_081" successfully removed
  Labels on physical volume "/dev/pmem1" successfully wiped.

And future tests are able to use the SCRATCH_DEV normally.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/081 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/081 b/tests/generic/081
index 8e552074..9f294c11 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -33,6 +33,8 @@ _cleanup()
 	while test -e /dev/mapper/$vgname-$snapname || \
 	      test -e /dev/mapper/$vgname-$lvname; do
 		$UMOUNT_PROG $mnt >> $seqres.full 2>&1
+		$LVM_PROG lvremove -f $vgname/$snapname >>$seqres.full 2>&1
+		$LVM_PROG lvremove -f $vgname/$lvname >>$seqres.full 2>&1
 		$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
 		$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
 		pv_ret=$?
-- 
2.31.1

