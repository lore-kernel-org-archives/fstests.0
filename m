Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43659C636D7
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Feb 2023 22:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBUWhg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjBUWhe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Feb 2023 17:37:34 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1FE32E61
        for <fstests@vger.kernel.org>; Tue, 21 Feb 2023 14:37:09 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso6689993pjb.5
        for <fstests@vger.kernel.org>; Tue, 21 Feb 2023 14:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pNfmBGQUpE7lz6HvqDMuagaR7rwNk2umiMdkKDoxT1s=;
        b=Uaq5qoj9IN6pkGC74DfSaux085xMM5vGoYs2VVN+5i4lDPSpxGVaiDLLuTN9SxnZcC
         2gCxHgirv5cF3U6XTHwujpHuD+SzYEjeXlz4kHfxT1Y0w039wy3ipWgj12wHMYyQoFY8
         0T9VFXjVfJUCv89vOsMl4qRNiYAGPT/N1BwgxEPRXKPjYrB43NBafRd7aKr4pQckc1lo
         IaWuO98mqdopOslVnCABluqQLwebm90twLODjCYwNO9U5COcLHMz4Z6m1/ZmQB0eKjEN
         OXtCNG1vs5L6McRDh/lBHQf7w4stRXpHQQAEZPZIHry4mrTes7I8ukoBfZ5fW8iq/98m
         s0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNfmBGQUpE7lz6HvqDMuagaR7rwNk2umiMdkKDoxT1s=;
        b=dbgRLu8o1cJg0nvoFzhyjQRMRamzld//OQ1zWGP1BxavEO+UgoAAppC4izMAT/ZMbB
         M5G7qYkW0P8iVSkdYMKWuL2GZq7M3B+nm3lix9TJ4T0vD5ndeddBpIehMU+TX0/X4Cvd
         WsfCtOq7ZCuQwYVYBOlzb0PFKqHyAgjcPmuozfqwSTEIVFBvtu68Qy1hOd6nxxlOCH7f
         WwemNssZgYbY8XcUKgwcgz+DHMHUsuwiPAv8Vn6tuSMb8zQIQODNP/zEzpRiWaukGg9U
         XibnOoyeaw2cZIrph2hNb7l7B8SS3x2Pq5KE5B0yn77qkjB0WUOtGoF+v4Kk1dp/fRRc
         dUog==
X-Gm-Message-State: AO0yUKW8YB1hO+eE7OAVWE5E5I94SkN2PQqo5ajSK7TbW10h9fbAdlj9
        2ts4WjHAu7Xk8ZP15lyPm4yhfMWhBTI=
X-Google-Smtp-Source: AK7set9aEs1drwwgcvMf38K/yFYm76nKuxPWNRsh8lj6ccl3sMtBkbba7t7CZFeqZHC+Cd+//fRbLg==
X-Received: by 2002:a17:903:41c3:b0:19b:e73:809b with SMTP id u3-20020a17090341c300b0019b0e73809bmr10208775ple.25.1677019026006;
        Tue, 21 Feb 2023 14:37:06 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2d4:203:9b79:fab5:aa2f:8ee6])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b0019afb7a02a1sm10110687plb.218.2023.02.21.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:37:05 -0800 (PST)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, djwong@kernel.org, amir73il@gmail.com,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v3] selftest: add tests for debugging testing setup
Date:   Tue, 21 Feb 2023 14:36:49 -0800
Message-Id: <20230221223649.3616254-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Many people have developed infrastructure around xfstests. In order to
test a setup, it would be helpful to have dummy tests that have
consistent test outcomes. Add a new test folder with the following
tests:

selftest/001 pass
selftest/002 fail from output mismatch
selftest/003 fail via _fail
selftest/004 skip
selftest/005 crash
selftest/006 hang

Also, create two new groups: 'selftest' which includes tests 001-004 and
'dangerous_selftest' which includes tests 005-006. The selftests will
not run unless explicitly specified.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
v2 -> v3:
- remove selftest folder from SRC_GROUPS
- add README.selftest
- remove trailing blank lines from tests

v1 -> v2:
- change name of folder from 'debug' to 'selftest'
- update tags to 'selftest' and 'dangerous_selftest'
- add selftest folder to SRC_GROUPS
- updated copyright tag
- added test which _fails

