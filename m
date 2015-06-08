Received: from mx1.redhat.com ([209.132.183.28]:33124 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753040AbbFHKlx (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 8 Jun 2015 06:41:53 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 5257019F98B
	for <fstests@vger.kernel.org>; Mon,  8 Jun 2015 10:41:53 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic: concurrent IO test with mixed IO types
Date: Mon,  8 Jun 2015 18:41:41 +0800
Message-Id: <1433760101-25540-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: lczerner@redhat.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Test concurrent buffered I/O, DIO, AIO, mmap I/O and splice I/O on the
same files.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

This fio job file has been proven to be potent, it triggers WARNINGs on ext4
and xfs with 4.1-rc6 kernel.

ext4: WARNING: at fs/ext4/inode.c:1328
xfs: WARNING: CPU: 7 PID: 3090 at fs/xfs/xfs_file.c:726 xfs_file_dio_aio_write+0x176/0x2a8 [xfs]()

The ext4 issue should be fixed by Lukas's patch
ext4: fix reservation release on invalidatepage for delalloc fs

And it ever paniced kernel in mm code and hung xfs.

I reduced the numjobs and iodepth to reduce the test time(~25s on my test host)
and scale them by $LOAD_FACTOR. And it still could trigger the warning on ext4
and xfs with reduced workload.

 tests/generic/090     | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/090.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 124 insertions(+)
 create mode 100755 tests/generic/090
 create mode 100644 tests/generic/090.out

diff --git a/tests/generic/090 b/tests/generic/090
new file mode 100755
index 0000000..748e935
--- /dev/null
+++ b/tests/generic/090
@@ -0,0 +1,121 @@
+#! /bin/bash
+# FS QA Test generic/090
+#
+# Concurrent mixed I/O (buffer I/O, aiodio, mmap, splice) on the same files
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
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
+fio_config=$tmp.fio
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
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
+iodepth=$((16 * LOAD_FACTOR))
+iodepth_batch=$((8 * LOAD_FACTOR))
+numjobs=$((5 * LOAD_FACTOR))
+cat >$fio_config <<EOF
+[global]
+bs=8k
+iodepth=$iodepth
+iodepth_batch=$iodepth_batch
+randrepeat=1
+size=1m
+directory=$SCRATCH_MNT
+numjobs=$numjobs
+[job1]
+ioengine=sync
+bs=1k
+direct=1
+rw=randread
+filename=file1:file2
+[job2]
+ioengine=libaio
+rw=randwrite
+direct=1
+filename=file1:file2
+[job3]
+bs=1k
+ioengine=posixaio
+rw=randwrite
+direct=1
+filename=file1:file2
+[job4]
+ioengine=splice
+direct=1
+rw=randwrite
+filename=file1:file2
+[job5]
+bs=1k
+ioengine=sync
+rw=randread
+filename=file1:file2
+[job6]
+ioengine=posixaio
+rw=randwrite
+filename=file1:file2
+[job7]
+ioengine=splice
+rw=randwrite
+filename=file1:file2
+[job8]
+ioengine=mmap
+rw=randwrite
+bs=1k
+filename=file1:file2
+[job9]
+ioengine=mmap
+rw=randwrite
+direct=1
+filename=file1:file2
+EOF
+# with ioengine=mmap and direct=1, fio requires bs to be at least pagesize,
+# which is a fio built-in var.
+echo 'bs=$pagesize' >> $fio_config
+
+rm -f $seqres.full
+
+_require_fio $fio_config
+
+echo "Silence is golden"
+$FIO_PROG $fio_config >>$seqres.full 2>&1
+
+# all done, expect no hang no oops no fs corruption,
+# _check_dmesg and _check_filesystems will do the check work for us
+status=0
+exit
diff --git a/tests/generic/090.out b/tests/generic/090.out
new file mode 100644
index 0000000..2b5100d
--- /dev/null
+++ b/tests/generic/090.out
@@ -0,0 +1,2 @@
+QA output created by 090
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 0c8964c..2e534a5 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -92,6 +92,7 @@
 087 perms auto quick
 088 perms auto quick
 089 metadata auto
+090 auto rw stress
 091 rw auto quick
 092 auto quick prealloc
 093 attr cap udf auto
-- 
1.8.3.1

