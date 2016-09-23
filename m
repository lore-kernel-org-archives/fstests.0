Received: from mx1.redhat.com ([209.132.183.28]:49488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760693AbcIWQy5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Sep 2016 12:54:57 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0F2F793C1
        for <fstests@vger.kernel.org>; Fri, 23 Sep 2016 16:54:56 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/317: use id to get user id
Date: Sat, 24 Sep 2016 00:54:36 +0800
Message-Id: <1474649676-31602-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Greping username "fsgqa" in passwd file to get user id doesn't
always work, because the given username could match multiple
entries, e.g. when we have user "123456-fsgqa" (used by other tests)
in passwd file.

Fix it by using "id -u $qa_user" to get the user id directly.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/317 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/317 b/tests/generic/317
index 9d9499b..7e40b1f 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -61,7 +61,7 @@ _require_scratch
 _require_user
 _require_ugid_map
 _require_userns
-qa_user_id=`grep $qa_user /etc/passwd |awk -F: '{print $3}'`
+qa_user_id=`id -u $qa_user`
 
 _filter_output()
 {
-- 
2.7.4

