Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B872BC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 07:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiEXHeQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 03:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiEXHeP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 03:34:15 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F09766A418
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 00:34:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1F12C5344B9
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 17:34:14 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-00FkVV-Ki
        for fstests@vger.kernel.org; Tue, 24 May 2022 17:34:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-008A6K-J9
        for fstests@vger.kernel.org;
        Tue, 24 May 2022 17:34:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 8/8] fstests: cleanup _cleanup usage in shared
Date:   Tue, 24 May 2022 17:34:11 +1000
Message-Id: <20220524073411.1943480-9-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524073411.1943480-1-david@fromorbit.com>
References: <20220524073411.1943480-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=628c8a76
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=nPCQ-H837X0RL6WGKMIA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

To match the cleanup of tests/xfs

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/shared/002 |  7 ++++---
 tests/shared/298 | 22 +++++++++++-----------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tests/shared/002 b/tests/shared/002
index d99539c9..0a92dcc2 100755
--- a/tests/shared/002
+++ b/tests/shared/002
@@ -15,12 +15,13 @@
 . ./common/preamble
 _begin_fstest auto metadata quick log
 
-# Override the default cleanup function.
-_cleanup()
+_dmflakey_cleanup()
 {
+	_unmount_flakey
 	_cleanup_flakey
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dmflakey_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/shared/298 b/tests/shared/298
index bd52b6a0..797ac7a8 100755
--- a/tests/shared/298
+++ b/tests/shared/298
@@ -9,6 +9,17 @@
 . ./common/preamble
 _begin_fstest auto trim
 
+_loop_cleanup()
+{
+	UMOUNT_PROG $loop_dev &> /dev/null
+	_destroy_loop_device $loop_dev
+	if [ $status -eq 0 ]; then
+		rm $img_file
+	fi
+	_cleanup
+}
+_register_cleanup _loop_cleanup
+
 _supported_fs ext4 xfs btrfs
 _require_test
 _require_loop
@@ -27,17 +38,6 @@ fi
 [ "$FSTYP" = "btrfs" ] && _require_btrfs_command inspect-internal dump-super
 [ "$FSTYP" = "btrfs" ] && _require_btrfs_command inspect-internal dump-tree
 
-# Override the default cleanup function.
-_cleanup()
-{
-	$UMOUNT_PROG $loop_dev &> /dev/null
-	_destroy_loop_device $loop_dev
-	if [ $status -eq 0 ]; then
-		rm -rf $tmp
-		rm $img_file
-	fi
-}
-
 get_holes()
 {
 	# It's not a good idea to be running tools against the image file
-- 
2.35.1

