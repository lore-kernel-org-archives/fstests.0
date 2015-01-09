Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48887 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459AbbAICIw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 8 Jan 2015 21:08:52 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2 v2] xfs/087: move to shared/087
Date: Thu,  8 Jan 2015 18:08:38 -0800
Message-Id: <1420769318-81382-2-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1420769318-81382-1-git-send-email-jaegeuk@kernel.org>
References: <1420769318-81382-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch moves xfs/087 to shared/.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/shared/087     | 169 ++++++++++++++++++++++
 tests/shared/087.out | 389 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/shared/group   |   1 +
 tests/xfs/087        | 169 ----------------------
 tests/xfs/087.out    | 389 ---------------------------------------------------
 tests/xfs/group      |   1 -
 6 files changed, 559 insertions(+), 559 deletions(-)
 create mode 100755 tests/shared/087
 create mode 100644 tests/shared/087.out
 delete mode 100755 tests/xfs/087
 delete mode 100644 tests/xfs/087.out

diff --git a/tests/shared/087 b/tests/shared/087
new file mode 100755
index 0000000..337a9ff
--- /dev/null
+++ b/tests/shared/087
@@ -0,0 +1,169 @@
+#! /bin/bash
+# FS QA Test No. 087
+#
+# * like 086 but want to create more/different kinds of metadata
+#   and so will use fsstress
+# * also can interrupt metadata with godown
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
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
+trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/log
+. ./common/quota
+
+_do_meta()
+{
+    out=$SCRATCH_MNT/fsstress
+    count=10000
+    param="-p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10 \
+           -f rename=30 -f stat=30 -f unlink=30 -f truncate=20"
+    _echofull "calling fsstress $param -m8 -n $count"
+    FSSTRESS_ARGS=`_scale_fsstress_args $param $FSSTRESS_AVOID -m 8 -n $count -d $out`
+    if ! $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full 2>&1
+    then
+	_echofull "fsstress failed"
+    fi
+}
+
+# real QA test starts here
+_supported_fs xfs f2fs
+_supported_os IRIX Linux
+
+rm -f $seqres.full $tmp.*
+_require_scratch
+
+if [ "$FSTYP" == "xfs" ]; then
+    _require_v2log
+    _require_xfs_quota
+fi
+
+echo "*** init FS"
+umount $SCRATCH_DEV >/dev/null 2>&1
+
+cat >$tmp.seq.params <<EOF
+# mkfs-opt             mount-opt
+# ------------------------------
+  version=2            logbsize=32k
+  version=2,su=4096    logbsize=32k
+  version=2,su=32768   logbsize=32k
+  version=2            logbsize=64k
+  version=2,su=64k     logbsize=64k
+  version=2            logbsize=128k
+  version=2,su=128k    logbsize=128k
+  version=2            logbsize=256k
+  version=2,su=256k    logbsize=256k
+EOF
+
+cat $tmp.seq.params \
+| while read mkfs mnt restofline
+do
+    if [ "$mkfs" = "#" ]; then
+	continue
+    fi
+
+    echo "--- mkfs=$mkfs, mnt=$mnt ---"
+
+    if [ "$FSTYP" == "xfs" ]; then
+        export MKFS_OPTIONS="-l $mkfs"
+        export MOUNT_OPTIONS="-o $mnt"
+    fi
+
+    # mkfs the FS
+    _echofull "mkfs"
+    _scratch_mkfs >>$seqres.full 2>&1
+    if [ $? -ne 0 ] ; then
+	_echofull "mkfs failed: $MKFS_OPTIONS"
+	continue
+    fi
+
+    # mount the FS
+    _echofull "mount"
+    if ! _scratch_mount >>$seqres.full 2>&1; then
+	_echofull "mount failed: $MOUNT_OPTIONS"
+	continue
+    fi
+
+    # create the metadata
+    _do_meta
+
+    # check before on what FS should look like
+    _echofull "ls -RF SCRATCH_MNT"
+    ls -RF $SCRATCH_MNT >$tmp.ls1
+
+    _echofull "godown"
+    src/godown -v -f $SCRATCH_MNT >> $seqres.full
+
+    _echofull "unmount"
+    umount $SCRATCH_DEV >>$seqres.full 2>&1 \
+	|| _fail "umount failed"
+
+    _echofull "logprint after going down..."
+    if [ "$FSTYP" == "xfs" ]; then
+        _print_logstate
+    else
+	echo "dirty log"
+    fi
+
+    _full "logprint headers"
+    if [ "$FSTYP" == "xfs" ]; then
+        _scratch_xfs_logprint -n >>$seqres.full 2>&1
+    fi
+
+    _echofull "mount with replay"
+    _scratch_mount >>$seqres.full 2>&1 \
+	|| _fail "mount failed: $MOUNT_OPTIONS"
+
+    # check on what FS looks like after log recovery
+    _echofull "ls -RF SCRATCH_MNT"
+    ls -RF $SCRATCH_MNT >$tmp.ls2
+
+    _echofull "diff ls before and after"
+    diff -us $tmp.ls1 $tmp.ls2 | sed "s#$tmp#TMP#g"
+
+    _echofull "unmount"
+    umount $SCRATCH_MNT
+
+    _echofull "logprint after mount and replay..."
+    if [ "$FSTYP" == "xfs" ]; then
+        _print_logstate
+    else
+	echo "clean log"
+    fi
+
+    if _check_scratch_fs; then
+	_echofull "filesystem is checked ok"
+    else
+	_echofull "filesystem is NOT ok"
+    fi
+done
+
+status=0
+exit
diff --git a/tests/shared/087.out b/tests/shared/087.out
new file mode 100644
index 0000000..9f009c0
--- /dev/null
+++ b/tests/shared/087.out
@@ -0,0 +1,389 @@
+QA output created by 087
+*** init FS
+--- mkfs=version=2, mnt=logbsize=32k ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** godown ***
+
+
+*** unmount ***
+
+
+*** logprint after going down... ***
+
+dirty log
+
+*** mount with replay ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** diff ls before and after ***
+
+Files TMP.ls1 and TMP.ls2 are identical
+
+*** unmount ***
+
+
+*** logprint after mount and replay... ***
+
+clean log
+
+*** filesystem is checked ok ***
+
+--- mkfs=version=2,su=4096, mnt=logbsize=32k ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** godown ***
+
+
+*** unmount ***
+
+
+*** logprint after going down... ***
+
+dirty log
+
+*** mount with replay ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** diff ls before and after ***
+
+Files TMP.ls1 and TMP.ls2 are identical
+
+*** unmount ***
+
+
+*** logprint after mount and replay... ***
+
+clean log
+
+*** filesystem is checked ok ***
+
+--- mkfs=version=2,su=32768, mnt=logbsize=32k ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** godown ***
+
+
+*** unmount ***
+
+
+*** logprint after going down... ***
+
+dirty log
+
+*** mount with replay ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** diff ls before and after ***
+
+Files TMP.ls1 and TMP.ls2 are identical
+
+*** unmount ***
+
+
+*** logprint after mount and replay... ***
+
+clean log
+
+*** filesystem is checked ok ***
+
+--- mkfs=version=2, mnt=logbsize=64k ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** godown ***
+
+
+*** unmount ***
+
+
+*** logprint after going down... ***
+
+dirty log
+
+*** mount with replay ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** diff ls before and after ***
+
+Files TMP.ls1 and TMP.ls2 are identical
+
+*** unmount ***
+
+
+*** logprint after mount and replay... ***
+
+clean log
+
+*** filesystem is checked ok ***
+
+--- mkfs=version=2,su=64k, mnt=logbsize=64k ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** godown ***
+
+
+*** unmount ***
+
+
+*** logprint after going down... ***
+
+dirty log
+
+*** mount with replay ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** diff ls before and after ***
+
+Files TMP.ls1 and TMP.ls2 are identical
+
+*** unmount ***
+
+
+*** logprint after mount and replay... ***
+
+clean log
+
+*** filesystem is checked ok ***
+
+--- mkfs=version=2, mnt=logbsize=128k ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** godown ***
+
+
+*** unmount ***
+
+
+*** logprint after going down... ***
+
+dirty log
+
+*** mount with replay ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** diff ls before and after ***
+
+Files TMP.ls1 and TMP.ls2 are identical
+
+*** unmount ***
+
+
+*** logprint after mount and replay... ***
+
+clean log
+
+*** filesystem is checked ok ***
+
+--- mkfs=version=2,su=128k, mnt=logbsize=128k ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** godown ***
+
+
+*** unmount ***
+
+
+*** logprint after going down... ***
+
+dirty log
+
+*** mount with replay ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** diff ls before and after ***
+
+Files TMP.ls1 and TMP.ls2 are identical
+
+*** unmount ***
+
+
+*** logprint after mount and replay... ***
+
+clean log
+
+*** filesystem is checked ok ***
+
+--- mkfs=version=2, mnt=logbsize=256k ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** godown ***
+
+
+*** unmount ***
+
+
+*** logprint after going down... ***
+
+dirty log
+
+*** mount with replay ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** diff ls before and after ***
+
+Files TMP.ls1 and TMP.ls2 are identical
+
+*** unmount ***
+
+
+*** logprint after mount and replay... ***
+
+clean log
+
+*** filesystem is checked ok ***
+
+--- mkfs=version=2,su=256k, mnt=logbsize=256k ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** godown ***
+
+
+*** unmount ***
+
+
+*** logprint after going down... ***
+
+dirty log
+
+*** mount with replay ***
+
+
+*** ls -RF SCRATCH_MNT ***
+
+
+*** diff ls before and after ***
+
+Files TMP.ls1 and TMP.ls2 are identical
+
+*** unmount ***
+
+
+*** logprint after mount and replay... ***
+
+clean log
+
+*** filesystem is checked ok ***
+
diff --git a/tests/shared/group b/tests/shared/group
index 429f2b4..00525c0 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -4,6 +4,7 @@
 # - comment line before each group is "new" description
 #
 006 auto enospc
