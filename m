Received: from szxga04-in.huawei.com ([45.249.212.190]:14080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726649AbeJPPVl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 16 Oct 2018 11:21:41 -0400
From: "zhangyi (F)" <yi.zhang@huawei.com>
Subject: [PATCH v2 3/4] overlay: add fsck.overlay stress test
Date: Tue, 16 Oct 2018 15:45:58 +0800
Message-ID: <20181016074559.24728-4-yi.zhang@huawei.com>
In-Reply-To: <20181016074559.24728-1-yi.zhang@huawei.com>
References: <20181016074559.24728-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, amir73il@gmail.com
Cc: guaneryu@gmail.com, miklos@szeredi.hu, yi.zhang@huawei.com, miaoxie@huawei.com
List-ID: <fstests@vger.kernel.org>

Introduce a test case for fsck.overlay which runs on the underlying
directories created by fsstress (contain a lot of fs objects) to
find potential stability issue.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 tests/overlay/062     | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/062.out |  2 ++
 tests/overlay/group   |  1 +
 3 files changed, 87 insertions(+)
 create mode 100755 tests/overlay/062
 create mode 100644 tests/overlay/062.out

diff --git a/tests/overlay/062 b/tests/overlay/062
new file mode 100755
index 0000000..f818562
--- /dev/null
+++ b/tests/overlay/062
@@ -0,0 +1,84 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Huawei.  All Rights Reserved.
+#
+# FS QA Test No. 062
+#
+# Stress test: test fsck.overlay running on the underlying dirs
+# which were created by fsstress.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1        # failure is the default!
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
+. ./common/attr
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs overlay
+_supported_os Linux
+_require_scratch_nocheck
+_require_command "$FSCK_OVERLAY_PROG" fsck.overlay
+
+# remove all files from previous tests
+_scratch_mkfs
+
+# Create an underlying layer which contain a lot of random objects
+create_layer()
+{
+	for dir in $*; do
+		seed=$RANDOM
+		echo "create random file system objects in $dir with seed $seed" \
+			>> $seqres.full
+
+		$FSSTRESS_PROG -s $seed -d $dir -z \
+			-f creat=20 -f link=10 -f mkdir=20 -f mknod=10 \
+			-f rename=10 -f setxattr=10 -f symlink=10 -f write=10 \
+			-p 4 -n 500 -l50 > /dev/null 2>&1
+	done
+}
+
+
+# Create test directories
+lowerdir=$OVL_BASE_SCRATCH_MNT/$seq-ovl-lower
+lowerdir2=$OVL_BASE_SCRATCH_MNT/$seq-ovl-lower2
+upperdir=$OVL_BASE_SCRATCH_MNT/$seq-ovl-upper
+workdir=$OVL_BASE_SCRATCH_MNT/$seq-ovl-workdir
+
+make_test_dirs()
+{
+	rm -rf $lowerdir $lowerdir2 $upperdir $workdir
+	mkdir -p $lowerdir $lowerdir2 $upperdir $workdir
+}
+
+
+# Test stability, should not crash and should not fail on "yes" mode.
+make_test_dirs
+create_layer $lowerdir2 $lowerdir $upperdir
+
+_overlay_fsck_dirs "$lowerdir:$lowerdir2" $upperdir $workdir -y >> \
+	$seqres.full 2>&1
+
+[[ "$?" == "$FSCK_OK" || "$?" == "$FSCK_NONDESTRUCT" ]] || \
+	echo "fsck return unexpected $?"
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/overlay/062.out b/tests/overlay/062.out
new file mode 100644
index 0000000..a1578f4
--- /dev/null
+++ b/tests/overlay/062.out
@@ -0,0 +1,2 @@
+QA output created by 062
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index ccc71f3..b308427 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -64,3 +64,4 @@
 059 auto quick copyup
 060 auto quick metacopy
 061 auto quick copyup
+062 auto stress fsck
-- 
2.5.0
