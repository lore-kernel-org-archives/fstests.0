Return-Path: <SRS0=dxnf=2L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B89FC2D0C3
	for <linux-fstests@archiver.kernel.org>; Sat, 21 Dec 2019 17:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4522206EF
	for <linux-fstests@archiver.kernel.org>; Sat, 21 Dec 2019 17:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGhFAqqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfLURE4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 21 Dec 2019 12:04:56 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51647 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfLURE4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 Dec 2019 12:04:56 -0500
Received: by mail-wm1-f42.google.com with SMTP id d73so11928689wmd.1;
        Sat, 21 Dec 2019 09:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XYYsNOwA4P2JUXVBuryUxvONRaOD/VDfSk7veS8CbIM=;
        b=dGhFAqqPwTBxAMWD/HugWz7FObPdySk16bUJuH4QsQnpZ/xCHowx7MKUCcfijRC7AR
         gBxvcw7shrr1VV9gwP466WzzM4+FNEElXiGAdMkmyqeltpmZIrpMgJLTm/McWECBIBsw
         QAzNKa+jVoqatuR+2lvBLYs5qE5MmnXVOaNrx8o+b6dAedZshID8YHPzgkSHjY5wNd24
         lDviz97wVaoqVjotxSqRu5PRPqLAg8R6iWx+V1Iv+HwtLZewji9qIZidX5y95WRKx+vu
         /M06wAO2AG2gXW0u/rZ9Dz47RFrxs8hEH3pvm+i5pE4wthsndljvp9dA20Hd8z1oAP40
         vzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XYYsNOwA4P2JUXVBuryUxvONRaOD/VDfSk7veS8CbIM=;
        b=TczjM1DgfSFaeDfVFI+aYo47bxhaVDDpCC9atBLLdwt8sHiV5ake7oMjO98Jg03z2D
         VmeurlJrYt9Zcw8jw5NPASeWR+4qBEut0O8ZFXSw4dE56QfT4beyRqWfEL85wUJUNTu/
         WTza3dh/rlCVNZTk2RUF6mzQmGLO9v4G3pEKFO9luFjFUJnKaLGBsKCv3UwhD8rqQdj8
         SWZazY+xz53Okgeh5owE2lutnU/GYCbPrVFseBjCVjqVIBhcWZMemYTTqr76obZr3nGy
         zYhdPCx35cJ1inVILRJw5ojZLpqaJH/9yGMcJXvhYaS5g2KwMlRy8OFCkyhsOjqc7nZI
         9x8Q==
X-Gm-Message-State: APjAAAXYgzSosxi2Qzjw2BrR3p5uVZcUKRe+T2Y29nPPIzR56gqNWSTB
        y7reJUGY+6uVbfNfUxqnt2U=
X-Google-Smtp-Source: APXvYqw7nwfXBg96IY5BgyoKJmEnSTKPtBCdwt7CaejicuFPN8RtRE0M8bmZ4Nb2R2bTDv2m7/MYng==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr21751351wmf.60.1576947894498;
        Sat, 21 Dec 2019 09:04:54 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.223])
        by smtp.gmail.com with ESMTPSA id q68sm16193448wme.14.2019.12.21.09.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 09:04:53 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH v2] overlay: Test unique st_dev;st_ino on non-samefs setup
Date:   Sat, 21 Dec 2019 19:04:47 +0200
Message-Id: <20191221170447.13586-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Check that files from middle layer on same fs as upper layer
are not allowed to export the real inode st_dev;st_ino.

This is a regression test for kernel commit:
  9c6d8f13e9da ("ovl: fix corner case of non-unique st_dev;st_ino")

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Eryu,

The kernel fix commit is now upstream.

Thanks,
Amir.

Changes since v1:
- Document upstream commit id

 tests/overlay/067     | 94 +++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/067.out |  2 +
 tests/overlay/group   |  1 +
 3 files changed, 97 insertions(+)
 create mode 100755 tests/overlay/067
 create mode 100644 tests/overlay/067.out

diff --git a/tests/overlay/067 b/tests/overlay/067
new file mode 100755
index 00000000..d0a59a0b
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
+#   9c6d8f13e9da ovl: fix corner case of non-unique st_dev;st_ino
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

