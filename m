Received: from szxga04-in.huawei.com ([45.249.212.190]:2207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfAVDUf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 22:20:35 -0500
From: zhengbin <zhengbin13@huawei.com>
Subject: [PATCH 4/6] squashfs: add data test
Date: Tue, 22 Jan 2019 11:24:06 +0800
Message-ID: <20190122032408.91336-5-zhengbin13@huawei.com>
In-Reply-To: <20190122032408.91336-1-zhengbin13@huawei.com>
References: <20190122032408.91336-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, guaneryu@gmail.com, fstests@vger.kernel.org
Cc: houtao1@huawei.com, zhaohongjiang@huawei.com, zhengbin13@huawei.com
List-ID: <fstests@vger.kernel.org>

This patch add data test(write, mmap read, aio read, buffer read,
direct read, dir read, ls). Readonly/015 is modified from
generic/210, but it does not test direct read(squashfs does not
support this), so I add a new file(aio-subblock-eof-read.c).

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 .gitignore                                  |   1 +
 src/aio-dio-regress/aio-subblock-eof-read.c |  84 ++++++++++++++++
 tests/readonly/011                          |  92 ++++++++++++++++++
 tests/readonly/011.out                      |  30 ++++++
 tests/readonly/012                          |  56 +++++++++++
 tests/readonly/012.out                      |   5 +
 tests/readonly/013                          |  47 +++++++++
 tests/readonly/013.out                      |   2 +
 tests/readonly/014                          |  46 +++++++++
 tests/readonly/014.out                      |   2 +
 tests/readonly/015                          |  42 ++++++++
 tests/readonly/015.out                      |   2 +
 tests/readonly/016                          | 145 ++++++++++++++++++++++++++++
 tests/readonly/016.out                      |   8 ++
 tests/readonly/017                          | 107 ++++++++++++++++++++
 tests/readonly/017.out                      |   2 +
 tests/readonly/018                          |  49 ++++++++++
 tests/readonly/018.out                      |   2 +
 tests/readonly/group                        |   8 ++
 19 files changed, 730 insertions(+)
 create mode 100644 src/aio-dio-regress/aio-subblock-eof-read.c
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
diff --git a/tests/readonly/group b/tests/readonly/group
index f87b1fc3..c5bca62c 100644
--- a/tests/readonly/group
+++ b/tests/readonly/group
@@ -13,3 +13,11 @@
 008 auto
 009 auto
 010 auto
+011 auto
+012 auto
+013 auto
+014 auto
+015 auto
+016 auto
+017 auto
+018 auto
--
2.16.2.dirty
