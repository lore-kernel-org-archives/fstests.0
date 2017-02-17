Received: from mx1.redhat.com ([209.132.183.28]:44546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755319AbdBQEgx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Feb 2017 23:36:53 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D1C63B72D
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2017 04:36:54 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v2 7/8] overlay: test flock after copied up
Date: Fri, 17 Feb 2017 12:36:27 +0800
Message-Id: <1487306188-2097-7-git-send-email-xzhou@redhat.com>
In-Reply-To: <1487306188-2097-1-git-send-email-xzhou@redhat.com>
References: <1487306188-2097-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

Locks of file in lower dir should working after it's
been copied up.

CC: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/overlay/028     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/028.out |  2 ++
 tests/overlay/group   |  1 +
 3 files changed, 83 insertions(+)
 create mode 100755 tests/overlay/028
 create mode 100644 tests/overlay/028.out

diff --git a/tests/overlay/028 b/tests/overlay/028
new file mode 100755
index 0000000..2e0995e
--- /dev/null
+++ b/tests/overlay/028
@@ -0,0 +1,80 @@
+#! /bin/bash
+# FS QA Test 028
+#
+# When file in lower dir is locked and it's been copied up,
+# make sure the lock is working in overlayfs.
+#
+# Kernel commit below fixed it.
+# c568d68341be locks: fix file locking on overlayfs
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
+lowerdir=$SCRATCH_DEV/$OVERLAY_LOWER_DIR
+mkdir -p $lowerdir
+touch $lowerdir/foo
+
+# Mounting overlay
+_scratch_mount
+
+# Testing copyup and flock
+flock $SCRATCH_MNT/foo sleep 5 &
+# flock in subshell should fail with no output
+(sleep 1; echo bar > $SCRATCH_MNT/foo; \
+  flock -n $SCRATCH_MNT/foo echo LOCKED)
+
+wait
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/028.out b/tests/overlay/028.out
new file mode 100644
index 0000000..2615f73
--- /dev/null
+++ b/tests/overlay/028.out
@@ -0,0 +1,2 @@
+QA output created by 028
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index 4db6751..cf058fc 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -30,3 +30,4 @@
 025 auto quick attr
 026 auto attr quick
 027 auto quick perms
+028 auto copyup quick
-- 
1.8.3.1

