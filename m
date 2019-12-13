Return-Path: <SRS0=uevG=2D=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84E0C43603
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Dec 2019 09:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30DF2253D
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Dec 2019 09:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msSv0EbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfLMJsO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:48:14 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:46727 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMJsO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Dec 2019 04:48:14 -0500
Received: by mail-pg1-f172.google.com with SMTP id z124so1264903pgb.13
        for <fstests@vger.kernel.org>; Fri, 13 Dec 2019 01:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ktI4ymsEPT4jLAPtDGVS4kGJCM7VzuCH5iFKYmodxOA=;
        b=msSv0EbAxDmex/4lQgejKL6WKxBkP2ZffHtdtwHevOtHMqhKh5q4C5ZQpVUICOmrfF
         0xRzJqfDfGVRovYBxxBexmitqSzCAyJue2HH9J/mqN0sFVLh8hkZQw2ZXbiTqSzb7DYU
         phJuSYQDy5xOXyIYjWxggf5XbVy0QZ3JC/nx6IvDtU6B7Nf9k/Pm9ZwJ8y8iSl7RZIzp
         /R8RnJqrsplmg06ZE8/js0TVlJZn3VgD3mbWnN+g45MXfX7H1Au1Zctg1jiVcdQWF8h/
         rhmBk0U0cu1fZwwlTqvbP3gavBoQReg/iKLoPdw1vRkGaUQzI/osGyu77FnAlPYyF7LU
         uDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ktI4ymsEPT4jLAPtDGVS4kGJCM7VzuCH5iFKYmodxOA=;
        b=sH8vIuHEHs8pPtuTSd41Ze4melOLfTQSGJ5HsrP+sxrt2DVKxxByxbkULlBi1wwUZT
         43fbW2pP1VzsIwQWvqpocJZwh34oIRHJ+NvbhMqHb1M+eSG06ykOIjrwzw8bLqRwQJ6Q
         FJ2Z37qWEj700zoLfxZDu8PKjxUzU1oXdsjOq8uvOhyxqRBc/QVsO7ZhnyVGhqb8CKy+
         ZsBDBPIYOrNA8/AAM0ZODawXcnOKUnpbN/EChYf//PnfBKKQ2xFMd2J90oEqlXcfVLXx
         T9OveojrpB1aU0qwWDR/lsQXUa0T2ljx/XoGLuW5nAgsgcwSm9udb1zr/wco+bYpCPE2
         eXZQ==
X-Gm-Message-State: APjAAAW5A0R9oXRXSj15yr3Y+7KtC4tUYf9pS0sdMOFEFtQMNeCDbFQG
        W5o4TZLYdRAPmFdBpxk7zEzjvOvD
X-Google-Smtp-Source: APXvYqzHZNuBl0/4BFCt/meAa20czsD3HMAqeNJFfGlueSIKZxs0ppkbBXzFU5OdgOD/aK75CeXQww==
X-Received: by 2002:a62:2ad5:: with SMTP id q204mr15270625pfq.33.1576230492306;
        Fri, 13 Dec 2019 01:48:12 -0800 (PST)
Received: from linux-3f6g.apac.novell.com ([45.122.156.254])
        by smtp.gmail.com with ESMTPSA id t30sm9800617pgl.75.2019.12.13.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 01:48:10 -0800 (PST)
From:   Yong Sun <sunyong0511@gmail.com>
X-Google-Original-From: Yong Sun <yosun@suse.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, Yong Sun <yosun@suse.com>
Subject: [PATCH v5] fstests: transport two ext4 tests from LTP
Date:   Fri, 13 Dec 2019 17:39:37 +0800
Message-Id: <20191213093936.9286-1-yosun@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Recently LTP upstream removed some ext4 tests[1].
And two of them is still valid to keep. So I transport those two tests here.
ext4-nsec-timestamps, which is used to test nanosec timestamps of ext4, rewrite into ext4/043 and 044.
ext4-subdir-limit, which is used to test subdirectory limit of ext4, rewrite into ext4/045.

[1] https://marc.info/?l=linux-fsdevel&m=157190623919681&w=2

