Received: from mx1.redhat.com ([209.132.183.28]:46279 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753433AbcFHK7J (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 8 Jun 2016 06:59:09 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D50685367
	for <fstests@vger.kernel.org>; Wed,  8 Jun 2016 10:59:08 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/2] overlay: test visible whiteout issue after rename
Date: Wed,  8 Jun 2016 18:59:02 +0800
Message-Id: <1465383543-10060-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Test visible whiteout issue after renaming file from lowerdir to a dir
in upperdir.

Upstream commit 45d117389696 ("ovl: ignore lower entries when checking
purity of non-directory entries") fixed the issue

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/overlay/005     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/005.out |  2 ++
 tests/overlay/group   |  1 +
 3 files changed, 80 insertions(+)
 create mode 100755 tests/overlay/005
 create mode 100644 tests/overlay/005.out

diff --git a/tests/overlay/005 b/tests/overlay/005
new file mode 100755
index 0000000..13ed5e7
--- /dev/null
+++ b/tests/overlay/005
@@ -0,0 +1,77 @@
+#! /bin/bash
+# FS QA Test 005
+#
+# Test visible whiteout issue after renaming file from lowerdir to a dir in
+# upperdir.
+#
+# Upstream commit 45d117389696 ("ovl: ignore lower entries when checking purity
+# of non-directory entries") fixed the issue
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
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
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs overlay
+_supported_os Linux
+_require_scratch
+
+echo "Silence is golden"
+
+# Remove all files from previous tests
+_scratch_mkfs
+
+# Create test file/dir before mount
+mkdir $SCRATCH_DEV/$OVERLAY_LOWER_DIR
+mkdir $SCRATCH_DEV/$OVERLAY_UPPER_DIR
+touch $SCRATCH_DEV/$OVERLAY_LOWER_DIR/lowertestfile
+mkdir $SCRATCH_DEV/$OVERLAY_UPPER_DIR/uppertestdir
+
+_scratch_mount
+
+# rename lowertestfile to uppertestdir, this triggers copyup and creates
+# whiteout in $OVERLAY_UPPER_DIR
+mv $SCRATCH_MNT/lowertestfile $SCRATCH_MNT/uppertestdir
+# the lowertestfile can be removed
+rm $SCRATCH_MNT/uppertestdir/lowertestfile
+# no file no whiteout file in upptestdir
+ls $SCRATCH_MNT/uppertestdir
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/005.out b/tests/overlay/005.out
new file mode 100644
index 0000000..a5027f1
--- /dev/null
+++ b/tests/overlay/005.out
@@ -0,0 +1,2 @@
+QA output created by 005
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index fcf6d63..aaf8f7f 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -7,3 +7,4 @@
 002 auto quick metadata
 003 auto quick whiteout
 004 attr auto copyup quick
+005 auto quick copyup whiteout
-- 
2.5.5

