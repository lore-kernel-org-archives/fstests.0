Received: from userp1040.oracle.com ([156.151.31.81]:29794 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbcGUXrd (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 19:47:33 -0400
Subject: [PATCH 11/17] xfs/234: use scratch device helpers
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 21 Jul 2016 16:47:26 -0700
Message-ID: <146914484608.11762.11733588115406137276.stgit@birch.djwong.org>
In-Reply-To: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Use the helper functions for scratch devices.  This fixes a problem
where xfs/234 fails when there's a realtime device.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/234 |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


diff --git a/tests/xfs/234 b/tests/xfs/234
index 2bbf295..8dadc34 100755
--- a/tests/xfs/234
+++ b/tests/xfs/234
@@ -34,7 +34,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
     cd /
-    umount $SCRATCH_MNT > /dev/null 2>&1
+    _scratch_unmount > /dev/null 2>&1
     rm -rf $tmp.* $metadump_file $TEST_DIR/image
 }
 
@@ -76,8 +76,8 @@ _scratch_metadump $metadump_file
 # Now restore the obfuscated one back and take a look around
 echo "Restore metadump"
 xfs_mdrestore $metadump_file $TEST_DIR/image
-_mount -t $FSTYP $TEST_DIR/image $SCRATCH_MNT
-umount $SCRATCH_MNT
+SCRATCH_DEV=$TEST_DIR/image _scratch_mount
+SCRATCH_DEV=$TEST_DIR/image _scratch_unmount
 
 echo "Check restored fs"
 _check_generic_filesystem $metadump_file

