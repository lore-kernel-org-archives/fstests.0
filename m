Received: from szxga07-in.huawei.com ([45.249.212.35]:58350 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726861AbfAVDUf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 22:20:35 -0500
From: zhengbin <zhengbin13@huawei.com>
Subject: [PATCH 1/6] squashfs: add squashfs support
Date: Tue, 22 Jan 2019 11:24:03 +0800
Message-ID: <20190122032408.91336-2-zhengbin13@huawei.com>
In-Reply-To: <20190122032408.91336-1-zhengbin13@huawei.com>
References: <20190122032408.91336-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, guaneryu@gmail.com, fstests@vger.kernel.org
Cc: houtao1@huawei.com, zhaohongjiang@huawei.com, zhengbin13@huawei.com
List-ID: <fstests@vger.kernel.org>

This patch add squashfs support in xfstests-dev. Add 'readonly'
directory support instead of generic/shard in tests which can
also be used for other readonly filesystems, The reason is:
The step of tests in readonly filesystem(such as squashfs) are
as follows:
1. write data in $SCRATCH_DEV
2. mkfs $SCRATCH_DEV file
3. mount file $SCRATCH_MNT
4. test in $SCRATCH_MNT

While the rw filesystems are as follows:
1. mkfs $SCRATCH_DEV
2. mount $SCRATCH_DEV $SCRATCH_MNT
3. test in $SCRATCH_MNT(just write data in $SCRATCH_MNT)

The tests in generic/shared are set as rw filesystem, it is hard
to use this in readonly filesystem, use 'readonly' dir which can
be easier to read.

PS: As readonly filesystems need to mkfs in every test, do not
use TEST_DEV&TEST_DIR.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 README.squashfs | 12 +++++++++++
 check           | 19 ++++++++++++++---
 common/config   |  6 ++++++
 common/rc       | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 95 insertions(+), 5 deletions(-)
 create mode 100644 README.squashfs

diff --git a/README.squashfs b/README.squashfs
new file mode 100644
index 00000000..34b9ade8
--- /dev/null
+++ b/README.squashfs
@@ -0,0 +1,12 @@
+To run xfstest on squashfs, configure the variables of TEST and SCRATCH
+directories to be used as the "base fs" and run './check -squashfs'.
+
+For example, the following config file can be used to run tests on
+xfs test/scratch directories:
+
+ TEST_DEV=/root/test
+ TEST_DIR=/mnt/test
+ SCRATCH_DEV=/root/scratch
+ SCRATCH_MNT=/mnt/scratch
+
+TEST_DEV and SCRATCH_DEV should be directories.
diff --git a/check b/check
index 77a06b00..898ca2d5 100755
--- a/check
+++ b/check
@@ -45,6 +45,7 @@ timestamp=${TIMESTAMP:=false}
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.*

 SRC_GROUPS="generic shared"
+SRC_READONLY_GROUPS="readonly"
 export SRC_DIR="tests"

 usage()
@@ -60,6 +61,7 @@ check options
     -pvfs2          test PVFS2
     -tmpfs              test TMPFS
     -ubifs              test ubifs
+    -squashfs		test squashfs
     -l			line mode diff
     -udiff		show unified diff (default)
     -n			show me, do not run tests
@@ -111,6 +113,16 @@ examples:
 	    exit 0
 }

+# Get Source group, if fstyp is readonly, use tests/readonly dir
+get_src_group()
+{
+	local grp=$SRC_GROUPS
+	if [ "$FSTYP" == "squashfs" ]; then
+		grp=$SRC_READONLY_GROUPS
+	fi
+	echo $grp
+}
+
 get_sub_group_list()
 {
 	local d=$1
@@ -138,7 +150,7 @@ get_group_list()
 		return
 	fi

-	for d in $SRC_GROUPS $FSTYP; do
+	for d in $(get_src_group) $FSTYP; do
 		if ! test -d "$SRC_DIR/$d" ; then
 			continue
 		fi
@@ -152,7 +164,7 @@ get_group_list()
 get_all_tests()
 {
 	touch $tmp.list
-	for d in $SRC_GROUPS $FSTYP; do
+	for d in $(get_src_group) $FSTYP; do
 		if ! test -d "$SRC_DIR/$d" ; then
 			continue
 		fi
@@ -258,6 +270,7 @@ while [ $# -gt 0 ]; do

 	-nfs)		FSTYP=nfs ;;
 	-glusterfs)	FSTYP=glusterfs ;;
+	-squashfs)      FSTYP=squashfs ;;
 	-cifs)		FSTYP=cifs ;;
 	-9p)		FSTYP=9p ;;
 	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
@@ -321,7 +334,7 @@ if ! . ./common/rc; then
 fi

 if [ -n "$subdir_xfile" ]; then
-	for d in $SRC_GROUPS $FSTYP; do
+	for d in $(get_src_group) $FSTYP; do
 		[ -f $SRC_DIR/$d/$subdir_xfile ] || continue
 		for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
 			echo $d/$f >> $tmp.xlist
diff --git a/common/config b/common/config
index 64f87057..ef507d1d 100644
--- a/common/config
+++ b/common/config
@@ -223,6 +223,7 @@ case "$HOSTOS" in
     Linux)
 	export MKFS_XFS_PROG=$(type -P mkfs.xfs)
 	export MKFS_EXT4_PROG=$(type -P mkfs.ext4)
+	export MKFS_SQUASHFS_PROG=$(type -P mksquashfs)
 	export MKFS_UDF_PROG=$(type -P mkudffs)
 	export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
 	export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