v1: https://lore.kernel.org/fstests/20230209013143.2586104-1-leah.rumancik@gmail.com/
v2: https://lore.kernel.org/fstests/20230214215431.1425107-1-leah.rumancik@gmail.com/


 README.selftest         | 22 ++++++++++++++++++++++
 doc/group-names.txt     |  2 ++
 tests/selftest/001      | 13 +++++++++++++
 tests/selftest/001.out  |  2 ++
 tests/selftest/002      | 13 +++++++++++++
 tests/selftest/002.out  |  2 ++
 tests/selftest/003      | 15 +++++++++++++++
 tests/selftest/003.out  |  2 ++
 tests/selftest/004      | 15 +++++++++++++++
 tests/selftest/004.out  |  2 ++
 tests/selftest/005      | 16 ++++++++++++++++
 tests/selftest/005.out  |  2 ++
 tests/selftest/006      | 19 +++++++++++++++++++
 tests/selftest/006.out  |  2 ++
 tests/selftest/Makefile | 24 ++++++++++++++++++++++++
 15 files changed, 151 insertions(+)
 create mode 100644 README.selftest
 create mode 100755 tests/selftest/001
 create mode 100644 tests/selftest/001.out
 create mode 100755 tests/selftest/002
 create mode 100644 tests/selftest/002.out
 create mode 100755 tests/selftest/003
 create mode 100644 tests/selftest/003.out
 create mode 100755 tests/selftest/004
 create mode 100644 tests/selftest/004.out
 create mode 100755 tests/selftest/005
 create mode 100644 tests/selftest/005.out
 create mode 100755 tests/selftest/006
 create mode 100644 tests/selftest/006.out
 create mode 100644 tests/selftest/Makefile

diff --git a/README.selftest b/README.selftest
new file mode 100644
index 00000000..8f1d45af
--- /dev/null
+++ b/README.selftest
@@ -0,0 +1,22 @@
+Tests with consistent results are provided in the selftest folder.
+Since many people develop testing infrastructure around xfstests,
+these tests are helpful to confirm the testing setup is working as
+expected.
+
+The provided tests include:
+selftest/001 - pass
+selftest/002 - fail from output mismatch
+selftest/003 - fail via _fail
+selftest/004 - skip
+selftest/005 - crash
+selftest/006 - hang
+
+Two groups are used for these tests: selftest and dangerous_selftest.
+selftest/00[1-4] are in the selftest group and selftest/00[5-6] are
+in the dangerous_selftest group.
+
+The selftests will only be run if explicitly speficied. To run the
+selftests, you can specify individual tests, use "selftests/*", or
+use the groups "-g selftest/selftest -g selftest/dangerous_selftest".
+Note, you cannot use the group names without including the folder name
+(ie. "-g selftest").
diff --git a/doc/group-names.txt b/doc/group-names.txt
index 771ce937..ace59e05 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -38,6 +38,7 @@ dangerous_fsstress_repair	race fsstress and xfs_scrub online repair
 dangerous_fsstress_scrub	race fsstress and xfs_scrub checking
 dangerous_repair	fuzzers to evaluate xfs_repair offline repair
 dangerous_scrub		fuzzers to evaluate xfs_scrub checking
+dangerous_selftest	selftests that crash/hang
 data			data loss checkers
 dax			direct access mode for persistent memory files
 db			xfs_db functional tests
@@ -111,6 +112,7 @@ samefs			overlayfs when all layers are on the same fs
 scrub			filesystem metadata scrubbers
 seed			btrfs seeded filesystems
 seek			llseek functionality
+selftest		tests with fixed results, used to validate testing setup
 send			btrfs send/receive
 shrinkfs		decreasing the size of a filesystem
 shutdown		FS_IOC_SHUTDOWN ioctl
