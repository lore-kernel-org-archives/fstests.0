Received: from mx1.redhat.com ([209.132.183.28]:60532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbdBPJOP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Feb 2017 04:14:15 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B851661D17
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 09:14:15 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 1/8] overlay: disallow overlayfs as upperdir
Date: Thu, 16 Feb 2017 17:13:48 +0800
Message-Id: <1487236435-6222-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

Using overlayfs dir as upperdir to mount another
overlayfs should fail.

CC: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/overlay/022     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/022.out |  2 ++
 tests/overlay/group   |  1 +
 3 files changed, 83 insertions(+)
 create mode 100755 tests/overlay/022
 create mode 100644 tests/overlay/022.out

diff --git a/tests/overlay/022 b/tests/overlay/022
new file mode 100755
index 0000000..b09a924
--- /dev/null
+++ b/tests/overlay/022
@@ -0,0 +1,80 @@
+#! /bin/bash
+# FS QA Test 022
+#
+# Regression test for kernel commit:
+#     76bc8e2 ovl: disallow overlayfs as upperdir
+#
+# This reproducer was originally written by
+#     Miklos Szeredi <mszeredi@redhat.com>
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat Inc. All Rights Reserved.
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
+_supported_fs overlay
+_supported_os Linux
+_require_scratch
+
+# Remove all files from previous tests
+_scratch_mkfs
+
+upperdir=$SCRATCH_DEV/$OVERLAY_UPPER_DIR
+mkdir -p $upperdir/upper
+mkdir -p $upperdir/work
+# mount overlay with dirs in upper
+_scratch_mount
+
+mkdir -p $tmp/{lower,mnt}
+# mount overlay using upper from another overlay upper
+# should fail
+_overlay_mount_dirs $tmp/lower $SCRATCH_MNT/upper \
+  $SCRATCH_MNT/work overlay $tmp/mnt > /dev/null 2>&1
+if [ $? -ne 0 ] ; then
+	echo "Silence is golden"
+else
+	echo "Test Fail"
+	$UMOUNT_PROG $tmp/mnt
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/022.out b/tests/overlay/022.out
new file mode 100644
index 0000000..394c6a7
--- /dev/null
+++ b/tests/overlay/022.out
@@ -0,0 +1,2 @@
+QA output created by 022
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index 5bcc25e..45768f5 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -24,3 +24,4 @@
 019 auto stress
 020 auto quick copyup perms
 021 auto quick copyup
+022 auto quick
-- 
1.8.3.1

