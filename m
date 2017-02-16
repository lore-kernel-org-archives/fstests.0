Received: from mx1.redhat.com ([209.132.183.28]:59432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752967AbdBPJOf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Feb 2017 04:14:35 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6E283D96B
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 09:14:35 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 8/8] overlay: accessing stacked overlayfs files
Date: Thu, 16 Feb 2017 17:13:55 +0800
Message-Id: <1487236435-6222-8-git-send-email-xzhou@redhat.com>
In-Reply-To: <1487236435-6222-1-git-send-email-xzhou@redhat.com>
References: <1487236435-6222-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

Lower dir comes from another overlayfs dir, then
accessing files in it should work.

CC: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/overlay/029     | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/029.out |  3 ++
 tests/overlay/group   |  1 +
 3 files changed, 96 insertions(+)
 create mode 100755 tests/overlay/029
 create mode 100644 tests/overlay/029.out

diff --git a/tests/overlay/029 b/tests/overlay/029
new file mode 100755
index 0000000..aedd141
--- /dev/null
+++ b/tests/overlay/029
@@ -0,0 +1,92 @@
+#! /bin/bash
+# FS QA Test 029
+#
+# There are dirs/files in lower dir and upper dir before
+# mounting overlayfs. After mounting, use dir in overlayfs
+# mountpoint as lowerdir to mount another overlayfs, then
+# access old files through the second overlayfs. It was
+# not working, kernel commit below fixed it.
+#
+# c4fcfc1619ea ovl: fix d_real() for stacked fs
+#
+# This reproducer was originally written by
+#     Miklos Szeredi <mszeredi@redhat.com>
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
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
+# Preparing files
+upperdir=$SCRATCH_DEV/$OVERLAY_UPPER_DIR
+lowerdir=$SCRATCH_DEV/$OVERLAY_LOWER_DIR
+mkdir -p $upperdir/up
+echo foo > $upperdir/up/foo
+mkdir -p $lowerdir/low
+echo bar > $lowerdir/low/bar
+
+# mount overlay in SCRATCH_MNT
+_scratch_mount
+
+mkdir -p $tmp/{upper,mnt,work}
+# mount overlay again using lower dir from SCRATCH_MNT dir
+_overlay_mount_dirs $SCRATCH_MNT/up $tmp/{upper,work} \
+  overlay $tmp/mnt
+# accessing file in the second mount
+cat $tmp/mnt/foo
+$UMOUNT_PROG $tmp/mnt
+
+# mount overlay again using upper dir from SCRATCH_MNT dir
+_overlay_mount_dirs $SCRATCH_MNT/low $tmp/{upper,work} \
+  overlay $tmp/mnt
+cat $tmp/mnt/bar
+$UMOUNT_PROG $tmp/mnt
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/029.out b/tests/overlay/029.out
new file mode 100644
index 0000000..870fcd9
--- /dev/null
+++ b/tests/overlay/029.out
@@ -0,0 +1,3 @@
+QA output created by 029
+foo
+bar
diff --git a/tests/overlay/group b/tests/overlay/group
index cf058fc..7e72a30 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -31,3 +31,4 @@
 026 auto attr quick
 027 auto quick perms
 028 auto copyup quick
+029 auto quick
-- 
1.8.3.1