+087 log v2log auto quota stress
 032 mkfs auto quick
 051 acl udf auto quick
 272 auto enospc rw
diff --git a/tests/xfs/087 b/tests/xfs/087
deleted file mode 100755
index 9dc81c7..0000000
--- a/tests/xfs/087
+++ /dev/null
@@ -1,169 +0,0 @@
-#! /bin/bash
-# FS QA Test No. 087
-#
-# * like 086 but want to create more/different kinds of metadata
-#   and so will use fsstress
-# * also can interrupt metadata with godown
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-. ./common/log
-. ./common/quota
-
-_do_meta()
-{
-    out=$SCRATCH_MNT/fsstress
-    count=10000
-    param="-p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10 \
-           -f rename=30 -f stat=30 -f unlink=30 -f truncate=20"
-    _echofull "calling fsstress $param -m8 -n $count"
-    FSSTRESS_ARGS=`_scale_fsstress_args $param $FSSTRESS_AVOID -m 8 -n $count -d $out`
-    if ! $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full 2>&1
-    then
-	_echofull "fsstress failed"
-    fi
-}
-
-# real QA test starts here
-_supported_fs xfs f2fs
-_supported_os IRIX Linux
-
-rm -f $seqres.full $tmp.*
-_require_scratch
-
-if [ "$FSTYP" == "xfs" ]; then
-    _require_v2log
-    _require_xfs_quota
-fi
-
-echo "*** init FS"
-umount $SCRATCH_DEV >/dev/null 2>&1
-
-cat >$tmp.seq.params <<EOF
-# mkfs-opt             mount-opt
-# ------------------------------
-  version=2            logbsize=32k
-  version=2,su=4096    logbsize=32k
-  version=2,su=32768   logbsize=32k
-  version=2            logbsize=64k
-  version=2,su=64k     logbsize=64k
-  version=2            logbsize=128k
-  version=2,su=128k    logbsize=128k
-  version=2            logbsize=256k
-  version=2,su=256k    logbsize=256k
-EOF
-
-cat $tmp.seq.params \
-| while read mkfs mnt restofline
-do
-    if [ "$mkfs" = "#" ]; then 
-	continue
-    fi
-
-    echo "--- mkfs=$mkfs, mnt=$mnt ---"
-
-    if [ "$FSTYP" == "xfs" ]; then
-        export MKFS_OPTIONS="-l $mkfs"
-        export MOUNT_OPTIONS="-o $mnt"
-    fi
-
-    # mkfs the FS
-    _echofull "mkfs"
-    _scratch_mkfs >>$seqres.full 2>&1
-    if [ $? -ne 0 ] ; then 
-	_echofull "mkfs failed: $MKFS_OPTIONS"
-	continue
-    fi
-
-    # mount the FS
-    _echofull "mount"
-    if ! _scratch_mount >>$seqres.full 2>&1; then
-	_echofull "mount failed: $MOUNT_OPTIONS"
-	continue
-    fi
-
-    # create the metadata
-    _do_meta
-
-    # check before on what FS should look like
-    _echofull "ls -RF SCRATCH_MNT"
-    ls -RF $SCRATCH_MNT >$tmp.ls1
-
-    _echofull "godown"
-    src/godown -v -f $SCRATCH_MNT >> $seqres.full
-
-    _echofull "unmount"
-    umount $SCRATCH_DEV >>$seqres.full 2>&1 \
-	|| _fail "umount failed"
-
-    _echofull "logprint after going down..."
-    if [ "$FSTYP" == "xfs" ]; then
-        _print_logstate
-    else
-	echo "dirty log"
-    fi
-
-    _full "logprint headers"
-    if [ "$FSTYP" == "xfs" ]; then
-        _scratch_xfs_logprint -n >>$seqres.full 2>&1
-    fi
-
-    _echofull "mount with replay"
-    _scratch_mount >>$seqres.full 2>&1 \
-	|| _fail "mount failed: $MOUNT_OPTIONS"
-
-    # check on what FS looks like after log recovery
-    _echofull "ls -RF SCRATCH_MNT"
-    ls -RF $SCRATCH_MNT >$tmp.ls2
-
-    _echofull "diff ls before and after"
-    diff -us $tmp.ls1 $tmp.ls2 | sed "s#$tmp#TMP#g"
-
-    _echofull "unmount"
-    umount $SCRATCH_MNT
-
-    _echofull "logprint after mount and replay..."
-    if [ "$FSTYP" == "xfs" ]; then
-        _print_logstate
-    else
-	echo "clean log"
-    fi
-
-    if _check_scratch_fs; then
-	_echofull "filesystem is checked ok"
-    else
-	_echofull "filesystem is NOT ok"
-    fi
-done
-
-status=0 
-exit
diff --git a/tests/xfs/087.out b/tests/xfs/087.out
deleted file mode 100644
index 9f009c0..0000000
--- a/tests/xfs/087.out
+++ /dev/null
@@ -1,389 +0,0 @@
-QA output created by 087
-*** init FS
---- mkfs=version=2, mnt=logbsize=32k ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** godown ***
-
-
-*** unmount ***
-
-
-*** logprint after going down... ***
-
-dirty log
-
-*** mount with replay ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** diff ls before and after ***
-
-Files TMP.ls1 and TMP.ls2 are identical
-
-*** unmount ***
-
-
-*** logprint after mount and replay... ***
-
-clean log
-
-*** filesystem is checked ok ***
-
---- mkfs=version=2,su=4096, mnt=logbsize=32k ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** godown ***
-
-
-*** unmount ***
-
-
-*** logprint after going down... ***
-
-dirty log
-
-*** mount with replay ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** diff ls before and after ***
-
-Files TMP.ls1 and TMP.ls2 are identical
-
-*** unmount ***
-
-
-*** logprint after mount and replay... ***
-
-clean log
-
-*** filesystem is checked ok ***
-
---- mkfs=version=2,su=32768, mnt=logbsize=32k ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** godown ***
-
-
-*** unmount ***
-
-
-*** logprint after going down... ***
-
-dirty log
-
-*** mount with replay ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** diff ls before and after ***
-
-Files TMP.ls1 and TMP.ls2 are identical
-
-*** unmount ***
-
-
-*** logprint after mount and replay... ***
-
-clean log
-
-*** filesystem is checked ok ***
-
---- mkfs=version=2, mnt=logbsize=64k ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** godown ***
-
-
-*** unmount ***
-
-
-*** logprint after going down... ***
-
-dirty log
-
-*** mount with replay ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** diff ls before and after ***
-
-Files TMP.ls1 and TMP.ls2 are identical
-
-*** unmount ***
-
-
-*** logprint after mount and replay... ***
-
-clean log
-
-*** filesystem is checked ok ***
-
---- mkfs=version=2,su=64k, mnt=logbsize=64k ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** godown ***
-
-
-*** unmount ***
-
-
-*** logprint after going down... ***
-
-dirty log
-
-*** mount with replay ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** diff ls before and after ***
-
-Files TMP.ls1 and TMP.ls2 are identical
-
-*** unmount ***
-
-
-*** logprint after mount and replay... ***
-
-clean log
-
-*** filesystem is checked ok ***
-
---- mkfs=version=2, mnt=logbsize=128k ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** godown ***
-
-
-*** unmount ***
-
-
-*** logprint after going down... ***
-
-dirty log
-
-*** mount with replay ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** diff ls before and after ***
-
-Files TMP.ls1 and TMP.ls2 are identical
-
-*** unmount ***
-
-
-*** logprint after mount and replay... ***
-
-clean log
-
-*** filesystem is checked ok ***
-
---- mkfs=version=2,su=128k, mnt=logbsize=128k ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** godown ***
-
-
-*** unmount ***
-
-
-*** logprint after going down... ***
-
-dirty log
-
-*** mount with replay ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** diff ls before and after ***
-
-Files TMP.ls1 and TMP.ls2 are identical
-
-*** unmount ***
-
-
-*** logprint after mount and replay... ***
-
-clean log
-
-*** filesystem is checked ok ***
-
---- mkfs=version=2, mnt=logbsize=256k ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** godown ***
-
-
-*** unmount ***
-
-
-*** logprint after going down... ***
-
-dirty log
-
-*** mount with replay ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** diff ls before and after ***
-
-Files TMP.ls1 and TMP.ls2 are identical
-
-*** unmount ***
-
-
-*** logprint after mount and replay... ***
-
-clean log
-
-*** filesystem is checked ok ***
-
---- mkfs=version=2,su=256k, mnt=logbsize=256k ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** calling fsstress -p 4 -z -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10            -f rename=30 -f stat=30 -f unlink=30 -f truncate=20 -m8 -n 10000 ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** godown ***
-
-
-*** unmount ***
-
-
-*** logprint after going down... ***
-
-dirty log
-
-*** mount with replay ***
-
-
-*** ls -RF SCRATCH_MNT ***
-
-
-*** diff ls before and after ***
-
-Files TMP.ls1 and TMP.ls2 are identical
-
-*** unmount ***
-
-
-*** logprint after mount and replay... ***
-
-clean log
-
-*** filesystem is checked ok ***
-
diff --git a/tests/xfs/group b/tests/xfs/group
index 496630d..1e4be94 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -76,7 +76,6 @@
 084 ioctl rw auto
 085 log auto quick
 086 log v2log auto
-087 log v2log auto quota stress
 090 rw auto
 092 other auto quick
 094 metadata dir ioctl auto
-- 
2.1.1

