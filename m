Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44179 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbbCTKRs (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 06:17:48 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2KAHmZ7021731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 06:17:48 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 9/9] generic/077: add missing _require_scratch
Date: Fri, 20 Mar 2015 18:16:58 +0800
Message-Id: <1426846618-23413-10-git-send-email-eguan@redhat.com>
In-Reply-To: <1426846618-23413-1-git-send-email-eguan@redhat.com>
References: <1426846618-23413-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

generic/077 uses $SCRATCH_DEV without _require_scratch. Add it back.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/077 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/077 b/tests/generic/077
index 0d6aec7..8405b02 100755
--- a/tests/generic/077
+++ b/tests/generic/077
@@ -54,6 +54,7 @@ _supported_os Linux
 
 [ ! -d $filler ] && _notrun "No directory to source files from"
 
+_require_scratch
 _require_attrs
 _require_acls
 _require_user
-- 
2.1.0

