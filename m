Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:42895 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaLOW5H (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 17:57:07 -0500
Received: by mail-wi0-f169.google.com with SMTP id r20so12030401wiv.4
        for <fstests@vger.kernel.org>; Mon, 15 Dec 2014 14:57:05 -0800 (PST)
Received: from [192.168.0.2] (178-222-112-234.dynamic.isp.telekom.rs. [178.222.112.234])
        by mx.google.com with ESMTPSA id et4sm14677620wjd.15.2014.12.15.14.57.04
        for <fstests@vger.kernel.org>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Dec 2014 14:57:05 -0800 (PST)
Date: Tue, 16 Dec 2014 01:57:29 +0100 (CET)
From: Dushan Tcholich <dusanc@gmail.com>
Subject: [PATCH] xfstests: unify _require_batched_discard
Message-ID: <alpine.LNX.2.00.1412160142370.862@reiser4.gekom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

To check for FITRIM tests used  _require_fstrim() and 
_test_batched_discard() 
but as _test_batched_discard() already includes _test_fstrim() unify 
FSTRIM 
check throughout xfstests with _require_batched_discard().

Signed-off-by: Dushan Tcholich <dusanc@gmail.com>

--- xfstests.orig/common/rc	2014-12-16 00:33:28.000000000 +0100
+++ xfstests.1/common/rc	2014-12-16 01:30:05.000000000 +0100
@@ -2336,14 +2336,14 @@
 	fi
 }
 
-_test_batched_discard()
+_require_batched_discard()
 {
 	if [ $# -ne 1 ]; then
-		echo "Usage: _test_batched_discard mnt_point" 1>&2
+		echo "Usage: _require_batched_discard mnt_point" 1>&2
 		exit 1
 	fi
 	_require_fstrim
-	$FSTRIM_PROG ${1} &>/dev/null
+	[$FSTRIM_PROG $1 > /dev/null 2>&1] || _notrun "FITRIM not supported on $1"
 }
 
 _require_dumpe2fs()
diff -urN xfstests.orig/tests/generic/038 xfstests.1/tests/generic/038
--- xfstests.orig/tests/generic/038	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.1/tests/generic/038	2014-12-16 01:31:23.000000000 +0100
@@ -69,7 +69,6 @@
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_fstrim
 
 rm -f $seqres.full
 
@@ -123,6 +122,7 @@
 _scratch_mkfs >>$seqres.full 2>&1
 _require_fs_space $SCRATCH_MNT $((10 * 1024 * 1024))
 _scratch_mount
+_require_batched_discard $SCRATCH_MNT
 
 for ((i = 0; i < $((4 * $LOAD_FACTOR)); i++)); do
 	trim_loop &
diff -urN xfstests.orig/tests/generic/251 xfstests.1/tests/generic/251
--- xfstests.orig/tests/generic/251	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.1/tests/generic/251	2014-12-16 01:32:22.000000000 +0100
@@ -43,9 +43,9 @@
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_fstrim
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
+_require_batched_discard $SCRATCH_MNT
 
 _cleanup()
 {
@@ -150,11 +150,6 @@
 nproc=20
 content=$here
 
-# Check for FITRIM support
-echo -n "Checking FITRIM support: "
-_test_batched_discard $SCRATCH_MNT || _notrun "FITRIM not supported on $SCRATCH_DEV"
-echo "done."
-
 mkdir -p $tmp
 
 (
diff -urN xfstests.orig/tests/generic/251.out xfstests.1/tests/generic/251.out
--- xfstests.orig/tests/generic/251.out	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.1/tests/generic/251.out	2014-12-16 01:53:09.000000000 +0100
@@ -1,3 +1,2 @@
 QA output created by 251
-Checking FITRIM support: done.
 Running the test: done.
diff -urN xfstests.orig/tests/generic/260 xfstests.1/tests/generic/260
--- xfstests.orig/tests/generic/260	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.1/tests/generic/260	2014-12-16 01:32:45.000000000 +0100
@@ -40,13 +40,12 @@
 _supported_fs generic
 _supported_os Linux
 _require_math
-_require_fstrim
 
 _require_scratch
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_test_batched_discard $SCRATCH_MNT || _notrun "FITRIM not supported on $SCRATCH_DEV"
+_require_batched_discard $SCRATCH_MNT
 
 fssize=$($DF_PROG -k | grep "$SCRATCH_MNT" | grep "$SCRATCH_DEV"  | awk '{print $3}')
 
diff -urN xfstests.orig/tests/generic/288 xfstests.1/tests/generic/288
--- xfstests.orig/tests/generic/288	2014-12-16 00:33:30.000000000 +0100
+++ xfstests.1/tests/generic/288	2014-12-16 01:33:08.000000000 +0100
@@ -36,12 +36,11 @@
 _supported_fs generic
 _supported_os Linux
 
-_require_fstrim
 _require_scratch
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
-_test_batched_discard $SCRATCH_MNT || _notrun "FITRIM not supported on $SCRATCH_DEV"
+_require_batched_discard $SCRATCH_MNT
 
 echo "[+] Length is zero (should fail)"
 out=$("$FSTRIM_PROG" -v -o0 -l0 $SCRATCH_MNT 2>&1)
