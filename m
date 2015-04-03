Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45157 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbbDCMPJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 3 Apr 2015 08:15:09 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 6CBC9AECCE
	for <fstests@vger.kernel.org>; Fri,  3 Apr 2015 12:15:09 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [RFC PATCH] fstests: _require_metadata_journaling in _require_dm_flakey
Date: Fri,  3 Apr 2015 20:14:45 +0800
Message-Id: <1428063285-31140-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Tests take use of dm-flakey target should require metadata journaling,
so move _require_metadata_journaling call from each test to
_require_dm_flakey to ease the process, though it seems unnecessary to
btrfs or xfs specific tests.

This change also makes generic/039 generic/059 generic/325 require
metadata journaling automatically, and any new test that calls
_require_dm_flakey.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc         | 1 +
 tests/generic/034 | 1 -
 tests/generic/040 | 1 -
 tests/generic/041 | 1 -
 tests/generic/056 | 1 -
 tests/generic/057 | 1 -
 tests/generic/065 | 1 -
 tests/generic/066 | 1 -
 tests/generic/073 | 1 -
 tests/generic/311 | 1 -
 tests/generic/321 | 1 -
 tests/generic/322 | 1 -
 12 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/common/rc b/common/rc
index c5db0dd..518bf38 100644
--- a/common/rc
+++ b/common/rc
@@ -1311,6 +1311,7 @@ _require_dm_flakey()
 {
     # require SCRATCH_DEV to be a valid block device
     _require_block_device $SCRATCH_DEV
+    _require_metadata_journaling $SCRATCH_DEV
     _require_command "$DMSETUP_PROG" dmsetup
 
     modprobe dm-flakey >/dev/null 2>&1
diff --git a/tests/generic/034 b/tests/generic/034
index 966b3d2..4ec1db8 100755
--- a/tests/generic/034
+++ b/tests/generic/034
@@ -53,7 +53,6 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_dm_flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
diff --git a/tests/generic/040 b/tests/generic/040
index c841fbc..5f10f48 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -62,7 +62,6 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_dm_flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
diff --git a/tests/generic/041 b/tests/generic/041
index f38b662..36a6f42 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -66,7 +66,6 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_dm_flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
diff --git a/tests/generic/056 b/tests/generic/056
index 8bb1522..9ec00e3 100755
--- a/tests/generic/056
+++ b/tests/generic/056
@@ -55,7 +55,6 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_dm_flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
diff --git a/tests/generic/057 b/tests/generic/057
index 3b9f89e..4c0ffd1 100755
--- a/tests/generic/057
+++ b/tests/generic/057
@@ -55,7 +55,6 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_dm_flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
diff --git a/tests/generic/065 b/tests/generic/065
index 739a4d5..4fdff5a 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -56,7 +56,6 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_dm_flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
diff --git a/tests/generic/066 b/tests/generic/066
index cb36506..3fbce8f 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -61,7 +61,6 @@ _need_to_be_root
 _require_scratch
 _require_dm_flakey
 _require_attrs
-_require_metadata_journaling $SCRATCH_DEV
 
 _crash_and_mount()
 {
diff --git a/tests/generic/073 b/tests/generic/073
index 9cf0d90..bf666ec 100755
--- a/tests/generic/073
+++ b/tests/generic/073
@@ -56,7 +56,6 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_dm_flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
diff --git a/tests/generic/311 b/tests/generic/311
index d21b6eb..85e52e8 100755
--- a/tests/generic/311
+++ b/tests/generic/311
@@ -56,7 +56,6 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch_nocheck
 _require_dm_flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 # xfs_io is not required for this test, but it's the best way to verify
 # the test system supports fallocate() for allocation
diff --git a/tests/generic/321 b/tests/generic/321
index c821a23..3bd6b12 100755
--- a/tests/generic/321
+++ b/tests/generic/321
@@ -45,7 +45,6 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch_nocheck
 _require_dm_flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
diff --git a/tests/generic/322 b/tests/generic/322
index 4c0edf6..3ec2387 100755
--- a/tests/generic/322
+++ b/tests/generic/322
@@ -45,7 +45,6 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch_nocheck
 _require_dm_flakey
-_require_metadata_journaling $SCRATCH_DEV
 
 rm -f $seqres.full
 
-- 
2.1.0

