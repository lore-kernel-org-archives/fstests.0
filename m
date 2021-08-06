Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07B1C4338F
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Aug 2021 05:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E739611BF
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Aug 2021 05:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhHFFKe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 Aug 2021 01:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhHFFKe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Aug 2021 01:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628226619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JyLEvOZVu3oAZntqUkqTA/x0D0ATgVxWvT+dw1d0kRs=;
        b=VyQYiPuTR4v7PBodY21jhNpvild0QowRbfeNqWPp8DMoBAemHXgkjb4huMgccq8HiKm8e4
        y9T+QEPwX5a5NW3djFyMCUpx9jdg32YVgKN2YaTg8vSWXCNVNukPfF1KcD+t38Rb6myc+c
        BKRSzOLK/UmfHQE7G7qZO6ZAwzv+WKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-ug8DhQNxOU-RPUrO2jtHpQ-1; Fri, 06 Aug 2021 01:10:17 -0400
X-MC-Unique: ug8DhQNxOU-RPUrO2jtHpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F67A1084F5E
        for <fstests@vger.kernel.org>; Fri,  6 Aug 2021 05:10:16 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-121.pek2.redhat.com [10.72.12.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CE5C1ABD8
        for <fstests@vger.kernel.org>; Fri,  6 Aug 2021 05:10:14 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] xfs: quota state command should report upg grace times separately
Date:   Fri,  6 Aug 2021 13:10:12 +0800
Message-Id: <20210806051012.1640342-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Regression test for d8a94546 ("xfs_quota: state command should report
ugp grace times"). When give "-ugp" or "-a" options to xfs_quota
state command, it should report grace times for all three types
separately.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/175     | 33 +++++++++++++++++++++++++++++++++
 tests/xfs/175.out | 21 +++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100755 tests/xfs/175
 create mode 100644 tests/xfs/175.out

diff --git a/tests/xfs/175 b/tests/xfs/175
new file mode 100755
index 00000000..0b7d81ec
--- /dev/null
+++ b/tests/xfs/175
@@ -0,0 +1,33 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 175
+#
+# Regression test for d8a94546 ("xfs_quota: state command should report
+# ugp grace times"). When give "-ugp" or "-a" options to xfs_quota state
+# command, it should report grace times for all three types separately.
+#
+. ./common/preamble
+_begin_fstest auto quick quota
+
+# real QA test starts here
+_supported_fs xfs
+_require_scratch
+_require_quota
+
+# Format filesystem and set up quota limits
+_scratch_mkfs > $seqres.full
+_qmount_option "grpquota"
+_scratch_mount >> $seqres.full
+
+$XFS_QUOTA_PROG -x -c 'timer -u 5d' $SCRATCH_MNT
+# xfs_quota state -ugp or -a should report times for all three types separately.
+echo "* state -ugp:"
+$XFS_QUOTA_PROG -x -c 'state -ugp' $SCRATCH_MNT | grep 'grace time'
+echo "* state -a:"
+$XFS_QUOTA_PROG -x -c 'state -a' $SCRATCH_MNT | grep 'grace time'
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/175.out b/tests/xfs/175.out
new file mode 100644
index 00000000..83247e21
--- /dev/null
+++ b/tests/xfs/175.out
@@ -0,0 +1,21 @@
+QA output created by 175
+* state -ugp:
+Blocks grace time: [--------]
+Inodes grace time: [--------]
+Realtime Blocks grace time: [--------]
+Blocks grace time: [5 days]
+Inodes grace time: [5 days]
+Realtime Blocks grace time: [5 days]
+Blocks grace time: [--------]
+Inodes grace time: [--------]
+Realtime Blocks grace time: [--------]
+* state -a:
+Blocks grace time: [--------]
+Inodes grace time: [--------]
+Realtime Blocks grace time: [--------]
+Blocks grace time: [5 days]
+Inodes grace time: [5 days]
+Realtime Blocks grace time: [5 days]
+Blocks grace time: [--------]
+Inodes grace time: [--------]
+Realtime Blocks grace time: [--------]
-- 
2.31.1

