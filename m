Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054AAC6FA82
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Sep 2022 12:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiIMM6M (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Sep 2022 08:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiIMM6M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Sep 2022 08:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553C725F3
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663073889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLHjDV6vtHm/jwO6Ea2F8hiesVpCe03N8Vxq+DJU6jk=;
        b=DOGUuCiCVi38tZz7EHykeN7ZBig0sk0gH+3eAJjJencYQPX9sLwCwV1J9fU5ioLIW6uYX5
        CEHPMF8ATmjPZfR5aSYp7s/oTHtSyX8uwfqav0Ds8KkaTGZrdZDNly+/hTJ1mxI2+20ldw
        ktvbyLXSvrGCFs+frIHmZ6WUzLBGlKk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-GNZrIDW6PwOqMUCSM1BN_w-1; Tue, 13 Sep 2022 08:58:08 -0400
X-MC-Unique: GNZrIDW6PwOqMUCSM1BN_w-1
Received: by mail-ed1-f72.google.com with SMTP id b16-20020a056402279000b0044f1102e6e2so8541128ede.20
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 05:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tLHjDV6vtHm/jwO6Ea2F8hiesVpCe03N8Vxq+DJU6jk=;
        b=A+9O/kUHNjnbASHLpcS6K57proPo4b4UGyB574lzZrgFdF58ydBUEveT+9aqOeUAiy
         0D5qgtmfFlD4LwFZDy4o1gYmRPLfGJ/Y3Rr5cKvBdL9LU6uJdAhWaXvzZ1/adxGQFHQU
         1YUlS6kL9A6xzm9C3gT/YPb2sGcQ7e+Yus1cMH9jMbQU/bdxYV8bQjuRw2b1gI7NEMrP
         c/xOrgzko//Qb7NYeKwN3y15yByS8ZexS9NpCTQQ8PqsSgYFHBeGe55S3Kre1oMzbQLQ
         yTUs34xUdqzb9rCDSZeUKaRjAofw/1f6KnflMZRL8zb3jOnjTE1oQpRpDDaiYVj1WSIN
         vb+g==
X-Gm-Message-State: ACgBeo3U2eJmSe2fHV7BiOnC+ZKkopQoojkdxHyTep4c8cRSf1d+5nwY
        NFrr4chhEBqf29JiBg7bowDYqc7k6sy9yfHoOJwWV5G9w8FKbXQEuyasnll/SySXy5pMdh59MjA
        zDSAQrZNrY5QjQrECNp0n/tfooZKr5akuSq2D8DIeUvNJKD60enPVg1wzE0x38F2Qh1Gm
X-Received: by 2002:a17:907:320a:b0:741:72ee:8f3 with SMTP id xg10-20020a170907320a00b0074172ee08f3mr22077997ejb.168.1663073886133;
        Tue, 13 Sep 2022 05:58:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4waTYWpP/K7m9AfFKeyCJyo5UiVrB5Jwb/Y8E0CfnSGsP/7bHDv37rd1VJIEotIjfU06aWtQ==
X-Received: by 2002:a17:907:320a:b0:741:72ee:8f3 with SMTP id xg10-20020a170907320a00b0074172ee08f3mr22077975ejb.168.1663073885874;
        Tue, 13 Sep 2022 05:58:05 -0700 (PDT)
Received: from localhost.localdomain.com (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id e17-20020a170906249100b00778e3e2830esm593722ejb.9.2022.09.13.05.58.04
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 05:58:04 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 1/1] generic: test i_blocks for truncated large files
Date:   Tue, 13 Sep 2022 14:58:01 +0200
Message-Id: <20220913125801.56366-2-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913125801.56366-1-preichl@redhat.com>
References: <20220913125801.56366-1-preichl@redhat.com>
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
 tests/generic/698     | 48 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/698.out |  2 ++
 2 files changed, 50 insertions(+)
 create mode 100755 tests/generic/698
 create mode 100644 tests/generic/698.out

diff --git a/tests/generic/698 b/tests/generic/698
new file mode 100755
index 00000000..337df6c5
--- /dev/null
+++ b/tests/generic/698
@@ -0,0 +1,48 @@
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
+$XFS_IO_PROG -f -c "pwrite -W 0 5G" $junk_file > /dev/null
+
+truncate -s $((4 * 1024 * 1024 * 1024)) $junk_file
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

