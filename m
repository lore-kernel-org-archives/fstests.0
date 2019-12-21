Return-Path: <SRS0=dxnf=2L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB44FC2D0C0
	for <linux-fstests@archiver.kernel.org>; Sat, 21 Dec 2019 08:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F8D2072B
	for <linux-fstests@archiver.kernel.org>; Sat, 21 Dec 2019 08:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLUIzU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:55:20 -0500
Received: from snd00011.auone-net.jp ([111.86.247.11]:38881 "EHLO
        dmta0008.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725954AbfLUIzU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 Dec 2019 03:55:20 -0500
Received: from ppp.dion.ne.jp by dmta0008.auone-net.jp with ESMTP
          id <20191221085518708.CZTM.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>
          for <fstests@vger.kernel.org>; Sat, 21 Dec 2019 17:55:18 +0900
Date:   Sat, 21 Dec 2019 17:55:18 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/{003,120,192}: Set atime options precisely
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20191221085518708.CZTM.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make tests pass regardless of options set by MOUNT_OPTIONS.

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 common/rc         | 3 +--
 tests/generic/003 | 6 +++---
 tests/generic/120 | 2 +-
 tests/generic/192 | 1 +
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/rc b/common/rc
index 5cdd829b..e2f081c0 100644
--- a/common/rc
+++ b/common/rc
@@ -440,7 +440,7 @@ _test_cycle_mount()
 	return
     fi
     _test_unmount
-    _test_mount
+    _test_mount "$@"
 }
 
 _scratch_mkfs_options()
@@ -3392,7 +3392,6 @@ _exclude_scratch_mount_option()
 
 _require_atime()
 {
-	_exclude_scratch_mount_option "noatime"
 	case $FSTYP in
 	nfs|cifs)
 		_notrun "atime related mount options have no effect on $FSTYP"
diff --git a/tests/generic/003 b/tests/generic/003
index 767d7059..a634b1a4 100755
--- a/tests/generic/003
+++ b/tests/generic/003
@@ -66,7 +66,7 @@ _compare_stat_times() {
 }
 
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
-_scratch_mount "-o relatime"
+_scratch_mount "-o atime,nostrictatime,relatime"
 
 if [ "$FSTYP" = "btrfs" ]; then
 	TPATH=$SCRATCH_MNT/sub1
@@ -94,7 +94,7 @@ _compare_stat_times NNN "$file1_stat_after_first_access" \
 	"$file1_stat_after_second_access" "after accessing file1 second time"
 
 # Mounting with nodiratime option
-_scratch_cycle_mount "nodiratime"
+_scratch_cycle_mount "atime,nodiratime"
 file1_stat_after_remount=`_stat $TPATH/dir1/file1`
 _compare_stat_times NNN "$file1_stat_after_second_access" \
 	"$file1_stat_after_remount" "for file1 after remount"
@@ -120,7 +120,7 @@ _compare_stat_times NNN "$dir2_stat_after_file_creation" \
 	"$dir2_stat_after_file_access" "for dir2 after file access"
 
 # Mounting with noatime option, creating a file and accessing it
-_scratch_cycle_mount "noatime"
+_scratch_cycle_mount "noatime,nostrictatime"
 echo "ccc" > $TPATH/dir2/file3
 file3_stat_before_first_access=`_stat $TPATH/dir2/file3`
 sleep 1
diff --git a/tests/generic/120 b/tests/generic/120
index 48ca9508..2f86d9fc 100755
--- a/tests/generic/120
+++ b/tests/generic/120
@@ -44,7 +44,7 @@ _compare_access_times()
 
 }
 
-if ! _try_scratch_mount "-o noatime" >$tmp.out 2>&1
+if ! _try_scratch_mount "-o noatime,nostrictatime" >$tmp.out 2>&1
 then
     cat $tmp.out
     echo "!!! mount failed"
diff --git a/tests/generic/192 b/tests/generic/192
index 50b3d6fd..37197979 100755
--- a/tests/generic/192
+++ b/tests/generic/192
@@ -38,6 +38,7 @@ testfile=$TEST_DIR/testfile
 rm -f $testfile
 rm -f $seqres.full
 
+_test_cycle_mount -o atime
 echo test >$testfile
 time1=`_access_time $testfile | tee -a $seqres.full`
 
-- 
2.24.1

