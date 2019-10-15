Return-Path: <SRS0=6y5p=YI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460F2ECE58F
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 18:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2229620854
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 18:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571163961;
	bh=RHiTGwKIyhw68XNamvogA0hnIzZsk8r+AmjBH0AhhTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e1ydl18qK4Mgg9Jux3qIuVIo3kkURWmzZm3n9bBMrdzEZhYnk901wYTbqfaRy8Sl/
	 Xuh8a708z8EAiG7I8WIQLbUglSxTvAjBv6Kejyb3WqUslyg87saZKRoffqraL9QevI
	 O150YLF5SYrGgsTjGTcMmBmm/qsOn3DqFLWLNIzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbfJOSZ5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389025AbfJOSZ5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Oct 2019 14:25:57 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F490222D3;
        Tue, 15 Oct 2019 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571163444;
        bh=RHiTGwKIyhw68XNamvogA0hnIzZsk8r+AmjBH0AhhTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Us4GG7U9j8xrkEs4hidLFmIjtKOhN+Df+AlsTO0E2ZvtaOdnsUj/bj8r4mAuEeT0J
         excI884r6Jsk9kjqrSHYsT7goJ5nGLlbp/8qVYnHKlINtTuxWik/q8PfBrdcL3GNK0
         S/9iHQ9YQbzV8hEYBeJR+yB0T1Jq3ZIChU5xm2es=
From:   Eric Biggers <ebiggers@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org
Subject: [PATCH v3 9/9] generic: verify ciphertext of v2 encryption policies with Adiantum
Date:   Tue, 15 Oct 2019 11:16:43 -0700
Message-Id: <20191015181643.6519-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191015181643.6519-1-ebiggers@kernel.org>
References: <20191015181643.6519-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Verify ciphertext for v2 encryption policies that use Adiantum to
encrypt file contents and file names.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/804     | 45 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/804.out | 11 +++++++++++
 tests/generic/group   |  1 +
 3 files changed, 57 insertions(+)
 create mode 100755 tests/generic/804
 create mode 100644 tests/generic/804.out

diff --git a/tests/generic/804 b/tests/generic/804
new file mode 100755
index 00000000..72e7b025
--- /dev/null
+++ b/tests/generic/804
@@ -0,0 +1,45 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Google LLC
+#
+# FS QA Test generic/804
+#
+# Verify ciphertext for v2 encryption policies that use Adiantum to encrypt file
+# contents and file names.
+#
+# This is the same as generic/550, except using v2 policies.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/encrypt
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+# Test both with and without the DIRECT_KEY flag.
+_verify_ciphertext_for_encryption_policy Adiantum Adiantum v2
+_verify_ciphertext_for_encryption_policy Adiantum Adiantum v2 direct
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/804.out b/tests/generic/804.out
new file mode 100644
index 00000000..726376b2
--- /dev/null
+++ b/tests/generic/804.out
@@ -0,0 +1,11 @@
+QA output created by 804
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: Adiantum
+	filenames_encryption_mode: Adiantum
+	options: v2
+
+Verifying ciphertext with parameters:
+	contents_encryption_mode: Adiantum
+	filenames_encryption_mode: Adiantum
+	options: v2 direct
diff --git a/tests/generic/group b/tests/generic/group
index 6f5c15b2..3373980d 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -585,3 +585,4 @@
 801 auto quick encrypt
 802 auto quick encrypt
 803 auto quick encrypt
+804 auto quick encrypt
-- 
2.23.0.700.g56cf767bdb-goog

