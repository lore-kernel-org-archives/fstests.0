Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B8DC432BE
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Aug 2021 15:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3483460EE7
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Aug 2021 15:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhH0PG6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 Aug 2021 11:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233712AbhH0PG5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Aug 2021 11:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630076768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bunrdo8STbPTjRaYBQBuq1FCelM+OGpkGE3gSxh7m2I=;
        b=AGaQVHJasKYqWBC0phwhnF5c4bGrNdvw9GC7TItaqfb776TD27sGGc5EDrCsffRbwL3n5x
        fotVCW9pKNrGuK9xF2eTw285UVT+Gw9XtvKngj/fOvjmr2+fJwTP6aWAs8Lnq14+6xHRFL
        Fjpf+Y0ayuVH+ox2SPwpI1d64xEgXgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-1ESyG4UwNrew4wToli_P4w-1; Fri, 27 Aug 2021 11:06:06 -0400
X-MC-Unique: 1ESyG4UwNrew4wToli_P4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B376875108
        for <fstests@vger.kernel.org>; Fri, 27 Aug 2021 15:06:05 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBEA860BD9;
        Fri, 27 Aug 2021 15:06:04 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] generic/646: Test page faults during read and write
Date:   Fri, 27 Aug 2021 17:06:03 +0200
Message-Id: <20210827150603.1724638-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Here's an update of a test case I'm trying to get merged since May.
Please have a look; I'm tired of dragging this along.

Thanks,
Andreas

--

Some filesystems have problems when the buffer passed to read or write
is memory-mapped to the file being read from or written to, and the
buffer needs to be faulted in during the read or write.  That's not
common, but filesystems are still required to cope with it, and if they
fail this test, then they will also fail more complex scenarios that
involve multiple files.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 src/Makefile          |   2 +-
 src/mmap-rw-fault.c   | 176 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/646     |  27 +++++++
 tests/generic/646.out |   2 +
 4 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 src/mmap-rw-fault.c
 create mode 100755 tests/generic/646
 create mode 100644 tests/generic/646.out

