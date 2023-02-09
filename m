Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2166C05027
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Feb 2023 01:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjBIBb6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Feb 2023 20:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBIBbz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Feb 2023 20:31:55 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3FFF767
        for <fstests@vger.kernel.org>; Wed,  8 Feb 2023 17:31:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d8so34725plr.10
        for <fstests@vger.kernel.org>; Wed, 08 Feb 2023 17:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPn+2DnlcJilZNEeaQJw316Ng0KZy9lo3maI1EtPjQ8=;
        b=ebWlSefYW40juFHMj2cEM0e2FUul4ToFR0WYpWzoIxwZ31SXbOIq5ERpZXvg3uPrNy
         trvyP7orGmwNMfvdh8E1Js7dKaXyb8Y/SS7suGTRmi0GYJ+bSzt3ohM2B2X7jYG3acFV
         n16fKrQTqA47ZfB0cQveQkpp3eIsWzxr30LhZGtSzvYnk2PFfURWMm1yVspV7u1UGF5E
         Ds7WNKDUBd0IvWHGCkPT+WUvSdFTjUEDnaAwOraBmGJGgZ2JtSnvL7TwCRLmHA4+DxJz
         32Z05fLEjKwea8bRHB9mBpXg3hmYYILDhsC8PDKHc14QbnRD7KEQsciEUkkT5oxlQCkj
         DDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPn+2DnlcJilZNEeaQJw316Ng0KZy9lo3maI1EtPjQ8=;
        b=OXDre8AP/x0XzbG/9KuiJ856LYZRNl7bp3WHBxzojQyfxplPnngHmSyDT0J7vZL+dO
         cu7cbfwa2vMr1/+ioxg0E+5bzwSQFKCI0/qM9Geb5HDoK2XeGP5Eh5LtJbltwuashvss
         KmEYOGTsfHpWLGeknwdJMzU8wXNAuoGYb0FW8DSdmfW0WWKRaQ3xUy/5HvG7jdECsjsL
         LPH3KgftWpffMV7ScKFGyzeQCdLsC2BJHPr8+CJWnAbkYjvGWqM3xPOR6RTzl0x3dGUW
         gFUpUFDhvi8nnt7mg6uz2z48AUbgyPnHPFdpeFXiIEMIZzGFNxPNfFIKBieUbtFubx/p
         zE/Q==
X-Gm-Message-State: AO0yUKXbqRI12xUrYtCcyak4BBBKlXkAZjPJH12D70QMObdmGGVDnSh0
        Q/s9CnFZv81GEFxtI9jkwyaJzcXc8AltOQ==
X-Google-Smtp-Source: AK7set+xiUFj/NiDnwZsR294/tfCaC2HBwRsa+4cNSaibDQGlFigXqO0Tnf82MDdmJVkB4uIgQTRew==
X-Received: by 2002:a17:90b:1c8f:b0:22c:4d85:1725 with SMTP id oo15-20020a17090b1c8f00b0022c4d851725mr10408600pjb.9.1675906312635;
        Wed, 08 Feb 2023 17:31:52 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2d4:203:726:5e6d:fcde:4245])
        by smtp.gmail.com with ESMTPSA id q32-20020a17090a4fa300b00230d7b6d162sm2186322pjh.37.2023.02.08.17.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 17:31:52 -0800 (PST)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH] debug: add tests for debugging testing setup
Date:   Wed,  8 Feb 2023 17:31:43 -0800
Message-Id: <20230209013143.2586104-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Many people have developed infrastructure around xfstests. In order to
test a setup, it would be helpful to have dummy tests that have
consistent test outcomes. Add a new test folder with the following
debugging tests:

debug/001 pass
debug/002 fail
debug/003 skip
debug/004 crash
debug/005 hang

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 doc/group-names.txt  |  1 +
 tests/debug/001      | 14 ++++++++++++++
 tests/debug/001.out  |  2 ++
 tests/debug/002      | 14 ++++++++++++++
 tests/debug/002.out  |  2 ++
 tests/debug/003      | 16 ++++++++++++++++
 tests/debug/003.out  |  2 ++
 tests/debug/004      | 17 +++++++++++++++++
 tests/debug/004.out  |  2 ++
 tests/debug/005      | 20 ++++++++++++++++++++
 tests/debug/005.out  |  2 ++
 tests/debug/Makefile | 24 ++++++++++++++++++++++++
 12 files changed, 116 insertions(+)
 create mode 100755 tests/debug/001
 create mode 100644 tests/debug/001.out
 create mode 100755 tests/debug/002
 create mode 100644 tests/debug/002.out
 create mode 100755 tests/debug/003
 create mode 100644 tests/debug/003.out
 create mode 100755 tests/debug/004
 create mode 100644 tests/debug/004.out
 create mode 100755 tests/debug/005
 create mode 100644 tests/debug/005.out
 create mode 100644 tests/debug/Makefile

