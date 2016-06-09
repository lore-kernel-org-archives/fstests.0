Received: from imap.thunk.org ([74.207.234.97]:33770 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbcFISls (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 9 Jun 2016 14:41:48 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] defrag: test $TEST_DEV for extents for ext4 defrag
Date: Thu,  9 Jun 2016 14:41:09 -0400
Message-Id: <1465497669-3137-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Commit 902223bdbbf2: "defrag: require extents support for ext4 defrag"
added a test to make sure the ext4 file system has extents enabled by
testing the scratch device.  Unfortunately at the time when
_require_defrag is run, the scratch file system hasn't been
initialized yet by the test, so its contents are undefined.

If the previous test explicitly creates a file system with extents
disabled on $SCRATCH_DEV (such as ext4/306), then subsequent tests
(e.g., ext4/307 and ext4/306) will refuse to run.

Fix this by testing $TEST_DEV instead of $SCRATCH_DEV.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/defrag | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/defrag b/common/defrag
index 44fc536..7db0cb4 100644
--- a/common/defrag
+++ b/common/defrag
@@ -33,7 +33,7 @@ _require_defrag()
 	else
 		DEFRAG_PROG="$E4DEFRAG_PROG"
 	fi
-	dumpe2fs -h $SCRATCH_DEV 2> /dev/null | grep -wq extent || \
+	dumpe2fs -h $TEST_DEV 2> /dev/null | grep -wq extent || \
 		_notrun "file system does not have extents, needed for defrag"
 	;;
     btrfs)
-- 
2.5.0

