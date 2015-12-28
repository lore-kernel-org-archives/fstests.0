Received: from cn.fujitsu.com ([59.151.112.132]:51109 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751874AbbL1KcK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 28 Dec 2015 05:32:10 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id C0C3441887CB
	for <fstests@vger.kernel.org>; Mon, 28 Dec 2015 18:31:26 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] f2fs: add Makefile for f2fs
Date: Mon, 28 Dec 2015 18:27:48 +0800
Message-ID: <1451298468-19509-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Installation failed due to Makefile omission, so fix this.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/f2fs/Makefile | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 tests/f2fs/Makefile

diff --git a/tests/f2fs/Makefile b/tests/f2fs/Makefile
new file mode 100644
index 0000000..4d00e9e
--- /dev/null
+++ b/tests/f2fs/Makefile
@@ -0,0 +1,21 @@
+#
+#  Copyright (c) 2015 Fujitsu Ltd.
+#  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+
+F2FS_DIR = f2fs
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(F2FS_DIR)
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
1.8.3.1



