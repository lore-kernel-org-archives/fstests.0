Received: from mx2.suse.de ([195.135.220.15]:42414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728664AbfEQP4j (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 May 2019 11:56:39 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] generic/{436,445}: define _cleanup function earlier in the tests
Date: Fri, 17 May 2019 16:56:35 +0100
Message-Id: <20190517155635.30742-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Luis Henriques <lhenriques@suse.com>, Amir Goldstein <amir73il@gmail.com>
List-ID: <fstests@vger.kernel.org>

If the filesystem doesn't support a feature that is required for the tests
to run, they will fail to execute the _cleanup function because it isn't yet
defined:

  ./common/rc: line 1: _cleanup: command not found

This error became more visible with commit 87a53d2e7c82 ("generic/{436,445}:
check falloc support").

Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 tests/generic/436 | 14 +++++++-------
 tests/generic/445 | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tests/generic/436 b/tests/generic/436
index ada60b2e7afd..6e5c36c5c01a 100755
--- a/tests/generic/436
+++ b/tests/generic/436
@@ -15,6 +15,13 @@ tmp=$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
+
+_cleanup()
+{
+	rm -f $tmp.* $BASE_TEST_FILE.*
+}
+
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
@@ -27,15 +34,8 @@ _require_seek_data_hole
 # All the seek sanity test cases here do falloc
 _require_xfs_io_command "falloc"
 
-BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
-
 _require_test_program "seek_sanity_test"
 
-_cleanup()
-{
-	rm -f $tmp.* $BASE_TEST_FILE.*
-}
-
 _run_seek_sanity_test -s 13 -e 16 $BASE_TEST_FILE > $seqres.full 2>&1 ||
 	_fail "seek sanity check failed!"
 
diff --git a/tests/generic/445 b/tests/generic/445
index 248f321b8601..cf41607997e9 100755
--- a/tests/generic/445
+++ b/tests/generic/445
@@ -15,6 +15,13 @@ tmp=$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
+
+_cleanup()
+{
+	rm -f $tmp.* $BASE_TEST_FILE.*
+}
+
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
@@ -27,15 +34,8 @@ _require_seek_data_hole
 # All the seek sanity test cases here do falloc
 _require_xfs_io_command "falloc"
 
-BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
-
 _require_test_program "seek_sanity_test"
 
-_cleanup()
-{
-	rm -f $tmp.* $BASE_TEST_FILE.*
-}
-
 _run_seek_sanity_test -s 17 -e 17 $BASE_TEST_FILE > $seqres.full 2>&1 ||
 	_fail "seek sanity check failed!"
 
