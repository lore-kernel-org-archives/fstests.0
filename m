Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E955C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Apr 2022 06:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbiDXG0q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Apr 2022 02:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbiDXG0o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Apr 2022 02:26:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E80E17BF8A
        for <fstests@vger.kernel.org>; Sat, 23 Apr 2022 23:23:43 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KmJ1W4mwMzGny8;
        Sun, 24 Apr 2022 14:21:03 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 14:23:37 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <zlang@redhat.com>, <guaneryu@gmail.com>, <fstests@vger.kernel.org>
CC:     <libaokun1@huawei.com>, <yukuai3@huawei.com>
Subject: [RFC] common: overlay support tmpfs
Date:   Sun, 24 Apr 2022 14:37:51 +0800
Message-ID: <20220424063751.1067376-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfstests support overlay+tmpfs

```local.config.example
export FSTYP=tmpfs
export TEST_DEV=tmpfs_test
export TEST_DIR=/tmp/test
export TEST_FS_MOUNT_OPTS="-t tmpfs"
export SCRATCH_DEV=tmpfs_scratch
export SCRATCH_MNT=/tmp/scratch
export MOUNT_OPTIONS="-t tmpfs"
```
Run `./check -overlay tests` to execute test case on overlay+tmpfs.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 common/config | 4 ++--
 common/rc     | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/common/config b/common/config
index 1033b890..3dc047e8 100644
--- a/common/config
+++ b/common/config
@@ -614,7 +614,7 @@ _overlay_config_override()
 	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
 	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
 	#    overlayfs base and mount dirs inside base fs mount.
-	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
+	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || [ "$FSTYP" == tmpfs ] || return 0
 
 	# Config file may specify base fs type, but we obay -overlay flag
 	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
@@ -634,7 +634,7 @@ _overlay_config_override()
 	export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
 	export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
 
-	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
+	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
 
 	# Store original base fs vars
 	export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
diff --git a/common/rc b/common/rc
index 553ae350..12498189 100644
--- a/common/rc
+++ b/common/rc
@@ -834,13 +834,18 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
+	nfs*|cifs|ceph|glusterfs|pvfs2|9p|virtiofs)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
 		_scratch_cleanup_files
 		return $?
 		;;
+	overlay)
+		[ ! "$OVL_BASE_FSTYP" == tmpfs ] || return 0
+		_scratch_cleanup_files
+		return $?
+		;;
 	tmpfs)
 		# do nothing for tmpfs
 		return 0
-- 
2.31.1

