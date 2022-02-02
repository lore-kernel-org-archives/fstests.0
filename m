Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530D0C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Feb 2022 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiBBHie (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:38:34 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:58740 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbiBBHie (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Feb 2022 02:38:34 -0500
Received: from dread.disaster.area (pa49-180-69-7.pa.nsw.optusnet.com.au [49.180.69.7])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 71F7E62C033
        for <fstests@vger.kernel.org>; Wed,  2 Feb 2022 18:38:32 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nFADn-00774h-7H
        for fstests@vger.kernel.org; Wed, 02 Feb 2022 18:38:31 +1100
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nFADn-003aBI-3h
        for fstests@vger.kernel.org;
        Wed, 02 Feb 2022 18:38:31 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] fstest: add more tests to the metadump group
Date:   Wed,  2 Feb 2022 18:38:31 +1100
Message-Id: <20220202073831.854055-1-david@fromorbit.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61fa34f8
        a=NB+Ng1P8A7U24Uo7qoRq4Q==:117 a=NB+Ng1P8A7U24Uo7qoRq4Q==:17
        a=oGFeUVbbRNcA:10 a=20KFwNOVAAAA:8 a=wopq05uW3E7KPXx9n6wA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Because they use metadump and I want to test metadump more easily.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/129 | 2 +-
 tests/xfs/234 | 2 +-
 tests/xfs/253 | 2 +-
 tests/xfs/284 | 2 +-
 tests/xfs/291 | 2 +-
 tests/xfs/336 | 2 +-
 tests/xfs/432 | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/xfs/129 b/tests/xfs/129
index df977552..90887d54 100755
--- a/tests/xfs/129
+++ b/tests/xfs/129
@@ -9,7 +9,7 @@
 # said block.
 #
 . ./common/preamble
-_begin_fstest auto quick clone
+_begin_fstest auto quick clone metadump
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/234 b/tests/xfs/234
index a61681ab..6ff2f228 100755
--- a/tests/xfs/234
+++ b/tests/xfs/234
@@ -9,7 +9,7 @@
 # said block.
 #
 . ./common/preamble
-_begin_fstest auto quick rmap punch
+_begin_fstest auto quick rmap punch metadump
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/253 b/tests/xfs/253
index a96a2c17..1899ce52 100755
--- a/tests/xfs/253
+++ b/tests/xfs/253
@@ -18,7 +18,7 @@
 # that is already in use (and no other name is available to use).
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick metadump
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/284 b/tests/xfs/284
index 9d75bcec..fa7bfdd0 100755
--- a/tests/xfs/284
+++ b/tests/xfs/284
@@ -8,7 +8,7 @@
 # on mounted XFS to make sure they refuse to proceed.
 #
 . ./common/preamble
-_begin_fstest auto quick dump copy db mkfs repair
+_begin_fstest auto quick dump copy db mkfs repair metadump
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/291 b/tests/xfs/291
index bbc6f2b9..6d5e247e 100755
--- a/tests/xfs/291
+++ b/tests/xfs/291
@@ -7,7 +7,7 @@
 # Test xfs_repair on fragmented multi-block dir2 fs
 #
 . ./common/preamble
-_begin_fstest auto repair
+_begin_fstest auto repair metadump
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/336 b/tests/xfs/336
index 279830b5..6592419d 100755
--- a/tests/xfs/336
+++ b/tests/xfs/336
@@ -7,7 +7,7 @@
 # Exercise metadump on realtime rmapbt preservation.
 #
 . ./common/preamble
-_begin_fstest auto rmap realtime
+_begin_fstest auto rmap realtime metadump
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/432 b/tests/xfs/432
index 40cb2474..86012f0b 100755
--- a/tests/xfs/432
+++ b/tests/xfs/432
@@ -14,7 +14,7 @@
 # threshold to 2^21 blocks, make sure we never do that again.
 #
 . ./common/preamble
-_begin_fstest auto quick dir metadata
+_begin_fstest auto quick dir metadata metadump
 
 # Override the default cleanup function.
 _cleanup()
-- 
2.33.0

