Return-Path: <SRS0=J6Lv=C3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE97C43464
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Sep 2020 06:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF0420866
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Sep 2020 06:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9SIOS9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIRGPW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Sep 2020 02:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbgIRGPV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Sep 2020 02:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600409720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9LKeD2Yay2NrY6FC2S/wTAvALL8z8D2UqGMG6lanB+U=;
        b=E9SIOS9JZrBNiD0FsJT1AL0swJE9Hth6VPntHt8fkPuLsmw7Qr18GVx+x+eZ8VtAieFOlI
        1/Gxdl0hjk5EbKaTokC3nKkRLbYR4TaU1vUwh0AFrkFWGMJ67nyduJLc9NFK3i89OMU8gn
        BR3SLlsBAwNiNgFTIoIu++gzHltX4no=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-AhLdiarvMlSx2pgCuFLmjg-1; Fri, 18 Sep 2020 02:15:17 -0400
X-MC-Unique: AhLdiarvMlSx2pgCuFLmjg-1
Received: by mail-wm1-f69.google.com with SMTP id r10so1502575wmh.0
        for <fstests@vger.kernel.org>; Thu, 17 Sep 2020 23:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9LKeD2Yay2NrY6FC2S/wTAvALL8z8D2UqGMG6lanB+U=;
        b=QqMooVqtd7pKSpW2vApbDRwaWmrsjpjJGKkT5A760ESMO5pxSaTMPIK/JbLKR/SFkN
         nRBPWFXKhUjhLYQg/IKSEmXTUJakiCpmgT3IcIl9yASxKRr8H2Ebbgut9ksmQlVYslfu
         S/hbmrJgNpSRwm1Wx2/poCeviL4L0yG+sol2YqsqCPGJXtyIiB09jy6lxjyv/m6OpNBT
         8lKkVI16NVGOzvRbZze/+vCeIl+AVV1gYSe0NurJ+PGVUl2ZApX3ETGxRD+5wICy6hRT
         FnM8jxlWe6YCKnXW8yAJwywmqlQef7v3zip+16SEfdSB9I8Rs9nirkV118rrpTPSwBQX
         st5A==
X-Gm-Message-State: AOAM530QyrIK1mnaPurQC02ZMH0DkvDD9rPO/KxhNaDBV6oVgbLBLFCD
        k4MWZIBbCExgeafZrapFO1CENUkMNDKGWvPjvPb1uxNIxGc1FNEqsxiYk9fo1vpbxFCfO/D1ry2
        nD73L8Kvm446P2R2dKQ==
X-Received: by 2002:adf:f504:: with SMTP id q4mr35569940wro.353.1600409716112;
        Thu, 17 Sep 2020 23:15:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB62YcZToEyEoda81PByyC0Xje0rYOiSvsYyyJPdENeHeqEL6vxFewa0nkFvYnpAur6HQJfg==
X-Received: by 2002:adf:f504:: with SMTP id q4mr35569919wro.353.1600409715845;
        Thu, 17 Sep 2020 23:15:15 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id s2sm3582871wrw.96.2020.09.17.23.15.15
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 23:15:15 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2] xfs: Add test for too-small device with stripe geometry
Date:   Fri, 18 Sep 2020 08:15:14 +0200
Message-Id: <20200918061514.115764-1-preichl@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Verify hat an attempt to create a too-small device with stripe geometry,
is handled gracefully instead of hitting an assert in align_ag_geometry()

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/xfs/260     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/260.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 55 insertions(+)
 create mode 100755 tests/xfs/260
 create mode 100644 tests/xfs/260.out

diff --git a/tests/xfs/260 b/tests/xfs/260
new file mode 100755
index 00000000..4e81d634
--- /dev/null
+++ b/tests/xfs/260
@@ -0,0 +1,52 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.
+#
+# FS QA Test 260
+#
+# Verify that an attempt to create a too-small device with stripe geometry,
+# is handled gracefully instead of hitting an assert in align_ag_geometry()
+#
+# This test verifies the problem fixed in kernel with commit
+# (mkfs.xfs: fix ASSERT on too-small device with stripe geometry)
+#
+
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
+	rm -f $localfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+echo 'Silence is golden'
+
+_supported_fs xfs
+_supported_os Linux
+_require_test
+
+localfile=$TEST_DIR/260.$$
+
+truncate --size=10444800 $localfile
+
+$MKFS_XFS_PROG -dsu=65536,sw=1 $localfile >> $seqres.full 2>&1
+
+[ $? -ne 1 ] && echo "${MKFS_XFS_PROG} should fail gracefully"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/260.out b/tests/xfs/260.out
new file mode 100644
index 00000000..18ca517c
--- /dev/null
+++ b/tests/xfs/260.out
@@ -0,0 +1,2 @@
+QA output created by 260
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index ed0d389e..7a6dfed7 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -257,6 +257,7 @@
 257 auto quick clone
 258 auto quick clone
 259 auto quick
+260 auto quick mkfs
 261 auto quick quota
 262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 263 auto quick quota
-- 
2.26.2

