Return-Path: <fstests-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18845 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932909AbaLKWMc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Dec 2014 17:12:32 -0500
From: Vishal Verma <vishal.l.verma@linux.intel.com>
Subject: [PATCH v2] ext4: the _require checks for bigalloc need a larger fs size
Date: Thu, 11 Dec 2014 15:11:20 -0700
Message-Id: <1418335880-27252-1-git-send-email-vishal.l.verma@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

_require_ext4_bigalloc and _require_ext4_mkfs_bigalloc create a
200k fs. DAX (as XIP before it) relies on a fs block size ==
system page size; ie 4k for us.  With a 200k fs size limit,
mkfs refuses to create a filesystem with a 4k block size, so
the check fails, but for a bogus reason.
Increasing the fs size to 512m allows mkfs to create a filesystem
with 4k block size, so the test passes.

Signed-off-by: Vishal Verma <vishal.l.verma@linux.intel.com>
Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
---

v1->v2 Update commit log with feedback from Matthew.

 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index d5e3aff..615a446 100644
--- a/common/rc
+++ b/common/rc
@@ -1314,7 +1314,7 @@ _require_xfs_crc()
 #
 _require_ext4_mkfs_bigalloc()
 {
-	$MKFS_EXT4_PROG -F -O bigalloc -n $SCRATCH_DEV 200k >/dev/null 2>&1 \
+	$MKFS_EXT4_PROG -F -O bigalloc -n $SCRATCH_DEV 512m >/dev/null 2>&1 \
 	   || _notrun "mkfs.ext4 doesn't have bigalloc feature"
 }
 
@@ -1322,7 +1322,7 @@ _require_ext4_mkfs_bigalloc()
 #
 _require_ext4_bigalloc()
 {
-	$MKFS_EXT4_PROG -F -O bigalloc $SCRATCH_DEV 200k >/dev/null 2>&1
+	$MKFS_EXT4_PROG -F -O bigalloc $SCRATCH_DEV 512m >/dev/null 2>&1
 	_scratch_mount >/dev/null 2>&1 \
 	   || _notrun "Ext4 kernel doesn't support bigalloc feature"
 	umount $SCRATCH_MNT
-- 
2.1.0