diff --git a/src/Makefile b/src/Makefile
index 884bd86a..25ab061d 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -18,7 +18,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
-	t_mmap_writev_overlap checkpoint_journal
+	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/mmap-rw-fault.c b/src/mmap-rw-fault.c
new file mode 100644
index 00000000..244d2cb6
--- /dev/null
+++ b/src/mmap-rw-fault.c
@@ -0,0 +1,176 @@
+/* Trigger mmap page faults in the same file during pread and pwrite. */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE /* to get definition of O_DIRECT flag. */
+#endif
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <err.h>
+
+char *filename;
+unsigned int page_size;
+void *page;
+char *addr;
+int fd;
+ssize_t ret;
+
+/*
+ * Leave a hole at the beginning of the test file and initialize a block of
+ * @page_size bytes at offset @page_size to @c.  Then, reopen the file and
+ * mmap the first two pages.
+ */
+void init(char c, int flags)
+{
+	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY | O_DIRECT, 0666);
+	if (fd == -1)
+		goto fail;
+	memset(page, c, page_size);
+	ret = pwrite(fd, page, page_size, page_size);
+	if (ret != page_size)
+		goto fail;
+	if (close(fd))
+		goto fail;
+
+	fd = open(filename, flags);
+	if (fd == -1)
+		goto fail;
+	addr = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (addr == MAP_FAILED)
+		err(1, NULL);
+	return;
+
+fail:
+	err(1, "%s", filename);
+}
+
+void done(void)
+{
+	if (fsync(fd))
+		goto fail;
+	if (close(fd))
+		goto fail;
+	return;
+
+fail:
+	err(1, "%s", filename);
+}
+
+static ssize_t do_read(int fd, void *buf, size_t count, off_t offset)
+{
+	ssize_t count2 = 0, ret;
+
+	do {
+		ret = pread(fd, buf, count, offset);
+		if (ret == -1) {
+			if (errno == EINTR)
+				continue;
+			break;
+		}
+		if (ret == 0)
+			break;
+		count2 += ret;
+		buf += ret;
+		count -= ret;
+	} while (count);
+	return count2;
+}
+
+static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
+{
+	ssize_t count2 = 0, ret;
+
+	do {
+		ret = pwrite(fd, buf, count, offset);
+		if (ret == -1) {
+			if (errno == EINTR)
+				continue;
+			break;
+		}
+		if (ret == 0)
+			break;
+		count2 += ret;
+		buf += ret;
+		count -= ret;
+	} while (count);
+	return count2;
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2)
+		errx(1, "no test filename argument given");
+	filename = argv[1];
+
+	page_size = ret = sysconf(_SC_PAGE_SIZE);
+	if (ret == -1)
+		err(1, NULL);
+
+	ret = posix_memalign(&page, page_size, page_size);
+	if (ret) {
+		errno = ENOMEM;
+		err(1, NULL);
+	}
+
+	/*
+	 * Make sure page faults during pread are handled correctly.
+	 */
+	init('a', O_RDWR);
+	ret = do_read(fd, addr, page_size, page_size);
+	if (ret != page_size)
+		err(1, "pread %s: %ld != %u", filename, ret, page_size);
+	if (memcmp(addr, page, page_size))
+		errx(1, "pread is broken");
+	done();
+
+	init('b', O_RDWR | O_DIRECT);
+	ret = do_read(fd, addr, page_size, page_size);
+	if (ret != page_size)
+		err(1, "pread %s (O_DIRECT): %ld != %u", filename, ret, page_size);
+	if (memcmp(addr, page, page_size))
+		errx(1, "pread (D_DIRECT) is broken");
+	done();
+
+	/*
+	 * Make sure page faults during pwrite are handled correctly.
+	 */
+	init('c', O_RDWR);
+	ret = do_write(fd, addr + page_size, page_size, 0);
+	if (ret != page_size)
+		err(1, "pwrite %s: %ld != %u", filename, ret, page_size);
+	if (memcmp(addr, page, page_size))
+		errx(1, "pwrite is broken");
+	done();
+
+	init('d', O_RDWR | O_DIRECT);
+	ret = do_write(fd, addr + page_size, page_size, 0);
+	if (ret != page_size)
+		err(1, "pwrite %s (O_DIRECT): %ld != %u", filename, ret, page_size);
+	if (memcmp(addr, page, page_size))
+		errx(1, "pwrite (O_DIRECT) is broken");
+	done();
+
+	/*
+	 * Reading from a hole takes a different code path in the kernel.
+	 */
+	init('e', O_RDWR | O_DIRECT);
+	ret = do_read(fd, addr, page_size, 0);
+	if (ret != page_size)
+		err(1, "pread %s (O_DIRECT) from hole: %ld != %u", filename, ret, page_size);
+	memset(page, 0, page_size);
+	if (memcmp(addr, page, page_size))
+		errx(1, "pread (D_DIRECT) from hole is broken");
+	done();
+
+	if (unlink(filename))
+		err(1, "unlink %s", filename);
+
+	return 0;
+}
diff --git a/tests/generic/646 b/tests/generic/646
new file mode 100755
index 00000000..57d8c13d
--- /dev/null
+++ b/tests/generic/646
@@ -0,0 +1,27 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 646
+#
+# Trigger mmap page faults in the same file during pread and pwrite
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs generic
+_require_test
+_require_test_program mmap-rw-fault
+
+echo "Silence is golden"
+
+$here/src/mmap-rw-fault $TEST_DIR/mmap-rw-fault.tmp
+
+status=$?
+exit
diff --git a/tests/generic/646.out b/tests/generic/646.out
new file mode 100644
index 00000000..8357006e
--- /dev/null
+++ b/tests/generic/646.out
@@ -0,0 +1,2 @@
+QA output created by 646
+Silence is golden
-- 
2.26.3

