Received: from imap.thunk.org ([74.207.234.97]:51041 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756089AbcBJBuM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 9 Feb 2016 20:50:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 10/12] generic: disable generic/027 for tmpfs
Date: Tue,  9 Feb 2016 20:49:59 -0500
Message-Id: <1455069001-17846-11-git-send-email-tytso@mit.edu>
In-Reply-To: <1455069001-17846-1-git-send-email-tytso@mit.edu>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The generic/027 test creates a large number of 1k files until the file
creation fails.  On other file systems there will be a large number
zero length files because the block allocation has failed, but there
are still inodes available, and so the file creation loop runs until
the file system runs out of inodes.

With tmpfs, we can limit the size of the file system, which limits the
block allocation, but there is no limit to the number of inodes that
can be created until kmalloc() fails --- or the OOM killer kills the
test.  So this causes this test to run for a long, long time, and in
some cases the test or the test runner will get OOM killed instead.
We have other ENOSPC tests, so given that tmpfs is just so different
from all other file systems, it's simpler just to disable this test
for tmpfs than to try to make it work.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/027 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/027 b/tests/generic/027
index d2e59d6..f89a4ca 100755
--- a/tests/generic/027
+++ b/tests/generic/027
@@ -59,6 +59,7 @@ create_file()
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
+[ "$FSTYP" == tmpfs ] && _notrun "Test is not suitable for tmpfs"
 
 _require_scratch
 
-- 
2.5.0

