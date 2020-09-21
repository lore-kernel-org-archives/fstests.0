Return-Path: <SRS0=Zf7U=C6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAF7C43464
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 08:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E112158C
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 08:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBlZNq8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgIUIzT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726324AbgIUIzT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Sep 2020 04:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600678517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7G/nD0Vz7JMNP0wUXhHob4xMD5hpDM0u/pimdtqKcQ0=;
        b=YBlZNq8byn2Gzp5ufXZmLB3Zbx5bp/SwSQ9//QD36aQSYa72PHXIPbBlc2j4jbfNZJ2O1k
        q7nxpJKJjULr7A4FmEBifdp2G0wBV59vT78j3Bn1t2DaM+7iBwGIf6gh6aX5Yk4kuvgYvJ
        aY5mishZKdzqHu7fMotzkS6cumjdhko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-CC4cPMKPP6G5n8TAIUWPLw-1; Mon, 21 Sep 2020 04:55:15 -0400
X-MC-Unique: CC4cPMKPP6G5n8TAIUWPLw-1
Received: by mail-wm1-f71.google.com with SMTP id 23so2261341wmk.8
        for <fstests@vger.kernel.org>; Mon, 21 Sep 2020 01:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7G/nD0Vz7JMNP0wUXhHob4xMD5hpDM0u/pimdtqKcQ0=;
        b=HEBt5yqb5jexHZmJlsRUHbT09EWQiIIo3AWNau8Rsit/lUG/PwjbRQ8XJWcRKFVDuM
         YUyWwWnEHnfcjcwyqCtRrCOY+xZacHblnRsnrYQXieoo4jbINgQNaduEVijhwXWl3Ewv
         RzAySH8etQFv3t5YjUvlppWVW8WhF6dAzP/Xe41P5z6Nkg+h8XUWb8vuZKzDmgy+UAlv
         AzsFfsIlJaA5r1MRwtsH/YFUbBoD3pQxwwO5ZlGOwuLqEzAfybadrysj7lx2MAwE9bZ/
         +US+as1aLqYU/aHuXBsc/e8CyUnbwZbhtkIWjkJJL63gkmonr5tIySjtBM8U9EZ+wx/p
         cMsg==
X-Gm-Message-State: AOAM532PRqz8J5mpyLmOPsTwSpZFbCPl72ykH3ZVupPv8gU2btauIoYI
        QPmxCjKIz21V2KA2BxOV2NGiBtgKHzkf94+rRqOfoljtVMoEOIatGzKPViBn3rzlTHZpeOvWFEi
        VoyZBkcL4ie+rSgovqQ==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr28366862wml.159.1600678513931;
        Mon, 21 Sep 2020 01:55:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBDdSNfOHlE1JqAzBCVkW6tVQNKWqGcF+c8zV+J5A7fRq7nCKD+mghMXD2NE9YIB9Ayq8J5Q==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr28366848wml.159.1600678513755;
        Mon, 21 Sep 2020 01:55:13 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id f14sm19569051wrv.72.2020.09.21.01.55.12
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 01:55:13 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3] xfs: Add test for too-small device with stripe geometry
Date:   Mon, 21 Sep 2020 10:55:11 +0200
Message-Id: <20200921085511.98739-1-preichl@redhat.com>
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
 tests/xfs/260     | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/260.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 54 insertions(+)
 create mode 100755 tests/xfs/260
 create mode 100644 tests/xfs/260.out

diff --git a/tests/xfs/260 b/tests/xfs/260
new file mode 100755
index 00000000..f4da0302
--- /dev/null
+++ b/tests/xfs/260
@@ -0,0 +1,51 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc.. All Rights Reserved.
+#
+# FS QA Test 260
+#
+# Verify that an attempt to create a too-small device with stripe geometry,
+# is handled gracefully instead of hitting an assert in align_ag_geometry()
+#
+# This test verifies the problem fixed in xfsprogs with commit
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
+_require_test
+
+localfile=$TEST_DIR/$seq.$$
+
+$XFS_IO_PROG -f -c "truncate 10444800" $localfile
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
index b8374359..c8713ca5 100644
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

