Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A58C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 01:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbiETBXm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 21:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiETBXl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 21:23:41 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80F8727CC7
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 18:23:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9163A10E6838
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 11:23:39 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nrrMf-00E40U-Rm
        for fstests@vger.kernel.org; Fri, 20 May 2022 11:23:37 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nrrMf-006TK7-Qi
        for fstests@vger.kernel.org;
        Fri, 20 May 2022 11:23:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/2] fstests: tests should not source common/rc directly
Date:   Fri, 20 May 2022 11:23:35 +1000
Message-Id: <20220520012336.1542637-2-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520012336.1542637-1-david@fromorbit.com>
References: <20220520012336.1542637-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6286ed9b
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=gbopmE6BPGZhA-chkOMA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

_begin_fstest() does this as every test needs it, so remove it from
all the tests that source it a second time.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/btrfs/243   | 1 -
 tests/btrfs/245   | 1 -
 tests/ext4/053    | 1 -
 tests/generic/644 | 1 -
 tests/generic/645 | 1 -
 tests/generic/647 | 1 -
 tests/generic/677 | 1 -
 tests/generic/678 | 1 -
 tests/generic/679 | 1 -
 tests/generic/690 | 1 -
 10 files changed, 10 deletions(-)

diff --git a/tests/btrfs/243 b/tests/btrfs/243
index 750b4323..09a63bcd 100755
--- a/tests/btrfs/243
+++ b/tests/btrfs/243
@@ -20,7 +20,6 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-. ./common/rc
 . ./common/filter
 . ./common/dmflakey
 
diff --git a/tests/btrfs/245 b/tests/btrfs/245
index dadc8492..426aab1c 100755
--- a/tests/btrfs/245
+++ b/tests/btrfs/245
@@ -11,7 +11,6 @@
 _begin_fstest auto quick idmapped subvol
 
 # get standard environment, filters and checks
-. ./common/rc
 . ./common/filter
 
 # real QA test starts here
diff --git a/tests/ext4/053 b/tests/ext4/053
index bf6e3f6b..187a2515 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -28,7 +28,6 @@ _cleanup()
 }
 
 # get standard environment, filters and checks
-. ./common/rc
 . ./common/filter
 . ./common/quota
 
diff --git a/tests/generic/644 b/tests/generic/644
index edf9b03e..c48338d8 100755
--- a/tests/generic/644
+++ b/tests/generic/644
@@ -10,7 +10,6 @@
 _begin_fstest auto quick cap idmapped mount
 
 # get standard environment, filters and checks
-. ./common/rc
 . ./common/filter
 
 # real QA test starts here
diff --git a/tests/generic/645 b/tests/generic/645
index 74e0f589..556d2450 100755
--- a/tests/generic/645
+++ b/tests/generic/645
@@ -10,7 +10,6 @@
 _begin_fstest auto quick idmapped mount
 
 # get standard environment, filters and checks
-. ./common/rc
 . ./common/filter
 
 # real QA test starts here
diff --git a/tests/generic/647 b/tests/generic/647
index fa6edadc..8484fa8d 100755
--- a/tests/generic/647
+++ b/tests/generic/647
@@ -18,7 +18,6 @@ _cleanup()
 }
 
 # get standard environment, filters and checks
-. ./common/rc
 . ./common/filter
 
 # real QA test starts here
diff --git a/tests/generic/677 b/tests/generic/677
index 1d4eaa53..39af90a9 100755
--- a/tests/generic/677
+++ b/tests/generic/677
@@ -18,7 +18,6 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-. ./common/rc
 . ./common/filter
 . ./common/dmflakey
 . ./common/punch
diff --git a/tests/generic/678 b/tests/generic/678
index 1c3cf6e3..3c3c05b7 100755
--- a/tests/generic/678
+++ b/tests/generic/678
@@ -22,7 +22,6 @@ _cleanup()
 }
 
 # get standard environment, filters and checks
-. ./common/rc
 . ./common/filter
 
 # real QA test starts here
diff --git a/tests/generic/679 b/tests/generic/679
index c32d42b9..a0094e48 100755
--- a/tests/generic/679
+++ b/tests/generic/679
@@ -11,7 +11,6 @@
 . ./common/preamble
 _begin_fstest auto quick prealloc
 
-. ./common/rc
 . ./common/filter
 . ./common/punch
 
diff --git a/tests/generic/690 b/tests/generic/690
index f03295a5..cef8d6e8 100755
--- a/tests/generic/690
+++ b/tests/generic/690
@@ -24,7 +24,6 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-. ./common/rc
 . ./common/filter
 . ./common/dmflakey
 
-- 
2.35.1

