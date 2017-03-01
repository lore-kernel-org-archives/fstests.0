Received: from cn.fujitsu.com ([59.151.112.132]:41948 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750993AbdCAICJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Mar 2017 03:02:09 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id EE62247C4EBE
        for <fstests@vger.kernel.org>; Wed,  1 Mar 2017 15:57:08 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] ext4/306: require 64bit feature to run ext4/306
Date: Wed, 1 Mar 2017 15:57:02 +0800
Message-ID: <1488355022-22218-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

The 64bit feature isn't supported by mkfs.ext4 on RHEL6, so
we add _require_ext4_mkfs_64bit to check it.  If 64bit feature
isn't supported, we could skip this case.  This feature has
been produced by 'commit 02d6f47e9647d ("mke2fs: Fix up mke2fs
to be able to make 64-bit file systems")'.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc      | 7 +++++++
 tests/ext4/306 | 1 +
 2 files changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index 8f23334..0c3c154 100644
--- a/common/rc
+++ b/common/rc
@@ -1669,6 +1669,13 @@ _require_scratch_ext4_crc()
 	_scratch_unmount
 }
 
+# this test requires the 64bit feature to be available in mkfs.ext4
+_require_ext4_mkfs_64bit()
+{
+	$MKFS_EXT4_PROG -F -O 64bit -n $SCRATCH_DEV 512m >/dev/null 2>&1 \
+	   || _notrun "mkfs.ext4 doesn't have 64bit feature"
+}
+
 # this test requires the bigalloc feature to be available in mkfs.ext4
 #
 _require_ext4_mkfs_bigalloc()
diff --git a/tests/ext4/306 b/tests/ext4/306
index fa3b782..4a92dd2 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -44,6 +44,7 @@ _supported_fs ext4
 _supported_os Linux
 
 _require_scratch
+_require_ext4_mkfs_64bit
 
 rm -f $seqres.full
 
-- 
1.8.3.1



