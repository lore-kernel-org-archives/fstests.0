Received: from cn.fujitsu.com ([59.151.112.132]:27735 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750910AbdCBGw6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Mar 2017 01:52:58 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3] ext4: add _require_ext4_mkfs_feature to check different features
Date: Thu, 2 Mar 2017 14:03:12 +0800
Message-ID: <1488434592-12834-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170302042212.GI14226@eguan.usersys.redhat.com>
References: <20170302042212.GI14226@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) We add _require_ext4_mkfs_feature to check the specified
   feature whether it is available in mkfs.ext4 or not.

2) We apply _require_ext4_mkfs_feature in ext4/003 and remove
   _require_mkfs_mkfs_bigalloc.

3) We add _require_ext4_mkfs_feature in ext4/306.  When 64bit
   feature is supported by mkfs.ext4, ext4/306 could skip.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc      | 21 ++++++++++++++++-----
 tests/ext4/003 |  2 +-
 tests/ext4/306 |  1 +
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/common/rc b/common/rc
index 8f23334..cba7b84 100644
--- a/common/rc
+++ b/common/rc
@@ -1669,12 +1669,23 @@ _require_scratch_ext4_crc()
 	_scratch_unmount
 }
 
-# this test requires the bigalloc feature to be available in mkfs.ext4
-#
-_require_ext4_mkfs_bigalloc()
+# Check the specified feature whether it is available in mkfs.ext4 or not.
+_require_ext4_mkfs_feature()
 {
-	$MKFS_EXT4_PROG -F -O bigalloc -n $SCRATCH_DEV 512m >/dev/null 2>&1 \
-	   || _notrun "mkfs.ext4 doesn't have bigalloc feature"
+	local feature=$1
+	local testfile=$TEST_DIR/$$.ext4_mkfs
+
+	if [ -z "$feature" ]; then
+                echo "Usage: _require_ext4_mkfs_feature feature"
+                exit 1
+        fi
+
+	touch $testfile
+	local result=$($MKFS_EXT4_PROG -F -O $feature -n $testfile 512m 2>&1)
+	echo $result | grep -q "Invalid filesystem option" && \
+		_notrun "mkfs.ext4 doesn't support $feature feature"
+
+	rm -f $testfile
 }
 
 # this test requires the ext4 kernel support bigalloc feature
diff --git a/tests/ext4/003 b/tests/ext4/003
index 53875a9..9be4017 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -38,7 +38,7 @@ _supported_fs ext4
 _supported_os Linux
 
 _require_scratch
-_require_ext4_mkfs_bigalloc
+_require_ext4_mkfs_feature "bigalloc"
 _require_ext4_bigalloc
 
 rm -f $seqres.full
diff --git a/tests/ext4/306 b/tests/ext4/306
index fa3b782..be765e6 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -44,6 +44,7 @@ _supported_fs ext4
 _supported_os Linux
 
 _require_scratch
+_require_ext4_mkfs_feature "64bit"
 
 rm -f $seqres.full
 
-- 
1.8.3.1



