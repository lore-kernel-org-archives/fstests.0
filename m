Received: from cn.fujitsu.com ([222.73.24.84]:9785 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbcFHDDn (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 7 Jun 2016 23:03:43 -0400
Received: from localhost.localdomain (unknown [10.167.226.107])
	by cn.fujitsu.com (Postfix) with ESMTP id AA77A4056434
	for <fstests@vger.kernel.org>; Wed,  8 Jun 2016 11:03:29 +0800 (CST)
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] fstests: ext4: regression test for fsync transaction ids initialization
Date: Wed,  8 Jun 2016 11:02:25 +0800
Message-Id: <1465354945-11307-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Commit 688f869 fixed this bug:
    ext4: ext4: Initialize fsync transaction ids in ext4_new_inode()

We manually modify jbd2 journal_superblock_s.s_sequence to be a very large
number, which will greatly reduce the time taken to trigger this bug, though
it seems some too hacked.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
 tests/ext4/021     | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/021.out |   2 +
 tests/ext4/group   |   1 +
 3 files changed, 120 insertions(+)
 create mode 100755 tests/ext4/021
 create mode 100644 tests/ext4/021.out

diff --git a/tests/ext4/021 b/tests/ext4/021
new file mode 100755
index 0000000..cdc1524
--- /dev/null
+++ b/tests/ext4/021
@@ -0,0 +1,117 @@
+#! /bin/bash
+# FS QA Test 021
+#
+# Regression test for commit:
+# 688f869 ext4: Initialize fsync transaction ids in ext4_new_inode()
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	$UMOUNT_PROG $loop_mnt
+	_destroy_loop_device $loop_dev1
+	_destroy_loop_device $loop_dev2
+	rm -rf $loop_mnt
+	rm -f $fs_img1 $fs_img2
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+_require_test
+_require_loop
+
+BLOCKSIZE=1024
+loop_mnt=$TEST_DIR/$seq.$$.mnt
+fs_img1=$TEST_DIR/$seq.$$.img1
+fs_img2=$TEST_DIR/$seq.$$.img2
+mkdir $loop_mnt
+$XFS_IO_PROG -f -c "truncate 128m" $fs_img1 >>$seqres.full 2>&1
+$XFS_IO_PROG -f -c "truncate 16m" $fs_img2 >>$seqres.full 2>&1
+
+loop_dev1=`_create_loop_device $fs_img1`
+loop_dev2=`_create_loop_device $fs_img2`
+
+_mkfs_dev -b $BLOCKSIZE -O journal_dev $loop_dev2 >>$seqres.full 2>&1
+_mkfs_dev -b $BLOCKSIZE -J device=$loop_dev2 $loop_dev1 >>$seqres.full 2>&1
+
+# Below command will modify jbd2 journal transaction id to be 2178000000,
+# which will reduce the time taken to trigger this bug. When ext4 fs block
+# size is 1024, journal superblock will start at offset 2048, and
+# journal_superblock_s.s_sequence will start at offset 2072. After this
+# modification, jbd2 will will start to run with a initial transaction id
+# 2178000000.
+echo 81d1a480 | xxd -r -ps | dd of=$loop_dev2 bs=4 count=1 seek=518 >/dev/null 2>&1
+
+trans_id=$(dumpe2fs $loop_dev2 2>/dev/null | grep "Journal sequence" | \
+  awk -F ":" '{print $2}')
+trans_id=$((trans_id))
+if [ $trans_id -ne 2178000000 ]; then
+	echo "fail to set initial transaction id to 2178000000"
+	exit
+fi
+echo "Initial transaction id is $trans_id"
+
+_mount $loop_dev1 $loop_mnt
+cd $loop_mnt
+
+cat >do_fdatasync.c <<EOF
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/types.h>
+
+void main(void)
+{
+	int fd;
+
+	fd = open("testfile", O_RDWR | O_CREAT | O_EXCL);
+	while (1)
+		fdatasync(fd);
+}
+EOF
+gcc -o do_fdatasync do_fdatasync.c >> $seqres.full 2>&1 || \
+  _notrun "Could not compile test program (see end of $seqres.full)"
+
+./do_fdatasync &
+child_process=$!
+
+sleep 60
+kill $child_process >/dev/null 2>&1
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/021.out b/tests/ext4/021.out
new file mode 100644
index 0000000..ee3e81d
--- /dev/null
+++ b/tests/ext4/021.out
@@ -0,0 +1,2 @@
+QA output created by 021
+Initial transaction id is 2178000000
diff --git a/tests/ext4/group b/tests/ext4/group
index 9e28159..7736da1 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -23,6 +23,7 @@
 018 fuzzers
 019 fuzzers
 020 auto quick ioctl rw
+021 auto
 271 auto rw quick
 301 aio auto ioctl rw stress
 302 aio auto ioctl rw stress
-- 
2.5.0



