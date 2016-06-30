Received: from mx1.redhat.com ([209.132.183.28]:43628 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbcF3Mtl (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 08:49:41 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00277C049D5A
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 12:49:36 +0000 (UTC)
Received: from bfoster.bfoster (dhcp-41-180.bos.redhat.com [10.18.41.180])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u5UCnZrQ007204
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 08:49:35 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH 2/2] tests/xfs: test for post umount readahead completion panic
Date: Thu, 30 Jun 2016 08:49:34 -0400
Message-Id: <1467290974-13203-3-git-send-email-bfoster@redhat.com>
In-Reply-To: <1467290974-13203-1-git-send-email-bfoster@redhat.com>
References: <1467290974-13203-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

XFS has a bug where directory readahead completions can occur after
unmount. This can lead to a crash or panic because metadata read
verification attempts to access core XFS data structures (e.g., the log)
after they have been freed and certain pointers have been reset.

Add a test that triggers directory readahead, delays the readahead I/O
and immediately unmounts the filesystem. This test is part of the
dangerous group as it will cause kernels affected by the bug to crash.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 tests/xfs/999     | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/999.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 93 insertions(+)
 create mode 100755 tests/xfs/999
 create mode 100644 tests/xfs/999.out

diff --git a/tests/xfs/999 b/tests/xfs/999
new file mode 100755
index 0000000..041d719
--- /dev/null
+++ b/tests/xfs/999
@@ -0,0 +1,90 @@
+#! /bin/bash
+# FS QA Test No. 999
+#
+# Test to reproduce an XFS unmount crash due to races with directory readahead.
+# XFS had a bug in which unmount would proceed with a readahead I/O in flight.
+# If the unmount deconstructed the log by the time I/O completion occurs,
+# certain metadata read verifier checks could access invalid memory and cause a
+# panic.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+	_scratch_unmount > /dev/null 2>&1
+	_cleanup_delay > /dev/null 2>&1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/dmdelay
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+
+_require_scratch
+_require_dm_target delay
+
+rm -f $seqres.full
+
+echo "Silence is golden."
+
+_scratch_mkfs_xfs >> $seqres.full 2>&1
+
+_init_delay
+_mount_delay
+
+# create a directory large enough for extent format
+mkdir $SCRATCH_MNT/dir
+for i in $(seq 0 999); do
+	touch $SCRATCH_MNT/dir/$i
+done
+
+# remount to clear the buffer cache
+_unmount_delay
+_mount_delay
+
+# introduce a read I/O delay
+_load_delay_table $DELAY_READ
+
+# Map the directory and immediately unmount. This should invoke an asynchronous
+# readahead on the first block of the directory. The readahead is delayed by
+# dm-delay. If the unmount doesn't properly wait for the readahead completion,
+# the read verifier can run after core data structures have been freed and lead
+# to a crash/panic.
+$XFS_IO_PROG -c "bmap -v" $SCRATCH_MNT/dir >> $seqres.full 2>&1
+_unmount_delay
+
+_cleanup_delay
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/999.out b/tests/xfs/999.out
new file mode 100644
index 0000000..d254382
--- /dev/null
+++ b/tests/xfs/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Silence is golden.
diff --git a/tests/xfs/group b/tests/xfs/group
index 5a35a76..6752cc0 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -290,3 +290,4 @@
 308 auto quick clone
 309 auto clone
 310 auto clone rmap
+999 auto dangerous quick
-- 
2.5.5

