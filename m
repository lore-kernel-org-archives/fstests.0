Return-Path: <SRS0=pS6L=4P=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99617C4BA3B
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Feb 2020 10:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1F524672
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Feb 2020 10:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXoMTEOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgB0Kfp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Feb 2020 05:35:45 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40026 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgB0Kfp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Feb 2020 05:35:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so2436071otr.7
        for <fstests@vger.kernel.org>; Thu, 27 Feb 2020 02:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UwM7Z7dUuedofJb1CB8qngdlyrYRs3VZxQvv+VcV9UA=;
        b=UXoMTEOxe5MNSvKINt1kZkzy5IFBQ5RRoh+VnCAZa069otX3Q+eCJ9c6rqJFhdo+8d
         xDtp5uql2QshN9jpyzpeK3va8MjcGZ/XMEwaJ/RJFbHSwS8bVYkvKVDvh2a131nEpRvg
         MB0SgEvqJe11hSLJMd5kn4y60EDCdQTaUcALilGhcJBA8N5Ia71amN0gL+OwsH7zjH6Q
         hD0yCilDQtEOz6h6I7WEu3eEQ809z7zE9y6zKFH0M97PqyReyORjOT7O/9ZFu7BF+7n2
         GVA7V4OuPr4DjQwZOijCS/Z+NM/B8ySQLFaQmq8kMkFZIGcT17ervUTekxUW9vo1qk4V
         QVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UwM7Z7dUuedofJb1CB8qngdlyrYRs3VZxQvv+VcV9UA=;
        b=PgWn2ApUNjIYt4/KfkdOF760rJhIJNiytYZopGsYiatDmi+J9eA2Bx5yZaUj8Xg5YJ
         /VrbjOiQxeNqK6Riuyeh3jkpBbEIGZxadYfSOuIZHMtba1r02Cy/6uClYFlzv+eYX6W9
         5it8sUmzW1Bh1bJt5vD7Y1K+YHQmi3WKoxmbjcn8AnS/U712/aNYLAea9VKQ3B4ySj/p
         1fYCvQrPZICP6bibPszhjLalp/jOTEnFEDddDyc2xOvbxqsjC00KCSk2Za5J+4p9GM+u
         IT0Rt5X8PeN1FL/E1seZQkP+EgkfjciJ0Nzf5jWBzYkcMVabnnT+G/fP+5zkRRU1Oc48
         QAcg==
X-Gm-Message-State: APjAAAUc6iikDgcg9DYdlmrS0CBCiI96oxdDEttuzYKKFa6s3evdP3aV
        oQYKFzSHKKKPNGTr/IfWCStbgUQfhLg=
X-Google-Smtp-Source: APXvYqzTR+B/R4mOye7eVv763wtWr9hhnEkAwn85zPD8ZEjVXIaZhFzm8wndCMGyL+m8jPzoaif4qA==
X-Received: by 2002:a05:6830:147:: with SMTP id j7mr2734789otp.12.1582799741828;
        Thu, 27 Feb 2020 02:35:41 -0800 (PST)
Received: from linux-50d1.gns.novell.com ([209.58.160.54])
        by smtp.gmail.com with ESMTPSA id 5sm1818006otr.13.2020.02.27.02.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 02:35:40 -0800 (PST)
From:   Yong Sun <sunyong0511@gmail.com>
X-Google-Original-From: Yong Sun <yosun@suse.com>
To:     fstests@vger.kernel.org
Cc:     Yong Sun <yosun@suse.com>, darrick.wong@oracle.com,
        guaneryu@gmail.com
Subject: [PATCH v7] fstests: transport two ext4 tests from LTP
Date:   Thu, 27 Feb 2020 18:35:07 +0800
Message-Id: <20200227103507.17966-1-yosun@suse.com>
X-Mailer: git-send-email 2.25.0
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
v6: Fix several issue reviewed by Eryu, and remove block setting in ext4/045
Refer to ext4/045 fail https://www.spinics.net/lists/linux-ext4/msg69467.html
v7: Fix several issue reviewed by Eryu
t_create_(long|short)_dirs.c have much different, better to keep two file.
---
 .gitignore                |   3 +
 src/Makefile              |   3 +-
 src/t_create_long_dirs.c  | 139 +++++++++++++++++++++++++++++++++++++
 src/t_create_short_dirs.c | 142 ++++++++++++++++++++++++++++++++++++++
 src/t_get_file_time.c     |  53 ++++++++++++++
 tests/ext4/043            |  56 +++++++++++++++
 tests/ext4/043.out        |   2 +
 tests/ext4/044            |  88 +++++++++++++++++++++++
 tests/ext4/044.out        |   2 +
 tests/ext4/045            | 111 +++++++++++++++++++++++++++++
 tests/ext4/045.out        |   2 +
 tests/ext4/group          |   3 +
 12 files changed, 603 insertions(+), 1 deletion(-)
 create mode 100644 src/t_create_long_dirs.c
 create mode 100644 src/t_create_short_dirs.c
 create mode 100644 src/t_get_file_time.c
 create mode 100755 tests/ext4/043
 create mode 100644 tests/ext4/043.out
 create mode 100755 tests/ext4/044
 create mode 100644 tests/ext4/044.out
 create mode 100755 tests/ext4/045
 create mode 100644 tests/ext4/045.out

