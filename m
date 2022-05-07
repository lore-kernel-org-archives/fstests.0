Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B46BC433EF
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 09:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443304AbiEGJfR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442853AbiEGJfP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 05:35:15 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B0DBCAD
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 02:31:29 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KwMWm20XQzXdlm;
        Sat,  7 May 2022 17:26:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 7 May
 2022 17:31:27 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <zlang@redhat.com>, <guaneryu@gmail.com>, <amir73il@gmail.com>,
        <libaokun1@huawei.com>, <zhengliang6@huawei.com>,
        <yukuai3@huawei.com>
Subject: [RFC v2 1/2] common/config: overlay support tmpfs
Date:   Sat, 7 May 2022 17:45:23 +0800
Message-ID: <20220507094524.949615-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220507094524.949615-1-libaokun1@huawei.com>
References: <20220507094524.949615-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfstests local.config support overlay+tmpfs

```local.config.example
export FSTYP=tmpfs
export TEST_DEV=tmpfs_test
export TEST_DIR=/tmp/test
export SCRATCH_DEV=tmpfs_scratch
export SCRATCH_MNT=/tmp/scratch
```

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 common/config  | 12 ++++++------
 common/overlay |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

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
 
-- 
2.31.1

