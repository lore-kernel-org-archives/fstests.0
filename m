Return-Path: <fstests-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41600 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbaLOUYp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 15:24:45 -0500
From: Vishal Verma <vishal.l.verma@linux.intel.com>
Subject: [PATCH] cifs: Add Makefile
Date: Mon, 15 Dec 2014 13:24:05 -0700
Message-Id: <1418675045-22541-1-git-send-email-vishal.l.verma@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: pshilovsky@samba.org, Vishal Verma <vishal.l.verma@linux.intel.com>
List-ID: <fstests@vger.kernel.org>

tests/cifs lacked a Makefile, and this caused the %install section of
rpmbuild to fail. Add a boilerplate Makefile (from tests/ext4)

Signed-off-by: Vishal Verma <vishal.l.verma@linux.intel.com>
---
 tests/cifs/Makefile | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 tests/cifs/Makefile

diff --git a/tests/cifs/Makefile b/tests/cifs/Makefile
new file mode 100644
index 0000000..9176e5c
--- /dev/null
+++ b/tests/cifs/Makefile
@@ -0,0 +1,20 @@
+#
+# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+
+CIFS_DIR = cifs
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(CIFS_DIR)
+
+include $(BUILDRULES)
+
+install:
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 644 group $(TARGET_DIR)
+	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
-- 
2.1.0

