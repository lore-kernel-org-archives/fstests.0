Received: from mx2.suse.de ([195.135.220.15]:50752 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbbHYJmT (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 25 Aug 2015 05:42:19 -0400
From: Jan Kara <jack@suse.com>
Subject: [PATCH] fstests: Add test of rename
Date: Tue, 25 Aug 2015 11:42:10 +0200
Message-Id: <1440495730-14093-1-git-send-email-jack@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Jan Kara <jack@suse.com>
List-ID: <fstests@vger.kernel.org>

Test renaming of various entry types in directories of various sizes.
Check that filesystem didn't get corrupted.

Signed-off-by: Jan Kara <jack@suse.com>
---
 tests/generic/326   | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/group |  1 +
 2 files changed, 94 insertions(+)
 create mode 100755 tests/generic/326

This is a regression test for ftype handling bug I've fixed last week in XFS.
I've made the test to iterate relatively densely over a wide range of directory
sizes so that it can be used to test handling of different directory
formats also for other filesystems (e.g. ext4 has inline & normal directories,
UDF as well). I have verified that for XFS we test directory operations for all
directory types.

diff --git a/tests/generic/326 b/tests/generic/326
new file mode 100755
index 000000000000..a8d9e9b5a34f
--- /dev/null
+++ b/tests/generic/326
@@ -0,0 +1,93 @@
+#! /bin/bash
+# FS QA Test No. 326
+#
+# Test rename for various sizes of directories. This is motivated by a bug
+# in XFS where directory entry file type was not updated properly on rename.
+#
+#-----------------------------------------------------------------------
+# Copyright (C) 2015 SUSE Linux Products GmbH. All Rights Reserved.
+# Author: Jan Kara <jack@suse.com>
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
+status=1	# failure is the default!
+
+filldir()
+{
+	for (( i = 0; i < $1; i++ )); do
+		touch "fname$i"
+	done
+}
+
+# Test renaming of file, symlink over file, symlink, non-existent
+# name
+renamedir()
+{
+	touch fs1
+	touch fs2
+	touch fs3
+	touch fd1
+	touch fd2
+	ln -s foo ss1
+	ln -s foo ss2
+	ln -s foo ss3
+	ln -s foo sd1
+	ln -s foo sd2
+
+	mv -T fs1 fd1
+	mv -T fs2 sd1
+	mv -T fs3 ed1
+
+	mv -T ss1 fd2
+	mv -T ss2 sd2
+	mv -T ss3 ed2
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/log
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+rm -f $seqres.full
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+# Test different directory sizes to test various directory formats
+for f in 1 2 3 4 5 8 12 18 27 40 60 90 135 202 303 454 681 1020 1530 2295; do
+	mkdir $SCRATCH_MNT/dir$f
+	pushd $SCRATCH_MNT/dir$f >/dev/null
+	filldir $f
+	renamedir
+	popd >/dev/null
+done
+
+if _check_scratch_fs; then
+	_echofull "Scratch fs is fine after renames"
+	status=0
+fi
+
+exit
diff --git a/tests/generic/group b/tests/generic/group
index a33536ec2a0a..612cb8efe879 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -204,3 +204,4 @@
 323 auto aio stress
 324 auto fsr quick
 325 auto quick data log
+326 auto metadata dir
-- 
2.1.4

