Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF046C00140
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Aug 2022 14:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbiHLOu5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 12 Aug 2022 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHLOu4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Aug 2022 10:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4984901A5
        for <fstests@vger.kernel.org>; Fri, 12 Aug 2022 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660315854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2FEub00A6DBFxyGaoBCILmU9icilwbwstlWYdWUGap8=;
        b=DKRtAzPFhZXD2VZDivdkeBBLWddJZDQ/yhJoc7+D3Uqbizv5fkR8MrsRVbkZT+1Cn/wHev
        +SXEFnQLxzbo9Kn9lKIVCvzAqItDtrO6PSmOQFIiBy7yALbCBf7cGZmfqiNjCJGAh7d376
        hTrGhxRcoRjdkXpDyfxll5rEv92bbYQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-29-UWvLD2UWO_quRrUklhvyAg-1; Fri, 12 Aug 2022 10:50:53 -0400
X-MC-Unique: UWvLD2UWO_quRrUklhvyAg-1
Received: by mail-ed1-f72.google.com with SMTP id v19-20020a056402349300b0043d42b7ddefso744253edc.13
        for <fstests@vger.kernel.org>; Fri, 12 Aug 2022 07:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2FEub00A6DBFxyGaoBCILmU9icilwbwstlWYdWUGap8=;
        b=QvozfWZ2KXro7dmINof1Sml5eWS40QulwWJPf287LlFHpchzf9S8SEilsOH9O9aaqF
         Px3hOvdpdr/eV8OJVxCqTfdQFntT8Bk1sEJt4PdKy/BUGGg1XtdrjydyR24bqdzt1tIz
         cR84ZLfPWFC6ylAaEMGN4lySzdaGwtz2mB8kXOi3Tb19TluSg6v+MN1rxTXfHgXzbNY7
         T7nkNZEktfgKVvL5GyEynx0qTCu7/q7YPcnNzuzdP4kHX07N7hTBlNIVx/wBTdmtGz/G
         5rAmDiMG+wgMg05D2oUT4q5qJtBtQErwE6upULVt0Zf3V2Tz3ZDhHq6O7fwM00G+KVfu
         wUHg==
X-Gm-Message-State: ACgBeo3/Eoyuy+QqMJDfFDCUYSF7afpc42qO+RBjwO2N6SviSNjsypQ4
        2stFszCWXEuFF/X0NHPYshfxFHCSqlOld+fUnuw8QDH6SnXaF1sJ1G92/g6Ylck6yv3CA7ncLDm
        TwKUOAT3V+346I2FSho8vW324y2U9IDDEyPftEpvUoISBeSuVjyRHiDmMyy27oinP3378
X-Received: by 2002:a17:906:9bdd:b0:730:5b04:7298 with SMTP id de29-20020a1709069bdd00b007305b047298mr3085644ejc.180.1660315852375;
        Fri, 12 Aug 2022 07:50:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5BDEywKf/49t6S4dOJNLeTAEcIi/xxd6Buv1zK1X+dZXDBcxArW8pZcsy53qC/bUEeqqyXew==
X-Received: by 2002:a17:906:9bdd:b0:730:5b04:7298 with SMTP id de29-20020a1709069bdd00b007305b047298mr3085623ejc.180.1660315851894;
        Fri, 12 Aug 2022 07:50:51 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id gg17-20020a170906e29100b0072af930cf97sm852574ejb.115.2022.08.12.07.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:50:51 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     sj1557.seo@samsung.com
Subject: [PATCH] generic: test i_blocks for large files
Date:   Fri, 12 Aug 2022 16:50:50 +0200
Message-Id: <20220812145050.43966-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is a regression test for an incorrect
computation of i_blocks for files larger than
4 GiB. Bug was filed for exFAT.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/generic/693-inodes-for-large-files     | 49 ++++++++++++++++++++
 tests/generic/693-inodes-for-large-files.out |  1 +
 2 files changed, 50 insertions(+)
 create mode 100755 tests/generic/693-inodes-for-large-files
 create mode 100644 tests/generic/693-inodes-for-large-files.out

diff --git a/tests/generic/693-inodes-for-large-files b/tests/generic/693-inodes-for-large-files
new file mode 100755
index 00000000..797d6a21
--- /dev/null
+++ b/tests/generic/693-inodes-for-large-files
@@ -0,0 +1,49 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
+#
+# FS QA Test 693
+#
+# Verify that i_blocks for files larger than 4 GiB have correct
+# values.
+#
+# This test verifies the problem fixed in kernel with commit
+# 0c336d6e33f4 exfat: fix incorrect loading of i_blocks for large files
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
+
+junk_dir=$TEST_DIR/$seq
+junk_file=$junk_dir/junk
+mkdir -p $junk_dir
+
+$XFS_IO_PROG -f -c "truncate 4G" $junk_file
+
+iblocks=`$XFS_IO_PROG -c "stat" $junk_file | grep 'stat.blocks'`
+test -z "$iblocks" && echo 'Failed to parse the blocks'
+
+_test_cycle_mount
+
+iblocks_after_remount=`$XFS_IO_PROG -c "stat" $junk_file | grep 'stat.blocks'`
+
+test -z "$iblocks_after_remount" && echo 'Failed to parse the blocks'
+
+if [ "$iblocks" != "$iblocks_after_remount" ]; then
+	echo "Number of blocks needs to be same: $iblocks, $iblocks_after_remount"
+	status=1
+	exit
+fi
+
+status=0
+
+exit
diff --git a/tests/generic/693-inodes-for-large-files.out b/tests/generic/693-inodes-for-large-files.out
new file mode 100644
index 00000000..f39aa77c
--- /dev/null
+++ b/tests/generic/693-inodes-for-large-files.out
@@ -0,0 +1 @@
+QA output created by 693-inodes-for-large-files
-- 
2.37.1

