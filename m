Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:54293 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757595AbaISTfP (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 19 Sep 2014 15:35:15 -0400
Message-ID: <541C8571.6090201@sandeen.net>
Date: Fri, 19 Sep 2014 14:35:13 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: [PATCH 4.5/5] generic: tidy up mmap write vs truncate/remap test
References: <1410918113-23516-1-git-send-email-david@fromorbit.com> <1410918113-23516-5-git-send-email-david@fromorbit.com>
In-Reply-To: <1410918113-23516-5-git-send-email-david@fromorbit.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Some minor changes to 030 as sent, to:

1) differentiate which tests failed in the output hunks, and
2) remove extraneous operations from the last test.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/030 b/tests/generic/030
old mode 100644
new mode 100755
index 9947b96..8bb50bd
--- a/tests/generic/030
+++ b/tests/generic/030
@@ -72,10 +72,10 @@ $XFS_IO_PROG -t -f \
 -c "close"      \
 $testfile | _filter_xfs_io
 
-echo "==== Pre-Remount ==="
+echo "==== Pre-Remount 1 ==="
 hexdump -C $testfile
 _scratch_remount
-echo "==== Post-Remount =="
+echo "==== Post-Remount 1 =="
 hexdump -C $testfile
 
 rm -f $testfile
@@ -101,10 +101,10 @@ $XFS_IO_PROG -t -f \
 -c "close"      \
 $testfile | _filter_xfs_io
 
-echo "==== Pre-Remount ==="
+echo "==== Pre-Remount 2 ==="
 hexdump -C $testfile
 _scratch_remount
-echo "==== Post-Remount =="
+echo "==== Post-Remount 2 =="
 hexdump -C $testfile
 
 # third case is the same as the first, but this time on unaligned byte
@@ -115,32 +115,21 @@ $XFS_IO_PROG -t -f \
 -c "truncate 5136912" \
 -c "pwrite -S 0x58 0 5136912" \
 -c "mmap -rw 0 5136912" \
--c "mremap 5136912" \
--c "truncate 5136912" \
 -c "truncate 5139720" \
 -c "mremap -m 5139720" \
 -c "mwrite -S 0 5136912 2808" \
--c "mwrite -S 0 5136912 2808" \
--c "mwrite -S 0 5136912 2808" \
 -c "mremap 5136912 " \
 -c "truncate 5136912" \
 -c "truncate 5139720" \
 -c "mremap -m 5139720" \
--c "mwrite -S 0 5136912 2808" \
--c "mwrite -S 0 5136912 2808" \
 -c "mwrite -S 0x59 5136912 2808" \
--c "truncate 5140480" \
--c "mremap 5140480" \
--c "msync -s 0 5140480" \
--c "mremap 5139720" \
--c "munmap" \
 -c "close" \
 $testfile | _filter_xfs_io
 
-echo "==== Pre-Remount ==="
+echo "==== Pre-Remount 3 ==="
 hexdump -C $testfile
 _scratch_remount
-echo "==== Post-Remount =="
+echo "==== Post-Remount 3 =="
 hexdump -C $testfile
 
 status=0
diff --git a/tests/generic/030.out b/tests/generic/030.out
index 20f6561..b3a17e5 100644
--- a/tests/generic/030.out
+++ b/tests/generic/030.out
@@ -1,13 +1,13 @@
 QA output created by 030
 wrote 5137408/5137408 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-==== Pre-Remount ===
+==== Pre-Remount 1 ===
 00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
 *
 004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
 *
 004e7000
-==== Post-Remount ==
+==== Post-Remount 1 ==
 00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
 *
 004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
@@ -15,7 +15,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 004e7000
 wrote 5137408/5137408 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-==== Pre-Remount ===
+==== Pre-Remount 2 ===
 00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
 *
 004e6000  5a 5a 5a 5a 5a 5a 5a 5a  5a 5a 5a 5a 5a 5a 5a 5a  |ZZZZZZZZZZZZZZZZ|
@@ -23,7 +23,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
 *
 004e7000
-==== Post-Remount ==
+==== Post-Remount 2 ==
 00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
 *
 004e6000  5a 5a 5a 5a 5a 5a 5a 5a  5a 5a 5a 5a 5a 5a 5a 5a  |ZZZZZZZZZZZZZZZZ|
@@ -33,7 +33,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 004e7000
 wrote 5136912/5136912 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-==== Pre-Remount ===
+==== Pre-Remount 3 ===
 00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
 *
 004e6210  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
@@ -42,7 +42,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 004e6d10  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
 004e7000
-==== Post-Remount ==
+==== Post-Remount 3 ==
 00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
 *
 004e6210  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|


