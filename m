Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C3221285
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746514936; cv=none; b=saiFosbi5g0ouRlDhEBfQ+/LY/qhrltfkfFDXx/+TO+Ql1ZiF1+og+gmxzmz+JO2lPZvSUrRWbA81VSC0z8P1b7tDQEdIpvXsGwQnjuyE/t8hmkQoDwSbgSb4ZvvjVebWsAQbgZsBGWy3vgoiLOsPJycT3/8nvd+sg51ers5V60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746514936; c=relaxed/simple;
	bh=qLFnbXR/iFLSg5koyjksWLF9V77rH3lQL7HHAgYNTqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfcRy3KYAxiRn4NX8SDMch36F8iWpL/oV+alU7p+f3Yq/8Gqwdairs1LUJHH9D4F4ZevGQF6hLri11eDy27gDS0kY3a86snub+9gwXuZ/0YU/bq4w4yktVl/fBq61HkwAcmPoErfF+7bgJ1nrJHaB5lRt9Pr57OpVCV2k4HJYPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2I8bjbg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2I8bjbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2B6C4CEE4;
	Tue,  6 May 2025 07:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746514935;
	bh=qLFnbXR/iFLSg5koyjksWLF9V77rH3lQL7HHAgYNTqg=;
	h=From:To:Cc:Subject:Date:From;
	b=T2I8bjbgS2SimKD1pEzTHw9Fwxzd3I72ickAPGmVubUAzTPatFn4Rud5y4nS2R7hM
	 u8OHfbbgdFAdIiPf8OvNNJQuti1bRiW7DFGNx5euj/YRwIWg+6cnULe6kHeAQofiBx
	 hJJqmLMkGpl2byAjSqoYo9oBEdNqAlHuZdjq59wauKu1Ipxtkl8pUD/Iqz8NYBNZml
	 xLeiaFtSwshjvg1cyQmHdAMIudVoRUGSR1aJAi1f1WGilPX7KmjywgOrbCWcdWGTZC
	 C2XjCaxMsAeDkfHXT7M2Pq6P+v6xqMXclOm4tkiUAaPRhf9ayDK/LJc5wMAFnxEKNi
	 9KpJVFYUe57rQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs/013: test to check potential corruption on atomic_write file
Date: Tue,  6 May 2025 15:02:10 +0800
Message-ID: <20250506070210.539539-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
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
v2:
- fix description of test steps
- add missing "_require_kernel_config CONFIG_F2FS_FAULT_INJECTION"
- add missing "_require_command "$F2FS_IO_PROG" f2fs_io"
- put correct filesize in the golden output
 tests/f2fs/013     | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/013.out |  2 ++
 2 files changed, 73 insertions(+)
 create mode 100755 tests/f2fs/013
 create mode 100644 tests/f2fs/013.out

diff --git a/tests/f2fs/013 b/tests/f2fs/013
new file mode 100755
index 00000000..4cf56840
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

