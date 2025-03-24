Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C125D543
	for <fstests@vger.kernel.org>; Mon, 24 Mar 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819928; cv=none; b=GgOy7+Z1ocVNAcww6yfts2QJa2iRGINs4gv1szFhxuh80dQz3oHVyYX/ZYfykMO3KekE7W0V84hSUn1YRJ9IQA8+ooWi3HqBiFy1e4jMNOGctHXBCGYPZ8rsy000g+jv+CZOefAaCT6Eulbb6AgKucx6/Sum1YcL5IV/DxvA3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819928; c=relaxed/simple;
	bh=PIKk/rQU2Xe6f/2Nwfdobvb7T1ZWBBTYT7hjOleiHjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goreGw/dfdoHvoy2oHoUtZF6E48sZsGVULSC4UMEX4B6l6/yCv5bEWZvwPu7kpdKm6Evn0sqQPCPngMgFJb4cOn+Uk+1cZeiazvyC5AdeG/9Y7vZl5NRvyNzsnNbzxGRo2hGoXOlg61tqskI745U8wJ97rth0cXt1Ckb//+lLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM+6io1y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM+6io1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C76C4CEDD;
	Mon, 24 Mar 2025 12:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742819928;
	bh=PIKk/rQU2Xe6f/2Nwfdobvb7T1ZWBBTYT7hjOleiHjk=;
	h=From:To:Cc:Subject:Date:From;
	b=YM+6io1y4nGde/qJd+8lje7cxVVn7n3oG3GdKjjsXEBbXJRzG9G59bLkxQt6UMNmG
	 Go/pyCEcSaVrC6q2Y29o4bQ8D39JwmLFlFBf+zyOjCst18CNPh3W0oJl9yOHSMT+o1
	 nW+ihfGoWh52hNca1u0S8qcenPQ2UXcqP+4+YC+QQlDGolcnsRq7R3Z4byE0BQaWsh
	 czvbMZXSIqYXL03lNpBOqXLBaox8AKmO4OGlisZpyeAOiIZz2nagLfIGyDTIvPS8Ml
	 RCl7fhK60b9AP2XTdDNAu2+dJUZcVv+TQv7LkjOslCQm6pT863MBO31X8IzCuL7Ygr
	 viCUVQQW+58IQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jianan Huang <huangjianan@xiaomi.com>
Subject: [PATCH] f2fs/010: test dirty status handling on database file
Date: Mon, 24 Mar 2025 20:38:36 +0800
Message-ID: <20250324123836.3098377-1-chao@kernel.org>
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
 tests/f2fs/010     | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/010.out |  2 ++
 2 files changed, 70 insertions(+)
 create mode 100755 tests/f2fs/010
 create mode 100644 tests/f2fs/010.out

diff --git a/tests/f2fs/010 b/tests/f2fs/010
new file mode 100755
index 00000000..360c09b9
--- /dev/null
+++ b/tests/f2fs/010
@@ -0,0 +1,68 @@
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
+	kill -9 $atomic_write_pid > /dev/null 2>&1
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

