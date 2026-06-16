Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9AC30D3FA
	for <fstests@vger.kernel.org>; Tue, 16 Jun 2026 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595336; cv=none; b=YY5Z4NpVWxuP88YbiDps+pzO/Txp70WN4fBu2ZqQsUAVXHxC5rPTranlzX8lxfU7eJIbXhY2TsmN4luD3DSrPR9goywLg33XyYpUndUVz+HBiG7YMQDY+9wgP0aO6ae85lMI+EucBnzr3CzB3BV1/YfatIeHbqi675LCkJPiY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595336; c=relaxed/simple;
	bh=m/601xyDY7h8WhzWGfJaBnM8A5/xZE+Vq9YbnKojMBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxpqNLdo3QiGTHFxMN6bdSdV1jafUoFhJyJvYfHsz4obwwFES5fLc8Cj1X8z6k/Ebn4l6eooOXcMm3voDkIw0nSqrAL3RkdfJV46fhYHQmdP7huJ4xSKeCUSbn8TDgfArNMLh/99Ci2XSsmNdfrXcN0WXOzfuVO+RdtitjaT85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROWIjque; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROWIjque"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A63C1F000E9;
	Tue, 16 Jun 2026 07:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781595334;
	bh=5OqYq3CVAUbXgmqfvSQEnxITdTEtIh1tw62VVnP96dQ=;
	h=From:To:Cc:Subject:Date;
	b=ROWIjqueRKTV4h2kfEPmCmyeoVPe/iCFmD6Mj/he2cqECD6xqkHSqfh+nDnWaj0FQ
	 0Y6D2/d8liNox9Bil0zXBJEKq5lk3WNcg/hOAEuqguk6fIk6qbl6VIvr8JX+5kVtbN
	 G7EBHn2A3EBBl15QolVvbSC2ydpXoSCi6Gqewk9DS9jUIZSbpwP0sXksB3i/tae9rg
	 AHz0O1fBOgIerEX/rXvvcWbMiiJ0y/tjMiMMZrMFK6bEn4cAmgA5PHsn/ZPNEmRiqW
	 U76sXPk0W/Nu4LoUWo84KL/Xl+KEeUUKoBf3jd/dPstFZoK4tN+ms1pjuoTxzjrf8q
	 OHgMjsUAp1DIw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4] f2fs/025: test to do sanity check section type correctly in f2fs GC
Date: Tue, 16 Jun 2026 07:35:26 +0000
Message-ID: <20260616073526.2967012-1-chao@kernel.org>
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
v4:
- add missing "_require_fs_sysfs_attr $TEST_DEV gc_urgent"
 tests/f2fs/025     | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/025.out |  2 ++
 2 files changed, 84 insertions(+)
 create mode 100755 tests/f2fs/025
 create mode 100644 tests/f2fs/025.out

diff --git a/tests/f2fs/025 b/tests/f2fs/025
new file mode 100755
index 000000000..807f18f23
--- /dev/null
+++ b/tests/f2fs/025
@@ -0,0 +1,82 @@
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
+_require_fs_sysfs_attr $TEST_DEV gc_urgent
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

