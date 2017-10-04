Received: from mx1.redhat.com ([209.132.183.28]:37234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbdJDSUO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Oct 2017 14:20:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9424768C3
        for <fstests@vger.kernel.org>; Wed,  4 Oct 2017 18:20:14 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] common/rc: Further improve gfs2 support
Date: Wed,  4 Oct 2017 20:20:09 +0200
Message-Id: <20171004182009.22786-1-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 common/rc | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 53bbb118..95d4306e 100644
--- a/common/rc
+++ b/common/rc
@@ -1056,7 +1056,19 @@ _scratch_mkfs_sized()
 	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
 	;;
     gfs2)
-	yes | ${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
+	# mkfs.gfs2 doesn't automatically shrink journal files on small
+	# filesystems, so the journal files may end up being bigger than the
+	# filesystem, which will cause mkfs.gfs2 to fail.  Until that's fixed,
+	# shrink the journal size to at most one eigth of the filesystem and at
+	# least 8 MiB, the minimum size allowed.
+	MIN_JOURNAL_SIZE=8
+	DEFAULT_JOURNAL_SIZE=128
+	if (( fssize/8 / (1024*1024) < DEFAULT_JOURNAL_SIZE )); then
+	    (( JOURNAL_SIZE = fssize/8 / (1024*1024) ))
+	    (( JOURNAL_SIZE >= MIN_JOURNAL_SIZE )) || JOURNAL_SIZE=$MIN_JOURNAL_SIZE
+	    MKFS_OPTIONS="-J $JOURNAL_SIZE $MKFS_OPTIONS"
+	fi
+	${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -O -b $blocksize $SCRATCH_DEV $blocks
 	;;
     ocfs2)
 	yes | ${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
@@ -1143,7 +1155,7 @@ _scratch_mkfs_blocksized()
 	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
 	;;
     gfs2)
-	yes | ${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
+	${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -O -b $blocksize $SCRATCH_DEV
 	;;
     ocfs2)
 	yes | ${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize -C $blocksize $SCRATCH_DEV
-- 
2.13.5

