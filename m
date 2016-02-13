Received: from imap.thunk.org ([74.207.234.97]:34550 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbcBMRlQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 13 Feb 2016 12:41:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 15/16] xfstests: increase tmpfs memory size
Date: Sat, 13 Feb 2016 12:41:08 -0500
Message-Id: <1455385269-26319-16-git-send-email-tytso@mit.edu>
In-Reply-To: <1455385269-26319-1-git-send-email-tytso@mit.edu>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Junho Ryu <jayr@google.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

512M is not enough for generic/129.  Raise default tmpfs size to 1G.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Junho Ryu <jayr@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/config b/common/config
index c97facf..cacd815 100644
--- a/common/config
+++ b/common/config
@@ -316,8 +316,8 @@ _mount_opts()
 		export MOUNT_OPTIONS="-o acl $GFS2_MOUNT_OPTIONS"
 		;;
 	tmpfs)
-		# We need to specify the size at mount, use 512 MB by default
-		export MOUNT_OPTIONS="-o size=512M $TMPFS_MOUNT_OPTIONS"
+		# We need to specify the size at mount, use 1G by default
+		export MOUNT_OPTIONS="-o size=1G $TMPFS_MOUNT_OPTIONS"
 		;;
 	*)
 		;;
-- 
2.5.0

