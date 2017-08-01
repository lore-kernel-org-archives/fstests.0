Received: from szxga03-in.huawei.com ([45.249.212.189]:9891 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdHAMQB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Aug 2017 08:16:01 -0400
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH] xfs/073: don't follow symbolic link when comparing the directories
Date: Tue, 1 Aug 2017 20:20:18 +0800
Message-ID: <1501590018-19013-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

When there is a broken symbolic link file under $here directory,
the diff between the source directory and the target directory will
output something like: "diff: /path/xxx/yyy: No such file or directory",
and the test case will fail.

To fix it, we should use "--no-dereference" option of diff command to
only compare the values of the symbolic links.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tests/xfs/073 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/073 b/tests/xfs/073
index 7228dd9..ddd462b 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -98,7 +98,7 @@ _verify_copy()
 	fi
 
 	echo comparing new image files to old
-	diff -Naur $source_dir $target_dir
+	diff -Naur --no-dereference $source_dir $target_dir
 
 	echo comparing new image directories to old
 	find $source_dir | _filter_path $source_dir > $tmp.manifest1
-- 
2.5.0

