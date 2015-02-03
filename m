From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 8/8 v4] tests/generic: relocate four xfs's tests
	into tests/generic/
Date: Tue,  3 Feb 2015 15:07:20 -0800
Message-ID: <1423004840-45315-9-git-send-email-jaegeuk@kernel.org>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dave Chinner <david@fromorbit.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: fstests@vger.kernel.org

This patch moves the generic testcases defined in xfs into tests/generic/.
 xfs/051 -> generic/051
 xfs/085 -> generic/085
 xfs/086 -> generic/086
 xfs/087 -> generic/087

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/generic/051          |  103 +
 tests/generic/051.out      |    2 +
 tests/generic/085          |   98 +
 tests/generic/085.out      |  113 ++
 tests/generic/086          |  178 ++
 tests/generic/086.out.f2fs | 3306 +++++++++++++++++++++++++++++++
 tests/generic/086.out.xfs  | 4722 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/087          |  179 ++
 tests/generic/087.out.f2fs |  303 +++
 tests/generic/087.out.xfs  |  389 ++++
 tests/generic/group        |    4 +
 tests/xfs/051              |  103 -
 tests/xfs/051.out          |    2 -
 tests/xfs/085              |   98 -
 tests/xfs/085.out          |  113 --
 tests/xfs/086              |  178 --
 tests/xfs/086.out.f2fs     | 3306 -------------------------------
 tests/xfs/086.out.xfs      | 4722 --------------------------------------------
 tests/xfs/087              |  179 --
 tests/xfs/087.out.f2fs     |  303 ---
 tests/xfs/087.out.xfs      |  389 ----
 tests/xfs/group            |    4 -
 22 files changed, 9397 insertions(+), 9397 deletions(-)
 create mode 100755 tests/generic/051
 create mode 100644 tests/generic/051.out
 create mode 100755 tests/generic/085
 create mode 100644 tests/generic/085.out
 create mode 100755 tests/generic/086
 create mode 100644 tests/generic/086.out.f2fs
 create mode 100644 tests/generic/086.out.xfs
 create mode 100755 tests/generic/087
 create mode 100644 tests/generic/087.out.f2fs
 create mode 100644 tests/generic/087.out.xfs
 delete mode 100755 tests/xfs/051
 delete mode 100644 tests/xfs/051.out
 delete mode 100755 tests/xfs/085
 delete mode 100644 tests/xfs/085.out
 delete mode 100755 tests/xfs/086
 delete mode 100644 tests/xfs/086.out.f2fs
 delete mode 100644 tests/xfs/086.out.xfs
 delete mode 100755 tests/xfs/087
 delete mode 100644 tests/xfs/087.out.f2fs
 delete mode 100644 tests/xfs/087.out.xfs

