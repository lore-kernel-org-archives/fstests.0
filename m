Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0293DC61DA4
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Feb 2023 21:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjBNVym (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBNVyl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Feb 2023 16:54:41 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850E11F494
        for <fstests@vger.kernel.org>; Tue, 14 Feb 2023 13:54:40 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 24so11204428pgt.7
        for <fstests@vger.kernel.org>; Tue, 14 Feb 2023 13:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXWJWCEGOcTAC97su6G2FlJNAtWGsVLOIuC3ppPFgc4=;
        b=D7Oe1sudG/nzI88cUWF0JwY1BLjYo+YEm1uqA0wkRsd62HMTULPJEilK420ZGonWKK
         RbgiZe9T1Kxfms1hOEktH+0GDgHVlkNTYdu+oaMYP6eEzPRApaIYZxAuJs7IyB30VSin
         zPUG3KrkoJCQfPB61x1wlYB+izvFVLeUZ329NbgyOJkVl3u54BcmlcX7Ejq683zowoFp
         2ONp0rMRJk5eA667ek4J0+RBlIKHzqQ1z45e599R4Rbcd2fKObdA/1PHLqCJh7ncCHnd
         dqJuYn4hkvYDzAPNlQ8ySYopT7B4YpzGW7oCgoj6TlF4kkn49U4AwIypIfZIul3u1Kmu
         iagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXWJWCEGOcTAC97su6G2FlJNAtWGsVLOIuC3ppPFgc4=;
        b=EncdG7f14DZEUPIYuVReYXDYZHoXDzcTN4b05pW83d/81XnSlNwcbmoR0AVyT96a/x
         e4+KOMz1nClXMSqTPKqMp1p5sQpva3Mdx1JgnFxvGboMAfwpJ+VdaP+C44psd2iKlAD5
         d46lKqCV1l13L3koekJ2XtsAyeVYkhQkRxs44j+Unf3wmMK1Fi8mRuZXwdt32gCZVwXH
         kbTJK31TywdJNKvfWgr/c+aFfqgihUkemfsgseaUhfz3wK1Xxm33Tjtn0D9gAtAAbq+d
         SrwJlXZ0qODWX+zDh9fMF1VxoesZlTDFlKkjM5X+P4UeI/ptz68aLweXjQ/ml/6jph8r
         /2JA==
X-Gm-Message-State: AO0yUKX51HDrUkvMJQSmQuoElx1T2T+hQJAgGHEqLN79mXm3ploowOAI
        OBlLCeAupOVkPNiPWSTPGSgfCAttoBtqqA==
X-Google-Smtp-Source: AK7set9ia5EwJszBGMv/KmH8kwQrK7tiyRUrJt0vIpqbZXxbRG6+u2+OVP+LBflK4H0HInidgiYuMg==
X-Received: by 2002:a62:3347:0:b0:5a8:c693:c7b4 with SMTP id z68-20020a623347000000b005a8c693c7b4mr3201648pfz.30.1676411679758;
        Tue, 14 Feb 2023 13:54:39 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2d4:203:cf14:3756:2b5e:fb87])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00588e0d5124asm10205553pfn.160.2023.02.14.13.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:54:39 -0800 (PST)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, djwong@kernel.org,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v2] selftest: add tests for debugging testing setup
Date:   Tue, 14 Feb 2023 13:54:31 -0800
Message-Id: <20230214215431.1425107-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
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
run when running all tests but they are not part of the auto group.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
v1 -> v2:

- change name of folder from 'debug' to 'selftest'
- update tags to 'selftest' and 'dangerous_selftest'
- add selftest folder to SRC_GROUPS
- update copyright tag
- add test which _fails

v1: https://lore.kernel.org/fstests/20230209013143.2586104-1-leah.rumancik@gmail.com/

 check                   |  2 +-
 doc/group-names.txt     |  2 ++
 tests/selftest/001      | 14 ++++++++++++++
 tests/selftest/001.out  |  2 ++
 tests/selftest/002      | 14 ++++++++++++++
 tests/selftest/002.out  |  2 ++
 tests/selftest/003      | 16 ++++++++++++++++
 tests/selftest/003.out  |  2 ++
 tests/selftest/004      | 16 ++++++++++++++++
 tests/selftest/004.out  |  2 ++
 tests/selftest/005      | 17 +++++++++++++++++
 tests/selftest/005.out  |  2 ++
 tests/selftest/006      | 20 ++++++++++++++++++++
 tests/selftest/006.out  |  2 ++
 tests/selftest/Makefile | 24 ++++++++++++++++++++++++
 15 files changed, 136 insertions(+), 1 deletion(-)
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

diff --git a/check b/check
index 4827532e..c2065cdc 100755
--- a/check
+++ b/check
@@ -48,7 +48,7 @@ timestamp=${TIMESTAMP:=false}
 
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
 
-SRC_GROUPS="generic shared"
+SRC_GROUPS="generic shared selftest"
 export SRC_DIR="tests"
 
 usage()
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
index 00000000..f326fc83
--- /dev/null
+++ b/tests/selftest/001
@@ -0,0 +1,14 @@
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
+
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
index 00000000..a3e463b8
--- /dev/null
+++ b/tests/selftest/002
@@ -0,0 +1,14 @@
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
+
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
index 00000000..80d9ea90
--- /dev/null
+++ b/tests/selftest/003
@@ -0,0 +1,16 @@
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
+
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
index 00000000..eddf49af
--- /dev/null
+++ b/tests/selftest/004
@@ -0,0 +1,16 @@
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
+
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
index 00000000..e8844d30
--- /dev/null
+++ b/tests/selftest/005
@@ -0,0 +1,17 @@
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
+
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
index 00000000..c6fa0dc4
--- /dev/null
+++ b/tests/selftest/006
@@ -0,0 +1,20 @@
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
+
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
2.39.1.581.gbfd45094c4-goog

