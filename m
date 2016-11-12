Received: from mx1.redhat.com ([209.132.183.28]:44600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966641AbcKLSkt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 12 Nov 2016 13:40:49 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8BBF83F3A
        for <fstests@vger.kernel.org>; Sat, 12 Nov 2016 18:40:48 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic: fix $tmp path in tests
Date: Sun, 13 Nov 2016 02:40:41 +0800
Message-Id: <1478976041-2006-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Some tests use "tmp/$$" as $tmp, and this would result in ENOENT
failure if $tmp is referenced in helpers or tests, because we have
no "tmp" dir in pwd.

Fix them to use "/tmp/$$" as all other tests do.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/018 | 2 +-
 tests/generic/094 | 2 +-
 tests/generic/225 | 2 +-
 tests/generic/249 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/018 b/tests/generic/018
index e8dbab3..e554861 100755
--- a/tests/generic/018
+++ b/tests/generic/018
@@ -26,7 +26,7 @@ seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
 here=`pwd`
-tmp=tmp/$$
+tmp=/tmp/$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/094 b/tests/generic/094
index 005de1d..b686a5b 100755
--- a/tests/generic/094
+++ b/tests/generic/094
@@ -26,7 +26,7 @@ seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
 here=`pwd`
-tmp=tmp/$$
+tmp=/tmp/$$
 status=1  # failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/225 b/tests/generic/225
index 5285e68..544e0be 100755
--- a/tests/generic/225
+++ b/tests/generic/225
@@ -26,7 +26,7 @@ seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
 here=`pwd`
-tmp=tmp/$$
+tmp=/tmp/$$
 status=1  # failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/generic/249 b/tests/generic/249
index d8b4df4..9b75478 100755
--- a/tests/generic/249
+++ b/tests/generic/249
@@ -26,7 +26,7 @@ seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
 
 here=`pwd`
-tmp=tmp/$$
+tmp=/tmp/$$
 status=1  # failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-- 
2.7.4

