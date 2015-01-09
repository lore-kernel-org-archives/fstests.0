Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41622 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932340AbbAILxF (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 9 Jan 2015 06:53:05 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2 v3] xfs/087: move to shared/087
Date: Fri,  9 Jan 2015 03:52:46 -0800
Message-Id: <1420804366-85126-2-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1420804366-85126-1-git-send-email-jaegeuk@kernel.org>
References: <1420804366-85126-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch moves xfs/087 to shared/.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/shared/087          | 174 ++++++++++++++
 tests/shared/087.out.f2fs | 583 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/shared/087.out.xfs  | 389 +++++++++++++++++++++++++++++++
 tests/shared/group        |   1 +
 tests/xfs/087             | 174 --------------
 tests/xfs/087.out.f2fs    | 583 ----------------------------------------------
 tests/xfs/087.out.xfs     | 389 -------------------------------
 tests/xfs/group           |   1 -
 8 files changed, 1147 insertions(+), 1147 deletions(-)
 create mode 100755 tests/shared/087
 create mode 100644 tests/shared/087.out.f2fs
 create mode 100644 tests/shared/087.out.xfs
 delete mode 100755 tests/xfs/087
 delete mode 100644 tests/xfs/087.out.f2fs
 delete mode 100644 tests/xfs/087.out.xfs

diff --git a/tests/shared/087 b/tests/shared/087
new file mode 100755
index 0000000..9017bfd
--- /dev/null
+++ b/tests/shared/087
@@ -0,0 +1,174 @@
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
diff --git a/tests/shared/087.out.f2fs b/tests/shared/087.out.f2fs
new file mode 100644
index 0000000..f84d6cf
--- /dev/null
+++ b/tests/shared/087.out.f2fs
@@ -0,0 +1,583 @@
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
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
+    external log device not specified
+
+Usage: xfs_logprint [options...] <device>
+
+Options:
+    -c	            try to continue if error found in log
+    -C <filename>   copy the log from the filesystem to filename
+    -d	            dump the log in log-record format
+    -e	            exit when an error is found in the log
+    -f	            specified device is actually a file
+    -l <device>     filename of external log
+    -n	            don't try and interpret log data
+    -o	            print buffer data in hex
+    -s <start blk>  block # to start printing
+    -v              print "overwrite" data
+    -t	            print out transactional view
+	-b          in transactional view, extract buffer info
+	-i          in transactional view, extract inode info
+	-q          in transactional view, extract quota info
+    -D              print only data; no decoding
+    -V              print version information
+
+*** filesystem is checked ok ***
+
diff --git a/tests/shared/087.out.xfs b/tests/shared/087.out.xfs
new file mode 100644
index 0000000..9f009c0
--- /dev/null
+++ b/tests/shared/087.out.xfs
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
index 429f2b4..c6e702d 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -6,6 +6,7 @@
 006 auto enospc
 032 mkfs auto quick
 051 acl udf auto quick
+087 log v2log auto quota stress
 272 auto enospc rw
 289 auto quick
 298 auto trim
diff --git a/tests/xfs/087 b/tests/xfs/087
deleted file mode 100755
index 9017bfd..0000000
--- a/tests/xfs/087
+++ /dev/null
@@ -1,174 +0,0 @@
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
index f84d6cf..0000000
--- a/tests/xfs/087.out.f2fs
+++ /dev/null
@@ -1,583 +0,0 @@
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
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
-    external log device not specified
-
-Usage: xfs_logprint [options...] <device>
-
-Options:
-    -c	            try to continue if error found in log
-    -C <filename>   copy the log from the filesystem to filename
-    -d	            dump the log in log-record format
-    -e	            exit when an error is found in the log
-    -f	            specified device is actually a file
-    -l <device>     filename of external log
-    -n	            don't try and interpret log data
-    -o	            print buffer data in hex
-    -s <start blk>  block # to start printing
-    -v              print "overwrite" data
-    -t	            print out transactional view
-	-b          in transactional view, extract buffer info
-	-i          in transactional view, extract inode info
-	-q          in transactional view, extract quota info
-    -D              print only data; no decoding
-    -V              print version information
-
-*** filesystem is checked ok ***
-
diff --git a/tests/xfs/087.out.xfs b/tests/xfs/087.out.xfs
deleted file mode 100644
index 9f009c0..0000000
--- a/tests/xfs/087.out.xfs
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

