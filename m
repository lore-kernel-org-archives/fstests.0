Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53539 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbbCKLPo (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Mar 2015 07:15:44 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2BBFiQD023348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 11 Mar 2015 07:15:44 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/4] new: fix template for new case to use a single tab not four spaces
Date: Wed, 11 Mar 2015 19:15:31 +0800
Message-Id: <1426072534-12246-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1426072534-12246-1-git-send-email-eguan@redhat.com>
References: <1426072534-12246-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

So we have preferred code style for all new test cases.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 new | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/new b/new
index 86f9075..d1f8939 100755
--- a/new
+++ b/new
@@ -148,8 +148,8 @@ trap "_cleanup; exit \\\$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    rm -f \$tmp.*
+	cd /
+	rm -f \$tmp.*
 }
 
 # get standard environment, filters and checks
-- 
2.1.0

