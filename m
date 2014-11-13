Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933762AbaKMXv0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 13 Nov 2014 18:51:26 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sADNpPH6018221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 13 Nov 2014 18:51:25 -0500
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sADNpONt011276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <fstests@vger.kernel.org>; Thu, 13 Nov 2014 18:51:25 -0500
Message-ID: <546543FC.6020701@redhat.com>
Date: Thu, 13 Nov 2014 17:51:24 -0600
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] use xfs_io falloc, not fallocate
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

generic/315 fails messily if the fallocate command
isn't present.

generic/299 also uses "fallocate" and "truncate"
binaries which may not be present.

Switch both to use xfs_io, and we already have the
_require for that, because it's what every other test
uses...

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/299 b/tests/generic/299
index e8685a4..f4fc20e 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -110,6 +110,7 @@ filename=buffered-aio-verifier
 EOF
 
 _require_fio $fio_config
+_require_xfs_io_command "falloc"
 
 _workout()
 {
@@ -125,12 +126,13 @@ _workout()
 	do
 	    for ((k=1; k <= NUM_JOBS; k++))
 	    do
-		fallocate -l $FILE_SIZE $SCRATCH_MNT/direct_aio.$k.0 \
-			>> $seqres.full 2>&1
+		$XFS_IO_PROG -f -c "falloc 0 $FILE_SIZE" \
+			$SCRATCH_MNT/direct_aio.$k.0 >> $seqres.full 2>&1
 	    done
 	    for ((k=1; k <= NUM_JOBS; k++))
 	    do
-		truncate -s 0 $SCRATCH_MNT/direct_aio.$k.0 >> $seqres.full 2>&1
+		$XFS_IO_PROG -c "truncate  0" \
+			$SCRATCH_MNT/direct_aio.$k.0 >> $seqres.full 2>&1
 	    done
 	    # Following like will check that pid is still run.
 	    # Once fio exit we can stop fallocate/truncate loop
diff --git a/tests/generic/315 b/tests/generic/315
index 62fdc01..4433b6c 100755
--- a/tests/generic/315
+++ b/tests/generic/315
@@ -49,6 +49,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
@@ -62,7 +63,8 @@ avail_begin=`df -P $TEST_DIR | awk 'END {print $4}'`
 # Preallocate half size of the available disk space to a file
 # starts from offset 0 with FALLOC_FL_KEEP_SIZE option on the
 # test file system.
-fallocate -n -o 0 -l $(($avail_begin/2)) $TEST_DIR/testfile.$seq >>$seqres.full 2>&1
+$XFS_IO_PROG -f -c 'falloc -k 0 $(($avail_begin/2))' \
+	$TEST_DIR/testfile.$seq >>$seqres.full 2>&1
 
 # Verify the file size, it should keep unchanged as 0 in this case
 fsize=`ls -l $TEST_DIR/testfile.$seq | awk '{print $5}'`


