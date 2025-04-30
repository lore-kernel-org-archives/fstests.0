Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B52111
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981264; cv=none; b=DgzJZFiAt1UfFi6ndVS9qq57CnyzNjTwhBLAm88md+gEI9d2nlljkk0Ww8faEKyWawJUx/N+50UWU/avOWZnjIyuvzcWTgqSjvXsPUaq0cwXYif94ARwhWRjZhymyk0Zs/45SVsVeKahLn3PJqn5iJxTmkXMJYkPSnhSOl93pRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981264; c=relaxed/simple;
	bh=gB8TAfuLxAG4wGF7EWMpCAyhqDp8zUiaMWtFctDP+0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qyweXPLrA7ikReuGpJBEsymT2FPs743AwBCmf9B+NZS8HhkkaJ5nW2K5EnwN4HsrR38Cr8joxx2S/Wj1J6EGF6r3d1871xEtVwzdHvPyncyIJeo/kHIV8yHoLP5Y92NHlYKdju2jByHDAxPO/99tnWeQbyvY7LR1Yt6VCy3poOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLYm9qei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLYm9qei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8FDC4CEE3;
	Wed, 30 Apr 2025 02:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745981264;
	bh=gB8TAfuLxAG4wGF7EWMpCAyhqDp8zUiaMWtFctDP+0c=;
	h=From:To:Cc:Subject:Date:From;
	b=XLYm9qei+IO6/5Algq5QOx+NGqO07aIh8bF+DNlegqWxufhX2Vou3lQ+lzDi3tbzQ
	 q6cYjaZnodBXNBs5TpMu2MoE4aiQVNfKFrIOepgKAM8IoYEUyP/GEA98cdIqtR477t
	 yrcBFkV4bArcNwqTUiQt2O41xbV3e6QGLR7Ubl7pQjMtb1NoO2tKNR/7ndTVfR0tcU
	 qFa9gz1flnF/PJVN62EnQ85h+pi5yHqLEopcA/G1XI6YY85njnOfebLbqN6jQpU0kw
	 HvFFLEVMT1K0eHdCJN0Rft0VSsXwZbtBp6xUXP4prZ+Q6wYAhwaKZ66GP6RGP00Pwm
	 CvD0n7mIjAEJw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs/013: test to check potential corruption on atomic_write file
Date: Wed, 30 Apr 2025 10:47:31 +0800
Message-ID: <20250430024731.2722027-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression testcase to check whether we will handle database
inode dirty status correctly:
1. make sure disk quota is enabled
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
 tests/f2fs/013     | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/013.out |  2 ++
 2 files changed, 75 insertions(+)
 create mode 100755 tests/f2fs/013
 create mode 100644 tests/f2fs/013.out

diff --git a/tests/f2fs/013 b/tests/f2fs/013
new file mode 100755
index 00000000..3db8448c
--- /dev/null
+++ b/tests/f2fs/013
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/013
+#
+# This is a regression testcase to check whether we will handle database
+# inode dirty status correctly:
+# 1. make sure disk quota is enabled
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
+# note that it relis on FAULT_TIMEOUT fault injection support in f2fs
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
+newsize=`stat $dbfile -c %s`
+if [ "$newsize" != "8192" ]; then
+	_fail "filesize is inconsistent:"$newsize
+fi
+rm $dbfile
+sync
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/013.out b/tests/f2fs/013.out
new file mode 100644
index 00000000..3e66423b
--- /dev/null
+++ b/tests/f2fs/013.out
@@ -0,0 +1,2 @@
+QA output created by 013
+Silence is golden
-- 
2.49.0

