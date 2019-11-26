Return-Path: <SRS0=JLeR=ZS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7D5C43215
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Nov 2019 20:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0033320727
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Nov 2019 20:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="u7qpL5xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKZUOC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:14:02 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:45595 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKZUOC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Nov 2019 15:14:02 -0500
Received: by mail-pf1-f170.google.com with SMTP id z4so9707256pfn.12
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2019 12:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdIfv/gG/cyTm1vwo5Jnsq53fCU8S/nWSYqzaryjPWE=;
        b=u7qpL5xmLaIISn5dDiDPG4EL49Db0mwOmDThauBpmoj6n9bojhEk+iO0QDnKuGH4Q2
         LlrUfzUsySO4c2BL4KBr3JmiIRw5vCiqG0AkdDEbAgITv6+/LoDWApIQGXrG6yb0phzB
         yUMZbyvQ2TUQUaublA5I3fi8wG9IgY8YE7GutLqv/riW0WRR5xQ9i+lXn/aMPN7EMuMr
         9DvhFPlDExeg2jVJ0Zm7rHKYXRP5kWLoLKRnOGvELPrgD1BgKlQkHLabT97w+VtH4vfB
         Ge0+gzCX9r9LlRqCJ9AFwRlwDn7JfKvSxN4BxRxhoQuLP6TadlNuKjvFQrZZb4ffyAf7
         140A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdIfv/gG/cyTm1vwo5Jnsq53fCU8S/nWSYqzaryjPWE=;
        b=b6YEty9Wfgr4vFMM+PHTiPuUL+d4yLqIwrRXKgf0bddYBC5lHJMPbJrNiGiFB9PT5a
         EMYh7vt4fHyADWscT1ylLs/fpYALjWExXHnKcYBvz38XouYPaghCY/XhZrOM03VR2Xxu
         c+2faI5AbrnuVX1GVGmbvn0rrUncbqf5DwfNhTSi8sXKLANVAKNh8Yhcse/4GJtvrJHP
         HiddplP4Ofvc918f/qp96MiWGKzSU0yurQLHOWrAjYbUULts47Qq8uG8b6yVsmTfWJ8g
         YI2eZ1yoZ1+oeczlfTbm4EnvgQQXbmojm18SY9WLE2SalRXBeqkU98cvSraSYFIVeilr
         97+w==
X-Gm-Message-State: APjAAAUX4VyXur55pk7tElD+rvdzZFv9fAPLDZ3udTKArGuIbh5/BzWs
        suaaqbwZGcCSYhZ+7TUVLalHCOU9SvQs0A==
X-Google-Smtp-Source: APXvYqwmRz0jMTyCJguOvW0w8ZdHdr98caBMX8R9UWkDjTJVlvLYC92VvtLf6onGk+FKTDoqoKm5pg==
X-Received: by 2002:a63:6742:: with SMTP id b63mr397721pgc.24.1574799241221;
        Tue, 26 Nov 2019 12:14:01 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::30de])
        by smtp.gmail.com with ESMTPSA id a6sm4507013pja.30.2019.11.26.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 12:14:00 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     fstests@vger.kernel.org
Cc:     kernel-team@fb.com, linux-xfs@vger.kernel.org
Subject: [PATCH] generic: test truncating mixed written/unwritten XFS realtime extent
Date:   Tue, 26 Nov 2019 12:13:56 -0800
Message-Id: <2512a38027e5286eae01d4aa36726f49a94e523d.1574799173.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The only XFS-specific part of this test is the setup, so we can make the
rest a generic test. It's slow, though, as it needs to write 8GB to
convert a big unwritten extent to written.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/generic/586     | 59 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/586.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 62 insertions(+)
 create mode 100755 tests/generic/586
 create mode 100644 tests/generic/586.out

diff --git a/tests/generic/586 b/tests/generic/586
new file mode 100755
index 00000000..5bcad68b
--- /dev/null
+++ b/tests/generic/586
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Facebook.  All Rights Reserved.
+#
+# FS QA Test 586
+#
+# Test "xfs: fix realtime file data space leak" and "xfs: don't check for AG
+# deadlock for realtime files in bunmapi". On XFS without the fix, rm will hang
+# forever. On other filesystems, this just tests writing into big fallocates.
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
+. ./common/rc
+. ./common/filter
+
+rm -f $seqres.full
+
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+maxextlen=$((0x1fffff))
+bs=4096
+rextsize=4
+
+extra_options=""
+if [[ $FSTYP = xfs && $USE_EXTERNAL = yes && -n $SCRATCH_RTDEV ]]; then
+	extra_options="$extra_options -bsize=$bs"
+	extra_options="$extra_options -r extsize=$((bs * rextsize))"
+	extra_options="$extra_options -d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1"
+fi
+_scratch_mkfs $extra_options >>$seqres.full 2>&1
+_scratch_mount
+_require_fs_space "$SCRATCH_MNT" "$(((maxextlen + 1) * bs / 1024))"
+
+fallocate -l $(((maxextlen + 1 - rextsize) * bs)) "$SCRATCH_MNT/file"
+sync
+fallocate -o $(((maxextlen + 1 - rextsize) * bs)) -l $((rextsize * bs)) "$SCRATCH_MNT/file"
+sync
+dd if=/dev/zero of="$SCRATCH_MNT/file" bs=$bs count=$((maxextlen + 2 - rextsize)) conv=notrunc status=none
+sync
+rm "$SCRATCH_MNT/file"
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/586.out b/tests/generic/586.out
new file mode 100644
index 00000000..3d36442d
--- /dev/null
+++ b/tests/generic/586.out
@@ -0,0 +1,2 @@
+QA output created by 586
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index e5d0c1da..6ddaf640 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -588,3 +588,4 @@
 583 auto quick encrypt
 584 auto quick encrypt
 585 auto rename
+586 auto prealloc preallocrw dangerous
-- 
2.24.0

