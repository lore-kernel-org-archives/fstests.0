Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88779C47094
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Jun 2021 21:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A3E61208
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Jun 2021 21:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhFGV5U (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Jun 2021 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGV5U (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Jun 2021 17:57:20 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D9FC061574
        for <fstests@vger.kernel.org>; Mon,  7 Jun 2021 14:55:12 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id d13so9904564uav.5
        for <fstests@vger.kernel.org>; Mon, 07 Jun 2021 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ho9LITi4MtGg2HFIwWtgjNqkyKaeYCfZ5pPkSOOvYGo=;
        b=Edo95UNBq6lI7s4kERqNFSccOg7Uc/g5ThEWwXki6zKtlZYmwXJOajoH8ovQuHf+rE
         9uJDVkA4slNDtSTPyxeJhxmgA8SGoOhlQXV3/f5fGrQ83rAYMioKr3J9n1I9LSRzneZ/
         81Tp5sRGaSjYv5aHDVnVTA77sP8KWCetlMSNKE9PLAw7Zha1eO0S9plWIxZI2AEG1GVE
         VJgHY+OauREeMIYg7F5Q+YAFFI6nDgMQmIJS+siBH5MJaBaXRWcjWSwF8Krwvh9XS1Mb
         NyRLJBWMHjyx/FxBg3pzMGW+lIm2oTQNwFnjPxZ6eULWCbygYae/fJ1KUCyMiEP10Pfm
         bqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ho9LITi4MtGg2HFIwWtgjNqkyKaeYCfZ5pPkSOOvYGo=;
        b=K+8yH16XmOrPRqNerGualrvmjMRw1jliEx5JTM8u6OnfQ89/DrDKrY4eT+FaoJK32m
         bWcZzxfbi3WcXLe/GcHR6YrGUGhV6/QRGYxeVZGQYcWQRc1u9JgBv6lj4iD2T4tnukVH
         XRptyExebToop2c+7Yxs1KPyxYgwspqI13YZci2zLTQ+ntdUHb2noDO48hLkl6WQToBt
         mA3SPwnGsrNQWIVvWBK5ego7YxRTEJucd5RtyZAooHYAf2FjacjoUfEhnLkBpCWoOzfn
         nRhGyOpIp2n8ReKlsC9TlecR5IdjgFJGM9IqwA6QGup8DunRn0k3dVlIFmLD4mJEMNIj
         MU1g==
X-Gm-Message-State: AOAM533r5c70HjMs2t+NweMi2XH9JWi9gbaKTa8lk2jjHG3EoPH9ItSl
        2lUkaKp2Zv0aRSPDbpIq/eEttgNvrMqhCA==
X-Google-Smtp-Source: ABdhPJxbgkUSlpTMBl0lRwex6HTswCkzCjV4KDs4LpnKrInodOleolZCo8spFCO2pGDj1yDAMacETw==
X-Received: by 2002:a9f:35a4:: with SMTP id t33mr10854645uad.43.1623102910722;
        Mon, 07 Jun 2021 14:55:10 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id y192sm2092043vsy.28.2021.06.07.14.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 14:55:10 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     fstests@vger.kernel.org
Cc:     guaneryu@gmail.com, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v3] ext4/309: test journal checkpoint ioctl
Date:   Mon,  7 Jun 2021 21:55:09 +0000
Message-Id: <20210607215509.3432807-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test for commit "ext4: add ioctl EXT4_IOC_CHECKPOINT". Tests journal
checkpointing and journal erasing via EXT4_IOC_CHECKPOINT with flag
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT set.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

Changes in v3:
- added SPDX header to new file src/checkpoint_journal.c
- updated test number to next available consecutive number (309)
- removed check for #defined(__linux__)
---
 .gitignore               |   1 +
 src/Makefile             |   2 +-
 src/checkpoint_journal.c |  97 +++++++++++++++++++++++++++++++++
 tests/ext4/309           | 115 +++++++++++++++++++++++++++++++++++++++
 tests/ext4/309.out       |   2 +
 tests/ext4/group         |   1 +
 6 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 src/checkpoint_journal.c
 create mode 100755 tests/ext4/309
 create mode 100644 tests/ext4/309.out

diff --git a/.gitignore b/.gitignore
index c62c1556..4e0220eb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -186,6 +186,7 @@ tags
 /src/idmapped-mounts/mount-idmapped
 /src/log-writes/replay-log
 /src/perf/*.pyc
+/src/checkpoint_journal
 
 # Symlinked files
 /tests/generic/035.out
diff --git a/src/Makefile b/src/Makefile
index 1279e4b9..5c76aa93 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -18,7 +18,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
-	t_mmap_writev_overlap
+	t_mmap_writev_overlap checkpoint_journal
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/checkpoint_journal.c b/src/checkpoint_journal.c
new file mode 100644
index 00000000..a4a6b695
--- /dev/null
+++ b/src/checkpoint_journal.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Google
+ * All Rights Reserved.
+ *
+ * checkpoint_journal.c
+ *
+ * Flush journal log and checkpoint journal for ext4 file system and
+ * optionally, issue discard or zeroout for the journal log blocks.
+ *
+ * Arguments:
+ * 1) mount point for device
+ * 2) flags (optional)
+ *	set --erase=discard to enable discarding journal blocks
+ *	set --erase=zeroout to enable zero-filling journal blocks
+ *	set --dry-run flag to only perform input checking
+ */
+
+#include <sys/ioctl.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <linux/fs.h>
+#include <getopt.h>
+
+#if !defined(EXT4_IOC_CHECKPOINT)
+#define EXT4_IOC_CHECKPOINT	_IOW('f', 43, __u32)
+#endif
+
+#if !defined(EXT4_IOC_CHECKPOINT_FLAG_DISCARD)
+#define EXT4_IOC_CHECKPOINT_FLAG_DISCARD		1
+#define EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT		2
+#define EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN		4
+#endif
+
+int main(int argc, char** argv) {
+	int fd, c, ret = 0, option_index = 0;
+	char* rpath;
+	unsigned int flags = 0;
+
+	static struct option long_options[] =
+	{
+		{"dry-run", no_argument, 0, 'd'},
+		{"erase", required_argument, 0, 'e'},
+		{0, 0, 0, 0}
+	};
+
+	/* get optional flags */
+	while ((c = getopt_long(argc, argv, "de:", long_options,
+				&option_index)) != -1) {
+		switch (c) {
+		case 'd':
+			flags |= EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN;
+			break;
+		case 'e':
+			if (strcmp(optarg, "discard") == 0) {
+				flags |= EXT4_IOC_CHECKPOINT_FLAG_DISCARD;
+			} else if (strcmp(optarg, "zeroout") == 0) {
+				flags |= EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT;
+			} else {
+				fprintf(stderr, "Error: invalid erase option\n");
+				return 1;
+			}
+			break;
+		default:
+			return 1;
+		}
+	}
+
+	if (optind != argc - 1) {
+		fprintf(stderr, "Error: invalid number of arguments\n");
+		return 1;
+	}
+
+	/* get fd to file system */
+	rpath = realpath(argv[optind], NULL);
+	fd = open(rpath, O_RDONLY);
+	free(rpath);
+
+	if (fd == -1) {
+		fprintf(stderr, "Error: unable to open device %s: %s\n",
+			argv[optind], strerror(errno));
+		return 1;
+	}
+
+	ret = ioctl(fd, EXT4_IOC_CHECKPOINT, &flags);
+
+	if (ret)
+		fprintf(stderr, "checkpoint ioctl returned error: %s\n", strerror(errno));
+
+	close(fd);
+	return ret;
+}
+
diff --git a/tests/ext4/309 b/tests/ext4/309
new file mode 100755
index 00000000..4b4a5861
--- /dev/null
+++ b/tests/ext4/309
@@ -0,0 +1,115 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Google, Inc. All Rights Reserved.
+#
+# FS QA Test No. 309
+#
+# Test checkpoint and zeroout of journal via ioctl EXT4_IOC_CHECKPOINT
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+status=1       # failure is the default!
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
+
+_require_scratch
+_require_command "$DEBUGFS_PROG" debugfs
+
+checkpoint_journal=$here/src/checkpoint_journal
+_require_test_program "checkpoint_journal"
+
+# convert output from stat<journal_inode> to list of block numbers
+get_journal_extents() {
+	inode_info=$($DEBUGFS_PROG $SCRATCH_DEV -R "stat <8>" 2>> $seqres.full)
+	echo -e "\nJournal info:" >> $seqres.full
+	echo "$inode_info" >> $seqres.full
+
+	extents_line=$(echo "$inode_info" | awk '/EXTENTS:/{ print NR; exit }')
+	get_extents=$(echo "$inode_info" | sed -n "$(($extents_line + 1))"p)
+
+	# get just the physical block numbers
+	get_extents=$(echo "$get_extents" |  perl -pe 's|\(.*?\):||g' | sed -e 's/, /\n/g' | perl -pe 's|(\d+)-(\d+)|\1 \2|g')
+
+	echo "$get_extents"
+}
+
+
+# checks all extents are zero'd out except for the superblock
+# arg 1: extents (output of get_journal_extents())
+check_extents() {
+	echo -e "\nChecking extents:" >> $seqres.full
+	echo "$1" >> $seqres.full
+
+	super_block="true"
+	echo "$1" | while IFS= read line; do
+		start_block=$(echo $line | cut -f1 -d' ')
+		end_block=$(echo $line | cut -f2 -d' ' -s)
+
+		# if first block of journal, shouldn't be wiped
+		if [ "$super_block" == "true" ]; then
+			super_block="false"
+
+			#if super block only block in this extent, skip extent
+			if [ -z "$end_block" ]; then
+				continue;
+			fi
+			start_block=$(($start_block + 1))
+		fi
+
+		if [ ! -z "$end_block" ]; then
+			blocks=$(($end_block - $start_block + 1))
+		else
+			blocks=1
+		fi
+
+		check=$(od $SCRATCH_DEV --skip-bytes=$(($start_block * $blocksize)) --read-bytes=$(($blocks * $blocksize)) -An -v | sed -e 's/[0 \t\n\r]//g')
+
+		[ ! -z "$check" ] && echo "error" && break
+	done
+}
+
+testdir="${SCRATCH_MNT}/testdir"
+
+_scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_scratch_mount >> $seqres.full 2>&1
+blocksize=$(_get_block_size $SCRATCH_MNT)
+mkdir $testdir
+
+# check if ioctl present, skip test if not present
+$checkpoint_journal $SCRATCH_MNT --dry-run || _notrun "journal checkpoint ioctl not present on device"
+
+# create some files to add some entries to journal
+for i in {1..100}; do
+	echo > $testdir/$i
+done
+
+# make sure these files get to the journal
+sync --file-system $testdir/1
+
+# call ioctl to checkpoint and zero-fill journal blocks
+$checkpoint_journal $SCRATCH_MNT --erase=zeroout || _fail "ioctl returned error"
+
+extents=$(get_journal_extents)
+
+# check journal blocks zeroed out
+ret=$(check_extents "$extents")
+[ "$ret" = "error" ] && _fail "Journal was not zero-filled"
+
+_scratch_unmount >> $seqres.full 2>&1
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/ext4/309.out b/tests/ext4/309.out
new file mode 100644
index 00000000..56330d65
--- /dev/null
+++ b/tests/ext4/309.out
@@ -0,0 +1,2 @@
+QA output created by 309
+Silence is golden
diff --git a/tests/ext4/group b/tests/ext4/group
index c246feb8..a7f70224 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -61,3 +61,4 @@
 306 auto rw resize quick
 307 auto ioctl rw defrag
 308 auto ioctl rw prealloc quick defrag
+309 auto ioctl quick
-- 
2.32.0.rc1.229.g3e70b5a671-goog

