Received: from mx1.redhat.com ([209.132.183.28]:34094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755319AbdBQEgs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Feb 2017 23:36:48 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E809680F7C
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2017 04:36:48 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v2 5/8] overlay: filter out xattr starts with "trusted.overlay."
Date: Fri, 17 Feb 2017 12:36:25 +0800
Message-Id: <1487306188-2097-5-git-send-email-xzhou@redhat.com>
In-Reply-To: <1487306188-2097-1-git-send-email-xzhou@redhat.com>
References: <1487306188-2097-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

Not "trusted.overlay".
  "trusted.overlayxxx" is allowed.
  "trusted.overlay.xxx" is not allowed.

CC: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/overlay/026     | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/026.out |   3 ++
 tests/overlay/group   |   1 +
 3 files changed, 105 insertions(+)
 create mode 100755 tests/overlay/026
 create mode 100644 tests/overlay/026.out

diff --git a/tests/overlay/026 b/tests/overlay/026
new file mode 100755
index 0000000..5b51239
--- /dev/null
+++ b/tests/overlay/026
@@ -0,0 +1,101 @@
+#! /bin/bash
+# FS QA Test 026
+#
+# Overlayfs should only filter out xattr starting with
+# "trusted.overlay.", not "trusted.overlay".
+# Setting xattrs like "trusted.overlay.xxx" is not allowed.
+# Setting xattrs like "trusted.overlayxxx" is allowed.
+#
+# Kernel commit below fixed it.
+# fe2b75952347 ovl: Fix OVL_XATTR_PREFIX
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
+. ./common/attr
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
+_require_attrs
+
+# Remove all files from previous tests
+_scratch_mkfs
+
+# Mounting overlay
+_scratch_mount
+touch $SCRATCH_MNT/testf0
+touch $SCRATCH_MNT/testf1
+
+# The first setfattr should pass silently
+$SETFATTR_PROG -n "trusted.overlayfsrz" -v "n" \
+  $SCRATCH_MNT/testf0
+
+# The second setfattr should fail, the reason not using
+# filter SCRATCH here is errno returned varies between
+# kernel versions, "not supported" vs "not permitted".
+$SETFATTR_PROG -n "trusted.overlay.fsz" -v "n" \
+  $SCRATCH_MNT/testf1 > /dev/null 2>&1
+if [ $? -eq 0 ] ; then
+	echo "Setting trusted.overlay.xxx should fail"
+fi
+
+# The first getfattr should pass
+$GETFATTR_PROG -n "trusted.overlayfsrz" $SCRATCH_MNT/testf0 \
+  2>&1 | sed -e "s,${SCRATCH_MNT#/},SCRATCH_MNT,g" \
+	     -e "/Removing leading/ d" \
+	     -e "/^$/ d"
+
+# The second getfattr should fail. Only check exit status
+# silently because errno returned varies among kernel vers.
+$GETFATTR_PROG -n "trusted.overlay.fsz" $SCRATCH_MNT/testf1 \
+  > /dev/null 2>&1
+if [ $? -eq 0 ] ; then
+	echo "Getting trusted.overlay.xxx should fail"
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/026.out b/tests/overlay/026.out
new file mode 100644
index 0000000..4f0e2d3
--- /dev/null
+++ b/tests/overlay/026.out
@@ -0,0 +1,3 @@
+QA output created by 026
+# file: SCRATCH_MNT/testf0
+trusted.overlayfsrz="n"
diff --git a/tests/overlay/group b/tests/overlay/group
index 82fe69e..92afa8d 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -28,3 +28,4 @@
 023 auto quick attr
 024 auto quick
 025 auto quick attr
+026 auto attr quick
-- 
1.8.3.1

