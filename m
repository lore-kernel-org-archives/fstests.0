Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519417A2FC
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245654; cv=none; b=huwhhL7+j/EcGDJBd+xFRbqA//4niOJBLaiUIS9p32FfsFkiQP8uSr8RAzKYsonuiuAtuNIeXEUZxLAVnwaPfiDUXwjrLLvqCW31eunI/g2HgnfWXFOTzyGT2TLXGxXfCnk6VX19XrJu1edxgW6nu5iLQqBnJmuGB/KA2U8v/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245654; c=relaxed/simple;
	bh=Jk/PTYM7LNHgvScV6Rq83FBn8mQ58k5htqZ0llO0bwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgIKUDCkQRbI0Lyo0CarCKN0hHaYK8N/E3wI52Q4c+jfgowILY1kuQvT+o0pO9mRfkJDPmagM9egoDBLaqZwR4Hfu+kw2ehkIzqwpEVqwxPD60ZF/wTpxuUvEtsvwtQzYAmfd1P+noCGjZ78nlnF5ux+dVsP2UvpmEd+zRsaTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtFBOFoz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtFBOFoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC36BC4CEF5;
	Fri, 15 Aug 2025 08:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755245654;
	bh=Jk/PTYM7LNHgvScV6Rq83FBn8mQ58k5htqZ0llO0bwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtFBOFoz0V5PbxV/gvJuuIikz2CQBu4kQvyZMmnZmFrBPbaahuDX0IIsj8WW+Assq
	 T1EwWWWbe2ni+8mBaqW1IGdmozlEMe6FK3Yurx5lXrINj+zMr1ECWtNkrqC9B3XYXL
	 4XSH0P0X55dUyr9gm95PT8ZMt8ZgjMFv0woPgxtqHkbgZiZkt9E07boeMH2FERLHtd
	 B2YsF7fTEKP3rnPeCiqr5DF/8v3zAzq5Ge9GCUgU0e78adyAudJM6VmK3Tiox1L5fi
	 hMo/k0E6Rvh5GZgUYjfH0dmzGfpb/PnOs48bZ/7T9S4FuaiDejOfM6emaIpilciWmN
	 MFmaAKvG0FkNw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3 2/3] f2fs/019: do sanity check on mapping table
Date: Fri, 15 Aug 2025 16:14:04 +0800
Message-ID: <20250815081405.2523015-2-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250815081405.2523015-1-chao@kernel.org>
References: <20250815081405.2523015-1-chao@kernel.org>
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
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add RVB tag from Zorro
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

