Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0C1FF5E3
	for <fstests@vger.kernel.org>; Fri,  9 May 2025 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746770893; cv=none; b=Foy6EJ2I43xzhfeNOeO7dn2TEe1xF27qlXaWEsh93N28VRqSvClsAFpnac74A/icYvT1vmQu1WSrYZHfs6IxVZKvEuw99gUCT00WABepxbmH/0b7PUOdGd1xkAEF9bK7DMtKnAvtQC4uF6QXHyrAGfLoRaGj2zBKtg/yat4iv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746770893; c=relaxed/simple;
	bh=naHAN4PuFoyYOjUDd/vVoVDZ1KAERgLaEoZdCCJbCYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BL5HyMYWnHRsmCLMSdgPFbWPxcQp7QyfGuCZj8gBQMfRh0uEqOvb30DZtsyXF5HcBCpF/RB0Cr/bGoyHt5FLljbgbNOuVZlFd+CvLxKEvaVb/CPngfyhkcDAR49akzqaD/KkPooEIAS1LcmxJspKiRo0Jou5ekcMFoXosy7Rng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPVKf9hn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPVKf9hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C6BC4CEE4;
	Fri,  9 May 2025 06:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746770892;
	bh=naHAN4PuFoyYOjUDd/vVoVDZ1KAERgLaEoZdCCJbCYs=;
	h=From:To:Cc:Subject:Date:From;
	b=kPVKf9hn2R9xC7m4ajHhi6KCFS1/amjw0cms0yrin6sJv7R2KmxbQEAGpNtXuAYOd
	 lXd77g05+6O0Lr6PhbpmhMGwG6ICNqIL2WUZQ5tZxEN+nHN0rWuMvqc45/y7vRQUN3
	 W9lTAZdEzeYDoMp9kOnfO+7mPsRhQaewFXNAOKTMQmDtxz4noa3EjX+Ee/KjjgRSTw
	 tHJ7rNzUv2+Tzwg/Qbyz2+a1u0vXp7YgmvUTyu/5Sokuysj9tbPIEElZM7mwvU3Pr1
	 JpdfThfBCRnXcRrwqV1oGGeNotqmJm4xNpPBzutdamD0mMcBi4pYNqjOZ156k6cPR/
	 F9rPvBGAephPQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs/013: test to check potential corruption on atomic_write file
Date: Fri,  9 May 2025 14:07:54 +0800
Message-ID: <20250509060754.1677062-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression testcase to check whether we will handle database
inode dirty status correctly:
1. mount f2fs image w/ timeout fault injection option
2. create a regular file, and write data into the file
3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
4. write transaction data to the file
5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
6. meanwhile loop call fsync in parallel
Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomic
file"), database file may become corrupted after atomic write while
there is concurrent dirty inode flush in background.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- fix typo: s/relis/relies
 tests/f2fs/013     | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/013.out |  2 ++
 2 files changed, 73 insertions(+)
 create mode 100755 tests/f2fs/013
 create mode 100644 tests/f2fs/013.out

diff --git a/tests/f2fs/013 b/tests/f2fs/013
new file mode 100755
index 00000000..80ed2702
--- /dev/null
+++ b/tests/f2fs/013
@@ -0,0 +1,71 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/013
+#
+# This is a regression testcase to check whether we will handle database
+# inode dirty status correctly:
+# 1. mount f2fs image w/ timeout fault injection option
+# 2. create a regular file, and write data into the file
+# 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
+# 4. write transaction data to the file
+# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
+# 6. meanwhile loop call fsync in parallel
+# Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomic
+# file"), database file may become corrupted after atomic write while
+# there is concurrent dirty inode flush in background.
+#
+. ./common/preamble
+_begin_fstest auto quick
+_require_kernel_config CONFIG_F2FS_FAULT_INJECTION
+_require_command "$F2FS_IO_PROG" f2fs_io
+
+_cleanup()
+{
+	[ -n "$atomic_write_pid" ] && kill -9 $atomic_write_pid
+	wait
+	cd /
+	rm -r -f $tmp.*
+}
+
+_fixed_by_kernel_commit f098aeba04c9 \
+	"f2fs: fix to avoid atomicity corruption of atomic file"
+
+_require_scratch
+
+_scratch_mkfs >> $seqres.full
+# note that it relies on FAULT_TIMEOUT fault injection support in f2fs
+_scratch_mount "-o fault_injection=1,fault_type=4194304" >> $seqres.full
+
+dbfile=$SCRATCH_MNT/file.db
+
+# initialize database file
+$XFS_IO_PROG -c "pwrite 0 4k" -c "fsync" -f $dbfile >> $seqres.full
+
+# sync filesystem to clear dirty inode
+sync
+
+# start atomic_write on src.db database file and commit transaction
+$F2FS_IO_PROG write 1 0 2 zero atomic_commit $dbfile >> $seqres.full &
+atomic_write_pid=$!
+
+# call fsync to flush dirty inode of database file in parallel
+for ((j=0;j<1000;j++)) do
+	$F2FS_IO_PROG fsync $dbfile >> $seqres.full
+done
+
+wait $atomic_write_pid
+unset atomic_write_pid
+
+# flush dirty data and drop cache
+sync
+echo 3 > /proc/sys/vm/drop_caches
+
+stat $dbfile -c %s
+
+rm $dbfile
+sync
+
+status=0
+exit
diff --git a/tests/f2fs/013.out b/tests/f2fs/013.out
new file mode 100644
index 00000000..d9271f75
--- /dev/null
+++ b/tests/f2fs/013.out
@@ -0,0 +1,2 @@
+QA output created by 013
+8192
-- 
2.49.0

