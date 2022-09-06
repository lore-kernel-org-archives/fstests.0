Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A681ECAAD5
	for <linux-fstests@archiver.kernel.org>; Tue,  6 Sep 2022 16:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiIFQYU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 6 Sep 2022 12:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbiIFQXu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Sep 2022 12:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7B8F26
        for <fstests@vger.kernel.org>; Tue,  6 Sep 2022 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662479604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+kM22IbcjGRsK2VAkSFl/+sTi1aaxrAHjSGzduZibAw=;
        b=d04LQjhKxKr2akkomvZF9gJ0AGKoY8hpWyHXlYeevWwFwTCSXZN41HEq0SWGt7tXdx2gki
        yfftjdoV3M07HdTp97/YBh/q0T9jhYCt8tM/rVOB1ucMhD6mKibiEjqTU5pPat8m6Qazc1
        OHzBuW+iAat8UX+KlK0oKowx/6Y6644=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-308-k6CDT7ZOOBaJcZlD7FrUTA-1; Tue, 06 Sep 2022 11:53:23 -0400
X-MC-Unique: k6CDT7ZOOBaJcZlD7FrUTA-1
Received: by mail-ej1-f71.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso3841364ejb.14
        for <fstests@vger.kernel.org>; Tue, 06 Sep 2022 08:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=+kM22IbcjGRsK2VAkSFl/+sTi1aaxrAHjSGzduZibAw=;
        b=Ba8n7S6hguuA2J6YH5U8oyD6xTnTyXZDDalkgPlQ9SdF7c5u13C/btotYcXOs6ZVxb
         wfXCRQV1DHFSsryEaMm0g4Avo2eZOJkkt065W/tyy9JnYDZizHbhoShrpSs4SJAZzn9z
         y/iSAus8K/5iJnmSSs89DF96EWPwW5Yw7qhzbyFHhJWui3VFQNpwm4sj2QIFNzrRpvNc
         Z6Fseqqv9P8ddy/gHMhOn9kRXhxZTZHLi0Bu6LmP4CKtSOzenaWJQtufg0f4ZPLUiwst
         lC5y/0Pkqw7aQwWv2B6wKIuRpE6Fv2tBk8methtegny/+XdKAB61HjBjwWOS20pxBt75
         DTDg==
X-Gm-Message-State: ACgBeo2srroXbZlP7HsbW2WF0XC09r5CCY7hugcE1luriUsDsBYGbpJd
        tTfck9UarDPAQuEkcsL3lRpN3Fx6Rbp5rKIRxNLW43b1/AcD+p9Pepjyq/iKVBWRYvMZVvFbae1
        djwoWX+HRKjQwjFc2Ky9PUM593y+O6AJYEabr7kbkX4ED8J1g9dHHFSLYpAf5xwjkP4gn
X-Received: by 2002:a17:907:d8d:b0:741:4d1a:5954 with SMTP id go13-20020a1709070d8d00b007414d1a5954mr33308848ejc.307.1662479602358;
        Tue, 06 Sep 2022 08:53:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR61UCUDACjnfT1B3ymk5XfpWLOjPQUNMRBK3Y0Wkm5HR9GRYH4XSvD//1uFnYoNEyQoC4RUtw==
X-Received: by 2002:a17:907:d8d:b0:741:4d1a:5954 with SMTP id go13-20020a1709070d8d00b007414d1a5954mr33308826ejc.307.1662479602067;
        Tue, 06 Sep 2022 08:53:22 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id gj10-20020a170907740a00b007304bdf18cfsm6702660ejc.136.2022.09.06.08.53.21
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 08:53:21 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic: test i_blocks for truncated large files
Date:   Tue,  6 Sep 2022 17:53:20 +0200
Message-Id: <20220906155320.952636-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
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
index 00000000..217641e6
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
+_require_test
+_require_fs_space $TEST_DIR $((5 * 1024 * 1024)) #kB
+
+echo "Silence is golden"
+
+junk_dir=$TEST_DIR/$seq
+junk_file=$junk_dir/junk
+mkdir -p $junk_dir
+
+$XFS_IO_PROG -f -c "pwrite -W 0 5G" $junk_file > /dev/null
+
+
+truncate -s $((4 * 1024 * 1024 * 1024)) $junk_file
+
+iblocks_after_truncate=`stat -c '%b' $junk_file`
+iblocks_expected=$((4 * 1024 * 1024 * 2))
+
+if [ "$iblocks_expected" != "$iblocks_after_truncate" ]; then
+	echo "Number of blocks needs to be same: $iblocks_expected, $iblocks_after_truncate"
+fi
+
+status=0
+
+exit
diff --git a/tests/generic/698.out b/tests/generic/698.out
new file mode 100644
index 00000000..222db0de
--- /dev/null
+++ b/tests/generic/698.out
@@ -0,0 +1,2 @@
+QA output created by 698
+Silence is golden
-- 
2.37.3

