From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 3/3] generic/396: test correct d_type values
Date: Tue, 20 Dec 2016 15:17:35 +0200
Message-Id: <1482239855-791-4-git-send-email-amir73il@gmail.com>
In-Reply-To: <1482239855-791-1-git-send-email-amir73il@gmail.com>
References: <1482239855-791-1-git-send-email-amir73il@gmail.com>
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Verify correct d_type values of dir entries.

This test does NOT require that file system support the filetype feature.
It verifies that either all file types are reported as DT_UNKNOWN
or that all file types are reported correctly.

For fs for which we know how to test the filetype feature (xfs|ext*)
verify getting DT_UNKNOWN IFF feature is disabled.

Verify special dir entries . and .. are always reported as DT_DIR.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/396     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/396.out |  9 ++++++
 tests/generic/group   |  1 +
 3 files changed, 97 insertions(+)
 create mode 100755 tests/generic/396
 create mode 100644 tests/generic/396.out

diff --git a/tests/generic/396 b/tests/generic/396
new file mode 100755
index 0000000..fbd2e79
--- /dev/null
+++ b/tests/generic/396
@@ -0,0 +1,87 @@
+#! /bin/bash
+# FSQA Test No. 396
+#
+# Test filetype feature
+#
+# This test does NOT require that file system support the d_type feature.
+# It verifies that either all file types are reported as DT_UNKNOWN
+# or all file types are reported correctly.
+#
+# For fs for which we know how to test the filetype feature (xfs|ext*)
+# verify getting DT_UNKNOWN IFF feature is disabled.
+#
+# Verify special dir entries . and .. are always reported as DT_DIR.
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (C) 2016 CTERA Networks. All Rights Reserved.
+# Author: Amir Goldstein <amir73il@gmail.com>
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
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+
+_scratch_mount
+
+# Create our test files.
+testdir=$SCRATCH_MNT/find-by-type
+mkdir -p $testdir
+mkdir $testdir/d
+touch $testdir/f
+ln -s $testdir/f $testdir/l
+mknod $testdir/c c 1 1
+mknod $testdir/b b 1 1
+mknod $testdir/p p
+
+# Test d_type DT_DIR for . and ..
+# this should be correct on all fs regardless of filetype feature
+src/t_dir_type $testdir d | grep -F '.' | sort
+
+# Test that either all file type are unknown or all are valid
+if _supports_filetype $testdir; then
+	# print real file types
+	src/t_dir_type $testdir | grep -vF '.' | sort
+else
+	# list unknown files and print filename as fake file type
+	src/t_dir_type $testdir u | awk '{ print $1, $1 }' | sort
+fi
+
+status=0
+exit
diff --git a/tests/generic/396.out b/tests/generic/396.out
new file mode 100644
index 0000000..de11c24
--- /dev/null
+++ b/tests/generic/396.out
@@ -0,0 +1,9 @@
+QA output created by 396
+. d
+.. d
+b b
+c c
+d d
+f f
+l l
+p p
diff --git a/tests/generic/group b/tests/generic/group
index 20b31ef..24c242f 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -397,3 +397,4 @@
 392 auto quick metadata
 393 auto quick rw
 394 auto quick
+396 auto quick
-- 
2.7.4
