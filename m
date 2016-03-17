Received: from mx1.redhat.com ([209.132.183.28]:49567 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004AbcCQE2f (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 17 Mar 2016 00:28:35 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] common: filter out all metadata related options not only crc
Date: Thu, 17 Mar 2016 12:28:12 +0800
Message-Id: <1458188892-14905-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Remove all metadata related mkfs options in _scratch_mkfs_xfs_opts() if
mkfs.xfs has no metadata support, not only the crc option.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index a34c387..38d3189 100644
--- a/common/rc
+++ b/common/rc
@@ -444,9 +444,9 @@ _scratch_mkfs_xfs_opts()
 {
 	mkfs_opts=$*
 
-	# remove crc related mkfs options if mkfs.xfs doesn't support v5 xfs
+	# remove metadata related mkfs options if mkfs.xfs doesn't support them
 	if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
-		mkfs_opts=`echo $mkfs_opts | sed "s/-m\s\+crc=.//"`
+		mkfs_opts=`echo $mkfs_opts | sed "s/-m\s\+\S\+//g"`
 	fi
 
 	_scratch_options mkfs
-- 
2.5.0

