Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57397 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387397AbfFJCnK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Jun 2019 22:43:10 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4/035: skip this test if DAX is in use
Date: Sun,  9 Jun 2019 22:42:54 -0400
Message-Id: <20190610024254.9830-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

This test creates a file system with a 1k block size.  Since there are
no architectures with a 1k page size, test file system can never be
mounted with DAX enabled, causing the test to fail.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/ext4/035 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ext4/035 b/tests/ext4/035
index ac5f38e0..05867402 100755
--- a/tests/ext4/035
+++ b/tests/ext4/035
@@ -36,6 +36,7 @@ _cleanup()
 _supported_fs ext4
 _supported_os Linux
 _require_scratch
+_exclude_scratch_mount_option dax
 _require_command "$RESIZE2FS_PROG" resize2fs
 
 rm -f $seqres.full
-- 
2.22.0
