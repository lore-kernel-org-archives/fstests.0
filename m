Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B31BC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Feb 2022 10:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiBVKhd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiBVKhd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Feb 2022 05:37:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA91BAB444
        for <fstests@vger.kernel.org>; Tue, 22 Feb 2022 02:37:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9A3F31F397;
        Tue, 22 Feb 2022 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645526226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4rK7RzRYhj5M1VJUj0lwN3XM2KaV+s8Xa98ryny+fYs=;
        b=YYbiZzDiG0NCKcBDCLN+3gvdthw8DuJoG90LykIWNJ4X2Bp5my2tGPoHD4tGZIO7LaCu2X
        R6fBelSQqhusZ+fXXPWadfKcsZYdErobf9fHWLbtHCIeuF7uH/P9b1Z3KzGsEVetJsXvRg
        BZeby3TNdfnR5mM+OfHPUBMGtx/xcVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645526226;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4rK7RzRYhj5M1VJUj0lwN3XM2KaV+s8Xa98ryny+fYs=;
        b=dOIbK6l3klt4jeo7389XpJJAUuNU+dA3i6au7rR4vJw/+q3/RxxNLi/pYoeQ7KBEqMitIU
        AY43wCWlS0wt0HDQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 84A3EA3B88;
        Tue, 22 Feb 2022 10:37:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 43144A0606; Tue, 22 Feb 2022 11:37:06 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH] generic/673: Add test for seekdir
Date:   Tue, 22 Feb 2022 11:36:58 +0100
Message-Id: <20220222103658.12978-1-jack@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add test checking functionality of seekdir. We check whether seekdir
gets us back to the directory entry it should and also whether seeking
to random positions does not crash the filesystem.

Unlike test generic/310 which also tests seeking, this test checks both
glibc readdir() function as well as getdents64() syscall directly. This
is because glibc readdir() implementation does a lot of caching and
processing internally thus hiding kernel from some possible problems.
Also test wider range of random offsets to have better chance of
hitting out of bound accesses or other bugs.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 .gitignore            |   1 +
 src/Makefile          |   2 +-
 src/t_readdir_3.c     | 238 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/673     |  41 ++++++++
 tests/generic/673.out |   2 +
 5 files changed, 283 insertions(+), 1 deletion(-)
 create mode 100644 src/t_readdir_3.c
 create mode 100755 tests/generic/673
 create mode 100644 tests/generic/673.out

diff --git a/.gitignore b/.gitignore
index ba0c572b248f..ca6ba5c473fa 100644
--- a/.gitignore
+++ b/.gitignore
@@ -158,6 +158,7 @@ tags
 /src/t_open_tmpfiles
 /src/t_readdir_1
 /src/t_readdir_2
+/src/t_readdir_3
 /src/t_rename_overwrite
 /src/t_stripealign
 /src/t_truncate_cmtime
