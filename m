Received: from imap.thunk.org ([74.207.234.97]:33778 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbcFISmL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 9 Jun 2016 14:42:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic: mark tests that require O_DIRECT
Date: Thu,  9 Jun 2016 14:42:08 -0400
Message-Id: <1465497728-3221-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

generic/094 and generic/225 use fiemap-tester, which requires O_DIRECT.

generic/311 requests fsync-tester to use  O_DIRECT

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/094 | 1 +
 tests/generic/225 | 1 +
 tests/generic/311 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/generic/094 b/tests/generic/094
index a51738a..005de1d 100755
--- a/tests/generic/094
+++ b/tests/generic/094
@@ -44,6 +44,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_odirect
 _require_xfs_io_command "fiemap"
 _require_xfs_io_command "falloc"
 
diff --git a/tests/generic/225 b/tests/generic/225
index c8e0f64..5285e68 100755
--- a/tests/generic/225
+++ b/tests/generic/225
@@ -44,6 +44,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_odirect
 _require_xfs_io_command "fiemap"
 
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/generic/311 b/tests/generic/311
index 2d4413b..d510204 100755
--- a/tests/generic/311
+++ b/tests/generic/311
@@ -54,6 +54,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch_nocheck
+_require_odirect
 _require_dm_target flakey
 _require_metadata_journaling $SCRATCH_DEV
 
-- 
2.5.0

