Received: from mx2.suse.de ([195.135.220.15]:36192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728682AbfDBKeg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 Apr 2019 06:34:36 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH 2/2] ceph: test basic ceph.quota.max_bytes quota
Date: Tue,  2 Apr 2019 11:34:28 +0100
Message-Id: <20190402103428.21435-3-lhenriques@suse.com>
In-Reply-To: <20190402103428.21435-1-lhenriques@suse.com>
References: <20190402103428.21435-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

Simple set of checks for CephFS max_bytes directory quota implementation.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 tests/ceph/002     | 147 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ceph/002.out |   1 +
 tests/ceph/group   |   1 +
 3 files changed, 149 insertions(+)
 create mode 100755 tests/ceph/002
 create mode 100644 tests/ceph/002.out

diff --git a/tests/ceph/002 b/tests/ceph/002
new file mode 100755
index 000000000000..313865dc639e
--- /dev/null
+++ b/tests/ceph/002
@@ -0,0 +1,147 @@
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
+testdir=$TEST_DIR/quota-test
+
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	rm -rf $testdir
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
+	val=$1
+	dir=$2
+	$SETFATTR_PROG -n ceph.quota.max_bytes -v $val $dir >/dev/null 2>&1
+}
+
+get_quota()
+{
+	dir=$1
+	$GETFATTR_PROG --only-values -n ceph.quota.max_bytes $dir 2> /dev/null
+}
+
+# function to write a file.  We use a loop because quotas in CephFS is a
+# "best-effort" implementation, i.e. a write may actually be allowed even if the
+# quota is being exceeded.  Using a loop reduces the chances of this to happen.
+#
+# NOTE: 'size' parameter is in M
+write_file()
+{
+	file=$1
+	size=$2 # size in M
+	for (( i = 1; i < $size; i++ )); do
+		$XFS_IO_PROG -f -c "pwrite -W $((i * 1048576)) 1048576" \
+			     $file >/dev/null 2>&1
+	done
+}
+
+# Check a file size
+#
+# NOTE: 'expected' (size) parameter is in M
+check_file_size()
+{
+	file=$1
+	expected=$(($2 * 1048576))
+	size=$(stat -c %s $file)
+	if [ "$size" -ne "$expected" ]; then
+		_fail "Expecting file with $expected got $size"
+	fi
+}
+
+mkdir $testdir
+
+# test setting quota
+set_quota 1000000 $testdir
+ret=$(get_quota $testdir)
+if [ "$ret" -ne 1000000 ]; then
+	_fail "expected max_bytes quota to be 1000000, got '$ret' instead"
+fi
+# set quota to largest acceptable value (0x7FFFFFFFFFFFFFFF)
+set_quota 9223372036854775807 $testdir
+ret=$(get_quota $testdir)
+if [ "$ret" -ne 9223372036854775807 ]; then
+	_fail "expected max_bytes quota to be 9223372036854775807, got '$ret' instead"
+fi
+# test resetting quota
+set_quota 0 $testdir
+ret=$(get_quota $testdir)
+if [ -n "$ret" ]; then
+	_fail "expected 0 max_bytes quota, got '$ret' instead"
+fi
+# set quota to invalid values (0x8000000000000000 and -1)
+set_quota 9223372036854775808 $testdir
+ret=$(get_quota $testdir)
+if [ -n "$ret" ]; then
+	_fail "expected max_bytes quota to be 0, got '$ret' instead"
+fi
+set_quota -1 $testdir
+ret=$(get_quota $testdir)
+if [ -n "$ret" ]; then
+	_fail "expected max_bytes quota to be 0, got '$ret' instead"
+fi
+
+bigfile="$testdir/bigfile"
+
+# set quota to 10M
+set_quota $((10 * 1048576)) $testdir
+
+# write 9M file
+write_file $bigfile 9
+check_file_size $bigfile 9
+rm $bigfile
+
+# try to write 11M file
+write_file $bigfile 11 # 11M
+check_file_size $bigfile 10
+rm $bigfile
+
+# write 5 x 2M files
+for (( j = 1; j < 6; j++ )); do
+	smallfile="$testdir/smallfile_$j"
+	write_file $smallfile 2 # 2M
+	check_file_size $smallfile 2
+done
+
+# try write another 2M file
+smallfile="$testdir/smallfile_fail"
+write_file $smallfile 2
+check_file_size $smallfile 0
+
+# reset quota
+set_quota 0 $testdir
+
+# write 2M file
+write_file $smallfile 2
+check_file_size $smallfile 2
+
+# success, all done
+status=0
+exit
diff --git a/tests/ceph/002.out b/tests/ceph/002.out
new file mode 100644
index 000000000000..c57ca23e5cbe
--- /dev/null
+++ b/tests/ceph/002.out
@@ -0,0 +1 @@
+QA output created by 002
diff --git a/tests/ceph/group b/tests/ceph/group
index e389bc6ec7ee..02da95169c67 100644
--- a/tests/ceph/group
+++ b/tests/ceph/group
@@ -1 +1,2 @@
 001 auto quick quota
+002 auto quick quota
