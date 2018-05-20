Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751162AbeETQWM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 20 May 2018 12:22:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 120BA81FE170
        for <fstests@vger.kernel.org>; Sun, 20 May 2018 16:22:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25F60215CDA7
        for <fstests@vger.kernel.org>; Sun, 20 May 2018 16:22:10 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] common/quota: sort lines of repquota output
Date: Mon, 21 May 2018 00:22:02 +0800
Message-Id: <20180520162202.13567-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The golden image of some cases (e.g: generic/305 generic/326
generic/327 generic/328 xfs/214 xfs/330 and xfs/440) depend on the
output of repquota() function.

When it reports multi-users, we can't control the order of lines,
then always hit failures likes:

  ...
   Create the original files
  -root 3072 0 0
   nobody 0 0 0
   fsgqa 0 0 0
  +root 3072 0 0
  ...

So sort the lines to make sure it won't break the golden image.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/quota  | 4 ++--
 tests/xfs/330 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/quota b/common/quota
index f01bd068..68c350ee 100644
--- a/common/quota
+++ b/common/quota
@@ -308,12 +308,12 @@ _check_quota_usage()
 
 # Report the block usage of root, $qa_user, and nobody
 _report_quota_blocks() {
-	repquota $1 | egrep "^($qa_user|root|nobody)" | awk '{print $1, $3, $4, $5}'
+	repquota $1 | egrep "^($qa_user|root|nobody)" | awk '{print $1, $3, $4, $5}' | sort -r
 }
 
 # Report the inode usage of root, $qa_user, and nobody
 _report_quota_inodes() {
-	repquota $1 | egrep "^($qa_user|root|nobody)" | awk '{print $1, $6, $7, $8}'
+	repquota $1 | egrep "^($qa_user|root|nobody)" | awk '{print $1, $6, $7, $8}' | sort -r
 }
 
 # make sure this script returns success
diff --git a/tests/xfs/330 b/tests/xfs/330
index 8260bdda..d49f2723 100755
--- a/tests/xfs/330
+++ b/tests/xfs/330
@@ -53,7 +53,7 @@ _require_nobody
 
 do_repquota()
 {
-	repquota $SCRATCH_MNT | egrep '^(fsgqa|root|nobody)'
+	repquota $SCRATCH_MNT | egrep '^(fsgqa|root|nobody)' | sort -r
 }
 
 rm -f "$seqres.full"
-- 
2.14.3

