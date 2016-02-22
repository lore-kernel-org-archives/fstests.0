Received: from imap.thunk.org ([74.207.234.97]:34160 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050AbcBVE0U (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 21 Feb 2016 23:26:20 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/4] generic: add _require_odirect for generic/125
Date: Sun, 21 Feb 2016 23:26:09 -0500
Message-Id: <1456115171-13191-3-git-send-email-tytso@mit.edu>
In-Reply-To: <1456115171-13191-1-git-send-email-tytso@mit.edu>
References: <1456115171-13191-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Also remove generic/125 from the auto group, and add it to the new
pnfs group.  This is to document where this test might be useful; it's
not really going to be useful for most normal on-disk file systems, so
remove it from the auto group.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/125   | 1 +
 tests/generic/group | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/125 b/tests/generic/125
index bcf9b3e..67eb63f 100755
--- a/tests/generic/125
+++ b/tests/generic/125
@@ -41,6 +41,7 @@ _supported_os Linux
 
 _require_test
 _require_user
+_require_odirect
 
 TESTDIR=$TEST_DIR/ftrunc
 TESTFILE=$TESTDIR/ftrunc.tmp
diff --git a/tests/generic/group b/tests/generic/group
index a47e23d..eb9748d 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -127,7 +127,7 @@
 122 auto quick clone dedupe
 123 perms auto quick
 124 pattern auto quick
-125 other auto
+125 other pnfs
 126 perms auto quick
 127 rw auto
 128 perms auto quick
-- 
2.5.0

