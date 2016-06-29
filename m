Received: from mx1.redhat.com ([209.132.183.28]:38395 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381AbcF2PIm (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 29 Jun 2016 11:08:42 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 625A661A19
	for <fstests@vger.kernel.org>; Wed, 29 Jun 2016 14:58:02 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH] xfstests: Fix installation for extended names
Date: Wed, 29 Jun 2016 16:57:55 +0200
Message-Id: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

xfstests supports extended test names like 314-foo-bar, but installation of
these tests was skipped (not matching a regexp). So this patch fixes the
makefiles in tests directories.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 tests/btrfs/Makefile   | 2 ++
 tests/cifs/Makefile    | 2 ++
 tests/ext4/Makefile    | 2 ++
 tests/f2fs/Makefile    | 2 ++
 tests/generic/Makefile | 2 ++
 tests/overlay/Makefile | 2 ++
 tests/shared/Makefile  | 2 ++
 tests/udf/Makefile     | 2 ++
 tests/xfs/Makefile     | 2 ++
 9 files changed, 18 insertions(+)

diff --git a/tests/btrfs/Makefile b/tests/btrfs/Makefile
index e1a5be1..074204c 100644
--- a/tests/btrfs/Makefile
+++ b/tests/btrfs/Makefile
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
diff --git a/tests/cifs/Makefile b/tests/cifs/Makefile
index 9176e5c..f6bff4f 100644
--- a/tests/cifs/Makefile
+++ b/tests/cifs/Makefile
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
diff --git a/tests/ext4/Makefile b/tests/ext4/Makefile
index 7a3c8e1..f7056a0 100644
--- a/tests/ext4/Makefile
+++ b/tests/ext4/Makefile
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
diff --git a/tests/f2fs/Makefile b/tests/f2fs/Makefile
index 4d00e9e..0805348 100644
--- a/tests/f2fs/Makefile
+++ b/tests/f2fs/Makefile
@@ -14,8 +14,10 @@ include $(BUILDRULES)
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
 	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/generic/Makefile b/tests/generic/Makefile
index 9529fb8..b90d6c9 100644
--- a/tests/generic/Makefile
+++ b/tests/generic/Makefile
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
diff --git a/tests/overlay/Makefile b/tests/overlay/Makefile
index 63c9878..3bc3a9b 100644
--- a/tests/overlay/Makefile
+++ b/tests/overlay/Makefile
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
diff --git a/tests/shared/Makefile b/tests/shared/Makefile
index cbd87f9..3854783 100644
--- a/tests/shared/Makefile
+++ b/tests/shared/Makefile
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
diff --git a/tests/udf/Makefile b/tests/udf/Makefile
index 1d96658..6f23935 100644
--- a/tests/udf/Makefile
+++ b/tests/udf/Makefile
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

