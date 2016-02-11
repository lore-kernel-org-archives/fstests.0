Received: from imap.thunk.org ([74.207.234.97]:36008 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbcBKF42 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 00:56:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 05/13] generic: add _require_odirect to generic/113 and generic/214
Date: Thu, 11 Feb 2016 00:56:14 -0500
Message-Id: <1455170182-32587-6-git-send-email-tytso@mit.edu>
In-Reply-To: <1455170182-32587-1-git-send-email-tytso@mit.edu>
References: <1455170182-32587-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

generic/113 and generic/214 both use O_DIRECT at some stage in their
tests, so check O_DIRECT support before running them.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/113 | 1 +
 tests/generic/214 | 1 +
 2 files changed, 2 insertions(+)

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

