Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FDA5474F
	for <fstests@vger.kernel.org>; Fri, 12 Jun 2026 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225895; cv=none; b=NlJx0JuLrhtrUJ3422cVeG/WxTQzlD0fH4bvxdusSp6CV8tbA5Wsdn8Y9STevyV0F0rd5Ki2y4s6UoyB7L0Umtyi8cNbaIaSdcQj/OlO/yNWsd5usQDdl+P4rLk+D1zGily0Sy6iKsDpp6yR2USVKE/NqOpmCiULsNuTI9LdeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225895; c=relaxed/simple;
	bh=A2jvrneakaxB27rewBPC4T4ivkSBJQt2om3kFnUP2Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glbPIZCY9I4GM0ki37SFpJv8R8/P/Dh/6W0qUT1yK4POwgfOnZrD4M70MwRtp9+F8bi/VIPT0dzmspVpBprsA4Ye995FMgTLDpjJIwQG5IpNZpaGcjpSIeEZ1dgFvRbcPkPWcosWGQE7onTluTx/bwBDFYcZKueMCFO/VDEfhIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow1Qfz75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow1Qfz75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF5F1F000E9;
	Fri, 12 Jun 2026 00:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781225894;
	bh=dfDy9y8MBcN9aGZ/09GVmidJB5V72Rd2TakHFbjxYVY=;
	h=From:To:Cc:Subject:Date;
	b=Ow1Qfz75tjysrFCLg+o1ySUv653ohSHYqixOQmVd4/6dlpLjxf6bBSB65grSS+NM8
	 VfjgaZHH7rzwEOxRsqwmJnoPr6unS+qAQSHWDT54hLczUOaPmH50dWQKurelYxo6ei
	 pyUjVkhylwTKR2O+f3WoGvqr8UPmbcryn6vhyxsCYxEMYUmEV8GEidSzFGGmHouonR
	 hts6gmLdaYKUcYCd+3dvzRuUsjvefgxYzcYcTCfsxjMt9d/jnYK1NpTaay7Sh+Vzi1
	 Ap0KzyGtB4mbSKaeq5WcCcPyDMKklQj9BfDXcL1BPfSB6zW1UNz7EoDmgCdd356ZJC
	 BOZFRXT2LiUwg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs/025: test to do sanity check section type correctly in f2fs GC
Date: Fri, 12 Jun 2026 00:58:02 +0000
Message-ID: <20260612005802.3017709-1-chao@kernel.org>
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
v2:
- clear MKFS_OPTIONS and MOUNT_OPTIONS to guarantee block allocation is as expected.
 tests/f2fs/025     | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/025.out |  2 +
 2 files changed, 94 insertions(+)
 create mode 100644 tests/f2fs/025
 create mode 100644 tests/f2fs/025.out

diff --git a/tests/f2fs/025 b/tests/f2fs/025
new file mode 100644
index 000000000..397e5439a
--- /dev/null
+++ b/tests/f2fs/025
@@ -0,0 +1,92 @@
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
+# Clear options to avoid interference from external configurations
+export MKFS_OPTIONS=""
+export MOUNT_OPTIONS=""
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
index 000000000..3d70951ef
--- /dev/null
+++ b/tests/f2fs/025.out
@@ -0,0 +1,2 @@
+QA output created by 025
+Silence is golden
-- 
2.49.0

