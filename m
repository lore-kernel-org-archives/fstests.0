Received: from mx1.redhat.com ([209.132.183.28]:44605 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbcFNH5X (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 14 Jun 2016 03:57:23 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D9583B717
	for <fstests@vger.kernel.org>; Tue, 14 Jun 2016 07:57:23 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/3] generic: test error handling on filesystem shutdown
Date: Tue, 14 Jun 2016 15:53:40 +0800
Message-Id: <1465890821-4388-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1465890821-4388-1-git-send-email-eguan@redhat.com>
References: <1465890821-4388-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Test XFS EFI/EFD error handling. Though it's an XFS bug, it can ran on
any filesystem supports shutdown.

This kernel commit fixed a hang on umount in XFS
8d99fe9 xfs: fix efi/efd error handling to avoid fs shutdown hangs

Though this bug is hard to hit, it's still good to have some coverage.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/353     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/353.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/generic/353
 create mode 100644 tests/generic/353.out

diff --git a/tests/generic/353 b/tests/generic/353
new file mode 100755
index 0000000..0516d8a
--- /dev/null
+++ b/tests/generic/353
@@ -0,0 +1,73 @@
+#! /bin/bash
+# FS QA Test 353
+#
+# Test XFS EFI/EFD error handling.
+#
+# This kernel commit fixed a hang on umount in XFS
+# 8d99fe9 xfs: fix efi/efd error handling to avoid fs shutdown hangs
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat Inc.  All Rights Reserved.
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
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_scratch_shutdown
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# fsstress load to generate EFI(extent free intention/EFD(extent free done)
+$FSSTRESS_PROG  -d $SCRATCH_MNT/testdir -n 99999 -p 16 -z -f fallocate=1 \
+		-f punch=1 -f creat=1 -f unlink=1 >>$seqres.full 2>&1 &
+sleep 5
+kill $!
+wait
+
+# shutdown filesystem, handle EFI/EFD in error path
+src/godown -f $SCRATCH_MNT
+
+# don't expect umount to hang. mount it again to do log replay and pass fs check
+_scratch_cycle_mount
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/353.out b/tests/generic/353.out
new file mode 100644
index 0000000..16ba4f1
--- /dev/null
+++ b/tests/generic/353.out
@@ -0,0 +1,2 @@
+QA output created by 353
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 4b65dcb..0203afa 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -355,3 +355,4 @@
 350 blockdev quick rw
 351 blockdev quick rw
 352 auto quick metadata
+353 auto quick metadata
-- 
1.8.3.1

