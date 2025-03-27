Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B451BC3C
	for <fstests@vger.kernel.org>; Thu, 27 Mar 2025 05:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743054709; cv=none; b=oR9dA+Vi3JB2yxaq/8lX3lCK/+Xj6zV1We1oM4fG55qjVy9YRITjirDEnyXhkF95TAefQkvYNCgm/2sQIer7RitBB4s5U70gyngF/h7el+wbwtbVx+eVIhTX5rmY2EjD5kUKBlEJm+ywDzcyVoapeZix+56rYc92ALf9DPEnF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743054709; c=relaxed/simple;
	bh=SJIyKCRKFBYowD/M/cJu/HYSC7rzw8jixMT6n76IJts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hgixwQJC4m01TzBmW7wl+giw8gMVxl9DF5Pds/5nZcuvCvBOVV1jdKo8inqSdhCQ4PT7K3+OG4diufOcylh9tx8bgwxKHHL7aLAhN+8p5dzcZobiAq1e2groORtc1XjDkhZ7OcMIy0VPxBDSqT01IZLyRiqr68oCXC5vJi22OM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icW0DUIe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icW0DUIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD75C4CEDD;
	Thu, 27 Mar 2025 05:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743054708;
	bh=SJIyKCRKFBYowD/M/cJu/HYSC7rzw8jixMT6n76IJts=;
	h=From:To:Cc:Subject:Date:From;
	b=icW0DUIeUcDUPNCt+txYgmrjj68MKU+PGnynOBnMPrzWMh9u+IdyHb1ouNMsYShXe
	 Hv0JPJho2HnxL21A3jcV0lhBM+KKPb107Tvvj//tyAIoELBed7teGwdkzMdSFdg97g
	 Sps6LxcfrzzHAmeEuS9K8iF/5uT6hjvkouyvzzMvCmeMg4slnrGQt4gk94zkZ6A+8e
	 yaXPDTLDqlYOb+eKLOBvY1Q8O9ebPmgJ99SNJ6XtXPg14X/jtNi4c0/L+NMs4+A+Am
	 JEUgkQLMCA4NiASmFxf4KnYwoBCx5C73f8lRJzN1YyuSrQLmXzI5xGDV/QNcqtO30b
	 n3m205FppsSfg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs/011: test to check out-of-space issue
Date: Thu, 27 Mar 2025 13:50:51 +0800
Message-ID: <20250327055051.3827735-1-chao@kernel.org>
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

We should apply both commit ("f2fs: fix to avoid panic once
fallocation fails for pinfile") and commit ("f2fs: fix to avoid
running out of free segments") to avoid system panic.
Note that w/ these two commit, we fixed such issue in both
convential and zoned block device.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- clean up codes suggested by Zorro
- change output to expect ENOSPC error if we have applied fixes
 tests/f2fs/011     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/011.out |  2 ++
 2 files changed, 55 insertions(+)
 create mode 100755 tests/f2fs/011
 create mode 100644 tests/f2fs/011.out

diff --git a/tests/f2fs/011 b/tests/f2fs/011
new file mode 100755
index 00000000..ec3d39ec
--- /dev/null
+++ b/tests/f2fs/011
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/011
+#
+# This is a regression testcase to check whether we will handle
+# out-of-space case correctly during fallocate() on pinned file
+# once we disable checkpoint.
+# 1. mount f2fs w/ checkpoint=disable option
+# 2. create fragmented file data
+# 3. set flag w/ pinned flag
+# 4. fallocate space for pinned file, expects panic due to running
+# out of space
+# We should apply both commit ("f2fs: fix to avoid panic once
+# fallocation fails for pinfile") and commit ("f2fs: fix to avoid
+# running out of free segments") to avoid system panic.
+# Note that w/ these two commit, we fixed such issue in both
+# convential and zoned block device.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_fixed_by_kernel_commit 48ea8b200414 \
+	"f2fs: fix to avoid panic once fallocation fails for pinfile"
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"f2fs: fix to avoid running out of free segments"
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
+	$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/$i >>$seqres.full
+done
+sync
+
+for ((i=0;i<256;i+=2)) do
+	rm -f $SCRATCH_MNT/$i
+done
+sync
+
+touch $pinfile
+$F2FS_IO_PROG pinfile set $pinfile >> $seqres.full
+$XFS_IO_PROG -c "falloc 0 $((3*256*1024*1024))" $pinfile
+
+status=0
+exit
diff --git a/tests/f2fs/011.out b/tests/f2fs/011.out
new file mode 100644
index 00000000..559c3fdf
--- /dev/null
+++ b/tests/f2fs/011.out
@@ -0,0 +1,2 @@
+QA output created by 011
+fallocate: No space left on device
-- 
2.49.0

