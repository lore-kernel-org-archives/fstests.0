Received: from userp1040.oracle.com ([156.151.31.81]:29983 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbcGUXsJ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 19:48:09 -0400
Subject: [PATCH 08/17] xfs/129: fix post-metadump remounting idiocy
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 21 Jul 2016 16:47:07 -0700
Message-ID: <146914482728.11762.13650586482755819412.stgit@birch.djwong.org>
In-Reply-To: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Use the standard _scratch_mount to mount the filesystem from the restored
image, instead of trying to call mount directly.  This is needed in case
we had custom mount options (like rtdev).

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/129 |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


diff --git a/tests/xfs/129 b/tests/xfs/129
index d29f842..17ff238 100755
--- a/tests/xfs/129
+++ b/tests/xfs/129
@@ -34,7 +34,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
     cd /
-    umount $SCRATCH_MNT > /dev/null 2>&1
+    _scratch_unmount > /dev/null 2>&1
     rm -rf $tmp.* $testdir $metadump_file $TEST_DIR/image
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

