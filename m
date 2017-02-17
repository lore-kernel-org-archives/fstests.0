Received: from mx1.redhat.com ([209.132.183.28]:40120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755319AbdBQEgu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Feb 2017 23:36:50 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com [10.5.11.28])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D92F8EB35
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2017 04:36:51 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v2 6/8] overlay: can not change underlying immutable file
Date: Fri, 17 Feb 2017 12:36:26 +0800
Message-Id: <1487306188-2097-6-git-send-email-xzhou@redhat.com>
In-Reply-To: <1487306188-2097-1-git-send-email-xzhou@redhat.com>
References: <1487306188-2097-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

Even timestamp change by touch.

CC: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/overlay/027     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/027.out |  2 ++
 tests/overlay/group   |  1 +
 3 files changed, 90 insertions(+)
 create mode 100755 tests/overlay/027
 create mode 100644 tests/overlay/027.out

diff --git a/tests/overlay/027 b/tests/overlay/027
new file mode 100755
index 0000000..4bb0329
--- /dev/null
+++ b/tests/overlay/027
@@ -0,0 +1,87 @@
+#! /bin/bash
+# FS QA Test 027
+#
+# If underlying upper file is immutable, it should stays
+# untouchable in the overlayfs mount.
+#
+# Kernel commit below fixed it.
+# f2b20f6ee842 vfs: move permission checking into ...
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
+	$CHATTR_PROG -i $upperdir/foo
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
+_require_chattr
+
+# Remove all files from previous tests
+_scratch_mkfs
+
+# Preparing immutable file
+upperdir=$SCRATCH_DEV/$OVERLAY_UPPER_DIR
+mkdir -p $upperdir
+touch $upperdir/foo
+$CHATTR_PROG +i $upperdir/foo
+
+# Mounting overlay
+_scratch_mount
+
+# Touching immutable file in overlay, should fail.
+# Not filtering output here because of errno returned
+# varies among kernel versions:
+#   touch: setting times of 'foo': Operation not permitted
+#   touch: cannot touch 'foo': Permission denied
+if touch $SCRATCH_MNT/foo > /dev/null 2>&1 ; then
+	echo "Test Fail, you can't change an immutable file"
+else
+	echo "Silence is golden"
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/027.out b/tests/overlay/027.out
new file mode 100644
index 0000000..ef78cda
--- /dev/null
+++ b/tests/overlay/027.out
@@ -0,0 +1,2 @@
+QA output created by 027
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index 92afa8d..4db6751 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -29,3 +29,4 @@
 024 auto quick
 025 auto quick attr
 026 auto attr quick
+027 auto quick perms
-- 
1.8.3.1

