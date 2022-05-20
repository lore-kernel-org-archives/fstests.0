Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476EDC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 18:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244905AbiETSXv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 14:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiETSXv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 14:23:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE62190D0C
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 11:23:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z39-20020a25a12a000000b0064dbcd526ffso7774428ybh.15
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5XUfyTc0ZRU9nWUoe/wFMFXdQaE7THi8KYzurIjxr4Q=;
        b=ZAHW7JQhkT/oZpc/PiySZgqLb2uL6fi6RT8zKBLxFJGKL78cFa4V56akZproHXjito
         Lv9Mq5oZvLoGweRlBdEXFhu0nuWnvaptSo24taz6dhC5VpVKoPp7Wd1s2xoiTmizYTDw
         dJcgTMFFEMe3roj/ydDycKh/ZsEX+xwK51lpJoAOBpU7AJXbwPV5lP/plsKPYxAvC4uw
         GPZPJYuMnZ+EjBNNM8dPXzTquv+KT3s6SHVMx57ZD5GGK3c+JNd1paKnsuV5JJCdgKwE
         /bL/WMQn2A5cVu7hy05flwcCEmTaeJmq3YnHSnqDsJAo/ai0EgPjhDCYz2rHQ7DiajQT
         bemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5XUfyTc0ZRU9nWUoe/wFMFXdQaE7THi8KYzurIjxr4Q=;
        b=Ruy4VdmbDbn18HdBv4uSVAMrkogWEAZem6mFrQ03apawqdJPdp+3PtifQpwQWsILbb
         L68Yzp1rJdBNfpCjiOkAMReiCfpcDzWIonMWqtKr+dxoJ2+vJZKXhH+655JIuUMaQXI0
         ibMpVdVpZL8dH4QSuCPiKbYWpkyygaIqcjpx/6yq/2SwkiJN+AZeXF2JEBVCSfJWgEZG
         kG0g4GIBk4GHYcfzFbaQvI0ql27xhbDQpgEAUIt7CaYxxlCjX1AXSyr9AMOf1HaiNTom
         5X5pOc54Ul8on/NhrRhFlr7nWHwTcuiz1CAZUlAsFd2d/rUb/x9TP9JGtVD+3xyUMzO9
         71jQ==
X-Gm-Message-State: AOAM532x0U7lEia+IsSGT90OM1rgBDtZcUA3LTZpTg3yv401k4KpMjTp
        Netm3sDPpZrCMZW9skjEPRlIgi9ZZKSb/TZvCNQkwuTqeBlaAtc+ekQTmoTDgPRrxJKF9m3ldgH
        JrdYmFNIQh3HAbg5K+tN/RnBBYhZxrp0sAi3PouzVSxTQyqjSzFE/mKiwMMXD
X-Google-Smtp-Source: ABdhPJw3iETyBugKjMvLqaY10G/WRV6awm7nKF/bg6/zYBOyGUL0uasBUy4u2enFxVU84fUBfoxkS+tVew==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a81:4104:0:b0:2f1:b59f:22a2 with SMTP id
 o4-20020a814104000000b002f1b59f22a2mr11828351ywa.328.1653071029757; Fri, 20
 May 2022 11:23:49 -0700 (PDT)
Date:   Fri, 20 May 2022 13:23:15 -0500
In-Reply-To: <20220520182315.615327-1-nhuck@google.com>
Message-Id: <20220520182315.615327-3-nhuck@google.com>
Mime-Version: 1.0
References: <20220520182315.615327-1-nhuck@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v3 2/2] generic: add tests for fscrypt policies with HCTR2
From:   Nathan Huckleberry <nhuck@google.com>
To:     fstests@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patch adds fscrypt policy tests for filename encryption using
HCTR2.

More information on HCTR2 can be found here: "Length-preserving
encryption with HCTR2" https://ia.cr/2021/1441

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 tests/generic/900     | 28 ++++++++++++++++++++++++++++
 tests/generic/900.out | 16 ++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

diff --git a/tests/generic/900 b/tests/generic/900
new file mode 100755
index 00000000..d1496007
--- /dev/null
+++ b/tests/generic/900
@@ -0,0 +1,28 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2022 Google LLC
+#
+# FS QA Test No. generic/900
+#
+# Verify ciphertext for v2 encryption policies that use AES-256-XTS to encrypt
+# file contents and AES-256-HCTR2 to encrypt file names.
+#
+. ./common/preamble
+_begin_fstest auto quick encrypt
+
+# Import common functions.
+. ./common/filter
+. ./common/encrypt
+
+# real QA test starts here
+_supported_fs generic
+
+_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-HCTR2 v2
+_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-HCTR2 \
+	v2 iv_ino_lblk_32
+_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-HCTR2 \
+	v2 iv_ino_lblk_64
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/900.out b/tests/generic/900.out
new file mode 100644
index 00000000..a87c80b3
--- /dev/null
+++ b/tests/generic/900.out
@@ -0,0 +1,16 @@
+QA output created by 900
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-HCTR2
+	options: v2
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-HCTR2
+	options: v2 iv_ino_lblk_32
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-HCTR2
+	options: v2 iv_ino_lblk_64
-- 
2.36.1.124.g0e6072fb45-goog

