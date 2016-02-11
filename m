Received: from imap.thunk.org ([74.207.234.97]:35995 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbcBKF41 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 00:56:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 10/13] xfstests: generic/079 and generic/277 requires chattr, not xattrs
Date: Thu, 11 Feb 2016 00:56:19 -0500
Message-Id: <1455170182-32587-11-git-send-email-tytso@mit.edu>
In-Reply-To: <1455170182-32587-1-git-send-email-tytso@mit.edu>
References: <1455170182-32587-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Add a new helper, _require_chattr, which allows the test to explicitly
check to see if the file system supports a specific chattr flag, as
not all file systems support chattr +A or chattr +i, and the presence
of extended attribute support is has nothing to do with a specific
chattr flag being supported.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc         | 16 ++++++++++++++++
 tests/generic/079 |  2 +-
 tests/generic/277 |  2 +-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index a585bd1..8754c17 100644
--- a/common/rc
+++ b/common/rc
@@ -3018,6 +3018,22 @@ _require_test_lsattr()
 		_notrun "lsattr not supported by test filesystem type: $FSTYP"
 }
 
+_require_chattr()
+{
+    attribute=$1
+
+    touch $TEST_DIR/syscalltest
+    chattr "+$attribute" $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
+    status=$?
+    chattr "-$attribute" $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
+    if [ "$status" -ne 0 ]; then
+      _notrun "file system doesn't support chattr +$attribute"
+    fi
+    cat $TEST_DIR/syscalltest.out >> $seqres.full
+
+    rm -f $TEST_DIR/syscalltest.out
+}
+
 _get_total_inode()
 {
 	if [ -z "$1" ]; then
diff --git a/tests/generic/079 b/tests/generic/079
index 041d9c0..5cceeba 100755
--- a/tests/generic/079
+++ b/tests/generic/079
@@ -48,7 +48,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 
-_require_attrs
+_require_chattr i
 _require_scratch
 
 [ -x $timmutable ] || _notrun "t_immutable was not built for this platform"
diff --git a/tests/generic/277 b/tests/generic/277
index 39ebdc3..27858e4 100755
--- a/tests/generic/277
+++ b/tests/generic/277
@@ -44,7 +44,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_attrs
+_require_chattr A
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
-- 
2.5.0

