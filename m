Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77FEC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 11 May 2022 08:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbiEKIUg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 May 2022 04:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbiEKIUQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 May 2022 04:20:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD882380F9
        for <fstests@vger.kernel.org>; Wed, 11 May 2022 01:20:14 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kynql6pVGzfbXC;
        Wed, 11 May 2022 16:18:59 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 16:20:12 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <zlang@redhat.com>, <guaneryu@gmail.com>, <amir73il@gmail.com>,
        <libaokun1@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [RFC v4] common: xfstests support overlay+tmpfs
Date:   Wed, 11 May 2022 16:34:04 +0800
Message-ID: <20220511083404.3315147-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The local.config of overlay+tmpfs is as follows:
```local.config.example
export FSTYP=tmpfs
export TEST_DEV=tmpfs_test
export TEST_DIR=/tmp/test
export SCRATCH_DEV=tmpfs_scratch
export SCRATCH_MNT=/tmp/scratch
```

Run `./check -overlay tests` to execute test case on overlay+tmpfs.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	Fix the bug in version V1 and fix the issue in cycle_mount.
V2->V3:
	Merge two patches into one completed patch.
V3->V4:
	Cycle mount the overlay without cycle mounting the base fs.

V1: https://patchwork.kernel.org/project/fstests/patch/20220424063751.1067376-1-libaokun1@huawei.com/
V2: https://patchwork.kernel.org/project/fstests/cover/20220507094524.949615-1-libaokun1@huawei.com/
V3: https://patchwork.kernel.org/project/fstests/patch/20220510020434.2561224-1-libaokun1@huawei.com/

 common/config  | 12 ++++++------
 common/overlay |  2 +-
 common/rc      | 39 ++++++++++++++++++++++++++++++---------
 3 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/common/config b/common/config
index 1033b890..d5953176 100644
--- a/common/config
+++ b/common/config
@@ -610,15 +610,15 @@ _overlay_config_override()
 	[ ! -d "$TEST_DEV" ] || export OVL_BASE_TEST_DIR="$TEST_DEV"
 	[ ! -d "$SCRATCH_DEV" ] || export OVL_BASE_SCRATCH_MNT="$SCRATCH_DEV"
 
+	# Config file may specify base fs type, but we obay -overlay flag
+	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
+	export FSTYP=overlay
+
 	# 2. SCRATCH/TEST_DEV point to the base fs partitions.  In this case,
 	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
 	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
 	#    overlayfs base and mount dirs inside base fs mount.
-	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
-
-	# Config file may specify base fs type, but we obay -overlay flag
-	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
-	export FSTYP=overlay
+	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
 
 	# Store original base fs vars
 	export OVL_BASE_TEST_DEV="$TEST_DEV"
@@ -634,7 +634,7 @@ _overlay_config_override()
 	export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
 	export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
 
-	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
+	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
 
 	# Store original base fs vars
 	export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
diff --git a/common/overlay b/common/overlay
index fff67ba1..c4e7ee58 100644
--- a/common/overlay
+++ b/common/overlay
@@ -81,7 +81,7 @@ _overlay_base_mount()
 		return 1
 	fi
 
-	_mount $* $dev $mnt
+	_mount -t $OVL_BASE_FSTYP $* $dev $mnt
 	_idmapped_mount $dev $mnt
 }
 
diff --git a/common/rc b/common/rc
index 553ae350..0d50cc22 100644
--- a/common/rc
+++ b/common/rc
@@ -409,15 +409,25 @@ _scratch_remount()
 _scratch_cycle_mount()
 {
     local opts="$1"
+    local unmounted
+
+    case "$FSTYP" in
+    tmpfs)
+        _scratch_remount "$opts"
+        return
+        ;;
+    overlay)
+        if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
+            $UMOUNT_PROG $SCRATCH_MNT
+            unmounted=true
+        fi
+        ;;
+    esac
 
-    if [ "$FSTYP" = tmpfs ]; then
-	_scratch_remount "$opts"
-	return
-    fi
     if test -n "$opts"; then
 	opts="-o $opts"
     fi
-    _scratch_unmount
+    [ "$unmounted" = true ] || _scratch_unmount
     _try_scratch_mount "$opts" || _fail "cycle mount failed"
 }
 
@@ -522,10 +532,21 @@ _test_unmount()
 
 _test_cycle_mount()
 {
-    if [ "$FSTYP" = tmpfs ]; then
-	return
-    fi
-    _test_unmount
+    local unmounted
+
+    case "$FSTYP" in
+    tmpfs)
+        return
+        ;;
+    overlay)
+        if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
+            $UMOUNT_PROG $TEST_DIR
+            unmounted=true
+        fi
+        ;;
+    esac
+
+    [ "$unmounted" = true ] || _test_unmount
     _test_mount
 }
 
-- 
2.31.1

