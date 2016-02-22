Received: from imap.thunk.org ([74.207.234.97]:34156 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066AbcBVE0U (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 21 Feb 2016 23:26:20 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/4] defrag: require extents support for ext4 defrag
Date: Sun, 21 Feb 2016 23:26:10 -0500
Message-Id: <1456115171-13191-4-git-send-email-tytso@mit.edu>
In-Reply-To: <1456115171-13191-1-git-send-email-tytso@mit.edu>
References: <1456115171-13191-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The e4defrag program requires the use of fallocate, which in turn
means that the file system must have extents.  Enforce this
requirement so we don't get test failure noise when testing ext4's
ext3 compatibility.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/defrag | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/defrag b/common/defrag
index 942593e..6fbf830 100644
--- a/common/defrag
+++ b/common/defrag
@@ -27,7 +27,9 @@ _require_defrag()
         DEFRAG_PROG="$XFS_FSR_PROG"
 	;;
     ext4|ext4dev)
-        DEFRAG_PROG="$E4DEFRAG_PROG"
+	DEFRAG_PROG="$E4DEFRAG_PROG"
+	dumpe2fs -h $SCRATCH_DEV 2> /dev/null | grep -wq extent || \
+	     _notrun "file system does not have extents, needed for defrag"
 	;;
     btrfs)
 	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
-- 
2.5.0

