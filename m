Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789E5C07E99
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Jul 2021 06:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4DC61445
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Jul 2021 06:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhGIGNP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 9 Jul 2021 02:13:15 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:35682 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhGIGNO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Jul 2021 02:13:14 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 868238636D6
        for <fstests@vger.kernel.org>; Fri,  9 Jul 2021 16:10:29 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m1jiW-004RXn-8t
        for fstests@vger.kernel.org; Fri, 09 Jul 2021 16:10:28 +1000
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1m1jiV-009Zpa-V9
        for fstests@vger.kernel.org; Fri, 09 Jul 2021 16:10:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/459: catch mount failure
Date:   Fri,  9 Jul 2021 16:10:27 +1000
Message-Id: <20210709061027.2282643-1-david@fromorbit.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=e_q4qTt1xDgA:10 a=20KFwNOVAAAA:8 a=VbFXYVN_0NirtrzGDcEA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Because if we don't, we freeze the root filesystem instead of
$SCRATCH_MNT and it all goes downhill from there.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/459 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/generic/459 b/tests/generic/459
index 7fd7a6fa..e5e5e9ab 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -77,7 +77,9 @@ _mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
 $LVM_PROG lvcreate  -k n -s $vgname/$lvname \
 		    -n $snapname >>$seqres.full 2>&1
 
-_mount /dev/mapper/$vgname-$snapname $SCRATCH_MNT
+# Catch mount failure so we don't blindly go an freeze the root filesystem
+# instead of lvm volume.
+_mount /dev/mapper/$vgname-$snapname $SCRATCH_MNT || _fail "mount failed"
 
 # Consume all space available in the volume and freeze to ensure everything
 # required to make the fs consistent is flushed to disk.
-- 
2.31.1

