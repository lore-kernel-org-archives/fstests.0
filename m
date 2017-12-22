Received: from imap.thunk.org ([74.207.234.97]:50948 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755940AbdLVS0L (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 22 Dec 2017 13:26:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: use a slightly bigger file system in ext4/021
Date: Fri, 22 Dec 2017 13:26:07 -0500
Message-Id: <20171222182607.7745-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

An 8 MB file system may not be big enough for certain file system
configurations --- in particular, if the inode size is 2048 bytes.
Make the test file system 10MB instead.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/021 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/021 b/tests/ext4/021
index 8a780873..e46b43be 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -50,7 +50,7 @@ _require_scratch
 _require_dumpe2fs
 
 # 8M in bytes
-fssize=$((8 * 1024 * 1024))
+fssize=$((10 * 1024 * 1024))
 _scratch_mkfs_sized $fssize >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 
-- 
2.11.0.rc0.7.gbe5a750

