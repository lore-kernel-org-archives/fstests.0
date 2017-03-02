Received: from cn.fujitsu.com ([59.151.112.132]:32747 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751055AbdCBDKm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Mar 2017 22:10:42 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] ext4/306: require 64bit feature to run ext4/306
Date: Thu, 2 Mar 2017 10:24:26 +0800
Message-ID: <1488421466-3303-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170301085939.GG14226@eguan.usersys.redhat.com>
References: <20170301085939.GG14226@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

The 64bit feature isn't supported by mkfs.ext4 on RHEL6, so
we add _require_ext4_mkfs_64bit to check it.  If 64bit feature
isn't supported, we could skip this case.  This feature has
been produced by 'commit 02d6f47e9647d ("mke2fs: Fix up mke2fs
to be able to make 64-bit file systems")'.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc      | 11 +++++++++++
 tests/ext4/306 |  1 +
 2 files changed, 12 insertions(+)

diff --git a/common/rc b/common/rc
index 8f23334..8c4f1c3 100644
--- a/common/rc
+++ b/common/rc
@@ -1669,6 +1669,17 @@ _require_scratch_ext4_crc()
 	_scratch_unmount
 }
 
+# this test requires the 64bit feature to be available in mkfs.ext4
+_require_ext4_mkfs_64bit()
+{
+	local testfile=$TEST_DIR/$$.64bit
+
+	touch $testfile
+	$MKFS_EXT4_PROG -F -O 64bit -n $testfile 512m >/dev/null 2>&1 \
+	   || _notrun "mkfs.ext4 doesn't have 64bit feature"
+	rm -f $testfile
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



