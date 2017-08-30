Received: from mx1.redhat.com ([209.132.183.28]:46144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbdH3Hho (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 30 Aug 2017 03:37:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03C508046A
        for <fstests@vger.kernel.org>; Wed, 30 Aug 2017 07:37:44 +0000 (UTC)
From: XiaoLi Feng <xifeng@redhat.com>
Subject: [PATCH] generic/451: check the return when create overlong file name
Date: Wed, 30 Aug 2017 15:37:41 +0800
Message-Id: <1504078661-27128-1-git-send-email-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xiaoli feng <xifeng@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: xiaoli feng <xifeng@redhat.com>

When create overlong file name, it's expected to return
ENAMETOOLONG. But it returns ENOENT in filesystem cifs. It also
should be tested in all general filesystems. So add it into
generic test.

Signed-off-by: xiaoli feng <xifeng@redhat.com>
---
 tests/generic/451     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/451.out |  5 +++
 2 files changed, 92 insertions(+)
 create mode 100755 tests/generic/451
 create mode 100644 tests/generic/451.out

diff --git a/tests/generic/451 b/tests/generic/451
new file mode 100755
index 0000000..0eab4f5
--- /dev/null
+++ b/tests/generic/451
@@ -0,0 +1,87 @@
+#! /bin/bash
+# FS QA Test 451
+#
+# Check if it returns correct message when create MAXNAMELENGTH file.
+# The filesystem cifs have the issue about returning the wrong error
+# message. And checking the issue is similarly suiting for general 
+# filesystems. So I add it into generic test.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 YOUR NAME HERE.  All Rights Reserved.
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
+get_string()
+{
+        local LEN=$1
+        local ret=""
+
+        for i in `seq 1 $LEN`; do
+                ret=${ret}a
+        done
+	echo $ret
+}
+
+# Check if return the error: File name too long
+maxname=`getconf NAME_MAX /`
+let maxname=$maxname+2
+fname=`get_string $maxname`
+# test dir
+result=`mkdir $fname 2>&1 |tee -a $seqres.full |grep -o "File name too long"`
+echo "Dir MAXNAME test pass: $result"
+# test file
+result=`touch $fname 2>&1 |tee -a $seqres.full |grep -o "File name too long"`
+echo "File MAXNAME test pass: $result"
+# test device
+result=`mknod $fname c 3 1 2>&1 |tee -a $seqres.full |grep -o "File name too long"`
+echo "Char device MAXNAME test pass: $result"
+# test FIFO
+result=`mkfifo $fname 2>&1 |tee -a $seqres.full |grep -o "File name too long"`
+echo "FIFO MAXNAME test pass: $result"
+
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/451.out b/tests/generic/451.out
new file mode 100644
index 0000000..5b5dcc6
--- /dev/null
+++ b/tests/generic/451.out
@@ -0,0 +1,5 @@
+QA output created by 451
+Dir MAXNAME test pass: File name too long
+File MAXNAME test pass: File name too long
+Char device MAXNAME test pass: File name too long
+FIFO MAXNAME test pass: File name too long
-- 
1.8.3.1

