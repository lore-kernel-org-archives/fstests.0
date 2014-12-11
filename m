Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43706 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514AbaLKRTq (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Dec 2014 12:19:46 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBBHJeM8030334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 11 Dec 2014 12:19:45 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 4/4] common: fix comment about _require_test
Date: Fri, 12 Dec 2014 01:16:11 +0800
Message-Id: <1418318171-5892-5-git-send-email-eguan@redhat.com>
In-Reply-To: <1418318171-5892-1-git-send-email-eguan@redhat.com>
References: <1418318171-5892-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

_require_test will mount test dev if not mounted, fix the comment to
reflect that.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index d5e3aff..9a4da56 100644
--- a/common/rc
+++ b/common/rc
@@ -1104,7 +1104,7 @@ _require_scratch()
 }
 
 
-# this test needs a test partition - check we're ok & unmount it
+# this test needs a test partition - check we're ok & mount it
 #
 _require_test()
 {
-- 
1.8.3.1

