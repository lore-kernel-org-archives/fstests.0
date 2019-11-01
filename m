Return-Path: <SRS0=OCqJ=YZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A02C47E49
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Nov 2019 11:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D63A217D9
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Nov 2019 11:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfKALAz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:00:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:57684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbfKALAz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 1 Nov 2019 07:00:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87E10B344
        for <fstests@vger.kernel.org>; Fri,  1 Nov 2019 11:00:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 436121E4849; Fri,  1 Nov 2019 12:00:53 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] generic/235: Fix false failure on ext2
Date:   Fri,  1 Nov 2019 12:00:46 +0100
Message-Id: <20191101110046.24994-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191101110046.24994-1-jack@suse.cz>
References: <20191101110046.24994-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test gives false failure on ext2 filesystem as 64k file already has
indirect block and so space usage does not exactly match expectation.
The test really needs to verify only whether quota accounting got
reenabled so just test using creating another empty file which is not
prone to these problems.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/235     | 5 +++--
 tests/generic/235.out | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/generic/235 b/tests/generic/235
index 6adc803c04b7..01db4711a0ec 100755
--- a/tests/generic/235
+++ b/tests/generic/235
@@ -55,8 +55,9 @@ _try_scratch_mount "-o remount,ro" 2>&1 | tee -a $seqres.full | _filter_scratch
 touch $SCRATCH_MNT/failed 2>&1 | tee -a $seqres.full | _filter_scratch
 _try_scratch_mount "-o remount,rw" 2>&1 | tee -a $seqres.full | _filter_scratch
 
-$XFS_IO_PROG -c 'pwrite 0 64k' -c 'fsync' \
-			$SCRATCH_MNT/testfile >>$seqres.full 2>&1
+touch $SCRATCH_MNT/testfile2
+chown $qa_user:$qa_user $SCRATCH_MNT/testfile2
+
 do_repquota
 
 _scratch_unmount 2>/dev/null
diff --git a/tests/generic/235.out b/tests/generic/235.out
index abcb47a69d06..87b16e0acf6d 100644
--- a/tests/generic/235.out
+++ b/tests/generic/235.out
@@ -17,10 +17,10 @@ Block grace time: 7days; Inode grace time: 7days
                         Block limits                File limits
 User            used    soft    hard  grace    used  soft  hard  grace
 ----------------------------------------------------------------------
-fsgqa     --      64       0       0              1     0     0       
+fsgqa     --       0       0       0              2     0     0       
 *** Report for group quotas on device SCRATCH_DEV
 Block grace time: 7days; Inode grace time: 7days
                         Block limits                File limits
 Group           used    soft    hard  grace    used  soft  hard  grace
 ----------------------------------------------------------------------
-fsgqa     --      64       0       0              1     0     0       
+fsgqa     --       0       0       0              2     0     0       
-- 
2.16.4

