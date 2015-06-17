Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14743 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753403AbbFQVh6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2015 17:37:58 -0400
Received: from pps.filterd (m0004347 [127.0.0.1])
	by m0004347.ppops.net (8.14.5/8.14.5) with SMTP id t5HLbE37000730
	for <fstests@vger.kernel.org>; Wed, 17 Jun 2015 14:37:58 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0004347.ppops.net with ESMTP id 1v3ea5gcwv-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Wed, 17 Jun 2015 14:37:58 -0700
From: Josef Bacik <jbacik@fb.com>
Subject: [PATCH V3] generic: add fiemap test that does prealloc
Date: Wed, 17 Jun 2015 14:37:56 -0700
Message-ID: <1434577076-9501-1-git-send-email-jbacik@fb.com>
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
V2->V3:
-drop the extra check for unsupported fiemap

 tests/generic/094     | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/094.out |  3 +++
 tests/generic/group   |  1 +
 3 files changed, 75 insertions(+)
 create mode 100644 tests/generic/094
 create mode 100644 tests/generic/094.out

diff --git a/tests/generic/094 b/tests/generic/094
new file mode 100644
index 0000000..4e4b668
--- /dev/null
+++ b/tests/generic/094
@@ -0,0 +1,71 @@
+#! /bin/bash
+# FS QA Test No. 094
+#
+# Run the fiemap (file extent mapping) tester with preallocation enabled
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Facebook.  All Rights Reserved.
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
+
+[ -x $here/src/fiemap-tester ] || _notrun "fiemap-tester not built"
+
+seed=`date +%s`
+
+echo "using seed $seed" >> $seqres.full
+
+echo "fiemap run with sync"
+$here/src/fiemap-tester -q -S -s $seed -r 200 $fiemapfile 2>&1 | \
+	tee -a $seqres.full
+
+echo "fiemap run without sync"
+$here/src/fiemap-tester -q -s $seed -r 200 $fiemapfile 2>&1 | \
+	tee -a $seqres.full
+
+status=0
+exit
diff --git a/tests/generic/094.out b/tests/generic/094.out
new file mode 100644
index 0000000..b5476be
--- /dev/null
+++ b/tests/generic/094.out
@@ -0,0 +1,3 @@
+QA output created by 094
+fiemap run with sync
+fiemap run without sync
diff --git a/tests/generic/group b/tests/generic/group
index 0c8964c..370e286 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -95,6 +95,7 @@
 091 rw auto quick
 092 auto quick prealloc
 093 attr cap udf auto
+094 auto quick prealloc
 097 udf auto
 099 udf auto
 100 udf auto
-- 
2.1.0

