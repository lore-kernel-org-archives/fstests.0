Received: from mail-qt0-f193.google.com ([209.85.216.193]:33368 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932497AbdJJRVc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Oct 2017 13:21:32 -0400
Received: by mail-qt0-f193.google.com with SMTP id x54so17091147qth.0
        for <fstests@vger.kernel.org>; Tue, 10 Oct 2017 10:21:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/2] perf/001: a random write buffered fio perf test
Date: Tue, 10 Oct 2017 13:21:25 -0400
Message-Id: <1507656085-17101-3-git-send-email-josef@toxicpanda.com>
In-Reply-To: <1507656085-17101-1-git-send-email-josef@toxicpanda.com>
References: <1507656085-17101-1-git-send-email-josef@toxicpanda.com>
Sender: fstests-owner@vger.kernel.org
To: kernel-team@fb.com, fstests@vger.kernel.org, david@fromorbit.com, tytso@mit.edu
Cc: Josef Bacik <jbacik@fb.com>
List-ID: <fstests@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

This uses the new fio results perf helpers to run a rand write buffered
workload on the scratch device.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 tests/perf/001     | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/perf/001.out |  2 ++
 2 files changed, 75 insertions(+)
 create mode 100644 tests/perf/001
 create mode 100644 tests/perf/001.out

diff --git a/tests/perf/001 b/tests/perf/001
new file mode 100644
index 000000000000..d2188ebaaf31
--- /dev/null
+++ b/tests/perf/001
@@ -0,0 +1,73 @@
+#! /bin/bash
+# perf/001 Test
+#
+# Buffered random write performance test.
+#
+#-----------------------------------------------------------------------
+# (c) 2017 Josef Bacik
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
+#
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
+fio_results=$tmp.json
+status=1	# failure is the default!
+trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_block_device $SCRATCH_DEV
+_fio_results_init
+
+rm -f $seqres.full
+
+_size=(16 * $LOAD_FACTOR)
+
+cat >$fio_config <<EOF
+[t1]
+directory=${SCRATCH_MNT}
+allrandrepeat=1
+readwrite=randwrite
+size=${_size}G
+ioengine=psync
+end_fsync=1
+fallocate=none
+EOF
+
+_require_fio $fio_config
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+cat $fio_config >> $seqres.full
+run_check $FIO_PROG --output-format=json --output=$fio_results $fio_config
+
+_scratch_unmount
+_fio_results_compare $seq $fio_results
+echo "Silence is golden"
+status=0; exit
diff --git a/tests/perf/001.out b/tests/perf/001.out
new file mode 100644
index 000000000000..88678b8ed5ad
--- /dev/null
+++ b/tests/perf/001.out
@@ -0,0 +1,2 @@
+QA output created by 001
+Silence is golden
-- 
2.7.4

