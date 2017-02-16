Received: from mx1.redhat.com ([209.132.183.28]:60614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752967AbdBPJO3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Feb 2017 04:14:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64D6461D02
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 09:14:30 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 6/8] overlay: can not change underlying immutable file
Date: Thu, 16 Feb 2017 17:13:53 +0800
Message-Id: <1487236435-6222-6-git-send-email-xzhou@redhat.com>
In-Reply-To: <1487236435-6222-1-git-send-email-xzhou@redhat.com>
References: <1487236435-6222-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

Even timestamp change by touch.

CC: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/overlay/027     | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/027.out |  2 ++
 tests/overlay/group   |  1 +
 3 files changed, 81 insertions(+)
 create mode 100755 tests/overlay/027
 create mode 100644 tests/overlay/027.out

diff --git a/tests/overlay/027 b/tests/overlay/027
new file mode 100755
index 0000000..b3a97b8
--- /dev/null
+++ b/tests/overlay/027
@@ -0,0 +1,78 @@
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
+# Touching immutable file in overlay, should fail
+touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/027.out b/tests/overlay/027.out
new file mode 100644
index 0000000..3f19c46
--- /dev/null
+++ b/tests/overlay/027.out
@@ -0,0 +1,2 @@
+QA output created by 027
+touch: setting times of 'SCRATCH_MNT/foo': Operation not permitted
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

