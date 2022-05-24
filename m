Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524ACC43217
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 07:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiEXHeT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 03:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiEXHeR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 03:34:17 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B4B46A403
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 00:34:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 8B57D534571
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 17:34:14 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-00FkVL-HT
        for fstests@vger.kernel.org; Tue, 24 May 2022 17:34:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-008A66-GL
        for fstests@vger.kernel.org;
        Tue, 24 May 2022 17:34:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 5/8] fstests: use a common fsstress cleanup function
Date:   Tue, 24 May 2022 17:34:08 +1000
Message-Id: <20220524073411.1943480-6-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524073411.1943480-1-david@fromorbit.com>
References: <20220524073411.1943480-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=628c8a76
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=EUfe5sX75YO2TcIWdEcA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Lots of tests now have a common cleanup function for fsstress based
tests. Define a common cleanup function in common/preamble and
convert those tests to register it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/preamble | 11 +++++++++++
 tests/xfs/011   |  7 -------
 tests/xfs/013   |  9 +--------
 tests/xfs/051   | 11 ++---------
 tests/xfs/057   |  9 ---------
 tests/xfs/079   | 11 +----------
 tests/xfs/141   | 11 +----------
 tests/xfs/167   |  9 +--------
 tests/xfs/442   | 11 ++---------
 9 files changed, 19 insertions(+), 70 deletions(-)

diff --git a/common/preamble b/common/preamble
index 7aa55dc6..0e8827c3 100644
--- a/common/preamble
+++ b/common/preamble
@@ -13,6 +13,17 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
+# Standard cleanup function for tests using fsstress. THese tests all need to
+# kill fsstress processes when unexpectedly killed, and wait for them to finish.
+# Those tests can either register this function directly or call it from their
+# own local cleanup functions.
+_fsstress_cleanup()
+{
+	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
+	wait
+	_cleanup
+}
+
 # Install the supplied cleanup code as a signal handler for HUP, INT, QUIT,
 # TERM, or when the test exits.  Extra signals can be specified as subsequent
 # parameters.
diff --git a/tests/xfs/011 b/tests/xfs/011
index 161f263c..b9b0d138 100755
--- a/tests/xfs/011
+++ b/tests/xfs/011
@@ -10,13 +10,6 @@
 #
 . ./common/preamble
 _begin_fstest auto freeze log metadata quick
-
-_fsstress_cleanup()
-{
-	$KILLALL_PROG -9 fsstress 2>/dev/null
-	wait
-	_cleanup
-}
 _register_cleanup _fsstress_cleanup
 
 # Use the information exported by XFS to sysfs to determine whether the log has
diff --git a/tests/xfs/013 b/tests/xfs/013
index c451ded3..ce91ed62 100755
--- a/tests/xfs/013
+++ b/tests/xfs/013
@@ -12,18 +12,11 @@
 #
 . ./common/preamble
 _begin_fstest auto metadata stress
+_register_cleanup _fsstress_cleanup
 
 # Import common functions.
 . ./common/filter
 
-_fsstress_cleanup()
-{
-	$KILLALL_PROG -9 fsstress 2>/dev/null
-	wait
-	_cleanup
-}
-_register_cleanup _fsstress_cleanup
-
 filter_enospc() {
 	sed -e '/^.*No space left on device.*/d'
 }
diff --git a/tests/xfs/051 b/tests/xfs/051
index 4718099d..e2e0e7f2 100755
--- a/tests/xfs/051
+++ b/tests/xfs/051
@@ -10,19 +10,12 @@
 #
 . ./common/preamble
 _begin_fstest shutdown auto log metadata
-
-_fsstress_cleanup()
-{
-	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
-	wait
-	_cleanup
-}
-_register_cleanup fsstress_cleanup
+_register_cleanup _fsstress_cleanup
 
 # Import common functions.
 . ./common/dmflakey
 
-# Modify as appropriate.
+# real QA test starts here
 _supported_fs xfs
 
 _require_scratch
diff --git a/tests/xfs/057 b/tests/xfs/057
index 983479ab..432c4836 100755
--- a/tests/xfs/057
+++ b/tests/xfs/057
@@ -23,13 +23,6 @@
 . ./common/preamble
 _begin_fstest auto log recoveryloop
 
-_fsstress_cleanup()
-{
-	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
-	wait
-	_cleanup
-}
-
 local_cleanup()
 {
 	[ -e /sys/fs/xfs/$sdev/errortag/log_item_pin ] &&
@@ -42,8 +35,6 @@ _register_cleanup local_cleanup
 . ./common/inject
 
 # real QA test starts here
-
-# Modify as appropriate.
 _supported_fs xfs
 _require_xfs_io_error_injection log_item_pin
 _require_xfs_io_error_injection log_bad_crc
diff --git a/tests/xfs/079 b/tests/xfs/079
index fc30181b..d49b699c 100755
--- a/tests/xfs/079
+++ b/tests/xfs/079
@@ -16,21 +16,12 @@
 #
 . ./common/preamble
 _begin_fstest shutdown auto log quick
-
-_fsstress_cleanup()
-{
-	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
-	wait
-	_cleanup
-}
-_register_cleanup fsstress_cleanup
+_register_cleanup _fsstress_cleanup
 
 # Import common functions.
 . ./common/log
 
 # real QA test starts here
-
-# Modify as appropriate.
 _supported_fs xfs
 _require_scratch
 _require_v2log
diff --git a/tests/xfs/141 b/tests/xfs/141
index 0b0cac81..18a00058 100755
--- a/tests/xfs/141
+++ b/tests/xfs/141
@@ -13,21 +13,12 @@
 #
 . ./common/preamble
 _begin_fstest auto log metadata
-
-_fsstress_cleanup()
-{
-	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
-	wait
-	_cleanup
-}
-_register_cleanup fsstress_cleanup
+_register_cleanup _fsstress_cleanup
 
 # Import common functions.
 . ./common/inject
 
 # real QA test starts here
-
-# Modify as appropriate.
 _supported_fs xfs
 _require_xfs_io_error_injection "log_bad_crc"
 _require_scratch
diff --git a/tests/xfs/167 b/tests/xfs/167
index 50d3c41b..d7b5f378 100755
--- a/tests/xfs/167
+++ b/tests/xfs/167
@@ -8,14 +8,7 @@
 #
 . ./common/preamble
 _begin_fstest rw metadata auto stress
-
-_fsstress_cleanup()
-{
-	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
-	wait
-	_cleanup
-}
-_register_cleanup fsstress_cleanup
+_register_cleanup _fsstress_cleanup
 
 workout()
 {
diff --git a/tests/xfs/442 b/tests/xfs/442
index a4a76ce2..dcec4685 100755
--- a/tests/xfs/442
+++ b/tests/xfs/442
@@ -11,21 +11,14 @@
 #
 . ./common/preamble
 _begin_fstest auto stress clone quota
-
-_fsstress_cleanup()
-{
-	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
-	wait
-	_cleanup
-}
-_register_cleanup fsstress_cleanup
+_register_cleanup _fsstress_cleanup
 
 # Import common functions.
 . ./common/quota
 . ./common/filter
 . ./common/reflink
 
-# Modify as appropriate.
+# real QA test starts here
 _supported_fs xfs
 
 _require_scratch_reflink
-- 
2.35.1

