Received: from aserp1040.oracle.com ([141.146.126.69]:35992 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdAWV5z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Jan 2017 16:57:55 -0500
Date: Mon, 23 Jan 2017 13:57:50 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] xfs: test xfs_db source command
Message-ID: <20170123215750.GO14033@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Make sure that the 'source' command works correctly whether supplied
via command line or interactive prompt.

You probably want "xfs_db: fix the 'source' command when passed as a -c
option" in xfsprogs.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/400     |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/400.out |   11 ++++++++
 tests/xfs/group   |    1 +
 3 files changed, 81 insertions(+)
 create mode 100755 tests/xfs/400
 create mode 100644 tests/xfs/400.out

diff --git a/tests/xfs/400 b/tests/xfs/400
new file mode 100755
index 0000000..a11ea12
--- /dev/null
+++ b/tests/xfs/400
@@ -0,0 +1,69 @@
+#! /bin/bash
+# FS QA Test No. 400
+#
+# Test nesting the 'source' command in xfs_db via -c and interactive.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Oracle, Inc.  All Rights Reserved.
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
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1303  USA
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
+trap "_cleanup; exit \$status" 0 1 2 3 7 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.* $seqres.a $seqres.b
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs xfs
+_require_scratch
+
+cat > $seqres.a << ENDL
+echo This is file A
+source $seqres.b
+ENDL
+cat > $seqres.b << ENDL
+echo This is file B
+ENDL
+
+echo "Test with -c"
+_scratch_xfs_db -c "sb 0" -c "p magicnum" -c "source $seqres.a" -c "p magicnum" | sed -e 's/0x58465342/XFS_MAGIC/g'
+
+echo "Test with interactive"
+(echo "sb 0"; sleep 0.5;
+ echo "p magicnum"; sleep 0.5;
+ echo "source $seqres.a"; sleep 0.5;
+ echo "p magicnum"; sleep 0.5) | _scratch_xfs_db 2>&1 | sed -e 's/xfs_db> //g' -e 's/0x58465342/XFS_MAGIC/g' | egrep '(This is file|magicnum =)'
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/400.out b/tests/xfs/400.out
new file mode 100644
index 0000000..7772b7b
--- /dev/null
+++ b/tests/xfs/400.out
@@ -0,0 +1,11 @@
+QA output created by 400
+Test with -c
+magicnum = XFS_MAGIC
+This is file A 
+This is file B 
+magicnum = XFS_MAGIC
+Test with interactive
+magicnum = XFS_MAGIC
+This is file A 
+This is file B 
+magicnum = XFS_MAGIC
diff --git a/tests/xfs/group b/tests/xfs/group
index 43685b8..7ffb1ec 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -337,6 +337,7 @@
 346 auto quick clone
 347 auto quick clone
 348 auto quick repair
+400 auto quick
 1300 dangerous_fuzzers scrub
 1301 dangerous_fuzzers dangerous_scrub dangerous_repair
 1302 dangerous_fuzzers dangerous_scrub dangerous_repair
