Received: from mx1.redhat.com ([209.132.183.28]:56487 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbcGEFjg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 5 Jul 2016 01:39:36 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] common/rc: avoid mkfs option conflicts in _scratch_mkfs_xfs_supported
Date: Tue,  5 Jul 2016 13:39:13 +0800
Message-Id: <1467697153-23189-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
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
 common/rc | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 883bd7b..ad81461 100644
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
+	# if $mkfs_opts conflits with $MKFS_OPTIONS,
+	# try again without $MKFS_OPTIONS
+	if [ $mkfs_status -ne 0 -a -n "$MKFS_OPTIONS" ]; then
+		$MKFS_XFS_PROG -N $SCRATCH_OPTIONS $mkfs_opts $SCRATCH_DEV
+		mkfs_status=$?
+	fi
+	return $mkfs_status
 }
 
 _scratch_mkfs_xfs()
-- 
2.7.4

