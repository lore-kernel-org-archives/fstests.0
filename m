Received: from mx1.redhat.com ([209.132.183.28]:52372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751812AbdDGH4U (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 Apr 2017 03:56:20 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 2/3] DAX-DIO: skip DAX to non-DAX if unsupported
Date: Fri,  7 Apr 2017 15:56:03 +0800
Message-Id: <1491551764-18779-2-git-send-email-xzhou@redhat.com>
In-Reply-To: <1491551764-18779-1-git-send-email-xzhou@redhat.com>
References: <1491551764-18779-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

By tweaking SCRATCH_DEV by ndctl, only run DAX mapped
area DIO to non-DAX area tests when pmem device is in
"memory mode".

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/generic/413 | 25 ++++++++++++++++++++++++-
 tests/xfs/260     | 25 ++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/tests/generic/413 b/tests/generic/413
index a1cc514..55a871f 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -34,6 +34,11 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	_check_scratch_fs
+	# umount and restore SCRATCH_DEV to original mode
+	_scratch_unmount
+	$NDCTL_PROG create-namespace -f -e $scns -m $scmode \
+	  > /dev/null 2>&1
 }
 
 # get standard environment, filters and checks
@@ -47,9 +52,13 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_scratch_dax
+# fsck manually in cleanup as we will reconfig SCRATCH_DEV
+_require_scratch_nocheck
 _require_test_program "feature"
 _require_test_program "t_mmap_dio"
 _require_xfs_io_command "falloc"
+_require_ndctl
+_require_jq
 
 prep_files()
 {
@@ -110,7 +119,7 @@ t_both_nondax()
 t_mmap_dio_dax()
 {
 	t_both_dax $1
-	t_dax_to_nondax $1
+	[ $skipdmd -eq 0 ] && t_dax_to_nondax $1
 	t_nondax_to_dax $1
 	t_both_nondax $1
 }
@@ -126,6 +135,20 @@ do_tests()
 	t_mmap_dio_dax $((64 * 1024 * 1024))
 }
 
+skipdmd=0
+# config SCRATCH_DEV to memory mode to support DAX mapped
+# area DIO to non-DAX area.
+
+# save original mode
+scmode=$(_ndctl_get_pmem_key_value $SCRATCH_DEV mode)
+
+# get its namespace
+scns=$(_ndctl_get_pmem_key_value $SCRATCH_DEV dev)
+
+# skip dax to non-dax dio if config fails
+$NDCTL_PROG create-namespace -f -e $scns -m memory \
+  > /dev/null 2>&1 || skipdmd=1
+
 # make fs 2Mb aligned for PMD fault testing
 mkfs_opts=""
 if [ "$FSTYP" == "ext4" ]; then
diff --git a/tests/xfs/260 b/tests/xfs/260
index e613cc0..d07b273 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -34,6 +34,11 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	_check_scratch_fs
+	# umount and restore SCRATCH_DEV to original mode
+	_scratch_unmount
+	$NDCTL_PROG create-namespace -f -e $scns -m $scmode \
+	  > /dev/null 2>&1
 }
 
 # get standard environment, filters and checks
@@ -46,10 +51,14 @@ rm -f $seqres.full
 _supported_fs xfs
 _supported_os Linux
 _require_scratch_dax
+# fsck manually in cleanup as we will reconfig SCRATCH_DEV
+_require_scratch_nocheck
 _require_test_program "feature"
 _require_test_program "t_mmap_dio"
 _require_xfs_io_command "chattr" "+/-x"
 _require_xfs_io_command "falloc"
+_require_ndctl
+_require_jq
 
 prep_files()
 {
@@ -120,7 +129,7 @@ t_both_nondax()
 t_dax_flag_mmap_dio()
 {
 	t_both_dax $1
-	t_dax_to_nondax $1
+	[ $skipdmd -eq 0 ] && t_dax_to_nondax $1
 	t_nondax_to_dax $1
 	t_both_nondax $1
 }
@@ -136,6 +145,20 @@ do_tests()
 	t_dax_flag_mmap_dio $((64 * 1024 * 1024))
 }
 
+skipdmd=0
+# config SCRATCH_DEV to memory mode to support DAX mapped
+# area DIO to non-DAX area.
+
+# save original mode
+scmode=$(_ndctl_get_pmem_key_value $SCRATCH_DEV mode)
+
+# get its namespace
+scns=$(_ndctl_get_pmem_key_value $SCRATCH_DEV dev)
+
+# skip dax to non-dax dio if config fails
+$NDCTL_PROG create-namespace -f -e $scns -m memory \
+  > /dev/null 2>&1 || skipdmd=1
+
 # make xfs 2Mb aligned for PMD fault testing
 _scratch_mkfs "-d su=2m,sw=1" > /dev/null 2>&1
 
-- 
1.8.3.1