diff --git a/tests/generic/051 b/tests/generic/051
new file mode 100755
index 0000000..f2f21f0
--- /dev/null
+++ b/tests/generic/051
@@ -0,0 +1,103 @@
+#! /bin/bash
+# FS QA Test No. 051
+#
+# Simulate a buffer use after free race in XFS log recovery. The race triggers
+# on I/O failures during log recovery. Note that this test is dangerous as it
+# causes BUG() errors or a panic.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2013 Oracle, Inc.  All Rights Reserved.
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
+	cd /
+	rm -f $tmp.*
+	killall -9 $FSSTRESS_PROG > /dev/null 2>&1
+	_scratch_unmount > /dev/null 2>&1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/dmflakey
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_scratch_shutdown
+_require_dm_flakey
+
+if [ "$FSTYP" == "xfs" ]; then
+    _require_xfs_sysfs debug/log_recovery_delay
+fi
+
+echo "Silence is golden."
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+# Start a workload and shutdown the fs. The subsequent mount will require log
+# recovery.
+$FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT > /dev/null 2>&1 &
+sleep 5
+src/godown -f $SCRATCH_MNT
+killall -q $FSSTRESS_PROG
+wait
+_scratch_unmount
+
+# Initialize a dm-flakey device that will pass I/Os for 5s and fail thereafter.
+_init_flakey
+BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
+FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 5 180"
+_load_flakey_table $FLAKEY_ALLOW_WRITES
+
+# Set a 10s log recovery delay and mount the flakey device. This should allow
+# initial writes to proceed (e.g., stale log block reset) and then let the
+# flakey uptime timer expire such that I/Os will fail by the time log recovery
+# starts.
+if [ "$FSTYP" == "xfs" ]; then
+    echo 10 > /sys/fs/xfs/debug/log_recovery_delay
+fi
+
+# The mount should fail due to dm-flakey. Note that this is dangerous on kernels
+# without the xfs_buf log recovery race fixes.
+_mount_flakey > /dev/null 2>&1
+
+if [ "$FSTYP" == "xfs" ]; then
+    echo 0 > /sys/fs/xfs/debug/log_recovery_delay
+fi
+
+_cleanup_flakey
+
+# replay the log
+_scratch_mount
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/051.out b/tests/generic/051.out
new file mode 100644
index 0000000..5180bc4
--- /dev/null
+++ b/tests/generic/051.out
@@ -0,0 +1,2 @@
+QA output created by 051
+Silence is golden.
diff --git a/tests/generic/085 b/tests/generic/085
new file mode 100755
index 0000000..db394eb
--- /dev/null
+++ b/tests/generic/085
@@ -0,0 +1,98 @@
+#! /bin/bash
+# FS QA Test No. 085
+#
+# To test log replay by shutdown of file system
+# This is the first simple initial test to ensure that
+# the goingdown ioctl is working and recovery of
+# create transactions is working.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.
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
+
+# real QA test starts here
+_supported_fs generic
+_supported_os IRIX Linux
+
+rm -f $seqres.full
+rm -f $tmp.log
+
+_require_scratch
+_require_scratch_shutdown
+
+if [ "$FSTYP" == "f2fs" ]; then
+    _require_dumpf2fs
+fi
+
+echo "mkfs"
+_scratch_mkfs >>$seqres.full 2>&1 \
+    || _fail "mkfs scratch failed"
+
+echo "mount"
+_scratch_mount >>$seqres.full 2>&1 \
+    || _fail "mount failed: $MOUNT_OPTIONS"
+
+echo "touch files"
+touch $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
+
+echo "godown"
+src/godown -v -f $SCRATCH_MNT >> $seqres.full
+
+echo "unmount"
+umount $SCRATCH_MNT
+
+echo "logprint after going down..."
+_print_logstate
+
+# curious if FS consistent at start
+if false; then
+    if _xfs_check $SCRATCH_DEV; then
+       echo "*** checked ok ***"
+    fi
+fi
+
+echo "mount with replay"
+_scratch_mount $mnt >>$seqres.full 2>&1 \
+    || _fail "mount failed: $mnt $MOUNT_OPTIONS"
+
+echo "ls SCRATCH_MNT"
+ls $SCRATCH_MNT
+
+echo "unmount"
+umount $SCRATCH_MNT
+
+echo "logprint after mount and replay..."
+_print_logstate
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/085.out b/tests/generic/085.out
new file mode 100644
index 0000000..d2d99a1
--- /dev/null
+++ b/tests/generic/085.out
@@ -0,0 +1,113 @@
+QA output created by 085
+mkfs
+mount
+touch files
+godown
+unmount
+logprint after going down...
+dirty log
+mount with replay
+ls SCRATCH_MNT
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
+unmount
+logprint after mount and replay...
+clean log
diff --git a/tests/generic/086 b/tests/generic/086
new file mode 100755
index 0000000..037b81d
--- /dev/null
+++ b/tests/generic/086
@@ -0,0 +1,178 @@
+#! /bin/bash
+# FS QA Test No. 086
+#
+# To test log replay with version 2 logs
+# Initially keep this simple with just creates.
+# In another qa test we can do more e.g. use fsstress.
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
+seqfull=$0
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
+
+# real QA test starts here
+_supported_fs generic
+_supported_os IRIX Linux
+
+rm -f $seqres.full $tmp.*
+_require_scratch
+_require_scratch_shutdown
+
+case "$FSTYP" in
+    xfs)
+        _require_v2log
+        ;;
+    f2fs)
+        _require_dumpf2fs
+esac
+
+# link correct .out file
+_link_out_file_fs $seq.out $seqfull.out
+
+echo "*** init FS"
+umount $SCRATCH_DEV >/dev/null 2>&1
+
+cat >$tmp.seq.params.xfs <<EOF
+# mkfs-opt             mount-opt
+# ------------------------------
+  version=2            logbsize=32k
+  version=2,su=4096    logbsize=32k
+  version=2,su=32768   logbsize=32k
+  version=2,su=32768   logbsize=64k
+  version=2            logbsize=64k
+  version=2,su=64k     logbsize=64k
+  version=2            logbsize=128k
+  version=2,su=128k    logbsize=128k
+  version=2            logbsize=256k
+  version=2,su=256k    logbsize=256k
+EOF
+
+cat >$tmp.seq.params.f2fs <<EOF
+# mkfs-opt  mount-opt
+# ---------------------------
+  test1     active_logs=6,background_gc=off
+  test2     active_logs=6,background_gc=off,inline_data
+  test3     active_logs=6,background_gc=off,inline_dentry
+  test4     active_logs=6,background_gc=off,inline_dentry,inline_data
+  test5     active_logs=6,background_gc=off,disable_roll_forward
+  test6     active_logs=4,background_gc=off
+  test7     active_logs=2,background_gc=off
+EOF
+
+cat $tmp.seq.params.$FSTYP > $tmp.seq.params
+
+# Do the work for various log params which
+# should not effect the data content of the log
+# Try with and without sync'ing - sync'ing will mean that
+# the log will be written out unfilled and thus the log 
+# stripe can have an effect.
+#
+for s in sync nosync ; do
+    cat $tmp.seq.params \
+    | while read mkfs mnt restofline
+    do
+	if [ "$mkfs" = "#" ]; then 
+	    continue
+	fi
+
+	echo "--- mkfs=$mkfs, mnt=$mnt, sync=$s ---"
+	export MKFS_OPTIONS="-l $mkfs"
+	export MOUNT_OPTIONS="-o $mnt"
+
+	# mkfs the FS
+	_echofull "mkfs"
+	_scratch_mkfs >>$seqres.full 2>&1
+	if [ $? -ne 0 ] ; then 
+	    _echofull "mkfs failed: $MKFS_OPTIONS"
+	    continue
+	fi
+
+	# mount the FS
+	_echofull "mount"
+	if ! _scratch_mount >>$seqres.full 2>&1; then
+	    _echofull "mount failed: $MOUNT_OPTIONS"
+	    continue
+	fi
+
+	# create the metadata
+	if [ $s = "sync" ]; then
+	    # generate some log traffic - but not too much
+	    # add some syncs to get the log flushed to disk 
+	    for file in $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}; do
+		touch $file
+		sync
+	    done
+	else
+	    # generate some log traffic - but not too much - life gets a little
+	    # more complicated if the log wraps around. This traffic is
+	    # pretty much arbitary, but could probably be made better than this.
+	    touch $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
+	fi
+
+	# check before on what FS should look like
+	_echofull "ls SCRATCH_MNT"
+	ls $SCRATCH_MNT
+
+	_echofull "godown"
+	src/godown -v -f $SCRATCH_MNT >> $seqres.full
+
+	_echofull "unmount"
+	umount $SCRATCH_DEV >>$seqres.full 2>&1 \
+	    || _fail "umount failed"
+
+	_echofull "logprint after going down..."
+	_print_logstate
+
+	_echofull "mount with replay"
+	_scratch_mount >>$seqres.full 2>&1 \
+	    || _fail "mount failed: $MOUNT_OPTIONS"
+
+	# check on what FS looks like after log recovery
+	_echofull "ls SCRATCH_MNT"
+	ls $SCRATCH_MNT
+
+	_echofull "unmount"
+	umount $SCRATCH_MNT
+
+	_echofull "logprint after mount and replay..."
+	_print_logstate
+
+	if _check_scratch_fs; then
+	    _echofull "filesystem is checked ok"
+	else
+	    _echofull "filesystem is NOT ok"
+	fi
+    done
+done
+
+status=0 
+exit
diff --git a/tests/generic/086.out.f2fs b/tests/generic/086.out.f2fs
new file mode 100644
index 0000000..e090864
--- /dev/null
+++ b/tests/generic/086.out.f2fs
@@ -0,0 +1,3306 @@
+QA output created by 086
+*** init FS
+--- mkfs=test1, mnt=active_logs=6,background_gc=off, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test2, mnt=active_logs=6,background_gc=off,inline_data, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test3, mnt=active_logs=6,background_gc=off,inline_dentry, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test4, mnt=active_logs=6,background_gc=off,inline_dentry,inline_data, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test5, mnt=active_logs=6,background_gc=off,disable_roll_forward, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test6, mnt=active_logs=4,background_gc=off, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test7, mnt=active_logs=2,background_gc=off, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test1, mnt=active_logs=6,background_gc=off, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test2, mnt=active_logs=6,background_gc=off,inline_data, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test3, mnt=active_logs=6,background_gc=off,inline_dentry, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test4, mnt=active_logs=6,background_gc=off,inline_dentry,inline_data, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test5, mnt=active_logs=6,background_gc=off,disable_roll_forward, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test6, mnt=active_logs=4,background_gc=off, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=test7, mnt=active_logs=2,background_gc=off, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
diff --git a/tests/generic/086.out.xfs b/tests/generic/086.out.xfs
new file mode 100644
index 0000000..ac56cc2
--- /dev/null
+++ b/tests/generic/086.out.xfs
@@ -0,0 +1,4722 @@
+QA output created by 086
+*** init FS
+--- mkfs=version=2, mnt=logbsize=32k, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=4096, mnt=logbsize=32k, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=32768, mnt=logbsize=32k, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=32768, mnt=logbsize=64k, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2, mnt=logbsize=64k, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=64k, mnt=logbsize=64k, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2, mnt=logbsize=128k, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=128k, mnt=logbsize=128k, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2, mnt=logbsize=256k, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=256k, mnt=logbsize=256k, sync=sync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2, mnt=logbsize=32k, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=4096, mnt=logbsize=32k, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=32768, mnt=logbsize=32k, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=32768, mnt=logbsize=64k, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2, mnt=logbsize=64k, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=64k, mnt=logbsize=64k, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2, mnt=logbsize=128k, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=128k, mnt=logbsize=128k, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2, mnt=logbsize=256k, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+--- mkfs=version=2,su=256k, mnt=logbsize=256k, sync=nosync ---
+
+*** mkfs ***
+
+
+*** mount ***
+
+
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
+*** ls SCRATCH_MNT ***
+
+00
+01
+02
+03
+04
+05
+06
+07
+08
+09
+10
+11
+12
+13
+14
+15
+16
+17
+18
+19
+20
+21
+22
+23
+24
+25
+26
+27
+28
+29
+30
+31
+32
+33
+34
+35
+36
+37
+38
+39
+40
+41
+42
+43
+44
+45
+46
+47
+48
+49
+50
+51
+52
+53
+54
+55
+56
+57
+58
+59
+60
+61
+62
+63
+64
+65
+66
+67
+68
+69
+70
+71
+72
+73
+74
+75
+76
+77
+78
+79
+80
+81
+82
+83
+84
+85
+86
+87
+88
+89
+90
+91
+92
+93
+94
+95
+96
+97
+98
+99
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
diff --git a/tests/generic/087 b/tests/generic/087
new file mode 100755
index 0000000..75925f9
--- /dev/null
+++ b/tests/generic/087
@@ -0,0 +1,179 @@
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
+seqfull=$0
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
+_supported_fs generic
+_supported_os IRIX Linux
+
+rm -f $seqres.full $tmp.*
+_require_scratch
+_require_scratch_shutdown
+
+case "$FSTYP" in
+    xfs)
+        _require_v2log
+        _require_xfs_quota
+        ;;
+    f2fs)
+        _require_dumpf2fs
+esac
+
+echo "*** init FS"
+umount $SCRATCH_DEV >/dev/null 2>&1
+
+cat >$tmp.seq.params.xfs <<EOF
+# mkfs-opt             mount-opt
+# ------------------------------
+  version=2            uquota,logbsize=32k
+  version=2,su=4096    uquota,logbsize=32k
+  version=2,su=32768   uquota,logbsize=32k
+  version=2            uquota,logbsize=64k
+  version=2,su=64k     uquota,logbsize=64k
+  version=2            uquota,logbsize=128k
+  version=2,su=128k    uquota,logbsize=128k
+  version=2            uquota,logbsize=256k
+  version=2,su=256k    uquota,logbsize=256k
+EOF
+
+cat >$tmp.seq.params.f2fs <<EOF
+# mkfs-opt  mount-opt
+# ---------------------------
+  test1     active_logs=6,background_gc=off
+  test2     active_logs=6,background_gc=off,inline_data
+  test3     active_logs=6,background_gc=off,inline_dentry
+  test4     active_logs=6,background_gc=off,inline_dentry,inline_data
+  test5     active_logs=6,background_gc=off,disable_roll_forward
+  test6     active_logs=4,background_gc=off
+  test7     active_logs=2,background_gc=off
+EOF
+
+cat $tmp.seq.params.$FSTYP > $tmp.seq.params
+
+# link correct .out file
+_link_out_file_fs $seq.out $seqfull.out
+
+cat $tmp.seq.params \
+| while read mkfs mnt restofline
+do
+    if [ "$mkfs" = "#" ]; then 
+	continue
+    fi
+
+    echo "--- mkfs=$mkfs, mnt=$mnt ---"
+    export MKFS_OPTIONS="-l $mkfs"
+    export MOUNT_OPTIONS="-o $mnt"
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
+    _print_logstate
+
+    _full "logprint headers"
+    _scratch_xfs_logprint -n >>$seqres.full 2>&1
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
+    _print_logstate
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
diff --git a/tests/generic/087.out.f2fs b/tests/generic/087.out.f2fs
new file mode 100644
index 0000000..75f9c08
--- /dev/null
+++ b/tests/generic/087.out.f2fs
@@ -0,0 +1,303 @@
+QA output created by 087
+*** init FS
+--- mkfs=test1, mnt=active_logs=6,background_gc=off ---
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
+--- mkfs=test2, mnt=active_logs=6,background_gc=off,inline_data ---
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
+--- mkfs=test3, mnt=active_logs=6,background_gc=off,inline_dentry ---
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
+--- mkfs=test4, mnt=active_logs=6,background_gc=off,inline_dentry,inline_data ---
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
+--- mkfs=test5, mnt=active_logs=6,background_gc=off,disable_roll_forward ---
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
+--- mkfs=test6, mnt=active_logs=4,background_gc=off ---
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
+--- mkfs=test7, mnt=active_logs=2,background_gc=off ---
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
diff --git a/tests/generic/087.out.xfs b/tests/generic/087.out.xfs
new file mode 100644
index 0000000..0743fcc
--- /dev/null
+++ b/tests/generic/087.out.xfs
@@ -0,0 +1,389 @@
+QA output created by 087
+*** init FS
+--- mkfs=version=2, mnt=uquota,logbsize=32k ---
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
+--- mkfs=version=2,su=4096, mnt=uquota,logbsize=32k ---
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
+--- mkfs=version=2,su=32768, mnt=uquota,logbsize=32k ---
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
+--- mkfs=version=2, mnt=uquota,logbsize=64k ---
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
+--- mkfs=version=2,su=64k, mnt=uquota,logbsize=64k ---
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
+--- mkfs=version=2, mnt=uquota,logbsize=128k ---
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
+--- mkfs=version=2,su=128k, mnt=uquota,logbsize=128k ---
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
+--- mkfs=version=2, mnt=uquota,logbsize=256k ---
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
+--- mkfs=version=2,su=256k, mnt=uquota,logbsize=256k ---
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
diff --git a/tests/generic/group b/tests/generic/group
index 122b172..86d10af 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -44,6 +44,7 @@
 039 metadata auto quick
 040 metadata auto quick
 041 metadata auto quick
