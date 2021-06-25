Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22718C2B9F4
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Jun 2021 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F082261992
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Jun 2021 18:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFYSJE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 25 Jun 2021 14:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhFYSJD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 25 Jun 2021 14:09:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25D3261973;
        Fri, 25 Jun 2021 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624644402;
        bh=R7lWJPy8NmXTgDfMejBo8o4yAUk+o8nv9gNqLyw5PRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdIoSVT0NHjAAUb0OFWN/0KKAOvcqRGoNSjnUP2dZtSvwVmLBcd8i0cn+qxi/XlW2
         oSd5FXMIEMGIZWqJXh0dwywWU0H3k9UtKBU8BXc8J2uC9/dVfRsOTm6G5Dv2sv9fRS
         TIhaGuIfKDmc73vi68Hl1A/NQHTOo1Fq42iknmZ4AyY9swjhuVQ17lWm0k6ONeRiyG
         pENkACwLY4pK/Y253rW966muQLAa+v5kC5MQBeNw2orTEbgJEEuO80suR7yET+dOeZ
         puONs7cIBP+Ds0M6MM0wS02QQvjxWV9ZZ6MaHEUO/ab8VJG62qcvKMQkgG3HTanGek
         98qCgI2SFByXQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, aweits@rit.edu, dhowells@redhat.com,
        willy@infradead.org
Subject: [PATCH v2] generic: add a test to ensure that page is properly filled before write
Date:   Fri, 25 Jun 2021 14:06:41 -0400
Message-Id: <20210625180641.90861-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210612123154.8098-1-jlayton@kernel.org>
References: <20210612123154.8098-1-jlayton@kernel.org>
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
 tests/generic/639     | 53 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/639.out |  5 ++++
 tests/generic/group   |  1 +
 3 files changed, 59 insertions(+)
 create mode 100755 tests/generic/639
 create mode 100644 tests/generic/639.out

The kernel patch for this finally got merged, so we can refer to it in
the comments now. Also go ahead and set this test to be #639 instead of
XXX.

diff --git a/tests/generic/639 b/tests/generic/639
new file mode 100755
index 000000000000..647db8c663fe
--- /dev/null
+++ b/tests/generic/639
@@ -0,0 +1,53 @@
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+
+_cleanup()
+{
+	cd /
+	rm -f $testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+_supported_fs generic
+_require_test
+
+rm -f $seqres.full
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
diff --git a/tests/generic/group b/tests/generic/group
index 9a636b23f243..7139ca570320 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -641,3 +641,4 @@
 636 auto quick swap
 637 auto quick dir
 638 auto quick rw
+639 auto quick rw
-- 
2.31.1

