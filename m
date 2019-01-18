Received: from szxga04-in.huawei.com ([45.249.212.190]:2201 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfARJgN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 Jan 2019 04:36:13 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 86ECEA725A8CDEE01570
        for <fstests@vger.kernel.org>; Fri, 18 Jan 2019 17:33:49 +0800 (CST)
From: zhengbin <zhengbin13@huawei.com>
Subject: [PATCH 1/1] squashfs: add squashfs tests
Date: Fri, 18 Jan 2019 17:37:25 +0800
Message-ID: <20190118093725.103172-2-zhengbin13@huawei.com>
In-Reply-To: <20190118093725.103172-1-zhengbin13@huawei.com>
References: <20190118093725.103172-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com, fstests@vger.kernel.org
Cc: houtao1@huawei.com, zhaohongjiang@huawei.com, zhengbin13@huawei.com
List-ID: <fstests@vger.kernel.org>

This patch add squashfs support in xfstests-dev. Add two directories
in tests directory, readonly can also be used for other readonly
filesystem, squashfs is just used for squashfs filesystem.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 .gitignore                                  |   1 +
 README.squashfs                             |  12 ++
 check                                       |  19 ++-
 common/attr                                 |   5 +
 common/config                               |   6 +
 common/rc                                   |  63 ++++++++-
 src/aio-dio-regress/aio-subblock-eof-read.c |  84 ++++++++++++
 tests/readonly/001                          |  97 ++++++++++++++
 tests/readonly/001.out                      |   2 +
 tests/readonly/002                          |  48 +++++++
 tests/readonly/002.out                      |   6 +
 tests/readonly/003                          |  72 +++++++++++
 tests/readonly/003.out                      |   5 +
 tests/readonly/004                          |  50 +++++++
 tests/readonly/004.out                      |   3 +
 tests/readonly/005                          |  77 +++++++++++
 tests/readonly/005.out                      |   2 +
 tests/readonly/006                          |  48 +++++++
 tests/readonly/006.out                      |   4 +
 tests/readonly/007                          |  74 +++++++++++
 tests/readonly/007.out                      |   9 ++
 tests/readonly/008                          | 193 ++++++++++++++++++++++++++++
 tests/readonly/008.out                      |  34 +++++
 tests/readonly/009                          |  50 +++++++
 tests/readonly/009.out                      |   2 +
 tests/readonly/010                          |  49 +++++++
 tests/readonly/010.out                      |   4 +
 tests/readonly/011                          |  92 +++++++++++++
 tests/readonly/011.out                      |  30 +++++
 tests/readonly/012                          |  56 ++++++++
 tests/readonly/012.out                      |   5 +
 tests/readonly/013                          |  47 +++++++
 tests/readonly/013.out                      |   2 +
 tests/readonly/014                          |  46 +++++++
 tests/readonly/014.out                      |   2 +
 tests/readonly/015                          |  42 ++++++
 tests/readonly/015.out                      |   2 +
 tests/readonly/016                          | 145 +++++++++++++++++++++
 tests/readonly/016.out                      |   8 ++
 tests/readonly/017                          | 107 +++++++++++++++
 tests/readonly/017.out                      |   2 +
 tests/readonly/018                          |  49 +++++++
 tests/readonly/018.out                      |   2 +
 tests/readonly/019                          | 109 ++++++++++++++++
 tests/readonly/019.out                      |  45 +++++++
 tests/readonly/020                          |  56 ++++++++
 tests/readonly/020.out                      |   9 ++
 tests/readonly/021                          |  74 +++++++++++
 tests/readonly/021.out                      |  11 ++
 tests/readonly/Makefile                     |  20 +++
 tests/readonly/group                        |  26 ++++
 tests/squashfs/001                          |  60 +++++++++
 tests/squashfs/001.out                      |   9 ++
 tests/squashfs/002                          |  40 ++++++
 tests/squashfs/002.out                      |   2 +
 tests/squashfs/003                          |  55 ++++++++
 tests/squashfs/003.out                      |  12 ++
 tests/squashfs/004                          |  73 +++++++++++
 tests/squashfs/004.out                      |  23 ++++
 tests/squashfs/005                          |  54 ++++++++
 tests/squashfs/005.out                      |  13 ++
 tests/squashfs/Makefile                     |  20 +++
 tests/squashfs/group                        |  10 ++
 63 files changed, 2372 insertions(+), 5 deletions(-)
 create mode 100644 README.squashfs
 create mode 100644 src/aio-dio-regress/aio-subblock-eof-read.c
 create mode 100755 tests/readonly/001
 create mode 100644 tests/readonly/001.out
 create mode 100755 tests/readonly/002
 create mode 100644 tests/readonly/002.out
 create mode 100755 tests/readonly/003
 create mode 100644 tests/readonly/003.out
 create mode 100755 tests/readonly/004
 create mode 100644 tests/readonly/004.out
 create mode 100755 tests/readonly/005
 create mode 100644 tests/readonly/005.out
 create mode 100755 tests/readonly/006
 create mode 100644 tests/readonly/006.out
 create mode 100755 tests/readonly/007
 create mode 100644 tests/readonly/007.out
 create mode 100755 tests/readonly/008
 create mode 100644 tests/readonly/008.out
 create mode 100755 tests/readonly/009
 create mode 100644 tests/readonly/009.out
 create mode 100755 tests/readonly/010
 create mode 100644 tests/readonly/010.out
 create mode 100755 tests/readonly/011
 create mode 100644 tests/readonly/011.out
 create mode 100755 tests/readonly/012
 create mode 100644 tests/readonly/012.out
 create mode 100755 tests/readonly/013
 create mode 100644 tests/readonly/013.out
 create mode 100755 tests/readonly/014
 create mode 100644 tests/readonly/014.out
 create mode 100755 tests/readonly/015
 create mode 100644 tests/readonly/015.out
 create mode 100755 tests/readonly/016
 create mode 100644 tests/readonly/016.out
 create mode 100755 tests/readonly/017
 create mode 100644 tests/readonly/017.out
 create mode 100755 tests/readonly/018
 create mode 100644 tests/readonly/018.out
 create mode 100755 tests/readonly/019
 create mode 100644 tests/readonly/019.out
 create mode 100755 tests/readonly/020
 create mode 100644 tests/readonly/020.out
 create mode 100755 tests/readonly/021
 create mode 100644 tests/readonly/021.out
 create mode 100644 tests/readonly/Makefile
 create mode 100644 tests/readonly/group
 create mode 100755 tests/squashfs/001
 create mode 100644 tests/squashfs/001.out
 create mode 100755 tests/squashfs/002
 create mode 100644 tests/squashfs/002.out
 create mode 100755 tests/squashfs/003
 create mode 100644 tests/squashfs/003.out
 create mode 100755 tests/squashfs/004
 create mode 100644 tests/squashfs/004.out
 create mode 100755 tests/squashfs/005
 create mode 100644 tests/squashfs/005.out
 create mode 100644 tests/squashfs/Makefile
 create mode 100644 tests/squashfs/group

diff --git a/.gitignore b/.gitignore
index ea1aac8a..d9886427 100644
--- a/.gitignore
+++ b/.gitignore
@@ -159,6 +159,7 @@
 /src/aio-dio-regress/aio-dio-hole-filling-race
 /src/aio-dio-regress/aio-dio-invalidate-failure
 /src/aio-dio-regress/aio-dio-invalidate-readahead
+/src/aio-dio-regress/aio-subblock-eof-read
 /src/aio-dio-regress/aio-dio-subblock-eof-read
 /src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages
 /src/aio-dio-regress/aio-io-setup-with-nonwritable-context-pointer
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
diff --git a/common/attr b/common/attr
index 20049de0..845ed88e 100644
--- a/common/attr
+++ b/common/attr
@@ -179,6 +179,11 @@ _require_attrs()
     [ -n "$GETFATTR_PROG" ] || _notrun "getfattr command not found"
     [ -n "$SETFATTR_PROG" ] || _notrun "setfattr command not found"

+    if [ "$FSTYP" == "squashfs" ]; then
+	# squashfs is a readonly filesystem, can not touch file
+	return
+    fi
+
     #
     # Test if chacl is able to write an attribute on the target filesystems.
     # On really old kernels the system calls might not be implemented at all,
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
diff --git a/src/aio-dio-regress/aio-subblock-eof-read.c b/src/aio-dio-regress/aio-subblock-eof-read.c
new file mode 100644
index 00000000..24f03f93
--- /dev/null
+++ b/src/aio-dio-regress/aio-subblock-eof-read.c
@@ -0,0 +1,84 @@
+/*  SPDX-License-Identifier: GPL-2.0+
+ * Copyright (C) 2005 Jeff Moyer
+ * Copyright (C) 2019 zhengbin
+ *
+ * Test AIO read of last block of file
+ *
+ * Code taken from aio-dio-subblock-eof-read.c
+ * Munged by zhengbin
+ *
+ * Description:  This source code implements a test to ensure that an AIO
+ * read of the last block in a file opened with  returns the proper
+ * amount of data.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <libaio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+
+#define fail(fmt, args...)	\
+do {				\
+	printf(fmt, ##args);	\
+	exit(1);		\
+} while (0)
+
+static unsigned char buffer[4096] __attribute((aligned(4096)));
+
+int main(int argc, char **argv)
+{
+	int ret;
+	int fd;
+	int filesize;
+	const char *filename;
+	struct iocb myiocb;
+	struct iocb *cb = &myiocb;
+	io_context_t ioctx;
+	struct io_event ie;
+
+	if (argc != 3)
+		fail("Usage: %s filename filesize\n", argv[0]);
+
+	filename = argv[1];
+	fd = open(filename, O_RDONLY, 0600);
+	if (fd < 0)
+		fail("open returned error %d\n", errno);
+
+	filesize = atoi(argv[2]);
+
+	/* <1> use normal disk read, this should be ok */
+	ret = read(fd, buffer, 4096);
+	if (ret != filesize)
+		fail("buffered read returned %d, should be 300\n", ret);
+
+	/* <2> use AIO disk read, it sees error. */
+	memset(&myiocb, 0, sizeof(myiocb));
+	cb->data = 0;
+	cb->key = 0;
+	cb->aio_lio_opcode = IO_CMD_PREAD;
+	cb->aio_reqprio = 0;
+	cb->aio_fildes = fd;
+	cb->u.c.buf = buffer;
+	cb->u.c.nbytes = 4096;
+	cb->u.c.offset = 0;
+
+	ret = io_queue_init(1, &ioctx);
+	if (ret != 0)
+		fail("io_queue_init returned error %d\n", ret);
+
+	ret = io_submit(ioctx, 1, &cb);
+	if (ret != 1)
+		fail("io_submit returned error %d\n", ret);
+
+	ret = io_getevents(ioctx, 1, 1, &ie, NULL);
+	if (ret != 1)
+		fail("io_getevents returned %d\n", ret);
+
+	if (ie.res != filesize)
+		fail("AIO read of last block in file returned %ld bytes, "
+		     "expected %d\n", ie.res, filesize);
+
+	printf("AIO read of last block in file succeeded.\n");
+	return 0;
+}
diff --git a/tests/readonly/001 b/tests/readonly/001
new file mode 100755
index 00000000..164722d2
--- /dev/null
+++ b/tests/readonly/001
@@ -0,0 +1,97 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 001. Modifed from generic/067.
+#
+# Some random mount/umount corner case tests
+#
+# - mount at a nonexistent mount point
+# - mount a free loop device
+# - mount with a wrong fs type specified
+# - umount an symlink to device which is not mounted
+# - umount a path with too long name
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_loop
+
+rm -f $seqres.full
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+
+# kernel should not hang nor oops when mounting fs to nonexistent mount point
+mount_nonexistent_mnt()
+{
+	echo "# mount to nonexistent mount point" >>$seqres.full
+	rm -rf $SCRATCH_DEV/nosuchdir
+	$MOUNT_PROG -t $FSTYP $SCRATCH_COMPRESS_FILE $SCRATCH_DEV/nosuchdir >>$seqres.full 2>&1
+}
+
+# fs driver should be able to handle mounting a free loop device gracefully
+# xfs ever hung, "ec53d1d xfs: don't block on buffer read errors" fixed it
+mount_free_loopdev()
+{
+	echo "# mount a free loop device" >>$seqres.full
+	loopdev=`losetup -f`
+	$MOUNT_PROG -t $FSTYP $loopdev $SCRATCH_MNT >>$seqres.full 2>&1
+}
+
+# mount with wrong fs type specified.
+# This should fail gracefully, no hang no oops are expected
+mount_wrong_fstype()
+{
+	local fs=ext4
+	echo "# mount with wrong fs type" >>$seqres.full
+	$MOUNT_PROG -t $fs $SCRATCH_COMPRESS_FILE $SCRATCH_MNT >>$seqres.full 2>&1
+}
+
+# umount a symlink to device, which is not mounted.
+# This should fail gracefully, no hang no oops are expected
+umount_symlink_device()
+{
+	local symlink=$SCRATCH_DEV/$seq.scratch_dev_symlink
+	rm -f $symlink
+	echo "# umount symlink to device, which is not mounted" >>$seqres.full
+	ln -s $SCRATCH_COMPRESS_FILE $symlink
+	$UMOUNT_PROG $symlink >>$seqres.full 2>&1
+	rm -f $symlink
+}
+
+# umount a path name that is 256 bytes long, this should fail gracefully,
+# and the following umount should not hang nor oops
+umount_toolong_name()
+{
+	local longname=$SCRATCH_MNT/`$PERL_PROG -e 'print "a"x256;'`
+
+	_scratch_mount 2>&1 | tee -a $seqres.full
+
+	echo "# umount a too-long name" >>$seqres.full
+	$UMOUNT_PROG $longname >>$seqres.full 2>&1
+	_scratch_unmount 2>&1 | tee -a $seqres.full
+}
+
+mount_nonexistent_mnt
+mount_free_loopdev
+mount_wrong_fstype
+
+umount_symlink_device
+umount_toolong_name
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/readonly/001.out b/tests/readonly/001.out
new file mode 100644
index 00000000..88678b8e
--- /dev/null
+++ b/tests/readonly/001.out
@@ -0,0 +1,2 @@
+QA output created by 001
+Silence is golden
diff --git a/tests/readonly/002 b/tests/readonly/002
new file mode 100755
index 00000000..eb3824d2
--- /dev/null
+++ b/tests/readonly/002
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 002
+#
+# Test metadata write/soft link/hard link on a RO fs
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_DEV/testfile
+rm -f $testfile
+touch $testfile
+
+_scratch_mkfs  > /dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+
+chown 1 $testfile 2>&1 | _filter_scratch
+chgrp 1 $testfile 2>&1 | _filter_scratch
+chmod 777 $testfile 2>&1 | _filter_scratch
+
+ln -s $testfile $SCRATCH_MNT/linkfile 2>&1 | _filter_scratch
+ln $testfile $SCRATCH_MNT/hardfile 2>&1 | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/002.out b/tests/readonly/002.out
new file mode 100644
index 00000000..3e5132b2
--- /dev/null
+++ b/tests/readonly/002.out
@@ -0,0 +1,6 @@
+QA output created by 002
+chown: changing ownership of 'SCRATCH_MNT/testfile': Read-only file system
+chgrp: changing group of 'SCRATCH_MNT/testfile': Read-only file system
+chmod: changing permissions of 'SCRATCH_MNT/testfile': Read-only file system
+ln: failed to create symbolic link 'SCRATCH_MNT/linkfile': Read-only file system
+ln: failed to create hard link 'SCRATCH_MNT/hardfile': Read-only file system
diff --git a/tests/readonly/003 b/tests/readonly/003
new file mode 100755
index 00000000..fc9577cc
--- /dev/null
+++ b/tests/readonly/003
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2008 Silicon Graphics, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 003. Modifed from generic/192.
+#
+# Simple test of atime
+# - ensure it is persistent after unmount
+# - check atime not updated after cat in readonly fs
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+_access_time()
+{
+	stat -c %X $1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_atime
+
+delay=2
+testfile=$SCRATCH_DEV/testfile
+rm -f $testfile
+rm -f $seqres.full
+
+echo test >$testfile
+
+_scratch_mkfs > /dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+
+time1=`_access_time $testfile | tee -a $seqres.full`
+
+echo "sleep for $delay seconds"
+sleep $delay # sleep to allow time to move on for access
+cat $testfile
+time2=`_access_time $testfile | tee -a $seqres.full`
+
+cd /
+_scratch_cycle_mount
+time3=`_access_time $testfile | tee -a $seqres.full`
+
+delta1=`expr $time2 - $time1`
+delta2=`expr $time3 - $time1`
+
+# readonly file system do not update atime
+_within_tolerance "delta1" $delta1 0 0 0 -v
+_within_tolerance "delta2" $delta2 $delta1 0 0 -v
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/003.out b/tests/readonly/003.out
new file mode 100644
index 00000000..ae2fe728
--- /dev/null
+++ b/tests/readonly/003.out
@@ -0,0 +1,5 @@
+QA output created by 003
+sleep for 2 seconds
+test
+delta1 is in range
+delta2 is in range
diff --git a/tests/readonly/004 b/tests/readonly/004
new file mode 100755
index 00000000..352fbff1
--- /dev/null
+++ b/tests/readonly/004
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2011 Red Hat, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 004. Modifed from generic/258.
+#
+# Test timestamps prior to epoch
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/timestamp-test.txt
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+TESTFILE=$SCRATCH_DEV/timestamp-test.txt
+
+# Create a file with a timestamp prior to the epoch
+echo "Creating file with timestamp of Jan 1, 1960"
+touch -t 196001010101 $TESTFILE
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+TESTFILE=$SCRATCH_MNT/timestamp-test.txt
+
+# Should yield -315593940 (prior to epoch)
+echo "Testing for negative seconds since epoch"
+ts=`stat -c %X $TESTFILE`
+if [ "$ts" -ge 0 ]; then
+	echo "Timestamp wrapped: $ts"
+	_fail "Timestamp wrapped"
+fi
+
+status=0
+exit
diff --git a/tests/readonly/004.out b/tests/readonly/004.out
new file mode 100644
index 00000000..2935bba1
--- /dev/null
+++ b/tests/readonly/004.out
@@ -0,0 +1,3 @@
+QA output created by 004
+Creating file with timestamp of Jan 1, 1960
+Testing for negative seconds since epoch
diff --git a/tests/readonly/005 b/tests/readonly/005
new file mode 100755
index 00000000..2633a742
--- /dev/null
+++ b/tests/readonly/005
@@ -0,0 +1,77 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2014, Oracle and/or its affiliates.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 005. Modifed from generic/003.
+#
+# Access time should never be updated in readonly fs, despite the
+# strictatime mount option.
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/file1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+_stat() {
+	stat -c "%x;%y;%z" $1
+}
+
+_compare_stat_times() {
+	updated=$1	# 3 chars indicating if access, modify and
+			# change times should be updated (Y) or not (N)
+	IFS=';' read -a first_stat <<< "$2"   # Convert first stat to array
+	IFS=';' read -a second_stat <<< "$3"  # Convert second stat to array
+	test_step=$4	# Will be printed to output stream in case of an
+			# error, to make debugging easier
+	types=( access modify change )
+
+	for i in 0 1 2; do
+		if [ "${first_stat[$i]}" == "${second_stat[$i]}" ]; then
+			if [ "${updated:$i:1}" == "N" ]; then
+				continue;
+			fi
+			echo -n "ERROR: ${types[$i]} time has not been updated "
+			echo $test_step
+		elif [ "${updated:$i:1}" == "N" ]; then
+			echo -n "ERROR: ${types[$i]} time has changed "
+			echo $test_step
+		fi
+	done
+}
+
+rm -f $SCRATCH_DEV/file1
+echo "test" >$SCRATCH_DEV/file1
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount "-o strictatime"
+
+file1_stat_before_first_access=`_stat $SCRATCH_MNT/file1`
+
+sleep 2
+
+cat $SCRATCH_MNT/file1 > /dev/null
+file1_stat_after_first_access=`_stat $SCRATCH_MNT/file1`
+_compare_stat_times NNN "$file1_stat_before_first_access" \
+	"$file1_stat_after_first_access" "for file in read-only filesystem"
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/readonly/005.out b/tests/readonly/005.out
new file mode 100644
index 00000000..a5027f12
--- /dev/null
+++ b/tests/readonly/005.out
@@ -0,0 +1,2 @@
+QA output created by 005
+Silence is golden
diff --git a/tests/readonly/006 b/tests/readonly/006
new file mode 100755
index 00000000..05d2fd09
--- /dev/null
+++ b/tests/readonly/006
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 006
+#
+# uid/gid/access rights/soft link/hard link test
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_DEV/testfile
+rm -f $testfile
+
+echo "test" >$testfile
+chown 1 $testfile
+chgrp 2 $testfile
+chmod 421 $testfile
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+stat -c %u $testfile
+stat -c %g $testfile
+stat -c %a $testfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/006.out b/tests/readonly/006.out
new file mode 100644
index 00000000..9f773e99
--- /dev/null
+++ b/tests/readonly/006.out
@@ -0,0 +1,4 @@
+QA output created by 006
+1
+2
+421
diff --git a/tests/readonly/007 b/tests/readonly/007
new file mode 100755
index 00000000..811b44c6
--- /dev/null
+++ b/tests/readonly/007
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2016 CTERA Networks. All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 007. Modifed from generic/401.
+#
+# Test filetype feature
+#
+# This test does NOT require that file system support the d_type feature.
+# It verifies that file types are reported as either DT_UNKNOWN or as
+# the actual file type. For example, special dir entries . and .. MAY be
+# reported as DT_UNKNOWN IF filetype feature is disabled (ext4), but MAY
+# also be reported as DT_DIR in this case (xfs).
+#
+# For fs for which we know how to test the filetype feature (xfs|ext*)
+# verify getting DT_UNKNOWN IFF feature is disabled.
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $SCRATCH_DEV/find-by-type
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_test_program "t_dir_type"
+
+# Create our test files.
+testdir=$SCRATCH_DEV/find-by-type
+mkdir -p $testdir
+mkdir $testdir/d
+touch $testdir/f
+ln -s $testdir/f $testdir/l
+mknod $testdir/c c 1 1
+mknod $testdir/b b 1 1
+mknod $testdir/p p
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testdir=$SCRATCH_MNT/find-by-type
+
+# Test d_type of test files - it must be the actual file type on fs
+# with filetype support and it could be either the actual file type
+# or DT_UNKNOWN on fs without filetype support
+ftype=
+src/t_dir_type $SCRATCH_MNT u | wc -l > /dev/null && ftype=1
+src/t_dir_type $testdir | \
+while read name type; do
+	if [ "$ftype" != 1 -a "$type" = u ]; then
+		if [ "$name" = "." -o "$name" = ".." ]; then
+			type=d
+		else
+			type=$name
+		fi
+	fi
+	echo $name $type
+done | sort
+
+status=0
+exit
diff --git a/tests/readonly/007.out b/tests/readonly/007.out
new file mode 100644
index 00000000..798401ed
--- /dev/null
+++ b/tests/readonly/007.out
@@ -0,0 +1,9 @@
+QA output created by 007
+. d
+.. d
+b b
+c c
+d d
+f f
+l l
+p p
diff --git a/tests/readonly/008 b/tests/readonly/008
new file mode 100755
index 00000000..09da3215
--- /dev/null
+++ b/tests/readonly/008
@@ -0,0 +1,193 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test NO. 008. Modifed from generic/478.
+#
+# Test OFD lock. fcntl F_OFD_SETLK to set lock, then F_OFD_GETLK
+# to verify we are being given correct advice by kernel.
+#
+# OFD lock combines POSIX lock and BSD flock:
+#   + does not share between threads
+#   + byte granularity
+#            (both tested by LTP/fcntl3{4,6})
+#   + only release automatically after all open fd closed
+#
+# This test target the third one and expand a little bit.
+#
+# The basic idea is one setlk routine setting locks via fcntl
+# *_SETLK, followed by operations like clone, dup then close fd;
+# another routine getlk getting locks via fcntl *_GETLK.
+#
+# Firstly in setlk routine process P0, place a lock L0 on an
+# opened testfile, then
+#
+#   + clone() a child P1 to close the fd then tell getlk to go,
+#     parent P0 wait getlk done then close fd.
+# or
+#   + dup() fd to a newfd then close newfd then tell getlk to go,
+#     then wait getlk done then close fd.
+#
+# In getlk process P2, do fcntl *_GETLK with lock L1 after get
+# notified by setlk routine.
+#
+# In the end, getlk routine check the returned struct flock.l_type
+# to see if the lock mechanism works fine.
+#
+# When testing with clone,
+#    + CLONE_FILES set, close releases all locks;
+#    + CLONE_FILES not set, locks remain in P0;
+#
+# If L0 is a POSIX lock,
+#   + it is not inherited into P1
+#   + it is released after dup & close
+#
+# If L0 is a OFD lock,
+#   + it is inherited into P1
+#   + it is not released after dup & close
+#
+#  setlk routine:			 * getlk routine:
+#    start				 *   start
+#      |				 *     |
+#   open file				 *  open file
+#      |				 *     |
+#   init sem				 *     |
+#      |				 *     |
+#  wait init sem done			 * wait init sem done
+#      |				 *     |
+#    setlk L0                            *     |
+#      |				 *     |
+#      |---------clone()--------|	 *     |
+#      |                        |	 *     |
+#      |(child P1)   (parent P0)|	 *     | (P2)
+#      |                        |	 *     |
+#      |                   close fd	 *     |
+#      |                        |	 *     |
+#      |                 set sem0=0	 *  wait sem0==0
+#      |                        |	 *     |
+#      |                        |	 *   getlk L1
+#      |                        |	 *     |
+#   wait sem1==0                |    	 *  set sem1=0
+#      |                        |	 *     |
+#     exit                wait child 	 *     |
+#                               |	 *  check result
+#                           cleanup  	 *     |
+#                               |	 *     |
+#                             exit	 *    exit
+#
+# We can test combainations of:
+#	+ shared or exclusive lock
+#	+ these locks are conflicting or not
+#	+ one OFD lock and one POSIX lock
+#	+ that open testfile RDONLY or RDWR
+#	+ clone with CLONE_FILES or not
+#	+ dup and close newfd
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+rm -f $SCRATCH_DEV/testfile
+
+# prepare a 4k testfile in TEST_DIR
+$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
+	$SCRATCH_DEV/testfile >> $seqres.full 2>&1
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+do_test()
+{
+	local soptions="$1"
+	local goptions="$2"
+	# print options and getlk output for debug
+	echo $* >> $seqres.full 2>&1
+	# -s : do setlk
+	$here/src/t_ofd_locks $soptions $SCRATCH_MNT/testfile &
+	# -g : do getlk
+	$here/src/t_ofd_locks $goptions $SCRATCH_MNT/testfile | \
+		tee -a $seqres.full
+	wait $!
+
+	# add -F to clone with CLONE_FILES
+	soptions="$1 -F"
+	# with -F, new locks are always file to place
+	$here/src/t_ofd_locks $soptions $SCRATCH_MNT/testfile &
+	$here/src/t_ofd_locks $goptions $SCRATCH_MNT/testfile | \
+		tee -a $seqres.full
+	wait $!
+
+	# add -d to dup and close
+	soptions="$1 -d"
+	$here/src/t_ofd_locks $soptions $SCRATCH_MNT/testfile &
+	$here/src/t_ofd_locks $goptions $SCRATCH_MNT/testfile | \
+		tee -a $seqres.full
+	wait $!
+}
+
+# Always setlk at range [0,9], getlk at range [0,9] [5,24] or [20,29].
+# To open file RDONLY should not break the locks.
+# POSIX locks should be released after closed fd, so it wont conflict
+# with other locks in tests
+
+# -P : operate posix lock
+# -w : operate on F_WRLCK
+# -r : operate on F_RDLCK
+# -R : open file RDONLY
+# -W : open file RDWR
+# -o : file offset where the lock starts
+# -l : lock length
+# -F : clone with CLONE_FILES in setlk
+# -d : dup and close in setlk
+
+# setlk rdlck [0,9], getlk wrlck [0,9], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -w -o 0 -l 10 -R" "rdlck" "unlck" "rdlck"
+# setlk rdlck [0,9], getlk wrlck [5,24], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -w -o 5 -l 20 -R -P" "rdlck" "unlck" "rdlck"
+# setlk posix rdlck [0,9], getlk wrlck [5,24], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -P" "-g -w -o 5 -l 20 -R" "rdlck" "unlck" "unlck"
+# setlk rdlck [0,9], getlk wrlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -w -o 20 -l 10 -R" "unlck" "unlck" "unlck"
+# setlk posix rdlck [0,9], getlk wrlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -P" "-g -w -o 20 -l 10 -R" "unlck" "unlck" "unlck"
+
+# setlk rdlck [0,9], getlk rdlck [0,9], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 0 -l 10 -R" "unlck" "unlck" "unlck"
+# setlk rdlck [0,9], getlk posix rdlck [0,9], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 0 -l 10 -R -P" "unlck" "unlck" "unlck"
+# setlk posix rdlck [0,9], getlk rdlck [0,9], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -P" "-g -r -o 0 -l 10 -R" "unlck" "unlck" "unlck"
+
+# setlk rdlck [0,9], getlk rdlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 20 -l 10 -R" "unlck" "unlck" "unlck"
+# setlk rdlck [0,9], getlk posix rdlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 20 -l 10 -R -P" "unlck" "unlck" "unlck"
+# setlk posix rdlck [0,9], getlk rdlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -P" "-g -r -o 20 -l 10 -R" "unlck" "unlck" "unlck"
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/008.out b/tests/readonly/008.out
new file mode 100644
index 00000000..d3ac560f
--- /dev/null
+++ b/tests/readonly/008.out
@@ -0,0 +1,34 @@
+QA output created by 008
+get rdlck
+lock could be placed
+get rdlck
+get rdlck
+lock could be placed
+get rdlck
+get rdlck
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
diff --git a/tests/readonly/009 b/tests/readonly/009
new file mode 100755
index 00000000..215fd136
--- /dev/null
+++ b/tests/readonly/009
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 RedHat Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test NO. 009. Modifed from generic/504.
+#
+# flock test(shared lock, exclusive lock)
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/flock_testfile_$seq
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_command "$FLOCK_PROG" "flock"
+
+testfile=$SCRATCH_DEV/flock_testfile_$seq
+rm -f $testfile
+touch $testfile
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/flock_testfile_$seq
+
+# test shared lock
+flock -sn $testfile -c "echo 'test' > /dev/null"
+
+# test exclusive lockflock
+flock -xn $testfile -c "echo 'test' > /dev/null"
+
+# success, all done
+status=0
+echo "Silence is golden"
+exit
diff --git a/tests/readonly/009.out b/tests/readonly/009.out
new file mode 100644
index 00000000..7e977155
--- /dev/null
+++ b/tests/readonly/009.out
@@ -0,0 +1,2 @@
+QA output created by 009
+Silence is golden
diff --git a/tests/readonly/010 b/tests/readonly/010
new file mode 100755
index 00000000..9821cec0
--- /dev/null
+++ b/tests/readonly/010
@@ -0,0 +1,49 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 010
+#
+# soft link/hard link test
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+	rm -f $SCRATCH_DEV/hardlink
+	rm -f $SCRATCH_DEV/softlink
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_DEV/testfile
+rm -f $testfile
+
+echo "test" >$testfile
+ln -s $testfile $SCRATCH_DEV/softlink
+ln $testfile $SCRATCH_DEV/hardlink
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+cat $SCRATCH_MNT/softlink
+cat $SCRATCH_MNT/hardlink
+stat -c %h $testfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/010.out b/tests/readonly/010.out
new file mode 100644
index 00000000..c40989d5
--- /dev/null
+++ b/tests/readonly/010.out
@@ -0,0 +1,4 @@
+QA output created by 010
+test
+test
+2
diff --git a/tests/readonly/011 b/tests/readonly/011
new file mode 100755
index 00000000..186d32a9
--- /dev/null
+++ b/tests/readonly/011
@@ -0,0 +1,92 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2013 Red Hat, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 011. Modifed from generic/306.
+#
+# Test Write, RW open on a RO fs
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	umount $BINDFILE
+	cd /
+	rm -rf $SCRATCH_DEV/$seq.test
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+THIS_TEST_DIR=$SCRATCH_DEV/$seq.test
+rm -rf $THIS_TEST_DIR
+mkdir $THIS_TEST_DIR || _fail "Could not create dir for test"
+
+DEVNULL=$THIS_TEST_DIR/devnull
+DEVZERO=$THIS_TEST_DIR/devzero
+SYMLINK=$THIS_TEST_DIR/symlink
+BINDFILE=$THIS_TEST_DIR/bindfile
+TARGET=$THIS_TEST_DIR/target
+
+mknod $DEVNULL c 1 3 || _fail "Could not create devnull device"
+mknod $DEVZERO c 1 5 || _fail "Could not create devzero device"
+touch $BINDFILE || _fail "Could not create bind mount file"
+touch $TARGET || _fail "Could not create symlink target"
+ln -s $TARGET $SYMLINK
+touch $THIS_TEST_DIR/testfile
+
+_scratch_mkfs  > /dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+THIS_TEST_DIR=$SCRATCH_MNT/$seq.test
+DEVNULL=$THIS_TEST_DIR/devnull
+DEVZERO=$THIS_TEST_DIR/devzero
+SYMLINK=$THIS_TEST_DIR/symlink
+BINDFILE=$THIS_TEST_DIR/bindfile
+TESTFILE=$THIS_TEST_DIR/testfile
+
+# We should be able to read & write to/from these devices even on an RO fs
+echo "== try to create new file"
+touch $THIS_TEST_DIR/this_should_fail 2>&1 | _filter_scratch
+echo "== try to do write operation to testfile"
+cp $TESTFILE $THIS_TEST_DIR/newfile 2>&1 | _filter_scratch
+truncate -s 300 $TESTFILE 2>&1 | _filter_scratch
+echo "== try to make new dir"
+mkdir -p $THIS_TEST_DIR/newdir 2>&1 | _filter_scratch
+echo "== pwrite to null device"
+$XFS_IO_PROG -c "pwrite 0 512" $DEVNULL | _filter_xfs_io
+echo "== pread from zero device"
+$XFS_IO_PROG -c "pread 0 512" $DEVZERO | _filter_xfs_io
+
+echo "== truncating write to null device"
+echo foo > $DEVNULL 2>&1 | _filter_scratch
+echo "== appending write to null device"
+echo foo >> $DEVNULL 2>&1 | _filter_scratch
+
+echo "== writing to symlink from ro fs to rw fs"
+# Various combinations of O_CREAT & O_TRUNC
+$XFS_IO_PROG -c "pwrite 0 512" $SYMLINK | _filter_xfs_io
+$XFS_IO_PROG -f -c "pwrite 0 512" $SYMLINK | _filter_xfs_io
+$XFS_IO_PROG -t -c "pwrite 0 512" $SYMLINK | _filter_xfs_io
+
+echo "== write to bind-mounted rw file on ro fs"
+mount --bind $TARGET $BINDFILE
+# with and without -f (adds O_CREAT)
+$XFS_IO_PROG -c "pwrite 0 512" $BINDFILE | _filter_xfs_io
+$XFS_IO_PROG -f -c "pwrite 0 512" $BINDFILE | _filter_xfs_io
+$XFS_IO_PROG -t -c "pwrite 0 512" $BINDFILE | _filter_xfs_io
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/011.out b/tests/readonly/011.out
new file mode 100644
index 00000000..1987f7ef
--- /dev/null
+++ b/tests/readonly/011.out
@@ -0,0 +1,30 @@
+QA output created by 011
+== try to create new file
+touch: cannot touch 'SCRATCH_MNT/011.test/this_should_fail': Read-only file system
+== try to do write operation to testfile
+cp: cannot create regular file 'SCRATCH_MNT/011.test/newfile': Read-only file system
+truncate: cannot open 'SCRATCH_MNT/011.test/testfile' for writing: Read-only file system
+== try to make new dir
+mkdir: cannot create directory 'SCRATCH_MNT/011.test/newdir': Read-only file system
+== pwrite to null device
+wrote 512/512 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== pread from zero device
+read 512/512 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== truncating write to null device
+== appending write to null device
+== writing to symlink from ro fs to rw fs
+wrote 512/512 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== write to bind-mounted rw file on ro fs
+wrote 512/512 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/readonly/012 b/tests/readonly/012
new file mode 100755
index 00000000..8263d721
--- /dev/null
+++ b/tests/readonly/012
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2012 Red Hat, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei, Inc. All Rights Reserved.
+#
+# FS QA Test No. 012. Modifed from generic/294.
+#
+# Tests for EEXIST (not EROFS) for inode creations, if
+# we ask to create an already-existing entity on an RO filesystem
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $SCRATCH_DEV/$seq.test
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+THIS_TEST_DIR=$SCRATCH_DEV/$seq.test
+
+_create_files()
+{
+	mknod $THIS_TEST_DIR/testnode c 1 3 2>&1 | _filter_mknod
+	mkdir $THIS_TEST_DIR/testdir
+	touch $THIS_TEST_DIR/testtarget
+	ln -s $THIS_TEST_DIR/testtarget $THIS_TEST_DIR/testlink 2>&1 | _filter_ln
+}
+
+rm -rf $THIS_TEST_DIR
+mkdir $THIS_TEST_DIR || _fail "Could not create dir for test"
+
+_create_files 2>&1 | _filter_scratch
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+THIS_TEST_DIR=$SCRATCH_MNT/$seq.test
+
+_create_files 2>&1 | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/012.out b/tests/readonly/012.out
new file mode 100644
index 00000000..f088f97d
--- /dev/null
+++ b/tests/readonly/012.out
@@ -0,0 +1,5 @@
+QA output created by 012
+mknod: SCRATCH_MNT/012.test/testnode: File exists
+mkdir: cannot create directory 'SCRATCH_MNT/012.test/testdir': File exists
+touch: cannot touch 'SCRATCH_MNT/012.test/testtarget': Read-only file system
+ln: creating symbolic link 'SCRATCH_MNT/012.test/testlink': File exists
diff --git a/tests/readonly/013 b/tests/readonly/013
new file mode 100755
index 00000000..701c9114
--- /dev/null
+++ b/tests/readonly/013
@@ -0,0 +1,47 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 013
+#
+# little file test
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $THIS_TEST_DIR
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+iter=100
+THIS_TEST_DIR=$SCRATCH_DEV/testdir
+
+rm -rf $THIS_TEST_DIR
+mkdir -p $THIS_TEST_DIR
+
+for ((count=1;${count}<=${iter};count++)); do
+	dd if=/dev/urandom of=$THIS_TEST_DIR/file-$count bs=1K count=1K > /dev/null 2>&1
+done
+
+_scratch_mkfs  >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+diff -r $THIS_TEST_DIR $SCRATCH_MNT/testdir
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/readonly/013.out b/tests/readonly/013.out
new file mode 100644
index 00000000..3e66423b
--- /dev/null
+++ b/tests/readonly/013.out
@@ -0,0 +1,2 @@
+QA output created by 013
+Silence is golden
diff --git a/tests/readonly/014 b/tests/readonly/014
new file mode 100755
index 00000000..e0e6f051
--- /dev/null
+++ b/tests/readonly/014
@@ -0,0 +1,46 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei, Inc.  All Rights Reserved.
+#
+# FSQA Test No. 014. Modifed from generic/141.
+#
+# Test for xfs_io mmap read problem
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/mmap
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+# create file
+file=$SCRATCH_DEV/mmap
+rm -f $file
+$XFS_IO_PROG -f -c "pwrite 0 1024k" $file > /dev/null
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+file=$SCRATCH_MNT/mmap
+
+# mmap a region and mmap read it
+$XFS_IO_PROG -r -c "mmap -r 64k 64k" -c "mread -r" $file > /dev/null
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/readonly/014.out b/tests/readonly/014.out
new file mode 100644
index 00000000..db5250b9
--- /dev/null
+++ b/tests/readonly/014.out
@@ -0,0 +1,2 @@
+QA output created by 014
+Silence is golden
diff --git a/tests/readonly/015 b/tests/readonly/015
new file mode 100755
index 00000000..1b4885d3
--- /dev/null
+++ b/tests/readonly/015
@@ -0,0 +1,42 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2009 Eric Sandeen.  All Rights Reserved.
+# Copyright (c) 2019 Huawei, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 015. Modifed from generic/210.
+#
+# Run aio-subblock-eof-read - test AIO read of last block of file
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/aio-test-file
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+file=$SCRATCH_DEV/aio-test-file
+rm -f $file
+truncate -s 300 $file
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+file=$SCRATCH_MNT/aio-test-file
+src/aio-dio-regress/aio-subblock-eof-read $file 300
+
+status=0
+exit
diff --git a/tests/readonly/015.out b/tests/readonly/015.out
new file mode 100644
index 00000000..47de4ebf
--- /dev/null
+++ b/tests/readonly/015.out
@@ -0,0 +1,2 @@
+QA output created by 015
+AIO read of last block in file succeeded.
diff --git a/tests/readonly/016 b/tests/readonly/016
new file mode 100755
index 00000000..c7d44fd3
--- /dev/null
+++ b/tests/readonly/016
@@ -0,0 +1,145 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 016. Modifed from generic/450.
+#
+# Test read around EOF. If the file offset is at or past the end of file,
+# no bytes are read, and read() returns zero.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile_${seq}
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+tfile=$SCRATCH_DEV/testfile_${seq}
+rm -f $tfile
+
+# ssize: sector size
+# bsize: block size
+ssize=512
+bsize=4096
+asize=$((bsize * 2))
+tsize=$((asize - ssize * 2))
+
+$XFS_IO_PROG -ft -c "pwrite 0 ${tsize}" -c "fsync" $tfile >>$seqres.full
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+tfile=$SCRATCH_MNT/testfile_${seq}
+
+# check xfs_io pread result, especially for
+# Param1: expected pread offset
+# Param2: expected pread count
+# Param3: expected pread return
+#
+# If any of above values are not as expected, the output keeps
+# using the real value
+check_xfs_io_read()
+{
+	OFFSET=$1
+	COUNT=$2
+	RETURN=$3
+
+	$AWK_PROG -v ret="$RETURN" -v cnt="$COUNT" -v off="$OFFSET" '
+		/read/{
+			split($2, bytes, "/")
+
+			retval=bytes[1]
+			count=bytes[2]
+			offset=$NF
+
+			if(retval != ret || count != cnt || offset != off)
+				printf("expect [%s,%s,%s], got [%s,%s,%s]\n", \
+					off, cnt, ret, offset, count, retval)
+
+			next
+		}
+	'
+}
+
+# +-------------------------------------------------------+
+# |           block           |           block           |
+# +-------------------------------------------------------+
+# | sect | sect | sect | sect | sect | sect | sect | sect |
+#                                           |
+#                                          EOF
+# |<--------------- move EOF -------------->| xxxxxxxxxxx |
+# [pread1]
+#                             [           pread2          ]
+#                                           [pread3]
+#                                                  [pread4]  ...  [pread5]
+#
+# Run below steps with different $operation and $openflag
+#
+# 1) write 2 blocks (6 sectors) data to move EOF to the penultimate sector
+# 2) read (pread1) the first sector within EOF
+# 3) read (pread2) the second block contain EOF
+# 4) read (pread3) a sector at (after) EOF
+# 5) read (pread4) the last sector past EOF
+# 6) read (pread5) at far away from EOF
+#
+read_test()
+{
+	local of="$1"
+	local op="buffer read"
+
+	if [ "$of" != "" ]; then
+		op="direct read"
+	fi
+
+	echo "$op the first sector within EOF"
+	$XFS_IO_PROG $of -r -c "pread 0 $ssize" $tfile | \
+		check_xfs_io_read 0 "$ssize" "$ssize"
+
+	echo "$op the second block contains EOF"
+	$XFS_IO_PROG $of -r -c "pread $bsize $bsize" $tfile | \
+		check_xfs_io_read "$bsize" "$bsize" "$((tsize - bsize))"
+
+	echo "$op a sector at (after) EOF"
+	$XFS_IO_PROG $of -r -c "pread $tsize $ssize" $tfile | \
+		check_xfs_io_read "$tsize" "$ssize" "0"
+
+	echo "$op the last sector past EOF"
+	$XFS_IO_PROG $of -r -c "pread $((tsize + ssize)) $ssize" $tfile | \
+		check_xfs_io_read "$((tsize + ssize))" "$ssize" "0"
+
+	echo "$op at far away from EOF"
+	$XFS_IO_PROG $of -r -c "pread $((bsize * 100)) $ssize" $tfile | \
+		check_xfs_io_read "$((bsize * 100))" "$ssize" "0"
+}
+
+# Test buffer I/O read
+read_test
+
+# Test direct I/O read(not support)
+rm -f $seqres.full
+echo "direct read the first sector within EOF"
+$XFS_IO_PROG -d -r -c "pread $tsize $ssize" $tfile >>$seqres.full 2>&1
+cat $seqres.full | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/016.out b/tests/readonly/016.out
new file mode 100644
index 00000000..57eecd9c
--- /dev/null
+++ b/tests/readonly/016.out
@@ -0,0 +1,8 @@
+QA output created by 016
+buffer read the first sector within EOF
+buffer read the second block contains EOF
+buffer read a sector at (after) EOF
+buffer read the last sector past EOF
+buffer read at far away from EOF
+direct read the first sector within EOF
+SCRATCH_MNT/testfile_016: Invalid argument
diff --git a/tests/readonly/017 b/tests/readonly/017
new file mode 100755
index 00000000..f5ac2b92
--- /dev/null
+++ b/tests/readonly/017
@@ -0,0 +1,107 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2013 Huawei. All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 017. Modifed from generic/310.
+#
+# Check if there are two threads,one keeps calling read() or lseek(), and
+# the other calling readdir(), both on the same directory fd.
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $SCRATCH_DEV/$seq
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_command "$KILLALL_PROG" killall
+
+dmesg -c > /dev/null
+
+nr_bug=`dmesg | grep -c "kernel BUG"`
+nr_error=`dmesg | grep -c "error"`
+nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
+nr_warning=`dmesg | grep -c "^WARNING"`
+nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
+
+#check if some kind of kernel bug happened
+check_kernel_bug()
+{
+	new_bug=`dmesg | grep -c "kernel BUG"`
+	new_error=`dmesg | grep -c "error"`
+	new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
+	new_warning=`dmesg | grep -c "^WARNING"`
+	new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
+
+	# no kernel bug is detected
+	if [ $new_bug -eq $nr_bug -a $new_error -eq $nr_error -a \
+	     $new_null -eq $nr_null -a $new_warning -eq $nr_warning -a \
+	     $new_lockdep -eq $nr_lockdep ]; then
+		return 0
+	fi
+
+	nr_bug=$new_bug
+	nr_error=$new_error
+	nr_null=$new_null
+	nr_warning=$new_warning
+	nr_lockdep=$new_lockdep
+	return 1
+}
+
+RUN_TIME=$((30 * $TIME_FACTOR))
+
+SEQ_DIR=$SCRATCH_DEV/$seq
+rm -rf $SEQ_DIR
+mkdir -p $SEQ_DIR
+for n in {1..4096}; do
+	touch $SEQ_DIR/$n
+done
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+SEQ_DIR=$SCRATCH_MNT/$seq
+
+_test_read()
+{
+	src/t_readdir_1 $SEQ_DIR &
+	sleep $RUN_TIME
+	$KILLALL_PROG t_readdir_1
+	check_kernel_bug
+	if [ $? -ne 0 ]; then
+		_fatal "kernel bug detected, check dmesg for more information."
+	fi
+}
+
+_test_lseek()
+{
+	src/t_readdir_2 $SEQ_DIR &
+	sleep $RUN_TIME
+	$KILLALL_PROG t_readdir_2
+	check_kernel_bug
+	if [ $? -ne 0 ]; then
+		_fatal "kernel bug detected, check dmesg for more information."
+	fi
+}
+
+_test_read
+_test_lseek
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/readonly/017.out b/tests/readonly/017.out
new file mode 100644
index 00000000..82228448
--- /dev/null
+++ b/tests/readonly/017.out
@@ -0,0 +1,2 @@
+QA output created by 017
+Silence is golden
diff --git a/tests/readonly/018 b/tests/readonly/018
new file mode 100755
index 00000000..40bee5e8
--- /dev/null
+++ b/tests/readonly/018
@@ -0,0 +1,49 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2017 Intel Corporation.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test NO. 018. Modifed from generic/452.
+#
+# This is a regression test for kernel patch:(ls test)
+#   commit 42d4a99b09cb ("ext4: fix fault handling when mounted with -o dax,ro")
+# created by Ross Zwisler <ross.zwisler@linux.intel.com>
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/ls_on_scratch
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+# we need to be able to execute binaries on scratch
+_exclude_scratch_mount_option "noexec"
+
+LS=$(which ls --skip-alias --skip-functions)
+SCRATCH_LS=$SCRATCH_DEV/ls_on_scratch
+cp $LS $SCRATCH_LS
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+SCRATCH_LS=$SCRATCH_MNT/ls_on_scratch
+
+$SCRATCH_LS $SCRATCH_LS | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/018.out b/tests/readonly/018.out
new file mode 100644
index 00000000..f608c03d
--- /dev/null
+++ b/tests/readonly/018.out
@@ -0,0 +1,2 @@
+QA output created by 018
+SCRATCH_MNT/ls_on_scratch
diff --git a/tests/readonly/019 b/tests/readonly/019
new file mode 100755
index 00000000..69c6c7fd
--- /dev/null
+++ b/tests/readonly/019
@@ -0,0 +1,109 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
+# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 019. Modifed from generic/097.
+#
+# simple attr tests for EAs:
+#  - set should return error
+#  - get
+#  - list
+# Basic testing.
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/fooA
+	rm -f $SCRATCH_DEV/fooB
+	rm -f $SCRATCH_DEV/fooC
+}
+
+getfattr()
+{
+	_getfattr --absolute-names "$@" |& _filter_scratch
+}
+
+setfattr()
+{
+	$SETFATTR_PROG "$@" |& _filter_scratch
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/attr
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_attrs
+
+file0=$SCRATCH_DEV/foo0
+fileA=$SCRATCH_DEV/fooA
+fileB=$SCRATCH_DEV/fooB
+fileC=$SCRATCH_DEV/fooC
+
+rm -f $file0
+rm -f $fileA
+rm -f $fileB
+rm -f $fileC
+echo -e "\ncreate file fooA"
+touch $fileA
+
+echo -e "\ncreate file fooB"
+touch $fileB
+echo -e "\nset fooB EA <user.noise,woof>:"
+setfattr -n user.noise -v woof $fileB
+
+echo -e "\ncreate file fooC"
+touch $fileC
+echo -e "\nset fooC EA <user.size,small>:"
+setfattr -n user.size -v small $fileC
+echo -e "\nset fooC EA <user.noise,low>:"
+setfattr -n user.noise -v low $fileC
+echo -e "\nset fooC EA <trusted.colour,blue>:"
+setfattr -n trusted.colour -v blue $fileC
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+file0=$SCRATCH_MNT/foo0
+fileA=$SCRATCH_MNT/fooA
+fileB=$SCRATCH_MNT/fooB
+fileC=$SCRATCH_MNT/fooC
+
+echo -e "\nset SCRATCH_MNT fooA EA"
+setfattr -n user.noise -v woof $fileA
+
+echo -e "\nlist non-existent file0 EA"
+getfattr -d $file0
+
+echo -e "\nshould be no EAs for fooA:"
+getfattr -d $fileA
+
+echo -e "\nlist the EAs for fooB: user.noise"
+getfattr -d $fileB
+
+echo -e "\nlist the EAs for fooC: user.size, user.noise"
+getfattr -d $fileC
+
+echo -e "\nget the value of the fooC user.size EA"
+getfattr -n user.size $fileC
+
+echo -e "\nlist fooC trusted EAs"
+getfattr -d -m '^trusted\.' $fileC
+
+echo -e "success"
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/019.out b/tests/readonly/019.out
new file mode 100644
index 00000000..48593890
--- /dev/null
+++ b/tests/readonly/019.out
@@ -0,0 +1,45 @@
+QA output created by 019
+
+create file fooA
+
+create file fooB
+
+set fooB EA <user.noise,woof>:
+
+create file fooC
+
+set fooC EA <user.size,small>:
+
+set fooC EA <user.noise,low>:
+
+set fooC EA <trusted.colour,blue>:
+
+set SCRATCH_MNT fooA EA
+setfattr: SCRATCH_MNT/fooA: Read-only file system
+
+list non-existent file0 EA
+getfattr: SCRATCH_MNT/foo0: No such file or directory
+
+should be no EAs for fooA:
+
+list the EAs for fooB: user.noise
+# file: SCRATCH_MNT/fooB
+user.noise="woof"
+
+
+list the EAs for fooC: user.size, user.noise
+# file: SCRATCH_MNT/fooC
+user.noise="low"
+user.size="small"
+
+
+get the value of the fooC user.size EA
+# file: SCRATCH_MNT/fooC
+user.size="small"
+
+
+list fooC trusted EAs
+# file: SCRATCH_MNT/fooC
+trusted.colour="blue"
+
+success
diff --git a/tests/readonly/020 b/tests/readonly/020
new file mode 100755
index 00000000..c56c4d3f
--- /dev/null
+++ b/tests/readonly/020
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2016 SUSE Linux Products GmbH. All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 020. Modifed from generic/337.
+#
+# Test that the filesystem's implementation of the listxattrs system call lists
+# all the xattrs an inode has.
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_attrs
+
+rm -f $SCRATCH_DEV/testfile
+touch $SCRATCH_DEV/testfile
+# Create our test file with a few xattrs. The first 3 xattrs have a name that
+# when given as input to a crc32c function result in the same checksum. This
+# made btrfs list only one of the xattrs through listxattrs system call (because
+# it packs xattrs with the same name checksum into the same btree item).
+$SETFATTR_PROG -n user.foobar -v 123 $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.WvG1c1Td -v qwerty $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.J3__T_Km3dVsW_ -v hello $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.something -v pizza $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.ping -v pong $SCRATCH_DEV/testfile
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+# Now call getfattr with --dump, which calls the listxattrs system call.
+# It should list all the xattrs we have set before.
+_getfattr --absolute-names --dump $SCRATCH_MNT/testfile | _filter_scratch
+
+echo -e "success"
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/020.out b/tests/readonly/020.out
new file mode 100644
index 00000000..27ca52a9
--- /dev/null
+++ b/tests/readonly/020.out
@@ -0,0 +1,9 @@
+QA output created by 020
+# file: SCRATCH_MNT/testfile
+user.J3__T_Km3dVsW_="hello"
+user.WvG1c1Td="qwerty"
+user.foobar="123"
+user.ping="pong"
+user.something="pizza"
+
+success
diff --git a/tests/readonly/021 b/tests/readonly/021
new file mode 100755
index 00000000..9d46c8e5
--- /dev/null
+++ b/tests/readonly/021
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 021. Modifed from generic/377.
+#
+# Test listxattr syscall behaviour with different buffer sizes.
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_attrs
+_require_test_program "listxattr"
+
+listxattr="$here/src/listxattr"
+
+# Create a testfile with three xattrs such that the sum of namelengths of the
+# first two is bigger than the namelength of the third. This is needed for
+# the 5th testcase that tests one of the cornercases.
+testfile=$SCRATCH_DEV/testfile
+rm -f $testfile
+touch $testfile
+$SETFATTR_PROG -n user.foo -v bar $testfile
+$SETFATTR_PROG -n user.ping -v pong $testfile
+$SETFATTR_PROG -n user.hello -v there $testfile
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+
+# 1. Call listxattr without buffer length argument. This should succeed.
+$listxattr $testfile | sort
+
+# 2. Calling listxattr on nonexistant file should fail with -ENOENT.
+$listxattr ""
+
+# 3. Calling listxattr with buffersize not suffecient for even one xattr
+# should fail with -ERANGE.
+$listxattr $testfile 1
+
+# 4. Calling listxattr with buffersize suffecient for one xattr, but not
+# sufficient for the whole list should still fail with -ERANGE.
+$listxattr $testfile 9
+
+# 5. Calling listxattr with buffersize suffecient for the last xattr, but not
+# sufficient for the sum of first two. Should fail with -ERANGE.
+$listxattr $testfile 11
+
+# 6. Calling listxattr with buffersize bigger than needed should succeed.
+$listxattr $testfile 500 | sort
+
+status=0
+exit
diff --git a/tests/readonly/021.out b/tests/readonly/021.out
new file mode 100644
index 00000000..09b2c5ea
--- /dev/null
+++ b/tests/readonly/021.out
@@ -0,0 +1,11 @@
+QA output created by 021
+xattr: user.foo
+xattr: user.hello
+xattr: user.ping
+listxattr: No such file or directory
+listxattr: Numerical result out of range
+listxattr: Numerical result out of range
+listxattr: Numerical result out of range
+xattr: user.foo
+xattr: user.hello
+xattr: user.ping
diff --git a/tests/readonly/Makefile b/tests/readonly/Makefile
new file mode 100644
index 00000000..b9a2b641
--- /dev/null
+++ b/tests/readonly/Makefile
@@ -0,0 +1,20 @@
+#
+# Copyright (c) 2019 Huawei.  All Rights Reserved.
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+
+READONLY_DIR = readonly
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(READONLY_DIR)
+
+include $(BUILDRULES)
+
+install:
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 group $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
diff --git a/tests/readonly/group b/tests/readonly/group
new file mode 100644
index 00000000..3953328d
--- /dev/null
+++ b/tests/readonly/group
@@ -0,0 +1,26 @@
+# QA groups control file
+# Defines test groups and nominal group owners
+# - do not start group names with a digit
+# - comment line before each group is "new" description
+#
+001 auto
+002 auto
+003 auto
+004 auto
+005 auto
+006 auto
+007 auto
+008 auto
+009 auto
+010 auto
+011 auto
+012 auto
+013 auto
+014 auto
+015 auto
+016 auto
+017 auto
+018 auto
+019 auto
+020 auto
+021 auto
diff --git a/tests/squashfs/001 b/tests/squashfs/001
new file mode 100755
index 00000000..3f71f122
--- /dev/null
+++ b/tests/squashfs/001
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 001
+#
+# Compression test
+#
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $THIS_TEST_DIR
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+# rarely use lzma, do not test it
+mcomp=(gzip lz4 lzo xz)
+iter=5
+THIS_TEST_DIR=$SCRATCH_DEV/testdir
+
+rm -rf $THIS_TEST_DIR
+mkdir -p $THIS_TEST_DIR
+
+for ((count=1;${count}<=${iter};count++)); do
+	dd if=/dev/urandom of=$THIS_TEST_DIR/file-$count bs=1K count=1024 > /dev/null 2>&1
+	mkdir -p $THIS_TEST_DIR/dir-$count
+	dd if=/dev/urandom of=$THIS_TEST_DIR/dir-$count/file-$count bs=1K count=1024 > /dev/null 2>&1
+done
+
+# Run tests
+for comp in ${mcomp[*]}; do
+	echo "making squashfs image using $comp compression."
+	_scratch_mkfs "-comp $comp" >/dev/null 2>&1
+	if [ $?  != 0 ]; then
+		echo "mksquashfs failed for $comp compression."
+		continue
+	fi
+	echo "Testing mount and diff data."
+	_scratch_mount
+	diff -r $THIS_TEST_DIR $SCRATCH_MNT/testdir
+	_scratch_unmount
+done
+
+status=0
+exit
diff --git a/tests/squashfs/001.out b/tests/squashfs/001.out
new file mode 100644
index 00000000..93cafe6a
--- /dev/null
+++ b/tests/squashfs/001.out
@@ -0,0 +1,9 @@
+QA output created by 001
+making squashfs image using gzip compression.
+Testing mount and diff data.
+making squashfs image using lz4 compression.
+Testing mount and diff data.
+making squashfs image using lzo compression.
+Testing mount and diff data.
+making squashfs image using xz compression.
+Testing mount and diff data.
diff --git a/tests/squashfs/002 b/tests/squashfs/002
new file mode 100755
index 00000000..ae999a38
--- /dev/null
+++ b/tests/squashfs/002
@@ -0,0 +1,40 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 002
+#
+# mksquashfs -no-sparse test, -no-sparse: read all data of sparse files
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+rm -f $SCRATCH_DEV/testfile
+truncate -s 100M $SCRATCH_DEV/testfile
+
+_scratch_mkfs "-no-sparse" >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+# If use -no-sparse, du -h will be 100M
+du -h $SCRATCH_MNT/testfile | awk '{print $1}'
+diff -r $SCRATCH_DEV/testfile $SCRATCH_MNT/testfile
+
+status=0
+exit
diff --git a/tests/squashfs/002.out b/tests/squashfs/002.out
new file mode 100644
index 00000000..7ca3f044
--- /dev/null
+++ b/tests/squashfs/002.out
@@ -0,0 +1,2 @@
+QA output created by 002
+100M
diff --git a/tests/squashfs/003 b/tests/squashfs/003
new file mode 100755
index 00000000..4c2ea806
--- /dev/null
+++ b/tests/squashfs/003
@@ -0,0 +1,55 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 003
+#
+# mksquashfs -xattrs, -no-xattrs test
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_attrs
+
+opts=(-xattrs -no-xattrs)
+
+rm -f $SCRATCH_DEV/testfile
+
+touch $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.foobar -v 123 $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.WvG1c1Td -v qwerty $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.J3__T_Km3dVsW_ -v hello $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.something -v pizza $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.ping -v pong $SCRATCH_DEV/testfile
+
+# Run tests
+for opt in ${opts[*]}; do
+	echo "making squashfs image using $opt"
+	_scratch_mkfs "$opt" >/dev/null 2>&1 || _fail "Could not mkfs scratch device use $opt"
+	_scratch_mount
+	# list all the xattrs we have set before.
+	echo "list all testfile xattr"
+	_getfattr --absolute-names --dump $SCRATCH_MNT/testfile | _filter_scratch
+	_scratch_unmount
+done
+
+status=0
+exit
diff --git a/tests/squashfs/003.out b/tests/squashfs/003.out
new file mode 100644
index 00000000..c55184f8
--- /dev/null
+++ b/tests/squashfs/003.out
@@ -0,0 +1,12 @@
+QA output created by 003
+making squashfs image using -xattrs
+list all testfile xattr
+# file: SCRATCH_MNT/testfile
+user.J3__T_Km3dVsW_="hello"
+user.WvG1c1Td="qwerty"
+user.foobar="123"
+user.ping="pong"
+user.something="pizza"
+
+making squashfs image using -no-xattrs
+list all testfile xattr
diff --git a/tests/squashfs/004 b/tests/squashfs/004
new file mode 100755
index 00000000..bd34b661
--- /dev/null
+++ b/tests/squashfs/004
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 004
+#
+# mksquashfs -no-fragments -always-use-fragments, -noI -noD -noF -noX, -b test
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $THIS_TEST_DIR
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+mfrag=(-no-fragments -always-use-fragments)
+mcomp=(-noI -noD -noF -noX)
+iter=6
+THIS_TEST_DIR=$SCRATCH_DEV/testdir
+
+rm -rf $THIS_TEST_DIR
+mkdir -p $THIS_TEST_DIR
+
+for ((count=1;${count}<=${iter};count++)); do
+	dd if=/dev/urandom of=$THIS_TEST_DIR/file-$count bs=1M count=1 >/dev/null 2>&1
+	mkdir -p $THIS_TEST_DIR/dir-$count
+	dd if=/dev/urandom of=$THIS_TEST_DIR/dir-$count/file-$count bs=1K count=1 >/dev/null 2>&1
+done
+
+for frag in ${mfrag[*]}; do
+	for comp in ${mcomp[*]}; do
+		echo "making squashfs image using 16384 blocksize, $frag, $comp"
+		_scratch_mkfs "-b 16384 $frag $comp" >/dev/null 2>&1
+		if [ $?  != 0 ]; then
+			echo "mksquashfs failed."
+			continue
+		fi
+		echo "Testing mount and diff data."
+		_scratch_mount
+		diff -r $THIS_TEST_DIR $SCRATCH_MNT/testdir
+		_scratch_unmount
+	done
+done
+
+for blocksize in 4096 8192 32768; do
+	echo "making squashfs image using $blocksize blocksize"
+	_scratch_mkfs "-b $blocksize" >/dev/null 2>&1
+	if [ $?  != 0 ]; then
+		echo "mksquashfs failed."
+		continue
+	fi
+	echo "Testing mount and diff data."
+	_scratch_mount
+	diff -r $THIS_TEST_DIR $SCRATCH_MNT/testdir
+	_scratch_unmount
+done
+
+status=0
+exit
diff --git a/tests/squashfs/004.out b/tests/squashfs/004.out
new file mode 100644
index 00000000..e6b65559
--- /dev/null
+++ b/tests/squashfs/004.out
@@ -0,0 +1,23 @@
+QA output created by 004
+making squashfs image using 16384 blocksize, -no-fragments, -noI
+Testing mount and diff data.
+making squashfs image using 16384 blocksize, -no-fragments, -noD
+Testing mount and diff data.
+making squashfs image using 16384 blocksize, -no-fragments, -noF
+Testing mount and diff data.
+making squashfs image using 16384 blocksize, -no-fragments, -noX
+Testing mount and diff data.
+making squashfs image using 16384 blocksize, -always-use-fragments, -noI
+Testing mount and diff data.
+making squashfs image using 16384 blocksize, -always-use-fragments, -noD
+Testing mount and diff data.
+making squashfs image using 16384 blocksize, -always-use-fragments, -noF
+Testing mount and diff data.
+making squashfs image using 16384 blocksize, -always-use-fragments, -noX
+Testing mount and diff data.
+making squashfs image using 4096 blocksize
+Testing mount and diff data.
+making squashfs image using 8192 blocksize
+Testing mount and diff data.
+making squashfs image using 32768 blocksize
+Testing mount and diff data.
diff --git a/tests/squashfs/005 b/tests/squashfs/005
new file mode 100755
index 00000000..2935123d
--- /dev/null
+++ b/tests/squashfs/005
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 005
+#
+# mksquashfs -all-root, -force-uid uid, -force-gid gid test
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1        # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_DEV/testfile
+rm -f $testfile
+
+echo test >$testfile
+chown 1 $testfile
+chgrp 2 $testfile
+chmod 421 $testfile
+
+for ids in "-all-root" "-force-uid 2" "-force-gid 1"; do
+	echo "making squashfs image using $ids"
+	_scratch_mkfs "$ids" >/dev/null 2>&1
+	if [ $?  != 0 ]; then
+		echo "mksquashfs failed."
+		continue
+	fi
+	echo "getting uid, gid"
+	_scratch_mount
+	stat -c %u $SCRATCH_MNT/testfile
+	stat -c %g $SCRATCH_MNT/testfile
+	_scratch_unmount
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/squashfs/005.out b/tests/squashfs/005.out
new file mode 100644
index 00000000..1ee4f9c3
--- /dev/null
+++ b/tests/squashfs/005.out
@@ -0,0 +1,13 @@
+QA output created by 005
+making squashfs image using -all-root
+getting uid, gid
+0
+0
+making squashfs image using -force-uid 2
+getting uid, gid
+2
+2
+making squashfs image using -force-gid 1
+getting uid, gid
+1
+1
diff --git a/tests/squashfs/Makefile b/tests/squashfs/Makefile
new file mode 100644
index 00000000..bbdc91ea
--- /dev/null
+++ b/tests/squashfs/Makefile
@@ -0,0 +1,20 @@
+#
+# Copyright (c) 2019 Huawei.  All Rights Reserved.
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+
+SQUASHFS_DIR = squashfs
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(SQUASHFS_DIR)
+
+include $(BUILDRULES)
+
+install:
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 group $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
diff --git a/tests/squashfs/group b/tests/squashfs/group
new file mode 100644
index 00000000..a3544bc1
--- /dev/null
+++ b/tests/squashfs/group
@@ -0,0 +1,10 @@
+# QA groups control file
+# Defines test groups and nominal group owners
+# - do not start group names with a digit
+# - comment line before each group is "new" description
+#
+001 auto squashfs
+002 auto squashfs
+003 auto squashfs
+004 auto squashfs
+005 auto squashfs
--
2.16.2.dirty
