Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:20169 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752516AbbBXW7t (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Feb 2015 17:59:49 -0500
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YQONF-0004w0-WA
	for fstests@vger.kernel.org; Wed, 25 Feb 2015 09:54:42 +1100
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YQONF-0002gE-Us
	for fstests@vger.kernel.org; Wed, 25 Feb 2015 09:54:41 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 4/4] generic: Add rudimetary RENAME_WHITEOUT test
Date: Wed, 25 Feb 2015 09:54:39 +1100
Message-Id: <1424818479-10083-5-git-send-email-david@fromorbit.com>
In-Reply-To: <1424818479-10083-1-git-send-email-david@fromorbit.com>
References: <1424818479-10083-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

There is no API documentation for RENAME_WHITEOUT. There is no
developer documentation for RENAME_WHITEOUT. There are not comments
in the overlayfs or ext4 implementation of RENAME_WHITEOUT.

Hence, this test simply tries to expose basic RENAME_WHITEOUT
behaviour from ext4 so we can reverse-engineer and verify
bug-for-bug renameat2(RENAME_WHITEOUT) ext4 compatibility.

Note: uses generic/078 just to keep out of the way of the 6-7 other
pending new tests.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 src/renameat2.c       |  4 ++--
 tests/generic/078     | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/078.out | 51 +++++++++++++++++++++++++++++++++++++++
 tests/generic/group   |  1 +
 4 files changed, 120 insertions(+), 2 deletions(-)
 create mode 100755 tests/generic/078
 create mode 100644 tests/generic/078.out

diff --git a/src/renameat2.c b/src/renameat2.c
index 5ac0936..c59ce65 100644
--- a/src/renameat2.c
+++ b/src/renameat2.c
@@ -96,9 +96,9 @@ int main(int argc, char *argv[])
 		 * Turn EEXIST into ENOTEMPTY.  E.g. XFS uses EEXIST, and that
 		 * is also accepted by the standards.
 		 *
-		 * This applies only to plain rename (flags == 0).
+		 * This applies only to plain rename and RENAME_WHITEOUT
 		 */
-		if (!flags && errno == EEXIST)
+		if (errno == EEXIST && (!flags || (flags & RENAME_WHITEOUT)))
 			errno = ENOTEMPTY;
 
 		perror("");
diff --git a/tests/generic/078 b/tests/generic/078
new file mode 100755
index 0000000..92ece0c
--- /dev/null
+++ b/tests/generic/078
@@ -0,0 +1,66 @@
+#! /bin/bash
+# FS QA Test No. generic/078
+#
+# Check renameat2 syscall with RENAME_WHITEOUT flag
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Miklos Szeredi.  All Rights Reserved.
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
+    cd /
+    rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/renameat2
+
+_supported_fs generic
+_supported_os Linux
+
+_require_test
+_requires_renameat2
+_require_test_symlinks
+
+rename_dir=$TEST_DIR/$$
+mkdir $rename_dir
+touch $rename_dir/foo $rename_dir/bar
+if ! src/renameat2 -t -w $rename_dir/foo $rename_dir/bar; then
+    rm -f $rename_dir/foo $rename_dir/bar; rmdir $rename_dir
+    _notrun "fs doesn't support RENAME_WHITEOUT"
+fi
+rm -f $rename_dir/foo $rename_dir/bar
+
+# real QA test starts here
+
+_rename_tests $rename_dir -w
+rmdir $rename_dir
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/078.out b/tests/generic/078.out
new file mode 100644
index 0000000..5d5e3a0
--- /dev/null
+++ b/tests/generic/078.out
@@ -0,0 +1,51 @@
+QA output created by 078
+samedir  none/none -> No such file or directory
+samedir  none/regu -> No such file or directory
+samedir  none/symb -> No such file or directory
+samedir  none/dire -> No such file or directory
+samedir  none/tree -> No such file or directory
+samedir  regu/none -> char/regu.
+samedir  regu/regu -> char/regu.
+samedir  regu/symb -> char/regu.
+samedir  regu/dire -> Is a directory
+samedir  regu/tree -> Is a directory
+samedir  symb/none -> char/symb.
+samedir  symb/regu -> char/symb.
+samedir  symb/symb -> char/symb.
+samedir  symb/dire -> Is a directory
+samedir  symb/tree -> Is a directory
+samedir  dire/none -> char/dire.
+samedir  dire/regu -> Not a directory
+samedir  dire/symb -> Not a directory
+samedir  dire/dire -> char/dire.
+samedir  dire/tree -> Directory not empty
+samedir  tree/none -> char/tree.
+samedir  tree/regu -> Not a directory
+samedir  tree/symb -> Not a directory
+samedir  tree/dire -> char/tree.
+samedir  tree/tree -> Directory not empty
+crossdir none/none -> No such file or directory
+crossdir none/regu -> No such file or directory
+crossdir none/symb -> No such file or directory
+crossdir none/dire -> No such file or directory
+crossdir none/tree -> No such file or directory
+crossdir regu/none -> char/regu.
+crossdir regu/regu -> char/regu.
+crossdir regu/symb -> char/regu.
+crossdir regu/dire -> Is a directory
+crossdir regu/tree -> Is a directory
+crossdir symb/none -> char/symb.
+crossdir symb/regu -> char/symb.
+crossdir symb/symb -> char/symb.
+crossdir symb/dire -> Is a directory
+crossdir symb/tree -> Is a directory
+crossdir dire/none -> char/dire.
+crossdir dire/regu -> Not a directory
+crossdir dire/symb -> Not a directory
+crossdir dire/dire -> char/dire.
+crossdir dire/tree -> Directory not empty
+crossdir tree/none -> char/tree.
+crossdir tree/regu -> Not a directory
+crossdir tree/symb -> Not a directory
+crossdir tree/dire -> char/tree.
+crossdir tree/tree -> Directory not empty
diff --git a/tests/generic/group b/tests/generic/group
index f2eb87a..0f274a6 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -69,6 +69,7 @@
 075 rw udf auto quick
 076 metadata rw udf auto quick stress
 077 acl attr auto enospc
+078 auto quick metadata
 079 acl attr ioctl metadata auto quick
 083 rw auto enospc stress
 088 perms auto quick
-- 
2.0.0

