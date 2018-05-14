Received: from mail-wr0-f194.google.com ([209.85.128.194]:36689 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeENFsd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 May 2018 01:48:33 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 2/3] fstests: define and use TIMEOUT_PROG
Date: Mon, 14 May 2018 08:49:50 +0300
Message-Id: <1526276991-23897-3-git-send-email-amir73il@gmail.com>
In-Reply-To: <1526276991-23897-1-git-send-email-amir73il@gmail.com>
References: <1526276991-23897-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/config     | 1 +
 tests/generic/297 | 4 ++--
 tests/generic/298 | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/common/config b/common/config
index cc31806..af360ce 100644
--- a/common/config
+++ b/common/config
@@ -204,6 +204,7 @@ export UBIUPDATEVOL_PROG="`set_prog_path ubiupdatevol`"
 export THIN_CHECK_PROG="$(set_prog_path thin_check)"
 export PYTHON2_PROG="`set_prog_path python2`"
 export SQLITE3_PROG="`set_prog_path sqlite3`"
+export TIMEOUT_PROG="`set_prog_path timeout`"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/tests/generic/297 b/tests/generic/297
index f7eb37b..a3ba5c4 100755
--- a/tests/generic/297
+++ b/tests/generic/297
@@ -45,7 +45,7 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_require_command "$(which timeout)" "timeout"
+_require_command "$TIMEOUT_PROG" "timeout"
 
 test $FSTYP == "nfs"  && _notrun "NFS can't interrupt clone operations"
 
@@ -83,7 +83,7 @@ kill_after=2	# give us a shorter time to die
 n=$(stat -c '%s' $testdir/file1)
 echo "performing kill test on $n bytes..." >> $seqres.full
 touch $TEST_DIR/before
-timeout -s INT ${kill_after}s $XFS_IO_PROG -f -c "reflink $testdir/file1 0 $n $n" $testdir/file1 >> $seqres.full 2>&1
+$TIMEOUT_PROG -s INT ${kill_after}s $XFS_IO_PROG -f -c "reflink $testdir/file1 0 $n $n" $testdir/file1 >> $seqres.full 2>&1
 touch $TEST_DIR/after
 before=$(stat -c '%Y' $TEST_DIR/before)
 after=$(stat -c '%Y' $TEST_DIR/after)
diff --git a/tests/generic/298 b/tests/generic/298
index b518da1..a4d458c 100755
--- a/tests/generic/298
+++ b/tests/generic/298
@@ -45,7 +45,7 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_require_command "$(which timeout)" "timeout"
+_require_command "$TIMEOUT_PROG" "timeout"
 
 test $FSTYP == "nfs"  && _notrun "NFS can't interrupt clone operations"
 
@@ -83,7 +83,7 @@ kill_after=2	# give us a shorter time to die
 n=$(stat -c '%s' $testdir/file1)
 echo "performing kill test on $n bytes..." >> $seqres.full
 touch $TEST_DIR/before
-urk=$(timeout -s KILL ${kill_after}s $XFS_IO_PROG -f -c "reflink $testdir/file1 0 $n $n" $testdir/file1 >> $seqres.full 2>&1)
+urk=$($TIMEOUT_PROG -s KILL ${kill_after}s $XFS_IO_PROG -f -c "reflink $testdir/file1 0 $n $n" $testdir/file1 >> $seqres.full 2>&1)
 touch $TEST_DIR/after
 before=$(stat -c '%Y' $TEST_DIR/before)
 after=$(stat -c '%Y' $TEST_DIR/after)
-- 
2.7.4