+051 auto log metadata
 053 acl repair auto quick
 054 auto quick rw
 062 attr udf auto quick
@@ -56,6 +57,9 @@
 077 acl attr auto enospc
 079 acl attr ioctl metadata auto quick
 083 rw auto enospc stress
+085 log auto quick
+086 log v2log auto
+087 log v2log auto quota stress
 088 perms auto quick
 089 metadata auto
 091 rw auto quick
diff --git a/tests/xfs/051 b/tests/xfs/051
deleted file mode 100755
index f2f21f0..0000000
--- a/tests/xfs/051
+++ /dev/null
@@ -1,103 +0,0 @@
-#! /bin/bash
-# FS QA Test No. 051
-#
-# Simulate a buffer use after free race in XFS log recovery. The race triggers
-# on I/O failures during log recovery. Note that this test is dangerous as it
-# causes BUG() errors or a panic.
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2013 Oracle, Inc.  All Rights Reserved.
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
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-	killall -9 $FSSTRESS_PROG > /dev/null 2>&1
-	_scratch_unmount > /dev/null 2>&1
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/dmflakey
-
-# Modify as appropriate.
-_supported_fs generic
-_supported_os Linux
-
-_require_scratch
-_require_scratch_shutdown
-_require_dm_flakey
-
-if [ "$FSTYP" == "xfs" ]; then
-    _require_xfs_sysfs debug/log_recovery_delay
-fi
-
-echo "Silence is golden."
-
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-
-# Start a workload and shutdown the fs. The subsequent mount will require log
-# recovery.
-$FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT > /dev/null 2>&1 &
-sleep 5
-src/godown -f $SCRATCH_MNT
-killall -q $FSSTRESS_PROG
-wait
-_scratch_unmount
-
-# Initialize a dm-flakey device that will pass I/Os for 5s and fail thereafter.
-_init_flakey
-BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
-FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 5 180"
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-
-# Set a 10s log recovery delay and mount the flakey device. This should allow
-# initial writes to proceed (e.g., stale log block reset) and then let the
-# flakey uptime timer expire such that I/Os will fail by the time log recovery
-# starts.
-if [ "$FSTYP" == "xfs" ]; then
-    echo 10 > /sys/fs/xfs/debug/log_recovery_delay
-fi
-
-# The mount should fail due to dm-flakey. Note that this is dangerous on kernels
-# without the xfs_buf log recovery race fixes.
-_mount_flakey > /dev/null 2>&1
-
-if [ "$FSTYP" == "xfs" ]; then
-    echo 0 > /sys/fs/xfs/debug/log_recovery_delay
-fi
-
-_cleanup_flakey
-
-# replay the log
-_scratch_mount
-_scratch_unmount
-
-# success, all done
-status=0
-exit
diff --git a/tests/xfs/051.out b/tests/xfs/051.out
deleted file mode 100644
index 5180bc4..0000000
--- a/tests/xfs/051.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 051
-Silence is golden.
diff --git a/tests/xfs/085 b/tests/xfs/085
deleted file mode 100755
index db394eb..0000000
--- a/tests/xfs/085
+++ /dev/null
@@ -1,98 +0,0 @@
-#! /bin/bash
-# FS QA Test No. 085
-#
-# To test log replay by shutdown of file system
-# This is the first simple initial test to ensure that
-# the goingdown ioctl is working and recovery of
-# create transactions is working.
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.
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
-
-# real QA test starts here
-_supported_fs generic
-_supported_os IRIX Linux
-
-rm -f $seqres.full
-rm -f $tmp.log
-
-_require_scratch
-_require_scratch_shutdown
-
-if [ "$FSTYP" == "f2fs" ]; then
-    _require_dumpf2fs
-fi
-
-echo "mkfs"
-_scratch_mkfs >>$seqres.full 2>&1 \
-    || _fail "mkfs scratch failed"
-
-echo "mount"
-_scratch_mount >>$seqres.full 2>&1 \
-    || _fail "mount failed: $MOUNT_OPTIONS"
-
-echo "touch files"
-touch $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
-
-echo "godown"
-src/godown -v -f $SCRATCH_MNT >> $seqres.full
-
-echo "unmount"
-umount $SCRATCH_MNT
-
-echo "logprint after going down..."
-_print_logstate
-
-# curious if FS consistent at start
-if false; then
-    if _xfs_check $SCRATCH_DEV; then
-       echo "*** checked ok ***"
-    fi
-fi
-
-echo "mount with replay"
-_scratch_mount $mnt >>$seqres.full 2>&1 \
-    || _fail "mount failed: $mnt $MOUNT_OPTIONS"
-
-echo "ls SCRATCH_MNT"
-ls $SCRATCH_MNT
-
-echo "unmount"
-umount $SCRATCH_MNT
-
-echo "logprint after mount and replay..."
-_print_logstate
-
-# success, all done
-status=0
-exit
diff --git a/tests/xfs/085.out b/tests/xfs/085.out
deleted file mode 100644
index d2d99a1..0000000
--- a/tests/xfs/085.out
+++ /dev/null
@@ -1,113 +0,0 @@
-QA output created by 085
-mkfs
-mount
-touch files
-godown
-unmount
-logprint after going down...
-dirty log
-mount with replay
-ls SCRATCH_MNT
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
-unmount
-logprint after mount and replay...
-clean log
diff --git a/tests/xfs/086 b/tests/xfs/086
deleted file mode 100755
index 037b81d..0000000
--- a/tests/xfs/086
+++ /dev/null
@@ -1,178 +0,0 @@
-#! /bin/bash
-# FS QA Test No. 086
-#
-# To test log replay with version 2 logs
-# Initially keep this simple with just creates.
-# In another qa test we can do more e.g. use fsstress.
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
-seqfull=$0
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
-
-# real QA test starts here
-_supported_fs generic
-_supported_os IRIX Linux
-
-rm -f $seqres.full $tmp.*
-_require_scratch
-_require_scratch_shutdown
-
-case "$FSTYP" in
-    xfs)
-        _require_v2log
-        ;;
-    f2fs)
-        _require_dumpf2fs
-esac
-
-# link correct .out file
-_link_out_file_fs $seq.out $seqfull.out
-
-echo "*** init FS"
-umount $SCRATCH_DEV >/dev/null 2>&1
-
-cat >$tmp.seq.params.xfs <<EOF
-# mkfs-opt             mount-opt
-# ------------------------------
-  version=2            logbsize=32k
-  version=2,su=4096    logbsize=32k
-  version=2,su=32768   logbsize=32k
-  version=2,su=32768   logbsize=64k
-  version=2            logbsize=64k
-  version=2,su=64k     logbsize=64k
-  version=2            logbsize=128k
-  version=2,su=128k    logbsize=128k
-  version=2            logbsize=256k
-  version=2,su=256k    logbsize=256k
-EOF
-
-cat >$tmp.seq.params.f2fs <<EOF
-# mkfs-opt  mount-opt
-# ---------------------------
-  test1     active_logs=6,background_gc=off
-  test2     active_logs=6,background_gc=off,inline_data
-  test3     active_logs=6,background_gc=off,inline_dentry
-  test4     active_logs=6,background_gc=off,inline_dentry,inline_data
-  test5     active_logs=6,background_gc=off,disable_roll_forward
-  test6     active_logs=4,background_gc=off
-  test7     active_logs=2,background_gc=off
-EOF
-
-cat $tmp.seq.params.$FSTYP > $tmp.seq.params
-
-# Do the work for various log params which
-# should not effect the data content of the log
-# Try with and without sync'ing - sync'ing will mean that
-# the log will be written out unfilled and thus the log 
-# stripe can have an effect.
-#
-for s in sync nosync ; do
-    cat $tmp.seq.params \
-    | while read mkfs mnt restofline
-    do
-	if [ "$mkfs" = "#" ]; then 
-	    continue
-	fi
-
-	echo "--- mkfs=$mkfs, mnt=$mnt, sync=$s ---"
-	export MKFS_OPTIONS="-l $mkfs"
-	export MOUNT_OPTIONS="-o $mnt"
-
-	# mkfs the FS
-	_echofull "mkfs"
-	_scratch_mkfs >>$seqres.full 2>&1
-	if [ $? -ne 0 ] ; then 
-	    _echofull "mkfs failed: $MKFS_OPTIONS"
-	    continue
-	fi
-
-	# mount the FS
-	_echofull "mount"
-	if ! _scratch_mount >>$seqres.full 2>&1; then
-	    _echofull "mount failed: $MOUNT_OPTIONS"
-	    continue
-	fi
-
-	# create the metadata
-	if [ $s = "sync" ]; then
-	    # generate some log traffic - but not too much
-	    # add some syncs to get the log flushed to disk 
-	    for file in $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}; do
-		touch $file
-		sync
-	    done
-	else
-	    # generate some log traffic - but not too much - life gets a little
-	    # more complicated if the log wraps around. This traffic is
-	    # pretty much arbitary, but could probably be made better than this.
-	    touch $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
-	fi
-
-	# check before on what FS should look like
-	_echofull "ls SCRATCH_MNT"
-	ls $SCRATCH_MNT
-
-	_echofull "godown"
-	src/godown -v -f $SCRATCH_MNT >> $seqres.full
-
-	_echofull "unmount"
-	umount $SCRATCH_DEV >>$seqres.full 2>&1 \
-	    || _fail "umount failed"
-
-	_echofull "logprint after going down..."
-	_print_logstate
-
-	_echofull "mount with replay"
-	_scratch_mount >>$seqres.full 2>&1 \
-	    || _fail "mount failed: $MOUNT_OPTIONS"
-
-	# check on what FS looks like after log recovery
-	_echofull "ls SCRATCH_MNT"
-	ls $SCRATCH_MNT
-
-	_echofull "unmount"
-	umount $SCRATCH_MNT
-
-	_echofull "logprint after mount and replay..."
-	_print_logstate
-
-	if _check_scratch_fs; then
-	    _echofull "filesystem is checked ok"
-	else
-	    _echofull "filesystem is NOT ok"
-	fi
-    done
-done
-
-status=0 
-exit
diff --git a/tests/xfs/086.out.f2fs b/tests/xfs/086.out.f2fs
deleted file mode 100644
index e090864..0000000
--- a/tests/xfs/086.out.f2fs
+++ /dev/null
@@ -1,3306 +0,0 @@
-QA output created by 086
-*** init FS
---- mkfs=test1, mnt=active_logs=6,background_gc=off, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test2, mnt=active_logs=6,background_gc=off,inline_data, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test3, mnt=active_logs=6,background_gc=off,inline_dentry, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test4, mnt=active_logs=6,background_gc=off,inline_dentry,inline_data, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test5, mnt=active_logs=6,background_gc=off,disable_roll_forward, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test6, mnt=active_logs=4,background_gc=off, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test7, mnt=active_logs=2,background_gc=off, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test1, mnt=active_logs=6,background_gc=off, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test2, mnt=active_logs=6,background_gc=off,inline_data, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test3, mnt=active_logs=6,background_gc=off,inline_dentry, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test4, mnt=active_logs=6,background_gc=off,inline_dentry,inline_data, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test5, mnt=active_logs=6,background_gc=off,disable_roll_forward, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test6, mnt=active_logs=4,background_gc=off, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=test7, mnt=active_logs=2,background_gc=off, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
diff --git a/tests/xfs/086.out.xfs b/tests/xfs/086.out.xfs
deleted file mode 100644
index ac56cc2..0000000
--- a/tests/xfs/086.out.xfs
+++ /dev/null
@@ -1,4722 +0,0 @@
-QA output created by 086
-*** init FS
---- mkfs=version=2, mnt=logbsize=32k, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=4096, mnt=logbsize=32k, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=32768, mnt=logbsize=32k, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=32768, mnt=logbsize=64k, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2, mnt=logbsize=64k, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=64k, mnt=logbsize=64k, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2, mnt=logbsize=128k, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=128k, mnt=logbsize=128k, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2, mnt=logbsize=256k, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=256k, mnt=logbsize=256k, sync=sync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2, mnt=logbsize=32k, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=4096, mnt=logbsize=32k, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=32768, mnt=logbsize=32k, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=32768, mnt=logbsize=64k, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2, mnt=logbsize=64k, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=64k, mnt=logbsize=64k, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2, mnt=logbsize=128k, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=128k, mnt=logbsize=128k, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2, mnt=logbsize=256k, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
---- mkfs=version=2,su=256k, mnt=logbsize=256k, sync=nosync ---
-
-*** mkfs ***
-
-
-*** mount ***
-
-
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
-*** ls SCRATCH_MNT ***
-
-00
-01
-02
-03
-04
-05
-06
-07
-08
-09
-10
-11
-12
-13
-14
-15
-16
-17
-18
-19
-20
-21
-22
-23
-24
-25
-26
-27
-28
-29
-30
-31
-32
-33
-34
-35
-36
-37
-38
-39
-40
-41
-42
-43
-44
-45
-46
-47
-48
-49
-50
-51
-52
-53
-54
-55
-56
-57
-58
-59
-60
-61
-62
-63
-64
-65
-66
-67
-68
-69
-70
-71
-72
-73
-74
-75
-76
-77
-78
-79
-80
-81
-82
-83
-84
-85
-86
-87
-88
-89
-90
-91
-92
-93
-94
-95
-96
-97
-98
-99
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
diff --git a/tests/xfs/087 b/tests/xfs/087
deleted file mode 100755
index 75925f9..0000000
--- a/tests/xfs/087
+++ /dev/null
@@ -1,179 +0,0 @@
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
-seqfull=$0
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
-_supported_fs generic
-_supported_os IRIX Linux
-
-rm -f $seqres.full $tmp.*
-_require_scratch
-_require_scratch_shutdown
-
-case "$FSTYP" in
-    xfs)
-        _require_v2log
-        _require_xfs_quota
-        ;;
-    f2fs)
-        _require_dumpf2fs
-esac
-
-echo "*** init FS"
-umount $SCRATCH_DEV >/dev/null 2>&1
-
-cat >$tmp.seq.params.xfs <<EOF
-# mkfs-opt             mount-opt
-# ------------------------------
-  version=2            uquota,logbsize=32k
-  version=2,su=4096    uquota,logbsize=32k
-  version=2,su=32768   uquota,logbsize=32k
-  version=2            uquota,logbsize=64k
-  version=2,su=64k     uquota,logbsize=64k
-  version=2            uquota,logbsize=128k
-  version=2,su=128k    uquota,logbsize=128k
-  version=2            uquota,logbsize=256k
-  version=2,su=256k    uquota,logbsize=256k
-EOF
-
-cat >$tmp.seq.params.f2fs <<EOF
-# mkfs-opt  mount-opt
-# ---------------------------
-  test1     active_logs=6,background_gc=off
-  test2     active_logs=6,background_gc=off,inline_data
-  test3     active_logs=6,background_gc=off,inline_dentry
-  test4     active_logs=6,background_gc=off,inline_dentry,inline_data
-  test5     active_logs=6,background_gc=off,disable_roll_forward
-  test6     active_logs=4,background_gc=off
-  test7     active_logs=2,background_gc=off
-EOF
-
-cat $tmp.seq.params.$FSTYP > $tmp.seq.params
-
-# link correct .out file
-_link_out_file_fs $seq.out $seqfull.out
-
-cat $tmp.seq.params \
-| while read mkfs mnt restofline
-do
-    if [ "$mkfs" = "#" ]; then 
-	continue
-    fi
-
-    echo "--- mkfs=$mkfs, mnt=$mnt ---"
-    export MKFS_OPTIONS="-l $mkfs"
-    export MOUNT_OPTIONS="-o $mnt"
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
-    _print_logstate
-
-    _full "logprint headers"
-    _scratch_xfs_logprint -n >>$seqres.full 2>&1
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
-    _print_logstate
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
diff --git a/tests/xfs/087.out.f2fs b/tests/xfs/087.out.f2fs
deleted file mode 100644
index 75f9c08..0000000
--- a/tests/xfs/087.out.f2fs
+++ /dev/null
@@ -1,303 +0,0 @@
-QA output created by 087
-*** init FS
---- mkfs=test1, mnt=active_logs=6,background_gc=off ---
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
---- mkfs=test2, mnt=active_logs=6,background_gc=off,inline_data ---
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
---- mkfs=test3, mnt=active_logs=6,background_gc=off,inline_dentry ---
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
---- mkfs=test4, mnt=active_logs=6,background_gc=off,inline_dentry,inline_data ---
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
---- mkfs=test5, mnt=active_logs=6,background_gc=off,disable_roll_forward ---
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
---- mkfs=test6, mnt=active_logs=4,background_gc=off ---
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
---- mkfs=test7, mnt=active_logs=2,background_gc=off ---
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
diff --git a/tests/xfs/087.out.xfs b/tests/xfs/087.out.xfs
deleted file mode 100644
index 0743fcc..0000000
--- a/tests/xfs/087.out.xfs
+++ /dev/null
@@ -1,389 +0,0 @@
-QA output created by 087
-*** init FS
---- mkfs=version=2, mnt=uquota,logbsize=32k ---
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
---- mkfs=version=2,su=4096, mnt=uquota,logbsize=32k ---
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
---- mkfs=version=2,su=32768, mnt=uquota,logbsize=32k ---
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
---- mkfs=version=2, mnt=uquota,logbsize=64k ---
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
---- mkfs=version=2,su=64k, mnt=uquota,logbsize=64k ---
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
---- mkfs=version=2, mnt=uquota,logbsize=128k ---
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
---- mkfs=version=2,su=128k, mnt=uquota,logbsize=128k ---
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
---- mkfs=version=2, mnt=uquota,logbsize=256k ---
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
---- mkfs=version=2,su=256k, mnt=uquota,logbsize=256k ---
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
index 4099793..5781de1 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -48,7 +48,6 @@
 048 other auto quick
 049 rw auto quick
 050 quota auto quick
-051 auto log metadata
 052 quota db auto quick
 054 quota auto quick
 055 dump ioctl remote tape
@@ -73,9 +72,6 @@
 081 deprecated # log logprint quota
 082 deprecated # log logprint v2log
 084 ioctl rw auto
-085 log auto quick
-086 log v2log auto
-087 log v2log auto quota stress
 090 rw auto
 092 other auto quick
 094 metadata dir ioctl auto
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
