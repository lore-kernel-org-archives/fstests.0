Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951411F1537
	for <fstests@vger.kernel.org>; Mon,  1 Sep 2025 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692221; cv=none; b=s99KgDMMtDuhzo291FyvQobo72nr3px+A4EsaPuBLROs/fLuk8RW1pN2LzjOwQDS7mfndb3/orrZ3Utf8EH7yVlQ1nLu3rfsdYoTaZ67DaKQSnlizyDc+hnXIWYUssLOx80qu6ah62HFGOnKnvUCocr34tmkfchgPNT0DfGeYXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692221; c=relaxed/simple;
	bh=iLG451+50P0EKs0JV6qN5ndqwtac3Z7TuRAjBMlTWo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofgblNpmacR0vcM0yl7c0ucYOu86Sx18b0OSnzu2wlobX4OHS8IRMWRjiN9FyDdTfOoKQlwVLA1QENJHuH6Wlx/TYgL/3Et2aCQyccihfj3/SFq57wITFdUCzmeTV4JlFgyE/P54LdhPBXX857OjvodvqsD2OV8Rqha0OSlM1Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfT01AdP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfT01AdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F2FC4CEED;
	Mon,  1 Sep 2025 02:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756692221;
	bh=iLG451+50P0EKs0JV6qN5ndqwtac3Z7TuRAjBMlTWo0=;
	h=From:To:Cc:Subject:Date:From;
	b=gfT01AdPjt+T6zSrdukdX7IBclha5JM5dCRVM2zGdzkPUEXK8AaNtxFSTgPWIlLPx
	 w628vmZeyZh0tOGf3zOjvyfmZ8Ss07SuTs+TwYz6Vq9c61Y/ZiD0t66FP2taqzQ71a
	 L6+xqluuuZ9RvCe5eSpbdY8iFTCFEln+Wae0GMXn1OTVGhN5LB7OaFso27TBJU/L1K
	 iFNK0vWFcnFBVqPZjKYyf4+VpDcnJZyPJ3bUREqw3BYID/BTLEXweFixAz3NwAffsc
	 APcwcQqp6r6Q2ZWebS1j/2B34NgU+XdIIee8mSBn2oCiRGGffHrEVUw2OptjzsLRYT
	 Uc3fXyJvS9k4w==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs/021: test quota mount option
Date: Mon,  1 Sep 2025 10:03:30 +0800
Message-ID: <20250901020331.2171502-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
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
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/021     | 30 ++++++++++++++++++++++++++++++
 tests/f2fs/021.out |  2 ++
 2 files changed, 32 insertions(+)
 create mode 100755 tests/f2fs/021
 create mode 100644 tests/f2fs/021.out

diff --git a/tests/f2fs/021 b/tests/f2fs/021
new file mode 100755
index 00000000..c41760fc
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
+_begin_fstest auto quick mount
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
2.49.0

