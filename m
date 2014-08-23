Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:53870 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbaHWIQc (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 23 Aug 2014 04:16:32 -0400
From: Pavel Shilovsky <pshilovsky@samba.org>
Subject: [PATCH 2/2] common: add a directory tree for cifs tests
Date: Sat, 23 Aug 2014 12:16:03 +0400
Message-Id: <1408781763-30127-3-git-send-email-pshilovsky@samba.org>
In-Reply-To: <1408781763-30127-1-git-send-email-pshilovsky@samba.org>
References: <1408781763-30127-1-git-send-email-pshilovsky@samba.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Pavel Shilovsky <pshilovsky@samba.org>
---
 tests/cifs/Makefile | 14 ++++++++++++++
 tests/cifs/group    |  5 +++++
 2 files changed, 19 insertions(+)
 create mode 100644 tests/cifs/Makefile
 create mode 100644 tests/cifs/group

diff --git a/tests/cifs/Makefile b/tests/cifs/Makefile
new file mode 100644
index 0000000..37e868b
--- /dev/null
+++ b/tests/cifs/Makefile
@@ -0,0 +1,14 @@
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
+	$(INSTALL) -m 644 group $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
diff --git a/tests/cifs/group b/tests/cifs/group
new file mode 100644
index 0000000..4e01f0c
--- /dev/null
+++ b/tests/cifs/group
@@ -0,0 +1,5 @@
+# QA groups control file
+# Defines test groups and nominal group owners
+# - do not start group names with a digit
+# - comment line before each group is "new" description
+#
-- 
1.9.1

