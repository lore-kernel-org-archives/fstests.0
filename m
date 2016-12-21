Received: from mail-wm0-f66.google.com ([74.125.82.66]:35939 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756940AbcLUNum (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Dec 2016 08:50:42 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so30581310wma.3
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 05:50:41 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v3 3/3] generic/396: test correct d_type values
Date: Wed, 21 Dec 2016 15:50:21 +0200
Message-Id: <1482328221-31713-1-git-send-email-amir73il@gmail.com>
In-Reply-To: <1482239855-791-4-git-send-email-amir73il@gmail.com>
References: <1482239855-791-4-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Verify correct d_type values of dir entries.

This test does NOT require that file system support the filetype feature.
It verifies that either all file types are reported as DT_UNKNOWN
or that all file types are reported correctly.

For fs for which we know how to test the filetype feature (xfs|ext*)
verify getting DT_UNKNOWN IFF filetype feature is disabled.

Special dir entries . and .. MAY be reported as DT_UNKNOWN IF filetype
feature is disabled (ext4), but MAY also be reported as DT_DIR in this
case (xfs).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/396     | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/396.out |  9 +++++
 tests/generic/group   |  1 +
 3 files changed, 103 insertions(+)
 create mode 100755 tests/generic/396
 create mode 100644 tests/generic/396.out

Added another test to the matrix, found another special case to handle:
ext4 vs. xfs returns DT_UNKNOWN for . and .. on ! _supports_filetype.

Fixes the test to correctly handle both cases.

Tested with tmpfs, ext2, ext4, xfs for d_type supported fs
Tested with xfs -m crc=0 -n ftype=0 for d_type unsupported fs
Tested with ext2/ext4 -O ^filetype  for d_type unsupported fs

v3:
- allow DT_UNKNOWN type for . and .. when filetype feature is disabled (ext4)

v2:
- use helper to test for file type support
- allow DT_UNKNOWN type, but only for all files
- verify . and .. have DT_DIR type

v1:
- verify that d_type matches actual file type

diff --git a/tests/generic/396 b/tests/generic/396
new file mode 100755
index 0000000..0d4a17d
--- /dev/null
+++ b/tests/generic/396
@@ -0,0 +1,93 @@
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
+# Special dir entries . and .. MAY be reported as DT_UNKNOWN IF filetype
+# feature is disabled (ext4), but MAY also be reported as DT_DIR in this
+# case (xfs).
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
+# Test d_type of . and ..
+# it must be DT_DIR on fs with filetype support and it could be
+# either DR_DIR or DT_UNKNOWN on fs without filetype support
+src/t_dir_type $testdir d | grep -F '.' | sort
+
+# Test that either all file types are unknown or all are correct
+if _supports_filetype $testdir; then
+	# print real file types
+	src/t_dir_type $testdir | grep -vF '.' | sort
+else
+	# print fake dir file type for . and .. if they are DT_UNKNOWN
+	src/t_dir_type $testdir u | grep -F '.' | \
+		awk '{ print $1, "d" }' | sort
+	# list unknown files and print filename as fake file type
+	src/t_dir_type $testdir u | grep -vF '.' | \
+		awk '{ print $1, $1 }' | sort
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

