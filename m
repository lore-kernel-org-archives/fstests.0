Return-Path: <SRS0=YV7M=ZQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DDEC432C0
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Nov 2019 14:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4233E2071A
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Nov 2019 14:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET8DHAuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKXOaJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Nov 2019 09:30:09 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:54907 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKXOaJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Nov 2019 09:30:09 -0500
Received: by mail-wm1-f51.google.com with SMTP id b11so2990921wmj.4;
        Sun, 24 Nov 2019 06:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w6XPxMD1xfZU9M95aFkTQnmgJPOQe+sMuAbHFjGOuEc=;
        b=ET8DHAuHFdAGLreIksZK8jtOMPvnfTkgcurg5PWSeYG4doL13vikHzsr0w38fBnERm
         ASRTT+JIHeCbhdBjEXalI4QIcjjcWj5i+F0UJZz0Yroz1VbDu5Xf5m0VroZJsKHCeJOl
         KVm5CaprMwLgcgh+0F6DPinjq9+YxMac8wN74hEkYg9LAr9SX1K+w6ZcYx/Cgvy9MoiQ
         LTgQGz0vrZtxURVjQbMZtExAS9XXxxgpe1K+EZh9W8QZa+qmkUjEZVwLEjj1RzybmoHb
         fEiMFZGnq8O/n1on5/jI8WMb2Kprm6QttTroBrr9TO2/YLysPNYBZwIFn3LDFvPNMfW5
         eW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w6XPxMD1xfZU9M95aFkTQnmgJPOQe+sMuAbHFjGOuEc=;
        b=XybcRteyqH26OonB8Z5SQT01BWYiBEnTkD2gtqb1nMIhfChNDeTVk7y31O6yxB79bu
         K4DLpyZ21hIThEgBq246gKg75TVB7f4YzlXJb59MVB+Btk14XO1byd4tlAbmCblT6wBi
         jRUWKt+lH6ZWnfoAgMPdIueOF5iQxWYqCEDqnQ3LF5D05OYMhSU2DKA69WPhkIhLSCM4
         GXxFXv9JiukJ4O0V3zTru1vOp8dtOBhEl8rK37+S46ZyK/e81M3lQolja8qmnGB+VZcv
         baWYgNK2CqhZy2dKMGdWIkAFVxYlEB7wB7HPY3IORMGMt9I1H6jH8T7pvLrsV8ItTqkY
         VwDg==
X-Gm-Message-State: APjAAAV8/OulcTy/JWCerMDu1CwZu5tVJWGEP5LFAui3JnlarlMtNqNn
        0oOLn1TsMBlEbbZGKS6P7hc=
X-Google-Smtp-Source: APXvYqzHrlFz7e0caKTCkN3ex7SGOzwZRI/WVF9yU9RXBG3WhB5pVN6sRp8O7h79HF4f/z6cOPEkqg==
X-Received: by 2002:a1c:9804:: with SMTP id a4mr24324872wme.57.1574605806286;
        Sun, 24 Nov 2019 06:30:06 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d202sm5131518wmd.47.2019.11.24.06.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 06:30:05 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH] overlay: Test unique st_dev;st_ino on non-samefs setup
Date:   Sun, 24 Nov 2019 16:29:57 +0200
Message-Id: <20191124142957.20873-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Check that files from middle layer on same fs as upper layer
are not allowed to export the real inode st_dev;st_ino.

This is a regression test for kernel commit:
  ovl: fix corner case of non-unique st_dev;st_ino

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Eryu,

This is a test for kernel v4.17 regression I noticed during discussion
on an unrelated change.

The fix for this regression has been posted [1] last week, but did not
get any feedback yet. So maybe wait with merging the test until Miklos
ackloledges the bug, or until the fix commit has a final description.

As the test demonstrates in a simple user scenario, the problem is real,
although I have no idea how common this setup is in the wild.

Thanks,
Amir.

[1] https://marc.info/?l=linux-unionfs&m=157400544201252&w=2

 tests/overlay/067     | 94 +++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/067.out |  2 +
 tests/overlay/group   |  1 +
 3 files changed, 97 insertions(+)
 create mode 100755 tests/overlay/067
 create mode 100644 tests/overlay/067.out

diff --git a/tests/overlay/067 b/tests/overlay/067
new file mode 100755
index 00000000..88bcd399
--- /dev/null
+++ b/tests/overlay/067
@@ -0,0 +1,94 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 CTERA Networks. All Rights Reserved.
+#
+# FSQA Test No. 067
+#
+# Test unique st_dev;st_ino on non-samefs setup.
+#
+# Check that files from middle layer on same fs as upper layer
+# are not allowed to export the real inode st_dev;st_ino.
+#
+# This is a regression test for kernel commit:
+#   ovl: fix corner case of non-unique st_dev;st_ino
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
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs overlay
+_supported_os Linux
+# Use non-default scratch underlying overlay dirs, we need to check
+# them explicity after test.
+_require_scratch_nocheck
+_require_test
+
+# Lower is on test partition
+lower=$OVL_BASE_TEST_DIR/$OVL_LOWER-$seq
+# Upper/work are on scratch partition
+middle=$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
+upper=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
+work=$OVL_BASE_SCRATCH_MNT/$OVL_WORK
+
+rm -rf $lower
+mkdir $lower
+
+_scratch_mkfs >>$seqres.full 2>&1
+
+realfile=$middle/file
+testfile=$SCRATCH_MNT/file
+
+# Create a file on middle layer on same fs as upper layer
+echo wrong > $realfile
+
+# Mount an overlay on $SCRATCH_MNT with lower layer on test partition
+# and middle and upper layer on scratch partition.
+# Disable xino, so not all overlay inodes are on the same st_dev.
+_overlay_scratch_mount_dirs $middle:$lower $upper $work -o xino=off || \
+	_notrun "cannot mount overlay with xino=off option"
+
+stat $realfile >>$seqres.full
+stat $testfile >>$seqres.full
+
+# Diverge the content of the overlay file from its origin
+echo right > $testfile
+
+stat $testfile >>$seqres.full
+
+# Expect the overlay file to differ from the original lower file
+diff -q $realfile $testfile >>$seqres.full &&
+	echo "diff with middle layer file doesn't know right from wrong! (warm cache)"
+
+echo 3 > /proc/sys/vm/drop_caches
+
+stat $testfile >>$seqres.full
+
+# Expect the overlay file to differ from the original lower file
+diff -q $realfile $testfile >>$seqres.full &&
+	echo "diff with middle layer file doesn't know right from wrong! (cold cache)"
+
+$UMOUNT_PROG $SCRATCH_MNT
+# check overlayfs
+_overlay_check_scratch_dirs $middle:$lower $upper $work -o xino=off
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/overlay/067.out b/tests/overlay/067.out
new file mode 100644
index 00000000..daa15453
--- /dev/null
+++ b/tests/overlay/067.out
@@ -0,0 +1,2 @@
+QA output created by 067
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index 1dec7db9..b7cd7774 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -69,3 +69,4 @@
 064 auto quick copyup
 065 auto quick mount
 066 auto quick copyup
+067 auto quick copyup nonsamefs
-- 
2.17.1

