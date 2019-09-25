Received: from szxga04-in.huawei.com ([45.249.212.190]:2712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727329AbfIYBr1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 24 Sep 2019 21:47:27 -0400
From: Zhihao Cheng <chengzhihao1@huawei.com>
Subject: [PATCH xfstests v2] overlay: Enable character device to be the base fs partition
Date: Wed, 25 Sep 2019 09:54:08 +0800
Message-ID: <1569376448-53998-1-git-send-email-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com, amir73il@gmail.com, david.oberhollenzer@sigma-star.at, ebiggers@google.com, yi.zhang@huawei.com
Cc: fstests@vger.kernel.org, linux-kernel@vger.kernel.org, chengzhihao1@huawei.com
List-ID: <fstests@vger.kernel.org>

There is a message in _supported_fs():
    _notrun "not suitable for this filesystem type: $FSTYP"
for when overlay usecases are executed on a chararcter device based base
fs. _overay_config_override() detects that the current base fs partition
is not a block device, and FSTYP won't be overwritten as 'overlay' before
executing usecases which results in all overlay usecases become 'notrun'.
In addition, all generic usecases are based on base fs rather than overlay.

We want to rewrite FSTYP to 'overlay' before running the usecases. To do
this, we need to add additional character device judgments for TEST_DEV
and SCRATCH_DEV in _overay_config_override().

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
