From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] common/populate: remove unnecessary devices directory creation
Date: Mon, 18 Apr 2016 09:26:47 +0800
Message-ID: <1460942807-19296-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

_scratch_ext4_populate and _scratch_xfs_populate try to create
devices directory in xfstests/, so if we run xfs/083 or ext4/006
twice, it'll fail, fix this issue.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 common/populate | 2 --
 1 file changed, 2 deletions(-)

diff --git a/common/populate b/common/populate
index d166c24..aa6ed79 100644
--- a/common/populate
+++ b/common/populate
@@ -141,7 +141,6 @@ _scratch_xfs_populate() {
 
 	# Char & block
 	echo "+ special"
-	mkdir devices
 	mknod "${SCRATCH_MNT}/S_IFCHR" c 1 1
 	mknod "${SCRATCH_MNT}/S_IFBLK" c 1 1
 
@@ -241,7 +240,6 @@ _scratch_ext4_populate() {
 
 	# Char & block
 	echo "+ special"
-	mkdir devices
 	mknod "${SCRATCH_MNT}/S_IFCHR" c 1 1
 	mknod "${SCRATCH_MNT}/S_IFBLK" c 1 1
 
-- 
1.8.3.1
