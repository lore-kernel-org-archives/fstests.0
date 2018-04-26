Received: from mx1.redhat.com ([209.132.183.28]:44408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754277AbeDZMEp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Apr 2018 08:04:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75ACF5F798
        for <fstests@vger.kernel.org>; Thu, 26 Apr 2018 12:04:45 +0000 (UTC)
Received: from bfoster.bfoster (dhcp-41-20.bos.redhat.com [10.18.41.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37FC4177AF
        for <fstests@vger.kernel.org>; Thu, 26 Apr 2018 12:04:45 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH v2] tests/xfs: filestream allocator inode use-after-free test
Date: Thu, 26 Apr 2018 08:04:44 -0400
Message-Id: <20180426120444.3620-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The XFS filestreams allocator caches dir inode -> agno mappings in
an MRU mechanism that holds elements in memory for an amount of time
and then cleans up expired elements in the background. The elements
typically held inode pointers without holding a reference to the
associated inode. This means that if the inode is reclaimed before
an expired entry is cleaned up, the MRU reaper can access freed
memory and cause a panic.

Test for this problem by performing continuous filestreams
allocations under short-lived parent directory inodes. This will
produce KASAN use-after-free splats if enabled during the test.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

v2:
- Drop unnecessary _scratch_mount error check.
- Create and use helper for min. scratch dev size.
v1: https://marc.info/?l=fstests&m=152302430125453&w=2

 common/rc         |  10 +++++
 tests/xfs/445     | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/445.out |   2 +
 tests/xfs/group   |   1 +
 4 files changed, 122 insertions(+)
 create mode 100755 tests/xfs/445
 create mode 100644 tests/xfs/445.out

diff --git a/common/rc b/common/rc
index 366489bb..ab15eca1 100644
--- a/common/rc
+++ b/common/rc
@@ -1600,6 +1600,16 @@ _require_scratch()
 	touch ${RESULT_DIR}/require_scratch
 }
 
+# require a scratch dev of a minimum size (in kb)
+_require_scratch_size()
+{
+	[ $# -eq 1 ] || _fail "_require_scratch_size: expected size param"
+
+	_require_scratch
+	devsize=`_get_device_size $SCRATCH_DEV`
+	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
+}
+
 
 # this test needs a test partition - check we're ok & mount it
 #
diff --git a/tests/xfs/445 b/tests/xfs/445
new file mode 100755
index 00000000..41b54d93
--- /dev/null
+++ b/tests/xfs/445
@@ -0,0 +1,109 @@
+#! /bin/bash
+# FS QA Test 445
+#
+# Test the XFS filestreams allocator for use-after-free inode access. The
+# filestreams allocator uses the MRU and historically kept around unreferenced
+# inode pointers in each element. These pointers could outlive the inodes they
+# referred to and thus lead to access of freed or reused memory when the MRU
+# element was reaped. Test for this problem by performing filestream allocations
+# against short-lived parent directory inodes.
+#
+# Note that some form of kernel debug mechanism for use-after-free detection
+# (i.e., KASAN) is required for this test to reproduce the original problem.
+# This is because XFS uses a kmem cache for xfs_inode objects which means that
+# the backing pages for freed inodes may still reside in the cache with the
+# freed inodes in a partially initialized state.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Red Hat, Inc.  All Rights Reserved.
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
+. ./common/filestreams
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+drop_caches()
+{
+	while [ true ]; do
+		echo 2 > /proc/sys/vm/drop_caches
+		sleep 1
+	done
+}
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch_size $((2*1024*1024)) # kb
+
+# check for filestreams
+_check_filestreams_support || _notrun "filestreams not available"
+
+# use small AGs for frequent stream switching
+_scratch_mkfs_xfs -d agsize=20m,size=2g >> $seqres.full 2>&1 ||
+	_fail "mkfs failed"
+_scratch_mount "-o filestreams"
+
+# start background inode reclaim
+drop_caches &
+pid=$!
+
+# Stress the filestreams allocator via continuous allocation to a file under
+# different parent dirs. Remove the old dirs as the file is moved so the MRU
+# references point to an unlinked inode by the time they are removed. If the
+# old dir inodes are reclaimed and associated memory reused, MRU cleanup can
+# access the inode after it's been freed.
+dir=$SCRATCH_MNT
+for i in $(seq 0 90); do
+	mkdir -p $dir/$i
+	$XFS_IO_PROG -fc "falloc $(($i * 20))m 20m" $dir/$i/file
+
+	mkdir -p $dir/$((i + 1))
+	mv $dir/$i/file $dir/$((i + 1))/file
+	rmdir $dir/$i
+
+	# throttle to ensure this loop sees several cache reclaims
+	sleep 0.1
+done
+
+kill $pid 2> /dev/null
+wait $pid 2> /dev/null
+
+echo Silence is golden
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/445.out b/tests/xfs/445.out
new file mode 100644
index 00000000..44e55d20
--- /dev/null
+++ b/tests/xfs/445.out
@@ -0,0 +1,2 @@
+QA output created by 445
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index 831f2cfa..2a7dec6f 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -442,3 +442,4 @@
 442 auto stress clone quota
 443 auto quick ioctl fsr
 444 auto quick
+445 auto filestreams
-- 
2.13.6

