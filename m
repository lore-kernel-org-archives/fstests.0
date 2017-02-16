Received: from mx1.redhat.com ([209.132.183.28]:59314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752363AbdBPJOS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Feb 2017 04:14:18 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33B193DBC1
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 09:14:19 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 2/8] overlay: work dir in overlay inherits no ACLs
Date: Thu, 16 Feb 2017 17:13:49 +0800
Message-Id: <1487236435-6222-2-git-send-email-xzhou@redhat.com>
In-Reply-To: <1487236435-6222-1-git-send-email-xzhou@redhat.com>
References: <1487236435-6222-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

They should be cleaned while mounting overlayfs.

CC: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/overlay/023     | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/023.out |  8 +++++
 tests/overlay/group   |  1 +
 3 files changed, 90 insertions(+)
 create mode 100755 tests/overlay/023
 create mode 100644 tests/overlay/023.out

diff --git a/tests/overlay/023 b/tests/overlay/023
new file mode 100755
index 0000000..9f4ace5
--- /dev/null
+++ b/tests/overlay/023
@@ -0,0 +1,81 @@
+#! /bin/bash
+# FS QA Test 023
+#
+# The "work" directory in an overlyfs workdir should not inherit
+# ACL attrs from workdir.
+# Kernel commits below fix it.
+#   c11b9fdd6a61 ovl: remove posix_acl_default from workdir
+#   e1ff3dd1ae52 ovl: fix workdir creation
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
+. ./common/attr
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs overlay
+_supported_os Linux
+_require_acls
+_require_scratch
+
+# Remove all files from previous tests
+_scratch_mkfs
+
+# setting acls before mount
+wkdir=$SCRATCH_DEV/$OVERLAY_WORK_DIR
+mkdir -p $wkdir
+setfacl -d -m o::rwx $wkdir
+
+_scratch_mount
+
+# getting acls and doing a non-common filter,
+# since getfacl will remove leading / from absolute
+# path names.
+getfacl $wkdir/work 2>&1 | \
+	sed -e "s,${wkdir#/},wkdir,g" \
+	    -e "/Removing leading/ d"
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/023.out b/tests/overlay/023.out
new file mode 100644
index 0000000..3bdaca4
--- /dev/null
+++ b/tests/overlay/023.out
@@ -0,0 +1,8 @@
+QA output created by 023
+# file: wkdir/work
+# owner: root
+# group: root
+user::---
+group::---
+other::---
+
diff --git a/tests/overlay/group b/tests/overlay/group
index 45768f5..09da1be 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -25,3 +25,4 @@
 020 auto quick copyup perms
 021 auto quick copyup
 022 auto quick
+023 auto quick attr
-- 
1.8.3.1

