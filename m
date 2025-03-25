Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1B225290C
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891677; cv=none; b=CJaVH/RI0cYfOw5exvI/H2KBHF32B9Urof/JiwmgGzpfDGBuyqaVb16/+EvscO1q69RCuIJPlmJr8hzrK/H6VU+bwSRM8izOLZOKscS5b00SBDBdF59YGGH3LcerUkwTOO1usw5C5FGHgMUzRxpbjPdzRrw4+nzaovO67pNAAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891677; c=relaxed/simple;
	bh=nRM4bXUyptdAglnpX3FP5KP7iBLUkiyRSBRlxNjz6Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LuKJYkCGNY6wFyKF79OfXrX5X54hQzT9tAbtcJbi/aDF7AAQtpKNIp1CkcqiPH6vDAHSjkPqm0sPo37zbzvZ5QvN1Ly6HnMwnX0O5cnZteCNUvrKn7UR2GM9e/QEO+rcEukgDzHiYhPYxXt0ZeOq2yzXZL+LTBNiJF0b26a0vKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVCQqPYB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVCQqPYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87848C4CEE8;
	Tue, 25 Mar 2025 08:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742891676;
	bh=nRM4bXUyptdAglnpX3FP5KP7iBLUkiyRSBRlxNjz6Ck=;
	h=From:To:Cc:Subject:Date:From;
	b=IVCQqPYBdTKoKizVykV6g9EoNfQgIZw1OlMj+UoUSHEMysSVK/3CkxFqMp1Cz0HIm
	 FXAP+36gSghKQFLUy1XKN/jc9lTiwmqjCdCcmklwVUnZkPG8flyq1IoO3cgMzKe+bH
	 VFMlb70pe/Lln8shaKUGF7FuqZqyYGrGywRYk+2zndeqCC75SV2qsYIG/wm2rYuzAV
	 pMe23W2FrscUZxpgzv20fzM0aAZoKWr21ASExCJVOFgYXgu/f1ZNBgwfAk+hC2+t+0
	 XqYYTYWL0O2vOnJM9oxV6yNENu0+JkbXkHqsuUUqAFepriPFpbTV0IVZjtHKwqQemz
	 YOdv4AgdDydQA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jianan Huang <huangjianan@xiaomi.com>
Subject: [PATCH v2] f2fs/010: test dirty status handling on database file
Date: Tue, 25 Mar 2025 16:34:28 +0800
Message-ID: <20250325083428.3301950-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression testcase to check whether we will handle database
inode dirty status correctly:
1. create a regular file, and write data into the file
2. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
3. write transaction data to the file
4. rename the file
5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
6. drop caches in order to call f2fs_evict_inode()
It expects kernel panic will gone after we apply commit 03511e936916
("f2fs: fix inconsistent dirty state of atomic file").

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Cc: Jianan Huang <huangjianan@xiaomi.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix to unset atomic_write_pid to avoid killing process w/ dummy pid value
 tests/f2fs/010     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/010.out |  2 ++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/f2fs/010
 create mode 100644 tests/f2fs/010.out

diff --git a/tests/f2fs/010 b/tests/f2fs/010
new file mode 100755
index 00000000..50e37817
--- /dev/null
+++ b/tests/f2fs/010
@@ -0,0 +1,69 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/010
+#
+# This is a regression testcase to check whether we will handle database
+# inode dirty status correctly:
+# 1. create a regular file, and write data into the file
+# 2. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
+# 3. write transaction data to the file
+# 4. rename the file
+# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
+# 6. drop caches in order to call f2fs_evict_inode()
+# It expects kernel panic will gone after we apply commit 03511e936916
+# ("f2fs: fix inconsistent dirty state of atomic file").
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
+_fixed_by_kernel_commit 03511e936916 \
+	"f2fs: fix inconsistent dirty state of atomic file"
+
+_require_scratch
+_require_command "$F2FS_IO_PROG" f2fs_io
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+src_db=$SCRATCH_MNT/src.db
+dst_db=$SCRATCH_MNT/dst.db
+
+# initialize database file
+$XFS_IO_PROG -c "pwrite 0 4k" -c "fsync" -f $src_db >> $seqres.full
+
+# sync filesystem to clear dirty inode
+sync
+
+# start atomic_write on src.db database file and commit transaction after 3000ms
+$F2FS_IO_PROG write 1 0 0 zero atomic_commit $src_db 3000 >> $seqres.full &
+atomic_write_pid=$!
+
+# wait a moment to let atomic write starts
+sleep 1
+
+# it will dirty inode when updating i_pino
+mv $src_db $dst_db
+
+# wait for atomic_write commit completion
+sleep 4
+
+# drop caches in order to call f2fs_evict_inode()
+echo 3 > /proc/sys/vm/drop_caches
+
+wait $atomic_write_pid
+unset atomic_write_pid
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/010.out b/tests/f2fs/010.out
new file mode 100644
index 00000000..1d83a8d6
--- /dev/null
+++ b/tests/f2fs/010.out
@@ -0,0 +1,2 @@
+QA output created by 010
+Silence is golden
-- 
2.48.1

