Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:38985 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbaLOXjD (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 18:39:03 -0500
Received: by mail-wg0-f42.google.com with SMTP id z12so16001650wgg.1
        for <fstests@vger.kernel.org>; Mon, 15 Dec 2014 15:39:01 -0800 (PST)
Received: from [192.168.0.2] (178-222-112-234.dynamic.isp.telekom.rs. [178.222.112.234])
        by mx.google.com with ESMTPSA id bj3sm14881045wib.3.2014.12.15.15.39.00
        for <fstests@vger.kernel.org>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Dec 2014 15:39:00 -0800 (PST)
Date: Tue, 16 Dec 2014 02:39:30 +0100 (CET)
From: Dushan Tcholich <dusanc@gmail.com>
Subject: [PATCH v2] Check O_DIRECT support before testing direct I/O
Message-ID: <alpine.LNX.2.00.1412160233180.862@reiser4.gekom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Some filesystems do not support O_DIRECT.  Check whether TEST_DIR supports
it by running xfs_io with -d flag.

v1: initial implementation
v2: removed unnecessary check for buffered IO

From: Junho Ryu <jayr@google.com
Signed-off-by: Junho Ryu <jayr@google.com>
Signed-off-by: Dushan Tcholich <dusanc@gmail.com> 

---

diff -urN xfstests.orig/common/rc xfstests.2/common/rc
--- xfstests.orig/common/rc	2014-12-16 00:33:28.000000000 +0100
+++ xfstests.2/common/rc	2014-12-16 02:24:15.000000000 +0100
@@ -1391,6 +1391,7 @@
         AIO_TEST=src/aio-dio-regress/$1
         [ -x $AIO_TEST ] || _notrun "$AIO_TEST not built"
     fi
+    _require_odirect
 }
 
 # run an aio-dio program
@@ -1519,6 +1520,17 @@
 		_notrun "xfs_io $command failed (old kernel/wrong fs?)"
 }
 
+# check that kernel and filesystem support direct I/O
+_require_odirect()
+{
+       testfile=$TEST_DIR/$$.direct
+       $XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile 2>&1
+       if [ $? -ne 0 ]; then
+               _notrun "O_DIRECT is not supported"
+       fi
+       rm -f $testfile 2>&1 > /dev/null
+}
+
 # Check that a fs has enough free space (in 1024b blocks)
 #
 _require_fs_space()
diff -urN xfstests.orig/tests/generic/091 xfstests.2/tests/generic/091
--- xfstests.orig/tests/generic/091	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.2/tests/generic/091	2014-12-16 02:21:50.000000000 +0100
@@ -39,6 +39,7 @@
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_odirect
 
 rm -f $seqres.full
 
diff -urN xfstests.orig/tests/generic/130 xfstests.2/tests/generic/130
--- xfstests.orig/tests/generic/130	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.2/tests/generic/130	2014-12-16 02:21:50.000000000 +0100
@@ -50,6 +50,7 @@
 
 _require_scratch
 _require_sparse_files
+_require_odirect
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
diff -urN xfstests.orig/tests/generic/133 xfstests.2/tests/generic/133
--- xfstests.orig/tests/generic/133	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.2/tests/generic/133	2014-12-16 02:21:50.000000000 +0100
@@ -39,6 +39,7 @@
 _supported_fs generic
 _supported_os Linux IRIX
 _require_test
+_require_odirect
 
 echo "Buffered writer, buffered reader"
 $XFS_IO_PROG -f -d -c 'pwrite -b 64k 0 512m' $TEST_DIR/io_test > /dev/null
diff -urN xfstests.orig/tests/generic/135 xfstests.2/tests/generic/135
--- xfstests.orig/tests/generic/135	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.2/tests/generic/135	2014-12-16 02:21:50.000000000 +0100
@@ -39,6 +39,7 @@
 _supported_fs generic
 _supported_os Linux IRIX
 
+_require_odirect
 _require_scratch
 _scratch_mkfs >/dev/null 2>&1
 
diff -urN xfstests.orig/tests/generic/226 xfstests.2/tests/generic/226
--- xfstests.orig/tests/generic/226	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.2/tests/generic/226	2014-12-16 02:21:50.000000000 +0100
@@ -37,6 +37,7 @@
 _supported_fs generic
 _supported_os Linux IRIX
 _require_scratch
+_require_odirect
 
 # real QA test starts here
 rm -f $seqres.full
diff -urN xfstests.orig/tests/generic/263 xfstests.2/tests/generic/263
--- xfstests.orig/tests/generic/263	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.2/tests/generic/263	2014-12-16 02:21:50.000000000 +0100
@@ -39,6 +39,7 @@
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_odirect
 
 rm -f $seqres.full
 
diff -urN xfstests.orig/tests/generic/299 xfstests.2/tests/generic/299
--- xfstests.orig/tests/generic/299	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.2/tests/generic/299	2014-12-16 02:21:50.000000000 +0100
@@ -43,6 +43,7 @@
 _supported_os Linux
 _need_to_be_root
 _require_scratch
+_require_odirect
 
 NUM_JOBS=$((4*LOAD_FACTOR))
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
diff -urN xfstests.orig/tests/generic/300 xfstests.2/tests/generic/300
--- xfstests.orig/tests/generic/300	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.2/tests/generic/300	2014-12-16 02:21:50.000000000 +0100
@@ -43,6 +43,7 @@
 _supported_os Linux
 _need_to_be_root
 _require_scratch
+_require_odirect
 
 # xfs_io is not required for this test, but it's the best way to verify
 # the test system supports fallocate() for allocation and hole punching
