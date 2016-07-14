Received: from mx1.redhat.com ([209.132.183.28]:52687 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbcGNMno (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Jul 2016 08:43:44 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9538D562A9
	for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 12:43:44 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 5/6] xfstests: update xfs/096 for new behaviour
Date: Thu, 14 Jul 2016 14:43:33 +0200
Message-Id: <1468500214-6237-6-git-send-email-jtulak@redhat.com>
In-Reply-To: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Because we recently changed how mkfs behaves when it gets incorrect/invalid
values, add a feature check to run this test only on older binaries, which
accepts invalid sunit values.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
UPDATE:
Throw away all changes and replace them with a single
_require_xfs_mkfs_without_validation from common/rc.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 tests/xfs/096 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/096 b/tests/xfs/096
index f949e83..64754b2 100755
--- a/tests/xfs/096
+++ b/tests/xfs/096
@@ -105,6 +105,7 @@ _supported_fs xfs
 _supported_os IRIX Linux
 _require_scratch
 _require_v2log
+_require_xfs_mkfs_without_validation
 
 # choose .out file based on internal/external log
 rm -f $seqfull.out
-- 
2.5.5

