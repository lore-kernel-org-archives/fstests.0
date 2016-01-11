Received: from mx1.redhat.com ([209.132.183.28]:47715 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759856AbcAKLin (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 Jan 2016 06:38:43 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/2] common: remove all files in $SCRATCH_DEV for overlayfs in _scratch_cleanup_files()
Date: Mon, 11 Jan 2016 19:38:20 +0800
Message-Id: <1452512301-22145-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

All files in lower/upper dirs should be removed for overlayfs in
_scratch_cleanup_files(), not only files in merged dir, otherwise files
from lower dir won't be removed.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index e5ae1d0..e2a32da 100644
--- a/common/rc
+++ b/common/rc
@@ -701,9 +701,17 @@ _mkfs_dev()
 # remove all files in $SCRATCH_MNT, useful when testing on NFS/CIFS
 _scratch_cleanup_files()
 {
-	_scratch_mount
-	rm -rf $SCRATCH_MNT/*
-	_scratch_unmount
+	case $FSTYP in
+	overlay)
+		# $SCRATCH_DEV is a valid directory in overlay case
+		rm -rf $SCRATCH_DEV/*
+		;;
+	*)
+		_scratch_mount
+		rm -rf $SCRATCH_MNT/*
+		_scratch_unmount
+		;;
+	esac
 }
 
 _scratch_mkfs()
-- 
1.8.3.1

