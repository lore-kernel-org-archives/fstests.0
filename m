Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334BCC433E1
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Mar 2021 22:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1376561981
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Mar 2021 22:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhCSWUv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230411AbhCSWUY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Mar 2021 18:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616192423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IIZLA0MswVooLcDVZjaYIlsVidwdJzOMDE5CrAsqafg=;
        b=f761+OYzwj1llC7xo7yKNzlYY5/LT04iivu6oYm7ie3xVWg+yHuVP/dI5BSrp6ZnrSZaRo
        oYwEqZgzwme+xKEVXlhyAzeJrnyPi61cdT0rmnpJTTbYAn+m/w00UXOJK56TfZID0JaAD0
        Woko/twmaEpkHeQm2JFLa0Z9wKVXlvE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-HR52Nd0eOLGAoSnly55VXA-1; Fri, 19 Mar 2021 18:20:22 -0400
X-MC-Unique: HR52Nd0eOLGAoSnly55VXA-1
Received: by mail-wr1-f69.google.com with SMTP id v13so22520707wrs.21
        for <fstests@vger.kernel.org>; Fri, 19 Mar 2021 15:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IIZLA0MswVooLcDVZjaYIlsVidwdJzOMDE5CrAsqafg=;
        b=eOYQ0r3mitWa8UPzml4FispK7ovJ+70mjhLjrL43tZeaW6NKfiJSsu+o5Gpq5d7qBr
         0tBlyQfZcoW0MCRFoRJYT9S4bFF0Odke5i2GER0/vt8YaPP0FCmi998DEdmxDhWPzy0z
         iCUpxN933xA977tpZBw1wd2mohHuFdv/Xl6iQl0YPEpySB0MitdyoLM1KhtdCSBqoFM6
         +C+143D7eB+VQ5Inhm+1VkcIpkJeA821WWL5auCSi4EAbU3RbT8rLeld5X8CSiCdcITL
         BuFcmOj55vZZmLCBnX6hl1DtRQ0exr/K5pB+Fd4G9ZpHBd9nc+7TmBMA9Ub7ofsfo622
         QpUw==
X-Gm-Message-State: AOAM531VXgdhJWJef105v5wWDdDK3nSAmHRsomH615g08BK4WF5Hg2E+
        vaT5eFrFbTxIlG2muEP8HlaIlicGV9bkp0qocEIFfLoUdSMjkUEL3IxHqVcFs7X3WQmIoh7S6YQ
        J9GZ6VkEIFJ0bZFrvsRwYOAhujeaaVhubr+gUlnynPbVG8RQPZxCztp46Fsq7QFmgi0ko
X-Received: by 2002:a5d:4904:: with SMTP id x4mr6571329wrq.69.1616192420774;
        Fri, 19 Mar 2021 15:20:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTiIJuxaXeqQjrPoaKDEk9We2c1TSoLQ5Uz3eUTgIGnnedJT3D22y0fE5kMC0M8my6jB/Kdg==
X-Received: by 2002:a5d:4904:: with SMTP id x4mr6571314wrq.69.1616192420502;
        Fri, 19 Mar 2021 15:20:20 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id u3sm9774683wrt.82.2021.03.19.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 15:20:20 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com
Subject: [PATCH v2] xfs/529: Add test for printing deprec. mount options
Date:   Fri, 19 Mar 2021 23:20:19 +0100
Message-Id: <20210319222019.576377-1-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
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
 tests/xfs/529     | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/529.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 90 insertions(+)
 create mode 100755 tests/xfs/529
 create mode 100644 tests/xfs/529.out

diff --git a/tests/xfs/529 b/tests/xfs/529
new file mode 100755
index 00000000..f90462c3
--- /dev/null
+++ b/tests/xfs/529
@@ -0,0 +1,87 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc.. All Rights Reserved.
+#
+# FS QA Test 529
+#
+# https://bugzilla.kernel.org/show_bug.cgi?id=211605
+# Verify that the warnings are not printed on remount if the mount option has
+# the same value as during the mount
+#
+# Regression test for commit:
+# xfs: Skip repetitive warnings about mount options
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
+_scratch_unmount
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
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/529.out b/tests/xfs/529.out
new file mode 100644
index 00000000..1b252fee
--- /dev/null
+++ b/tests/xfs/529.out
@@ -0,0 +1,2 @@
+QA output created by 529
+Silence is golden.
diff --git a/tests/xfs/group b/tests/xfs/group
index 288b916d..3e6cc415 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -505,3 +505,4 @@
 526 auto quick mkfs
 527 auto quick quota
 528 auto quick rw realtime
+529 auto quick mount
-- 
2.30.2

