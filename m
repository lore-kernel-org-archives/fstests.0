Received: from cn.fujitsu.com ([59.151.112.132]:63052 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753420AbcL3EO2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Dec 2016 23:14:28 -0500
From: Su Yue <suy.fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] fstests: btrfs/104: Redirect mkfs output to avoid false alert
Date: Thu, 29 Dec 2016 23:14:09 -0500
Message-ID: <20161230041410.10038-1-suy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

btrfs/104 doesn't redirect mkfs output correctly, which leads to false
alert.

Fix it.

Signed-off-by: Su Yue <suy.fnst@cn.fujitsu.com>
---
 tests/btrfs/104 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/104 b/tests/btrfs/104
index e6a6d3b..c8be4dd 100755
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -107,7 +107,7 @@ _explode_fs_tree () {
 
 # Force the default leaf size as the calculations for making our btree
 # heights are based on that.
-_scratch_mkfs "--nodesize 16384"
+_scratch_mkfs "--nodesize 16384" >> $seqres.full 2>&1
 _scratch_mount
 
 # populate the default subvolume and create a snapshot ('snap1')
-- 
2.9.3



