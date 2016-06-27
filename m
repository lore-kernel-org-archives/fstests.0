Received: from mx1.redhat.com ([209.132.183.28]:43656 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcF0Wk2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 27 Jun 2016 18:40:28 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 095F085545
	for <fstests@vger.kernel.org>; Mon, 27 Jun 2016 22:40:28 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v7 1/3] generic/026: This test doesn't require runas
Date: Tue, 28 Jun 2016 00:40:20 +0200
Message-Id: <1467067222-18286-2-git-send-email-agruenba@redhat.com>
In-Reply-To: <1467067222-18286-1-git-send-email-agruenba@redhat.com>
References: <1467067222-18286-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 tests/generic/026 | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/generic/026 b/tests/generic/026
index 4d3fac6..69b1cbe 100755
--- a/tests/generic/026
+++ b/tests/generic/026
@@ -29,7 +29,6 @@ echo "QA output created by $seq"
 
 here=`pwd`
 tmp=/tmp/$$
-runas=$here/src/runas
 status=1	# FAILure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -54,8 +53,6 @@ _acl_setup_ids
 _require_acls
 _require_acl_get_max
 
-[ -x $runas ] || _notrun "$runas executable not found"
-
 rm -f $seqres.full
 
 # get dir
-- 
2.5.5

