Received: from imap.thunk.org ([74.207.234.97]:60424 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753214AbcLHD6w (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Dec 2016 22:58:52 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] overlay: stress test changes to top and bottom layers simultaneously
Date: Wed,  7 Dec 2016 22:58:44 -0500
Message-Id: <20161208035844.18544-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Introduce a test which runs fsstress on the top and bottom overlayfs
directories simultaneously to find potential races that plagued wrapfs
derived file systems.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/overlay/017     | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/017.out |  2 ++
 tests/overlay/group   |  1 +
 3 files changed, 84 insertions(+)
 create mode 100755 tests/overlay/017
 create mode 100644 tests/overlay/017.out

diff --git a/tests/overlay/017 b/tests/overlay/017
new file mode 100755
index 00000000..1dbde766
--- /dev/null
+++ b/tests/overlay/017
@@ -0,0 +1,81 @@
+#! /bin/bash
+# FS QA Test 017
+#
+# Run fsstress on lower dir and top dir at the same time
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
+_supported_fs overlay
+_supported_os Linux
+_require_scratch
+
+# Remove all files from previous tests
+_scratch_mkfs
+
+lowerdir=$SCRATCH_DEV/$OVERLAY_LOWER_DIR
+mkdir -p $lowerdir
+
+_scratch_mount
+
+echo "Silence is golden"
+
+d_low=$lowerdir/fsstress
+d_top=$SCRATCH_MNT/fsstress
+mkdir -p $d_low $d_top
+
+echo $FSSTRESS_PROG -s 42 -d $d_low -p 4 -n 1000 -l100 -v > $seqres.full.1
+$FSSTRESS_PROG -s 42 -d $d_low -p 4 -n 1000 -l100 -v >> $seqres.full.1 2>&1 &
+
+echo $FSSTRESS_PROG -s 42 -d $d_top -p 4 -n 1000 -l100 -v > $seqres.full.2
+$FSSTRESS_PROG -s 42 -d $d_top -p 4 -n 1000 -l100 -v >> $seqres.full.2 2>&1 &
+
+ret=0
+if ! wait %1
+then
+        echo "--------------------------------------"       >>$seqres.full.1
+	echo "fsstress on lower directory returned $? - see $seqres.full.1"
+        echo "--------------------------------------"       >>$seqres.full.1
+	ret=1
+fi
+
+if ! wait %2
+then
+        echo "--------------------------------------"       >>$seqres.full.2
+	echo "fsstress on overlay directory returned $? - see $seqres.full.2"
+        echo "--------------------------------------"       >>$seqres.full.2
+	ret=1
+fi
+
+cat $seqres.full.1 $seqres.full.2 > $seqres.full
+rm $seqres.full.1 $seqres.full.2
+
+if [ "$ret" -eq 1 ]
+then
+	status=1
+else
+	status=0
+fi
+
+exit $status
diff --git a/tests/overlay/017.out b/tests/overlay/017.out
new file mode 100644
index 00000000..82228448
--- /dev/null
+++ b/tests/overlay/017.out
@@ -0,0 +1,2 @@
+QA output created by 017
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index 5740d2a2..b310aebe 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -19,3 +19,4 @@
 014 auto quick copyup
 015 auto quick whiteout
 016 auto quick
+017 auto quick
-- 
2.11.0.rc0.7.gbe5a750

