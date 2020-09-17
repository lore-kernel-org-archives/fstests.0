Return-Path: <SRS0=PSS3=C2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45BBC43464
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Sep 2020 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B6620838
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Sep 2020 20:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTrZsHd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgIQUhH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Sep 2020 16:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbgIQUhG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Sep 2020 16:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600375025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bBnVH1rWNGRXJxsjn9bSR0679UcJ5h+xV8lSVgzx0TQ=;
        b=bTrZsHd0Si1FMq00cSXDrL1oL6JA34MvfSIToBuEwO6K/HEsrsEiX4x4VmIu6sUuMnuV1z
        UlF0iBzxjFo0T3AVRMI32+ghTlzxEIooNrXmlwGiJ+zTgsOWAjfYA3BEUeqB+wLLWf+MVP
        Fcrg8gT25EuaroNiCBR0UHfQYUBT0Tw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-rXVR3_MYP8OdL0Zho5K2Hw-1; Thu, 17 Sep 2020 16:36:48 -0400
X-MC-Unique: rXVR3_MYP8OdL0Zho5K2Hw-1
Received: by mail-wm1-f69.google.com with SMTP id l15so1173000wmh.9
        for <fstests@vger.kernel.org>; Thu, 17 Sep 2020 13:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bBnVH1rWNGRXJxsjn9bSR0679UcJ5h+xV8lSVgzx0TQ=;
        b=OmpmAPhVVYkv7b52OxhEd4km7lkxvDXZcez/wj+bSigFzgVeDPHl+EX0C4Yy302s8p
         Rq9GWnsHpFi6KMnegs+byeTmO29RHMmk/LK5cI2q2Y4DO/pTXLnzFWcDCvGoFTiEuszc
         DFrvkuzP30s4yg1+Rc9PysJgbd98bnv2ACX3krAGvlJ/5e8ymE59zTfFs7efex/eaFlm
         f9M1z/8hjnw6K7qwKSn/k5OqS3SIHSywfWC4hjq9qO5dHhihqwS1z5ZP+XMbyphn+Mvk
         XAMs+iKAOdUJLC8BFs3W25BrJ2w5wDg7MMnpxDnc4L1VgkC/LCNUYr57/W8E34APgXRa
         yJxA==
X-Gm-Message-State: AOAM532cB86Gs/YMjbSpuCZf/MZGANY2Kqs0D8sJ3cu73Irg/JuMKm07
        TAOsV5LyPZNYGEfFJcQ0aFpa6VRpLULVVUk6ZUJXvhZx8v5vWu22Q1+gyzXGvdTHzv5ppvjYsiD
        LdlWF0OXXnJzlq+bmzA==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr12038067wml.42.1600375001200;
        Thu, 17 Sep 2020 13:36:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdxwk4OFrcqPi6PH0u7rdHSgSo/2K3uZDFJMP+a59fMihGZD+Xv38v2PNX8J4peZwSFGBIww==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr12038056wml.42.1600375001017;
        Thu, 17 Sep 2020 13:36:41 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id u13sm977171wrm.77.2020.09.17.13.36.40
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 13:36:40 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] xfs: Add test for too-small device with stripe geometry
Date:   Thu, 17 Sep 2020 22:36:39 +0200
Message-Id: <20200917203639.104000-1-preichl@redhat.com>
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
 tests/xfs/260     | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/260.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 57 insertions(+)
 create mode 100755 tests/xfs/260
 create mode 100644 tests/xfs/260.out

diff --git a/tests/xfs/260 b/tests/xfs/260
new file mode 100755
index 00000000..11c9dc1e
--- /dev/null
+++ b/tests/xfs/260
@@ -0,0 +1,54 @@
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
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+#. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+echo 'Silence is golden'
+
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount
+
+localfile="${SCRATCH_MNT}/testfile"
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

