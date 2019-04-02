Received: from userp2120.oracle.com ([156.151.31.85]:38980 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDBIUI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Apr 2019 04:20:08 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2] fstests: btrfs: try use forget to unregister device
Date: Tue,  2 Apr 2019 16:19:46 +0800
Message-Id: <20190402081946.24838-1-anand.jain@oracle.com>
In-Reply-To: <1552988980-25710-1-git-send-email-anand.jain@oracle.com>
References: <1552988980-25710-1-git-send-email-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.cz, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

Some btrfs test cases use btrfs module-reload to unregister devices in
the btrfs kernel. The problem with the module-reload approach is, if test
system contains btrfs as rootfs, then you can't run these test cases.

Patches [1] introduced btrfs forget feature which can unregister devices
without the module-reload approach.

 [1]
 btrfs-progs: device scan: add new option to forget one or all scanned devices
 btrfs: introduce new ioctl to unregister a btrfs device

And this patch makes relevant changes in the fstests to use this new
feature, when available.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Update change log.
 Rename _require_btrfs_forget_if_not_fs_loadable() to _require_btrfs_forget_or_module_loadable()
 Rename _btrfs_forget_if_not_fs_reload() to _btrfs_forget_or_module_reload()

 common/btrfs    | 20 ++++++++++++++++++++
 tests/btrfs/124 |  6 +++---
 tests/btrfs/125 |  6 +++---
 tests/btrfs/154 |  6 +++---
 tests/btrfs/164 |  4 ++--
 5 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index f6513c06f95f..19ac7cc4b18c 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -382,3 +382,23 @@ _scratch_btrfs_sectorsize()
 	$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV |\
 		grep sectorsize | awk '{print $2}'
 }
+
+_btrfs_supports_forget()
+{
+	$BTRFS_UTIL_PROG device scan --help | grep -wq forget && \
+		$BTRFS_UTIL_PROG device scan --forget > /dev/null 2>&1
+}
+
+_require_btrfs_forget_or_module_loadable()
+{
+	_btrfs_supports_forget && return
+
+	_require_loadable_fs_module "btrfs"
+}
+
+_btrfs_forget_or_module_reload()
+{
+	_btrfs_supports_forget && return
+
+	_reload_fs_module "btrfs"
+}
diff --git a/tests/btrfs/124 b/tests/btrfs/124
index a52c65f608ff..0686a3b5f991 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -51,7 +51,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch_dev_pool 2
 _test_unmount
-_require_loadable_fs_module "btrfs"
+_require_btrfs_forget_or_module_loadable
 
 _scratch_dev_pool_get 2
 
@@ -86,7 +86,7 @@ echo "clean btrfs ko" >> $seqres.full
 _scratch_unmount
 
 # un-scan the btrfs devices
-_reload_fs_module "btrfs"
+_btrfs_forget_or_module_reload
 
 echo >> $seqres.full
 echo "-----Write degraded mount fill upto $max_fs_sz bytes-----" >> $seqres.full
@@ -125,7 +125,7 @@ echo
 echo "Mount degraded with the other dev"
 _scratch_unmount
 # un-scan the btrfs devices
-_reload_fs_module "btrfs"
+_btrfs_forget_or_module_reload
 _mount -o degraded $dev2 $SCRATCH_MNT >>$seqres.full 2>&1
 _run_btrfs_util_prog filesystem show
 checkpoint3=`md5sum $SCRATCH_MNT/tf2`
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index 847fa62ad25f..e1edccddd7d4 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -50,7 +50,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch_dev_pool 3
 _test_unmount
-_require_loadable_fs_module "btrfs"
+_require_btrfs_forget_or_module_loadable
 _require_btrfs_fs_feature raid56
 
 _scratch_dev_pool_get 3
@@ -103,7 +103,7 @@ echo "unmount" >> $seqres.full
 _scratch_unmount
 echo "clean btrfs ko" >> $seqres.full
 # un-scan the btrfs devices
-_reload_fs_module "btrfs"
+_btrfs_forget_or_module_reload
 _mount -o degraded,device=$dev2 $dev1 $SCRATCH_MNT >>$seqres.full 2>&1
 dd if=/dev/zero of="$SCRATCH_MNT"/tf2 bs=$bs count=$count \
 					>>$seqres.full 2>&1
@@ -139,7 +139,7 @@ echo "Mount degraded but with other dev"
 
 _scratch_unmount
 # un-scan the btrfs devices
-_reload_fs_module "btrfs"
+_btrfs_forget_or_module_reload
 
 _mount -o degraded,device=${dev2} $dev3 $SCRATCH_MNT >>$seqres.full 2>&1
 
diff --git a/tests/btrfs/154 b/tests/btrfs/154
index cd6c688fb9fe..cbf65a42919d 100755
--- a/tests/btrfs/154
+++ b/tests/btrfs/154
@@ -36,7 +36,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch_dev_pool 2
-_require_loadable_fs_module "btrfs"
+_require_btrfs_forget_or_module_loadable
 
 _scratch_dev_pool_get 2
 
@@ -90,7 +90,7 @@ degrade_mount_write()
 
 	echo "clean btrfs ko" >> $seqres.full
 	# un-scan the btrfs devices
-	_reload_fs_module "btrfs"
+	_btrfs_forget_or_module_reload
 	_mount -o degraded $DEV1 $SCRATCH_MNT >>$seqres.full 2>&1
 	cnt=$(( $COUNT/10 ))
 	dd if=/dev/urandom of="$SCRATCH_MNT"/tf1 bs=$bs count=$cnt \
@@ -142,7 +142,7 @@ verify()
 	echo "unmount" >> $seqres.full
 
 	_scratch_unmount
-	_reload_fs_module "btrfs"
+	_btrfs_forget_or_module_reload
 	_mount -o degraded $DEV2 $SCRATCH_MNT >>$seqres.full 2>&1
 	verify_checkpoint1=`md5sum $SCRATCH_MNT/tf1`
 	verify_checkpoint2=`md5sum $SCRATCH_MNT/tf2`
diff --git a/tests/btrfs/164 b/tests/btrfs/164
index 097191a0e493..e280f52e930a 100755
--- a/tests/btrfs/164
+++ b/tests/btrfs/164
@@ -36,7 +36,7 @@ rm -f $seqres.full
 # Modify as appropriate.
 _supported_fs btrfs
 _supported_os Linux
-_require_loadable_fs_module "btrfs"
+_require_btrfs_forget_or_module_loadable
 _require_scratch_dev_pool 2
 
 _scratch_dev_pool_get 2
@@ -69,7 +69,7 @@ delete_seed()
 {
 	_run_btrfs_util_prog device delete $dev_seed $SCRATCH_MNT
 	_scratch_unmount
-	_reload_fs_module "btrfs"
+	_btrfs_forget_or_module_reload
 	run_check _mount $dev_sprout $SCRATCH_MNT
 	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
 	echo -- sprout --
-- 
2.17.1
