Received: from userp2130.oracle.com ([156.151.31.86]:37670 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDQOyk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Apr 2018 10:54:40 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] fstests: btrfs/130 make it workable on small systems
Date: Tue, 17 Apr 2018 22:56:40 +0800
Message-Id: <20180417145640.12888-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This test case takes a long time to complete at the default
LOAD_FACTOR=1, so reduce the nr_extents to 256, so for larger
systems it can still use higher LOAD_FACTOR.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/130 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/130 b/tests/btrfs/130
index 96c8f9d9d526..05f92c11a998 100755
--- a/tests/btrfs/130
+++ b/tests/btrfs/130
@@ -60,7 +60,7 @@ _require_scratch_reflink
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 
-nr_extents=$((4096 * $LOAD_FACTOR))
+nr_extents=$((256 * $LOAD_FACTOR))
 
 # Use 128K blocksize, the default value of both deduperemove or
 # inband dedupe
-- 
2.15.0

