Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751292AbeBRMpM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 18 Feb 2018 07:45:12 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] fstests: _fail test by default when _scratch_mount fails
Date: Sun, 18 Feb 2018 20:44:57 +0800
Message-Id: <20180218124457.28597-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Previously _scratch_mount didn't check the mount status and most
tests continue to run even if the mount failed (unless test checks
for the mount status explicitly). This would result in running tests
on the underlying filesystem (usually rootfs) and implicit test
failures, and such failures can be annoying and are usually hard to
debug.

Now _fail test by default if _scratch_mount failed and introduce
_try_scratch_mount for tests that need to check mount results
themselves. Also introduce a new _try_scratch_mount helper that does
scratch mount without checking mount status for tests that do the
check themselves.

Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---

Changes since RFC patch:
- fold the two patches into one single patch
- rename _scratch_mount_nocheck to _try_scratch_mount
- simplify mount failure error message
- convert more tests to use _scratch_mount instead of _try_scratch_mount || _fail

 common/attr        |  2 +-
 common/dmapi       |  4 ++--
 common/dump        |  4 ++--
 common/encrypt     |  2 +-
 common/filestreams |  4 ++--
 common/fuzzy       |  4 ++--
 common/log         |  6 +++---
 common/overlay     |  2 +-
 common/punch       |  2 +-
 common/quota       |  4 ++--
 common/rc          | 40 ++++++++++++++++++++++++----------------
 common/xfs         | 12 ++++++------
 tests/btrfs/004    |  6 +++---
 tests/btrfs/007    |  4 ++--
 tests/btrfs/009    |  2 +-
 tests/btrfs/012    |  4 ++--
 tests/btrfs/042    |  2 +-
 tests/btrfs/057    |  2 +-
 tests/btrfs/091    |  4 ++--
 tests/btrfs/131    |  4 ++--
 tests/btrfs/136    |  2 +-
 tests/ext4/003     |  2 +-
 tests/ext4/006     |  4 ++--
 tests/ext4/007     |  2 +-
 tests/ext4/008     |  2 +-
 tests/ext4/011     |  4 ++--
 tests/ext4/012     |  4 ++--
 tests/ext4/024     |  2 +-
 tests/ext4/025     |  2 +-
 tests/ext4/305     |  2 +-
 tests/ext4/306     |  2 +-
 tests/generic/015  |  2 +-
 tests/generic/019  |  4 ++--
 tests/generic/050  | 10 +++++-----
 tests/generic/052  |  5 ++---
 tests/generic/053  |  2 +-
 tests/generic/054  |  4 ++--
 tests/generic/055  |  4 ++--
 tests/generic/062  |  2 +-
 tests/generic/064  |  2 +-
 tests/generic/068  |  3 +--
 tests/generic/069  |  2 +-
 tests/generic/076  |  3 +--
 tests/generic/077  |  3 +--
 tests/generic/079  |  2 +-
 tests/generic/082  |  4 ++--
 tests/generic/083  |  3 +--
 tests/generic/105  |  2 +-
 tests/generic/117  |  3 +--
 tests/generic/120  |  2 +-
 tests/generic/169  |  3 +--
 tests/generic/235  |  4 ++--
 tests/generic/270  |  2 +-
 tests/generic/294  |  2 +-
 tests/generic/317  |  2 +-
 tests/generic/318  |  2 +-
 tests/generic/388  |  2 +-
 tests/generic/390  |  2 +-
 tests/generic/403  |  2 +-
 tests/generic/466  |  2 +-
 tests/shared/003   |  2 +-
 tests/xfs/005      |  2 +-
 tests/xfs/009      |  2 +-
 tests/xfs/016      |  2 +-
 tests/xfs/017      |  7 +++----
 tests/xfs/019      |  2 +-
 tests/xfs/021      |  3 +--
 tests/xfs/034      |  3 +--
 tests/xfs/041      |  4 ++--
 tests/xfs/042      |  4 ++--
 tests/xfs/044      |  4 ++--
 tests/xfs/045      |  4 ++--
 tests/xfs/057      |  2 +-
 tests/xfs/067      |  2 +-
 tests/xfs/072      |  2 +-
 tests/xfs/073      |  2 +-
 tests/xfs/075      |  4 ++--
 tests/xfs/077      |  4 ++--
 tests/xfs/079      |  2 +-
 tests/xfs/083      |  6 +++---
 tests/xfs/085      |  2 +-
 tests/xfs/090      |  2 +-
 tests/xfs/092      |  2 +-
 tests/xfs/094      |  2 +-
 tests/xfs/098      |  2 +-
 tests/xfs/103      |  2 +-
 tests/xfs/104      |  2 +-
 tests/xfs/111      |  2 +-
 tests/xfs/121      |  8 +++-----
 tests/xfs/130      |  2 +-
 tests/xfs/137      |  4 ++--
 tests/xfs/141      |  2 +-
 tests/xfs/177      |  6 ++----
 tests/xfs/181      |  3 +--
 tests/xfs/183      |  3 +--
 tests/xfs/189      | 14 +++++++-------
 tests/xfs/263      |  2 +-
 tests/xfs/270      |  4 ++--
 tests/xfs/297      |  2 +-
 tests/xfs/333      |  2 +-
 tests/xfs/338      |  2 +-
 tests/xfs/340      |  2 +-
 tests/xfs/433      |  2 +-
 tests/xfs/434      |  2 +-
 tests/xfs/435      |  2 +-
 tests/xfs/436      |  2 +-
 tests/xfs/439      |  2 +-
 tests/xfs/442      |  2 +-
 tests/xfs/443      |  2 +-
 109 files changed, 184 insertions(+), 192 deletions(-)

diff --git a/common/attr b/common/attr
index 66b0227f721e..3d1385a493b0 100644
--- a/common/attr
+++ b/common/attr
@@ -229,7 +229,7 @@ _require_noattr2()
 {
 	_scratch_mkfs_xfs > /dev/null 2>&1 \
 		|| _fail "_scratch_mkfs_xfs failed on $SCRATCH_DEV"
-	_scratch_mount -o noattr2 > /dev/null 2>&1 \
+	_try_scratch_mount -o noattr2 > /dev/null 2>&1 \
 		|| _notrun "noattr2 mount option not supported on $SCRATCH_DEV"
 	_scratch_unmount
 }
diff --git a/common/dmapi b/common/dmapi
index c8a463a2cac0..5eff3d92f195 100644
--- a/common/dmapi
+++ b/common/dmapi
@@ -31,10 +31,10 @@ _dmapi_scratch_mount () {
     if [ `echo "$MOUNT_OPTIONS" | grep -c dmapi` -gt 0 -o \
         `echo "$MOUNT_OPTIONS" | grep -c dmi` -gt 0 ] ; then
         #already got dmapi options set
-        _scratch_mount
+        _try_scratch_mount
         dmapi_mount_result=$?
     else
-        _scratch_mount "-o dmapi,mtpt=$SCRATCH_MNT"
+        _try_scratch_mount "-o dmapi,mtpt=$SCRATCH_MNT"
         dmapi_mount_result=$?
     fi
 
diff --git a/common/dump b/common/dump
index 2b3cfa0f0607..7b9c10a25414 100644
--- a/common/dump
+++ b/common/dump
@@ -235,7 +235,7 @@ _wipe_fs()
     _require_scratch
 
     _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
-    _scratch_mount >>$seqres.full || _fail "mount failed"
+    _scratch_mount >>$seqres.full
 }
 
 #
@@ -287,7 +287,7 @@ _stable_fs()
 {
     _saveddir=`pwd`; cd /
     _scratch_unmount >>$seqres.full || _fail "unmount failed"
-    _scratch_mount >>$seqres.full || _fail "mount failed"
+    _scratch_mount >>$seqres.full
     cd $_saveddir
 }
 
diff --git a/common/encrypt b/common/encrypt
index 189c59ee9bbd..3d77ebd2cecc 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -43,7 +43,7 @@ _require_scratch_encryption()
 	# Try to mount the filesystem.  If this fails then either the kernel
 	# isn't aware of encryption, or the mkfs options were not compatible
 	# with encryption (e.g. ext4 with block size != PAGE_SIZE).
-	if ! _scratch_mount &>>$seqres.full; then
+	if ! _try_scratch_mount &>>$seqres.full; then
 		_notrun "kernel is unaware of $FSTYP encryption feature," \
 			"or mkfs options are not compatible with encryption"
 	fi
