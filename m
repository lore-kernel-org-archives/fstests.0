Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02B3C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 07:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiEXHeS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 03:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiEXHeQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 03:34:16 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44ABF65D3B
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 00:34:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 84CD210E6AFA
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 17:34:14 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-00FkVO-IN
        for fstests@vger.kernel.org; Tue, 24 May 2022 17:34:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-008A6A-HC
        for fstests@vger.kernel.org;
        Tue, 24 May 2022 17:34:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 6/8] fstests: consolidate no cleanup test setup
Date:   Tue, 24 May 2022 17:34:09 +1000
Message-Id: <20220524073411.1943480-7-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524073411.1943480-1-david@fromorbit.com>
References: <20220524073411.1943480-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=628c8a76
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=O0-bKGfrwHk_oJ93W7MA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Many of the XFS fuzzer tests define a "no cleanup" cleanup function.
Consolidate this in common/preamble and deduplicate all the tests
using this setup.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/preamble | 9 +++++++++
 tests/xfs/083   | 5 -----
 tests/xfs/085   | 5 -----
 tests/xfs/086   | 5 -----
 tests/xfs/087   | 5 -----
 tests/xfs/088   | 5 -----
 tests/xfs/089   | 5 -----
 tests/xfs/091   | 5 -----
 tests/xfs/093   | 5 -----
 tests/xfs/097   | 5 -----
 tests/xfs/098   | 5 -----
 tests/xfs/099   | 5 -----
 tests/xfs/100   | 5 -----
 tests/xfs/101   | 5 -----
 tests/xfs/102   | 5 -----
 tests/xfs/105   | 5 -----
 tests/xfs/112   | 5 -----
 tests/xfs/113   | 5 -----
 tests/xfs/117   | 5 -----
 tests/xfs/120   | 5 -----
 tests/xfs/123   | 5 -----
 tests/xfs/124   | 5 -----
 tests/xfs/125   | 5 -----
 tests/xfs/126   | 5 -----
 tests/xfs/130   | 5 -----
 25 files changed, 9 insertions(+), 120 deletions(-)

diff --git a/common/preamble b/common/preamble
index 0e8827c3..99e60a40 100644
--- a/common/preamble
+++ b/common/preamble
@@ -13,6 +13,15 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
+# Cleanup function for tests that want to leave a warm corpse behind for
+# debugging purposes. This should really only be used on tests that are designed
+# to fail (e.g. fuzzer tests) and not on tests that should always pass in normal
+# circumstances.
+_no_cleanup()
+{
+	cd /
+}
+
 # Standard cleanup function for tests using fsstress. THese tests all need to
 # kill fsstress processes when unexpectedly killed, and wait for them to finish.
 # Those tests can either register this function directly or call it from their
diff --git a/tests/xfs/083 b/tests/xfs/083
index 7666d204..a817c71f 100755
--- a/tests/xfs/083
+++ b/tests/xfs/083
@@ -10,11 +10,6 @@
 #
 . ./common/preamble
 _begin_fstest dangerous_fuzzers punch
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/085 b/tests/xfs/085
index 8aa8f2a0..6d171f5a 100755
--- a/tests/xfs/085
+++ b/tests/xfs/085
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/086 b/tests/xfs/086
index 031cb445..d0e26381 100755
--- a/tests/xfs/086
+++ b/tests/xfs/086
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/087 b/tests/xfs/087
index 9d1f59f0..bca4fdd0 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/088 b/tests/xfs/088
index de824223..b3743151 100755
--- a/tests/xfs/088
+++ b/tests/xfs/088
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/089 b/tests/xfs/089
index dae2d0d0..5567c3f0 100755
--- a/tests/xfs/089
+++ b/tests/xfs/089
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/091 b/tests/xfs/091
index c5db3337..8cda3146 100755
--- a/tests/xfs/091
+++ b/tests/xfs/091
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/093 b/tests/xfs/093
index 9fe1799a..a4308881 100755
--- a/tests/xfs/093
+++ b/tests/xfs/093
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/097 b/tests/xfs/097
index d66df458..8cdf7ce2 100755
--- a/tests/xfs/097
+++ b/tests/xfs/097
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/098 b/tests/xfs/098
index 21215ee5..7d2c5b8a 100755
--- a/tests/xfs/098
+++ b/tests/xfs/098
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/099 b/tests/xfs/099
index 2791e2df..a59022b6 100755
--- a/tests/xfs/099
+++ b/tests/xfs/099
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/100 b/tests/xfs/100
index e71e760e..6f3c36c5 100755
--- a/tests/xfs/100
+++ b/tests/xfs/100
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/101 b/tests/xfs/101
index 1cbcc973..437ba63f 100755
--- a/tests/xfs/101
+++ b/tests/xfs/101
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/102 b/tests/xfs/102
index 0ce3588a..b75883f6 100755
--- a/tests/xfs/102
+++ b/tests/xfs/102
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/105 b/tests/xfs/105
index 8a583da5..66c59c23 100755
--- a/tests/xfs/105
+++ b/tests/xfs/105
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/112 b/tests/xfs/112
index 4362f31c..b3fcf12f 100755
--- a/tests/xfs/112
+++ b/tests/xfs/112
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/113 b/tests/xfs/113
index e3f4fd4d..9d18532f 100755
--- a/tests/xfs/113
+++ b/tests/xfs/113
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/117 b/tests/xfs/117
index 4962c201..c8d1635d 100755
--- a/tests/xfs/117
+++ b/tests/xfs/117
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/120 b/tests/xfs/120
index 653948ee..e427b0c3 100755
--- a/tests/xfs/120
+++ b/tests/xfs/120
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/123 b/tests/xfs/123
index e191623a..48c8dd08 100755
--- a/tests/xfs/123
+++ b/tests/xfs/123
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/124 b/tests/xfs/124
index af738212..e9b04a17 100755
--- a/tests/xfs/124
+++ b/tests/xfs/124
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/125 b/tests/xfs/125
index a7280e2c..f5d28ef3 100755
--- a/tests/xfs/125
+++ b/tests/xfs/125
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/126 b/tests/xfs/126
index 55a12178..88d99227 100755
--- a/tests/xfs/126
+++ b/tests/xfs/126
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
diff --git a/tests/xfs/130 b/tests/xfs/130
index e7a0e6e3..c48858ea 100755
--- a/tests/xfs/130
+++ b/tests/xfs/130
@@ -9,11 +9,6 @@
 #
 . ./common/preamble
 _begin_fstest fuzzers clone
-
-_no_cleanup()
-{
-	cd /
-}
 _register_cleanup _no_cleanup
 
 # Import common functions.
-- 
2.35.1

