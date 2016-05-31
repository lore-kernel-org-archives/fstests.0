Received: from mx1.redhat.com ([209.132.183.28]:39252 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbcEaUTA (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 31 May 2016 16:19:00 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1B6D50F5F
	for <fstests@vger.kernel.org>; Tue, 31 May 2016 20:18:58 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 2/3] generic/026: This test doesn't require runas
Date: Tue, 31 May 2016 22:18:50 +0200
Message-Id: <1464725931-27588-2-git-send-email-agruenba@redhat.com>
In-Reply-To: <1464725931-27588-1-git-send-email-agruenba@redhat.com>
References: <1464725931-27588-1-git-send-email-agruenba@redhat.com>
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

