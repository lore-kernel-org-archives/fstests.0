Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:43054 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbaLOVDI (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 16:03:08 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so10225833wiw.14
        for <fstests@vger.kernel.org>; Mon, 15 Dec 2014 13:03:06 -0800 (PST)
Received: from [192.168.0.2] (178-222-112-234.dynamic.isp.telekom.rs. [178.222.112.234])
        by mx.google.com with ESMTPSA id gf6sm14412431wjc.11.2014.12.15.13.03.05
        for <fstests@vger.kernel.org>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Dec 2014 13:03:05 -0800 (PST)
Date: Tue, 16 Dec 2014 00:03:35 +0100 (CET)
From: Dushan Tcholich <dusanc@gmail.com>
Subject: [PATCH] Check O_DIRECT support before testing direct I/O
Message-ID: <alpine.LNX.2.00.1412152332120.21847@reiser4.gekom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


In december 2013 Juhno Ryu posted a patch xfstests: check O_DIRECT 
support before testing direct I/O to xfs@oss.sgi.com 
http://oss.sgi.com/archives/xfs/2013-12/msg00759.html

As there are no archives of fstests m-l I couldn't find why his 
patches weren't applied so apologise if this is innapropriate but  
I rebased his patch upon current xfstests code:

---

Some filesystems do not support O_DIRECT.  Check whether TEST_DIR supports 
it by running xfs_io with and without -d flag.

Signed-off-by: Junho Ryu <jayr@google.com>
Signed-off-by: Dushan Tcholich <dusanc@gmail.com>

---


--- xfstests.orig/common/rc	2014-12-14 15:17:59.000000000 +0100
+++ xfstests/common/rc	2014-12-15 19:40:36.000000000 +0100
@@ -1391,6 +1395,7 @@
         AIO_TEST=src/aio-dio-regress/$1
         [ -x $AIO_TEST ] || _notrun "$AIO_TEST not built"
     fi
+    _require_odirect
 }
 
 # run an aio-dio program
@@ -1519,6 +1524,20 @@
 		_notrun "xfs_io $command failed (old kernel/wrong fs?)"
 }
 
+# check that kernel and filesystem support direct I/O
+_require_odirect()
+{
+       testfile=$TEST_DIR/$$.direct
+       $XFS_IO_PROG -F -f -c "pwrite 0 20k" $testfile 2>&1
+       if [ $? -eq 0 ]; then
+               $XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile 2>&1
+               if [ $? -ne 0 ]; then
+                       _notrun "O_DIRECT is not supported"
+               fi
+       fi
+       rm -f $testfile 2>&1 > /dev/null
+}
+
 # Check that a fs has enough free space (in 1024b blocks)
 #
 _require_fs_space()

diff -urN xfstests.orig/tests/generic/091 xfstests/tests/generic/091
--- xfstests.orig/tests/generic/091	2014-12-14 15:18:00.000000000 +0100
+++ xfstests/tests/generic/091	2014-12-14 13:25:10.000000000 +0100
@@ -39,6 +39,7 @@
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_odirect
 
 rm -f $seqres.full

diff -urN xfstests.orig/tests/generic/130 xfstests/tests/generic/130
--- xfstests.orig/tests/generic/130	2014-12-14 15:18:00.000000000 +0100
+++ xfstests/tests/generic/130	2014-12-14 13:24:50.000000000 +0100
@@ -50,6 +50,7 @@
 
 _require_scratch
 _require_sparse_files
+_require_odirect
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
diff -urN xfstests.orig/tests/generic/133 xfstests/tests/generic/133
--- xfstests.orig/tests/generic/133	2014-12-14 15:18:00.000000000 +0100
+++ xfstests/tests/generic/133	2014-12-14 13:25:43.000000000 +0100
@@ -39,6 +39,7 @@
 _supported_fs generic
 _supported_os Linux IRIX
 _require_test
+_require_odirect
 
 echo "Buffered writer, buffered reader"
 $XFS_IO_PROG -f -d -c 'pwrite -b 64k 0 512m' $TEST_DIR/io_test > /dev/null
diff -urN xfstests.orig/tests/generic/135 xfstests/tests/generic/135
--- xfstests.orig/tests/generic/135	2014-12-14 15:18:00.000000000 +0100
+++ xfstests/tests/generic/135	2014-12-14 13:22:52.000000000 +0100
@@ -39,6 +39,7 @@
 _supported_fs generic
 _supported_os Linux IRIX
 
+_require_odirect
 _require_scratch
 _scratch_mkfs >/dev/null 2>&1
 
diff -urN xfstests.orig/tests/generic/226 xfstests/tests/generic/226
--- xfstests.orig/tests/generic/226	2014-12-14 15:18:00.000000000 +0100
+++ xfstests/tests/generic/226	2014-12-14 13:22:52.000000000 +0100
@@ -37,6 +37,7 @@
 _supported_fs generic
 _supported_os Linux IRIX
 _require_scratch
+_require_odirect
 
 # real QA test starts here
 rm -f $seqres.full
diff -urN xfstests.orig/tests/generic/263 xfstests/tests/generic/263
--- xfstests.orig/tests/generic/263	2014-12-14 15:18:00.000000000 +0100
+++ xfstests/tests/generic/263	2014-12-14 13:26:23.000000000 +0100
@@ -39,6 +39,7 @@
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_odirect
 
 rm -f $seqres.full
 
diff -urN xfstests.orig/tests/generic/299 xfstests/tests/generic/299
--- xfstests.orig/tests/generic/299	2014-12-14 15:18:00.000000000 +0100
+++ xfstests/tests/generic/299	2014-12-14 13:22:52.000000000 +0100
@@ -43,6 +43,7 @@
 _supported_os Linux
 _need_to_be_root
 _require_scratch
+_require_odirect
 
 NUM_JOBS=$((4*LOAD_FACTOR))
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
diff -urN xfstests.orig/tests/generic/300 xfstests/tests/generic/300
--- xfstests.orig/tests/generic/300	2014-12-14 15:18:00.000000000 +0100
+++ xfstests/tests/generic/300	2014-12-14 13:22:52.000000000 +0100
@@ -43,6 +43,7 @@
 _supported_os Linux
 _need_to_be_root
 _require_scratch
+_require_odirect
 
 # xfs_io is not required for this test, but it's the best way to verify
 # the test system supports fallocate() for allocation and hole punching
