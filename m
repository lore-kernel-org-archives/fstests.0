Received: from imap.thunk.org ([74.207.234.97]:33630 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbcDCE5T (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 3 Apr 2016 00:57:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic/082: filter out project quota status
Date: Sun,  3 Apr 2016 00:57:12 -0400
Message-Id: <1459659432-13126-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

In the most recent quota tools package, with the new project quota
support, quotaon -p prints an extra line which generic/082.out isn't
expecting.  So filter it out.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/082 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/generic/082 b/tests/generic/082
index ca77c25..a727c10 100755
--- a/tests/generic/082
+++ b/tests/generic/082
@@ -36,6 +36,11 @@ _cleanup()
 	rm -f $tmp.*
 }
 
+_filter_project_quota()
+{
+    grep -v "^project quota on"
+}
+
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
@@ -64,7 +69,7 @@ quotaon $SCRATCH_MNT >>$seqres.full 2>&1
 # just ignored, but quota is still on. This may change in future, let's
 # re-consider the case then.
 _scratch_mount "-o remount,ro,nosuchopt" >>$seqres.full 2>&1
-quotaon -p $SCRATCH_MNT | _filter_scratch
+quotaon -p $SCRATCH_MNT | _filter_scratch | _filter_project_quota
 # second remount should succeed, no oops or hang expected
 _scratch_mount "-o remount,ro" || _fail "second remount,ro failed"
 
-- 
2.5.0

