Received: from szxga06-in.huawei.com ([45.249.212.32]:57836 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727742AbeI3P7a (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 30 Sep 2018 11:59:30 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] check: recognize f2fs through parameter
Date: Sun, 30 Sep 2018 17:26:52 +0800
Message-ID: <20180930092653.122684-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

Add a paramenter in check to configure $FSTYP for f2fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 check | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/check b/check
index f3c8021d94b9..a9024094721a 100755
--- a/check
+++ b/check
@@ -59,6 +59,7 @@ check options
     -pvfs2          test PVFS2
     -tmpfs              test TMPFS
     -ubifs              test ubifs
+    -f2fs		test f2fs
     -l			line mode diff
     -udiff		show unified diff (default)
     -n			show me, do not run tests
@@ -263,6 +264,7 @@ while [ $# -gt 0 ]; do
 	-pvfs2)		FSTYP=pvfs2 ;;
 	-tmpfs)		FSTYP=tmpfs ;;
 	-ubifs)		FSTYP=ubifs ;;
+	-f2fs)		FSTYP=f2fs ;;
 
 	-g)	group=$2 ; shift ;
 		GROUP_LIST="$GROUP_LIST ${group//,/ }"
-- 
2.18.0.rc1
