Received: from mx1.redhat.com ([209.132.183.28]:37408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbdBPJOV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Feb 2017 04:14:21 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8AEFC0A57C9
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 09:14:21 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 3/8] overlay: test workdir cleanup in mounting
Date: Thu, 16 Feb 2017 17:13:50 +0800
Message-Id: <1487236435-6222-3-git-send-email-xzhou@redhat.com>
In-Reply-To: <1487236435-6222-1-git-send-email-xzhou@redhat.com>
References: <1487236435-6222-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

"work" directory in workdir should be cleaned up
and recreated while overlayfs mounting. Or overlayfs
will be mounted read-only.

CC: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/overlay/024     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/024.out |  2 ++
 tests/overlay/group   |  1 +
 3 files changed, 78 insertions(+)
 create mode 100755 tests/overlay/024
 create mode 100644 tests/overlay/024.out

diff --git a/tests/overlay/024 b/tests/overlay/024
new file mode 100755
index 0000000..a1d306e
--- /dev/null
+++ b/tests/overlay/024
@@ -0,0 +1,75 @@
+#! /bin/bash
+# FS QA Test 024
+#
+# "work" directory under workdir should be cleaned up
+# well on overlayfs startup, or overlayfs will be mounted
+# read-only.
+# Kernel commit below fixes it.
+# eea2fb4851e9 ovl: proper cleanup of workdir
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
+# making workdir
+wkdir=$SCRATCH_DEV/$OVERLAY_WORK_DIR
+mkdir -p $wkdir/work/foo
+
+_scratch_mount
+
+# try writing to mountpoint
+touch $SCRATCH_MNT/bar
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/024.out b/tests/overlay/024.out
new file mode 100644
index 0000000..fd6fbb1
--- /dev/null
+++ b/tests/overlay/024.out
@@ -0,0 +1,2 @@
+QA output created by 024
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index 09da1be..0563a04 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -26,3 +26,4 @@
 021 auto quick copyup
 022 auto quick
 023 auto quick attr
+024 auto quick
-- 
1.8.3.1

