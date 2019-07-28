Received: from mx1.redhat.com ([209.132.183.28]:53962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfG1JHW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 28 Jul 2019 05:07:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B45A30842A9
        for <fstests@vger.kernel.org>; Sun, 28 Jul 2019 09:07:22 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D5C71001B04
        for <fstests@vger.kernel.org>; Sun, 28 Jul 2019 09:07:20 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] xfs: test statfs on project quota directory
Date: Sun, 28 Jul 2019 17:07:15 +0800
Message-Id: <20190728090715.9486-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

There's a bug on xfs cause statfs get negative f_ffree value from
a project quota directory. It's fixed by "de7243057 fs/xfs: fix
f_ffree value for statfs when project quota is set". So add statfs
testing on project quota block and inode count limit.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

Thanks Carlos helped to review the V2 patch, V3 did below changes:
1) Remove project quota config files, turn to use 'project -p <path>'
2) Modify some comments

Thanks,
Zorro

 tests/xfs/509     | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/509.out |  3 +++
 tests/xfs/group   |  1 +
 3 files changed, 65 insertions(+)
 create mode 100755 tests/xfs/509
 create mode 100644 tests/xfs/509.out

diff --git a/tests/xfs/509 b/tests/xfs/509
new file mode 100755
index 00000000..e67cff13
--- /dev/null
+++ b/tests/xfs/509
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 509
+#
+# Test statfs when project quota is set.
+# Uncover de7243057 fs/xfs: fix f_ffree value for statfs when project quota is set
+#
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
+	_scratch_unmount
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/quota
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+_require_xfs_quota
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_enable_pquota
+_qmount_option "prjquota"
+_qmount
+_require_prjquota $SCRATCH_DEV
+
+# Create a directory to be project object, and create a file to take 64k space
+mkdir $SCRATCH_MNT/t
+$XFS_IO_PROG -f -c "pwrite 0 65536" -c sync $SCRATCH_MNT/t/file >>$seqres.full
+
+quota_cmd="$XFS_QUOTA_PROG -x"
+$quota_cmd -c "project -s -p $SCRATCH_MNT/t 42" $SCRATCH_MNT >/dev/null 2>&1
+$quota_cmd -c 'limit -p isoft=53 bsoft=100m 42' $SCRATCH_MNT
+
+# The itotal and size should be 53 and 102400(k), as above project quota limit.
+# The isued and used should be 2 and 64(k), as this case takes.
+df -k --output=file,itotal,iused,size,used $SCRATCH_MNT/t | \
+	_filter_scratch | _filter_spaces
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/509.out b/tests/xfs/509.out
new file mode 100644
index 00000000..418b2dd7
--- /dev/null
+++ b/tests/xfs/509.out
@@ -0,0 +1,3 @@
+QA output created by 509
+File Inodes IUsed 1K-blocks Used
+SCRATCH_MNT/t 53 2 102400 64
diff --git a/tests/xfs/group b/tests/xfs/group
index 270d82ff..364a7ed5 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -506,3 +506,4 @@
 506 auto quick health
 507 clone
 508 auto quick quota
+509 auto quick quota
-- 
2.17.2
