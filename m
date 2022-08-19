Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19123C32771
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Aug 2022 14:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349459AbiHSObn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 19 Aug 2022 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiHSObm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Aug 2022 10:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9884BEA337
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660919500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xLqYh9MKC33aCGBrYUiILJOiVdyq5sKSJULmizwH248=;
        b=BuDc/kWk1Im2kJt4YzAmET0G/+r/Ji6o2PqEllsF0aOXOEobFcZ60zsH8hHqcA2psl7yEp
        Fyubi7+XQQQ98UBXL5L0u8eysW+qUOymWNnvH56fB6MelRia3WOpfzUKyqnDzTnDeyA7ZE
        ybhh6ImdYgQN+/rU2JBl/vuMYe3EcKo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-a-pALodCMkm9jU8lKxNpvg-1; Fri, 19 Aug 2022 10:31:39 -0400
X-MC-Unique: a-pALodCMkm9jU8lKxNpvg-1
Received: by mail-ed1-f72.google.com with SMTP id m18-20020a056402511200b0043d601a8035so2966112edd.20
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 07:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=xLqYh9MKC33aCGBrYUiILJOiVdyq5sKSJULmizwH248=;
        b=TDn9uBySUbI+d7OhmccDAK4+caI27eBlfR/QSBnsQUof9Amvr7LwfoxvdSxJuvzvtX
         XzZcH4jfryk11cKd7ffdOLywC1kwF2MGQ1q4SRyedoCyDF6nlDCv4zLhw2ix/uPkHxu2
         HW3zYa/nzH3PFkWnE0uy06aGbLUOHyZYnsafDhcTzGQP5kECc2RRfCLY7KL0ahf8t3Ui
         QesjAj6Y+tb+BgS/w5ai2Zl36u+STDdI1dL00UTNy3cZDwBKGtJUw/qf0UrELutfchXP
         AxGxBis7ryqjkHLz7RU5QVb+YRsi3qKeR3Gdz0NoiYsA91X0WTaXthABAoiv7VIPvOU8
         qC7w==
X-Gm-Message-State: ACgBeo1/yyXkbXuXX0KAZbRr4dFinvYFGzAN4Zy00RAbimdkl6iE7m2Y
        n3YjGPdpFhFlCJ9PI8gBVqWrPk9wRVp43ngdUTX13iYDYZQvPUdJYlFY3drtT1IJhXhLS4plpcm
        t/P9y719E35lUKrF6QZdHe0blUD6Rb3KDFOqMBsygQQWeUqCsD6iGYjQ3S3V3/NDdeocG
X-Received: by 2002:a05:6402:22ea:b0:445:d29c:9694 with SMTP id dn10-20020a05640222ea00b00445d29c9694mr6288687edb.359.1660919498044;
        Fri, 19 Aug 2022 07:31:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR48FlcTy/+7xUo7h6j2k3afbjpnLFSsjZDWjYq8/zau0uPJ1j57K9WKeBjCVNyb/cfY1rlGFg==
X-Received: by 2002:a05:6402:22ea:b0:445:d29c:9694 with SMTP id dn10-20020a05640222ea00b00445d29c9694mr6288668edb.359.1660919497741;
        Fri, 19 Aug 2022 07:31:37 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906218200b0073306218484sm2381216eju.26.2022.08.19.07.31.36
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:31:37 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v4] generic: test i_blocks for large files
Date:   Fri, 19 Aug 2022 16:31:35 +0200
Message-Id: <20220819143135.468776-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.2
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
 tests/generic/694     | 47 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/694.out |  2 ++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/generic/694
 create mode 100644 tests/generic/694.out

diff --git a/tests/generic/694 b/tests/generic/694
new file mode 100755
index 00000000..dfd988df
--- /dev/null
+++ b/tests/generic/694
@@ -0,0 +1,47 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
+#
+# FS QA Test 694
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
+_require_fs_space $TEST_DIR $((4 * 1024 * 1024)) #kB
+
+echo "Silence is golden"
+
+junk_dir=$TEST_DIR/$seq
+junk_file=$junk_dir/junk
+mkdir -p $junk_dir
+
+$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
+
+iblocks=`stat -c '%b' $junk_file`
+
+_test_cycle_mount
+
+iblocks_after_remount=`stat -c '%b' $junk_file`
+
+if [ "$iblocks" != "$iblocks_after_remount" ]; then
+	echo "Number of blocks needs to be same: $iblocks, $iblocks_after_remount"
+fi
+
+status=0
+
+exit
diff --git a/tests/generic/694.out b/tests/generic/694.out
new file mode 100644
index 00000000..d1fb84a2
--- /dev/null
+++ b/tests/generic/694.out
@@ -0,0 +1,2 @@
+QA output created by 694
+Silence is golden
-- 
2.37.2

