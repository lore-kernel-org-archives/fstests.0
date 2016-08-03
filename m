Received: from userp1050.oracle.com ([156.151.31.82]:48469 "EHLO
	userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756754AbcHCWrD (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2016 18:47:03 -0400
Date: Wed, 3 Aug 2016 15:45:36 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH v2 06/17] xfs: optionally test xfs_repair index rebuilding at
 the end of each test
Message-ID: <20160803224536.GC8586@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914481474.11762.2741429828012981240.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914481474.11762.2741429828012981240.stgit@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Run xfs_repair twice more at the end of each test -- once to rebuild
the btree indices, and again with -n to check the rebuild work.  This
is in addition to the regular dry-run spot check.

v2: Reorder the repair invocations and label them better in the output.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 README    |    4 ++++
 common/rc |   31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/README b/README
index 2647e12..4509cc1 100644
--- a/README
+++ b/README
@@ -80,6 +80,10 @@ Preparing system for tests (IRIX and Linux):
                added to the end of fsstresss and fsx invocations, respectively,
                in case you wish to exclude certain operational modes from these
                tests.
+             - set TEST_XFS_REPAIR_REBUILD=1 to have _check_xfs_filesystem
+               run xfs_repair -n to check the filesystem; xfs_repair to rebuild
+               metadata indexes; and xfs_repair -n (a third time) to check the
+               results of the rebuilding.
 
         - or add a case to the switch in common/config assigning
           these variables based on the hostname of your test
diff --git a/common/rc b/common/rc
index 0ff72f2..eca9b9d 100644
--- a/common/rc
+++ b/common/rc
@@ -2452,6 +2452,37 @@ _check_xfs_filesystem()
     fi
     rm -f $tmp.fs_check $tmp.logprint $tmp.repair
 
+    # Optionally test the index rebuilding behavior.
+    if [ -n "$TEST_XFS_REPAIR_REBUILD" ]; then
+        $XFS_REPAIR_PROG $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
+        if [ $? -ne 0 ]
+        then
+            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild) (see $seqres.full)"
+
+            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild)" >>$seqres.full
+            echo "*** xfs_repair output ***"	>>$seqres.full
+            cat $tmp.repair | _fix_malloc		>>$seqres.full
+            echo "*** end xfs_repair output"	>>$seqres.full
+
+            ok=0
+        fi
+        rm -f $tmp.fs_check $tmp.logprint $tmp.repair
+
+        $XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
+        if [ $? -ne 0 ]
+        then
+            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild-reverify) (see $seqres.full)"
+
+            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild-reverify)" >>$seqres.full
+            echo "*** xfs_repair -n output ***"	>>$seqres.full
+            cat $tmp.repair | _fix_malloc		>>$seqres.full
+            echo "*** end xfs_repair output"	>>$seqres.full
+
+            ok=0
+        fi
+        rm -f $tmp.fs_check $tmp.logprint $tmp.repair
+    fi
+
     if [ $ok -eq 0 ]
     then
         echo "*** mount output ***"		>>$seqres.full
