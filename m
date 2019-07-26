Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388598AbfGZNpz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 26 Jul 2019 09:45:55 -0400
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] common/rc: ceph only supports default SEEK_HOLE behavior
Date: Fri, 26 Jul 2019 09:45:52 -0400
Message-Id: <20190726134552.23782-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: amir73il@gmail.com
List-ID: <fstests@vger.kernel.org>

CephFS currently has only a very primitive SEEK_HOLE implementation,
and always sets the offset to EOF when it's used. Remove it from the
whitelist.

Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 3fe5647ec658..e0b087c10e8f 100644
--- a/common/rc
+++ b/common/rc
@@ -2352,7 +2352,7 @@ _fstyp_has_non_default_seek_data_hole()
 	fi
 
 	case "$fstyp" in
-	btrfs|ext4|xfs|ceph|cifs|f2fs|gfs2|ocfs2|tmpfs)
+	btrfs|ext4|xfs|cifs|f2fs|gfs2|ocfs2|tmpfs)
 		return 0
 		;;
 	nfs*)
-- 
2.21.0
