Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444524C6C
	for <fstests@vger.kernel.org>; Wed, 26 Mar 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990633; cv=none; b=YU6IE5aw8Bt3UAjJgomOwzAcxWTPxCIUUdkBPrsi7I7d7W71KGCUW5VnnJ914F/ndmCnjeouocR3v+dLFdFvCX8HGZPq1A7ffMITO+6RsVYsaurAH1zzf+zEykM8HJz04SMF/3PwFgEw4TOsBZXEHePDwk2DACflNEOl2pKO0w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990633; c=relaxed/simple;
	bh=Y+epb3NLQIDPGyb4Dk0u1R+/gTlL8sesV7u4E5OVk6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lC5gxNUTPpdUOKXONnoWous2Z2vII1gklKO0apepYg5LtRrFN7gqhsuNAS/ar2hEiqOXHWrYx+J5QaERhpqAmj6sFeRMV7ZowaPpUTJNzMbWCndmjb205jeKWilIFDfBPrf9VarDrxIfU7w/7rfMcCpB/C28pgiminTQYoiT0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf3Y4PfA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf3Y4PfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C04C4CEE2;
	Wed, 26 Mar 2025 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742990631;
	bh=Y+epb3NLQIDPGyb4Dk0u1R+/gTlL8sesV7u4E5OVk6s=;
	h=From:To:Cc:Subject:Date:From;
	b=Cf3Y4PfAO6mQHZ1bcqtJMgZcj6lh+bwCtSFD6EXxixYXhzaqcr9NSxPmFGSOvbXWB
	 SLDEH/64xuO90UU+eSxf6ALJtJFEjbEo7OBTXIrl2uyGbc7n5s4/CgC8+aew7j65F/
	 4/e7V5wvwwr75q5U4l9qFtiEDa9stunuOmymB2D79HjlwBRII0VRvaxeLxwbNGbwup
	 0q7SeurlbgXNtt5l7u9WdK9BzA0K/z+Eq+CuUNRnn/Lw/Q+xdy1ouxH4kDv777INlA
	 RjZewIatkuD3F0MSi8wpd0mKHQOBPwnX5Fp+VctscIH8qYHOHCqi8gL16GpMc/Gw9O
	 gqW8JK+gNsDNA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs/011: test to check out-of-space issue
Date: Wed, 26 Mar 2025 20:03:41 +0800
Message-ID: <20250326120341.3641535-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression testcase to check whether we will handle
out-of-space case correctly during fallocate() on pinned file
once we disable checkpoint.

Testcase:
1. mount f2fs w/ checkpoint=disable option
2. create fragmented file data
3. set flag w/ pinned flag
4. fallocate space for pinned file, expects panic due to running
out of space.

We should apply commit 48ea8b200414 ("f2fs: fix to avoid panic
once fallocation fails for pinfile") to avoid system panic.
Note that it only fix the issue for regular block device, problem
still exist for zoned block device.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/011     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/011.out |  2 ++
 2 files changed, 60 insertions(+)
 create mode 100755 tests/f2fs/011
 create mode 100644 tests/f2fs/011.out

diff --git a/tests/f2fs/011 b/tests/f2fs/011
new file mode 100755
index 00000000..1ece8fd0
--- /dev/null
+++ b/tests/f2fs/011
@@ -0,0 +1,58 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/012
+#
+# This is a regression testcase to check whether we will handle
+# out-of-space case correctly during fallocate() on pinned file
+# once we disable checkpoint.
+# 1. mount f2fs w/ checkpoint=disable option
+# 2. create fragmented file data
+# 3. set flag w/ pinned flag
+# 4. fallocate space for pinned file, expects panic due to running
+# out of space
+# We should apply commit 48ea8b200414 ("f2fs: fix to avoid panic
+# once fallocation fails for pinfile") to avoid system panic.
+# Note that it only fix the issue for regular block device, problem
+# still exist for zoned block device.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
+
+_fixed_by_kernel_commit 48ea8b200414 \
+       "f2fs: fix to avoid panic once fallocation fails for pinfile"
+
+_require_scratch
+_require_command "$F2FS_IO_PROG" f2fs_io
+
+_scratch_mkfs_sized $((1*1024*1024*1024)) >> $seqres.full
+_scratch_mount -o checkpoint=disable:10%
+
+pinfile=$SCRATCH_MNT/file
+
+# simulate fragment status in f2fs
+for ((i=0;i<256;i++)) do
+       dd if=/dev/zero of=$SCRATCH_MNT/$i bs=1M count=1 >>$seqres.full 2>&1
+done
+sync
+
+for ((i=0;i<256;i+=2)) do
+       rm $SCRATCH_MNT/$i >> $seqres.full 2>&1
+done
+sync
+
+touch $pinfile
+$F2FS_IO_PROG pinfile set $pinfile >> $seqres.full
+fallocate -l $((3*256*1024*1024)) $pinfile >> $seqres.full 2>&1
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/011.out b/tests/f2fs/011.out
new file mode 100644
index 00000000..62e02519
--- /dev/null
+++ b/tests/f2fs/011.out
@@ -0,0 +1,2 @@
+QA output created by 011
+Silence is golden
-- 
2.49.0

