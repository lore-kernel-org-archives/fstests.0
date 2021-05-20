Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A2DC43460
	for <linux-fstests@archiver.kernel.org>; Thu, 20 May 2021 11:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC6F610A1
	for <linux-fstests@archiver.kernel.org>; Thu, 20 May 2021 11:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbhETLpX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 May 2021 07:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242577AbhETLnr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 May 2021 07:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621510943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ATYNzff35rat8glB3t4CQGIAnOU6fczPe2JUp9Mc1Pk=;
        b=Xnc7McynyRDZ4E9p3llY5f7LpWgRK1x3sqvls8LRbSOKB1mCht5WFkQTRIO+iOE8yFijHv
        cIzaBkBw6IVSi+Z9jPYQIR1tEoltQl1k6xdObGDM4dyM+5aqHlHoZKbcRl1dyp+/oypvvc
        GbHf0bWo4dUdiMiO3zc1Q4950VJhS4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-BCpoWXVQOg6QENpyZ4Khww-1; Thu, 20 May 2021 07:42:22 -0400
X-MC-Unique: BCpoWXVQOg6QENpyZ4Khww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 295558189C4
        for <fstests@vger.kernel.org>; Thu, 20 May 2021 11:42:21 +0000 (UTC)
Received: from max.com (unknown [10.40.195.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 621B65D9DC;
        Thu, 20 May 2021 11:42:20 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v4] generic/637: Test page faults during read and write
Date:   Thu, 20 May 2021 13:42:18 +0200
Message-Id: <20210520114218.1595735-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some filesystems have problems when the buffer passed to read or write is
memory-mapped to the file being read from or written to and the buffer is
faulted in during the read or write.  (That's probably not a recommended
use case, but it should work nevertheless.)

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 src/Makefile          |   3 +-
 src/mmap-rw-fault.c   | 164 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/637     |  40 +++++++++++
 tests/generic/637.out |   2 +
 tests/generic/group   |   1 +
 5 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 src/mmap-rw-fault.c
 create mode 100755 tests/generic/637
 create mode 100644 tests/generic/637.out

diff --git a/src/Makefile b/src/Makefile
index cc0b9579..13cdf19b 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -17,7 +17,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
-	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc
+	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
+	mmap-rw-fault
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/mmap-rw-fault.c b/src/mmap-rw-fault.c
new file mode 100644
index 00000000..b9c58af6
--- /dev/null
+++ b/src/mmap-rw-fault.c
@@ -0,0 +1,164 @@
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
+	if (unlink(filename))
+		err(1, "unlink %s", filename);
+
+	return 0;
+}
diff --git a/tests/generic/637 b/tests/generic/637
new file mode 100755
index 00000000..d3c3f235
--- /dev/null
+++ b/tests/generic/637
@@ -0,0 +1,40 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 637
+#
+# Trigger mmap page faults in the same file during pread and pwrite
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_test
+
+$here/src/mmap-rw-fault $TEST_DIR/mmap-rw-fault.tmp \
+|| exit
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/637.out b/tests/generic/637.out
new file mode 100644
index 00000000..55a3d825
--- /dev/null
+++ b/tests/generic/637.out
@@ -0,0 +1,2 @@
+QA output created by 637
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 105763c4..01996b48 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -639,3 +639,4 @@
 634 auto quick atime bigtime
 635 auto quick atime bigtime shutdown
 636 auto quick swap
+637 auto
-- 
2.26.3

