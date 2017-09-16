Received: from mx1.redhat.com ([209.132.183.28]:37178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751253AbdIPNU5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 16 Sep 2017 09:20:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB497C0587C7
        for <fstests@vger.kernel.org>; Sat, 16 Sep 2017 13:20:56 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] common/rc: Improve gfs2 support
Date: Sat, 16 Sep 2017 15:20:54 +0200
Message-Id: <20170916132054.24078-1-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Support gfs2 in _scratch_mkfs_sized _scratch_mkfs_blocksized.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index cd53a37..53bbb11 100644
--- a/common/rc
+++ b/common/rc
@@ -1055,6 +1055,9 @@ _scratch_mkfs_sized()
     ext2|ext3|ext4|ext4dev)
 	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
 	;;
+    gfs2)
+	yes | ${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
+	;;
     ocfs2)
 	yes | ${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
 	;;
@@ -1139,6 +1142,9 @@ _scratch_mkfs_blocksized()
     ext2|ext3|ext4)
 	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
 	;;
+    gfs2)
+	yes | ${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
+	;;
     ocfs2)
 	yes | ${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize -C $blocksize $SCRATCH_DEV
 	;;
-- 
1.8.3.1

