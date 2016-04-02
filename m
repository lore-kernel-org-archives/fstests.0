Received: from imap.thunk.org ([74.207.234.97]:32804 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbcDBQ4V (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 2 Apr 2016 12:56:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] Mark tests which use direct I/O with _requires_odirect
Date: Sat,  2 Apr 2016 12:56:13 -0400
Message-Id: <1459616174-31557-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

There were a number of tests that use Direct I/O that weren't testing
to make sure O_DIRECT is actually supported.  This will be important
for avoiding false positives when testing ext4 encryption (which does
not support DIO for obvious reasons).

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/301    | 1 +
 tests/ext4/302    | 1 +
 tests/ext4/303    | 1 +
 tests/ext4/304    | 1 +
 tests/generic/095 | 1 +
 tests/generic/250 | 1 +
 tests/generic/252 | 2 +-
 tests/generic/331 | 2 +-
 tests/generic/332 | 2 +-
 9 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/ext4/301 b/tests/ext4/301
index 4e21acd..8e051f9 100755
--- a/tests/ext4/301
+++ b/tests/ext4/301
@@ -42,6 +42,7 @@ _supported_os Linux
 _supported_fs ext4
 _require_scratch
 _require_defrag
+_require_odirect
 
 NUM_JOBS=$((4*LOAD_FACTOR))
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
diff --git a/tests/ext4/302 b/tests/ext4/302
index 6ed8ce0..e45dfb8 100755
--- a/tests/ext4/302
+++ b/tests/ext4/302
@@ -43,6 +43,7 @@ _supported_os Linux
 _supported_fs ext4
 _require_scratch
 _require_defrag
+_require_odirect
 
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
 # We need space for 2 files (test file, and donor one)
diff --git a/tests/ext4/303 b/tests/ext4/303
index b925aa3..3519002 100755
--- a/tests/ext4/303
+++ b/tests/ext4/303
@@ -43,6 +43,7 @@ _supported_os Linux
 _supported_fs ext4
 _require_scratch
 _require_defrag
+_require_odirect
 
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
 # We need space for 3 files (one donor file and two test files)
diff --git a/tests/ext4/304 b/tests/ext4/304
index ceb82d6..952bbb9 100755
--- a/tests/ext4/304
+++ b/tests/ext4/304
@@ -44,6 +44,7 @@ _supported_os Linux
 _supported_fs ext4
 _require_scratch
 _require_defrag
+_require_odirect
 
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
 # We need space for 2 files (test file, and donor one)
diff --git a/tests/generic/095 b/tests/generic/095
index 1123080..c656ef1 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -44,6 +44,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_odirect
 
 iodepth=$((16 * LOAD_FACTOR))
 iodepth_batch=$((8 * LOAD_FACTOR))
diff --git a/tests/generic/250 b/tests/generic/250
index b0b175a..6d15de2 100755
--- a/tests/generic/250
+++ b/tests/generic/250
@@ -47,6 +47,7 @@ _supported_os Linux
 _require_scratch
 _require_dm_target error
 _require_xfs_io_command "falloc"
+_require_odirect
 
 rm -f $seqres.full
 
diff --git a/tests/generic/252 b/tests/generic/252
index fc9a723..ffedd56 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -47,7 +47,7 @@ _supported_os Linux
 _require_scratch
 _require_dm_target error
 _require_xfs_io_command "falloc"
-_require_test_program "aio-dio-regress/aiocp"
+_require_aiodio "aiocp"
 AIO_TEST="src/aio-dio-regress/aiocp"
 
 rm -f $seqres.full
diff --git a/tests/generic/331 b/tests/generic/331
index 8d8fd6a..9b91459 100755
--- a/tests/generic/331
+++ b/tests/generic/331
@@ -47,7 +47,7 @@ _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
 _require_dm_target error
-_require_test_program "aio-dio-regress/aiocp"
+_require_aiodio "aiocp"
 AIO_TEST="src/aio-dio-regress/aiocp"
 
 rm -f $seqres.full
diff --git a/tests/generic/332 b/tests/generic/332
index b805bbd..1fb5611 100755
--- a/tests/generic/332
+++ b/tests/generic/332
@@ -44,7 +44,7 @@ _cleanup()
 _supported_os Linux
 _require_scratch_reflink
 _require_cp_reflink
-_require_test_program "aio-dio-regress/aiocp"
+_require_aiodio "aiocp"
 AIO_TEST="src/aio-dio-regress/aiocp"
 
 rm -f $seqres.full
-- 
2.5.0

