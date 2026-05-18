Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6731E846
	for <fstests@vger.kernel.org>; Mon, 18 May 2026 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099195; cv=none; b=OyV6goof6BhH38Z9bDIiAQOyGNCSlCymjzMtTJnu0WtgcrczcLXludNMG5GonrKSRqtC2oHSr9lwgWD9jGmi0eFIK9pPHe2kChoDwvQd/IOxJL5q+f4CUnRDWj/2p15HYbkp2RsSxB2zIS5ISRUWxw3I6LylOSuDPBn0NhKKDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099195; c=relaxed/simple;
	bh=4X1McEd5eVxfLzKIoES+zNc8qiIg/c8YVdL/tToqksQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ei3BI1C0Ae4peuRcKUfXb10EohuipIpG4/rWWBaV59zt6dljwjSNTjRMgsoERgSz+e2cLk6qkKHc1tqTwsdFEvOABXzQ5yEXkNXjN1HGJtxwoZygYTaCTymbV5V0UjSpxeqo3bEqucw3Sn2FHhMbIxyyZdp3/6fPsNUHKOT/wjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK6oGDez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK6oGDez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD28FC2BCF5;
	Mon, 18 May 2026 10:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779099194;
	bh=4X1McEd5eVxfLzKIoES+zNc8qiIg/c8YVdL/tToqksQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lK6oGDezHjX3WJBBMTcITOmeiR39nGhQxrP8y6+Vxx88LUetKTYQYb36M5wY1P/LX
	 sQCOQtDv7lbcMBuvHOn0cBrietvJYMXjVPnoU62Eg88OqbL24pFYqC5tvm0BkIJ1HO
	 xyqx4ERqBHWFzTyVmuxY6y+XfXQSmuBx6wvZkmOjWwSiQq16k5AMK9vAF+e3fZalR5
	 Jza8ZnslqISlF9sxEujRrIYvtiZOxyixnvjLvRhoO+fC8LPzyy12p723/yyvNVo2lo
	 zZwba6KAmmVCSFvKhyfnIg4Cg0N6lwyoP9R/LvAnintv7Mzaly70l0LIT9dx011Ffz
	 cHUEn1cEYKZlw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	jprusakowski@google.com,
	joannechien@google.com,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs/025: test to do sanity check section type correctly in f2fs GC
Date: Mon, 18 May 2026 18:12:52 +0800
Message-ID: <20260518101252.445214-1-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
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
 tests/f2fs/025     | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/025.out |  2 ++
 2 files changed, 90 insertions(+)
 create mode 100644 tests/f2fs/025
 create mode 100644 tests/f2fs/025.out

diff --git a/tests/f2fs/025 b/tests/f2fs/025
new file mode 100644
index 00000000..1eba7158
--- /dev/null
+++ b/tests/f2fs/025
@@ -0,0 +1,88 @@
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
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
+
+_require_scratch
+_require_xfs_io_command "pwrite"
+_require_xfs_io_command "truncate"
+_require_command "$F2FS_IO_PROG" f2fs_io
+_require_check_dmesg
+
+# Format with 96MB size and 2 segments per section
+_scratch_mkfs_sized $((96 * 1024 * 1024)) "" "-s 2" >> $seqres.full 2>&1
+
+# Mount with mode=lfs
+_scratch_mount -o mode=lfs >> $seqres.full 2>&1
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
+$F2FS_IO_PROG shutdown 2 $SCRATCH_MNT >> $seqres.full 2>&1
+
+_scratch_unmount >> $seqres.full 2>&1
+
+_scratch_mount -o mode=lfs >> $seqres.full 2>&1
+
+# Run urgent_gc mode to trigger garbage collection
+dev_name=$(_short_dev $SCRATCH_DEV)
+if [ -f /sys/fs/f2fs/$dev_name/gc_urgent ]; then
+	echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent
+fi
+
+# Wait background GC thread to wake up to run and potentially encounter the inconsistency
+sleep 5
+
+_scratch_unmount >> $seqres.full 2>&1
+
+# Check whether the dmesg has the warning indicating the bug
+_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
+	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/f2fs/025.out b/tests/f2fs/025.out
new file mode 100644
index 00000000..3d70951e
--- /dev/null
+++ b/tests/f2fs/025.out
@@ -0,0 +1,2 @@
+QA output created by 025
+Silence is golden
-- 
2.49.0

