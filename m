Received: from mail-pf0-f182.google.com ([209.85.192.182]:34984 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934196AbcIVTiA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2016 15:38:00 -0400
Received: by mail-pf0-f182.google.com with SMTP id z123so33669987pfz.2
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2016 12:38:00 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] btrfs: test free space tree mount options
Date: Thu, 22 Sep 2016 12:37:53 -0700
Message-Id: <a39fb886ccb917969e34355367fcdd46920bb2b6.1474572744.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

The behavior of different combinations of space_cache mount options
wasn't well defined, which led to a regression between my initial
patches adding the free space tree and the 4.5 release. Add a test to
exercise all of the meaningful permutations of clear_cache,
nospace_cache, and space_cache.

This is a regression test for Linux kernel commit "Btrfs: fix mount -o
clear_cache,space_cache=v2".

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Sorry, resending to the right fstests list...

The patch to fix this is coming out soon as part of my free space tree
fixes.

 tests/btrfs/131     | 150 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/131.out |  20 +++++++
 tests/btrfs/group   |   1 +
 3 files changed, 171 insertions(+)
 create mode 100755 tests/btrfs/131
 create mode 100644 tests/btrfs/131.out

diff --git a/tests/btrfs/131 b/tests/btrfs/131
new file mode 100755
index 0000000..cc75153
--- /dev/null
+++ b/tests/btrfs/131
@@ -0,0 +1,150 @@
+#! /bin/bash
+# FS QA Test 131
+#
+# Test free space tree mount options.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Facebook.  All Rights Reserved.
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
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_btrfs inspect-internal
+
+_mkfs_v1() {
+	_scratch_mkfs >/dev/null 2>&1
+	# Future proof against btrfs-progs making space_cache=v2 filesystems by
+	# default.
+	_scratch_mount -o clear_cache,space_cache=v1
+	_scratch_unmount
+}
+
+_mkfs_v2() {
+	_scratch_mkfs >/dev/null 2>&1
+	_scratch_mount -o space_cache=v2
+	_scratch_unmount
+}
+
+_check_fst_compat() {
+	compat_ro="$($BTRFS_UTIL_PROG inspect-internal dump-super "$SCRATCH_DEV" | \
+		     sed -rn 's/^compat_ro_flags\s+(.*)$/\1/p')"
+	if ((compat_ro & 0x1)); then
+		echo "free space tree is enabled"
+	else
+		echo "free space tree is disabled"
+	fi
+}
+
+# Mount options might interfere.
+export MOUNT_OPTIONS=""
+
+# When the free space tree is not enabled:
+# -o space_cache=v1: keep using the old free space cache
+# -o space_cache=v2: enable the free space tree
+# -o clear_cache,space_cache=v2: clear the free space cache and enable the free space tree
+# We don't check the no options case or plain space_cache as that will change
+# in the future to turn on space_cache=v2.
+
+_mkfs_v1
+echo "Using free space cache"
+_scratch_mount -o space_cache=v1
+_check_fst_compat
+_scratch_unmount
+
+_mkfs_v1
+echo "Enabling free space tree"
+_scratch_mount -o space_cache=v2
+_check_fst_compat
+_scratch_unmount
+
+_mkfs_v1
+echo "Disabling free space cache and enabling free space tree"
+_scratch_mount -o clear_cache,space_cache=v2
+_check_fst_compat
+_scratch_unmount
+
+# When the free space tree is enabled:
+# -o nospace_cache, -o space_cache=v1: error
+# no options, -o space_cache=v2: keep using the free space tree
+# -o clear_cache, -o clear_cache,space_cache=v2: clear and recreate the free space tree
+# -o clear_cache,nospace_cache: clear the free space tree
+# -o clear_cache,space_cache=v1: clear the free space tree, enable the free space cache
+
+_mkfs_v2
+echo "Trying to mount without free space tree"
+_scratch_mount -o nospace_cache >/dev/null 2>&1 || echo "mount failed"
+_scratch_mount -o space_cache=v1 >/dev/null 2>&1 || echo "mount failed"
+
+_mkfs_v2
+echo "Mounting existing free space tree"
+_scratch_mount
+_check_fst_compat
+_scratch_unmount
+_scratch_mount -o space_cache=v2
+_check_fst_compat
+_scratch_unmount
+
+_mkfs_v2
+echo "Recreating free space tree"
+_scratch_mount -o clear_cache,space_cache=v2
+_check_fst_compat
+_scratch_unmount
+_mkfs_v2
+_scratch_mount -o clear_cache
+_check_fst_compat
+_scratch_unmount
+
+_mkfs_v2
+echo "Disabling free space tree"
+_scratch_mount -o clear_cache,nospace_cache
+_check_fst_compat
+_scratch_unmount
+
+_mkfs_v2
+echo "Reverting to free space cache"
+_scratch_mount -o clear_cache,space_cache=v1
+_check_fst_compat
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/131.out b/tests/btrfs/131.out
new file mode 100644
index 0000000..aaa4a70
--- /dev/null
+++ b/tests/btrfs/131.out
@@ -0,0 +1,20 @@
+QA output created by 131
+Using free space cache
+free space tree is disabled
+Enabling free space tree
+free space tree is enabled
+Disabling free space cache and enabling free space tree
+free space tree is enabled
+Trying to mount without free space tree
+mount failed
+mount failed
+Mounting existing free space tree
+free space tree is enabled
+free space tree is enabled
+Recreating free space tree
+free space tree is enabled
+free space tree is enabled
+Disabling free space tree
+free space tree is disabled
+Reverting to free space cache
+free space tree is disabled
diff --git a/tests/btrfs/group b/tests/btrfs/group
index f3a7a4f..c090604 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -133,3 +133,4 @@
 128 auto quick send
 129 auto quick send
 130 auto clone send
+131 auto quick
-- 
2.10.0

