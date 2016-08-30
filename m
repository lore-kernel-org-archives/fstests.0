Received: from cn.fujitsu.com ([222.73.24.84]:30484 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S932295AbcH3DzY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 29 Aug 2016 23:55:24 -0400
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] generic/159: record error value correctly
Date: Tue, 30 Aug 2016 11:51:14 +0800
Message-Id: <20160830035114.13876-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This case failed in btrfs, it's because when trying to open an immutable
file, vfs returns EPERM, not EACCESS, fix this.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
 tests/generic/159.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/159.out b/tests/generic/159.out
index 92fe33a..3e5e47f 100755
--- a/tests/generic/159.out
+++ b/tests/generic/159.out
@@ -2,4 +2,4 @@ QA output created by 159
 Format and mount
 Create the original files
 Try reflink on immutable files
-TEST_DIR/test-159/file2: Permission denied
+TEST_DIR/test-159/file2: Operation not permitted
-- 
2.9.0



