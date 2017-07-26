Received: from mx1.redhat.com ([209.132.183.28]:45802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbdGZKsI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Jul 2017 06:48:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 833C8267C6
        for <fstests@vger.kernel.org>; Wed, 26 Jul 2017 10:48:08 +0000 (UTC)
Received: from dhcp-13-64.nay.redhat.com (dhcp-13-64.nay.redhat.com [10.66.13.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B75CE77EF7
        for <fstests@vger.kernel.org>; Wed, 26 Jul 2017 10:48:07 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] generic: test read around EOF
Date: Wed, 26 Jul 2017 18:48:04 +0800
Message-Id: <20170726104804.25903-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

As posix standard, if the file offset is at or past the end of file,
no bytes are read, and read() returns zero. But there was a bug,
when DIO read offset is just past the EOF a little, but in the same
block with EOF, read returns different negative values.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

V2 did below changes:
1) move falloc, resvsp, allocsp related test to be special test,
   no standard output
2) pick up pread related test into read_test() function

Thanks,
Zorro

 tests/generic/450     | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/450.out |  50 +++++++++++++++
 tests/generic/group   |   1 +
 3 files changed, 222 insertions(+)
 create mode 100755 tests/generic/450
 create mode 100644 tests/generic/450.out

diff --git a/tests/generic/450 b/tests/generic/450
new file mode 100755
index 00000000..5fbe7f0c
--- /dev/null
+++ b/tests/generic/450
@@ -0,0 +1,171 @@
+#! /bin/bash
+# FS QA Test 450
+#
+# Test read around EOF. If the file offset is at or past the end of file,
+# no bytes are read, and read() returns zero. But there was a bug, when
+# DIO read offset is just past the EOF a little, but in the same block
+# with EOF, read returns different negative values.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
+	rm -f $tfile
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
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+
+tfile=$TEST_DIR/testfile_${seq}
+ssize=`blockdev --getss $TEST_DEV`
+bsize=`_get_block_size $TEST_DIR`
+
+rm -f $tfile 2>/dev/null
+
+# check xfs_io pread result, especially for
+# Param1: expected pread return
+# Param2: expected pread count
+# Param3: expected pread offset
+#
+# If any of above values are not as expected, the output keeps
+# using the real value
+check_xfs_io_read()
+{
+	RETURN=$1
+	COUNT=$2
+	OFFSET=$3
+
+	$AWK_PROG -v ret="$RETURN" -v cnt="$COUNT" -v off="$OFFSET" '
+		/read/{
+			split($2, bytes, "/")
+
+			retval=bytes[1]
+			count=bytes[2]
+			offset=$NF
+
+			if(retval == ret) retval="X"
+			if(count == cnt) count="XX"
+			if(offset == off) offset="XXX"
+
+			printf("read [%s/%s %s]\n", retval, count, offset)
+
+			next
+		}
+	'
+}
+
+
+# +-----------------------------------------+
+# |    block    |    block    |    block    |
+# +------------------------------------------
+# | sect | sect | sect | sect | sect | sect |
+#                                  |
+#                                 EOF
+# |<----------- move EOF --------->| xxxxxx |
+# [pread1]
+#               [           pread2          ]
+#                                    [pread3]     ...   [pread4]
+#
+# Run below steps with differnt $operation and $openflag
+#
+# 1) use $operation (alloc/reserve/truncate ...) to move EOF
+# 2) read (pread1) the first sector doesn't contain EOF
+# 3) read (pread2) the 2nd and 3rd blocks contain EOF
+# 4) read (pread3) the last sector which just out of EOF
+# 5) read (pread4) at far far away from EOF
+#
+# NOTE: This case generally test on sector size < block size, but equal is fine
+#
+asize=$((bsize * 3))
+tsize=$((asize - ssize - 100))
+
+read_test()
+{
+	$XFS_IO_PROG $oflag -c "pread 0 $ssize" $tfile | \
+		check_xfs_io_read "$ssize" "$ssize" "0"
+
+	$XFS_IO_PROG $oflag -c "pread $bsize $((bsize * 2))" $tfile | \
+		check_xfs_io_read "$((tsize - bsize))" "$((bsize * 2))" "$bsize"
+
+	$XFS_IO_PROG $oflag -c "pread $((bsize * 3 - ssize)) $ssize" $tfile | \
+		check_xfs_io_read "0" "$ssize" "$((bsize * 3 - ssize))"
+
+	$XFS_IO_PROG $oflag -c "pread $((bsize * 100)) $ssize" $tfile | \
+		check_xfs_io_read "0" "$ssize" "$((bsize * 100))"
+}
+
+# Generic test
+for oflag in "" "-d" "-s" "-sd"; do
+	for oper in "pwrite 0 ${tsize}" "truncate ${tsize}"; do
+		echo "## Test ${oper%% *} and read with open ${oflag} ##" | \
+			tee -a $seqres.full
+
+		$XFS_IO_PROG -ft -c "$oper" $tfile >>$seqres.full
+
+		read_test
+
+		echo | tee -a $seqres.full
+	done
+done
+
+# XFS test
+echo "## Extra testing, no output is expected below ##"
+for oflag in "" "-d" "-s" "-sd"; do
+	for oper in "falloc 0 ${tsize}" \
+		    "resvsp 0 ${asize}" \
+		    "allocsp ${tsize} 0"; do
+		echo "## Test ${oper%% *} and read with open ${oflag} ##" >> $seqres.full
+
+		# Drop all output, for some filesystems don't support these
+		# test operations
+		$XFS_IO_PROG -ft -c "truncate ${tsize}" -c "$oper" $tfile >>$seqres.full 2>&1
+
+		# For keeping golden image consistency in different filesystems,
+		# drop the output, but not error output
+		read_test >>$seqres.full
+
+		echo >> $seqres.full
+	done
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/450.out b/tests/generic/450.out
new file mode 100644
index 00000000..ad2570e8
--- /dev/null
+++ b/tests/generic/450.out
@@ -0,0 +1,50 @@
+QA output created by 450
+## Test pwrite and read with open  ##
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+
+## Test truncate and read with open  ##
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+
+## Test pwrite and read with open -d ##
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+
+## Test truncate and read with open -d ##
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+
+## Test pwrite and read with open -s ##
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+
+## Test truncate and read with open -s ##
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+
+## Test pwrite and read with open -sd ##
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+
+## Test truncate and read with open -sd ##
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+read [X/XX XXX]
+
+## Extra testing, no output is expected below ##
diff --git a/tests/generic/group b/tests/generic/group
index a04cc900..0b29be0a 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -452,3 +452,4 @@
 447 auto quick clone
 448 auto quick rw
 449 auto quick acl enospc
+450 auto quick rw
-- 
2.13.3

