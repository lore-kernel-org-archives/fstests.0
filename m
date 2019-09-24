Received: from szxga04-in.huawei.com ([45.249.212.190]:2711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405224AbfIXJdn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 24 Sep 2019 05:33:43 -0400
From: Zhihao Cheng <chengzhihao1@huawei.com>
Subject: [PATCH xfstests] overlay: Enable character device to be the base fs partition
Date: Tue, 24 Sep 2019 17:40:25 +0800
Message-ID: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com, amir73il@gmail.com, david.oberhollenzer@sigma-star.at, ebiggers@google.com, yi.zhang@huawei.com
Cc: fstests@vger.kernel.org, linux-kernel@vger.kernel.org, chengzhihao1@huawei.com
List-ID: <fstests@vger.kernel.org>

When running overlay tests using character devices as base fs partitions,
all overlay usecase results become 'notrun'. Function
'_overay_config_override' (common/config) detects that the current base
fs partition is not a block device and will set FSTYP to base fs. The
overlay usecase will check the current FSTYP, and if it is not 'overlay'
or 'generic', it will skip the execution.

For example, using UBIFS as base fs skips all overlay usecases:

  FSTYP         -- ubifs       # FSTYP should be overridden as 'overlay'
  MKFS_OPTIONS  -- /dev/ubi0_1 # Character device
  MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch

  overlay/001	[not run] not suitable for this filesystem type: ubifs
  overlay/002	[not run] not suitable for this filesystem type: ubifs
  overlay/003	[not run] not suitable for this filesystem type: ubifs
  ...

When checking that the base fs partition is a block/character device,
FSTYP is overwritten as 'overlay'. This patch allows the base fs
partition to be a character device that can also execute overlay
usecases (such as ubifs).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 common/config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/config b/common/config
index 4c86a49..a22acdb 100644
--- a/common/config
+++ b/common/config
@@ -550,7 +550,7 @@ _overlay_config_override()
 	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
 	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
 	#    overlayfs base and mount dirs inside base fs mount.
-	[ -b "$TEST_DEV" ] || return 0
+	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
 
 	# Config file may specify base fs type, but we obay -overlay flag
 	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
@@ -570,7 +570,7 @@ _overlay_config_override()
 	export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
 	export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
 
-	[ -b "$SCRATCH_DEV" ] || return 0
+	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
 
 	# Store original base fs vars
 	export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
-- 
2.7.4
