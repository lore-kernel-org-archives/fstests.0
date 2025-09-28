Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C1220F29
	for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049581; cv=none; b=nHN9+b6wxRM+cJtK9O0yL1KGxhpO8xlrZHiqKQ/Yh6KEdMHf9ErgOrizwW0PnF8gpay6n5EmPratHyRmAg1LluvdF5Fm+YlSVRHBrtp8m5Pt+RUIag5Ujx44VNLnwUl0dmGmrYz5Fr50Z/cmktotBJ/Ylub5xjguJRZrjz96Rak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049581; c=relaxed/simple;
	bh=5nUj7RWeOwj694q2m5C7FBsq7V+t+XNUadgoVrwldWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H7zuqYhMii7P88ZSK+3k8lz1vc37q36fmFlmbH7bOKPms/dOntdSC2UyApIVWv8Ok9fthx6kbHbsJ5vbkkoQkbiMjf/8OSxpLYxdSHM9no2MUwpLuG15rmjlPKGeHNu5X4IcAFiZdVm9lRe2lvwy59Wtf191yOhJca0WB354qFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qizxVdi6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qizxVdi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CECC4CEF0;
	Sun, 28 Sep 2025 08:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759049580;
	bh=5nUj7RWeOwj694q2m5C7FBsq7V+t+XNUadgoVrwldWo=;
	h=From:To:Cc:Subject:Date:From;
	b=qizxVdi6JS6kzNnRDXc7YDA1cfMhumLgG1A8pX2tEeV63CvOU0msO55iPkHR4XkDQ
	 t2jqGFXL1YCpihSRZORQOKoANvVwJ2rs/lIo2olis3FT/kK/l3k9tPIXgi286eBgEq
	 eTpQuvN/ACj5Z6O4P3miZ3P/+qJDy+1BiLQDFGgWgFyo6j3PDtRQqwosSriW2+shUX
	 Jkasm03tuPkHuQYUvYTtILFTs67aASnyiQIMwkUop3+bwo86NjCytKNGL0ClUeJN2i
	 NP+VqqMOj+RVn5Z4SoIcxuhSrNVxYN9WKRKlHmkLOujOZtw1DGeL8srHuXdRSonWz7
	 QdDYkF15etkDg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2 1/2] f2fs/021: test quota mount option
Date: Sun, 28 Sep 2025 16:34:41 +0800
Message-Id: <20250928083442.7955-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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
v2:
- add the testcase to 'quota' and 'remount' group
- add reviewed-by tag from Zorro
 tests/f2fs/021     | 30 ++++++++++++++++++++++++++++++
 tests/f2fs/021.out |  2 ++
 2 files changed, 32 insertions(+)
 create mode 100755 tests/f2fs/021
 create mode 100644 tests/f2fs/021.out

diff --git a/tests/f2fs/021 b/tests/f2fs/021
new file mode 100755
index 00000000..96fc97c4
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
+_fixed_by_kernel_commit xxxxxxxxxxxx \
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
2.40.1

