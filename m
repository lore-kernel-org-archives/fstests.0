Received: from imap.thunk.org ([74.207.234.97]:35996 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbcBKF41 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 00:56:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 13/13] common: remove unneeded mount options for ext4
Date: Thu, 11 Feb 2016 00:56:22 -0500
Message-Id: <1455170182-32587-14-git-send-email-tytso@mit.edu>
In-Reply-To: <1455170182-32587-1-git-send-email-tytso@mit.edu>
References: <1455170182-32587-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Ext4 has turned on acls and xattrs by default for a long, long time
(even the 3.10 kernel has it on by default).

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/config b/common/config
index cacd815..e031a4a 100644
--- a/common/config
+++ b/common/config
@@ -300,6 +300,9 @@ _mount_opts()
 		# acls & xattrs aren't turned on by default on ext$FOO
 		export MOUNT_OPTIONS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
 		;;
+	ext4|ext4dev)
+		export MOUNT_OPTIONS="$EXT_MOUNT_OPTIONS"
+		;;
 	f2fs)
 		export MOUNT_OPTIONS="-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
 		;;
-- 
2.5.0

