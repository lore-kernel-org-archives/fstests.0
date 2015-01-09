Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41593 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754753AbbAILw7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 9 Jan 2015 06:52:59 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2 v3] xfs/087: test f2fs selectively
Date: Fri,  9 Jan 2015 03:52:45 -0800
Message-Id: <1420804366-85126-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch add the f2fs support for xfs/087 with goingdown.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/rc              |  10 +
 tests/xfs/087          |  53 +++--
 tests/xfs/087.out      | 389 ---------------------------------
 tests/xfs/087.out.f2fs | 583 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/087.out.xfs  | 389 +++++++++++++++++++++++++++++++++
 5 files changed, 1019 insertions(+), 405 deletions(-)
 delete mode 100644 tests/xfs/087.out
 create mode 100644 tests/xfs/087.out.f2fs
 create mode 100644 tests/xfs/087.out.xfs

diff --git a/common/rc b/common/rc
index 5ce3322..2a50378 100644
--- a/common/rc
+++ b/common/rc
@@ -2091,6 +2091,16 @@ _link_out_file()
 	fi
 }
 
+_link_out_file_fs()
+{
+	if [ -z "$1" -o -z "$2" ]; then
+		echo Error must pass src and dst.
+		exit
+	fi
+	rm -f $2
+	ln -s $1.$FSTYP $2
+}
+
 _die()
 {
         echo $@
diff --git a/tests/xfs/087 b/tests/xfs/087
index 3a3fb49..9017bfd 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -24,6 +24,7 @@
 #-----------------------------------------------------------------------
 #
 
+seqfull=$0
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -54,31 +55,51 @@ _do_meta()
 }
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs xfs f2fs
 _supported_os IRIX Linux
 
 rm -f $seqres.full $tmp.*
 _require_scratch
-_require_v2log 
-_require_xfs_quota
+
+if [ "$FSTYP" == "xfs" ]; then
+    _require_v2log
+    _require_xfs_quota
+fi
 
 echo "*** init FS"
 umount $SCRATCH_DEV >/dev/null 2>&1
 
-cat >$tmp.seq.params <<EOF
+cat >$tmp.seq.params.xfs <<EOF
 # mkfs-opt             mount-opt
 # ------------------------------
-  version=2            logbsize=32k
-  version=2,su=4096    logbsize=32k
-  version=2,su=32768   logbsize=32k
-  version=2            logbsize=64k
-  version=2,su=64k     logbsize=64k
-  version=2            logbsize=128k
-  version=2,su=128k    logbsize=128k
-  version=2            logbsize=256k
-  version=2,su=256k    logbsize=256k
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
 EOF
 
+cat $tmp.seq.params.$FSTYP > $tmp.seq.params
+
+# link correct .out file
+_link_out_file_fs $seq.out $seqfull.out
+
 cat $tmp.seq.params \
 | while read mkfs mnt restofline
 do
@@ -92,7 +113,7 @@ do
 
     # mkfs the FS
     _echofull "mkfs"
-    _scratch_mkfs_xfs >>$seqres.full 2>&1
+    _scratch_mkfs >>$seqres.full 2>&1
     if [ $? -ne 0 ] ; then 
 	_echofull "mkfs failed: $MKFS_OPTIONS"
 	continue
@@ -100,7 +121,7 @@ do
 
     # mount the FS
     _echofull "mount"
-    if ! _scratch_mount -o uquota >>$seqres.full 2>&1; then
+    if ! _scratch_mount >>$seqres.full 2>&1; then
 	_echofull "mount failed: $MOUNT_OPTIONS"
 	continue
     fi
@@ -126,7 +147,7 @@ do
     _scratch_xfs_logprint -n >>$seqres.full 2>&1
 
     _echofull "mount with replay"
-    _scratch_mount -o uquota >>$seqres.full 2>&1 \
+    _scratch_mount >>$seqres.full 2>&1 \
 	|| _fail "mount failed: $MOUNT_OPTIONS"
 
     # check on what FS looks like after log recovery
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
diff --git a/tests/xfs/087.out.f2fs b/tests/xfs/087.out.f2fs
new file mode 100644
index 0000000..f84d6cf
--- /dev/null
+++ b/tests/xfs/087.out.f2fs
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
diff --git a/tests/xfs/087.out.xfs b/tests/xfs/087.out.xfs
new file mode 100644
index 0000000..9f009c0
--- /dev/null
+++ b/tests/xfs/087.out.xfs
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
-- 
2.1.1

