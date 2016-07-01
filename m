Received: from mx1.redhat.com ([209.132.183.28]:32857 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbcGAQJO (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 1 Jul 2016 12:09:14 -0400
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 1/2] xfstests: Fix installation for extended names
Date: Fri,  1 Jul 2016 18:09:06 +0200
Message-Id: <1467389347-2055-2-git-send-email-jtulak@redhat.com>
In-Reply-To: <1467389347-2055-1-git-send-email-jtulak@redhat.com>
References: <1467389347-2055-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, eguan@redhat.com, Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

xfstests supports extended test names like 314-foo-bar, but installation of
these tests was skipped (not matching a regexp). So this patch fixes the
makefiles in tests/*/

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
UPDATE:
Rewritten, now it doesn't fail without the extended name, and doesn't
suppress anything. Thanks Dave.
---
 tests/btrfs/Makefile   | 21 +++++++++++++++++----
 tests/cifs/Makefile    | 21 +++++++++++++++++----
 tests/ext4/Makefile    | 21 +++++++++++++++++----
 tests/f2fs/Makefile    | 24 ++++++++++++++++++------
 tests/generic/Makefile | 21 +++++++++++++++++----
 tests/overlay/Makefile | 23 ++++++++++++++++++-----
 tests/shared/Makefile  | 21 +++++++++++++++++----
 tests/udf/Makefile     | 21 +++++++++++++++++----
 tests/xfs/Makefile     | 21 +++++++++++++++++----
 9 files changed, 155 insertions(+), 39 deletions(-)

diff --git a/tests/btrfs/Makefile b/tests/btrfs/Makefile
index e1a5be1..0301d78 100644
--- a/tests/btrfs/Makefile
+++ b/tests/btrfs/Makefile
@@ -5,16 +5,29 @@
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-BTRFS_DIR = btrfs
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(BTRFS_DIR)
+GROUP_DIR = btrfs
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GROUP_DIR)
 
 include $(BUILDRULES)
 
+# note: the second TESTS wildcard gets also .out files, but these will be
+# overwritten with correct permissions a moment later, as they are also in
+# OUTPUTS. Regexps here are really limited, so I didn't find a better
+# solution...
+TESTS = $(wildcard [0-9][0-9][0-9])
+TESTS += $(wildcard [0-9][0-9][0-9]-*)
+
+
+OUTPUTS = $(wildcard [0-9][0-9][0-9].*)
+OUTPUTS += $(wildcard [0-9][0-9][0-9]-*.*)
+
+
+
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTPUTS) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/cifs/Makefile b/tests/cifs/Makefile
index 9176e5c..b0575c2 100644
--- a/tests/cifs/Makefile
+++ b/tests/cifs/Makefile
@@ -5,16 +5,29 @@
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-CIFS_DIR = cifs
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(CIFS_DIR)
+GROUP_DIR = cifs
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GROUP_DIR)
 
 include $(BUILDRULES)
 
+# note: the second TESTS wildcard gets also .out files, but these will be
+# overwritten with correct permissions a moment later, as they are also in
+# OUTPUTS. Regexps here are really limited, so I didn't find a better
+# solution...
+TESTS = $(wildcard [0-9][0-9][0-9])
+TESTS += $(wildcard [0-9][0-9][0-9]-*)
+
+
+OUTPUTS = $(wildcard [0-9][0-9][0-9].*)
+OUTPUTS += $(wildcard [0-9][0-9][0-9]-*.*)
+
+
+
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTPUTS) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/ext4/Makefile b/tests/ext4/Makefile
index 7a3c8e1..5c562a8 100644
--- a/tests/ext4/Makefile
+++ b/tests/ext4/Makefile
@@ -5,16 +5,29 @@
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-EXT4_DIR = ext4
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(EXT4_DIR)
+GROUP_DIR = ext4
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GROUP_DIR)
 
 include $(BUILDRULES)
 
+# note: the second TESTS wildcard gets also .out files, but these will be
+# overwritten with correct permissions a moment later, as they are also in
+# OUTPUTS. Regexps here are really limited, so I didn't find a better
+# solution...
+TESTS = $(wildcard [0-9][0-9][0-9])
+TESTS += $(wildcard [0-9][0-9][0-9]-*)
+
+
+OUTPUTS = $(wildcard [0-9][0-9][0-9].*)
+OUTPUTS += $(wildcard [0-9][0-9][0-9]-*.*)
+
+
+
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTPUTS) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/f2fs/Makefile b/tests/f2fs/Makefile
index 4d00e9e..bc0a7fd 100644
--- a/tests/f2fs/Makefile
+++ b/tests/f2fs/Makefile
@@ -1,21 +1,33 @@
 #
-#  Copyright (c) 2015 Fujitsu Ltd.
-#  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
 #
 
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-F2FS_DIR = f2fs
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(F2FS_DIR)
+GROUP_DIR = f2fs
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GROUP_DIR)
 
 include $(BUILDRULES)
 
+# note: the second TESTS wildcard gets also .out files, but these will be
+# overwritten with correct permissions a moment later, as they are also in
+# OUTPUTS. Regexps here are really limited, so I didn't find a better
+# solution...
+TESTS = $(wildcard [0-9][0-9][0-9])
+TESTS += $(wildcard [0-9][0-9][0-9]-*)
+
+
+OUTPUTS = $(wildcard [0-9][0-9][0-9].*)
+OUTPUTS += $(wildcard [0-9][0-9][0-9]-*.*)
+
+
+
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTPUTS) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/generic/Makefile b/tests/generic/Makefile
index 9529fb8..6ca5df8 100644
--- a/tests/generic/Makefile
+++ b/tests/generic/Makefile
@@ -5,16 +5,29 @@
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-GENERIC_DIR = generic
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GENERIC_DIR)
+GROUP_DIR = generic
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GROUP_DIR)
 
 include $(BUILDRULES)
 
+# note: the second TESTS wildcard gets also .out files, but these will be
+# overwritten with correct permissions a moment later, as they are also in
+# OUTPUTS. Regexps here are really limited, so I didn't find a better
+# solution...
+TESTS = $(wildcard [0-9][0-9][0-9])
+TESTS += $(wildcard [0-9][0-9][0-9]-*)
+
+
+OUTPUTS = $(wildcard [0-9][0-9][0-9].*)
+OUTPUTS += $(wildcard [0-9][0-9][0-9]-*.*)
+
+
+
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTPUTS) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/overlay/Makefile b/tests/overlay/Makefile
index 63c9878..2a49585 100644
--- a/tests/overlay/Makefile
+++ b/tests/overlay/Makefile
@@ -1,20 +1,33 @@
 #
-# Copyright (c) 2016 Red Hat Inc.  All Rights Reserved.
+# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
 #
 
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-TEST_DIR = overlay
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(TEST_DIR)
+GROUP_DIR = overlay
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GROUP_DIR)
 
 include $(BUILDRULES)
 
+# note: the second TESTS wildcard gets also .out files, but these will be
+# overwritten with correct permissions a moment later, as they are also in
+# OUTPUTS. Regexps here are really limited, so I didn't find a better
+# solution...
+TESTS = $(wildcard [0-9][0-9][0-9])
+TESTS += $(wildcard [0-9][0-9][0-9]-*)
+
+
+OUTPUTS = $(wildcard [0-9][0-9][0-9].*)
+OUTPUTS += $(wildcard [0-9][0-9][0-9]-*.*)
+
+
+
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTPUTS) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/shared/Makefile b/tests/shared/Makefile
index cbd87f9..381abe9 100644
--- a/tests/shared/Makefile
+++ b/tests/shared/Makefile
@@ -5,16 +5,29 @@
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-SHARED_DIR = shared
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(SHARED_DIR)
+GROUP_DIR = shared
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GROUP_DIR)
 
 include $(BUILDRULES)
 
+# note: the second TESTS wildcard gets also .out files, but these will be
+# overwritten with correct permissions a moment later, as they are also in
+# OUTPUTS. Regexps here are really limited, so I didn't find a better
+# solution...
+TESTS = $(wildcard [0-9][0-9][0-9])
+TESTS += $(wildcard [0-9][0-9][0-9]-*)
+
+
+OUTPUTS = $(wildcard [0-9][0-9][0-9].*)
+OUTPUTS += $(wildcard [0-9][0-9][0-9]-*.*)
+
+
+
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTPUTS) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/udf/Makefile b/tests/udf/Makefile
index 1d96658..d9e388c 100644
--- a/tests/udf/Makefile
+++ b/tests/udf/Makefile
@@ -5,16 +5,29 @@
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-UDF_DIR = udf
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(UDF_DIR)
+GROUP_DIR = udf
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GROUP_DIR)
 
 include $(BUILDRULES)
 
+# note: the second TESTS wildcard gets also .out files, but these will be
+# overwritten with correct permissions a moment later, as they are also in
+# OUTPUTS. Regexps here are really limited, so I didn't find a better
+# solution...
+TESTS = $(wildcard [0-9][0-9][0-9])
+TESTS += $(wildcard [0-9][0-9][0-9]-*)
+
+
+OUTPUTS = $(wildcard [0-9][0-9][0-9].*)
+OUTPUTS += $(wildcard [0-9][0-9][0-9]-*.*)
+
+
+
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTPUTS) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/xfs/Makefile b/tests/xfs/Makefile
index db94be0..824e32c 100644
--- a/tests/xfs/Makefile
+++ b/tests/xfs/Makefile
@@ -5,16 +5,29 @@
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-XFS_DIR = xfs
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(XFS_DIR)
+GROUP_DIR = xfs
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GROUP_DIR)
 
 include $(BUILDRULES)
 
+# note: the second TESTS wildcard gets also .out files, but these will be
+# overwritten with correct permissions a moment later, as they are also in
+# OUTPUTS. Regexps here are really limited, so I didn't find a better
+# solution...
+TESTS = $(wildcard [0-9][0-9][0-9])
+TESTS += $(wildcard [0-9][0-9][0-9]-*)
+
+
+OUTPUTS = $(wildcard [0-9][0-9][0-9].*)
+OUTPUTS += $(wildcard [0-9][0-9][0-9]-*.*)
+
+
+
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTPUTS) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
-- 
2.5.5