Signed-off-by: Sun Yong <yosun@suse.com>
---
v2: Correct copyright information
v3: Correct white-space damage
v4: Add a missing file
v5: Fix several issue reviewed by Darrick
---
 src/Makefile              |   3 +-
 src/t_create_long_dirs.c  | 139 +++++++++++++++++++++++++++++++++++++
 src/t_create_short_dirs.c | 142 ++++++++++++++++++++++++++++++++++++++
 src/t_ext4_file_time.c    |  53 ++++++++++++++
 tests/ext4/043            |  56 +++++++++++++++
 tests/ext4/043.out        |   2 +
 tests/ext4/044            |  87 +++++++++++++++++++++++
 tests/ext4/044.out        |   2 +
 tests/ext4/045            | 134 +++++++++++++++++++++++++++++++++++
 tests/ext4/045.out        |   2 +
 tests/ext4/group          |   3 +
 11 files changed, 622 insertions(+), 1 deletion(-)
 create mode 100644 src/t_create_long_dirs.c
 create mode 100644 src/t_create_short_dirs.c
 create mode 100644 src/t_ext4_file_time.c
 create mode 100755 tests/ext4/043
 create mode 100644 tests/ext4/043.out
 create mode 100755 tests/ext4/044
 create mode 100644 tests/ext4/044.out
 create mode 100755 tests/ext4/045
 create mode 100644 tests/ext4/045.out

