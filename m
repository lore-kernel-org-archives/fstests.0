Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAD6C11F68
	for <linux-fstests@archiver.kernel.org>; Fri,  2 Jul 2021 13:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE010613CE
	for <linux-fstests@archiver.kernel.org>; Fri,  2 Jul 2021 13:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhGBNm6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232308AbhGBNm6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 2 Jul 2021 09:42:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 718BD6142C;
        Fri,  2 Jul 2021 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625233225;
        bh=6Lo58Hdjd2TWUD0YTUlOgNtxlwPZDJdXXme9CQ4WeQA=;
        h=From:To:Cc:Subject:Date:From;
        b=IEbEyRp0yDAkFBpZnaWJHJrDxVsd8vXQFPleXHNyhqXwe9xNNtGbYURfWIvBWQBKm
         XRDQAyWMkWOfMY5YAszHKmloeXcR3IcBLAGFGLXMU2gy8Vgv13IXRZZ0QmrWsm9ElC
         plZSQOcz7E9iAapQie+WSaTnfnCS47N972pdrNkNj7X05JhzD/c0uhdpoOcRtb9ID9
         hzvK80EMpYa1xL912x6Bx84xNEl328LUECPRZSmXUagjHBpEtwJN1KqRih3kGfGaGr
         LT94rGpH8XBzEiNxyXiTUiWfWupa5+MsdmqXc4UB6W0tMqufApBPEwEp6Xa8ps350k
         uBUZeYaNxvi9w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, aweits@rit.edu, dhowells@redhat.com,
        willy@infradead.org
Subject: [PATCH v3] generic: add a test to ensure that page is properly filled before write
Date:   Fri,  2 Jul 2021 09:40:24 -0400
Message-Id: <20210702134024.24233-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We had a broken optimization in cephfs and netfs lib that could cause
part of a page to be improperly zeroed-out when writing to an offset
that was beyond the EOF but in an existing page.

Add a simple test that would have caught this.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/639     | 39 +++++++++++++++++++++++++++++++++++++++
 tests/generic/639.out |  5 +++++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/generic/639
 create mode 100644 tests/generic/639.out

v3: adapt to new test template

diff --git a/tests/generic/639 b/tests/generic/639
new file mode 100755
index 000000000000..c30f7644a2fc
--- /dev/null
+++ b/tests/generic/639
@@ -0,0 +1,39 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021, Jeff Layton <jlayton@redhat.com>
+#
+# FS QA Test No. 639
+#
+# Open a file and write a little data to it. Unmount (to clean out the cache)
+# and then mount again. Then write some data to it beyond the EOF and ensure
+# the result is correct.
+#
+# Prompted by a bug in ceph_write_begin that was fixed by commit 827a746f405d.
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+
+testfile="$TEST_DIR/test_write_begin.$$"
+
+# write some data to file and fsync it out
+$XFS_IO_PROG -f -c "pwrite -q 0 32" $testfile
+
+# cycle the mount to clean out the pagecache
+_test_cycle_mount
+
+# now, write to the file (near the end)
+$XFS_IO_PROG -c "pwrite -q 32 32" $testfile
+
+# dump what we think is in there
+echo "The result should be 64 bytes filled with 0xcd:"
+hexdump -C $testfile
+
+status=0
+exit
diff --git a/tests/generic/639.out b/tests/generic/639.out
new file mode 100644
index 000000000000..9bf0bac96864
--- /dev/null
+++ b/tests/generic/639.out
@@ -0,0 +1,5 @@
+QA output created by 639
+The result should be 64 bytes filled with 0xcd:
+00000000  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+*
+00000040
-- 
2.31.1

