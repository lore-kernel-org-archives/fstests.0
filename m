Received: from imap.thunk.org ([74.207.234.97]:59090 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbeETSpc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 20 May 2018 14:45:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic: fix cleanup function for test 490
Date: Sun, 20 May 2018 14:45:17 -0400
Message-Id: <20180520184517.8826-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: jack@suse.cz, guaneryu@gmail.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

generic/490 fails because cleanup tries to delete . and .. since $tmp
is left unset, and so "rm -f $tmp.*" does nothing useful.  Instead
delete temp files created by seek_sanity_test.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/490 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/490 b/tests/generic/490
index b5042c2e..c0335ca0 100755
--- a/tests/generic/490
+++ b/tests/generic/490
@@ -49,7 +49,7 @@ _require_test_program "seek_sanity_test"
 _cleanup()
 {
 	cd /
-	rm -f $tmp.*
+	rm -f $base_test_file*
 }
 
 $here/src/seek_sanity_test -s 19 -e 20 $base_test_file > $seqres.full 2>&1 ||
-- 
2.16.1.72.g5be1f00a9a

