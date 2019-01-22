Received: from szxga07-in.huawei.com ([45.249.212.35]:58348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726839AbfAVDUf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 22:20:35 -0500
From: zhengbin <zhengbin13@huawei.com>
Subject: [PATCH 6/6] squashfs: add mksquashfs options test
Date: Tue, 22 Jan 2019 11:24:08 +0800
Message-ID: <20190122032408.91336-7-zhengbin13@huawei.com>
In-Reply-To: <20190122032408.91336-1-zhengbin13@huawei.com>
References: <20190122032408.91336-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, guaneryu@gmail.com, fstests@vger.kernel.org
Cc: houtao1@huawei.com, zhaohongjiang@huawei.com, zhengbin13@huawei.com
List-ID: <fstests@vger.kernel.org>

This patch add mksquashfs options test(compressors, sparse file,
xattr, block size, fragment, compress inode,data,fragment,xattr,
file owner).

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 tests/squashfs/001      | 60 ++++++++++++++++++++++++++++++++++++++++
 tests/squashfs/001.out  |  9 ++++++
 tests/squashfs/002      | 40 +++++++++++++++++++++++++++
 tests/squashfs/002.out  |  2 ++
 tests/squashfs/003      | 55 +++++++++++++++++++++++++++++++++++++
 tests/squashfs/003.out  | 12 ++++++++
 tests/squashfs/004      | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/squashfs/004.out  | 23 ++++++++++++++++
 tests/squashfs/005      | 54 ++++++++++++++++++++++++++++++++++++
 tests/squashfs/005.out  | 13 +++++++++
 tests/squashfs/Makefile | 20 ++++++++++++++
 tests/squashfs/group    | 10 +++++++
 12 files changed, 371 insertions(+)
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
