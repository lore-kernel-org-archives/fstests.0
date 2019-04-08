Received: from mx2.suse.de ([195.135.220.15]:53882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbfDHQIs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 8 Apr 2019 12:08:48 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v3 2/2] ceph: test basic ceph.quota.max_bytes quota
Date: Mon,  8 Apr 2019 17:08:42 +0100
Message-Id: <20190408160842.23649-3-lhenriques@suse.com>
In-Reply-To: <20190408160842.23649-1-lhenriques@suse.com>
References: <20190408160842.23649-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Dave Chinner <david@fromorbit.com>, Eryu Guan <guaneryu@gmail.com>, ceph-devel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

Simple set of checks for CephFS max_bytes directory quota implementation.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 tests/ceph/002     | 127 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ceph/002.out |  64 +++++++++++++++++++++++
 tests/ceph/group   |   1 +
 3 files changed, 192 insertions(+)
 create mode 100755 tests/ceph/002
 create mode 100644 tests/ceph/002.out

diff --git a/tests/ceph/002 b/tests/ceph/002
new file mode 100755
index 000000000000..0edeb10b104e
--- /dev/null
+++ b/tests/ceph/002
@@ -0,0 +1,127 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 SUSE LLC. All Rights Reserved.
+#
+# FS QA Test No. 002
+#
+# This tests basic ceph.quota.max_bytes quota features.
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+workdir=$TEST_DIR/$seq
+
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs ceph
+
+_require_attrs
+
+set_quota()
+{
+	local val=$1
+	local dir=$2
+	$SETFATTR_PROG -n ceph.quota.max_bytes -v $val $dir >>$seqres.full 2>&1
+}
+
+get_quota()
+{
+	local dir=$1
+	_getfattr -n ceph.quota.max_bytes --absolute-names $dir \
+		  2>>$seqres.full | _filter_test_dir
+}
+
+# function to write a file.  We use a loop because quotas in CephFS is a
+# "best-effort" implementation, i.e. a write may actually be allowed even if the
+# quota is being exceeded.  Using a loop reduces the chances of this to happen:
+# the usage of fsync (-W in xfs_io) and the open/close of the file will make
+# sure the file size is be updated in the MDSs.
+#
+# NOTE: 'size' parameter is in M
+write_file()
+{
+	local file=$1
+	local size=$2 # size in M
+	for (( i = 1; i < $size; i++ )); do
+		$XFS_IO_PROG -f -c "pwrite -W $((i * 1048576)) 1m" \
+			     $file | _filter_xfs_io
+	done
+}
+
+rm -f $seqres.full
+rm -rf $workdir
+mkdir $workdir
+
+# test setting quota
+set_quota 1000000 $workdir
+get_quota $workdir
+
+# set quota to largest acceptable value (0x7FFFFFFFFFFFFFFF)
+set_quota 9223372036854775807 $workdir
+get_quota $workdir
+
+# test resetting quota
+set_quota 0 $workdir
+get_quota $workdir
+
+# set quota to invalid values (0x8000000000000000 and -1)
+set_quota 9223372036854775808 $workdir
+get_quota $workdir
+
+set_quota -1 $workdir
+get_quota $workdir
+
+bigfile="$workdir/bigfile"
+
+# set quota to 10M
+set_quota $((10 * 1048576)) $workdir
+
+# write 9M file
+write_file $bigfile 9
+stat -c %s $bigfile
+rm $bigfile
+
+# try to write 11M file
+write_file $bigfile 11 # 11M
+stat -c %s $bigfile
+rm $bigfile
+
+# write 5 x 2M files
+for (( j = 1; j < 6; j++ )); do
+	smallfile="$workdir/smallfile_$j"
+	write_file $smallfile 2 # 2M
+	stat -c %s $smallfile
+done
+
+# try to write another 2M file, should fail
+smallfile="$workdir/smallfile_fail"
+write_file $smallfile 2
+stat -c %s $smallfile
+
+# reset quota
+set_quota 0 $workdir
+
+# write 2M file
+write_file $smallfile 2
+stat -c %s $smallfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/ceph/002.out b/tests/ceph/002.out
new file mode 100644
index 000000000000..f5881e532a3e
--- /dev/null
+++ b/tests/ceph/002.out
@@ -0,0 +1,64 @@
+QA output created by 002
+# file: TEST_DIR/002
+ceph.quota.max_bytes="1000000"
+
+# file: TEST_DIR/002
+ceph.quota.max_bytes="9223372036854775807"
+
+wrote 1048576/1048576 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 2097152
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 3145728
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 4194304
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 5242880
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 6291456
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 7340032
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 8388608
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+9437184
+wrote 1048576/1048576 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 2097152
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 3145728
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 4194304
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 5242880
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 6291456
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 7340032
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 8388608
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 9437184
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+pwrite: Disk quota exceeded
+10485760
+wrote 1048576/1048576 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2097152
+wrote 1048576/1048576 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2097152
+wrote 1048576/1048576 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2097152
+wrote 1048576/1048576 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2097152
+wrote 1048576/1048576 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2097152
+pwrite: Disk quota exceeded
+0
+wrote 1048576/1048576 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2097152
diff --git a/tests/ceph/group b/tests/ceph/group
index e389bc6ec7ee..02da95169c67 100644
--- a/tests/ceph/group
+++ b/tests/ceph/group
@@ -1 +1,2 @@
 001 auto quick quota
+002 auto quick quota