diff --git a/src/Makefile b/src/Makefile
index ce6d8610..387293d1 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -16,7 +16,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
-	t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent
+	t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent \
+    t_ext4_file_time t_create_short_dirs t_create_long_dirs
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/t_create_long_dirs.c b/src/t_create_long_dirs.c
new file mode 100644
index 00000000..fe5b4b64
--- /dev/null
+++ b/src/t_create_long_dirs.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ */
+
+#define _POSIX_C_SOURCE 200809L
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include "config.h"
+
+/* NCHARS = 10 + 26 + 26 = 62 */
+#define NAME_LEN	255
+#define NCHARS		62
+#define MAX_LEN1	62
+#define MAX_LEN2	(62 * 62)
+#define MAX_LEN3	(62 * 62 * 62)
+
+/* valid characters for the directory name */
+char chars[NCHARS + 1] = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
+
+/* to store the generated directory name */
+char name[NAME_LEN + 1];
+int names;
+int parent_fd;
+
+/*
+ * init_name - initialize the directory name
+ *
+ * Generate a randomized directory name, and then we generate more
+ * directory names based on it.
+ */
+void init_name(void)
+{
+	int i;
+
+	srand(time(NULL));
+
+	for (i = 0; i < NAME_LEN; i++)
+		name[i] = chars[rand() % 62];
+}
+
+void create_dir(void)
+{
+	if (mkdirat(parent_fd, name, S_IRWXU)) {
+		perror("mkdir");
+		exit(1);
+	}
+}
+
+/*
+ * create_dirs - create @names directory names
+ * @n: how many names to be created
+ *
+ * if n <= 62,       we need to modify 1 char of the name
+ * if n <= 62*62,    we need to modify 2 chars
+ * if n <= 62*62*62, we need to modify 3 chars
+ */
+void create_dirs(int n)
+{
+	int i, j, k;
+	int depth;
+
+	if (n <= MAX_LEN1)
+		depth = 1;
+	else if (n <= MAX_LEN2)
+		depth = 2;
+	else
+		depth = 3;
+
+	for (i = 0; i < NCHARS; i++) {
+		name[0] = chars[i];
+		if (depth == 1) {
+			create_dir();
+			if (--n == 0)
+				return;
+			continue;
+		}
+
+		for (j = 0; j < NCHARS; j++) {
+			name[1] = chars[j];
+			if (depth == 2) {
+				create_dir();
+				if (--n == 0)
+					return;
+				continue;
+			}
+
+			for (k = 0; k < NCHARS; k++) {
+				name[2] = chars[k];
+				create_dir();
+				if (--n == 0)
+					return;
+			}
+		}
+	}
+}
+
+void usage()
+{
+	fprintf(stderr, "Usage: create_long_dirs nr_dirs parent_dir\n");
+}
+
+/*
+ * Create long-name directories
+ * @argv[1]: directory number
+ * @argv[2]: parent directory
+ */
+int main(int argc, char *argv[])
+{
+	if (argc != 3) {
+		usage();
+		return 1;
+	}
+
+	names = atoi(argv[1]);
+	if (names > MAX_LEN3 || names <= 0) {
+		usage();
+		return 1;
+	}
+
+	parent_fd = open(argv[2], O_RDONLY);
+	if (parent_fd == -1) {
+		perror("open parent dir failed");
+		return 1;
+	}
+
+	init_name();
+
+	create_dirs(names);
+
+	return 0;
+}
diff --git a/src/t_create_short_dirs.c b/src/t_create_short_dirs.c
new file mode 100644
index 00000000..778506e1
--- /dev/null
+++ b/src/t_create_short_dirs.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ */
+
+#define _POSIX_C_SOURCE 200809L
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include "config.h"
+
+/* NCHARS = 10 + 26 + 26 = 62 */
+#define NCHARS      62
+#define MAX_LEN1    62
+#define MAX_LEN2    (62 * 62)
+#define MAX_LEN3    (62 * 62 * 62)
+#define MAX_NAMES   (MAX_LEN1 + MAX_LEN2 + MAX_LEN3)
+
+/* valid characters for a directory name */
+char chars[] = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
+
+/* to store the generated directory name */
+char name[10];
+int names;
+int parent_fd;
+
+void create_dir(void)
+{
+	if (mkdirat(parent_fd, name, S_IRWXU)) {
+		perror("mkdir");
+		exit(1);
+	}
+}
+
+/*
+ * create_1 - create length-1 directory names
+ * @n: how name names to be created
+ */
+void create_1(int n)
+{
+	int i;
+
+	name[1] = '\0';
+	for (i = 0; i < NCHARS; i++) {
+		name[0] = chars[i];
+		create_dir();
+		if (--n == 0)
+			return;
+	}
+}
+
+/*
+ * create_2 - generate length-2 directory names
+ * @n: how many names to be created
+ */
+void create_2(int n)
+{
+	int i, j;
+
+	name[2] = '\0';
+	for (i = 0; i < NCHARS; i++) {
+		name[0] = chars[i];
+		for (j = 0; j < NCHARS; j++) {
+			name[1] = chars[j];
+			create_dir();
+			if (--n == 0)
+				return;
+		}
+	}
+}
+
+/*
+ * create_3 - generate length-3 directory names
+ * @n: how many names to be created
+ */
+void create_3(int n)
+{
+	int i, j, k;
+
+	name[3] = '\0';
+	for (i = 0; i < NCHARS; i++) {
+		name[0] = chars[i];
+		for (j = 0; j < NCHARS; j++) {
+			name[1] = chars[j];
+			for (k = 0; k < NCHARS; k++) {
+				name[2] = chars[k];
+				create_dir();
+				if (--n == 0)
+					return;
+			}
+		}
+	}
+}
+
+void usage()
+{
+	fprintf(stderr, "Usage: create_short_dirs nr_dirs parent_dir\n");
+}
+
+/*
+ * Create short-name directoriess
+ * @argv[1]: director number
+ * @argv[2]: the parent directory
+ */
+int main(int argc, char *argv[])
+{
+	if (argc != 3) {
+		usage();
+		return 1;
+	}
+
+	names = atoi(argv[1]);
+	if (names > MAX_NAMES || names <= 0) {
+		usage();
+		return 1;
+	}
+
+	parent_fd = open(argv[2], O_RDONLY);
+	if (parent_fd == -1) {
+		perror("open parent dir failed");
+		return 1;
+	}
+
+	create_1(names);
+	if (names <= MAX_LEN1)
+		return 0;
+
+	names -= MAX_LEN1;
+	create_2(names);
+	if (names <= MAX_LEN2)
+		return 0;
+
+	names -= MAX_LEN2;
+	create_3(names);
+
+	return 0;
+}
diff --git a/src/t_ext4_file_time.c b/src/t_ext4_file_time.c
new file mode 100644
index 00000000..d0184545
--- /dev/null
+++ b/src/t_ext4_file_time.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+
+/*
+ * Usage: file_time <filename> <atime|mtime|ctime> <sec|nsec>
+ */
+int main(int argc, char *argv[])
+{
+	time_t t;
+	struct stat st;
+
+	if (argc != 4) {
+		fprintf(stderr, "Wrong argument num!\n");
+		return 1;
+	}
+
+	if (stat(argv[1], &st) != 0) {
+		perror("stat failed");
+		return 1;
+	}
+
+	if (strcmp(argv[3], "sec") == 0) {
+		if (strcmp(argv[2], "atime") == 0)
+			t = st.st_atime;
+		else if (strcmp(argv[2], "mtime") == 0)
+			t = st.st_mtime;
+		else
+			t = st.st_ctime;
+	} else if (strcmp(argv[3], "nsec") == 0) {
+		if (strcmp(argv[2], "atime") == 0)
+			t = st.st_atim.tv_nsec;
+		else if (strcmp(argv[2], "mtime") == 0)
+			t = st.st_mtim.tv_nsec;
+		else
+			t = st.st_ctim.tv_nsec;
+	} else {
+		fprintf(stderr, "Wrong argument: %s\n", argv[3]);
+		return 1;
+	}
+
+	printf("%lu\n", t);
+
+	return 0;
+}
diff --git a/tests/ext4/043 b/tests/ext4/043
new file mode 100755
index 00000000..8a9f6d45
--- /dev/null
+++ b/tests/ext4/043
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test No. 043
+#
+# Test file timestamps are only precise to seconds with 128-byte inodes."
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext3 ext4
+_supported_os Linux
+
+_require_scratch
+_require_test_program "t_ext4_file_time"
+
+echo "Silence is golden"
+
+echo "Start test timestamps with 128 inode size one device $SCRATCH_DEV" >$seqres.full
+_scratch_mkfs_ext4 -I 128 >> $seqres.full 2>&1
+_scratch_mount
+
+touch "${SCRATCH_MNT}/tmp_file"
+
+atime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime nsec`
+mtime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime nsec`
+ctime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime nsec`
+
+if [ $atime -ne 0 -o $mtime -ne 0 -o $ctime -ne 0 ]; then
+        echo "nsec should be zero when extended timestamps are disabled"
+        echo "atime: $atime, mtime: $mtime, ctime: $ctime"
+fi
+
+status=0
+exit
diff --git a/tests/ext4/043.out b/tests/ext4/043.out
new file mode 100644
index 00000000..f90f0a57
--- /dev/null
+++ b/tests/ext4/043.out
@@ -0,0 +1,2 @@
+QA output created by 043
+Silence is golden
diff --git a/tests/ext4/044 b/tests/ext4/044
new file mode 100755
index 00000000..a1412684
--- /dev/null
+++ b/tests/ext4/044
@@ -0,0 +1,87 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test No. 044
+#
+# Test file timestamps are precise to nanoseconds with 256-byte inodes
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
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext3 ext4
+_supported_os Linux
+_require_scratch
+_require_test_program "t_ext4_file_time"
+
+echo "Silence is golden"
+
+echo "Test timestamps with 256 inode size one device $SCRATCH_DEV" >$seqres.full
+_scratch_mkfs_ext4 -t ext3 -I 256 >> $seqres.full 2>&1
+_scratch_mount
+
+# Create file
+touch "${SCRATCH_MNT}/tmp_file"
+sleep 1
+
+# Change atime, ctime and mtime of the file
+touch "${SCRATCH_MNT}/tmp_file"
+
+cur_time=`date '+%s %N'`
+sec=`echo $cur_time | awk {'print $1'}`
+nsec=`echo $cur_time | awk {'print $2'}`
+
+sec_atime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime sec`
+sec_mtime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime sec`
+sec_ctime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime sec`
+nsec_atime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime nsec`
+nsec_mtime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime nsec`
+nsec_ctime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime nsec`
+
+# Test nanosecond
+if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]; then
+        _fail "The timestamp is not nanosecond(nsec_atime: $nsec_atime, \ 
+              nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime, cur_time[ns]: $nsec)"
+fi
+
+# Check difference between file time and current time
+[ $(( $sec_atime - $sec )) -gt 1 ] && echo "The timestamp is wrong, sec_atime: $sec_atime, cur_time[s]: $sec"
+[ $(( $sec_mtime - $sec )) -gt 1 ] && echo "The timestamp is wrong, sec_atime: $sec_atime, cur_time[s]: $sec"
+[ $(( $sec_ctime - $sec )) -gt 1 ] && echo "The timestamp is wrong, sec_atime: $sec_atime, cur_time[s]: $sec"
+
+_scratch_unmount >> $seqres.full 2>&1
+
+# Test mount to ext3 then mount back to ext4 and check timestamp again
+_mount -t ext3 `_scratch_mount_options $*` || _fail "ext3 mount failed"
+_scratch_unmount >> $seqres.full 2>&1
+_scratch_mount
+
+nsec_atime2=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime nsec`
+nsec_mtime2=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime nsec`
+nsec_ctime2=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime nsec`
+
+[ $nsec_atime -ne $nsec_atime2 ] && echo "File nanosecond timestamp atime has changed unexpected from $nsec_atime to $nsec_atime2"
+[ $nsec_mtime -ne $nsec_mtime2 ] && echo "File nanosecond timestamp mtime has changed unexpected from $nsec_mtime to $nsec_mtime2"
+[ $nsec_ctime -ne $nsec_ctime2 ] && echo "File nanosecond timestamp ctime has changed unexpected from $nsec_ctime to $nsec_ctime2"
+
+status=0
+exit
diff --git a/tests/ext4/044.out b/tests/ext4/044.out
new file mode 100644
index 00000000..12a61dc4
--- /dev/null
+++ b/tests/ext4/044.out
@@ -0,0 +1,2 @@
+QA output created by 044
+Silence is golden
diff --git a/tests/ext4/045 b/tests/ext4/045
new file mode 100755
index 00000000..76cc5067
--- /dev/null
+++ b/tests/ext4/045
@@ -0,0 +1,134 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test No. 045
+#
+# Test subdirectory limit of ext4. 
+# We create more than 32000 subdirectories on the ext4 filesystem.
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
+SHORT_DIR=1
+LONG_DIR=2
+FAIL=1
+PASS=0
+prev_block_size=0
+prev_result=$FAIL
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+
+_require_scratch
+_require_test_program "t_create_short_dirs"
+_require_test_program "t_create_long_dirs"
+_require_dumpe2fs "$DUMPE2FS_PROG" dumpe2fs
+
+echo "Silence is golden"
+
+# Run a test case
+# $1: Number of directories to create
+# $2: create short dir or long dir
+# $3: parent directory
+# $4: filesystem block size
+workout()
+{
+    local dir_name_len=
+    if [ $2 -eq $SHORT_DIR ]; then
+        dir_name_len="short name"
+    else
+        dir_name_len="long name"
+    fi
+
+    echo "Num of dirs to create: $1, Dir name len: $dir_name_len, " \
+          "Parent dir: $3, Block size: $4" >> $seqres.full 2>&1
+
+    # Only mkfs if block size has been changed, or previous case failed
+    if [ $prev_result -ne $PASS -o $4 -ne $prev_block_size ]; then
+        _scratch_mkfs -b $4 -I 256 >> $seqres.full 2>&1
+        prev_block_size=$4
+    fi
+    prev_result=$FAIL
+
+    _scratch_mount
+
+    # create directories
+    mkdir -p $3 2> /dev/null
+
+    if [ $2 -eq $SHORT_DIR ]; then
+        $here/src/t_create_short_dirs $1 $3
+    else
+        $here/src/t_create_long_dirs $1 $3
+    fi
+
+    if [ $? -ne 0 ]; then
+        nr_dirs=`ls $3 | wc -l`
+        echo "Failed to create directories - $nr_dirs"
+        _scratch_unmount
+        return
+    fi
+
+    # delete directories
+    cd $3
+    ls | xargs rmdir
+    if [ $? -ne 0 ]; then
+        echo "Failed to remove directories in $3"
+        cd - > /dev/null
+        _scratch_unmount
+        return
+    fi
+    cd - > /dev/null
+    _scratch_unmount
+
+    # check dir_nlink is set
+    $DUMPE2FS_PROG $SCRATCH_DEV 2> /dev/null | grep '^Filesystem features' | grep -q dir_nlink
+    if [ $? -ne 0 ]; then
+        echo "Feature dir_nlink is not set, please check $seqres.full for detail"
+        return
+    fi
+
+    # run fsck to make sure the filesystem has no errors
+    _check_scratch_fs
+    prev_result=$PASS
+}
+
+# main
+DIR_LEN=( $SHORT_DIR $LONG_DIR )
+PARENT_DIR=( "$SCRATCH_MNT" "$SCRATCH_MNT/sub" )
+BLOCK_SIZE=( 1024 2048 4096 )
+
+for ((i = 0; i < 3; i++)); do
+    for ((j = 0; j < 2; j++)); do
+        for ((k = 0; k < 2; k++)); do
+            if [ ${DIR_LEN[$k]} -eq $LONG_DIR -a \
+                    ${BLOCK_SIZE[$i]} -eq 1024 ]; then
+                continue
+            fi
+            workout 65537 ${DIR_LEN[$k]} ${PARENT_DIR[$j]} ${BLOCK_SIZE[$i]}
+        done
+    done
+done
+
+status=0
+exit
diff --git a/tests/ext4/045.out b/tests/ext4/045.out
new file mode 100644
index 00000000..66276cfa
--- /dev/null
+++ b/tests/ext4/045.out
@@ -0,0 +1,2 @@
+QA output created by 045
+Silence is golden
diff --git a/tests/ext4/group b/tests/ext4/group
index 9dfc0d35..9c2f600b 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -45,6 +45,9 @@
 040 dangerous_fuzzers
 041 dangerous_fuzzers
 042 auto quick
+043 auto quick
+044 auto quick
+045 auto quick dir
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.24.0