diff --git a/doc/group-names.txt b/doc/group-names.txt
index 6cc9af78..212da7e7 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -39,6 +39,7 @@ dangerous_scrub		fuzzers to evaluate xfs_scrub checking
 data			data loss checkers
 dax			direct access mode for persistent memory files
 db			xfs_db functional tests
+debug			tests with fixed results, used to validate testing setup
 dedupe			FIEDEDUPERANGE ioctl
 defrag			filesystem defragmenters
 dir			directory test functions
diff --git a/tests/debug/001 b/tests/debug/001
new file mode 100755
index 00000000..9567449c
--- /dev/null
+++ b/tests/debug/001
@@ -0,0 +1,14 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 001
+#
+# A test that should always pass
+#
+. ./common/preamble
+_begin_fstest debug
+
+echo "Silence is golden"
+status=0
+exit
+
diff --git a/tests/debug/001.out b/tests/debug/001.out
new file mode 100644
index 00000000..88678b8e
--- /dev/null
+++ b/tests/debug/001.out
@@ -0,0 +1,2 @@
+QA output created by 001
+Silence is golden
diff --git a/tests/debug/002 b/tests/debug/002
new file mode 100755
index 00000000..12b45a94
--- /dev/null
+++ b/tests/debug/002
@@ -0,0 +1,14 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 002
+#
+# A test that should always fail
+#
+. ./common/preamble
+_begin_fstest debug
+
+echo "I am intentionally broken"
+status=0
+exit
+
diff --git a/tests/debug/002.out b/tests/debug/002.out
new file mode 100644
index 00000000..61705c7c
--- /dev/null
+++ b/tests/debug/002.out
@@ -0,0 +1,2 @@
+QA output created by 002
+Silence is golden
diff --git a/tests/debug/003 b/tests/debug/003
new file mode 100755
index 00000000..813e6ff6
--- /dev/null
+++ b/tests/debug/003
@@ -0,0 +1,16 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 003
+#
+# A test that should always be skipped
+#
+. ./common/preamble
+_begin_fstest debug
+
+_notrun "Always skip me"
+
+echo "I should be skipped"
+status=0
+exit
+
diff --git a/tests/debug/003.out b/tests/debug/003.out
new file mode 100644
index 00000000..6895fc80
--- /dev/null
+++ b/tests/debug/003.out
@@ -0,0 +1,2 @@
+QA output created by 003
+Silence is golden
diff --git a/tests/debug/004 b/tests/debug/004
new file mode 100755
index 00000000..2e5f1e43
--- /dev/null
+++ b/tests/debug/004
@@ -0,0 +1,17 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 004
+#
+# A test that crashes
+#
+. ./common/preamble
+_begin_fstest debug dangerous
+
+echo 1 > /proc/sys/kernel/sysrq
+echo c > /proc/sysrq-trigger
+
+echo "I should have crashed by now"
+status=0
+exit
+
diff --git a/tests/debug/004.out b/tests/debug/004.out
new file mode 100644
index 00000000..af8614ae
--- /dev/null
+++ b/tests/debug/004.out
@@ -0,0 +1,2 @@
+QA output created by 004
+Silence is golden
diff --git a/tests/debug/005 b/tests/debug/005
new file mode 100755
index 00000000..1a213926
--- /dev/null
+++ b/tests/debug/005
@@ -0,0 +1,20 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 005
+#
+# A test that hangs
+#
+
+. ./common/preamble
+_begin_fstest debug dangerous
+
+while :
+do
+    sleep 1d
+done
+
+echo "I should still be sleeping"
+status=0
+exit
+
diff --git a/tests/debug/005.out b/tests/debug/005.out
new file mode 100644
index 00000000..a5027f12
--- /dev/null
+++ b/tests/debug/005.out
@@ -0,0 +1,2 @@
+QA output created by 005
+Silence is golden
diff --git a/tests/debug/Makefile b/tests/debug/Makefile
new file mode 100644
index 00000000..84556199
--- /dev/null
+++ b/tests/debug/Makefile
@@ -0,0 +1,24 @@
+#
+# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+include $(TOPDIR)/include/buildgrouplist
+
+DEBUG_DIR = debug
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(DEBUG_DIR)
+DIRT = group.list
+
+default: $(DIRT)
+
+include $(BUILDRULES)
+
+install:
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 group.list $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
-- 
2.39.1.519.gcb327c4b5f-goog

