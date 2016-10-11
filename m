Received: from mx1.redhat.com ([209.132.183.28]:47518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbcJKK2E (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Oct 2016 06:28:04 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F27A12B8
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2016 10:26:40 +0000 (UTC)
Received: from bcodding.csb (vpn-60-205.rdu2.redhat.com [10.10.60.205])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u9BAQdXe012190
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2016 06:26:40 -0400
From: Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH] generic/317: fixup grep for qa_user_id
Date: Tue, 11 Oct 2016 06:26:38 -0400
Message-Id: <fb1905dab09a7e9d9d8952da56d90aaba2403a57.1476181339.git.bcodding@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The grep for $qa_user_id can return more than one entry.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 tests/generic/317 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/317 b/tests/generic/317
index 9d9499ba04dd..ddaa6b59afc5 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -61,7 +61,7 @@ _require_scratch
 _require_user
 _require_ugid_map
 _require_userns
-qa_user_id=`grep $qa_user /etc/passwd |awk -F: '{print $3}'`
+qa_user_id=`grep ^${qa_user}: /etc/passwd |awk -F: '{print $3}'`
 
 _filter_output()
 {
-- 
2.5.5

