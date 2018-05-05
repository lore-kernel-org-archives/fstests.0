Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:27352 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751742AbeEEAT4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 May 2018 20:19:56 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fEkvX-0006Pb-SP
        for fstests@vger.kernel.org; Sat, 05 May 2018 10:19:51 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fEkvX-0001U5-P8
        for fstests@vger.kernel.org; Sat, 05 May 2018 10:19:51 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] README: document the new default run mode
Date: Sat,  5 May 2018 10:19:51 +1000
Message-Id: <20180505001951.5665-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Also document the new way to run all tests (i.e. check -g all) and
clean up all the stray whitespace in the readme file.

Signed-Off-By: Dave Chinner <dchinner@redhat.com>
---
 README | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/README b/README
index 50c68afaf0c2..73f057f3d403 100644
--- a/README
+++ b/README
@@ -22,7 +22,7 @@ _______________________
 - create fsgqa test user ("sudo useradd fsgqa")
 - create fsgqa group ("sudo groupadd fsgqa")
 - create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
-	
+
 ______________________
 USING THE FSQA SUITE
 ______________________
@@ -36,11 +36,10 @@ Preparing system for tests:
       from http://www.extra.research.philips.com/udf/, then copy the udf_test
       binary to xfstests/src/. If you wish to disable UDF verification test
       set the environment variable DISABLE_UDF_TEST to 1.
-	
-    
+
     - create one or two partitions to use for testing
         - one TEST partition
-            - format as XFS, mount & optionally populate with 
+            - format as XFS, mount & optionally populate with
               NON-IMPORTANT stuff
         - one SCRATCH partition (optional)
             - leave empty and expect this partition to be clobbered
@@ -54,14 +53,14 @@ Preparing system for tests:
               SCRATCH_DEV should be unused by the tester, and for the legacy
               support SCRATCH_DEV will be set to the first disk of the
               SCRATCH_DEV_POOL by xfstests script.
-              
+
     - setup your environment
 	Quick start:
 	- copy local.config.example to local.config and edit as needed
 	Or:
         - setenv TEST_DEV "device containing TEST PARTITION"
-        - setenv TEST_DIR "mount point of TEST PARTITION"   
-       	- optionally:
+        - setenv TEST_DIR "mount point of TEST PARTITION"
+	- optionally:
              - setenv SCRATCH_DEV "device containing SCRATCH PARTITION" OR
                (btrfs only) setenv SCRATCH_DEV_POOL "to 3 or more SCRATCH disks for
                testing btrfs raid concepts"
@@ -109,18 +108,23 @@ Preparing system for tests:
 
     - if testing xfsdump, make sure the tape devices have a
       tape which can be overwritten.
-          
+
     - make sure $TEST_DEV is a mounted XFS partition
     - make sure that $SCRATCH_DEV or $SCRATCH_DEV_POOL contains nothing useful
-    
+
 Running tests:
 
     - cd xfstests
-    - By default the tests suite will run xfs tests:
+    - By default the tests suite will run all the tests in the auto group. These
+      are the tests that are expected to function correctly as regression tests,
+      and it excludes tests that exercise conditions known to cause machine
+      failures (i.e. the "dangerous" tests).
     - ./check '*/001' '*/002' '*/003'
     - ./check '*/06?'
     - Groups of tests maybe ran by: ./check -g [group(s)]
       See the 'group' file for details on groups
+    - If you want to run all tests regardless of what group they are in
+      (including dangerous tests), use the "all" group: ./check -g all
     - To randomize test order: ./check -r [test(s)]
     - You can explicitly specify NFS/CIFS/OVERLAY, otherwise
       the filesystem type will be autodetected from $TEST_DEV:
@@ -130,16 +134,16 @@ Running tests:
           The TEST and SCRATCH partitions should be pre-formatted
           with another base fs, where the overlay dirs will be created
 
-    
+
     The check script tests the return value of each script, and
     compares the output against the expected output. If the output
     is not as expected, a diff will be output and an .out.bad file
     will be produced for the failing test.
-    
+
     Unexpected console messages, crashes and hangs may be considered
     to be failures but are not necessarily detected by the QA system.
 
-__________________________ 
+__________________________
 ADDING TO THE FSQA SUITE
 __________________________
 
@@ -168,11 +172,11 @@ Test script environment:
 	    $TEST_DEV.
 
 	(b) mkfs a new XFS filesystem on $SCRATCH_DEV, and mount this
-	    on $SCRATCH_MNT. Call the the _require_scratch function 
+	    on $SCRATCH_MNT. Call the the _require_scratch function
             on startup if you require use of the scratch partition.
-            _require_scratch does some checks on $SCRATCH_DEV & 
-            $SCRATCH_MNT and makes sure they're unmounted. You should 
-            cleanup when your test is done, and in particular unmount 
+            _require_scratch does some checks on $SCRATCH_DEV &
+            $SCRATCH_MNT and makes sure they're unmounted. You should
+            cleanup when your test is done, and in particular unmount
             $SCRATCH_MNT.
 	    Tests can make use of $SCRATCH_LOGDEV and $SCRATCH_RTDEV
 	    for testing external log and realtime volumes - however,
-- 
2.17.0

