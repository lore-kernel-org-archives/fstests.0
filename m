Received: from mx1.redhat.com ([209.132.183.28]:59494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfGBIpO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 Jul 2019 04:45:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94482223884
        for <fstests@vger.kernel.org>; Tue,  2 Jul 2019 08:45:14 +0000 (UTC)
Received: from dhcp-12-171.nay.redhat.com (dhcp-12-171.nay.redhat.com [10.66.12.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C12EB403B
        for <fstests@vger.kernel.org>; Tue,  2 Jul 2019 08:45:13 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic: fix missed FSX_AVOID parameter
Date: Tue,  2 Jul 2019 16:45:07 +0800
Message-Id: <20190702084507.14050-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When I try to avoid copy_file_range operation from fsx, I set
FSX_AVOID="-E", but it doesn't work on generic/455, and generic/127
doesn't show $FSX_AVOID when it fails.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/127 | 8 ++++----
 tests/generic/455 | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/generic/127 b/tests/generic/127
index dedd8bbf..222e0315 100755
--- a/tests/generic/127
+++ b/tests/generic/127
@@ -37,7 +37,7 @@ _fsx_lite_nommap()
     dd if=/dev/zero of=$TEST_DIR/fsx_lite_nommap bs=${FSX_FILE_SIZE} count=1 > /dev/null 2>&1
     if ! ltp/fsx $FSX_ARGS -L -R -W $FSX_AVOID $TEST_DIR/fsx_lite_nommap > $tmp.output 2>&1
     then
-        echo "ltp/fsx $FSX_ARGS -L -R -W $TEST_DIR/fsx_lite_nommap"
+        echo "ltp/fsx $FSX_ARGS -L -R -W $FSX_AVOID $TEST_DIR/fsx_lite_nommap"
         cat $tmp.output
         return 1
     fi
@@ -51,7 +51,7 @@ _fsx_lite_mmap()
     dd if=/dev/zero of=$TEST_DIR/fsx_lite_mmap bs=${FSX_FILE_SIZE} count=1 > /dev/null 2>&1
     if ! ltp/fsx $FSX_ARGS -L $FSX_AVOID $TEST_DIR/fsx_lite_mmap > $tmp.output 2>&1
     then
-    	echo "ltp/fsx $FSX_ARGS -L fsx_lite_mmap"
+	echo "ltp/fsx $FSX_ARGS -L $FSX_AVOID $TEST_DIR/fsx_lite_mmap"
 	cat $tmp.output
 	return 1
     fi
@@ -64,7 +64,7 @@ _fsx_std_nommap()
     echo "=== FSX Standard Mode, No Memory Mapping ==="
     if ! ltp/fsx $FSX_ARGS -R -W $FSX_AVOID $TEST_DIR/fsx_std_nommap > $tmp.output 2>&1
     then
-        echo "ltp/fsx $FSX_ARGS -R -W fsx_std_nommap"
+        echo "ltp/fsx $FSX_ARGS -R -W $FSX_AVOID $TEST_DIR/fsx_std_nommap"
         cat $tmp.output
         return 1
     fi
@@ -77,7 +77,7 @@ _fsx_std_mmap()
     echo "=== FSX Standard Mode, Memory Mapping ==="
     if ! ltp/fsx $FSX_ARGS $FSX_AVOID $TEST_DIR/fsx_std_mmap > $tmp.output 2>&1
     then
-    	echo "ltp/fsx $FSX_ARGS fsx_std_mmap"
+	echo "ltp/fsx $FSX_ARGS $FSX_AVOID $TEST_DIR/fsx_std_mmap"
 	cat $tmp.output
 	return 1
     fi
diff --git a/tests/generic/455 b/tests/generic/455
index 05621220..404c603b 100755
--- a/tests/generic/455
+++ b/tests/generic/455
@@ -66,7 +66,7 @@ _log_writes_mount -o discard
 
 NUM_FILES=4
 NUM_OPS=200
-FSX_OPTS="-N $NUM_OPS -d -P $SANITY_DIR -i $LOGWRITES_DMDEV"
+FSX_OPTS="-N $NUM_OPS -d -P $SANITY_DIR -i $LOGWRITES_DMDEV $FSX_AVOID"
 # Set random seeds for fsx runs (0 for timestamp + pid)
 # When test failure is detected, check the seed values printed
 # by fsx processes to $seqres.full and set them in this array
-- 
2.17.2
