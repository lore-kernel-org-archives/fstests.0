Received: from mx1.redhat.com ([209.132.183.28]:51240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751702AbdDJGGE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 10 Apr 2017 02:06:04 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v2 2/3] DAX-DIO: skip DAX to non-DAX if unsupported
Date: Mon, 10 Apr 2017 14:05:52 +0800
Message-Id: <1491804353-1326-2-git-send-email-xzhou@redhat.com>
In-Reply-To: <1491804353-1326-1-git-send-email-xzhou@redhat.com>
References: <20170407171600.GA29489@linux.intel.com>
 <1491804353-1326-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

By tweaking SCRATCH_DEV by ndctl, only run DAX mapped
area DIO to non-DAX area tests when pmem device is in
"memory mode".

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

v2:
  umount/check scratch fs after test
  restore SCRATCH_DEV mode in cleanup
  fix variable names

 tests/generic/413 | 26 +++++++++++++++++++++++++-
 tests/xfs/260     | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/tests/generic/413 b/tests/generic/413
index a1cc514..fbe8f11 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -34,6 +34,9 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	# restore SCRATCH_DEV to original mode
+	$NDCTL_PROG create-namespace -f -e $scratch_dev_namespace \
+	  -m $scratch_dev_mode > /dev/null 2>&1
 }
 
 # get standard environment, filters and checks
@@ -47,9 +50,13 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_scratch_dax
+# fsck manually after tests as we will reconfig SCRATCH_DEV
+_require_scratch_nocheck
 _require_test_program "feature"
 _require_test_program "t_mmap_dio"
 _require_xfs_io_command "falloc"
+_require_ndctl
+_require_jq
 
 prep_files()
 {
@@ -110,7 +117,7 @@ t_both_nondax()
 t_mmap_dio_dax()
 {
 	t_both_dax $1
-	t_dax_to_nondax $1
+	[ $skip_dax_to_nondax -eq 0 ] && t_dax_to_nondax $1
 	t_nondax_to_dax $1
 	t_both_nondax $1
 }
@@ -126,6 +133,21 @@ do_tests()
 	t_mmap_dio_dax $((64 * 1024 * 1024))
 }
 
+skip_dax_to_nondax=0
+# config SCRATCH_DEV to memory mode to support DAX mapped
+# area DIO to non-DAX area.
+
+# save original mode
+scratch_dev_mode=$(_ndctl_get_pmem_key_value $SCRATCH_DEV mode)
+
+# get its namespace
+scratch_dev_namespace=$(_ndctl_get_pmem_key_value $SCRATCH_DEV dev)
+
+# skip dax to non-dax dio if config fails
+$NDCTL_PROG create-namespace -f -e $scratch_dev_namespace \
+  -m memory > /dev/null 2>&1 \
+  || skip_dax_to_nondax=1
+
 # make fs 2Mb aligned for PMD fault testing
 mkfs_opts=""
 if [ "$FSTYP" == "ext4" ]; then
@@ -146,6 +168,8 @@ _scratch_mount "-o dax"
 tsize=$((128 * 1024 * 1024))
 
 do_tests
+_scratch_unmount
+_check_scratch_fs
 
 # success, all done
 echo "Silence is golden"
diff --git a/tests/xfs/260 b/tests/xfs/260
index e613cc0..4e445d3 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -34,6 +34,9 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	# restore SCRATCH_DEV to original mode
+	$NDCTL_PROG create-namespace -f -e $scratch_dev_namespace \
+	  -m $scratch_dev_mode > /dev/null 2>&1
 }
 
 # get standard environment, filters and checks
@@ -46,10 +49,14 @@ rm -f $seqres.full
 _supported_fs xfs
 _supported_os Linux
 _require_scratch_dax
+# fsck manually after tests as we will reconfig SCRATCH_DEV
+_require_scratch_nocheck
 _require_test_program "feature"
 _require_test_program "t_mmap_dio"
 _require_xfs_io_command "chattr" "+/-x"
 _require_xfs_io_command "falloc"
+_require_ndctl
+_require_jq
 
 prep_files()
 {
@@ -120,7 +127,7 @@ t_both_nondax()
 t_dax_flag_mmap_dio()
 {
 	t_both_dax $1
-	t_dax_to_nondax $1
+	[ $skip_dax_to_nondax -eq 0 ] && t_dax_to_nondax $1
 	t_nondax_to_dax $1
 	t_both_nondax $1
 }
@@ -136,6 +143,21 @@ do_tests()
 	t_dax_flag_mmap_dio $((64 * 1024 * 1024))
 }
 
+skip_dax_to_nondax=0
+# config SCRATCH_DEV to memory mode to support DAX mapped
+# area DIO to non-DAX area.
+
+# save original mode
+scratch_dev_mode=$(_ndctl_get_pmem_key_value $SCRATCH_DEV mode)
+
+# get its namespace
+scratch_dev_namespace=$(_ndctl_get_pmem_key_value $SCRATCH_DEV dev)
+
+# skip dax to non-dax dio if config fails
+$NDCTL_PROG create-namespace -f -e $scratch_dev_namespace \
+  -m memory > /dev/null 2>&1 \
+  || skip_dax_to_nondax=1
+
 # make xfs 2Mb aligned for PMD fault testing
 _scratch_mkfs "-d su=2m,sw=1" > /dev/null 2>&1
 
@@ -145,12 +167,19 @@ _scratch_mount "-o dax"
 tsize=$((128 * 1024 * 1024))
 
 do_tests
+# we need to reconfig SCRATCH_DEV to its original mode
+# in cleanup, which will corrupt the FS. So fsck here
+# before cleanup.
 _scratch_unmount
+_check_scratch_fs
 
 # mount again without dax option
 export MOUNT_OPTIONS=""
+export TEST_FS_MOUNT_OPTS=""
 _scratch_mount
 do_tests
+_scratch_unmount
+_check_scratch_fs
 
 # success, all done
 echo "Silence is golden"
-- 
1.8.3.1

