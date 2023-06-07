Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6319C7EE25
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jun 2023 14:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbjFGOyh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jun 2023 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbjFGOyg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jun 2023 10:54:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC161FEC
        for <fstests@vger.kernel.org>; Wed,  7 Jun 2023 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686149617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=okR2xgRMLBLe6hqwoaHusS5GCpupLZ754TFYHVbqivE=;
        b=fAsib8EohoB7VlhIDRina5V1Ifr3uUJ+EzjXk2ftmC0gTADQADhL+Og53m4presyggMo+t
        UKtoSNAQfVbTp/t6WYCplBInQZR0zCKjaa8QsmbOZvPYc6cxwH7YleEXf7hqsfY/tKsTxh
        F6ixU8QSzFwX/yNUzvdp9c1/FhMTcoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-zqYytcxIMxSC2GafpStNCQ-1; Wed, 07 Jun 2023 10:53:36 -0400
X-MC-Unique: zqYytcxIMxSC2GafpStNCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 027AD8032FA;
        Wed,  7 Jun 2023 14:53:36 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.225.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C9CE2166B26;
        Wed,  7 Jun 2023 14:53:35 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3] generic/728: Add mmap + DIO write test
Date:   Wed,  7 Jun 2023 16:53:34 +0200
Message-Id: <20230607145334.1183177-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is the same as generic/647, but with an additional test that writes
a memory-mapped page onto itself using direct I/O.

For direct I/O writes, the kernel will invalidate the page cache before
and after carrying out the write.  This puts filesystems that fault in
pages on demand and then carry out the write with page faults disabled
into a position in which they will not be able to make any progress.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 src/mmap-rw-fault.c   | 33 ++++++++++++++++++++++++++++++---
 tests/generic/728     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/728.out |  2 ++
 3 files changed, 74 insertions(+), 3 deletions(-)
 create mode 100755 tests/generic/728
 create mode 100644 tests/generic/728.out

diff --git a/src/mmap-rw-fault.c b/src/mmap-rw-fault.c
index 82f9d978..161d9f79 100644
--- a/src/mmap-rw-fault.c
+++ b/src/mmap-rw-fault.c
@@ -20,6 +20,7 @@
 #include <string.h>
 #include <errno.h>
 #include <err.h>
+#include <getopt.h>
 
 char *filename;
 unsigned int page_size;
@@ -109,11 +110,29 @@ static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
 	return count2;
 }
 
+static void usage(const char *argv0)
+{
+	fprintf(stderr, "Usage: %s [-2] {filename}\n", argv0);
+	exit(2);
+}
+
 int main(int argc, char *argv[])
 {
-	if (argc != 2)
-		errx(1, "no test filename argument given");
-	filename = argv[1];
+	int opt, opt_2 = 0;
+
+	while ((opt = getopt(argc, argv, "2")) != -1) {
+		switch(opt) {
+		case '2':
+			opt_2 = 1;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind + 1 != argc)
+		usage(argv[0]);
+	filename = argv[optind];
 
 	page_size = ret = sysconf(_SC_PAGE_SIZE);
 	if (ret == -1)
@@ -179,6 +198,14 @@ int main(int argc, char *argv[])
 		errx(1, "pread (D_DIRECT) from hole is broken");
 	done();
 
+	if (opt_2) {
+		init('f', O_RDWR | O_DIRECT);
+		ret = do_write(fd, addr + page_size, page_size, page_size);
+		if (ret != page_size)
+			err(1, "pwrite %s (O_DIRECT): %ld != %u", filename, ret, page_size);
+		done();
+	}
+
 	if (unlink(filename))
 		err(1, "unlink %s", filename);
 
diff --git a/tests/generic/728 b/tests/generic/728
new file mode 100755
index 00000000..483c7b73
--- /dev/null
+++ b/tests/generic/728
@@ -0,0 +1,42 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 728
+#
+# Trigger page faults in the same file during read and write
+#
+# This is generic/647 with an additional test that writes a memory-mapped page
+# onto itself using direct I/O.
+#
+# The kernel will invalidate the page cache before carrying out the write, so
+# filesystems that fault in the page and then carry out the direct I/O write
+# with page faults disabled will never make any progress.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	rm -f $TEST_DIR/mmap-rw-fault.tmp
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs generic
+_require_test
+_require_odirect
+_require_test_program mmap-rw-fault
+
+echo "Silence is golden"
+
+$here/src/mmap-rw-fault -2 $TEST_DIR/mmap-rw-fault.tmp
+
+status=$?
+exit
diff --git a/tests/generic/728.out b/tests/generic/728.out
new file mode 100644
index 00000000..ab39f45f
--- /dev/null
+++ b/tests/generic/728.out
@@ -0,0 +1,2 @@
+QA output created by 728
+Silence is golden
-- 
2.40.0

