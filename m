Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492C7C00140
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Aug 2022 11:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiHRLj3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Aug 2022 07:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbiHRLj3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Aug 2022 07:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331E667441
        for <fstests@vger.kernel.org>; Thu, 18 Aug 2022 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660822758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eyApB48Dl0l6ePQPidRWW06tHKmZmRh7TJjepJQi9TI=;
        b=ZxoArKpezBI/0xMVHMYirYTiLR6aCeShp4CkJCJ5vwETITin9lhircnF+PjL6DOiYtxYrc
        zCnC8901vAGf1pLkbVJsQv0zvS7COF0KcQv2dCVGTYZNeshp8SB4JZl9HnXPgm0riHYP12
        A7okPgukCJfRbrrWg0GevKqxVSUXnG8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-P4ZVb4_pMsuff5RdFNsQJQ-1; Thu, 18 Aug 2022 07:39:09 -0400
X-MC-Unique: P4ZVb4_pMsuff5RdFNsQJQ-1
Received: by mail-ej1-f70.google.com with SMTP id jg41-20020a170907972900b00738b83ea216so586120ejc.11
        for <fstests@vger.kernel.org>; Thu, 18 Aug 2022 04:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=eyApB48Dl0l6ePQPidRWW06tHKmZmRh7TJjepJQi9TI=;
        b=urhWp4E3XvTPQ8t+tNcZZJPzByo5UiLvAzseOacP2WjK/QqXSRvkD+THp8EatihIbJ
         kHz1aj2sAQ4ADeySP/yh9+qR5GdeVnB0HNDZhZ+NBxgn9Aw1qm2wKXCnWtBh8RFJLF0X
         E9VtUDd0x4jARqE58HFaW/UuRniqWYPSbXd/XuKhbuWRKIZlRYJiOfT7LY4hN6MeCvKu
         KbRQk7R6O4uBy7qfa+r6i6fFUf5TqogoallTqU+Ibn3eetQ1kjXafN1O0Rp14GNgN23N
         YaiXakssjH66IMfe9BRTbdZgtFzTx/K3bqcxFaVyfhMEZFpT52i8We6JVycqR+Bo58Tp
         qeIw==
X-Gm-Message-State: ACgBeo1eIWxkz8DMkPXAZmKdSF700VJsVrPtpyEIXtnMfNxA0RK00flX
        YHHev76BVNLY4WyLs34vRcosPCp4hyeh/0WV/EI00Gf5At+U601COul8exX7c0/ftWSGxJK30RQ
        seW0A9BDdSQE9uIon/bXHntAM9brhilWqrmYtR4evM/DAc+9Xdn+GVWK6l2rboB72k5CZ
X-Received: by 2002:a17:907:60c7:b0:739:52ba:cbd0 with SMTP id hv7-20020a17090760c700b0073952bacbd0mr1643869ejc.152.1660822748385;
        Thu, 18 Aug 2022 04:39:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR66X+/+Mr0k1pUs167a8duOWa/er3WZBbhkBTqTfb79ezC1hVx9jsAJOlE43Ajz/25C81nODw==
X-Received: by 2002:a17:907:60c7:b0:739:52ba:cbd0 with SMTP id hv7-20020a17090760c700b0073952bacbd0mr1643861ejc.152.1660822748126;
        Thu, 18 Aug 2022 04:39:08 -0700 (PDT)
Received: from localhost.localdomain.com (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090653c100b006fec4ee28d0sm708937ejo.189.2022.08.18.04.39.06
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 04:39:07 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3] generic: test i_blocks for large files
Date:   Thu, 18 Aug 2022 13:39:05 +0200
Message-Id: <20220818113905.402441-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <Yvu+i1sxTD/KcVjL@magnolia>
References: <Yvu+i1sxTD/KcVjL@magnolia>
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
 tests/generic/693     | 47 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/693.out |  2 ++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/generic/693
 create mode 100644 tests/generic/693.out

diff --git a/tests/generic/693 b/tests/generic/693
new file mode 100755
index 00000000..29992ed0
--- /dev/null
+++ b/tests/generic/693
@@ -0,0 +1,47 @@
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
diff --git a/tests/generic/693.out b/tests/generic/693.out
new file mode 100644
index 00000000..01884ea5
--- /dev/null
+++ b/tests/generic/693.out
@@ -0,0 +1,2 @@
+QA output created by 693
+Silence is golden
-- 
2.37.2

