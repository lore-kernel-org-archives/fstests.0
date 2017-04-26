Received: from mx1.redhat.com ([209.132.183.28]:42556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753863AbdDZWFt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Apr 2017 18:05:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C6E1155E4
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2017 22:05:48 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-194.rdu2.redhat.com [10.10.122.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CD1E189F4
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2017 22:05:48 +0000 (UTC)
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: [PATCH v2] xfs/288: test xfs_growfs to ensure rejection if target isn't mounted
Date: Wed, 26 Apr 2017 17:05:47 -0500
Message-Id: <20170426220547.28517-1-billodo@redhat.com>
In-Reply-To: <20170424150935.28707-1-billodo@redhat.com>
References: <20170424150935.28707-1-billodo@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The manpage for xfs_growfs specifies that the file/dir to be
grown must be mounted. This is a test to ensure that if the
target isn't mounted, the command is rejected. The intention
is to test the command response, but not necessarily the
functionality of xfs_growfs. Absolute paths and relative paths
are covered, including symbolic links and bind mounts.

Signed-off-by: Bill O'Donnell <billodo@redhat.com>
---
v2: acually grow the fs as test proceeds; add filter, preventing
    superfluous stdio verbiage; add test for (unmounted) file; add
    description to commit message to clarify that this isn't a test
    for xfs_growfs functionality, but rather a test of command
    argument accepts and rejections.

 tests/xfs/288     | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/288.out |  23 ++++++++++
 tests/xfs/group   |   1 +
 3 files changed, 148 insertions(+)
 create mode 100755 tests/xfs/288
 create mode 100644 tests/xfs/288.out

diff --git a/tests/xfs/288 b/tests/xfs/288
new file mode 100755
index 0000000..51f5c32
--- /dev/null
+++ b/tests/xfs/288
@@ -0,0 +1,124 @@
+#! /bin/bash
+# FS QA Test 288
+#
+# Test to ensure xfs_growfs command rejects non-existent mount points
+# and accepts mounted targets.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
+    umount $tmpdir
+    umount $tmpbind
+    rmdir $tmpdir
+    rm -f $tmpsymlink
+    rmdir $tmpbind
+    rm -f $tmp
+    rm -f $tmpfile
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
+_supported_fs xfs
+_supported_os Linux
+_require_test
+_require_loop
+
+tmpfile=$TEST_DIR/fsfile
+tmpdir=$TEST_DIR/tmpdir
+tmpsymlink=$TEST_DIR/tmpsymlink.$$
+tmpbind=$TEST_DIR/tmpbind.$$
+
+mkdir -p $tmpdir || _fail "!!! failed to create temp mount dir"
+
+echo "=== mkfs.xfs ==="
+$MKFS_XFS_PROG -d file,name=$tmpfile,size=16m -f | _filter_mkfs 2>$tmp.mkfs >/dev/null
+
+echo "=== truncate ==="
+truncate --size=256m $tmpfile
+
+echo "=== xfs_growfs - unmounted, command should be rejected ==="
+$XFS_GROWFS_PROG $tmpdir
+
+echo "=== xfs_growfs - check relative path, unmounted ==="
+cd $TEST_DIR
+$XFS_GROWFS_PROG ./tmpdir
+
+echo "=== xfs_growfs - no path, unmounted ==="
+$XFS_GROWFS_PROG tmpdir
+
+echo "=== xfs_growfs - plain file - should be rejected ==="
+$XFS_GROWFS_PROG $tmpfile
+
+echo "=== mount ==="
+mount -o loop $tmpfile $tmpdir || _fail "!!! failed to loopback mount"
+
+echo "=== xfs_growfs - mounted - check absolute path ==="
+$XFS_GROWFS_PROG -D 8192 $tmpdir | _filter_growfs >$tmp.growfs
+
+echo "=== xfs_growfs - check relative path ==="
+$XFS_GROWFS_PROG -D 12288 ./tmpdir | _filter_growfs >$tmp.growfs
+
+echo "=== xfs_growfs - no path ==="
+$XFS_GROWFS_PROG -D 16384 tmpdir | _filter_growfs >$tmp.growfs
+
+echo "=== xfs_growfs - symbolic link ==="
+ln -s $tmpdir $tmpsymlink
+$XFS_GROWFS_PROG -D 20480 $tmpsymlink | _filter_growfs >$tmp.growfs
+
+echo "=== xfs_growfs - symbolic link using relative path ==="
+$XFS_GROWFS_PROG -D 24576 ./tmpsymlink.$$ | _filter_growfs >$tmp.growfs
+
+echo "=== xfs_growfs - symbolic link using no path ==="
+$XFS_GROWFS_PROG -D 28672 tmpsymlink.$$ | _filter_growfs >$tmp.growfs
+
+echo "=== xfs_growfs - bind mount ==="
+mkdir $tmpbind
+mount -o bind $tmpdir $tmpbind
+$XFS_GROWFS_PROG -D 32768 $tmpbind | _filter_growfs >$tmp.growfs
+
+echo "=== xfs_growfs - bind mount - relative path ==="
+$XFS_GROWFS_PROG -D 36864 ./tmpbind.$$ | _filter_growfs >$tmp.growfs
+
+echo "=== xfs_growfs - bind mount - no path ==="
+$XFS_GROWFS_PROG -D 40960 tmpbind.$$ | _filter_growfs >$tmp.growfs
+
+echo "=== xfs_growfs - plain file - should be rejected ==="
+$XFS_GROWFS_PROG $tmpfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/288.out b/tests/xfs/288.out
new file mode 100644
index 0000000..318aa8c
--- /dev/null
+++ b/tests/xfs/288.out
@@ -0,0 +1,23 @@
+QA output created by 288
+=== mkfs.xfs ===
+=== truncate ===
+=== xfs_growfs - unmounted, command should be rejected ===
+xfs_growfs: /mnt/test/tmpdir is not a mounted XFS filesystem
+=== xfs_growfs - check relative path, unmounted ===
+xfs_growfs: ./tmpdir is not a mounted XFS filesystem
+=== xfs_growfs - no path, unmounted ===
+xfs_growfs: tmpdir is not a mounted XFS filesystem
+=== xfs_growfs - plain file - should be rejected ===
+xfs_growfs: /mnt/test/fsfile is not a mounted XFS filesystem
+=== mount ===
+=== xfs_growfs - mounted - check absolute path ===
+=== xfs_growfs - check relative path ===
+=== xfs_growfs - no path ===
+=== xfs_growfs - symbolic link ===
+=== xfs_growfs - symbolic link using relative path ===
+=== xfs_growfs - symbolic link using no path ===
+=== xfs_growfs - bind mount ===
+=== xfs_growfs - bind mount - relative path ===
+=== xfs_growfs - bind mount - no path ===
+=== xfs_growfs - plain file - should be rejected ===
+xfs_growfs: /mnt/test/fsfile is not a mounted XFS filesystem
diff --git a/tests/xfs/group b/tests/xfs/group
index 75769f9..0dcb8e0 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -285,6 +285,7 @@
 285 dangerous_fuzzers dangerous_scrub
 286 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 287 auto dump quota quick
+288 growfs auto quick
 290 auto rw prealloc quick ioctl zero
 291 auto repair
 292 auto mkfs quick
-- 
2.9.3