diff --git a/.gitignore b/.gitignore
index 7e6b7daf..f3dc1a58 100644
--- a/.gitignore
+++ b/.gitignore
@@ -119,6 +119,8 @@
 /src/swapon
 /src/t_access_root
 /src/t_attr_corruption
+/src/t_create_long_dirs
+/src/t_create_short_dirs
 /src/t_dir_offset
 /src/t_dir_offset2
 /src/t_dir_type
@@ -127,6 +129,7 @@
 /src/t_ext4_dax_journal_corruption
 /src/t_futimens
 /src/t_getcwd
+/src/t_get_file_time
 /src/t_holes
 /src/t_immutable
 /src/t_locks_execve
diff --git a/src/Makefile b/src/Makefile
index b015e78b..f1d642c4 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -16,7 +16,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
-	t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent
+	t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent \
+	t_get_file_time t_create_short_dirs t_create_long_dirs
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/t_create_long_dirs.c b/src/t_create_long_dirs.c
new file mode 100644
index 00000000..0a7ee0fd
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
+#define NAME_LEN       255
+#define NCHARS         62
+#define MAX_LEN1       62
+#define MAX_LEN2       (62 * 62)
+#define MAX_LEN3       (62 * 62 * 62)
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
+       int i;
+
+       srand(time(NULL));
+
+       for (i = 0; i < NAME_LEN; i++)
+               name[i] = chars[rand() % 62];
+}
+
+void create_dir(void)
+{
+       if (mkdirat(parent_fd, name, S_IRWXU)) {
+               perror("mkdir");
+               exit(1);
+       }
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
+       int i, j, k;
+       int depth;
+
+       if (n <= MAX_LEN1)
+               depth = 1;
+       else if (n <= MAX_LEN2)
+               depth = 2;
+       else
+               depth = 3;
+
+       for (i = 0; i < NCHARS; i++) {
+               name[0] = chars[i];
+               if (depth == 1) {
+                       create_dir();
+                       if (--n == 0)
+                               return;
+                       continue;
+               }
+
+               for (j = 0; j < NCHARS; j++) {
+                       name[1] = chars[j];
+                       if (depth == 2) {
+                               create_dir();
+                               if (--n == 0)
+                                       return;
+                               continue;
+                       }
+
+                       for (k = 0; k < NCHARS; k++) {
+                               name[2] = chars[k];
+                               create_dir();
+                               if (--n == 0)
+                                       return;
+                       }
+               }
+       }
+}
+
+void usage()
+{
+       fprintf(stderr, "Usage: create_long_dirs nr_dirs parent_dir\n");
+}
+
+/*
+ * Create long-name directories
+ * @argv[1]: directory number
+ * @argv[2]: parent directory
+ */
+int main(int argc, char *argv[])
+{
+       if (argc != 3) {
+               usage();
+               return 1;
+       }
+
+       names = atoi(argv[1]);
+       if (names > MAX_LEN3 || names <= 0) {
+               usage();
+               return 1;
+       }
+
+       parent_fd = open(argv[2], O_RDONLY);
+       if (parent_fd == -1) {
+               perror("open parent dir failed");
+               return 1;
+       }
+
+       init_name();
+
+       create_dirs(names);
+
+       return 0;
+}
diff --git a/src/t_create_short_dirs.c b/src/t_create_short_dirs.c
new file mode 100644
index 00000000..b41582aa
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
+       if (mkdirat(parent_fd, name, S_IRWXU)) {
+               perror("mkdir");
+               exit(1);
+       }
+}
+
+/*
+ * create_1 - create length-1 directory names
+ * @n: how name names to be created
+ */
+void create_1(int n)
+{
+       int i;
+
+       name[1] = '\0';
+       for (i = 0; i < NCHARS; i++) {
+               name[0] = chars[i];
+               create_dir();
+               if (--n == 0)
+                       return;
+       }
+}
+
+/*
+ * create_2 - generate length-2 directory names
+ * @n: how many names to be created
+ */
+void create_2(int n)
+{
+       int i, j;
+
+       name[2] = '\0';
+       for (i = 0; i < NCHARS; i++) {
+               name[0] = chars[i];
+               for (j = 0; j < NCHARS; j++) {
+                       name[1] = chars[j];
+                       create_dir();
+                       if (--n == 0)
+                               return;
+               }
+       }
+}
+
+/*
+ * create_3 - generate length-3 directory names
+ * @n: how many names to be created
+ */
+void create_3(int n)
+{
+       int i, j, k;
+
+       name[3] = '\0';
+       for (i = 0; i < NCHARS; i++) {
+               name[0] = chars[i];
+               for (j = 0; j < NCHARS; j++) {
+                       name[1] = chars[j];
+                       for (k = 0; k < NCHARS; k++) {
+                               name[2] = chars[k];
+                               create_dir();
+                               if (--n == 0)
+                                       return;
+                       }
+               }
+       }
+}
+
+void usage()
+{
+       fprintf(stderr, "Usage: create_short_dirs nr_dirs parent_dir\n");
+}
+
+/*
+ * Create short-name directoriess
+ * @argv[1]: director number
+ * @argv[2]: the parent directory
+ */
+int main(int argc, char *argv[])
+{
+       if (argc != 3) {
+               usage();
+               return 1;
+       }
+
+       names = atoi(argv[1]);
+       if (names > MAX_NAMES || names <= 0) {
+               usage();
+               return 1;
+       }
+
+       parent_fd = open(argv[2], O_RDONLY);
+       if (parent_fd == -1) {
+               perror("open parent dir failed");
+               return 1;
+       }
+
+       create_1(names);
+       if (names <= MAX_LEN1)
+               return 0;
+
+       names -= MAX_LEN1;
+       create_2(names);
+       if (names <= MAX_LEN2)
+               return 0;
+
+       names -= MAX_LEN2;
+       create_3(names);
+
+       return 0;
+}
diff --git a/src/t_get_file_time.c b/src/t_get_file_time.c
new file mode 100644
index 00000000..90286a79
--- /dev/null
+++ b/src/t_get_file_time.c
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
+ * Usage: t_get_file_time <filename> <atime|mtime|ctime> <sec|nsec>
+ */
+int main(int argc, char *argv[])
+{
+       time_t t;
+       struct stat st;
+
+       if (argc != 4) {
+               fprintf(stderr, "Wrong argument num!\n");
+               return 1;
+       }
+
+       if (stat(argv[1], &st) != 0) {
+               perror("stat failed");
+               return 1;
+       }
+
+       if (strcmp(argv[3], "sec") == 0) {
+               if (strcmp(argv[2], "atime") == 0)
+                       t = st.st_atime;
+               else if (strcmp(argv[2], "mtime") == 0)
+                       t = st.st_mtime;
+               else
+                       t = st.st_ctime;
+       } else if (strcmp(argv[3], "nsec") == 0) {
+               if (strcmp(argv[2], "atime") == 0)
+                       t = st.st_atim.tv_nsec;
+               else if (strcmp(argv[2], "mtime") == 0)
+                       t = st.st_mtim.tv_nsec;
+               else
+                       t = st.st_ctim.tv_nsec;
+       } else {
+               fprintf(stderr, "Wrong argument: %s\n", argv[3]);
+               return 1;
+       }
+
+       printf("%lu\n", t);
+
+       return 0;
+}
diff --git a/tests/ext4/043 b/tests/ext4/043
new file mode 100755
index 00000000..5f8bfaf5
--- /dev/null
+++ b/tests/ext4/043
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 SUSE Linux Products GmbH.  All Rights Reserved.
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
+status=1       # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+       cd /
+       rm -f $tmp.*
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
+_require_test_program "t_get_file_time"
+
+echo "Silence is golden"
+
+echo "Start test timestamps with 128 inode size one device $SCRATCH_DEV" >$seqres.full
+_scratch_mkfs -I 128 >> $seqres.full 2>&1
+_scratch_mount
+
+touch "${SCRATCH_MNT}/tmp_file"
+
+atime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file atime nsec`
+mtime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file mtime nsec`
+ctime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file ctime nsec`
+
+if [ $atime -ne 0 -o $mtime -ne 0 -o $ctime -ne 0 ]; then
+       echo "nsec should be zero when extended timestamps are disabled"
+       echo "atime: $atime, mtime: $mtime, ctime: $ctime"
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
index 00000000..61b4f561
--- /dev/null
+++ b/tests/ext4/044
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 SUSE Linux Products GmbH.  All Rights Reserved.
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
+status=1       # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+       cd /
+       rm -f $tmp.*
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
+_require_scratch
+_require_test_program "t_get_file_time"
+
+echo "Silence is golden"
+
+echo "Test timestamps with 256 inode size one device $SCRATCH_DEV" >$seqres.full
+_scratch_mkfs -t ext3 -I 256 >> $seqres.full 2>&1
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
+sec=`echo $cur_time | $AWK_PROG {'print $1'}`
+nsec=`echo $cur_time | $AWK_PROG {'print $2'}`
+
+sec_atime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file atime sec`
+sec_mtime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file mtime sec`
+sec_ctime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file ctime sec`
+nsec_atime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file atime nsec`
+nsec_mtime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file mtime nsec`
+nsec_ctime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file ctime nsec`
+
+# Test nanosecond
+if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]; then
+       echo "The timestamp is not nanosecond(nsec_atime: $nsec_atime, \
+nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime, cur_time[ns]: $nsec)"
+fi
+
+# Check difference between file time and current time
+_within_tolerance "sec_atime" $sec_atime $sec 1
+_within_tolerance "sec_mtime" $sec_mtime $sec 1
+_within_tolerance "sec_ctime" $sec_ctime $sec 1
+
+_scratch_unmount >> $seqres.full 2>&1
+
+# Test mount to ext3 then mount back to ext4 and check timestamp again
+_mount -t ext3 `_scratch_mount_options $*` || _fail "ext3 mount failed"
+_scratch_unmount >> $seqres.full 2>&1
+_scratch_mount
+
+nsec_atime2=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file atime nsec`
+nsec_mtime2=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file mtime nsec`
+nsec_ctime2=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file ctime nsec`
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
index 00000000..068f82de
--- /dev/null
+++ b/tests/ext4/045
@@ -0,0 +1,111 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test No. 045
+#
+# Test subdirectory limit of ext4.
+# We create more than 65000 subdirectories on the ext4 filesystem.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1       # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+SHORT_DIR=1
+LONG_DIR=2
+
+_cleanup()
+{
+       cd /
+       rm -f $tmp.*
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
+workout()
+{
+       local dir_name_len=""
+       if [ $2 -eq $SHORT_DIR ]; then
+               dir_name_len="short name"
+       else
+               dir_name_len="long name"
+       fi
+
+       echo "Num of dirs to create: $1, Dir name len: $dir_name_len, " \
+               "Parent dir: $3" >> $seqres.full
+
+       _scratch_mkfs "-O extent,dir_nlink,dir_index -I 256" >> $seqres.full 2>&1
+       _scratch_mount
+
+       # create directories
+       mkdir -p $3 2> /dev/null
+
+       if [ $2 -eq $SHORT_DIR ]; then
+               $here/src/t_create_short_dirs $1 $3
+       else
+               $here/src/t_create_long_dirs $1 $3
+       fi
+
+       if [ $? -ne 0 ]; then
+               nr_dirs=`ls $3 | wc -l`
+               echo "Failed to create directories - $nr_dirs"
+               _scratch_unmount
+               return
+       fi
+
+       # delete directories
+       cd $3
+       ls | xargs rmdir
+       if [ $? -ne 0 ]; then
+               echo "Failed to remove directories in $3"
+               cd - > /dev/null
+               _scratch_unmount
+               return
+       fi
+       cd - > /dev/null
+       _scratch_unmount
+
+       # check dir_nlink is set
+       $DUMPE2FS_PROG -h $SCRATCH_DEV 2>> $seqres.full | grep '^Filesystem features' | grep -q dir_nlink
+       if [ $? -ne 0 ]; then
+               echo "Feature dir_nlink is not set, please check $seqres.full for detail"
+               return
+       fi
+}
+
+# main
+DIR_NUM=65537
+DIR_LEN=( $SHORT_DIR $LONG_DIR )
+PARENT_DIR="$SCRATCH_MNT/subdir"
+
+for ((i = 0; i < 2; i++)); do
+       workout $DIR_NUM ${DIR_LEN[$i]} $PARENT_DIR
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
index 62483c3f..a1adc553 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -44,6 +44,9 @@
 040 dangerous_fuzzers
 041 dangerous_fuzzers
 042 auto quick
+043 auto quick
+044 auto quick
+045 auto dir
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.25.0