diff --git a/common/filestreams b/common/filestreams
index f5441f5a82e9..d7a656f8bc23 100644
--- a/common/filestreams
+++ b/common/filestreams
@@ -111,11 +111,11 @@ _test_streams() {
 
 	if [ "$use_iflag" = "0" ]; then
 		# mount using filestreams mount option
-		_scratch_mount "-o filestreams" \
+		_try_scratch_mount "-o filestreams" \
 			|| _fail "filestreams mount failed"
 	else
 		# test will set inode flag
-		_scratch_mount || _fail "mount failed"
+		_scratch_mount
 	fi
 
 	cd $SCRATCH_MNT
diff --git a/common/fuzzy b/common/fuzzy
index b964fd8cb0fc..f89765c1bfd2 100644
--- a/common/fuzzy
+++ b/common/fuzzy
@@ -200,7 +200,7 @@ __scratch_xfs_fuzz_field_test() {
 
 	# Try to catch the error with scrub
 	echo "+ Try to catch the error"
-	_scratch_mount 2>&1
+	_try_scratch_mount 2>&1
 	res=$?
 	if [ $res -eq 0 ]; then
 		# Try an online scrub unless we're fuzzing ag 0's sb,
@@ -245,7 +245,7 @@ __scratch_xfs_fuzz_field_test() {
 
 	# See if scrub finds a clean fs
 	echo "+ Make sure error is gone (online)"
-	_scratch_mount 2>&1
+	_try_scratch_mount 2>&1
 	res=$?
 	if [ $res -eq 0 ]; then
 		# Try an online scrub unless we're fuzzing ag 0's sb,
diff --git a/common/log b/common/log
index bdb4ed684a08..b48f6abade77 100644
--- a/common/log
+++ b/common/log
@@ -370,7 +370,7 @@ _create_log()
 {
     # mount the FS
     _full "mount"
-    _scratch_mount >>$seqres.full 2>&1
+    _try_scratch_mount >>$seqres.full 2>&1
     if [ $? -ne 0 ] ; then 
 	_echofull "mount failed: $MOUNT_OPTIONS"
 	return 1
@@ -399,7 +399,7 @@ _create_log_sync()
 {
     # mount the FS
     _full " mount"
-    _scratch_mount >>$seqres.full 2>&1
+    _try_scratch_mount >>$seqres.full 2>&1
     if [ $? -ne 0 ] ; then 
 	_echofull "mount failed: $MOUNT_OPTIONS"
 	return 1
@@ -519,7 +519,7 @@ _require_v2log()
 
     # test out mount to see if it mounts a v2 log fs
     export MOUNT_OPTIONS="-o logbsize=32k"
-    if ! _scratch_mount >>$seqres.full 2>&1; then
+    if ! _try_scratch_mount >>$seqres.full 2>&1; then
         _notrun "mount/kernel does not support v2 logs"
     fi
 
diff --git a/common/overlay b/common/overlay
index a8b0e9369c86..e1b07f495e87 100644
--- a/common/overlay
+++ b/common/overlay
@@ -167,7 +167,7 @@ _require_scratch_overlay_features()
 	done
 
 	_scratch_mkfs > /dev/null 2>&1
-	_scratch_mount -o $opts || \
+	_try_scratch_mount -o $opts || \
 		_notrun "overlay options '$opts' cannot be enabled on ${SCRATCH_DEV}"
 
 	for feature in ${features[*]}; do
diff --git a/common/punch b/common/punch
index c4ed26192a22..42a7e97496b7 100644
--- a/common/punch
+++ b/common/punch
@@ -131,7 +131,7 @@ _test_punch() {
 		_dmapi_scratch_mount
 	else
 		# only unresvsp punch type is used, just do a normal mount
-		_scratch_mount || _fail "mount failed"
+		_scratch_mount
 	fi
 
 	cd $SCRATCH_MNT
diff --git a/common/quota b/common/quota
index 2611c484ee35..f8e037995ad4 100644
--- a/common/quota
+++ b/common/quota
@@ -119,7 +119,7 @@ _scratch_enable_pquota()
 	[ "$FSTYP" != "ext4" ] && return
 
 	tune2fs -O quota,project $SCRATCH_DEV >>$seqres.full 2>&1
-	_scratch_mount >/dev/null 2>&1 \
+	_try_scratch_mount >/dev/null 2>&1 \
 		|| _notrun "kernel doesn't support project feature on $FSTYP"
 	_scratch_unmount
 }
@@ -202,7 +202,7 @@ _choose_prid()
 _qmount()
 {
     _scratch_unmount >/dev/null 2>&1
-    _scratch_mount || _fail "qmount failed"
+    _try_scratch_mount || _fail "qmount failed"
     # xfs doesn't need these setups and quotacheck even fails on xfs
     # redirect the output to $seqres.full for debug purpose and ignore results
     if [ "$FSTYP" != "xfs" ]; then
diff --git a/common/rc b/common/rc
index 87863baaf33a..1b3cee5e1969 100644
--- a/common/rc
+++ b/common/rc
@@ -352,13 +352,20 @@ _supports_filetype()
 	esac
 }
 
+# mount scratch device with given options but don't check mount status
+_try_scratch_mount()
+{
+	if [ "$FSTYP" == "overlay" ]; then
+		_overlay_scratch_mount $*
+		return $?
+	fi
+	_mount -t $FSTYP `_scratch_mount_options $*`
+}
+
+# mount scratch device with given options and _fail if mount fails
 _scratch_mount()
 {
-    if [ "$FSTYP" == "overlay" ]; then
-        _overlay_scratch_mount $*
-        return $?
-    fi
-    _mount -t $FSTYP `_scratch_mount_options $*`
+	_try_scratch_mount $* || _fail "mount failed"
 }
 
 _scratch_unmount()
@@ -397,7 +404,7 @@ _scratch_cycle_mount()
 	opts="-o $opts"
     fi
     _scratch_unmount
-    _scratch_mount "$opts"
+    _try_scratch_mount "$opts" || _fail "cycle mount failed"
 }
 
 _scratch_shutdown()
@@ -524,7 +531,7 @@ _setup_large_ext4_fs()
 
 	# mount the filesystem and create 16TB - 4KB files until we consume
 	# all the necessary space.
-	_scratch_mount 2>&1 >$tmp_dir/mnt.err
+	_try_scratch_mount 2>&1 >$tmp_dir/mnt.err
 	local status=$?
 	if [ $status -ne 0 ]; then
 		echo "mount failed"
@@ -1103,7 +1110,7 @@ _repair_scratch_fs()
 	res=$?
 	if [ "$res" -ne 0 ]; then
 		echo "xfs_repair returns $res; replay log?"
-		_scratch_mount
+		_try_scratch_mount
 		res=$?
 		if [ "$res" -gt 0 ]; then
 			echo "mount returns $res; zap log?"
@@ -1872,7 +1879,7 @@ _require_scratch_ext4_crc()
 {
 	_scratch_mkfs_ext4 >/dev/null 2>&1
 	dumpe2fs -h $SCRATCH_DEV 2> /dev/null | grep -q metadata_csum || _notrun "metadata_csum not supported by this filesystem"
-	_scratch_mount >/dev/null 2>&1 \
+	_try_scratch_mount >/dev/null 2>&1 \
 	   || _notrun "Kernel doesn't support metadata_csum feature"
 	_scratch_unmount
 }
@@ -1888,7 +1895,7 @@ _require_scratch_ext4_feature()
     $MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$1" \
 		    $SCRATCH_DEV 512m >/dev/null 2>&1 \
 	|| _notrun "mkfs.ext4 doesn't support $1 feature"
-    _scratch_mount >/dev/null 2>&1 \
+    _try_scratch_mount >/dev/null 2>&1 \
 	|| _notrun "Kernel doesn't support the ext4 feature(s): $1"
     _scratch_unmount
 }
@@ -2322,7 +2329,7 @@ _require_scratch_richacl_xfs()
 	_scratch_mkfs_xfs_supported -m richacl=1 >/dev/null 2>&1 \
 		|| _notrun "mkfs.xfs doesn't have richacl feature"
 	_scratch_mkfs_xfs -m richacl=1 >/dev/null 2>&1
-	_scratch_mount >/dev/null 2>&1 \
+	_try_scratch_mount >/dev/null 2>&1 \
 		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
 	_scratch_unmount
 }
@@ -2331,7 +2338,7 @@ _require_scratch_richacl_ext4()
 {
 	_scratch_mkfs -O richacl >/dev/null 2>&1 \
 		|| _notrun "can't mkfs $FSTYP with option -O richacl"
-	_scratch_mount >/dev/null 2>&1 \
+	_try_scratch_mount >/dev/null 2>&1 \
 		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
 	_scratch_unmount
 }
@@ -2993,7 +3000,7 @@ _require_scratch_shutdown()
 	[ -x src/godown ] || _notrun "src/godown executable not found"
 
 	_scratch_mkfs > /dev/null 2>&1 || _notrun "_scratch_mkfs failed on $SCRATCH_DEV"
-	_scratch_mount || _notrun "_scratch_mount failed on $SCRATCH_MNT"
+	_scratch_mount
 
 	if [ $FSTYP = "overlay" ]; then
 		if [ -z $OVL_BASE_SCRATCH_DEV ]; then
@@ -3019,7 +3026,8 @@ _require_scratch_dax()
 {
 	_require_scratch
 	_scratch_mkfs > /dev/null 2>&1
-	_scratch_mount -o dax
+	_try_scratch_mount -o dax || \
+		_notrun "mount $SCRATCH_DEV with dax failed"
 	# Check options to be sure. XFS ignores dax option
 	# and goes on if dev underneath does not support dax.
 	_fs_options $SCRATCH_DEV | grep -qw "dax" || \
@@ -3030,7 +3038,7 @@ _require_scratch_dax()
 # Does norecovery support by this fs?
 _require_norecovery()
 {
-	_scratch_mount -o ro,norecovery || \
+	_try_scratch_mount -o ro,norecovery || \
 		_notrun "$FSTYP does not support norecovery"
 	_scratch_unmount
 }
@@ -3229,7 +3237,7 @@ _require_atime()
 _require_relatime()
 {
         _scratch_mkfs > /dev/null 2>&1
-        _scratch_mount -o relatime || \
+        _try_scratch_mount -o relatime || \
                 _notrun "relatime not supported by the current kernel"
 	_scratch_unmount
 }
diff --git a/common/xfs b/common/xfs
index 9b20b0380782..9ed78dee08ff 100644
--- a/common/xfs
+++ b/common/xfs
@@ -18,7 +18,7 @@ _setup_large_xfs_fs()
 	file_size=$(($file_size - $SCRATCH_DEV_EMPTY_SPACE))
 
 	# mount the filesystem, create the file, unmount it
-	_scratch_mount 2>&1 >$tmp_dir/mnt.err
+	_try_scratch_mount 2>&1 >$tmp_dir/mnt.err
 	local status=$?
 	if [ $status -ne 0 ]; then
 		echo "mount failed"
@@ -223,7 +223,7 @@ _require_xfs_mkfs_crc()
 _require_xfs_crc()
 {
 	_scratch_mkfs_xfs -m crc=1 >/dev/null 2>&1
-	_scratch_mount >/dev/null 2>&1 \
+	_try_scratch_mount >/dev/null 2>&1 \
 	   || _notrun "Kernel doesn't support crc feature"
 	_scratch_unmount
 }
@@ -233,7 +233,7 @@ _require_xfs_crc()
 _require_scratch_xfs_crc()
 {
 	_scratch_mkfs_xfs >/dev/null 2>&1
-	_scratch_mount >/dev/null 2>&1 \
+	_try_scratch_mount >/dev/null 2>&1 \
 	   || _notrun "Kernel doesn't support crc feature"
 	xfs_info $SCRATCH_MNT | grep -q 'crc=1' || _notrun "crc feature not supported by this filesystem"
 	_scratch_unmount
@@ -252,7 +252,7 @@ _require_xfs_mkfs_finobt()
 _require_xfs_finobt()
 {
 	_scratch_mkfs_xfs -m crc=1,finobt=1 >/dev/null 2>&1
-	_scratch_mount >/dev/null 2>&1 \
+	_try_scratch_mount >/dev/null 2>&1 \
 	   || _notrun "Kernel doesn't support finobt feature"
 	_scratch_unmount
 }
@@ -280,7 +280,7 @@ _require_xfs_sparse_inodes()
 	_scratch_mkfs_xfs_supported -m crc=1 -i sparse > /dev/null 2>&1 \
 		|| _notrun "mkfs.xfs does not support sparse inodes"
 	_scratch_mkfs_xfs -m crc=1 -i sparse > /dev/null 2>&1
-	_scratch_mount >/dev/null 2>&1 \
+	_try_scratch_mount >/dev/null 2>&1 \
 		|| _notrun "kernel does not support sparse inodes"
 	_scratch_unmount
 }
@@ -599,7 +599,7 @@ _require_meta_uuid()
 
 	_scratch_xfs_db -x -c "uuid generate" >/dev/null 2>&1
 
-	_scratch_mount >/dev/null 2>&1 \
+	_try_scratch_mount >/dev/null 2>&1 \
 	   || _notrun "Kernel doesn't support meta_uuid feature"
 	_scratch_unmount
 }
diff --git a/tests/btrfs/004 b/tests/btrfs/004
index 1b5b124d9a89..de583cc355d4 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -185,7 +185,7 @@ workout()
 	echo ""                                     >>$seqres.full
 	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
 		|| _fail "size=$fsz mkfs failed"
-	run_check _scratch_mount
+	_scratch_mount
 	# -w ensures that the only ops are ones which cause write I/O
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p $procs -n 2000 \
 		$FSSTRESS_AVOID
@@ -194,7 +194,7 @@ workout()
 		$SCRATCH_MNT/$snap_name
 
 	run_check _scratch_unmount >/dev/null 2>&1
-	run_check _scratch_mount "-o compress=lzo"
+	_scratch_mount "-o compress=lzo"
 
 	# make some noise but ensure we're not touching existing data
 	# extents.
@@ -208,7 +208,7 @@ workout()
 	run_check $FSSTRESS_PROG -d $clean_dir -w -p $procs -n 2000 \
 		$FSSTRESS_AVOID
 	run_check _scratch_unmount >/dev/null 2>&1
-	run_check _scratch_mount "-o atime"
+	_scratch_mount "-o atime"
 
 	if [ $do_bg_noise -ne 0 ]; then
 		# make background noise while backrefs are being walked
diff --git a/tests/btrfs/007 b/tests/btrfs/007
index 57f9a79f5f6f..a8414b21feac 100755
--- a/tests/btrfs/007
+++ b/tests/btrfs/007
@@ -65,7 +65,7 @@ workout()
 	echo ""                                     >>$seqres.full
 	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
 		|| _fail "size=$fsz mkfs failed"
-	run_check _scratch_mount "-o noatime"
+	_scratch_mount "-o noatime"
 
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -n $ops $FSSTRESS_AVOID -x \
 		"$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base"
@@ -91,7 +91,7 @@ workout()
 	echo ""                                     >>$seqres.full
 	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
 		|| _fail "size=$fsz mkfs failed"
-	run_check _scratch_mount "-o noatime"
+	_scratch_mount "-o noatime"
 
 	_run_btrfs_util_prog receive $SCRATCH_MNT < $tmp/base.snap
 	run_check $FSSUM_PROG -r $tmp/base.fssum $SCRATCH_MNT/base
diff --git a/tests/btrfs/009 b/tests/btrfs/009
index 2ffb81730d24..d720400519cf 100755
--- a/tests/btrfs/009
+++ b/tests/btrfs/009
@@ -59,7 +59,7 @@ $BTRFS_UTIL_PROG subvolume set-default $subvolid $SCRATCH_MNT >> $seqres.full 2>
 	|| _fail "couldn't set default"
 $BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/newvol >> $seqres.full 2>&1
 _scratch_unmount
-_scratch_mount || _fail "mount should have succeeded"
+_try_scratch_mount || _fail "mount should have succeeded"
 
 echo "Silence is golden"
 status=0 ; exit
diff --git a/tests/btrfs/012 b/tests/btrfs/012
index 85c82f07df4e..ac0f405a0d9a 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -74,7 +74,7 @@ _scratch_unmount
 # Convert it to btrfs, mount it, verify the data
 $BTRFS_CONVERT_PROG $SCRATCH_DEV >> $seqres.full 2>&1 || \
 	_fail "btrfs-convert failed"
-_scratch_mount || _fail "Could not mount new btrfs fs"
+_try_scratch_mount || _fail "Could not mount new btrfs fs"
 # (Ignore the symlinks which may be broken/nonexistent)
 diff -r /lib/modules/`uname -r`/ $SCRATCH_MNT/`uname -r`/ 2>&1 | grep -vw "source\|build"
 
@@ -114,7 +114,7 @@ _scratch_unmount
 # Convert it to btrfs, mount it and delete "ext2_saved"
 $BTRFS_CONVERT_PROG $SCRATCH_DEV >> $seqres.full 2>&1 || \
 	_fail "btrfs-convert failed"
-_scratch_mount || _fail "Could not mount new btrfs fs"
+_try_scratch_mount || _fail "Could not mount new btrfs fs"
 $BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/ext2_saved >> $seqres.full 2>&1 ||
 	_fail "failed to delete ext2_saved subvolume"
 _scratch_unmount
diff --git a/tests/btrfs/042 b/tests/btrfs/042
index cf3eac239b0f..be349e3d49c4 100755
--- a/tests/btrfs/042
+++ b/tests/btrfs/042
@@ -48,7 +48,7 @@ _require_btrfs_qgroup_report
 rm -f $seqres.full
 
 run_check _scratch_mkfs
-run_check _scratch_mount
+_scratch_mount
 
 LIMIT_SIZE=$((10 * 1024 * 1024))
 
diff --git a/tests/btrfs/057 b/tests/btrfs/057
index 8d355795359e..a834b7639d8f 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -54,7 +54,7 @@ run_check _scratch_mkfs "-b 1g --nodesize 4096"
 # inode cache is saved in the FS tree itself for every
 # individual FS tree,that affects the sizes reported by qgroup show
 # so we need to explicitly turn it off to get consistent values.
-run_check _scratch_mount "-o noinode_cache"
+_scratch_mount "-o noinode_cache"
 
 # -w ensures that the only ops are ones which cause write I/O
 run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p 5 -n 1000 \
diff --git a/tests/btrfs/091 b/tests/btrfs/091
index e3c43c761b4c..ca1d64c3dc09 100755
--- a/tests/btrfs/091
+++ b/tests/btrfs/091
@@ -61,12 +61,12 @@ run_check _scratch_mkfs "--nodesize $NODESIZE"
 # result.
 # discard error output since we will check return value manually.
 # also disable all compression, or output will mismatch with golden output
-_scratch_mount "-o noinode_cache,compress=no,compress-force=no" 2> /dev/null
+_try_scratch_mount "-o noinode_cache,compress=no,compress-force=no" 2> /dev/null
 
 # Check for old kernel which doesn't support 'noinode_cache' mount option
 if [ $? -ne 0 ]; then
 	support_noinode_cache="no"
-	run_check _scratch_mount
+	_scratch_mount
 fi
 
 _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv1
diff --git a/tests/btrfs/131 b/tests/btrfs/131
index ce486e6870e1..f7a0286e88d0 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -114,8 +114,8 @@ _scratch_unmount
 
 mkfs_v2
 echo "Trying to mount without free space tree"
-_scratch_mount -o nospace_cache >/dev/null 2>&1 || echo "mount failed"
-_scratch_mount -o space_cache=v1 >/dev/null 2>&1 || echo "mount failed"
+_try_scratch_mount -o nospace_cache >/dev/null 2>&1 || echo "mount failed"
+_try_scratch_mount -o space_cache=v1 >/dev/null 2>&1 || echo "mount failed"
 
 mkfs_v2
 echo "Mounting existing free space tree"
diff --git a/tests/btrfs/136 b/tests/btrfs/136
index d5408661bb7a..6d46bd6c7daa 100755
--- a/tests/btrfs/136
+++ b/tests/btrfs/136
@@ -102,7 +102,7 @@ _scratch_unmount
 # Convert non-extent & extent data to btrfs, mount it, verify the data
 $BTRFS_CONVERT_PROG $SCRATCH_DEV >> $seqres.full 2>&1 || \
 	_fail "btrfs-convert failed"
-_scratch_mount || _fail "Could not mount new btrfs fs"
+_try_scratch_mount || _fail "Could not mount new btrfs fs"
 
 # Compute md5 for converted files.
 find "$SCRATCH_MNT/ext3_ext4_data" -type f -fprint "$BTRFS_MD5SUM"
diff --git a/tests/ext4/003 b/tests/ext4/003
index eafe9a53cb34..7f2d6974fb38 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -44,7 +44,7 @@ rm -f $seqres.full
 
 $MKFS_EXT4_PROG -F -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
 	>> $seqres.full 2>&1
-_scratch_mount || _fail "couldn't mount fs"
+_scratch_mount
 
 $XFS_IO_PROG -f -c "pwrite 0 256m -b 1M" $SCRATCH_MNT/testfile 2>&1 | \
 	_filter_xfs_io
diff --git a/tests/ext4/006 b/tests/ext4/006
index bb9b7e574c29..a1e511e30c99 100755
--- a/tests/ext4/006
+++ b/tests/ext4/006
@@ -112,7 +112,7 @@ echo "++ corrupt image" >> $seqres.full
 e2fuzz ${FUZZ_ARGS} ${SCRATCH_DEV} >> $seqres.full 2>&1
 
 echo "++ mount image" >> $seqres.full
-_scratch_mount >> $seqres.full 2>&1
+_try_scratch_mount >> $seqres.full 2>&1
 
 echo "++ test scratch" >> $seqres.full
 _scratch_fuzz_test >> $seqres.full 2>&1
@@ -134,7 +134,7 @@ _check_scratch_fs >> $seqres.full 2>&1
 
 ROUND2_LOG="${tmp}-round2-${fsck_pass}.log"
 echo "++ mount image (2)" >> $ROUND2_LOG
-_scratch_mount >> $ROUND2_LOG 2>&1
+_try_scratch_mount >> $ROUND2_LOG 2>&1
 
 echo "++ chattr -R -i" >> $ROUND2_LOG
 $CHATTR_PROG -R -f -i "${SCRATCH_MNT}/" > /dev/null 2>> $ROUND2_LOG
diff --git a/tests/ext4/007 b/tests/ext4/007
index 6719c8b9450f..aeaa2d322930 100755
--- a/tests/ext4/007
+++ b/tests/ext4/007
@@ -89,7 +89,7 @@ dumpe2fs -g "${SCRATCH_DEV}" 2>/dev/null | awk -F ':' '{if ($1 == 0) {print $3}}
 done
 
 echo "+ mount image"
-_scratch_mount 2> /dev/null && _fail "mount should not succeed"
+_try_scratch_mount 2> /dev/null && _fail "mount should not succeed"
 
 echo "+ repair fs"
 # Have to specify backup sb and blocksize here so we don't pick up superblocks
diff --git a/tests/ext4/008 b/tests/ext4/008
index 7264f3723133..c84a28bfb0a9 100755
--- a/tests/ext4/008
+++ b/tests/ext4/008
@@ -85,7 +85,7 @@ dumpe2fs -g "${SCRATCH_DEV}" 2>/dev/null | awk -F ':' '{if (int($4) != -1) {prin
 done
 
 echo "+ mount image"
-_scratch_mount 2> /dev/null && _fail "mount should not succeed"
+_try_scratch_mount 2> /dev/null && _fail "mount should not succeed"
 
 echo "+ repair fs"
 e2fsck -fy "${SCRATCH_DEV}" >> $seqres.full 2>&1
diff --git a/tests/ext4/011 b/tests/ext4/011
index 03e4cd65bb87..c21442fce23c 100755
--- a/tests/ext4/011
+++ b/tests/ext4/011
@@ -73,13 +73,13 @@ blk="$(dumpe2fs "${SCRATCH_DEV}" 2> /dev/null | grep 'MMP block number' | sed -e
 $XFS_IO_PROG -f -c "pwrite -S 0x62 $((blk * blksz + 16)) 8" "${SCRATCH_DEV}" >> $seqres.full
 
 echo "+ mount image"
-_scratch_mount 2> /dev/null && _fail "mount should fail due to bad MMP"
+_try_scratch_mount 2> /dev/null && _fail "mount should fail due to bad MMP"
 
 echo "+ repair fs"
 e2fsck -fy "${SCRATCH_DEV}" >> $seqres.full 2>&1
 
 echo "+ mount image (2)"
-_scratch_mount || _fail "mount should not fail; MMP has been fixed"
+_try_scratch_mount || _fail "mount should not fail; MMP has been fixed"
 
 echo "+ check fs (2)"
 e2fsck -fn "${SCRATCH_DEV}" >> $seqres.full 2>&1 || _fail "fsck should not fail"
diff --git a/tests/ext4/012 b/tests/ext4/012
index 85880faf098d..1bf4fe5eb78f 100755
--- a/tests/ext4/012
+++ b/tests/ext4/012
@@ -72,13 +72,13 @@ echo "+ corrupt image"
 debugfs -w -R 'zap -f <8> 0' "${SCRATCH_DEV}" 2> /dev/null
 
 echo "+ mount image"
-_scratch_mount 2> /dev/null && _fail "mount should fail due to bad journal"
+_try_scratch_mount 2> /dev/null && _fail "mount should fail due to bad journal"
 
 echo "+ repair fs"
 e2fsck -fy "${SCRATCH_DEV}" >> $seqres.full 2>&1
 
 echo "+ mount image (2)"
-_scratch_mount || _fail "mount should not fail; journal has been fixed"
+_try_scratch_mount || _fail "mount should not fail; journal has been fixed"
 
 echo "+ check fs (2)"
 e2fsck -fn "${SCRATCH_DEV}" >> $seqres.full 2>&1 || _fail "fsck should not fail"
diff --git a/tests/ext4/024 b/tests/ext4/024
index c0d26ac6e769..a9ce24d406d4 100755
--- a/tests/ext4/024
+++ b/tests/ext4/024
@@ -79,7 +79,7 @@ _scratch_unmount
 debugfs -w -R "set_super_value s_last_orphan $inum" $SCRATCH_DEV &>>$seqres.full
 
 # Try to mount the filesystem.  This would hit a BUG() in fs/ext4/inode.c.
-_scratch_mount
+_try_scratch_mount
 
 # success, all done
 echo "Didn't crash!"
diff --git a/tests/ext4/025 b/tests/ext4/025
index 2a7b35fc3ee2..588c7a3f5379 100755
--- a/tests/ext4/025
+++ b/tests/ext4/025
@@ -58,7 +58,7 @@ _scratch_mkfs "-O bigalloc,meta_bg,^resize_inode" >> $seqres.full 2>&1
 $DEBUGFS_PROG -w -R "ssv first_meta_bg 842150400" $SCRATCH_DEV >> $seqres.full 2>&1
 
 echo "Try to mount a modified ext4 fs"
-_scratch_mount >> $seqres.full 2>&1 || echo "Fail to mount ext4 fs expectedly"
+_try_scratch_mount >> $seqres.full 2>&1 || echo "Fail to mount ext4 fs expectedly"
 
 # success, all done
 status=0
diff --git a/tests/ext4/305 b/tests/ext4/305
index 09db2e11fc49..b7331ae21fd0 100755
--- a/tests/ext4/305
+++ b/tests/ext4/305
@@ -61,7 +61,7 @@ PIDS=$!
 # 30 loops is enough to crash a buggy kernel
 i=0
 while [ $i -lt 30 ]; do
-	_scratch_mount
+	_try_scratch_mount
 	_scratch_unmount
 	let i=i+1
 done
diff --git a/tests/ext4/306 b/tests/ext4/306
index 70f281dbaf39..7d00bad6c1ce 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -53,7 +53,7 @@ if grep -q 64bit /etc/mke2fs.conf ; then
     features="^extents,^64bit"
 fi
 $MKFS_EXT4_PROG -F -O "$features" $SCRATCH_DEV 512m >> $seqres.full 2>&1
-_scratch_mount || _fail "couldn't mount fs"
+_scratch_mount
 
 # Create a small non-extent-based file
 echo "Create 1m testfile1"
diff --git a/tests/generic/015 b/tests/generic/015
index 9dcdde9e4462..bdae86dd6fb2 100755
--- a/tests/generic/015
+++ b/tests/generic/015
@@ -59,7 +59,7 @@ _require_no_large_scratch_dev
 # tolerance of 1%
 _scratch_mkfs_sized `expr 101 \* 1024 \* 1024` >/dev/null 2>&1 \
     || _fail "mkfs failed"
-_scratch_mount || _fail "mount failed"
+_scratch_mount
 out=$SCRATCH_MNT/fillup.$$
 rm -f $seqres.full
 
diff --git a/tests/generic/019 b/tests/generic/019
index 3b24c87ca25a..17ec7dd8229b 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -166,7 +166,7 @@ _workout()
 
 	# In order to check that filesystem is able to recover journal on mount(2)
 	# perform mount/umount, after that all errors should be fixed
-	run_check _scratch_mount
+	_scratch_mount
 	run_check _scratch_unmount
 }
 
@@ -174,7 +174,7 @@ _workout()
 
 rm -f $seqres.full
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
-_scratch_mount || _fail "mount failed"
+_scratch_mount
 allow_fail_make_request
 _workout
 status=$?
diff --git a/tests/generic/050 b/tests/generic/050
index e6e8bc1b9733..04acfb541fe5 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -61,7 +61,7 @@ blockdev --setro $SCRATCH_DEV
 # Mount it, and make sure we can't write to it, and we can unmount it again
 #
 echo "mounting read-only block device:"
-_scratch_mount 2>&1 | _filter_ro_mount
+_try_scratch_mount 2>&1 | _filter_ro_mount
 
 echo "touching file on read-only filesystem (should fail)"
 touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
@@ -77,7 +77,7 @@ echo "setting device read-write"
 blockdev --setrw $SCRATCH_DEV
 
 echo "mounting read-write block device:"
-_scratch_mount 2>&1 | _filter_scratch
+_try_scratch_mount 2>&1 | _filter_scratch
 
 echo "touch files"
 touch $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
@@ -96,7 +96,7 @@ blockdev --setro $SCRATCH_DEV
 # -o norecovery is used.
 #
 echo "mounting filesystem that needs recovery on a read-only device:"
-_scratch_mount 2>&1 | _filter_ro_mount
+_try_scratch_mount 2>&1 | _filter_ro_mount
 
 echo "unmounting read-only filesystem"
 _scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
@@ -107,7 +107,7 @@ _scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
 # data recovery hack.
 #
 echo "mounting filesystem with -o norecovery on a read-only device:"
-_scratch_mount -o norecovery 2>&1 | _filter_ro_mount
+_try_scratch_mount -o norecovery 2>&1 | _filter_ro_mount
 
 echo "unmounting read-only filesystem"
 _scratch_unmount 2>&1 | _filter_scratch
@@ -120,7 +120,7 @@ blockdev --setrw $SCRATCH_DEV
 # the underlying device is not write protected.
 #
 echo "mounting filesystem that needs recovery with -o ro:"
-_scratch_mount -o ro 2>&1 | _filter_scratch
+_try_scratch_mount -o ro 2>&1 | _filter_scratch
 
 # success, all done
 echo "*** done"
diff --git a/tests/generic/052 b/tests/generic/052
index 126f08e63311..168b55c2df95 100755
--- a/tests/generic/052
+++ b/tests/generic/052
@@ -56,8 +56,7 @@ _scratch_mkfs >>$seqres.full 2>&1 \
 _require_metadata_journaling $SCRATCH_DEV
 
 echo "mount"
-_scratch_mount >>$seqres.full 2>&1 \
-    || _fail "mount failed: $MOUNT_OPTIONS"
+_scratch_mount
 
 echo "touch files"
 touch $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
@@ -79,7 +78,7 @@ if false; then
 fi
 
 echo "mount with replay"
-_scratch_mount $mnt >>$seqres.full 2>&1 \
+_try_scratch_mount $mnt >>$seqres.full 2>&1 \
     || _fail "mount failed: $mnt $MOUNT_OPTIONS"
 
 echo "ls SCRATCH_MNT"
diff --git a/tests/generic/053 b/tests/generic/053
index cf46a93cf727..e2765d2f4c05 100755
--- a/tests/generic/053
+++ b/tests/generic/053
@@ -48,7 +48,7 @@ test=$SCRATCH_MNT/test
 
 # make filesystem on scratch using the defaults
 _do 'make filesystem on $SCRATCH_DEV' '_scratch_mkfs'
-_do 'mount filesytem' '_scratch_mount'
+_do 'mount filesytem' '_try_scratch_mount'
 
 # create test files and set acls
 acls="
diff --git a/tests/generic/054 b/tests/generic/054
index 12f471a19090..84b76e67e51d 100755
--- a/tests/generic/054
+++ b/tests/generic/054
@@ -83,7 +83,7 @@ for s in sync nosync ; do
 
 	# mount the FS
 	_echofull "mount"
-	if ! _scratch_mount >>$seqres.full 2>&1; then
+	if ! _try_scratch_mount >>$seqres.full 2>&1; then
 	    _echofull "mount failed: $MOUNT_OPTIONS"
 	    continue
 	fi
@@ -118,7 +118,7 @@ for s in sync nosync ; do
 	_print_logstate
 
 	_echofull "mount with replay"
-	_scratch_mount >>$seqres.full 2>&1 \
+	_try_scratch_mount >>$seqres.full 2>&1 \
 	    || _fail "mount failed: $MOUNT_OPTIONS"
 
 	# check on what FS looks like after log recovery
diff --git a/tests/generic/055 b/tests/generic/055
index c543e7517940..7f565251bb28 100755
--- a/tests/generic/055
+++ b/tests/generic/055
@@ -105,7 +105,7 @@ do
 
     # mount the FS
     _echofull "mount"
-    if ! _scratch_mount $QUOTA_OPTION >>$seqres.full 2>&1; then
+    if ! _try_scratch_mount $QUOTA_OPTION >>$seqres.full 2>&1; then
 	_echofull "mount failed: $MOUNT_OPTIONS"
 	continue
     fi
@@ -131,7 +131,7 @@ do
     _scratch_xfs_logprint -n >>$seqres.full 2>&1
 
     _echofull "mount with replay"
-    _scratch_mount $QUOTA_OPTION >>$seqres.full 2>&1 \
+    _try_scratch_mount $QUOTA_OPTION >>$seqres.full 2>&1 \
 	|| _fail "mount failed: $MOUNT_OPTIONS"
 
     # check on what FS looks like after log recovery
diff --git a/tests/generic/062 b/tests/generic/062
index 643f02c3f799..f0820eac916a 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -80,7 +80,7 @@ rm -f $tmp.backup1 $tmp.backup2 $seqres.full
 
 # real QA test starts here
 _scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
-_scratch_mount || _fail "mount failed"
+_scratch_mount
 _create_test_bed
 
 # In kernels before 3.0, getxattr() fails with EPERM for an attribute which
diff --git a/tests/generic/064 b/tests/generic/064
index 156485eef3a9..26fb630168b2 100755
--- a/tests/generic/064
+++ b/tests/generic/064
@@ -50,7 +50,7 @@ _require_xfs_io_command "fcollapse"
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
-_scratch_mount || _fail "mount failed"
+_scratch_mount
 
 src=$SCRATCH_MNT/testfile
 dest=$SCRATCH_MNT/testfile.dest
diff --git a/tests/generic/068 b/tests/generic/068
index bd12278cdd25..1a852534a549 100755
--- a/tests/generic/068
+++ b/tests/generic/068
@@ -62,8 +62,7 @@ echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs                               >>$seqres.full 2>&1 \
     || _fail "mkfs failed"
-_scratch_mount                              >>$seqres.full 2>&1 \
-    || _fail "mount failed"
+_scratch_mount
 
 touch $tmp.running
 
diff --git a/tests/generic/069 b/tests/generic/069
index 15586e9b9144..0121929ba78b 100755
--- a/tests/generic/069
+++ b/tests/generic/069
@@ -48,7 +48,7 @@ echo "*** mkfs"
 _scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
 
 echo "*** mount FS"
-_scratch_mount >/dev/null || _fail "mount failed"
+_scratch_mount
 
 cd $SCRATCH_MNT
 
diff --git a/tests/generic/076 b/tests/generic/076
index ac7653332cb0..033bc005dca3 100755
--- a/tests/generic/076
+++ b/tests/generic/076
@@ -66,8 +66,7 @@ echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs                               >>$seqres.full 2>&1 \
 	|| _fail "mkfs failed"
-_scratch_mount                              >>$seqres.full 2>&1 \
-	|| _fail "mount failed"
+_scratch_mount
 
 echo "*** test concurrent block/fs access"
 
diff --git a/tests/generic/077 b/tests/generic/077
index add16ea8f523..1175f6f4b554 100755
--- a/tests/generic/077
+++ b/tests/generic/077
@@ -68,8 +68,7 @@ echo ""                                     >>$seqres.full
 SIZE=`expr 50 \* 1024 \* 1024`
 _scratch_mkfs_sized $SIZE                   >>$seqres.full 2>&1 \
 	|| _fail "mkfs failed"
-_scratch_mount                              >>$seqres.full 2>&1 \
-	|| _fail "mount failed"
+_scratch_mount
 mkdir $SCRATCH_MNT/subdir
 
 echo "*** set default ACL"
diff --git a/tests/generic/079 b/tests/generic/079
index c2db6bf1f744..7669249ce8c4 100755
--- a/tests/generic/079
+++ b/tests/generic/079
@@ -53,7 +53,7 @@ _require_scratch
 
 # real QA test starts here
 _scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
-_scratch_mount || _fail "mount failed"
+_scratch_mount
 
 echo "*** starting up"
 $timmutable -c $SCRATCH_MNT/$seq >$tmp.out 2>&1
diff --git a/tests/generic/082 b/tests/generic/082
index a41afe6e6d20..7a11c1ac9538 100755
--- a/tests/generic/082
+++ b/tests/generic/082
@@ -68,10 +68,10 @@ quotaon $SCRATCH_MNT >>$seqres.full 2>&1
 # quota, but currently xfs doesn't fail in this case, the unknown option is
 # just ignored, but quota is still on. This may change in future, let's
 # re-consider the case then.
-_scratch_mount "-o remount,ro,nosuchopt" >>$seqres.full 2>&1
+_try_scratch_mount "-o remount,ro,nosuchopt" >>$seqres.full 2>&1
 quotaon -p $SCRATCH_MNT | _filter_scratch | filter_project_quota_line
 # second remount should succeed, no oops or hang expected
-_scratch_mount "-o remount,ro" || _fail "second remount,ro failed"
+_try_scratch_mount "-o remount,ro" || _fail "second remount,ro failed"
 
 # success, all done
 status=0
diff --git a/tests/generic/083 b/tests/generic/083
index 9f09a7b09e8b..ac97952c35c0 100755
--- a/tests/generic/083
+++ b/tests/generic/083
@@ -78,8 +78,7 @@ workout()
 		_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
 			|| _fail "size=$fsz mkfs failed"
 	fi
-	_scratch_mount                              >>$seqres.full 2>&1 \
-		|| _fail "mount failed"
+	_scratch_mount
 
 	# -w ensures that the only ops are ones which cause write I/O
 	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs -n $nops $FSSTRESS_AVOID`
diff --git a/tests/generic/105 b/tests/generic/105
index 8b6aa5268bc0..6ee123e4a070 100755
--- a/tests/generic/105
+++ b/tests/generic/105
@@ -62,7 +62,7 @@ echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs                               >>$seqres.full 2>&1 \
 	|| _fail "mkfs failed"
-_scratch_mount                              >>$seqres.full 2>&1 \
+_try_scratch_mount                      >>$seqres.full 2>&1 \
 	|| _fail "mount failed"
 
 cd $SCRATCH_MNT
diff --git a/tests/generic/117 b/tests/generic/117
index 58165eaac7cd..67e68c6e91e2 100755
--- a/tests/generic/117
+++ b/tests/generic/117
@@ -87,8 +87,7 @@ echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs                               >>$seqres.full 2>&1 \
     || _fail "mkfs failed"
-_scratch_mount                              >>$seqres.full 2>&1 \
-    || _fail "mount failed"
+_scratch_mount
 
 mkdir -p $SCRATCH_MNT/fsstress
 
diff --git a/tests/generic/120 b/tests/generic/120
index 7d65f6201e86..1180c10a59f1 100755
--- a/tests/generic/120
+++ b/tests/generic/120
@@ -60,7 +60,7 @@ _compare_access_times()
 
 }
 
-if ! _scratch_mount "-o noatime" >$tmp.out 2>&1
+if ! _try_scratch_mount "-o noatime" >$tmp.out 2>&1
 then
     cat $tmp.out
     echo "!!! mount failed"
diff --git a/tests/generic/169 b/tests/generic/169
index f51f4d1981ea..f0ed55edbdc5 100755
--- a/tests/generic/169
+++ b/tests/generic/169
@@ -60,8 +60,7 @@ _require_scratch
 _scratch_mkfs >>$seqres.full 2>&1 \
 	|| _fail "mkfs scratch failed"
 
-_scratch_mount >>$seqres.full 2>&1 \
-    || _fail "mount failed: $MOUNT_OPTIONS"
+_scratch_mount
 
 echo "# creating new file for io"
 touch $SCRATCH_MNT/testfile
diff --git a/tests/generic/235 b/tests/generic/235
index f991b1b73ea0..9cd24729e570 100755
--- a/tests/generic/235
+++ b/tests/generic/235
@@ -69,9 +69,9 @@ do_repquota
 # https://bugzilla.redhat.com/show_bug.cgi?id=563267
 #
 # then you need a more recent mount binary.
-_scratch_mount "-o remount,ro" 2>&1 | tee -a $seqres.full | _filter_scratch
+_try_scratch_mount "-o remount,ro" 2>&1 | tee -a $seqres.full | _filter_scratch
 touch $SCRATCH_MNT/failed 2>&1 | tee -a $seqres.full | _filter_scratch
-_scratch_mount "-o remount,rw" 2>&1 | tee -a $seqres.full | _filter_scratch
+_try_scratch_mount "-o remount,rw" 2>&1 | tee -a $seqres.full | _filter_scratch
 
 $XFS_IO_PROG -c 'pwrite 0 8k' -c 'fsync' \
 			$SCRATCH_MNT/testfile >>$seqres.full 2>&1
diff --git a/tests/generic/270 b/tests/generic/270
index 318f532ae9c0..f5026ba0cd30 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -83,7 +83,7 @@ _require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
-_scratch_mount "-o usrquota,grpquota" || _fail "mount failed"
+_scratch_mount "-o usrquota,grpquota"
 chmod 777 $SCRATCH_MNT
 quotacheck -u -g $SCRATCH_MNT 2>/dev/null
 quotaon -u -g $SCRATCH_MNT 2>/dev/null
diff --git a/tests/generic/294 b/tests/generic/294
index fb5d9aa80524..16687ded2878 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -67,7 +67,7 @@ rm -rf $THIS_TEST_DIR
 mkdir $THIS_TEST_DIR || _fail "Could not create dir for test"
 
 _create_files 2>&1 | _filter_scratch
-_scratch_mount -o remount,ro || _fail "Could not remount scratch readonly"
+_try_scratch_mount -o remount,ro || _fail "Could not remount scratch readonly"
 _create_files 2>&1 | _filter_scratch
 
 # success, all done
diff --git a/tests/generic/317 b/tests/generic/317
index 7e40b1fd7612..6d1e932bde1f 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -83,7 +83,7 @@ _scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***" >>$seqres.full
 echo ""             >>$seqres.full
 _scratch_mkfs       >>$seqres.full 2>&1 || _fail "mkfs failed"
-_scratch_mount      >>$seqres.full 2>&1 || _fail "mount failed"
+_scratch_mount
 chmod 777 $SCRATCH_MNT
 
 # create $file as "root" in userns, which is $qa_user in parent namespace
diff --git a/tests/generic/318 b/tests/generic/318
index e284317bd5cd..1c9b3f21dae9 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -93,7 +93,7 @@ _scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***" >>$seqres.full
 echo ""             >>$seqres.full
 _scratch_mkfs       >>$seqres.full 2>&1 || _fail "mkfs failed"
-_scratch_mount      >>$seqres.full 2>&1 || _fail "mount failed"
+_scratch_mount
 
 touch $file
 chown $acl1.$acl1 $file
diff --git a/tests/generic/388 b/tests/generic/388
index e0f482182299..863f0d899b62 100755
--- a/tests/generic/388
+++ b/tests/generic/388
@@ -64,7 +64,7 @@ echo "Silence is golden."
 
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
-_scratch_mount || _fail "mount failed"
+_scratch_mount
 
 for i in $(seq 1 $((50 * TIME_FACTOR)) ); do
 	($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -n 999999 -p 4 >> $seqres.full &) \
diff --git a/tests/generic/390 b/tests/generic/390
index 473015a2ad30..3bc6de237330 100755
--- a/tests/generic/390
+++ b/tests/generic/390
@@ -58,7 +58,7 @@ _require_test_program "feature"
 
 _scratch_mkfs >>$seqres.full 2>&1
 # We don't want to freeze/unfreeze root fs if mount scratch dev failed
-_scratch_mount >>$seqres.full 2>&1 || _fail "mount failed"
+_scratch_mount
 
 num_cpus=`$here/src/feature -o`
 
diff --git a/tests/generic/403 b/tests/generic/403
index 31c481b4e23e..d6706d3dd640 100755
--- a/tests/generic/403
+++ b/tests/generic/403
@@ -54,7 +54,7 @@ _require_scratch
 _require_attrs
 
 _scratch_mkfs > $seqres.full 2>&1 || _fail "mkfs"
-_scratch_mount || _fail "mount"
+_scratch_mount
 
 # create xattr small enough for local format on XFS
 touch $SCRATCH_MNT/file
diff --git a/tests/generic/466 b/tests/generic/466
index 07f24a746151..341f0722ce3b 100755
--- a/tests/generic/466
+++ b/tests/generic/466
@@ -60,7 +60,7 @@ for blocksize in 512 1024 2048 4096 8192 16384 32768 65536; do
 	# Try to format and mount with the given blocksize.  If they don't
 	# succeed, move on to the next block size.
 	if ! _scratch_mkfs_sized $devsize $blocksize >> $seqres.full 2>&1 ||
-	   ! _scratch_mount >> $seqres.full 2>&1 ||
+	   ! _try_scratch_mount >> $seqres.full 2>&1 ||
 	   test "$(stat -f -c '%S' $SCRATCH_MNT)" -ne "$blocksize"; then
 		echo "+++ Format and mount failed" >> $seqres.full
 		continue
diff --git a/tests/shared/003 b/tests/shared/003
index 8e02e8215848..9a9956cf44de 100755
--- a/tests/shared/003
+++ b/tests/shared/003
@@ -63,7 +63,7 @@ debugfs -w -R "feature +needs_recovery" $SCRATCH_DEV \
 	>>$seqres.full 2>&1
 
 # mount with noload option
-_scratch_mount "-o noload" >>$seqres.full 2>&1
+_try_scratch_mount "-o noload" >>$seqres.full 2>&1
 
 # success, all done
 status=0
diff --git a/tests/xfs/005 b/tests/xfs/005
index ebf4b15ec9b5..0978729bcfa6 100755
--- a/tests/xfs/005
+++ b/tests/xfs/005
@@ -59,7 +59,7 @@ _scratch_mkfs_xfs -m crc=1 >> $seqres.full 2>&1 || _fail "mkfs failed"
 $XFS_IO_PROG -c "pwrite 224 4" -c fsync $SCRATCH_DEV | _filter_xfs_io
 
 # should FAIL, the crc is bad; golden output contains mount failure
-_scratch_mount 2>&1 | _filter_error_mount
+_try_scratch_mount 2>&1 | _filter_error_mount
 
 # success, all done
 status=0
diff --git a/tests/xfs/009 b/tests/xfs/009
index 1a5bd4d346fd..1caeb33e780f 100755
--- a/tests/xfs/009
+++ b/tests/xfs/009
@@ -58,7 +58,7 @@ _init()
     fi
 
     echo "*** mount"
-    if ! _scratch_mount
+    if ! _try_scratch_mount
     then
         echo "failed to mount $SCRATCH_DEV"
         exit 1
diff --git a/tests/xfs/016 b/tests/xfs/016
index 0163716047d5..fde76622fad9 100755
--- a/tests/xfs/016
+++ b/tests/xfs/016
@@ -91,7 +91,7 @@ _log_traffic()
     out=$SCRATCH_MNT/$$.tmp
 
     echo "   *** mount"
-    if ! _scratch_mount
+    if ! _try_scratch_mount
     then
         echo "failed to mount $SCRATCH_DEV"
         exit 1
diff --git a/tests/xfs/017 b/tests/xfs/017
index b576cd154038..5aeba16e0b2e 100755
--- a/tests/xfs/017
+++ b/tests/xfs/017
@@ -59,8 +59,7 @@ echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs_xfs                           >>$seqres.full 2>&1 \
     || _fail "mkfs failed"
-_scratch_mount                              >>$seqres.full 2>&1 \
-    || _fail "mount failed"
+_scratch_mount
 
 echo "*** test"
 
@@ -70,7 +69,7 @@ do
 	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -n 1000 $FSSTRESS_AVOID`
         $FSSTRESS_PROG  $FSSTRESS_ARGS >>$seqres.full
 
-        _scratch_mount -o remount,ro \
+        _try_scratch_mount -o remount,ro \
             || _fail "remount ro failed"
 
         echo ""                                 >>$seqres.full
@@ -84,7 +83,7 @@ do
         echo ""                             >>$seqres.full
         _scratch_xfs_check                  >>$seqres.full 2>&1 \
             || _fail "xfs_check failed"
-        _scratch_mount -o remount,rw \
+        _try_scratch_mount -o remount,rw \
             || _fail "remount rw failed"
 done
 
diff --git a/tests/xfs/019 b/tests/xfs/019
index 3e4f1692ff89..10d4494682c5 100755
--- a/tests/xfs/019
+++ b/tests/xfs/019
@@ -122,7 +122,7 @@ _verify_fs()
 
 	echo "*** mount FS"
 	_full " mount"
-	_scratch_mount >>$seqfull 2>&1 \
+	_try_scratch_mount >>$seqfull 2>&1 \
 		|| _fail "mount failed"
 
 	echo "*** verify FS"
diff --git a/tests/xfs/021 b/tests/xfs/021
index 0471b9539af7..f8f4e1565905 100755
--- a/tests/xfs/021
+++ b/tests/xfs/021
@@ -87,8 +87,7 @@ _scratch_mkfs_xfs >/dev/null \
 	|| _fail "mkfs failed"
 
 echo "*** mount FS"
-_scratch_mount >/dev/null \
-	|| _fail "mount failed"
+_scratch_mount
 
 testfile=$SCRATCH_MNT/testfile
 echo "*** make test file 1"
diff --git a/tests/xfs/034 b/tests/xfs/034
index 2bf319bf6882..a3db571ad021 100755
--- a/tests/xfs/034
+++ b/tests/xfs/034
@@ -57,8 +57,7 @@ echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 _scratch_mkfs_xfs                           >>$seqres.full 2>&1 \
     || _fail "mkfs failed"
-_scratch_mount                              >>$seqres.full 2>&1 \
-    || _fail "mount failed"
+_scratch_mount
 
 echo "*** test"
 
diff --git a/tests/xfs/041 b/tests/xfs/041
index 1b9500f723bb..d5ecc6df8ca7 100755
--- a/tests/xfs/041
+++ b/tests/xfs/041
@@ -67,7 +67,7 @@ _scratch_mkfs_xfs -dsize=${agsize}m,agcount=1 2>&1 >/dev/null || _fail "mkfs fai
 bsize=`_scratch_mkfs_xfs -dsize=${agsize}m,agcount=1 2>&1 | _filter_mkfs 2>&1 \
 		| perl -ne 'if (/dbsize=(\d+)/) {print $1;}'`
 onemeginblocks=`expr 1048576 / $bsize`
-_scratch_mount || _fail "mount failed"
+_scratch_mount
 
 echo "done"
 
@@ -81,7 +81,7 @@ do
     _do "Grow filesystem to ${size}m" "xfs_growfs -D $grow_size $SCRATCH_MNT"
     echo -n "Flush filesystem... "
     _do "_scratch_unmount"
-    _do "_scratch_mount"
+    _do "_try_scratch_mount"
     echo "done"
     echo -n "Check files... "
     if ! _do "src/fill2fs_check $tmp.manifest"; then
diff --git a/tests/xfs/042 b/tests/xfs/042
index 182cebc313e3..45117d9c5a1c 100755
--- a/tests/xfs/042
+++ b/tests/xfs/042
@@ -75,7 +75,7 @@ _do_die_on_error=message_only
 
 echo -n "Make a 48 megabyte filesystem on SCRATCH_DEV and mount... "
 _scratch_mkfs_xfs -dsize=48m,agcount=3 2>&1 >/dev/null || _fail "mkfs failed"
-_scratch_mount || _fail "mount failed" 
+_scratch_mount
 
 echo "done"
 
@@ -97,7 +97,7 @@ _do "xfs_bmap -vp $SCRATCH_MNT/fill"
 echo "done"
 # flush the filesystem - make sure there is no space "lost" to pre-allocation
 _do "_scratch_unmount"
-_do "_scratch_mount"
+_do "_try_scratch_mount"
 echo -n "Use up any further available space... "
 _do "$XFS_IO_PROG -f -c \"falloc 0 1m\" $SCRATCH_MNT/pad"
 echo "done"
diff --git a/tests/xfs/044 b/tests/xfs/044
index fc5dae024e07..70f72d6930ad 100755
--- a/tests/xfs/044
+++ b/tests/xfs/044
@@ -60,7 +60,7 @@ _filter_logprint()
 _check_mount()
 {
     echo "    *** mount (expect success)"
-    if ! _scratch_mount
+    if ! _try_scratch_mount
     then
         echo "        !!! mount failed (expecting success)"
         status=1
@@ -79,7 +79,7 @@ _check_mount()
 _check_no_mount()
 {
     echo "    *** mount (expect failure)"
-    if _scratch_mount >$tmp.err 2>&1
+    if _try_scratch_mount >$tmp.err 2>&1
     then
         cat $tmp.err
         echo "        !!! mount succeeded (expecting failure)"
diff --git a/tests/xfs/045 b/tests/xfs/045
index 2733f5c1c22b..adf8566374b5 100755
--- a/tests/xfs/045
+++ b/tests/xfs/045
@@ -61,7 +61,7 @@ then
 fi
 
 echo "*** mount fs with bad mount option (expect failure)"
-if _scratch_mount -o foobar >$tmp.out 2>&1
+if _try_scratch_mount -o foobar >$tmp.out 2>&1
 then
     cat $tmp.out
     echo "!!! mount succeeded (expecting failure)"
@@ -72,7 +72,7 @@ echo "*** duplicate uuid"
 xfs_db -x -c "uuid $uuid" `_scratch_xfs_db_options` >/dev/null
 
 echo "*** mount fs with duplicate uuid (expect failure)"
-if _scratch_mount >$tmp.out 2>&1
+if _try_scratch_mount >$tmp.out 2>&1
 then
     cat $tmp.out
     echo "!!! mount succeeded (expecting failure)"
diff --git a/tests/xfs/057 b/tests/xfs/057
index 74a253e0ef19..228f52bb010f 100755
--- a/tests/xfs/057
+++ b/tests/xfs/057
@@ -77,7 +77,7 @@ sdev=$(_short_dev $SCRATCH_DEV)
 # use a small log fs
 _scratch_mkfs_sized $((1024 * 1024 * 500)) >> $seqres.full 2>&1 ||
 		_fail "mkfs failed"
-_scratch_mount || _fail "mount failed"
+_scratch_mount
 
 # populate the fs with some data and cycle the mount to reset the log head/tail
 $FSSTRESS_PROG -d $SCRATCH_MNT -z -fcreat=1 -p 4 -n 100000 > /dev/null 2>&1
diff --git a/tests/xfs/067 b/tests/xfs/067
index c68ec0940064..743d94bb3e8a 100755
--- a/tests/xfs/067
+++ b/tests/xfs/067
@@ -52,7 +52,7 @@ if [ "$isize" -lt 1024 ]; then
     _scratch_mkfs_xfs -i size=1024 >>$seqres.full \
 	|| _notrun "Cannot mkfs for this test using MKFS_OPTIONS specified"
 fi
-_scratch_mount >>$seqres.full || _fail "mount failed"
+_scratch_mount
 xfs_info $SCRATCH_MNT >>$seqres.full
 cd $SCRATCH_MNT
 
diff --git a/tests/xfs/072 b/tests/xfs/072
index 5393cf8b047b..074c786970d5 100755
--- a/tests/xfs/072
+++ b/tests/xfs/072
@@ -54,7 +54,7 @@ rm -f $seqres.full
 _scratch_unmount >/dev/null 2>&1
 
 _scratch_mkfs_xfs >/dev/null	|| _fail "mkfs failed"
-_scratch_mount >/dev/null	|| _fail "mount failed"
+_scratch_mount
 
 # check there's enough freespace on $SCRATCH_MNT ... (1GiB + 1MiB)
 avail=`df -P $SCRATCH_MNT | awk 'END {print $4}'`
diff --git a/tests/xfs/073 b/tests/xfs/073
index 7228dd92d6ae..9bcc95ddece9 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -139,7 +139,7 @@ _require_loop
 rm -f $seqres.full
 
 _scratch_mkfs_xfs -dsize=41m,agcount=2 >>$seqres.full 2>&1
-_scratch_mount 2>/dev/null || _fail "initial scratch mount failed"
+_scratch_mount
 
 echo
 echo === populating scratch device
diff --git a/tests/xfs/075 b/tests/xfs/075
index ccf29ea19db3..3c2c894820de 100755
--- a/tests/xfs/075
+++ b/tests/xfs/075
@@ -50,10 +50,10 @@ echo "Silence is golden"
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >$seqres.full
 
 # first ro mount with norecovery
-_scratch_mount "-o ro,norecovery" >>$seqres.full 2>&1 \
+_try_scratch_mount "-o ro,norecovery" >>$seqres.full 2>&1 \
 	|| _fail "First ro mount failed"
 # make sure a following remount,rw fails
-_scratch_mount "-o remount,rw" >>$seqres.full 2>&1 \
+_try_scratch_mount "-o remount,rw" >>$seqres.full 2>&1 \
 	&& _fail "Second rw remount succeeded"
 
 # success, all done
diff --git a/tests/xfs/077 b/tests/xfs/077
index 6d5ac1a36bd7..c4b4de96a190 100755
--- a/tests/xfs/077
+++ b/tests/xfs/077
@@ -70,7 +70,7 @@ _test_uuid()
 					| _filter_uuid $EXPECTED_UUID
 	NEW_UUID=`_scratch_xfs_db -c "uuid"  | awk '{print $NF}'`
 	_check_scratch_fs
-	_scratch_mount || _fail "Mount failed after UUID $ACTION"
+	_try_scratch_mount || _fail "Mount failed after UUID $ACTION"
 	_scratch_unmount
 
 }
@@ -127,7 +127,7 @@ $XFS_COPY_PROG $SCRATCH_DEV $IMGFILE 2>&1 >> $seqres.full || \
 _check_xfs_filesystem $IMGFILE none none || _fail "Copy looks corrupted"
 # The copy should have META_UUID feature set
 _fs_has_META_UUID $IMGFILE || _fail "META_UUID feature not set on copy"
-_scratch_mount || _fail "Mount failed after UUID rewrite"
+_try_scratch_mount || _fail "Mount failed after UUID rewrite"
 _scratch_unmount
 
 rm -f $IMGFILE
diff --git a/tests/xfs/079 b/tests/xfs/079
index 8ac9d58db38c..3079455a599a 100755
--- a/tests/xfs/079
+++ b/tests/xfs/079
@@ -78,7 +78,7 @@ wait
 # log record extended header count, as the log record header can only handle 32k
 # of space.
 _scratch_unmount
-_scratch_mount "-o logbsize=64k"
+_try_scratch_mount "-o logbsize=64k"
 
 # The mount may not fail on v4 filesystems. Check for CRC mismatch warning
 # messages to detect failure in this case.
diff --git a/tests/xfs/083 b/tests/xfs/083
index e2b5f823845d..5490bd20e8b3 100755
--- a/tests/xfs/083
+++ b/tests/xfs/083
@@ -75,7 +75,7 @@ scratch_repair() {
 	elif [ "${res}" -eq 2 ]; then
 		# replay log?
 		echo "+++ replaying log" >> "${FSCK_LOG}"
-		_scratch_mount >> "${FSCK_LOG}" 2>&1
+		_try_scratch_mount >> "${FSCK_LOG}" 2>&1
 		res=$?
 		echo "+++ mount returns ${res}" >> "${FSCK_LOG}"
 		if [ "${res}" -gt 0 ]; then
@@ -127,7 +127,7 @@ echo "++ corrupt image" >> $seqres.full
 xfs_db -x -c blockget -c "blocktrash ${FUZZ_ARGS}" "${SCRATCH_DEV}" >> $seqres.full 2>&1
 
 echo "++ mount image" >> $seqres.full
-_scratch_mount >> $seqres.full 2>&1
+_try_scratch_mount >> $seqres.full 2>&1
 
 echo "+++ test scratch" >> $seqres.full
 _scratch_fuzz_test >> $seqres.full 2>&1
@@ -149,7 +149,7 @@ _scratch_xfs_repair >> $seqres.full 2>&1
 
 ROUND2_LOG="${tmp}-round2-${fsck_pass}.log"
 echo "++ mount image (2)" >> $ROUND2_LOG
-_scratch_mount >> $ROUND2_LOG 2>&1
+_try_scratch_mount >> $ROUND2_LOG 2>&1
 
 echo "++ chattr -R -i" >> $ROUND2_LOG
 $CHATTR_PROG -R -f -i "${SCRATCH_MNT}/" > /dev/null 2>> $ROUND2_LOG
diff --git a/tests/xfs/085 b/tests/xfs/085
index 0c85850d2a62..57fc47c91d80 100755
--- a/tests/xfs/085
+++ b/tests/xfs/085
@@ -88,7 +88,7 @@ echo "+ corrupt image"
 $XFS_IO_PROG -f -c "pwrite -S 0x62 32 4" "${SCRATCH_DEV}" >> $seqres.full
 
 echo "+ mount image"
-_scratch_mount 2>/dev/null && _fail "mount should not succeed"
+_try_scratch_mount 2>/dev/null && _fail "mount should not succeed"
 
 echo "+ repair fs"
 _scratch_xfs_repair >> $seqres.full 2>&1
diff --git a/tests/xfs/090 b/tests/xfs/090
index 92b9e3d83d96..f4230bc292c9 100755
--- a/tests/xfs/090
+++ b/tests/xfs/090
@@ -57,7 +57,7 @@ _create_scratch()
 	fi
 
 	echo "*** mount"
-	if ! _scratch_mount
+	if ! _try_scratch_mount
 	then
 		echo "failed to mount $SCRATCH_DEV"
 		exit 1
diff --git a/tests/xfs/092 b/tests/xfs/092
index 5a6931957a85..ea3b12294549 100755
--- a/tests/xfs/092
+++ b/tests/xfs/092
@@ -53,7 +53,7 @@ MOUNT_OPTIONS="$MOUNT_OPTIONS -o inode64"
 _scratch_mkfs_xfs | _filter_mkfs 2>/dev/null
 echo Silence is golden
 
-_scratch_mount
+_try_scratch_mount
 [ $? -eq 0 ] || echo "inode64 mount failed unexpectedly!"
 
 # success, all done
diff --git a/tests/xfs/094 b/tests/xfs/094
index d3606f813815..13dcf6e2e77c 100755
--- a/tests/xfs/094
+++ b/tests/xfs/094
@@ -78,7 +78,7 @@ _create_scratch()
 	fi
 
 	echo "*** mount"
-	if ! _scratch_mount
+	if ! _try_scratch_mount
 	then
 		echo "failed to mount $SCRATCH_DEV"
 		exit 1
diff --git a/tests/xfs/098 b/tests/xfs/098
index 24ce1d5d44ed..b32fc493f853 100755
--- a/tests/xfs/098
+++ b/tests/xfs/098
@@ -94,7 +94,7 @@ logblocks="$(_scratch_xfs_get_sb_field logblocks)"
 $XFS_IO_PROG -f -c "pwrite -S 0x62 ${logstart} $((logblocks * blksz))" "${SCRATCH_DEV}" >> $seqres.full
 
 echo "+ mount image"
-_scratch_mount 2>/dev/null && _fail "mount should not succeed"
+_try_scratch_mount 2>/dev/null && _fail "mount should not succeed"
 
 echo "+ repair fs"
 _repair_scratch_fs >> $seqres.full 2>&1
diff --git a/tests/xfs/103 b/tests/xfs/103
index 024416bd47b6..90109e3bd91d 100755
--- a/tests/xfs/103
+++ b/tests/xfs/103
@@ -46,7 +46,7 @@ _create_scratch()
 	fi
 
 	echo "*** mount"
-	if ! _scratch_mount 2>/dev/null
+	if ! _try_scratch_mount 2>/dev/null
 	then
 		echo "failed to mount $SCRATCH_DEV"
 		exit 1
diff --git a/tests/xfs/104 b/tests/xfs/104
index c3b59775fdad..b716437400e9 100755
--- a/tests/xfs/104
+++ b/tests/xfs/104
@@ -42,7 +42,7 @@ _create_scratch()
 	. $tmp.mkfs
 
 	echo "*** mount"
-	if ! _scratch_mount 2>/dev/null
+	if ! _try_scratch_mount 2>/dev/null
 	then
 		echo "failed to mount $SCRATCH_DEV"
 		exit 1
diff --git a/tests/xfs/111 b/tests/xfs/111
index d5a09bbd32d6..8bc5e28b6a39 100755
--- a/tests/xfs/111
+++ b/tests/xfs/111
@@ -70,7 +70,7 @@ BYTE=`_scratch_xfs_db -c "convert inode $INO byte" \
 echo Blat inode clusters
 src/itrash $SCRATCH_DEV $BYTE
 
-_scratch_mount || _fail "Couldn't mount after itrash"
+_try_scratch_mount || _fail "Couldn't mount after itrash"
 
 echo Attempting bulkstat
 #src/bstat -q $SCRATCH_MNT
diff --git a/tests/xfs/121 b/tests/xfs/121
index 2f84a3c8b447..a380b7fb8058 100755
--- a/tests/xfs/121
+++ b/tests/xfs/121
@@ -54,8 +54,7 @@ _scratch_mkfs_xfs >>$seqres.full 2>&1 \
     || _fail "mkfs scratch failed"
 
 echo "mount"
-_scratch_mount >>$seqres.full 2>&1 \
-    || _fail "mount failed: $MOUNT_OPTIONS"
+_scratch_mount
 
 # num_files must be greater than 64 (XFS_AGI_UNLINKED_BUCKETS)
 # so that there will be at least one linked list from one of
@@ -82,7 +81,7 @@ echo "logprint after going down..."
 _print_logstate
 
 echo "mount with replay"
-_scratch_mount $mnt >>$seqres.full 2>&1 \
+_try_scratch_mount $mnt >>$seqres.full 2>&1 \
     || _fail "mount failed: $mnt $MOUNT_OPTIONS"
 
 echo "godown"
@@ -103,8 +102,7 @@ else
 fi
 
 # clean up dirty log with log recovery on mount
-_scratch_mount >> $seqres.full 2>&1 \
-    || _fail "mount failed"
+_scratch_mount
 
 # success, all done
 status=0
diff --git a/tests/xfs/130 b/tests/xfs/130
index 1c3d642430fc..a9e0ff4853d9 100755
--- a/tests/xfs/130
+++ b/tests/xfs/130
@@ -79,7 +79,7 @@ seq 0 $((agcount - 1)) | while read ag; do
 done
 
 echo "+ mount image"
-_scratch_mount >> $seqres.full 2>&1 && \
+_try_scratch_mount >> $seqres.full 2>&1 && \
 	echo "Should not be able to mount with broken refcountbt."
 _scratch_unmount >> $seqres.full 2>&1
 
diff --git a/tests/xfs/137 b/tests/xfs/137
index 093ef009b7da..6a19311860c3 100755
--- a/tests/xfs/137
+++ b/tests/xfs/137
@@ -69,13 +69,13 @@ _scratch_unmount
 # because the sb LSN is ahead of the current LSN. If it doesn't fail, push the
 # cycle back further and try again.
 _scratch_xfs_db -x -c "logformat" >> $seqres.full 2>&1
-_scratch_mount >> $seqres.full 2>&1
+_try_scratch_mount >> $seqres.full 2>&1
 if [ $? != 0 ]; then
 	echo mount failure detected
 else
 	_scratch_unmount
 	_scratch_xfs_db -x -c "logformat -c 2" >> $seqres.full 2>&1
-	_scratch_mount >> $seqres.full 2>&1 || echo mount failure detected
+	_try_scratch_mount >> $seqres.full 2>&1 || echo mount failure detected
 fi
 
 # verify that repair detects invalid LSNs as well
diff --git a/tests/xfs/141 b/tests/xfs/141
index f61e52428a51..80b5cb04ba80 100755
--- a/tests/xfs/141
+++ b/tests/xfs/141
@@ -79,7 +79,7 @@ for i in $(seq 1 5); do
 	# Verify that we can remount the fs. Log recovery should handle the torn
 	# write.
 	_scratch_unmount
-	_scratch_mount || _fail "failed to mount"
+	_scratch_mount
 done
 
 # success, all done
diff --git a/tests/xfs/177 b/tests/xfs/177
index 3957b49a8991..2aa4c7993039 100755
--- a/tests/xfs/177
+++ b/tests/xfs/177
@@ -59,8 +59,7 @@ _scratch_unmount > /dev/null 2>&1
 _scratch_mkfs_xfs >/dev/null 2>&1 \
         || _fail "mkfs failed"
 
-_scratch_mount \
-        || _fail "mount failed"
+_scratch_mount
 
 # run Mark Goodwin test here
 # Usage: ./bulkstat_unlink_test iterations nfiles stride dir
@@ -73,8 +72,7 @@ $here/src/bulkstat_unlink_test 20 1000 3 $SCRATCH_MNT/bulkstat
 
 # Mount scratch with ikeep enabled
 _scratch_unmount
-_scratch_mount "-o dmapi,mtpt=$SCRATCH_MNT" \
-        || _fail "mount failed"
+_scratch_mount "-o dmapi,mtpt=$SCRATCH_MNT"
 
 echo "Start bulkstat_unlink_test_modified"
 $here/src/bulkstat_unlink_test_modified 10 1000 1 $SCRATCH_MNT/bulkstat
diff --git a/tests/xfs/181 b/tests/xfs/181
index 07d7517174fd..3daea78807ad 100755
--- a/tests/xfs/181
+++ b/tests/xfs/181
@@ -61,8 +61,7 @@ _scratch_mkfs_xfs >>$seqres.full 2>&1 \
     || _fail "mkfs scratch failed"
 
 echo "mount"
-_scratch_mount >>$seqres.full 2>&1 \
-    || _fail "mount failed: $MOUNT_OPTIONS"
+_scratch_mount
 
 # num_files must be greater than 64 (XFS_AGI_UNLINKED_BUCKETS)
 # so that there will be at least one linked list from one of
diff --git a/tests/xfs/183 b/tests/xfs/183
index 764c1d5c6f27..390cfc8e444a 100755
--- a/tests/xfs/183
+++ b/tests/xfs/183
@@ -53,8 +53,7 @@ _require_scratch
 _scratch_mkfs_xfs >/dev/null 2>&1 \
         || _fail "mkfs failed"
 
-_scratch_mount \
-        || _fail "mount failed"
+_scratch_mount
 
 # run Mark Goodwin test here
 # Usage: ./bulkstat_unlink_test iterations nfiles stride dir
diff --git a/tests/xfs/189 b/tests/xfs/189
index 699eb3c1f941..e2654e516823 100755
--- a/tests/xfs/189
+++ b/tests/xfs/189
@@ -108,7 +108,7 @@ _test_remount_rw()
 	echo
 	echo "try remount ro,filestreams -> rw,filestreams"
 	echo
-	_scratch_mount -o ro,filestreams
+	_try_scratch_mount -o ro,filestreams
 	[ $? -eq 0 ] || echo "ro,filestreams mount failed unexpectedly"
 	_check_mount ro filestreams
 
@@ -127,7 +127,7 @@ _test_remount_rw()
 	echo
 	echo "try remount ro,noattr2 -> rw,attr2"
 	echo
-	_scratch_mount -o ro,noattr2
+	_try_scratch_mount -o ro,noattr2
 	[ $? -eq 0 ] || echo "ro,noattr2 mount failed unexpectedly"
 	_check_mount ro
 
@@ -149,7 +149,7 @@ _test_remount_write()
 	echo
 	echo "try touching file after remount ro -> rw with options"
 	echo
-	_scratch_mount
+	_try_scratch_mount
 	[ $? -eq 0 ] || echo "mount (1) failed unexpectedly"
 
 	touch $SCRATCH_MNT/foobar
@@ -157,7 +157,7 @@ _test_remount_write()
 
 	_scratch_unmount
 
-	_scratch_mount -o ro
+	_try_scratch_mount -o ro
 	[ $? -eq 0 ] || echo "mount (2) failed unexpectedly"
 
 	_mount -o remount,rw,filestreams $SCRATCH_MNT
@@ -181,15 +181,15 @@ _test_remount_barrier()
 	echo
 
 	# mention barrier explicitly even if it's currently the default just to be sure
-	_scratch_mount -o barrier
+	_try_scratch_mount -o barrier
 	[ $? -eq 0 ] || echo "mount failed unexpectedly!"
 	_check_mount rw
 
-	_scratch_mount -o remount,nobarrier
+	_try_scratch_mount -o remount,nobarrier
 	[ $? -eq 0 ] || _fail "remount nobarrier failed"
 	_check_mount rw nobarrier
 
-	_scratch_mount -o remount,barrier
+	_try_scratch_mount -o remount,barrier
 	[ $? -eq 0 ] || _fail "remount barrier failed"
 	_check_mount rw
 
diff --git a/tests/xfs/263 b/tests/xfs/263
index 7aebf90b820e..e713dfdd3b19 100755
--- a/tests/xfs/263
+++ b/tests/xfs/263
@@ -82,7 +82,7 @@ function test_all_state()
 		echo "== Options: $OPTIONS =="
 		# Some combinations won't mount on V4 supers (grp + prj)
 		_qmount_option "$OPTIONS"
-		_scratch_mount &>> $seqres.full || continue
+		_try_scratch_mount &>> $seqres.full || continue
 		$XFS_QUOTA_PROG -x -c "state" $SCRATCH_MNT | filter_quota_state
 		_scratch_unmount
 	done
diff --git a/tests/xfs/270 b/tests/xfs/270
index 18e6c3861195..05dee7418153 100755
--- a/tests/xfs/270
+++ b/tests/xfs/270
@@ -63,14 +63,14 @@ $XFS_DB_PROG -x -c "sb 0" -c "write features_ro_compat $((2**31))" $SCRATCH_DEV
 
 # rw mount with unknown ro-compat feature should fail
 echo "rw mount test"
-_scratch_mount 2>>$seqres.full
+_try_scratch_mount 2>>$seqres.full
 if [ $? -eq 0 ]; then
 	_fail "rw mount test failed"
 fi
 
 # But ro mount should succeed
 echo "ro mount test"
-_scratch_mount -o ro
+_try_scratch_mount -o ro
 if [ $? -ne 0 ]; then
 	_fail "ro mount test failed"
 else
diff --git a/tests/xfs/297 b/tests/xfs/297
index 708a7f864837..2ae2d437e45d 100755
--- a/tests/xfs/297
+++ b/tests/xfs/297
@@ -52,7 +52,7 @@ _require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 _scratch_mkfs_xfs -d agcount=16,su=256k,sw=12 -l su=256k,size=5120b >/dev/null 2>&1
-_scratch_mount >>$seqres.full 2>&1 || _fail "mount failed"
+_scratch_mount
 
 STRESS_DIR="$SCRATCH_MNT/testdir"
 mkdir -p $STRESS_DIR
diff --git a/tests/xfs/333 b/tests/xfs/333
index 2f394feda6c9..41949f922151 100755
--- a/tests/xfs/333
+++ b/tests/xfs/333
@@ -64,7 +64,7 @@ _scratch_unmount
 
 echo "Corrupt fs"
 _scratch_xfs_db -x -c 'sb 0' -c "write rrmapino $ino" >> $seqres.full
-_scratch_mount 2>&1 | _filter_error_mount
+_try_scratch_mount 2>&1 | _filter_error_mount
 
 echo "Test done, mount should have failed"
 
diff --git a/tests/xfs/338 b/tests/xfs/338
index 755510c88cb9..25e6aec9c6aa 100755
--- a/tests/xfs/338
+++ b/tests/xfs/338
@@ -60,7 +60,7 @@ echo "Corrupt fs"
 _scratch_xfs_db -x -c 'sb 0' -c 'addr rrmapino' \
 	-c 'write core.nlinkv2 0' -c 'write core.mode 0' -c 'sb 0' \
 	-c 'write rrmapino 0' >> $seqres.full
-_scratch_mount >> $seqres.full 2>&1 && echo "mount should have failed"
+_try_scratch_mount >> $seqres.full 2>&1 && echo "mount should have failed"
 
 echo "Repair fs"
 _scratch_unmount 2>&1 | _filter_scratch
diff --git a/tests/xfs/340 b/tests/xfs/340
index 7b1b7d13b1a2..8e82c0884fc8 100755
--- a/tests/xfs/340
+++ b/tests/xfs/340
@@ -65,7 +65,7 @@ _scratch_xfs_db -x -c "inode $rrmapino" \
 	-c 'write core.nblocks 0' -c 'sb 0' -c 'addr rootino' \
 	-c "write u3.sfdir3.list[2].inumber.i4 $rrmapino" \
 	-c 'sb 0' -c "write rrmapino $ino" >> $seqres.full
-_scratch_mount >> $seqres.full 2>&1 && echo "mount should have failed"
+_try_scratch_mount >> $seqres.full 2>&1 && echo "mount should have failed"
 
 echo "Repair fs"
 _scratch_unmount 2>&1 | _filter_scratch
diff --git a/tests/xfs/433 b/tests/xfs/433
index 275116851722..be1ccfcfe775 100755
--- a/tests/xfs/433
+++ b/tests/xfs/433
@@ -65,7 +65,7 @@ _require_scratch
 _require_attrs
 
 _scratch_mkfs > $seqres.full 2>&1
-_scratch_mount || _fail "mount failure"
+_scratch_mount
 
 file=$SCRATCH_MNT/testfile
 
diff --git a/tests/xfs/434 b/tests/xfs/434
index 908f25435772..e859aebb1804 100755
--- a/tests/xfs/434
+++ b/tests/xfs/434
@@ -99,7 +99,7 @@ _scratch_xfs_db -x -c 'agf 0' -c 'addr refcntroot' -c 'fuzz -d recs[1].startbloc
 _scratch_xfs_db -x -c 'agf 0' -c 'addr refcntroot' -c p >> $seqres.full
 
 # Suddenly enable quota to test if we can leak the quotacheck dquots!
-_scratch_mount -o quota >> $seqres.full 2>&1
+_try_scratch_mount -o quota >> $seqres.full 2>&1
 _scratch_unmount 2> /dev/null
 rm -f ${RESULT_DIR}/require_scratch
 
diff --git a/tests/xfs/435 b/tests/xfs/435
index 6ab8a614292f..dea28149e8c9 100755
--- a/tests/xfs/435
+++ b/tests/xfs/435
@@ -77,7 +77,7 @@ echo "Remount to check recovery" | tee /dev/ttyprintk
 _scratch_unmount
 _scratch_xfs_db -x -c 'agf 0' -c 'addr refcntroot' -c 'fuzz -d recs[1].startblock ones' >> $seqres.full
 _scratch_xfs_db -x -c 'agf 0' -c 'addr refcntroot' -c p >> $seqres.full
-_scratch_mount -o quota >> $seqres.full 2>&1
+_try_scratch_mount -o quota >> $seqres.full 2>&1
 _scratch_unmount 2> /dev/null
 rm -f ${RESULT_DIR}/require_scratch
 
diff --git a/tests/xfs/436 b/tests/xfs/436
index ec19106ce12c..d357b8303d44 100755
--- a/tests/xfs/436
+++ b/tests/xfs/436
@@ -93,7 +93,7 @@ _scratch_unmount
 _scratch_dump_log >> $seqres.full
 _scratch_xfs_db -x -c 'agf 0' -c 'addr refcntroot' -c 'fuzz -d recs[1].startblock ones' >> $seqres.full
 _scratch_xfs_db -x -c 'agf 0' -c 'addr refcntroot' -c p >> $seqres.full
-_scratch_mount -o noquota >> $seqres.full 2>&1
+_try_scratch_mount -o noquota >> $seqres.full 2>&1
 _scratch_unmount 2> /dev/null
 rm -f ${RESULT_DIR}/require_scratch
 
diff --git a/tests/xfs/439 b/tests/xfs/439
index 7be700cddff4..215c4b90cadb 100755
--- a/tests/xfs/439
+++ b/tests/xfs/439
@@ -67,7 +67,7 @@ lsunit=$(_scratch_xfs_get_sb_field logsunit)
 # Mount and writing log may trigger a crash on buggy kernel
 # The fix applied kernel refuses to mount, so a mount failure is
 # expected
-if _scratch_mount >> $seqres.full 2>&1; then
+if _try_scratch_mount >> $seqres.full 2>&1; then
 	for i in $(seq 1 1000); do
 		echo > ${SCRATCH_MNT}/$i
 	done
diff --git a/tests/xfs/442 b/tests/xfs/442
index 05cffe98456d..8478426ad060 100755
--- a/tests/xfs/442
+++ b/tests/xfs/442
@@ -93,7 +93,7 @@ _qmount_option "usrquota,grpquota,prjquota"
 # xfs_qm_dqattach before performing reflink operations") though each of those
 # tests now have separate faster-running regression tests.
 _scratch_mkfs_sized $((1600 * 1048576)) > $seqres.full 2>&1
-_scratch_mount >> $seqres.full 2>&1 || _fail "mount failed..."
+_scratch_mount >> $seqres.full 2>&1
 
 nr_cpus=$((LOAD_FACTOR * 4))
 nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
diff --git a/tests/xfs/443 b/tests/xfs/443
index df9434f807f4..5653849d964d 100755
--- a/tests/xfs/443
+++ b/tests/xfs/443
@@ -64,7 +64,7 @@ _require_xfs_io_command "fpunch"
 _require_xfs_io_command "swapext"
 
 _scratch_mkfs | _filter_mkfs >> $seqres.full 2> $tmp.mkfs
-_scratch_mount || _fail "mount failed"
+_scratch_mount
 
 # get fs block size
 . $tmp.mkfs
-- 
2.14.3

