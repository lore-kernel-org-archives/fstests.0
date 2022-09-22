Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E47C6FA90
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 06:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiIVGis (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 02:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIVGis (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 02:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7364CB6D1A
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 23:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663828726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ynH91aIqphd5XSYlCjy5Z9T879e+jI8maiNeIW6cgfs=;
        b=eKDzKxjz3+CUH1Ng93uGUYnMtj1QOPcw6sScWKWCrtYJnVrYzYyxQn5uZ7LGTgdtSIGglT
        DXFfYn5yRpnLkKv1szkEYm7r6A85HtA3vGTz/DpGBIQSY3dLjJjEegZDRhBb/H5eiJH4eT
        9HwJvRvL1DMe036ycSWcpbkrT5/Ov10=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-xrsWheU0N9K1wxo2fBJWLw-1; Thu, 22 Sep 2022 02:38:44 -0400
X-MC-Unique: xrsWheU0N9K1wxo2fBJWLw-1
Received: by mail-ej1-f70.google.com with SMTP id xc12-20020a170907074c00b007416699ea14so3970847ejb.19
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 23:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ynH91aIqphd5XSYlCjy5Z9T879e+jI8maiNeIW6cgfs=;
        b=n2NFHDWJ12W7BKgjoBPD2LvamuWZ7mg8eP1MXqb9KaDrF2ct/rFvOehkwwqRbzf14H
         IKisROlcvHHXBEbXfFFvQRrzcg3yP933ZrwB/nyXsFtu7+IczI6gPwcnZ6fEDCVyrF7k
         M++rrQoi+osTVsB0O3uIyA5hTMz0X2oaCzj8WBSnYdsA2xNhj0TpXTlTAPC5RSLnUEmp
         Nd/LrE/JEfNJAG3Mx07CyF+U7hTXnG/rD6JcAUQY8BaOqsjpA+wFGz+1Dht+sxlDcL7g
         H2LQzyDqkX9k12Pbce/4f8QgChoXQtv0MYAm3MV5Ox1oHAszfHuAQYmm7MMuPrPbuB+h
         eU7A==
X-Gm-Message-State: ACrzQf0g27E6dCIpVLjia36pKiioqAD1AGEvn1MaSy43/gdpWHPi45t/
        BRfz8GVqZpVVymkdAZs6GMx53VtDk46iSvdQ2hfHhfQ6hG1lpmndTIMCS1I7D2GQh0Lrjrid0kK
        AOJz3L38hsvHBB2OvFaX9Ofcc672YXDzvkj3mwj9ljy8CIoC26EKHbxXGn2IxT06tLrsa
X-Received: by 2002:a05:6402:b45:b0:44e:a071:2b3b with SMTP id bx5-20020a0564020b4500b0044ea0712b3bmr1698509edb.95.1663828723257;
        Wed, 21 Sep 2022 23:38:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5DOdyCRMJgNsZInZoHmHVwexNYkQp57Cou00tSbpolM7e38JRL261rHIOkTQ1vlsPkU/LYSw==
X-Received: by 2002:a05:6402:b45:b0:44e:a071:2b3b with SMTP id bx5-20020a0564020b4500b0044ea0712b3bmr1698485edb.95.1663828722897;
        Wed, 21 Sep 2022 23:38:42 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id s4-20020aa7d784000000b0044838efb8f8sm3072750edq.25.2022.09.21.23.38.39
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 23:38:41 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v5 2/2] generic: test i_blocks for truncated large files
Date:   Thu, 22 Sep 2022 08:38:36 +0200
Message-Id: <20220922063836.974796-3-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922063836.974796-1-preichl@redhat.com>
References: <20220922063836.974796-1-preichl@redhat.com>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/generic/698     | 51 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/698.out |  2 ++
 2 files changed, 53 insertions(+)
 create mode 100755 tests/generic/698
 create mode 100644 tests/generic/698.out

diff --git a/tests/generic/698 b/tests/generic/698
new file mode 100755
index 00000000..6aeea64e
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
+	echo "Could not create 5G test file"
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

