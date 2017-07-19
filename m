Received: from mail-pf0-f194.google.com ([209.85.192.194]:37629 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932416AbdGSWZr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Jul 2017 18:25:47 -0400
Received: by mail-pf0-f194.google.com with SMTP id d18so937732pfe.4
        for <fstests@vger.kernel.org>; Wed, 19 Jul 2017 15:25:47 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] generic/192: use shorter sleep and tolerate 2s delay
Date: Wed, 19 Jul 2017 15:25:08 -0700
Message-Id: <20170719222508.145781-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

generic/192 would sleep 40 seconds, update a file's atime, and then fail
if the atime was not exactly 40 seconds later.  This is unreliable since
things may be slow enough to cause an extra second to elapse.  "Fix"
this by allowing for 2 seconds of delay.  Also, while we're at it
shorten the sleep to a much more reasonable 5 seconds.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/192     | 13 +++++--------
 tests/generic/192.out |  6 +++---
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/tests/generic/192 b/tests/generic/192
index d3ed0ec0..2cee2e60 100755
--- a/tests/generic/192
+++ b/tests/generic/192
@@ -48,11 +48,7 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_atime
-#delay=150
-#delay=75
-#delay=60
-#delay=45
-delay=40
+delay=5
 
 testfile=$TEST_DIR/testfile
 rm -f $testfile
@@ -61,7 +57,7 @@ rm -f $seqres.full
 echo test >$testfile
 time1=`_access_time $testfile | tee -a $seqres.full`
 
-echo "sleep for $delay"
+echo "sleep for $delay seconds"
 sleep $delay # sleep to allow time to move on for access
 cat $testfile
 time2=`_access_time $testfile | tee -a $seqres.full`
@@ -73,8 +69,9 @@ time3=`_access_time $testfile | tee -a $seqres.full`
 delta1=`expr $time2 - $time1`
 delta2=`expr $time3 - $time1`
 
-echo "delta1 - access time after sleep in-core: $delta1"
-echo "delta2 - access time after sleep on-disk: $delta2"
+# tolerate an atime up to 2s later than the ideal case
+_within_tolerance "delta1" $delta1 $delay  0 2 -v
+_within_tolerance "delta2" $delta2 $delta1 0 0 -v
 
 # success, all done
 status=0
diff --git a/tests/generic/192.out b/tests/generic/192.out
index 7e1f6996..f3b41141 100644
--- a/tests/generic/192.out
+++ b/tests/generic/192.out
@@ -1,5 +1,5 @@
 QA output created by 192
-sleep for 40
+sleep for 5 seconds
 test
-delta1 - access time after sleep in-core: 40
-delta2 - access time after sleep on-disk: 40
+delta1 is in range
+delta2 is in range
-- 
2.14.0.rc0.284.gd933b75aa4-goog

