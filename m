Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFB6C433B4
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Apr 2021 22:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAEC613C0
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Apr 2021 22:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhDTWbX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233964AbhDTWbV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Apr 2021 18:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618957849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AItElApSRdEF8SscMo5EztqES4DYNXjN4KKabpK9fWM=;
        b=SskJWxZV2nRFrDPK//Vkz+JZabGw0tbPg0xzO+ixlLNXnu8aggd0S2KKIOHm7f9jbtoW3N
        IhtV10J1NXv+8AM+T10VkCZ1upca2VzbRJfgvJ5Tj+5n/0q7vWCn+VEelCPRhww14n4hD9
        ZrQajY8uRs8uTpO56slCfaMuCbEASmg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-nDM6ehUyN62KhMPTSYZbnQ-1; Tue, 20 Apr 2021 18:30:47 -0400
X-MC-Unique: nDM6ehUyN62KhMPTSYZbnQ-1
Received: by mail-wr1-f69.google.com with SMTP id o14-20020a5d474e0000b029010298882dadso11622054wrs.2
        for <fstests@vger.kernel.org>; Tue, 20 Apr 2021 15:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AItElApSRdEF8SscMo5EztqES4DYNXjN4KKabpK9fWM=;
        b=rFktQtglDpwPSKtf+HYYleRpm6c3KFDkaDXM3D9YhcOFFGlzpVh4IR4hP9nMlE3H8w
         WtoAGSjp6v2d0JV9sfh/8gMO7RCGIjjJKqx2DhnoJdP86ezk/pkQqrFMzoQLYFXIYhZg
         yOXolejdysOEE13DjGwC18cbnCFJA9BxlN4WsQlu5JcRSecvRoSu102eSLxdKQ0uG61G
         v8BtURN1R5HD8bRsLpoOeQRbpaYiXIdhsH8wMsvH1m1ozXauTEvEhhqrhBI6kZMLtALM
         LoLi3njHocEFd2P+oPTZZ2Bvb7jtHpcYpQb2+XVmI+5M8GzMEp/+7dXiIo8V+R0FSafy
         Jw+w==
X-Gm-Message-State: AOAM530blk+YJNEJoM619AiUVNgBeAVSY5F+tAAD1H+fKTPC0q01B7Wn
        27pQye0xKOWFKwUwmsuhTT7ybuCQBjQH314IyyffstCdctXluzYU/J+/l8japqNFcuyfH8QqL2i
        e3HgArQ/uQCwfN4NSIqfvU4NA6remxCobvGUux8Q/0ZsC2lfPUTdmM4V7KusLrxPY8QHC
X-Received: by 2002:a5d:4246:: with SMTP id s6mr22765695wrr.257.1618957846036;
        Tue, 20 Apr 2021 15:30:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytQ61YNK1ooce51tneaUCkqQCY3USW+NJOCZfmQ4CPPXiEe5gz7C1blJXOOe1oG5pPtz1M6w==
X-Received: by 2002:a5d:4246:: with SMTP id s6mr22765683wrr.257.1618957845812;
        Tue, 20 Apr 2021 15:30:45 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id o1sm444417wrw.95.2021.04.20.15.30.45
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 15:30:45 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/495: split the test
Date:   Wed, 21 Apr 2021 00:30:44 +0200
Message-Id: <20210420223044.51214-1-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Split each swap-file test into its own test. So on file-systems that
do not support e.g. sparse files (exfat) other swap-file tests can be
executed.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/generic/495     | 14 ++----------
 tests/generic/495.out |  3 ---
 tests/generic/634     | 50 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/634.out |  2 ++
 tests/generic/group   |  1 +
 5 files changed, 55 insertions(+), 15 deletions(-)
 create mode 100755 tests/generic/634
 create mode 100644 tests/generic/634.out

diff --git a/tests/generic/495 b/tests/generic/495
index 79a8abb3..f1a8a619 100755
--- a/tests/generic/495
+++ b/tests/generic/495
@@ -4,7 +4,7 @@
 #
 # FS QA Test 495
 #
-# Test invalid swap files.
+# Test invalid swap file (with holes)
 #
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
@@ -32,11 +32,11 @@ _supported_fs generic
 _require_scratch_swapfile
 _require_test_program mkswap
 _require_test_program swapon
+_require_sparse_files
 
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 
-echo "File with holes"
 # We can't use _format_swapfile because we're using our custom mkswap and
 # swapon.
 touch "$SCRATCH_MNT/swap"
@@ -47,15 +47,5 @@ $XFS_IO_PROG -c "truncate $(($(get_page_size) * 10))" "$SCRATCH_MNT/swap"
 "$here/src/swapon" "$SCRATCH_MNT/swap"
 swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
 
-echo "Empty swap file (only swap header)"
-rm -f "$SCRATCH_MNT/swap"
-touch "$SCRATCH_MNT/swap"
-$CHATTR_PROG +C "$SCRATCH_MNT/swap" >> $seqres.full 2>&1
-chmod 0600 "$SCRATCH_MNT/swap"
-_pwrite_byte 0x61 0 $(get_page_size) "$SCRATCH_MNT/swap" >> $seqres.full
-"$here/src/mkswap" "$SCRATCH_MNT/swap"
-"$here/src/swapon" "$SCRATCH_MNT/swap"
-swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
-
 status=0
 exit
diff --git a/tests/generic/495.out b/tests/generic/495.out
index a7e3b720..16de8245 100644
--- a/tests/generic/495.out
+++ b/tests/generic/495.out
@@ -1,5 +1,2 @@
 QA output created by 495
-File with holes
-swapon: Invalid argument
-Empty swap file (only swap header)
 swapon: Invalid argument
diff --git a/tests/generic/634 b/tests/generic/634
new file mode 100755
index 00000000..069d9f0e
--- /dev/null
+++ b/tests/generic/634
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Facebook. All Rights Reserved.
+#
+# FS QA Test 634
+#
+# Test invalid swap files.
+# Empty swap file (only swap header)
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
+_supported_fs generic
+_require_scratch_swapfile
+_require_test_program mkswap
+_require_test_program swapon
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+rm -f "$SCRATCH_MNT/swap"
+touch "$SCRATCH_MNT/swap"
+$CHATTR_PROG +C "$SCRATCH_MNT/swap" >> $seqres.full 2>&1
+chmod 0600 "$SCRATCH_MNT/swap"
+_pwrite_byte 0x61 0 $(get_page_size) "$SCRATCH_MNT/swap" >> $seqres.full
+"$here/src/mkswap" "$SCRATCH_MNT/swap"
+"$here/src/swapon" "$SCRATCH_MNT/swap"
+swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
+
+status=0
+exit
diff --git a/tests/generic/634.out b/tests/generic/634.out
new file mode 100644
index 00000000..b90e5758
--- /dev/null
+++ b/tests/generic/634.out
@@ -0,0 +1,2 @@
+QA output created by 634
+swapon: Invalid argument
diff --git a/tests/generic/group b/tests/generic/group
index 033465f1..158d759b 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -636,3 +636,4 @@
 631 auto rw overlay rename
 632 auto quick mount
 633 auto quick atime attr cap idmapped io_uring mount perms rw unlink
+634 auto quick swap
-- 
2.30.2

