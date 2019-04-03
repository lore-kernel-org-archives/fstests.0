Received: from userp2130.oracle.com ([156.151.31.86]:34368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCREv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Apr 2019 13:04:51 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2] fstests: btrfs/048: amend property validation cases
Date: Thu,  4 Apr 2019 01:04:37 +0800
Message-Id: <20190403170437.14448-1-anand.jain@oracle.com>
In-Reply-To: <20190403165419.12666-1-anand.jain@oracle.com>
References: <20190403165419.12666-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Add more property validation cases which are fixed by the patches [1]
 [1]
  btrfs: fix vanished compression property after failed set
  btrfs: fix zstd compression parameter

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: correct kernel patch titles in the test header and change log

 tests/btrfs/048     | 23 +++++++++++++++++++++++
 tests/btrfs/048.out | 16 ++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tests/btrfs/048 b/tests/btrfs/048
index 588219579cc6..f6de0b8ca8b1 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -6,6 +6,9 @@
 #
 # Btrfs properties test. The btrfs properties feature was introduced in the
 # linux kernel 3.14.
+# Fails without the kernel patches:
+#  btrfs: fix vanished compression property after failed set
+#  btrfs: fix zstd compression parameter
 #
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
@@ -34,6 +37,7 @@ _supported_os Linux
 _require_test
 _require_scratch
 _require_btrfs_command "property"
+_require_btrfs_command inspect-internal dump-super
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
@@ -203,5 +207,24 @@ $BTRFS_UTIL_PROG property get $SCRATCH_MNT/sv1 compression
 touch $SCRATCH_MNT/sv1/file2
 $BTRFS_UTIL_PROG property get $SCRATCH_MNT/sv1/file2 compression
 
+echo -e "\nTesting argument validation, should fail"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' | _filter_scratch
+echo "***"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' | _filter_scratch
+echo "***"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zst' | _filter_scratch
+
+echo -e "\nTesting if property is persistent across failed validation"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lzo'
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' | _filter_scratch
+$BTRFS_UTIL_PROG property get $SCRATCH_MNT compression
+
+echo -e "\nTesting generation is unchanged after failed validation"
+$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^generation'
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' | _filter_scratch
+$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^generation'
+
 status=0
 exit
diff --git a/tests/btrfs/048.out b/tests/btrfs/048.out
index 3e4e3d28950a..00f39bc01227 100644
--- a/tests/btrfs/048.out
+++ b/tests/btrfs/048.out
@@ -76,3 +76,19 @@ compression=zlib
 Testing subvolume property inheritance
 compression=lzo
 compression=lzo
+
+Testing argument validation, should fail
+ERROR: failed to set compression for /mnt/scratch: Invalid argument
+***
+ERROR: failed to set compression for /mnt/scratch: Invalid argument
+***
+ERROR: failed to set compression for /mnt/scratch: Invalid argument
+
+Testing if property is persistent across failed validation
+ERROR: failed to set compression for /mnt/scratch: Invalid argument
+compression=lzo
+
+Testing generation is unchanged after failed validation
+generation		7
+ERROR: failed to set compression for /mnt/scratch: Invalid argument
+generation		7
-- 
2.17.1