diff --git a/src/Makefile b/src/Makefile
index 111ce1d90fe6..4d9e02b74d13 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -31,7 +31,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
-	detached_mounts_propagation ext4_resize
+	detached_mounts_propagation ext4_resize t_readdir_3
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py
diff --git a/src/t_readdir_3.c b/src/t_readdir_3.c
new file mode 100644
index 000000000000..e5179ab27c51
--- /dev/null
+++ b/src/t_readdir_3.c
@@ -0,0 +1,238 @@
+#define _LARGEFILE64_SOURCE
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <dirent.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <errno.h>
+#include <stdint.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/syscall.h>
+
+/* Our own declaration taken from the kernel since glibc does not have it... */
+struct linux_dirent64 {
+	uint64_t	d_ino;
+	int64_t		d_off;
+	unsigned short	d_reclen;
+	unsigned char	d_type;
+	char		d_name[];
+};
+
+#define MIN_NAME_LEN 8
+#define MAX_NAME_LEN 70
+
+static DIR *dir;
+static int dfd;
+static int ignore_error;
+
+struct dir_ops {
+	loff_t (*getpos)(void);
+	void (*setpos)(loff_t pos);
+	void (*getentry)(struct dirent *entry);
+};
+
+static off64_t libc_getpos(void)
+{
+	return telldir(dir);
+}
+
+static void libc_setpos(off64_t pos)
+{
+	seekdir(dir, pos);
+}
+
+static void libc_getentry(struct dirent *entry)
+{
+	struct dirent *ret;
+
+	errno = 0;
+	ret = readdir(dir);
+	if (!ret) {
+		if (errno == 0) {
+			fprintf(stderr, "Unexpected EOF while reading dir.\n");
+			exit(1);
+		}
+		if (ignore_error)
+			return;
+		perror("readdir");
+		exit(1);
+	}
+	memcpy(entry, ret, sizeof(struct dirent));
+}
+
+static off64_t kernel_getpos(void)
+{
+	return lseek64(dfd, 0, SEEK_CUR);
+}
+
+static void kernel_setpos(off64_t pos)
+{
+	lseek64(dfd, pos, SEEK_SET);
+}
+
+static void kernel_getentry(struct dirent *entry)
+{
+	char dirbuf[NAME_MAX + 1 + sizeof(struct linux_dirent64)];
+	struct linux_dirent64 *lentry = (struct linux_dirent64 *)dirbuf;
+	int ret;
+
+	ret = syscall(SYS_getdents64, dfd, lentry, sizeof(dirbuf));
+	if (ret < 0) {
+		if (ignore_error)
+			return;
+		perror("getdents64");
+		exit(1);
+	}
+	if (ret == 0) {
+		fprintf(stderr, "Unexpected EOF while reading dir.\n");
+		exit(1);
+	}
+	entry->d_ino = lentry->d_ino;
+	entry->d_off = lentry->d_off;
+	entry->d_reclen = lentry->d_reclen;
+	entry->d_type = lentry->d_type;
+	strcpy(entry->d_name, lentry->d_name);
+}
+
+struct dir_ops libc_ops = {
+	.getpos = libc_getpos,
+	.setpos = libc_setpos,
+	.getentry = libc_getentry,
+};
+
+struct dir_ops kernel_ops = {
+	.getpos = kernel_getpos,
+	.setpos = kernel_setpos,
+	.getentry = kernel_getentry,
+};
+
+static void create_dir(char *dir, int count)
+{
+	int i, j, len;
+	char namebuf[MAX_NAME_LEN];
+	int dfd, fd;
+
+	dfd = open(dir, O_RDONLY | O_DIRECTORY);
+	if (dfd < 0) {
+		perror("Cannot open dir");
+		exit(1);
+	}
+	for (i = 0; i < count; i++) {
+		len = random() % (MAX_NAME_LEN - MIN_NAME_LEN) + MIN_NAME_LEN;
+		for (j = 0; j < len; j++)
+			namebuf[j] = random() % 26 + 'a';
+		namebuf[len] = 0;
+
+		fd = openat(dfd, namebuf, O_RDWR | O_CREAT | O_EXCL, 0644);
+		if (fd < 0) {
+			if (errno == EEXIST) {
+				/* Try again */
+				i--;
+				continue;
+			}
+			perror("File creation failed");
+			exit(1);
+		}
+		close(fd);
+	}
+	close(dfd);
+}
+
+static void test(int count, struct dir_ops *ops)
+{
+	struct dirent *dbuf;
+	struct dirent entry;
+	loff_t *pbuf;
+	loff_t dpos, maxpos = 0;
+	int i, pos;
+
+	dbuf = calloc(count, sizeof(struct dirent));
+	pbuf = calloc(count, sizeof(loff_t));
+	if (!dbuf || !pbuf) {
+		fprintf(stderr, "Out of memory for buffers.\n");
+		exit(1);
+	}
+
+	for (i = 0; i < count; i++) {
+		pbuf[i] = ops->getpos();
+		if (pbuf[i] > maxpos)
+			maxpos = pbuf[i];
+		ops->getentry(dbuf + i);
+		ops->setpos(dbuf[i].d_off);
+	}
+
+	for (i = 0; i < count; i++) {
+		pos = random() % count;
+		ops->setpos(pbuf[pos]);
+		ops->getentry(&entry);
+		if (dbuf[pos].d_ino != entry.d_ino ||
+		    dbuf[pos].d_type != entry.d_type ||
+		    strcmp(dbuf[pos].d_name, entry.d_name)) {
+			fprintf(stderr,
+				"Mismatch in dir entry %u at pos %llu\n", pos,
+				(unsigned long long)pbuf[pos]);
+			exit(1);
+		}
+	}
+	puts("Reading valid entries passed.");
+
+	ignore_error = 1;
+	for (i = 0; i < count; i++) {
+		dpos = random() % maxpos;
+		ops->setpos(dpos);
+		/*
+		 * We don't care about the result but the kernel should not
+		 * crash.
+		 */
+		ops->getentry(&entry);
+	}
+	ignore_error = 0;
+
+	puts("Reading random positions passed.");
+	free(dbuf);
+	free(pbuf);
+}
+
+int main(int argc, char *argv[])
+{
+	int count;
+	unsigned long seed;
+
+	if (argc != 4) {
+		fprintf(stderr, "Usage: t_seekdir_3 <dir> <count> <seed>\n");
+		return 1;
+	}
+
+	count = atoi(argv[2]);
+	seed = atol(argv[3]);
+
+	srandom(seed);
+
+	create_dir(argv[1], count);
+
+	puts("Testing readdir...");
+	dir = opendir(argv[1]);
+	if (!dir) {
+		perror("Cannot open dir");
+		exit(1);
+	}
+	test(count, &libc_ops);
+	closedir(dir);
+	dir = NULL;
+
+	puts("Testing getdents...");
+	dfd = open(argv[1], O_DIRECTORY | O_RDONLY);
+	if (dfd < 0) {
+		perror("Cannot open dir");
+		exit(1);
+	}
+	test(count, &kernel_ops);
+	close(dfd);
+	dfd = 0;
+	fprintf(stderr, "All tests passed\n");
+
+	return 0;
+}
diff --git a/tests/generic/673 b/tests/generic/673
new file mode 100755
index 000000000000..2e413c80b707
--- /dev/null
+++ b/tests/generic/673
@@ -0,0 +1,41 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test 673
+#
+# Test that filesystem properly handles seeking in directory both to valid
+# and invalid positions.
+#
+# This is a regression test for a48fc69fe658 ("udf: Fix crash after seekdir")
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+dir=$TEST_DIR/$seq-dir
+
+# Override the default cleanup function.
+_cleanup()
+{
+	rm -rf $dir
+}
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_test
+_require_test_program "t_readdir_3"
+
+files=4000
+seed=$RANDOM
+
+mkdir $dir
+echo "Using seed $seed" >> $seqres.full
+$here/src/t_readdir_3 $dir $files $seed >> $seqres.full
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/673.out b/tests/generic/673.out
new file mode 100644
index 000000000000..e038de2ca346
--- /dev/null
+++ b/tests/generic/673.out
@@ -0,0 +1,2 @@
+QA output created by 673
+All tests passed
-- 
2.31.1

