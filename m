Received: from mail-pf0-f181.google.com ([209.85.192.181]:34898 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbcKPAmG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Nov 2016 19:42:06 -0500
Received: by mail-pf0-f181.google.com with SMTP id i88so38856561pfk.2
        for <fstests@vger.kernel.org>; Tue, 15 Nov 2016 16:42:06 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] xfs/298: cd to / instead of ~
Date: Tue, 15 Nov 2016 16:34:01 -0800
Message-Id: <151e7c9999ff4680ee8456a75c5a527dede906fe.1479256416.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

In our kernel testing infrastructure, "$HOME" isn't defined. Everywhere
else in xfstests does `cd /` instead, so let's just do that.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/xfs/298 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/298 b/tests/xfs/298
index 7702526..26fb5c8 100755
--- a/tests/xfs/298
+++ b/tests/xfs/298
@@ -80,7 +80,7 @@ while [ $SIZE -lt 1024 ];do
 # remove the symlink - make sure ifree removes the remote symlink.
 	rm $SYMLINK_FILE
 # umount and check the number of extents on the inode. Should be 0.
-	cd
+	cd /
 	_scratch_unmount >/dev/null 2>&1
 	_scratch_xfs_db  -c "inode $inode" -c "p core.nextents"
 
-- 
2.10.2

