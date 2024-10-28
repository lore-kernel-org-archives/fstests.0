Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486891DACAA
	for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125088; cv=none; b=G7+cpkvV9oyQeMR+uebW/LkhUJ0FDEQSKslcJS+Vb9RfrJ1wxOqJQCRx9t+F3mrbrLYi8C0tnTLMjqLGIcH3+6qdESs1WERl1EXFtTFxNu21VyANBjl6kmid+/913isQccRp7BBGji87lkeqgpjGxaddqBMrstJ6kWoGTwCqcOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125088; c=relaxed/simple;
	bh=jvqQdl9HZD/pH/4UAiAhbo9OsbYYJlAiRgfGwYEGkx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oV/9xm16WJ7EDajqaALlnU2ji1zQrMFMkNDXW+tdiu6TZglC+zRbgqR+Jnko7agJl8vIyo9awfe1QBHuIWy4ibAlFOVGjjTq0AsrI6yY+5RFG5Yij+cZUHzEcNhnUFUDZHshLsqIse9LkdLnYuFrg7cyQRNVTtLcNouqrMDtBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PudvG3o2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PudvG3o2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921EAC4CEC3;
	Mon, 28 Oct 2024 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125087;
	bh=jvqQdl9HZD/pH/4UAiAhbo9OsbYYJlAiRgfGwYEGkx4=;
	h=From:To:Cc:Subject:Date:From;
	b=PudvG3o2Xqd1/ze1jfS/MLnDdG1eCIMwWmKr8otq6bRjpgbayf+plQn48t0RzS4gr
	 kFjAyX1WZjekmUHivtqfmaLN/gKoA2AMzNq/y4HyNxXOAAFJlxgni4REUdOu9/m/Bu
	 eFkslIoO5Ysagg8PNqjT7XiKl5MHzUNic/i2Dg+fQh9QNaLurdu+YFh2H3UQwZeXZ+
	 Bs/7esRkNfuGZ0LC/Jhxt26TO3siqBZiahaaKGCPIlHL1Atu5CPQJbTPfO4oiHv4SH
	 HcVjzvyHNG8+WIQ2qi+YWcZL+00lDA3cmr++h1GEzZMcVN2ANXP1h1gX4bX/Fe2CDP
	 O6CelV1XQbbFw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3 1/2] f2fs/006: add testcase to check out-of-space case
Date: Mon, 28 Oct 2024 22:17:59 +0800
Message-Id: <20241028141800.1788356-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression test to check whether f2fs handles dirty
data correctly when checkpoint is disabled, if lfs mode is on,
it will trigger OPU for all overwritten data, this will cost
free segments, so f2fs must account overwritten data as OPU
data when calculating free space, otherwise, it may run out
of free segments in f2fs' allocation function. If kernel config
CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
dd may encounter I/O error.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- explain more about behavior on kernel w/ different config
- use _filter_scratch to filter $SCRATCH_MNT
 tests/f2fs/006     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/006.out |  6 ++++++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/f2fs/006
 create mode 100644 tests/f2fs/006.out

diff --git a/tests/f2fs/006 b/tests/f2fs/006
new file mode 100755
index 00000000..f9560b2b
--- /dev/null
+++ b/tests/f2fs/006
@@ -0,0 +1,42 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oppo.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/006
+#
+# This is a regression test to check whether f2fs handles dirty
+# data correctly when checkpoint is disabled, if lfs mode is on,
+# it will trigger OPU for all overwritten data, this will cost
+# free segments, so f2fs must account overwritten data as OPU
+# data when calculating free space, otherwise, it may run out
+# of free segments in f2fs' allocation function. If kernel config
+# CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
+# dd may encounter I/O error.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"f2fs: fix to account dirty data in __get_secs_required()"
+
+# Import common functions.
+. ./common/filter
+
+_require_scratch
+_scratch_mkfs_sized $((1024*1024*100)) >> $seqres.full
+
+# use mode=lfs to let f2fs always triggers OPU
+_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
+
+testfile=$SCRATCH_MNT/testfile
+
+dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
+
+# it may run out of free space of f2fs and hang kernel
+dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
+dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync 2>&1 | _filter_scratch
+
+_scratch_remount checkpoint=enable
+
+status=0
+exit
diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
new file mode 100644
index 00000000..2dc9efda
--- /dev/null
+++ b/tests/f2fs/006.out
@@ -0,0 +1,6 @@
+QA output created by 006
+50+0 records in
+50+0 records out
+dd: error writing 'SCRATCH_MNT/testfile': No space left on device
+3+0 records in
+2+0 records out
-- 
2.40.1

