Received: from mx1.redhat.com ([209.132.183.28]:42633 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426AbcGNMnq (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Jul 2016 08:43:46 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0B74883C5
	for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 12:43:40 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 1/6] xfstests: Fix installation for extended names
Date: Thu, 14 Jul 2016 14:43:29 +0200
Message-Id: <1468500214-6237-2-git-send-email-jtulak@redhat.com>
In-Reply-To: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

xfstests supports extended test names like 314-foo-bar, but installation of
these tests was skipped (not matching a regexp). So this patch fixes the
makefiles in tests/*/

The include/buildrules change was written by Dave Chinner.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 include/buildrules     | 31 +++++++++++++++++++++++++++++++
 tests/btrfs/Makefile   |  4 ++--
 tests/cifs/Makefile    |  4 ++--
 tests/ext4/Makefile    |  4 ++--
 tests/f2fs/Makefile    |  4 ++--
 tests/generic/Makefile |  4 ++--
 tests/overlay/Makefile |  4 ++--
 tests/shared/Makefile  |  4 ++--
 tests/udf/Makefile     |  4 ++--
 tests/xfs/Makefile     |  4 ++--
 10 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/include/buildrules b/include/buildrules
index c8a7c47..1269c8c 100644
--- a/include/buildrules
+++ b/include/buildrules
@@ -100,3 +100,34 @@ MAKEDEP := $(MAKEDEPEND) $(CFLAGS)
 	    cp /dev/null .dep; \
 	fi
 
+# Gather files for installing into two lists:
+# TESTS with executable scripts and OUTFILES with all the test outputs.
+# Makefile has a very small matching, so we have to go this long way.
+
+# Start with all test related files:
+ALLFILES = $(wildcard [0-9]??*)
+
+# Now build a list of known output files.  Unfortunately, the
+# multiple output test files are poorly handled as makefiles don't
+# handle wildcarded multi-suffix matching. Hence we separate the
+# processing of these right now.
+EXTENDED_OUTFILES = $(wildcard [0-9]??*.out.*)
+BASIC_OUTFILES = $(wildcard [0-9]??*.out)
+OUTFILES = $(EXTENDED_OUTFILES) $(BASIC_OUTFILES)
+
+# Strip suffix to get matching tests. We want to strip from the
+# first "." to the end, but makefiles don't have a built in
+# operative for that. So:
+#
+# Hack: strip the multiple segments after .out with repeated basename calls.
+EXTFILTER1 = $(basename $(EXTENDED_OUTFILES))
+EXTFILTER2 = $(basename $(EXTFILTER1))
+EXTFILTER3 = $(basename $(EXTFILTER2))
+EXTFILTER4 = $(basename $(EXTFILTER3))
+
+# final filter list
+FILTER = $(basename $(EXTFILTER4) $(BASIC_OUTFILES))
+
+# finally, select the test files by filtering against against the
+# stripped output files and sort them to remove duplicates.
+TESTS = $(sort $(filter $(ALLFILES), $(FILTER)))
diff --git a/tests/btrfs/Makefile b/tests/btrfs/Makefile
index e1a5be1..2d93642 100644
--- a/tests/btrfs/Makefile
+++ b/tests/btrfs/Makefile
@@ -12,9 +12,9 @@ include $(BUILDRULES)
 
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/cifs/Makefile b/tests/cifs/Makefile
index 9176e5c..0c5cf3b 100644
--- a/tests/cifs/Makefile
+++ b/tests/cifs/Makefile
@@ -12,9 +12,9 @@ include $(BUILDRULES)
 
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/ext4/Makefile b/tests/ext4/Makefile
index 7a3c8e1..beb1541 100644
--- a/tests/ext4/Makefile
+++ b/tests/ext4/Makefile
@@ -12,9 +12,9 @@ include $(BUILDRULES)
 
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/f2fs/Makefile b/tests/f2fs/Makefile
index 4d00e9e..d13bca3 100644
--- a/tests/f2fs/Makefile
+++ b/tests/f2fs/Makefile
@@ -13,9 +13,9 @@ include $(BUILDRULES)
 
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/generic/Makefile b/tests/generic/Makefile
index 9529fb8..3878d05 100644
--- a/tests/generic/Makefile
+++ b/tests/generic/Makefile
@@ -12,9 +12,9 @@ include $(BUILDRULES)
 
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/overlay/Makefile b/tests/overlay/Makefile
index 63c9878..b07f892 100644
--- a/tests/overlay/Makefile
+++ b/tests/overlay/Makefile
@@ -12,9 +12,9 @@ include $(BUILDRULES)
 
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/shared/Makefile b/tests/shared/Makefile
index cbd87f9..8a83278 100644
--- a/tests/shared/Makefile
+++ b/tests/shared/Makefile
@@ -12,9 +12,9 @@ include $(BUILDRULES)
 
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/udf/Makefile b/tests/udf/Makefile
index 1d96658..c9c9f1b 100644
--- a/tests/udf/Makefile
+++ b/tests/udf/Makefile
@@ -12,9 +12,9 @@ include $(BUILDRULES)
 
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
diff --git a/tests/xfs/Makefile b/tests/xfs/Makefile
index db94be0..d64800e 100644
--- a/tests/xfs/Makefile
+++ b/tests/xfs/Makefile
@@ -12,9 +12,9 @@ include $(BUILDRULES)
 
 install:
 	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
 	$(INSTALL) -m 644 group $(TARGET_DIR)
-	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
 
 # Nothing.
 install-dev install-lib:
-- 
2.5.5

