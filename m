Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248CF19D087
	for <fstests@vger.kernel.org>; Sat, 11 Oct 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760172466; cv=none; b=DlZyK86al7JGDNDqitO6aUSGA5beYzJL72YFo1eTzqfSPlWr/4iASRJgBRK1KhYAQ94j7MB1HO1mW+PsOaqrSRg0pZiOOTVFqpwwWybzD262B2HWulHkMd+c6ulqIetCSRkqQwrj2AuXu1pxYL3KmdkN44LYxsxrMj/6a4mcL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760172466; c=relaxed/simple;
	bh=aRNDBJua0KIErd1NGeJk/Hz4Ic8lmnWSBxatZx+CVco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARpxQRWIToaqnu3BXItVPZbfZoEc8iJM+neWaA47KxShcldnXpQQNl/Ee+IG7Q1BWe41MHK94nldkpp3dd/lFKN8z8EZq/ADsnAJoX+Z2djtfentViAWy+hW8K6RzWMVZjf57F0Mbpwt2vQ9xGqRwoZb94O3E0miAD8i23rcEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1W8CEDx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1W8CEDx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C42EC4CEF4;
	Sat, 11 Oct 2025 08:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760172465;
	bh=aRNDBJua0KIErd1NGeJk/Hz4Ic8lmnWSBxatZx+CVco=;
	h=From:To:Cc:Subject:Date:From;
	b=a1W8CEDxoycZgvWvdBImT6QszjDnFEYM0bZoSPAy32np1+HAovV03vcKHJgyiF9BH
	 C+ioMgpMz4GZUI/sMeK/NEn05AUT53SpZLEYU9+NAEN0te7gU0Enstj2ffOl13B+FW
	 aO52CJVtVE3Gfk3hGB/+GcANmxT8/AxtZ13/8Q3tFgUAn9+sACeYEsknkdmpDWTfV3
	 HIq4cTDcaIVUXv6iKIAfu+EKd6CQpZpfAHCU9Ukdn2ZFJcHOMkCgXIjpGxlw6h82Tr
	 Wlh+lhStK8hhiffNj1JvOkXAesmt6Hzdct8m6gZk0BL+wETcRz6SfvixVxiR/vBMM2
	 HLdcUAMAhxjZw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3 1/2] f2fs/021: test quota mount option
Date: Sat, 11 Oct 2025 16:47:14 +0800
Message-ID: <20251011084715.608562-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This testcase tries to check whether f2fs can handle "usrjquota="
during remount correctly, it expects kernel will encounter NULL
pointer dereference bug w/o the fix ("f2fs: fix to avoid NULL pointer
dereference in f2fs_check_quota_consistency()").

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- update commit id in _fixed_by_kernel_commit line
 tests/f2fs/021     | 30 ++++++++++++++++++++++++++++++
 tests/f2fs/021.out |  2 ++
 2 files changed, 32 insertions(+)
 create mode 100755 tests/f2fs/021
 create mode 100644 tests/f2fs/021.out

diff --git a/tests/f2fs/021 b/tests/f2fs/021
new file mode 100755
index 00000000..0cacb138
--- /dev/null
+++ b/tests/f2fs/021
@@ -0,0 +1,30 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/021
+#
+# This testcase tries to check whether f2fs can handle "usrjquota="
+# during remount correctly
+#
+. ./common/preamble
+_begin_fstest auto quick mount quota remount
+
+_fixed_by_kernel_commit 930a9a6ee8e7 \
+	"f2fs: fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()"
+
+_require_scratch
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount "-o usrquota"
+quotacheck -uc $SCRATCH_MNT
+_scratch_unmount
+
+_scratch_mount "-o usrjquota=aquota.user,jqfmt=vfsold"
+_scratch_mount "-o remount,usrjquota=,jqfmt=vfsold"
+_scratch_unmount
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/021.out b/tests/f2fs/021.out
new file mode 100644
index 00000000..09f4062d
--- /dev/null
+++ b/tests/f2fs/021.out
@@ -0,0 +1,2 @@
+QA output created by 021
+Silence is golden
-- 
2.49.0

