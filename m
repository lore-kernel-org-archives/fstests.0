Received: from userp1040.oracle.com ([156.151.31.81]:29611 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbcGUXrD (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 19:47:03 -0400
Subject: [PATCH 06/17] xfs: run xfs_repair at the end of each test
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 21 Jul 2016 16:46:54 -0700
Message-ID: <146914481474.11762.2741429828012981240.stgit@birch.djwong.org>
In-Reply-To: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Run xfs_repair twice at the end of each test -- once to rebuild
the btree indices, and again with -n to check the rebuild work.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 README    |    4 ++++
 common/rc |   30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)


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
index 7c79bf8..3b45578 100644
--- a/common/rc
+++ b/common/rc
@@ -2428,6 +2428,36 @@ _check_xfs_filesystem()
         ok=0
     fi
 
+    if [ -n "$TEST_XFS_REPAIR_REBUILD" ]; then
+        $XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
+        if [ $? -ne 0 ]
+        then
+            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (r) (see $seqres.full)"
+
+            echo "_check_xfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
+            echo "*** xfs_repair -n output ***"	>>$seqres.full
+            cat $tmp.repair | _fix_malloc		>>$seqres.full
+            echo "*** end xfs_repair output"	>>$seqres.full
+
+            ok=0
+        fi
+        rm -f $tmp.fs_check $tmp.logprint $tmp.repair
+
+        $XFS_REPAIR_PROG $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
+        if [ $? -ne 0 ]
+        then
+            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (r) (see $seqres.full)"
+
+            echo "_check_xfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
+            echo "*** xfs_repair -n output ***"	>>$seqres.full
+            cat $tmp.repair | _fix_malloc		>>$seqres.full
+            echo "*** end xfs_repair output"	>>$seqres.full
+
+            ok=0
+        fi
+        rm -f $tmp.fs_check $tmp.logprint $tmp.repair
+    fi
+
     $XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
     if [ $? -ne 0 ]
     then

