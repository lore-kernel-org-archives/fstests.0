Received: from mx1.redhat.com ([209.132.183.28]:37503 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932081AbcF3IqY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 04:46:24 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 190826408A
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 08:35:28 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH v2] xfstests: Fix installation for extended names
Date: Thu, 30 Jun 2016 10:35:10 +0200
Message-Id: <1467275710-403-1-git-send-email-jtulak@redhat.com>
In-Reply-To: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
References: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

xfstests supports extended test names like 314-foo-bar, but installation of
these tests was skipped (not matching a regexp). So this patch fixes the
makefiles in tests directories.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
UPDATE:
  * install failed when no extended name was present, so suppress errors for
    extended names
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
index e1a5be1..63c1111 100644
--- a/tests/btrfs/Makefile
+++ b/tests/btrfs/Makefile
@@ -13,8 +13,10 @@ include $(BUILDRULES)
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	-$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR) 2>/dev/null;true
 	$(INSTALL) -m 644 group $(TARGET_DIR)
 	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	-$(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR) 2>/dev/null;true
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/cifs/Makefile b/tests/cifs/Makefile
index 9176e5c..93a9d69 100644
--- a/tests/cifs/Makefile
+++ b/tests/cifs/Makefile
@@ -13,8 +13,10 @@ include $(BUILDRULES)
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	-$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR) 2>/dev/null;true
 	$(INSTALL) -m 644 group $(TARGET_DIR)
 	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	-$(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR) 2>/dev/null;true
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/ext4/Makefile b/tests/ext4/Makefile
index 7a3c8e1..c7de3f1 100644
--- a/tests/ext4/Makefile
+++ b/tests/ext4/Makefile
@@ -13,8 +13,10 @@ include $(BUILDRULES)
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	-$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR) 2>/dev/null;true
 	$(INSTALL) -m 644 group $(TARGET_DIR)
 	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	-$(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR) 2>/dev/null;true
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/f2fs/Makefile b/tests/f2fs/Makefile
index 4d00e9e..e507495 100644
--- a/tests/f2fs/Makefile
+++ b/tests/f2fs/Makefile
@@ -14,8 +14,10 @@ include $(BUILDRULES)
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	-$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR) 2>/dev/null;true
 	$(INSTALL) -m 644 group $(TARGET_DIR)
 	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	-$(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR) 2>/dev/null;true
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/generic/Makefile b/tests/generic/Makefile
index 9529fb8..f449dc3 100644
--- a/tests/generic/Makefile
+++ b/tests/generic/Makefile
@@ -13,8 +13,10 @@ include $(BUILDRULES)
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	-$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR) 2>/dev/null;true
 	$(INSTALL) -m 644 group $(TARGET_DIR)
 	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	-$(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR) 2>/dev/null;true
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/overlay/Makefile b/tests/overlay/Makefile
index 63c9878..e8459e0 100644
--- a/tests/overlay/Makefile
+++ b/tests/overlay/Makefile
@@ -13,8 +13,10 @@ include $(BUILDRULES)
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	-$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR) 2>/dev/null;true
 	$(INSTALL) -m 644 group $(TARGET_DIR)
 	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	-$(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR) 2>/dev/null;true
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/shared/Makefile b/tests/shared/Makefile
index cbd87f9..d9148ec 100644
--- a/tests/shared/Makefile
+++ b/tests/shared/Makefile
@@ -13,8 +13,10 @@ include $(BUILDRULES)
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	-$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR) 2>/dev/null;true
 	$(INSTALL) -m 644 group $(TARGET_DIR)
 	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	-$(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR) 2>/dev/null;true
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/udf/Makefile b/tests/udf/Makefile
index 1d96658..9822e3c 100644
--- a/tests/udf/Makefile
+++ b/tests/udf/Makefile
@@ -13,8 +13,10 @@ include $(BUILDRULES)
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	-$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR) 2>/dev/null;true
 	$(INSTALL) -m 644 group $(TARGET_DIR)
 	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	-$(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR) 2>/dev/null;true
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/xfs/Makefile b/tests/xfs/Makefile
index db94be0..28e0887 100644
--- a/tests/xfs/Makefile
+++ b/tests/xfs/Makefile
@@ -13,8 +13,10 @@ include $(BUILDRULES)
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
 	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	-$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR) 2>/dev/null;true
 	$(INSTALL) -m 644 group $(TARGET_DIR)
 	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	-$(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR) 2>/dev/null;true
 
 # Nothing.
 install-dev install-lib:
-- 
2.5.5

