Received: from mx1.redhat.com ([209.132.183.28]:37909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbcGOEVI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 15 Jul 2016 00:21:08 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 840AFC00F08A
	for <fstests@vger.kernel.org>; Fri, 15 Jul 2016 04:21:07 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] common/rc: avoid mkfs option conflicts in _scratch_mkfs_xfs_supported
Date: Fri, 15 Jul 2016 12:20:51 +0800
Message-Id: <1468556451-19817-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

In recent mkfs.xfs updates in xfsprogs, commit 9090e187bc3e ("mkfs:
add respecification detection to generic parsing") added
re-specification detection to "-m" option, it causes several tests
_notrun if MKFS_OPTIONS has the same options as those being tested
in _scratch_mkfs_xfs_supported(), because they're specified multiple
times.

	MKFS_OPTIONS="-m crc=0" ./check xfs/001
	xfs/001 3s ... [not run] mkfs.xfs doesn't have crc feature

Fix it by creating XFS again without MKFS_OPTIONS in
_scratch_mkfs_xfs_supported(), in case there's conflict between
MKFS_OPTIONS and mkfs_opts, like what we do in _scratch_mkfs_xfs().

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- check if $mkfs_opts is empty, not MKFS_OPTIONS
- update the comments a bit to match _scratch_mkfs_xfs() more

 common/rc | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 0c68e4f..07a218d 100644
--- a/common/rc
+++ b/common/rc
@@ -473,11 +473,20 @@ _scratch_mkfs_xfs_opts()
 
 _scratch_mkfs_xfs_supported()
 {
-	mkfs_opts=$*
+	local mkfs_opts=$*
 
 	_scratch_options mkfs
 
 	$MKFS_XFS_PROG -N $MKFS_OPTIONS $SCRATCH_OPTIONS $mkfs_opts $SCRATCH_DEV
+	local mkfs_status=$?
+
+	# a mkfs failure may be caused by conflicts between $MKFS_OPTIONS and
+	# $mkfs_opts, try again without $MKFS_OPTIONS
+	if [ $mkfs_status -ne 0 -a -n "$mkfs_opts" ]; then
+		$MKFS_XFS_PROG -N $SCRATCH_OPTIONS $mkfs_opts $SCRATCH_DEV
+		mkfs_status=$?
+	fi
+	return $mkfs_status
 }
 
 _scratch_mkfs_xfs()
-- 
2.7.4

