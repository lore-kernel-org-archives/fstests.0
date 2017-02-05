Received: from imap.thunk.org ([74.207.234.97]:33740 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751734AbdBEGxq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 5 Feb 2017 01:53:46 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/3] generic: honor the FSSTRESS_AVOID environment variable
Date: Sun,  5 Feb 2017 01:53:34 -0500
Message-Id: <20170205065336.14994-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Make sure all tests which run fsstress, and which do not have a very
specific custom profile of which file system operations to run, honor
the FSSTRESS_AVOID environment variable.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/051 | 2 +-
 tests/generic/232 | 2 +-
 tests/generic/388 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/generic/051 b/tests/generic/051
index b0c37824..7b807b9f 100755
--- a/tests/generic/051
+++ b/tests/generic/051
@@ -63,7 +63,7 @@ PROCS=$((2 * LOAD_FACTOR))
 load_dir=$SCRATCH_MNT/test
 
 # let this run for a while
-$FSSTRESS_PROG -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
+$FSSTRESS_PROG $FSSTRESS_AVOID -n10000000 -p $PROCS -d $load_dir >> $seqres.full 2>&1 &
 sleep $SLEEP_TIME
 $KILLALL_PROG -q $FSSTRESS_PROG
 wait
diff --git a/tests/generic/232 b/tests/generic/232
index 6b197791..f4853f72 100755
--- a/tests/generic/232
+++ b/tests/generic/232
@@ -53,7 +53,7 @@ _fsstress()
 
 	out=$SCRATCH_MNT/fsstress.$$
 	count=2000
-	args=`_scale_fsstress_args -d $out -n $count -p 7`
+	args=`_scale_fsstress_args -d $out -n $count -p 7 $FSSTRESS_AVOID`
 
 	echo "fsstress $args" >> $seqres.full
 	if ! $FSSTRESS_PROG $args | tee -a $seqres.full | _filter_num
diff --git a/tests/generic/388 b/tests/generic/388
index 9d4ba9d6..3729aa5b 100755
--- a/tests/generic/388
+++ b/tests/generic/388
@@ -65,7 +65,7 @@ _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount || _fail "mount failed"
 
 for i in $(seq 1 50); do
-	($FSSTRESS_PROG -d $SCRATCH_MNT -n 999999 -p 4 >> $seqres.full &) \
+	($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -n 999999 -p 4 >> $seqres.full &) \
 		> /dev/null 2>&1
 
 	# purposely include 0 second sleeps to test shutdown immediately after
-- 
2.11.0.rc0.7.gbe5a750

