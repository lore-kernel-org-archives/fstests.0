Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DDAC433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Mar 2021 21:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B996864FC9
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Mar 2021 21:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCJVCv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:02:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231410AbhCJVCd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Mar 2021 16:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615410153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nPUAhQ0qOCm0ynT5BIFdn6KIn/x4B5mCMhl/ha9oxHs=;
        b=JFqzXwuX/Lkb2hOE8l6F6b/UGDkDPrjVgv/z+siLK9wJ0RsiKRq7OgmE/LYWNNnx1Ujydh
        H2UZb66tUgZh8gCDmVVR598dHPyqWFHdyPJAUG1MrU81GlVzp2FfD7WKifUdtBya0V2Oxp
        1FbMgBR1sBXps8d3LEEmtu3QknXtdj8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-W013F-ooO5CHl5qNDjTl4g-1; Wed, 10 Mar 2021 16:02:31 -0500
X-MC-Unique: W013F-ooO5CHl5qNDjTl4g-1
Received: by mail-wm1-f71.google.com with SMTP id v5so3133031wml.9
        for <fstests@vger.kernel.org>; Wed, 10 Mar 2021 13:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nPUAhQ0qOCm0ynT5BIFdn6KIn/x4B5mCMhl/ha9oxHs=;
        b=XioszlzFFbiSbeAfr4XwVzxOePg7Z91jNm5dsr8IAfxpjmtwSj//xM6j1uSXRh2rRd
         MJCbXG5ElyTV3nBX0y4prngCIBbvwCWRsrrTmkfNOYjTxx1CkkgWAvoWADQCG8Nf7D9x
         5z55escqDSrKtC91nAaiWNujmCMLxuQ+rpzRT7EFUnFgM/asJ/XDYMxxSpxf54XzbkAP
         7yqZI1kWBnJ2LqD9oacb7nHU8HATPs8vclinHreZ1kv8nNPCyr2Q5KItGLhdW4Ps7vGJ
         vsmls6Ngg4sW8nNDeVtDbr7u8vGZb8OlFZEqBZSe2bv5wH4wXMDgv19Hm3jkS4Q7VAca
         B02Q==
X-Gm-Message-State: AOAM532Yyh3SSVAsCEXBymIi6QL7R10d6hPx2zg6zfikt1LqR+GWj8Dz
        +c/6ob4OoyoU7/6ayIo7b9kHeXxMhFWMOIR8B7EWRJETknUuteTtPXSGk0q+Q+K8BDQUdwZHJj1
        vQAlHMJVR20b4FuPRIhQnloEFcZyIJ9dPDxxnhgTilv8ZppHi5UuponKoqtZeQ+pGvhiX
X-Received: by 2002:a05:600c:608:: with SMTP id o8mr5271073wmm.42.1615410149503;
        Wed, 10 Mar 2021 13:02:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLDJct0NmTOXIa2f5QFXvkqn8mUKeDtMiAHizX7V2LCWyoNCVR48VsqHy6iVHJpjavBSb77g==
X-Received: by 2002:a05:600c:608:: with SMTP id o8mr5271063wmm.42.1615410149291;
        Wed, 10 Mar 2021 13:02:29 -0800 (PST)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id p14sm574934wmc.30.2021.03.10.13.02.28
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:02:28 -0800 (PST)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] xfs/528: Add test for printing deprec. mount options
Date:   Wed, 10 Mar 2021 22:02:28 +0100
Message-Id: <20210310210228.58788-1-preichl@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Verify that warnings about deprecated mount options are properly
printed.

Verify that no excessive warnings are printed during remounts.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/xfs/528     | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/528.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 88 insertions(+)
 create mode 100755 tests/xfs/528
 create mode 100644 tests/xfs/528.out

diff --git a/tests/xfs/528 b/tests/xfs/528
new file mode 100755
index 00000000..148f6304
--- /dev/null
+++ b/tests/xfs/528
@@ -0,0 +1,85 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc.. All Rights Reserved.
+#
+# FS QA Test 528
+#
+# Verify that warnings about deprecated mount options are properly printed.
+#
+# Verify that no excessive warnings are printed during remounts.
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
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+_require_check_dmesg
+_supported_fs xfs
+_require_scratch
+
+log_tag()
+{
+	echo "fstests $seqnum [tag]" > /dev/kmsg
+}
+
+dmesg_since_test_tag()
+{
+	dmesg | tac | sed -ne "0,\#fstests $seqnum \[tag\]#p" | \
+		tac
+}
+
+check_dmesg_for_since_tag()
+{
+	dmesg_since_test_tag | egrep -q "$1"
+}
+
+echo "Silence is golden."
+
+
+# Skip old kernels that did not print the warning yet
+log_tag
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount -o attr2
+umount $SCRATCH_MNT
+check_dmesg_for_since_tag "XFS: attr2 mount option is deprecated" || \
+	_notrun "Deprecation warning are not printed at all."
+
+# Test mount with default options (attr2 and noikeep) and remount with
+# 2 groups of options
+# 1) the defaults (attr2, noikeep)
+# 2) non defaults (noattr2, ikeep)
+_scratch_mount
+for VAR in {attr2,noikeep}; do
+	log_tag
+	mount -o $VAR,remount $SCRATCH_MNT
+	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated." && \
+		echo "Should not be able to find deprecation warning for $VAR"
+done
+for VAR in {noattr2,ikeep}; do
+	log_tag
+	mount -o $VAR,remount $SCRATCH_MNT
+	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated" || \
+		echo "Could not find deprecation warning for $VAR"
+done
+umount $SCRATCH_MNT
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/528.out b/tests/xfs/528.out
new file mode 100644
index 00000000..762dccc0
--- /dev/null
+++ b/tests/xfs/528.out
@@ -0,0 +1,2 @@
+QA output created by 528
+Silence is golden.
diff --git a/tests/xfs/group b/tests/xfs/group
index e861cec9..ad3bd223 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -525,3 +525,4 @@
 525 auto quick mkfs
 526 auto quick mkfs
 527 auto quick quota
+528 auto quick mount
-- 
2.29.2

