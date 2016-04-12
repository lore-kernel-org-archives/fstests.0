Received: from cn.fujitsu.com ([222.73.24.84]:22836 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932270AbcDLIAH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 12 Apr 2016 04:00:07 -0400
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH] fstests: btrfs/091: Disable compress to avoid output dismatch
Date: Tue, 12 Apr 2016 15:59:58 +0800
Message-Id: <1460447998-6899-1-git-send-email-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

If run btrfs/091 with "-o compress=lzo" mount option, test case will
fail, as compress makes extent much smaller on disk, making output
different from golden output.

As this test case is only testing qgroup, not compression, disable
compression manually in test case.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/091 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/091 b/tests/btrfs/091
index 16b5c16..ad9f71c 100755
--- a/tests/btrfs/091
+++ b/tests/btrfs/091
@@ -60,7 +60,8 @@ run_check _scratch_mkfs "--nodesize $NODESIZE"
 # inode cache will also take space in fs tree, disable them to get consistent
 # result.
 # discard error output since we will check return value manually.
-_scratch_mount "-o noinode_cache" 2> /dev/null
+# also disable all compression, or output will mismatch with golden output
+_scratch_mount "-o noinode_cache,compress=no,compress-force=no" 2> /dev/null
 
 # Check for old kernel which doesn't support 'noinode_cache' mount option
 if [ $? -ne 0 ]; then
-- 
1.8.3.1



