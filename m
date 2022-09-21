Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB15CC32771
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Sep 2022 14:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiIUOKv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Sep 2022 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiIUOKp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Sep 2022 10:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34B896754
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 07:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663769435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=862Lr0kj4nU3NBjdKO1RALAPL1D0r8ilg4zI1v9bZwE=;
        b=H9xR9o+sDJgzPYwOaVOFjs6ml75CCaQe7FOShebLRwQNBLJ0O6wIsI0Fk7ahxdqxsIMLF7
        nOoq2FC+8r03MD3ivSqvpjYEqXDB2VA1zCKbouhxbovhwPlH/0NU0pEtVJhUiFjNq+zXqS
        7f7BgRE5ZSo9QnleHITK0DNKEN90ZZI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-158-ekS9eFtYNHqdBaN3pmXXmQ-1; Wed, 21 Sep 2022 10:10:33 -0400
X-MC-Unique: ekS9eFtYNHqdBaN3pmXXmQ-1
Received: by mail-ed1-f72.google.com with SMTP id y1-20020a056402358100b00451b144e23eso4485293edc.18
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 07:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=862Lr0kj4nU3NBjdKO1RALAPL1D0r8ilg4zI1v9bZwE=;
        b=xUg9Dl735GGXTvXD787vj3e8/TtU7btFaDsJNMkI3EnxT+Kh/JIW9wmq91EPd12GDG
         n46yhaYv+1QxiqU/sg+EkXsAYdHmJXYcH0VELkkB719a9SAY01e2LEolt4vN2pcyJYh5
         nK+LrTGQpnCT0WUOaUNjJ+N8Xspg285XsBWrvaBEyCjhOaljF53/fuhAkTQRN1RG+wYc
         p318q338MzR+YtYjfDsRGSXTg1P60Fbza2p8U5wrhRuSeeq6UVVDVgD6MGoQE0tKXk5R
         tDIOxGjXdcYnQjb+PVxu4hPhKcYqsLqU4pvYw6hisWVB1XfwNbDnOqOu5uGcRyqKbsDq
         eXrg==
X-Gm-Message-State: ACrzQf23Srt7aW0tTcRduKLqQRcHon4BFY7VBDsTG9sBZOGlmgVeaD4x
        Hrtoma8VwgacbwBrTfRo0hULNLkD6c2I24SWZL64VXOSqhZeKfmpyNf6nzBNXBwepCAojik1jzc
        0vm32HDb8Q4aKO4HX0eN8I5wPWg86vfNfvbTcB1Y2cTXJCWXSJE2RCHo+MA+ttkHMKKlT
X-Received: by 2002:a17:907:3f0f:b0:782:395f:cd69 with SMTP id hq15-20020a1709073f0f00b00782395fcd69mr38490ejc.406.1663769431786;
        Wed, 21 Sep 2022 07:10:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4JIHc/FtkpRrlgvbtJPPe6mKRNbyl3bJbbmGkTJ/EqK5KUWmglgakj4zqrdD7soPcDVK4xQg==
X-Received: by 2002:a17:907:3f0f:b0:782:395f:cd69 with SMTP id hq15-20020a1709073f0f00b00782395fcd69mr38474ejc.406.1663769431524;
        Wed, 21 Sep 2022 07:10:31 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id mf24-20020a170906cb9800b0077fc446aaf6sm1273400ejb.202.2022.09.21.07.10.29
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 07:10:30 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v4 2/2] generic: test i_blocks for truncated large files
Date:   Wed, 21 Sep 2022 16:10:25 +0200
Message-Id: <20220921141025.920599-3-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921141025.920599-1-preichl@redhat.com>
References: <20220921141025.920599-1-preichl@redhat.com>
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
 tests/generic/698     | 51 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/698.out |  2 ++
 2 files changed, 53 insertions(+)
 create mode 100755 tests/generic/698
 create mode 100644 tests/generic/698.out

diff --git a/tests/generic/698 b/tests/generic/698
new file mode 100755
index 00000000..97ac1474
--- /dev/null
+++ b/tests/generic/698
@@ -0,0 +1,51 @@
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
+_create_file_sized 5G $junk_file
+if [ $? -ne 0 ]; then
+        echo "_create_file_sized failed"
+fi
+
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

