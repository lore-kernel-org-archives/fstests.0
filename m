Received: from imap.thunk.org ([74.207.234.97]:56694 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758300AbcIWUGG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Sep 2016 16:06:06 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic/361: require that file system uses a real block device
Date: Fri, 23 Sep 2016 16:05:20 -0400
Message-Id: <20160923200520.29602-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

This test tries to use _mkfs_dev to format a loop device and then
tries to mount it.  For file systems that don't use block devices
(nfs, tmpfs, etc.) this is doomed to failure.  So skip this test if
$SCRATCH_DEV is not a block device.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/361 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/361 b/tests/generic/361
index ad047c6..c09863c 100755
--- a/tests/generic/361
+++ b/tests/generic/361
@@ -52,6 +52,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_block_device $SCRATCH_DEV
 
 # create a small filesystem to hold another filesystem image
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
-- 
2.9.0.243.g5c589a7.dirty

