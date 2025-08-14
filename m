Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F42F5335
	for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162444; cv=none; b=XO0hfNimV6iACgKXEJxf3PGiLxJgAX3DK/sKTQpf2/6XEKBVgVe7dQ544c0tBqIToEGGu16CyuOz4YKwLFnLBAeMmrN10nI4WFdrgc/dpaUTU8S7uTn09OCQ2mBQ8IYSjLvg0YDsdykKmVOsVdwXYU4kQSggj8XNPdUsielaWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162444; c=relaxed/simple;
	bh=BMt14Ouhem/YVIZtdH4icYSRSHB9L6eLuI2xQCZ3bPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aStw+xtkh+rQOHcySgQctaat++j9ecDVvMHByFKS60ZGb5VUF/7jqdySJIz/S3CJ+J9RfH5i2b8XWRgmvq2yKiuLx3ZvfRRBqKvJlm07ombJULg8TpqL/dtgQpFbWe30ZEx6CuP8u+VkkqZB6yhiqp2u0ocjcEofBryOY/cb5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXOKoYgI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXOKoYgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B16AC4CEF6;
	Thu, 14 Aug 2025 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162444;
	bh=BMt14Ouhem/YVIZtdH4icYSRSHB9L6eLuI2xQCZ3bPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXOKoYgIvwHM0hePoesX3MwJcQ2y0mMGYJIhJiTpbMvdv3Ppy6L1WL5xQLv3lBnf3
	 vHRIwH8GLEi/2Nr+VAA2wVR2sOi6DswaUQ44vJZSTOU4XcgDWcUQ0X7yqpEwVWDGPT
	 uxQMGXg1Lj1uJsVUBqjNuZIcIDnxYHJYitRd2eAashFSelIa1xZb/Yl+mW3dTQEO0O
	 PuthbekUty5qLbKoUd0c98MmR9vpHEFyud65jc5PN2+QdmhivIQIpgy15oXliq1iOd
	 0rLow11T5kgs9oDstzI15JlhhxwEk+4C6131M3bkIAbw2gg1ZEMYGCDNpr4c1rEyjF
	 BpQk4bpDlAbaw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/3] f2fs/019: do sanity check on mapping table
Date: Thu, 14 Aug 2025 17:07:11 +0800
Message-ID: <20250814090712.2119455-2-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
In-Reply-To: <20250814090712.2119455-1-chao@kernel.org>
References: <20250814090712.2119455-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression test:
1. create a file
2. write file to create a direct node at special offset
3. use inject.f2fs to inject nid of direct node w/ ino of the inode
4. check whether f2fs kernel module will detect and report such
   corruption in the fil

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- use _require_scratch_nocheck instead of _require_scratch
- use $XFS_IO_PROG instead of xfs_io
- add comments for why exporting MKFS_OPTIONS=""
 tests/f2fs/019     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/019.out |  2 ++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/f2fs/019
 create mode 100644 tests/f2fs/019.out

diff --git a/tests/f2fs/019 b/tests/f2fs/019
new file mode 100755
index 00000000..2307bd96
--- /dev/null
+++ b/tests/f2fs/019
@@ -0,0 +1,42 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/019
+#
+# This is a regression test:
+# 1. create a file
+# 2. write file to create a direct node at special offset
+# 3. use inject.f2fs to inject nid of direct node w/ ino of the inode
+# 4. check whether f2fs kernel module will detect and report such
+#    corruption in the file
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+_fixed_by_kernel_commit 77de19b6867f \
+	"f2fs: fix to avoid out-of-boundary access in dnode page"
+
+_require_scratch_nocheck
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+
+# remove all mkfs options to avoid layout change of on-disk inode
+export MKFS_OPTIONS=""
+
+testfile=$SCRATCH_MNT/testfile
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+$XFS_IO_PROG -f -c "pwrite 3738M 1M" -c "fsync" $testfile >> $seqres.full
+
+_scratch_unmount
+
+$F2FS_INJECT_PROG --node --mb addr --nid 5 --idx 937 --val 4 $SCRATCH_DEV >> $seqres.full
+
+_scratch_mount
+$XFS_IO_PROG -c "pread 3700M 40M" $testfile
+_scratch_unmount
+
+status=0
+exit
diff --git a/tests/f2fs/019.out b/tests/f2fs/019.out
new file mode 100644
index 00000000..2f7469e2
--- /dev/null
+++ b/tests/f2fs/019.out
@@ -0,0 +1,2 @@
+QA output created by 019
+pread: Structure needs cleaning
-- 
2.49.0