@@ -474,6 +475,11 @@ _check_device()
 			_fatal "common/config: $name ($dev) is not a directory for overlay"
 		fi
 		;;
+	squashfs)
+		if [ ! -d "$dev" ]; then
+			_fatal "common/config: $name ($dev) is not a directory for squashfs"
+		fi
+		;;
 	ubifs)
 		if [ ! -c "$dev" ]; then
 			_fatal "common/config: $name ($dev) is not a character device"
diff --git a/common/rc b/common/rc
index b8ed1776..39810342 100644
--- a/common/rc
+++ b/common/rc
@@ -6,6 +6,9 @@

 BC=$(which bc 2> /dev/null) || BC=

+# compress file for readonly filesystem(squashfs)
+export SCRATCH_COMPRESS_FILE=$SCRATCH_DEV/scratch_compress_file
+
 # Some tests are not relevant or functional when testing XFS realtime
 # subvolumes along with the rtinherit=1 mkfs option.  In these cases,
 # this test will opt-out of the test.
@@ -133,6 +136,9 @@ case "$FSTYP" in
     ext4)
 	 [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
 	 ;;
+    squashfs)
+	 [ "$MKFS_SQUASHFS_PROG" = "" ] && _fatal "mksquashfs not found"
+	 ;;
     f2fs)
 	 [ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
 	 ;;
@@ -327,6 +333,9 @@ _try_scratch_mount()
 	if [ "$FSTYP" == "overlay" ]; then
 		_overlay_scratch_mount $*
 		return $?
+	elif [ "$FSTYP" == "squashfs" ]; then
+		_mount -t $FSTYP $SCRATCH_OPTIONS $* $SCRATCH_COMPRESS_FILE $SCRATCH_MNT
+		return $?
 	fi
 	_mount -t $FSTYP `_scratch_mount_options $*`
 }
@@ -343,7 +352,7 @@ _scratch_unmount()
 	overlay)
 		_overlay_scratch_unmount
 		;;
-	btrfs)
+	btrfs|squashfs)
 		$UMOUNT_PROG $SCRATCH_MNT
 		;;
 	*)
@@ -398,6 +407,9 @@ _test_mount()
     if [ "$FSTYP" == "overlay" ]; then
         _overlay_test_mount $*
         return $?
+    elif [ "$FSTYP" == "squashfs" ]; then
+	# squashfs do not use TEST_DEV, TEST_DIR, just return
+	return 0
     fi
     _test_options mount
     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
@@ -407,6 +419,9 @@ _test_unmount()
 {
 	if [ "$FSTYP" == "overlay" ]; then
 		_overlay_test_unmount
+	elif [ "$FSTYP" == "squashfs" ]; then
+		# squashfs do not use TEST_DEV, TEST_DIR, just return
+		return
 	else
 		$UMOUNT_PROG $TEST_DEV
 	fi
@@ -580,6 +595,28 @@ _scratch_mkfs_ext4()
 	return $mkfs_status
 }

+_scratch_mkfs_squashfs()
+{
+	local mkfs_cmd="$MKFS_SQUASHFS_PROG"
+	local mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
+	mkdir -p /tmp
+	rm -f $SCRATCH_COMPRESS_FILE
+	local mkfs_status
+	local tmp=`mktemp -u`
+	local extra_mkfs_options=$*
+
+	eval "$mkfs_cmd $SCRATCH_DEV $SCRATCH_COMPRESS_FILE $MKFS_OPTIONS $extra_mkfs_options" \
+	  2>$tmp.mkfserr 1>$tmp.mkfsstd
+	mkfs_status=$?
+
+	# output stored mkfs output, filtering unnecessary output from stderr
+	cat $tmp.mkfsstd
+	eval "cat $tmp.mkfserr | $mkfs_filter" >&2
+
+	rm -f $tmp.mkfserr $tmp.mkfsstd
+	return $mkfs_status
+}
+
 _test_mkfs()
 {
     case $FSTYP in
@@ -613,6 +650,9 @@ _test_mkfs()
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
 	;;
+    squashfs)
+	# squashfs do not use TEST_DEV, TEST_DIR, just return
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
 	;;
@@ -713,6 +753,10 @@ _scratch_mkfs()
 		_scratch_mkfs_ext4 $*
 		return $?
 		;;
+	squashfs)
+		_scratch_mkfs_squashfs $*
+		return $?
+		;;
 	xfs)
 		_scratch_mkfs_xfs $*
 		return $?
@@ -1505,6 +1549,18 @@ _require_scratch_nocheck()
 		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
 		fi
 		;;
+	squashfs)
+		if [ ! -d "$SCRATCH_DEV" ]; then
+			_notrun "this test requires a valid \$SCRATCH_DEV"
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
+		fi
+		# umount SCRATCH_MNT
+		_scratch_unmount >/dev/null 2>&1
+		rm -f ${RESULT_DIR}/require_scratch
+		return
+		;;
 	ubifs)
 		# ubifs needs an UBI volume. This will be a char device, not a block device.
 		if [ ! -c "$SCRATCH_DEV" ]; then
@@ -3599,7 +3655,10 @@ init_rc()

 	# Sanity check that TEST partition is not mounted at another mount point
 	# or as another fs type
-	_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR $FSTYP || exit 1
+	# if fs type is squashfs, do not check mount on TEST_DEV TEST_DIR
+	if [ "$FSTYP" != "squashfs" ]; then
+		_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR $FSTYP || exit 1
+	fi
 	if [ -n "$SCRATCH_DEV" ]; then
 		# Sanity check that SCRATCH partition is not mounted at another
 		# mount point, because it is about to be unmounted and formatted.
--
2.16.2.dirty
