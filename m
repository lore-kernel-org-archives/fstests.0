Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2BBC25B08
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Aug 2022 02:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242677AbiHRC41 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Aug 2022 22:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiHRC40 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Aug 2022 22:56:26 -0400
Received: from out20-122.mail.aliyun.com (out20-122.mail.aliyun.com [115.124.20.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B64A5C52
        for <fstests@vger.kernel.org>; Wed, 17 Aug 2022 19:56:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07461943|-1;BR=01201311R191S24rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0280579-0.00153849-0.970404;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.OvvE7kA_1660791374;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OvvE7kA_1660791374)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 10:56:14 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fstests@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] fstests: add missing _require_scratch
Date:   Thu, 18 Aug 2022 10:56:14 +0800
Message-Id: <20220818025614.47274-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When $SCRATCH_DEV is not defined correctly, we need _require_scratch to skip
the tests that need $SCRATCH_DEV without an error.

so add missing _require_scratch.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 tests/btrfs/202 | 1 +
 tests/btrfs/215 | 1 +
 tests/btrfs/268 | 1 +
 tests/btrfs/269 | 1 +
 tests/btrfs/270 | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tests/btrfs/202 b/tests/btrfs/202
index c1fa3c3f..5f0429f1 100755
--- a/tests/btrfs/202
+++ b/tests/btrfs/202
@@ -11,6 +11,7 @@ _begin_fstest auto quick subvol snapshot
 . ./common/filter
 
 _supported_fs btrfs
+_require_scratch
 
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
diff --git a/tests/btrfs/215 b/tests/btrfs/215
index 27649160..7df74892 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -25,6 +25,7 @@ get_physical()
 
 # Modify as appropriate.
 _supported_fs btrfs
+_require_scratch
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device $SCRATCH_DEV
 
diff --git a/tests/btrfs/268 b/tests/btrfs/268
index 5043bb02..9dc14a18 100755
--- a/tests/btrfs/268
+++ b/tests/btrfs/268
@@ -14,6 +14,7 @@ _begin_fstest auto quick read_repair
 . ./common/filter
 
 _supported_fs btrfs
+_require_scratch
 _require_odirect
 _require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
 _require_scratch_dev_pool 2
diff --git a/tests/btrfs/269 b/tests/btrfs/269
index 3c11da3f..ad8f7286 100755
--- a/tests/btrfs/269
+++ b/tests/btrfs/269
@@ -18,6 +18,7 @@ _begin_fstest auto quick read_repair
 . ./common/filter
 
 _supported_fs btrfs
+_require_scratch
 _require_odirect
 _require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
 _require_scratch_dev_pool 4
diff --git a/tests/btrfs/270 b/tests/btrfs/270
index 5b73fb15..221ef7d2 100755
--- a/tests/btrfs/270
+++ b/tests/btrfs/270
@@ -12,6 +12,7 @@ _begin_fstest auto quick read_repair compress
 . ./common/filter
 
 _supported_fs btrfs
+_require_scratch
 _require_btrfs_command inspect-internal dump-tree
 _require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
 _require_scratch_dev_pool 2
-- 
2.36.2

