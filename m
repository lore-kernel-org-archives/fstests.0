Received: from sandeen.net ([63.231.237.45]:45431 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbcDTTjw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Apr 2016 15:39:52 -0400
Subject: [PATCH 2/2 V2] dm-thinp demo test
References: <5717DA92.4030003@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5717DB06.2060004@sandeen.net>
Date: Wed, 20 Apr 2016 15:39:50 -0400
MIME-Version: 1.0
In-Reply-To: <5717DA92.4030003@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>, Mike Snitzer <msnitzer@redhat.com>
List-ID: <fstests@vger.kernel.org>

Fairly trivial test to use the dm-thin infrastructure.

Right now it exhausts space in queue-on-error mode,
adds more space, does a bit more IO, then unmounts &
checks the fs.

Not sure if that's valid to test, but it works here and
demonstrates the common/dmthin helpers.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/343 b/tests/generic/343
new file mode 100755
index 0000000..3bc81d0
--- /dev/null
+++ b/tests/generic/343
@@ -0,0 +1,83 @@
+#! /bin/bash
+# FS QA Test No. generic/343
+#
+# Test very basic thin device usage, exhaustion, and growth
+#
+# Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
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
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+BACKING_SIZE=$((500 * 1024 * 1024 / 512))	# 500M
+VIRTUAL_SIZE=$((10 * $BACKING_SIZE))		# 5000M
+GROW_SIZE=$((100 * 1024 * 1024 / 512))		# 100M
+
+_cleanup()
+{
+	_dmthin_cleanup
+	rm -f $tmp.*
+}
+
+_setup_thin()
+{
+	_dmthin_init $BACKING_SIZE $VIRTUAL_SIZE
+	_dmthin_set_queue
+	_mkfs_dev $DMTHIN_VOL_DEV
+	_dmthin_mount
+}
+
+_workout()
+{
+	# Overfill it by a bit
+	for I in `seq 1 500`; do
+		$XFS_IO_PROG -f -c "pwrite -W 0 1M" $SCRATCH_MNT/file$I &>/dev/null
+	done
+
+	sync
+
+	_dmthin_grow  $GROW_SIZE
+
+	# Write a little more, but don't fill
+	for I in `seq 501 510`; do
+		$XFS_IO_PROG -f -c "pwrite 0 1M" $SCRATCH_MNT/file$I &>/dev/null
+	done
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/dmthin
+
+_supported_fs generic
+_supported_os Linux
+_require_dm_target thin-pool
+
+_setup_thin
+_workout
+_dmthin_check_fs
+_dmthin_cleanup
+
+echo "=== completed"
+
+status=0
+exit
diff --git a/tests/generic/343.out b/tests/generic/343.out
new file mode 100644
index 0000000..c64aec1
--- /dev/null
+++ b/tests/generic/343.out
@@ -0,0 +1,2 @@
+QA output created by 343
+=== completed
diff --git a/tests/generic/group b/tests/generic/group
index ef1a423..a371071 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -345,3 +345,4 @@
 340 auto
 341 auto quick metadata
 342 auto quick metadata
+343 auto quick rw thin


