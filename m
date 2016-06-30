Received: from mx1.redhat.com ([209.132.183.28]:60649 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbcF3QQJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 12:16:09 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 534028553D
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 16:06:35 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH v3] xfstests: Fix installation for extended
Date: Thu, 30 Jun 2016 18:06:24 +0200
Message-Id: <1467302784-32755-1-git-send-email-jtulak@redhat.com>
In-Reply-To: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
References: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

xfstests supports extended test names like 314-foo-bar, but installation of
these tests was skipped (not matching a regexp). So this patch fixes the
makefiles in tests/xfs/.

This change will have to be repeated later for other directories, as adding it
now everywhere would cause make install to fail if no such extended name is
present in the dir.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
UPDATE:
Let it be just in tests/xfs/.

NOTE: if tested without at first merging my 400-input-valiation test, make
install will fail again. :-)

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 tests/xfs/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/xfs/Makefile b/tests/xfs/Makefile
index db94be0..e9b98a3 100644
--- a/tests/xfs/Makefile
+++ b/tests/xfs/Makefile
@@ -13,8 +13,10 @@ include $(BUILDRULES)
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
 	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
-- 
2.5.5

