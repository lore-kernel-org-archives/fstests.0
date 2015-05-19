Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49059 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931AbbESRNq (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 19 May 2015 13:13:46 -0400
Received: from pps.filterd (m0044012 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id t4JH79fW030863
	for <fstests@vger.kernel.org>; Tue, 19 May 2015 10:13:45 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 1ug6pu8d3a-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Tue, 19 May 2015 10:13:45 -0700
From: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] generic: add fiemap test that does prealloc
Date: Tue, 19 May 2015 13:13:42 -0400
Message-ID: <1432055622-8638-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

I noticed that btrfs wasn't setting unwritten on prealloc test, and then
subsequently noticed that we weren't testing fiemap on prealloc extents with the
fiemap-tester.  This patch adds another test that does the same as generic/225
only with prealloc enabled.  Thanks,

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 tests/generic/328     | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/328.out |  3 ++
 tests/generic/group   |  1 +
 3 files changed, 82 insertions(+)
 create mode 100644 tests/generic/328
 create mode 100644 tests/generic/328.out

diff --git a/tests/generic/328 b/tests/generic/328
new file mode 100644
index 0000000..b6d6917
--- /dev/null
+++ b/tests/generic/328
@@ -0,0 +1,78 @@
+#! /bin/bash
+# FS QA Test No. 328
+#
+# Run the fiemap (file extent mapping) tester with preallocation enabled
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2009 Eric Sandeen.  All Rights Reserved.
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
+tmp=tmp/$$
+status=1  # failure is the default!
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
+_require_xfs_io_command "fiemap"
+_require_xfs_io_command "falloc"
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount > /dev/null 2>&1
+
+rm -f $seqres.full
+fiemapfile=$SCRATCH_MNT/$seq.fiemap
+fiemaplog=$SCRATCH_MNT/$seq.log
+
+[ -x $here/src/fiemap-tester ] || _notrun "fiemap-tester not built"
+
+seed=`date +%s`
+
+echo "using seed $seed" >> $fiemaplog
+
+echo "fiemap run with sync"
+$here/src/fiemap-tester -q -S -s $seed -r 200 $fiemapfile 2>&1 | tee -a $fiemaplog
+
+if [ $? -ne 0 ]; then
+	if grep -q "Operation not supported" $fiemaplog; then
+	      _notrun "FIEMAP not supported by this filesystem type: $FSTYP"
+	fi
+	status=$?
+	exit
+fi
+
+echo "fiemap run without sync"
+$here/src/fiemap-tester -q -s $seed -r 200 $fiemapfile 2>&1 | tee -a $fiemaplog
+
+status=0
+exit
diff --git a/tests/generic/328.out b/tests/generic/328.out
new file mode 100644
index 0000000..a8f052a
--- /dev/null
+++ b/tests/generic/328.out
@@ -0,0 +1,3 @@
+QA output created by 328
+fiemap run with sync
+fiemap run without sync
diff --git a/tests/generic/group b/tests/generic/group
index 09bf1a5..3024cd5 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -194,3 +194,4 @@
 325 auto quick data log
 326 auto log
 327 auto quick
+328 auto quick prealloc
-- 
1.8.3.1

