Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF6EC25B0E
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Aug 2022 19:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344463AbiHITFM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343772AbiHITEJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Aug 2022 15:04:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0A4B7CE
        for <fstests@vger.kernel.org>; Tue,  9 Aug 2022 11:40:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z7-20020a25ba47000000b00677405b2d2dso10358133ybj.13
        for <fstests@vger.kernel.org>; Tue, 09 Aug 2022 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=UY45fiCC0vM0G3PPAd3FtQ6obM5XnrZ9BORXRIICJ8g=;
        b=nbgIh6OdFRXkXtkG1PHNt3wMzpbxmQJ654d/KFNyG7iKCHyTYrEW61Q26HwbANCCu1
         7DV/+hYhzwnlUn2ujR2jJ3DaqUwJEPQjEUPPruGhnWeNEGm18xzZePvTtjhgenM3awj3
         UB9f8374+MnR43ayWWrO9B/o/YUcJfjRWE3FQ3W0FGjgTOZq2Xq0HwcAy3j4Txv4P60p
         Mwt/x5jWHuVzPzuDU3gLrvEHmQKURxfQM1Am2w4yBQPFbApuo4pMQ2roufn8t5xTt/+O
         Iz1Pr85kLI5LP1eNmFTrqmftQrrodCuvvAgcMIs43TWKkCsP+1Ao6M21D8d7nbjmopc9
         p+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=UY45fiCC0vM0G3PPAd3FtQ6obM5XnrZ9BORXRIICJ8g=;
        b=ou6iaBYPa1pNuCCJqr+6K70m1SzYs1R8J9904iydlFE7yjyXlEXZ6MY/V+4M6gTzQU
         YOHeSX+flAPcor3WFi9OXiaCTEfhU+L8/8rI12z3Y4S5UaZZkDeu5CDo49H+7zkivAvz
         ks6+zkqw29b8c0LomMGoBJBV7kkITv0KXNEkyNAVfapLFKWC57Cozec9iKFJt/V6SIzH
         GbG6NoDSeNPFyMAQEche8tC3YvY7wX1XbENOZXtswVOmsi6ZXbjhXJqyR1O/ttegitVj
         KpeMDIw6/qsk4d468RQ9xJcPBu/xwLY5PZUmGSVfo75JcyHcUxjAhPDQz9xhlNmUSgG2
         F82Q==
X-Gm-Message-State: ACgBeo2BIB1EHD1ZTLTaMqz0VG453Agi0HlSdXcJmu+bcyGAdJ0ppy1g
        JzAtCIOLkTEYtWRiBEXOvwBATKCw5azB2/S7/2TyeVkwFtaOtGmI6SyKQzFZD3mR4Xjd7o0/lC+
        Ri5eol57Zc+YueElmSISC01sP0In5GMeEkbWLbqwB873Z0j1o5TE1KfAgl9Sj
X-Google-Smtp-Source: AA6agR4aWZ/STUV8mOnMn6hd85MJEFs8dnuBNbd5YfBRpZUaM5+HAKzoQIdwMJPZ/cgtpkJbdxedf7066g==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:3056:0:b0:671:6913:d040 with SMTP id
 w83-20020a253056000000b006716913d040mr20789029ybw.124.1660070444318; Tue, 09
 Aug 2022 11:40:44 -0700 (PDT)
Date:   Tue,  9 Aug 2022 11:40:37 -0700
In-Reply-To: <20220809184037.636578-1-nhuck@google.com>
Message-Id: <20220809184037.636578-3-nhuck@google.com>
Mime-Version: 1.0
References: <20220809184037.636578-1-nhuck@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v6 2/2] generic: add tests for fscrypt policies with HCTR2
From:   Nathan Huckleberry <nhuck@google.com>
To:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patch adds fscrypt policy tests for filename encryption using
HCTR2.

More information on HCTR2 can be found here: "Length-preserving
encryption with HCTR2" https://ia.cr/2021/1441

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Tested-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/900     | 31 +++++++++++++++++++++++++++++++
 tests/generic/900.out | 16 ++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

diff --git a/tests/generic/900 b/tests/generic/900
new file mode 100755
index 00000000..1ff7c512
--- /dev/null
+++ b/tests/generic/900
@@ -0,0 +1,31 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2022 Google LLC
+#
+# FS QA Test No. generic/900
+#
+# Verify ciphertext for v2 encryption policies that use AES-256-XTS to encrypt
+# file contents and AES-256-HCTR2 to encrypt file names.
+#
+# HCTR2 was introduced in kernel commit 6b2a51ff03bf ("fscrypt: Add HCTR2
+# support for filename encryption")
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
2.37.1.559.g78731f0fdb-goog

