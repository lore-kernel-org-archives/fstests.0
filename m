Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40044 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422676AbbEONgt (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 15 May 2015 09:36:49 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id D57428E3D5
	for <fstests@vger.kernel.org>; Fri, 15 May 2015 13:36:48 +0000 (UTC)
Received: from plato.andrewprice.me.uk.com (ovpn-116-107.ams2.redhat.com [10.36.116.107])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4FDakLI015736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 15 May 2015 09:36:48 -0400
From: Andrew Price <anprice@redhat.com>
Subject: [PATCH 1/3] common/quota: set VFS_QUOTA for gfs2
Date: Fri, 15 May 2015 14:36:42 +0100
Message-Id: <1431697004-3032-1-git-send-email-anprice@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Use generic quota tools with gfs2.

Fixes "xfs_quota: cannot setup path for mount /mnt/scratch: No such
device or address"

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 common/quota | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/quota b/common/quota
index b320cf2..23be4f8 100644
--- a/common/quota
+++ b/common/quota
@@ -213,7 +213,7 @@ _check_quota_usage()
 
 	VFS_QUOTA=0
 	case $FSTYP in
-	ext2|ext3|ext4|ext4dev|reiserfs)
+	ext2|ext3|ext4|ext4dev|reiserfs|gfs2)
 		VFS_QUOTA=1
 		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
 		;;
-- 
2.1.0

