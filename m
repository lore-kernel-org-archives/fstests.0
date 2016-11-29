Received: from cn.fujitsu.com ([222.73.24.84]:39314 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1755120AbcK2Hdc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 02:33:32 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 01/10] fstests: common: Introduce function to check qgroup correctness
Date: Tue, 29 Nov 2016 15:32:54 +0800
Message-Id: <20161129073303.14776-2-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Old btrfs qgroup test cases uses fix golden output numbers, which limits
the coverage since they can't handle mount options like compress or
inode_map, and cause false alert.

Introduce _btrfs_check_scratch_qgroup() function to check qgroup
correctness using "btrfs check --qgroup-report" function, which will
follow the way kernel handle qgroup and are proved very reliable.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 common/rc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/common/rc b/common/rc
index 8c99306..35d2d56 100644
--- a/common/rc
+++ b/common/rc
@@ -3018,6 +3018,25 @@ _require_deletable_scratch_dev_pool()
 	done
 }
 
+# We check if "btrfs check" support to check qgroup correctness
+# Old fixed golden output can cover case like compress and inode_map
+# mount options, which limits the coverage
+_require_btrfs_check_qgroup()
+{
+	_require_command "$BTRFS_UTIL_PROG" btrfs
+	output=$($BTRFS_UTIL_PROG check --help | grep "qgroup-report")
+	if [ -z "$output" ]; then
+		_notrun "$BTRFS_UTIL_PROG too old (must support 'check --qgroup-report')"
+	fi
+}
+
+_btrfs_check_scratch_qgroup()
+{
+	_require_btrfs_check_qgroup
+	$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 |\
+		grep -E "Counts for qgroup.*are different"
+}
+
 # We check for btrfs and (optionally) features of the btrfs command
 _require_btrfs()
 {
-- 
2.7.4



