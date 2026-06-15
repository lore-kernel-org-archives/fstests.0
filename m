Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781893C344B
	for <fstests@vger.kernel.org>; Mon, 15 Jun 2026 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514321; cv=none; b=PCcugENENOC2ClSkorMLIZD+ubgpI8hffUeNNMoLm6rAnC0+Z8lfj8YN89ZsU3Ef0ZBGsj+L7sK9zA0VwZo6uE3ghbVFiTWCDxR2Z+T4n5kbrjcfYkLEZtzB3G0PiFt05UcID4TIJv9XnmaZIq9uIc0IJqadluM2VsZSIjTrJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514321; c=relaxed/simple;
	bh=HgvlybAV1yE0RyqTOLMsULmNFMhkfyzIWLN+HAHGH8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAlU+MjXAlBsq3Dpg/NLfDz4IWwOaNYfutZnK60sGn78LYzT14z1rKYEkaWs5Zt18cLfrynjGwuRja9cyhCKeputFCJ/0wMpXK2PmtvqAFgabVCXPf2opNk70Sg7GK4lF9mmM2P19zFvLbU9aZP1poSo/hplaNd9r9WcPVQkQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy3KlnaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy3KlnaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7141F00A3E;
	Mon, 15 Jun 2026 09:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781514320;
	bh=ME1/S/TriG2c+6aYaVUnTJ4FsRAfSoAwJMhNU9vY5q0=;
	h=From:To:Cc:Subject:Date;
	b=Iy3KlnaY+JoDT9oIwOkbOkG1wgZ4/G90bC6prgqs/+hmgmo5Z9Od2QEFGxufYzZ+t
	 /6iWxML0VV/Ab9NNJ4S2Mb027ZBYRBY048PG32fu+W3bnuY34kBikual4TnGBz3jZE
	 tRHdrvLW9NCsCg5pWGUQltueLiGjwSlkhSDOo76ugl3t9s7wmoQgXlbJqT7K5acvl4
	 QMyOKQn573pJY10WJZUhwnWImYOpuZCuzTJUxRokF7WIVtzYSEckYc5tJ1F1F+bUmy
	 4+yEV0SagpYcc5JiMfdVVy2H+PVMeKDeN1z3IyBNrB1BfQFdTFzh8wynoIWb8eiF3N
	 fHt3h3g0WSCfg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3] f2fs/025: test to do sanity check section type correctly in f2fs GC
Date: Mon, 15 Jun 2026 09:05:11 +0000
Message-ID: <20260615090511.1626551-1-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without commit 520760b9f915 ("f2fs: optimize representative type determination
in GC"), f2fs GC will report inconsistent segment type in large section issue,
and then it will force to shutdown filesystem.

[  768.190903] F2FS-fs (loop51): Inconsistent segment (3) type [1, 0] in SIT and SSA

The reason is f2fs kernel will assume all segment type inside large section is
the same, during GC it loads type from one segment and compare it to other
segments' type, however due to recovery flow, the chosen segment may has zero
valid blocks w/ different segment type, since the segment is invalid(free) one,
it will never be migrated, so that we should not treat such state as abnormal
condition.

This testcase is created to simulate above condition to see whether f2fs kernel
module can handle it correctly

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- remove unnecessary code
- use common help _scratch_shutdown() instead of "$F2FS_IO_PROG shutdown"
- use $F2FS_IO_PROG gc_urgent" instead of "echo > <sysfs_path>; sleep x" commands
 tests/f2fs/025     | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/025.out |  2 ++
 2 files changed, 83 insertions(+)
 create mode 100644 tests/f2fs/025
 create mode 100644 tests/f2fs/025.out

diff --git a/tests/f2fs/025 b/tests/f2fs/025
new file mode 100644
index 000000000..2327db10b
--- /dev/null
+++ b/tests/f2fs/025
@@ -0,0 +1,81 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Chao Yu <chao@kernel.org>
+#
+# FS QA Test No. f2fs/025
+#
+# Check whether f2fs will encounter cp_error (Inconsistent segment type)
+# when doing sanity check on type of segments inside large section during
+# garbage collection.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_fixed_by_kernel_commit 520760b9f915 \
+	"f2fs: optimize representative type determination in GC"
+
+. ./common/filter
+
+_require_scratch
+_require_scratch_shutdown
+_require_xfs_io_command "pwrite"
+_require_xfs_io_command "truncate"
+_require_command "$F2FS_IO_PROG" f2fs_io
+_require_check_dmesg
+
+# Clear options to avoid interference from external configurations
+export MKFS_OPTIONS=""
+export MOUNT_OPTIONS=""
+
+# Format with 96MB size and 2 segments per section
+_scratch_mkfs_sized $((96 * 1024 * 1024)) "" "-s 2" >> $seqres.full 2>&1
+
+# Mount with mode=lfs
+_scratch_mount -o mode=lfs
+
+# Create files to fill whole filesystem, then segment type will be changed to node type
+for ((i=0;i<5120;i++)) do
+	touch $SCRATCH_MNT/$i >> $seqres.full 2>&1
+done
+sync
+
+# Remove all files to create free(empty) node segments
+rm -f $SCRATCH_MNT/*
+sync
+
+# Allocate free space so that we have chance to reuse free(empty) node segments
+$XFS_IO_PROG -f -c "pwrite -b 4k 0 1928k" $SCRATCH_MNT/file >> $seqres.full 2>&1
+sync
+
+$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
+sync
+
+$XFS_IO_PROG -d -c "pwrite -b 4k 0 8M" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -d -c "pwrite -b 4k 0 32K" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -d -c "pwrite -b 4k 0 2M" -c "fsync" $SCRATCH_MNT/file >> $seqres.full 2>&1
+
+# Shutdown the filesystem without checkpoint
+_scratch_shutdown
+
+_scratch_unmount
+
+_scratch_mount -o mode=lfs
+
+# Run urgent_gc mode to trigger garbage collection
+dev_name=$(_short_dev $SCRATCH_DEV)
+$F2FS_IO_PROG gc_urgent $dev_name run 5 >> $seqres.full
+
+_scratch_unmount
+
+# Check whether the dmesg has the warning indicating the bug
+_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
+	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
+
+echo "Silence is golden"
+_exit 0
diff --git a/tests/f2fs/025.out b/tests/f2fs/025.out
new file mode 100644
index 000000000..3d70951ef
--- /dev/null
+++ b/tests/f2fs/025.out
@@ -0,0 +1,2 @@
+QA output created by 025
+Silence is golden
-- 
2.49.0

