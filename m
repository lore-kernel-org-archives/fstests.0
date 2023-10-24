Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A462C25B48
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Oct 2023 23:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbjJXXht (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Oct 2023 19:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbjJXXht (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Oct 2023 19:37:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC6610DA
        for <fstests@vger.kernel.org>; Tue, 24 Oct 2023 16:37:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5aaebfac4b0so3003056a12.2
        for <fstests@vger.kernel.org>; Tue, 24 Oct 2023 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1698190666; x=1698795466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8PpTv+uWkp5IFGC5paE61uGTyCzF2rR6Z84Y7JujcQ=;
        b=zdDNwxpmkb++/0cJvF/qFtyUn5AXjvwQ8LVubpqon1ervod7f1+OUTMMh6cc9ug6Rq
         SoYwyNdysuEYL+zIJApnCOkt7JTwbckj+n6R6bCXIRlhpDMX5mMrH7E6I2X7RZm22O8y
         G8pGgnleepKQvkXLA7IOCHLbTye1tMCFLmuAsk0YzcQPotSFuWw3Z31Hf7Q59BDdfdig
         MDeWvG74Q6vYq9sp20If843TC5eLdBkvdvPl7BS7uapUoTHXkrdCcAP8ZeRa+EaIdDGs
         lPLzKxv5L8PCCpsZyMSst91F7P7HnbDuQSkF9UkUNukUgCC+XUgygujskKg+wevokisy
         Z9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698190666; x=1698795466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8PpTv+uWkp5IFGC5paE61uGTyCzF2rR6Z84Y7JujcQ=;
        b=uw9CUF391yLvqjrO33Q1tIeoxGcSfQdEh7ncxpLc6yyrgwXWza7C+Ag/cZsj2CJj6b
         RGV4G+tXLhyvy86/Co2xv97W17HoBxsEeHU98pZB/DZyVLdmB9W0WaeMazgbRS6TJATQ
         EunmsPAHonWMObk/NYuAds7JvX/qtnDCb3nVDtUZRv8AH60TZK7VgrRR9W2UmPAqpI6o
         OcncnKlV3S+vrwhgv8RGTE+O7S5svCwJDury9lbtQLJtZENukLDpUur6NwCfWpjm3lTO
         Lac98l3QJ+HuyDApJL7o3t4vDIEYEALTTXacw6S+J3ELAh18SEoMHNi79vK+01Ap5AtX
         HQaQ==
X-Gm-Message-State: AOJu0YxC3dALhhhTUmviNKBLm1N7tL2JcAT7AA7juNiZcbjSLfL/8e1N
        93fZVZjTHuWiZMkl2RWOSwVPlsBt1DpZSCebXLM=
X-Google-Smtp-Source: AGHT+IFt17sjbFdWXpbnFV5tHaor2KEpN3UQGiSD8G8sBuK8FKh94CeTIjWGyUD5H1WGtuiucRDKkA==
X-Received: by 2002:a05:6a20:4408:b0:17b:3822:e5ea with SMTP id ce8-20020a056a20440800b0017b3822e5eamr5203326pzb.19.1698190665897;
        Tue, 24 Oct 2023 16:37:45 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2620:10d:c090:400::4:4dbb])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902ea0600b001c0ce518e98sm7911067plg.224.2023.10.24.16.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 16:37:45 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH fstests] xfs: test refilling AGFL after lots of btree splits
Date:   Tue, 24 Oct 2023 16:37:42 -0700
Message-ID: <c7be2fe66a297316b934ddd3a1368b14f39a9f22.1698190540.git.osandov@osandov.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <013168d2de9d25c56fe45ad75e9257cf9664f2d6.1698190191.git.osandov@fb.com>
References: <013168d2de9d25c56fe45ad75e9257cf9664f2d6.1698190191.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is a regression test for patch "xfs: fix internal error from AGFL
exhaustion"), which is not yet merged. Without the fix, it will fail
with a "Structure needs cleaning" error.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
---
 tests/xfs/601     | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/601.out |  2 ++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/xfs/601
 create mode 100644 tests/xfs/601.out

diff --git a/tests/xfs/601 b/tests/xfs/601
new file mode 100755
index 00000000..bbc5b443
--- /dev/null
+++ b/tests/xfs/601
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Meta Platforms, Inc. and affiliates.
+#
+# FS QA Test 601
+#
+# Regression test for patch "xfs: fix internal error from AGFL exhaustion".
+#
+. ./common/preamble
+_begin_fstest auto prealloc punch
+
+. ./common/filter
+
+_supported_fs xfs
+_require_scratch
+_require_test_program punch-alternating
+_fixed_by_kernel_commit XXXXXXXXXXXX "xfs: fix internal error from AGFL exhaustion"
+
+_scratch_mkfs -m rmapbt=0 | _filter_mkfs > /dev/null 2> "$tmp.mkfs"
+. "$tmp.mkfs"
+_scratch_mount
+
+alloc_block_len=$((_fs_has_crcs ? 56 : 16))
+allocbt_leaf_maxrecs=$(((dbsize - alloc_block_len) / 8))
+allocbt_node_maxrecs=$(((dbsize - alloc_block_len) / 12))
+
+# Create a big file with a size such that the punches below create the exact
+# free extents we want.
+num_holes=$((allocbt_leaf_maxrecs * allocbt_node_maxrecs - 1))
+$XFS_IO_PROG -c "falloc 0 $((9 * dbsize + num_holes * dbsize * 2))" -f "$SCRATCH_MNT/big"
+
+# Fill in any small free extents in AG 0. After this, there should be only one,
+# large free extent.
+_scratch_unmount
+mapfile -t gaps < <($XFS_DB_PROG -c 'agf 0' -c 'addr cntroot' -c 'p recs' "$SCRATCH_DEV" |
+	$SED_PROG -rn 's/^[0-9]+:\[[0-9]+,([0-9]+)\].*/\1/p' |
+	tac | tail -n +2)
+_scratch_mount
+for gap_i in "${!gaps[@]}"; do
+	gap=${gaps[$gap_i]}
+	$XFS_IO_PROG -c "falloc 0 $((gap * dbsize))" -f "$SCRATCH_MNT/gap$gap_i"
+done
+
+# Create enough free space records to make the bnobt and cntbt both full,
+# 2-level trees, plus one more record to make them split all the way to the
+# root and become 3-level trees. After this, there is a 7-block free extent in
+# the rightmost leaf of the cntbt, and all of the leaves of the cntbt other
+# than the rightmost two are full. Without the fix, the free list is also
+# empty.
+$XFS_IO_PROG -c "fpunch $dbsize $((7 * dbsize))" "$SCRATCH_MNT/big"
+"$here/src/punch-alternating" -o 9 "$SCRATCH_MNT/big"
+
+# Do an arbitrary operation that refills the free list. Without the fix, this
+# will allocate 6 blocks from the 7-block free extent in the rightmost leaf of
+# the cntbt, then try to insert the remaining 1 block free extent in the
+# leftmost leaf of the cntbt. But that leaf is full, so this tries to split the
+# leaf and fails because the free list is empty.
+$XFS_IO_PROG -c "fpunch 0 $dbsize" "$SCRATCH_MNT/big"
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/xfs/601.out b/tests/xfs/601.out
new file mode 100644
index 00000000..0d70c3e5
--- /dev/null
+++ b/tests/xfs/601.out
@@ -0,0 +1,2 @@
+QA output created by 601
+Silence is golden
-- 
2.42.0