diff --git a/tests/selftest/001 b/tests/selftest/001
new file mode 100755
index 00000000..f3480330
--- /dev/null
+++ b/tests/selftest/001
@@ -0,0 +1,13 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 001
+#
+# A test that should always pass
+#
+. ./common/preamble
+_begin_fstest selftest
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/selftest/001.out b/tests/selftest/001.out
new file mode 100644
index 00000000..88678b8e
--- /dev/null
+++ b/tests/selftest/001.out
@@ -0,0 +1,2 @@
+QA output created by 001
+Silence is golden
diff --git a/tests/selftest/002 b/tests/selftest/002
new file mode 100755
index 00000000..189ae2cb
--- /dev/null
+++ b/tests/selftest/002
@@ -0,0 +1,13 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 002
+#
+# A test that should always fail due to output mismatch
+#
+. ./common/preamble
+_begin_fstest selftest
+
+echo "I am intentionally broken"
+status=0
+exit
diff --git a/tests/selftest/002.out b/tests/selftest/002.out
new file mode 100644
index 00000000..61705c7c
--- /dev/null
+++ b/tests/selftest/002.out
@@ -0,0 +1,2 @@
+QA output created by 002
+Silence is golden
diff --git a/tests/selftest/003 b/tests/selftest/003
new file mode 100755
index 00000000..c7a2848c
--- /dev/null
+++ b/tests/selftest/003
@@ -0,0 +1,15 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 003
+#
+# A test that _fail's
+#
+
+. ./common/preamble
+_begin_fstest selftest
+
+_fail "I have _fail'ed"
+
+status=0
+exit
diff --git a/tests/selftest/003.out b/tests/selftest/003.out
new file mode 100644
index 00000000..6895fc80
--- /dev/null
+++ b/tests/selftest/003.out
@@ -0,0 +1,2 @@
+QA output created by 003
+Silence is golden
diff --git a/tests/selftest/004 b/tests/selftest/004
new file mode 100755
index 00000000..89a3884d
--- /dev/null
+++ b/tests/selftest/004
@@ -0,0 +1,15 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 004
+#
+# A test that should always be skipped
+#
+. ./common/preamble
+_begin_fstest selftest
+
+_notrun "Always skip me"
+
+echo "I should be skipped"
+status=0
+exit
diff --git a/tests/selftest/004.out b/tests/selftest/004.out
new file mode 100644
index 00000000..af8614ae
--- /dev/null
+++ b/tests/selftest/004.out
@@ -0,0 +1,2 @@
+QA output created by 004
+Silence is golden
diff --git a/tests/selftest/005 b/tests/selftest/005
new file mode 100755
index 00000000..738cf44d
--- /dev/null
+++ b/tests/selftest/005
@@ -0,0 +1,16 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 005
+#
+# A test that crashes
+#
+. ./common/preamble
+_begin_fstest dangerous_selftest
+
+echo 1 > /proc/sys/kernel/sysrq
+echo c > /proc/sysrq-trigger
+
+echo "I should have crashed by now"
+status=0
+exit
diff --git a/tests/selftest/005.out b/tests/selftest/005.out
new file mode 100644
index 00000000..a5027f12
--- /dev/null
+++ b/tests/selftest/005.out
@@ -0,0 +1,2 @@
+QA output created by 005
+Silence is golden
diff --git a/tests/selftest/006 b/tests/selftest/006
new file mode 100755
index 00000000..150de6e8
--- /dev/null
+++ b/tests/selftest/006
@@ -0,0 +1,19 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 006
+#
+# A test that hangs
+#
+
+. ./common/preamble
+_begin_fstest dangerous_selftest
+
+while :
+do
+    sleep 1d
+done
+
+echo "I should still be sleeping"
+status=0
+exit
diff --git a/tests/selftest/006.out b/tests/selftest/006.out
new file mode 100644
index 00000000..675c1b7c
--- /dev/null
+++ b/tests/selftest/006.out
@@ -0,0 +1,2 @@
+QA output created by 006
+Silence is golden
diff --git a/tests/selftest/Makefile b/tests/selftest/Makefile
new file mode 100644
index 00000000..3ddfca37
--- /dev/null
+++ b/tests/selftest/Makefile
@@ -0,0 +1,24 @@
+#
+# Copyright (c) 2023 Google, Inc. All Rights Reserved.
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+include $(TOPDIR)/include/buildgrouplist
+
+SELFTEST_DIR = selftest
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(SELFTEST_DIR)
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
2.39.2.637.g21b0678d19-goog

