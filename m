Received: from mx1.redhat.com ([209.132.183.28]:59581 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773AbbFXLJR (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 24 Jun 2015 07:09:17 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 04484359A5A
	for <fstests@vger.kernel.org>; Wed, 24 Jun 2015 11:09:17 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] fstests: remove $seqres.full before test to avoid keep-growing log file
Date: Wed, 24 Jun 2015 19:09:02 +0800
Message-Id: <1435144142-10380-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Some tests append logs to $seqres.full and never remove the log, which
keeps the log file growing. Remove $seqres.full before test in
following tests:

   ext4/271
   generic/019
   generic/269
   generic/270
   shared/272

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/ext4/271    | 1 +
 tests/generic/019 | 1 +
 tests/generic/269 | 1 +
 tests/generic/270 | 1 +
 tests/shared/272  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tests/ext4/271 b/tests/ext4/271
index e77ae57..217d0d8 100755
--- a/tests/ext4/271
+++ b/tests/ext4/271
@@ -41,6 +41,7 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 
+rm -f $seqres.full
 _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
 
 # -onoload and EXT4_SYNC_FL on file is important becase result in
diff --git a/tests/generic/019 b/tests/generic/019
index ca196ca..76a09d5 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -173,6 +173,7 @@ _workout()
 
 # real QA test starts here
 
+rm -f $seqres.full
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount || _fail "mount failed"
 allow_fail_make_request
diff --git a/tests/generic/269 b/tests/generic/269
index cff5e54..fe648b5 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -66,6 +66,7 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 
+rm -f $seqres.full
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount
 
diff --git a/tests/generic/270 b/tests/generic/270
index cebd377..255ebf2 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -81,6 +81,7 @@ _require_user
 _need_to_be_root
 _require_scratch
 
+rm -f $seqres.full
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount "-o usrquota,grpquota"
 chmod 777 $SCRATCH_MNT
diff --git a/tests/shared/272 b/tests/shared/272
index 4417535..11b2a00 100755
--- a/tests/shared/272
+++ b/tests/shared/272
@@ -87,6 +87,7 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 
+rm -f $seqres.full
 _scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount
 
-- 
2.4.3

