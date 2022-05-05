Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0576C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  5 May 2022 19:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385166AbiEETmJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 5 May 2022 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiEETmJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 May 2022 15:42:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B245D5F0
        for <fstests@vger.kernel.org>; Thu,  5 May 2022 12:38:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7c322f770so46352567b3.20
        for <fstests@vger.kernel.org>; Thu, 05 May 2022 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lQlP45DHkDNskXLx3b5+RlA38CXMVEY7+hpfZCUDyAI=;
        b=sWVotSrmvDcJU/drxd57OWO1ETBtWDCG0R4PkBhANs4jVeUK4UQF26kgUyiQSeh4kg
         Oiv3Q5pZrki3p6DGOZKul7T6PTeH4Tc1zkddtWLWLG6XusWPdrwmwq2PACgGVBT2DHRj
         hasLAFoldIcd/tahSrqx0QWjR6K9C+s+mR6RG12JysFGPc0Vmwf9/iAEcmc0V7+nitzp
         0B6DFSNkzcQWCll4Ab1LziB/0GLfXBXtd9sHL3Cmox4LgH73NsL2at6Vv9rxRe6fLq6H
         M5DARk81skbjeqh3+37F44jWZxPry43tzAbKuJou0rb1rFTZU232mHfrF2aGz1XmeHIR
         jvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQlP45DHkDNskXLx3b5+RlA38CXMVEY7+hpfZCUDyAI=;
        b=RLO1ui1Qz2dCX1WU4wjCiLOWOOD1WSTUgwIxe/rAg661VBmy5jNmWzZAGlxYhCk5V4
         9QlMLDE/kK/+HpUlWIDa2nixZmmJVAaQ0mBZDK0OOHjZ67ot9dRXm7rzv2RMCuLQniFq
         F9y7B7BtzOXExo8YwXffsQrfiFyiuz5RIKc5kk0a/zF83utDHVRKpdh9wdbIOlBkdTN9
         pf4CqEMBHQsVUHGRPKvmFBDqEUal3VsvCyUuzABCL8hBQu1Oyxa2n53ve3JaoIdQBrDk
         P6fEnACvWFVatyWcm3yT35Q6ltlmWfdugcvynmlgsCUMLWVl/upOraDlKy887dCK8Ufa
         KBOA==
X-Gm-Message-State: AOAM531kGB6z2Z7yKtGZXsIxViHYJ5tTRbiYunEI73uEp1uO7w7jc1qI
        +/QrVTbUEgWs435KvlMwI4UKKn47T5hp8Ye9buk1eYJuqNvqKml4TENM02v3RzCa7uHmxlD8dji
        k/28LCVgaEHXNHzTUD83dzavw7WX1DTTlGE34VE37SxO26eS2LwIvJ857ZDWQ
X-Google-Smtp-Source: ABdhPJy27FpVO9lfu7DrYy2nkn5t4F2BG2FPk2U9cYclYirGaKfNZmPLX0H5TCewdkgYMvbzELXW1JgjnQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:3fc3:0:b0:64a:2bf8:f4fd with SMTP id
 m186-20020a253fc3000000b0064a2bf8f4fdmr6107862yba.261.1651779508232; Thu, 05
 May 2022 12:38:28 -0700 (PDT)
Date:   Thu,  5 May 2022 14:38:09 -0500
In-Reply-To: <20220505193809.579026-1-nhuck@google.com>
Message-Id: <20220505193809.579026-3-nhuck@google.com>
Mime-Version: 1.0
References: <20220505193809.579026-1-nhuck@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [RFC PATCH v2 2/2] generic: add tests for fscrypt policies with HCTR2
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
 tests/generic/900     | 24 ++++++++++++++++++++++++
 tests/generic/900.out |  6 ++++++
 tests/generic/901     | 26 ++++++++++++++++++++++++++
 tests/generic/901.out |  6 ++++++
 tests/generic/902     | 26 ++++++++++++++++++++++++++
 tests/generic/902.out |  6 ++++++
 6 files changed, 94 insertions(+)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out
 create mode 100755 tests/generic/901
 create mode 100644 tests/generic/901.out
 create mode 100755 tests/generic/902
 create mode 100644 tests/generic/902.out

diff --git a/tests/generic/900 b/tests/generic/900
new file mode 100755
index 00000000..a3a9cead
--- /dev/null
+++ b/tests/generic/900
@@ -0,0 +1,24 @@
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
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/900.out b/tests/generic/900.out
new file mode 100644
index 00000000..2e5d1b27
--- /dev/null
+++ b/tests/generic/900.out
@@ -0,0 +1,6 @@
+QA output created by 900
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-HCTR2
+	options: v2
diff --git a/tests/generic/901 b/tests/generic/901
new file mode 100755
index 00000000..7fc63d8f
--- /dev/null
+++ b/tests/generic/901
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2022 Google LLC
+#
+# FS QA Test No. 901
+#
+# Verify ciphertext for v2 encryption policies that use the IV_INO_LBLK_32 flag
+# and use AES-256-XTS to encrypt file contents and AES-256-HCTR2 to encrypt
+# file names.
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
+_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-HCTR2 \
+	v2 iv_ino_lblk_32
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/901.out b/tests/generic/901.out
new file mode 100644
index 00000000..2a06addb
--- /dev/null
+++ b/tests/generic/901.out
@@ -0,0 +1,6 @@
+QA output created by 901
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-HCTR2
+	options: v2 iv_ino_lblk_32
diff --git a/tests/generic/902 b/tests/generic/902
new file mode 100755
index 00000000..82863d87
--- /dev/null
+++ b/tests/generic/902
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2022 Google LLC
+#
+# FS QA Test No. 902
+#
+# Verify ciphertext for v2 encryption policies that use the IV_INO_LBLK_64 flag
+# and use AES-256-XTS to encrypt file contents and AES-256-HCTR2 to encrypt
+# file names.
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
+_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-HCTR2 \
+	v2 iv_ino_lblk_64
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/902.out b/tests/generic/902.out
new file mode 100644
index 00000000..41df9f99
--- /dev/null
+++ b/tests/generic/902.out
@@ -0,0 +1,6 @@
+QA output created by 902
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: AES-256-XTS
+	filenames_encryption_mode: AES-256-HCTR2
+	options: v2 iv_ino_lblk_64
-- 
2.36.0.512.ge40c2bad7a-goog

