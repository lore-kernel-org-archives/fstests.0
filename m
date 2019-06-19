Received: from mail-pf1-f193.google.com ([209.85.210.193]:36313 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSC3m (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jun 2019 22:29:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so8774425pfl.3
        for <fstests@vger.kernel.org>; Tue, 18 Jun 2019 19:29:42 -0700 (PDT)
From: Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH] generic/532: note the kernel commit
Date: Wed, 19 Jun 2019 10:28:55 +0800
Message-Id: <20190619022855.24308-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Murphy Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: Murphy Zhou <xzhou@redhat.com>

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 tests/generic/532 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/532 b/tests/generic/532
index 3f8afa4a..007af792 100755
--- a/tests/generic/532
+++ b/tests/generic/532
@@ -5,7 +5,8 @@
 # FS QA Test No. 532
 #
 # Regression test for a bug where XFS fails to set statx attributes_mask but
-# sets attribute flags anyway.
+# sets attribute flags anyway. Fixed by commit:
+#    1b9598c8  xfs: fix reporting supported extra file attributes for statx()
 #
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
-- 
2.21.0
