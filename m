Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53750 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbaLOKnm (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 05:43:42 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 7CE1FAD6F
	for <fstests@vger.kernel.org>; Mon, 15 Dec 2014 10:43:41 +0000 (UTC)
From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] cifs: add missing Makefile
Date: Mon, 15 Dec 2014 11:43:30 +0100
Message-Id: <1418640210-16914-1-git-send-email-ddiss@suse.de>
In-Reply-To: <20141215110431.65c8bd80@plati.site>
References: <20141215110431.65c8bd80@plati.site>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
List-ID: <fstests@vger.kernel.org>

This fixes the make install target, which traverses all tests/*
subdirectories.

Reported-by: David Drysdale <drysdale@google.com>
Signed-off-by: David Disseldorp <ddiss@suse.de>
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
2.1.2

