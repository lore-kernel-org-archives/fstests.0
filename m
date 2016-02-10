Received: from imap.thunk.org ([74.207.234.97]:51038 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756053AbcBJBuM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 9 Feb 2016 20:50:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 04/12] generic: add _require_odirect to three more tests
Date: Tue,  9 Feb 2016 20:49:53 -0500
Message-Id: <1455069001-17846-5-git-send-email-tytso@mit.edu>
In-Reply-To: <1455069001-17846-1-git-send-email-tytso@mit.edu>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

generic/113, generic/125, generic/214 each use O_DIRECT at some
stage in their tests, so check O_DIRECT support before running them.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/113 | 1 +
 tests/generic/125 | 1 +
 tests/generic/214 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/generic/113 b/tests/generic/113
index 7208fa2..54d6191 100755
--- a/tests/generic/113
+++ b/tests/generic/113
@@ -77,6 +77,7 @@ _do_test()
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_odirect
 
 [ -x $here/ltp/aio-stress ] || _notrun "aio-stress not built for this platform"
 
diff --git a/tests/generic/125 b/tests/generic/125
index bcf9b3e..67eb63f 100755
--- a/tests/generic/125
+++ b/tests/generic/125
@@ -41,6 +41,7 @@ _supported_os Linux
 
 _require_test
 _require_user
+_require_odirect
 
 TESTDIR=$TEST_DIR/ftrunc
 TESTFILE=$TESTDIR/ftrunc.tmp
diff --git a/tests/generic/214 b/tests/generic/214
index dff267e..7838047 100755
--- a/tests/generic/214
+++ b/tests/generic/214
@@ -55,6 +55,7 @@ rm -f $seqres.full
 rm -f $TEST_DIR/ouch*
 
 _require_xfs_io_command "falloc"
+_require_odirect
 
 # Ok, off we go.
 
-- 
2.5.0

