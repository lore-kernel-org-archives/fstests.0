Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:56992 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbaLOPra (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 10:47:30 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] ext4/308,generic/324: require fallocate support
Date: Mon, 15 Dec 2014 10:47:23 -0500
Message-Id: <1418658443-31670-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

These tests use the falloc command in xfs_io, and there are some file
systems (ext3) or file system configurations (ext4 in ext3
compatibility mode) which do not support fallocate.  So add the
explicit requirement to avoid false test failures.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/308    | 1 +
 tests/generic/324 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/ext4/308 b/tests/ext4/308
index 8df24ba..948ff3f 100755
--- a/tests/ext4/308
+++ b/tests/ext4/308
@@ -46,6 +46,7 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_defrag
+_require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
diff --git a/tests/generic/324 b/tests/generic/324
index 1868bbc..5e642dc 100755
--- a/tests/generic/324
+++ b/tests/generic/324
@@ -44,6 +44,7 @@ _supported_os Linux
 _need_to_be_root
 _require_scratch
 _require_defrag
+_require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
-- 
2.1.0

