Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22489ECAAD8
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 07:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiITHfd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiITHf3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 03:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84195D0F7
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663659324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYXjml2GNFC01UdKD665kjnxxXXtUGKgKkHiAvMFaaY=;
        b=DJWqEJKZ6Y7iQN4N1ZUment1zmQrZx0uic0dSiE6tSfq/MsvQqlgGgr9C2rPfFEtwDzqzU
        rwoNWigTdX/RB2xc/Y27ic0LkIxzH8uM+mk7d5vuWJcn0IY5iLFRmUFLCaxmarH7oXH1rW
        HSkdzKYd4IBUXVWbiydG1ZNZX49+UVg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-82-vvjsm_jZPumtP65i61_hMA-1; Tue, 20 Sep 2022 03:35:22 -0400
X-MC-Unique: vvjsm_jZPumtP65i61_hMA-1
Received: by mail-ed1-f71.google.com with SMTP id m3-20020a056402430300b004512f6268dbso1236536edc.23
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 00:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZYXjml2GNFC01UdKD665kjnxxXXtUGKgKkHiAvMFaaY=;
        b=2Z4Rxtc9cYXRpgvmwdpCEb8AsuX3pJeLlxUgb0o3qT6PqS+a75coYHXfgIvbF/Qcok
         eA6bYfFWvwjhXCb+d5eIe54Wt8CnCM2brWPh8oajzH2WiOJYsxJondBPxL3dugCUC5sK
         VPZNZtedq7AZL+hN4CJVWUB7ktJmEVKgpuz64E7NovLyphacTeXmV1mCoPOUi9kRwqrZ
         5FNuyzZBzVTgnnUsUU/QhNE3QRzlb3qagMgiwkQEgsWYk25OeGQhgFRtCTUDZUCQCxXd
         vyECELNtt8UkukHxP+qKQBBolQpk1+nHiwrCikHMlM7mT3fEpLBLLCj5RzaeNwsvFSMh
         h3bw==
X-Gm-Message-State: ACrzQf2Bce1P4WnEjzmToKWQdiunjKx5s/TkA2D0ISHA581wG+c2mFqY
        cKp6p+Yw8TC5IuDg3k69KB97JvAZW33l7ps28PwU8GA6BUAHXnDSCfyfDO+iste9WzNRHc6Ndbn
        izHw9Z1r25Wt1tHoMBJz2hzM2NxFYTfnhOzZZfIkzVSNRclG/87AQ4Xtx4U9dLyDf5xzD
X-Received: by 2002:a05:6402:44c:b0:445:f2f1:4add with SMTP id p12-20020a056402044c00b00445f2f14addmr19132417edw.257.1663659320887;
        Tue, 20 Sep 2022 00:35:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ZmS8BovMqJpLZRUZIbmLfx3ArsdCa2QKFMSm3mwcMBhf260NmDTpLYT299g54v4SBujUzZg==
X-Received: by 2002:a05:6402:44c:b0:445:f2f1:4add with SMTP id p12-20020a056402044c00b00445f2f14addmr19132396edw.257.1663659320629;
        Tue, 20 Sep 2022 00:35:20 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id y8-20020a50e608000000b0043d1eff72b3sm733479edm.74.2022.09.20.00.35.18
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 00:35:19 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3 2/2] generic: test i_blocks for truncated large files
Date:   Tue, 20 Sep 2022 09:35:14 +0200
Message-Id: <20220920073514.285136-3-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920073514.285136-1-preichl@redhat.com>
References: <20220920073514.285136-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is a regression test for an incorrect computation of i_blocks for
truncated files larger than 4 GiB. Bug was filed for exFAT.

Test is based on reproducer provied by Christophe Vu-Brugier as part
of kernel patch-fix submission.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/generic/698     | 47 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/698.out |  2 ++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/generic/698
 create mode 100644 tests/generic/698.out

diff --git a/tests/generic/698 b/tests/generic/698
new file mode 100755
index 00000000..bb21957f
--- /dev/null
+++ b/tests/generic/698
@@ -0,0 +1,47 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
+#
+# FS QA Test 698
+#
+# Verify that i_blocks for truncated files larger than 4 GiB have correct
+# values.
+#
+# This test verifies the problem fixed in kernel with commit
+# 92fba084b79e exfat: fix i_blocks for files truncated over 4 GiB
+#
+. ./common/preamble
+. ./common/filter
+
+_begin_fstest auto
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.* $junk_dir
+}
+
+_supported_fs generic
+_fixed_by_kernel_commit 92fba084b79e \
+	"exfat: fix i_blocks for files truncated over 4 GiB"
+
+_require_test
+_require_fs_space $TEST_DIR $((5 * 1024 * 1024)) #kB
+
+junk_dir=$TEST_DIR/$seq
+junk_file=$junk_dir/junk
+mkdir -p $junk_dir
+
+_create_sizedfile 5G $junk_file
+truncate -s 4G $junk_file
+
+block_size=`stat -c '%B' $junk_file`
+iblocks_after_truncate=`stat -c '%b' $junk_file`
+iblocks_expected=$((4 * 1024 * 1024 * 1024 / $block_size))
+
+_within_tolerance "Number of allocated blocks after truncate" $iblocks_after_truncate $iblocks_expected 1% -v
+
+status=0
+
+exit
diff --git a/tests/generic/698.out b/tests/generic/698.out
new file mode 100644
index 00000000..cbb02d37
--- /dev/null
+++ b/tests/generic/698.out
@@ -0,0 +1,2 @@
+QA output created by 698
+Number of allocated blocks after truncate is in range
-- 
2.37.3

