Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10BBC433B4
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 10:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA0561406
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 10:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbhDWKIP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Apr 2021 06:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhDWKIN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Apr 2021 06:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619172457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjTHkgCoHdQV9FLiiIxBHs0FJ1X0b45D3uSJb26HYqY=;
        b=GTlYRyytaSqE/lN4Au8m9X3PygN9iB+lEH25B0gESr1EGhUURJrlWgxevPYo71W1jlTsAB
        LRohYoltcYaec5so52sxmKP1mfuUEx+ACOVYwKm5ZiLP5NtC2TGJVWmgfDqrou20l3I758
        Tu14DBnf704akqImHU8Qc2Mmu1EviWk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-Ncc5AXg1PeWbnxa8DukxlQ-1; Fri, 23 Apr 2021 06:07:35 -0400
X-MC-Unique: Ncc5AXg1PeWbnxa8DukxlQ-1
Received: by mail-wr1-f71.google.com with SMTP id f15-20020adffccf0000b02901028c7339ccso14930489wrs.1
        for <fstests@vger.kernel.org>; Fri, 23 Apr 2021 03:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjTHkgCoHdQV9FLiiIxBHs0FJ1X0b45D3uSJb26HYqY=;
        b=dQUWC9id5rGZ9++ACN4VZ0CyUfKmEuNJre0JFgSlkd/qbjAZHzyqnczz4dZfklNBVF
         JwsHlDTYFsfqH1urodNLME1iuVdk0ChDxycIJkRx/4M/6Py+NkvhXvzbS2LwK5X8FeVU
         GyTmqkEN6OnRZ0Xkspj1wji6ULNUcNiZBRqp1Ak3YLsbuxRt1zdDzkN7RjGzy0G6ZExz
         g1Nlgqs8Fq0hT0qH4EGDaaKIvDHCo3Vi0k91F7gnX6YF9DoI2wPugtZXC3fC39TQNvBn
         MEY1eb43S6sQCtBNrNQpVvL+3hAOokrVwEPht11llL52W+zYWcgJEmzBqqbP47E0CAxH
         jUxQ==
X-Gm-Message-State: AOAM531QGqoj4PzuJkvHE+QBE7zAdhB5zfoTl7VLyvsFVueKUC88Ofmo
        BhQorxRManlG5pnBaZJ85avXjbRBUzoloajVKAgwUUaEaRQijqK2ymnKMdC8z5bQA3LJ/9e7Rpl
        XNdJnoSylzflLv5XkW1wLU5tuW5nDvXoldBVPLmTMHL4Mt7ESAgaciZS9qj0QFM6rpY6a
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr3718408wrw.425.1619172454129;
        Fri, 23 Apr 2021 03:07:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDSJZM/zkuLMiEiK8nJz2xGX1VPJThSdoVI3lW4PDQE81geslga+eFCqrzmX/7VI+92pk5aA==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr3718385wrw.425.1619172453910;
        Fri, 23 Apr 2021 03:07:33 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id z14sm9887003wrt.54.2021.04.23.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:07:33 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     bfoster@redhat.com, shreeya.patel@collabora.com
Subject: [PATCH v2 1/1] generic/495: split the test
Date:   Fri, 23 Apr 2021 12:07:31 +0200
Message-Id: <20210423100731.14111-2-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423100731.14111-1-preichl@redhat.com>
References: <20210423100731.14111-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Split each swap-file test into its own test. So on file-systems that
do not support e.g. sparse files (exfat) other swap-file tests can be
executed.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 tests/generic/495     | 14 ++-----------
 tests/generic/495.out |  3 ---
 tests/generic/634     | 49 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/634.out |  2 ++
 tests/generic/group   |  1 +
 5 files changed, 54 insertions(+), 15 deletions(-)
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
index 00000000..8e15a4f0
--- /dev/null
+++ b/tests/generic/634
@@ -0,0 +1,49 @@
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

