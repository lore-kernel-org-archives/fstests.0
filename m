Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908ADF60
	for <fstests@vger.kernel.org>; Sat, 20 Jul 2024 07:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721461403; cv=none; b=a/zY+AsQcxGvg74/AvrtCvwAUXJ1KOQ+slg+GhG0Pa1t5S58Td/zP5QuIfOLcNZWHm6DorwabXpP6UydLSuXdnBvA59RfBGmfdenPsN4OmknimH0A0pRb35EPPs6x801ljuoG2V96QYza0J+FjtLafNWOPClDesJcqYc+NHIhC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721461403; c=relaxed/simple;
	bh=SXN+gBJcErBmdJHeulGYWX8/O+1JBPPNS2SRTZEpCgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XHl0NPYorvxaOSjm7+Rp3j2lFXYvhOaJMlymocScjggljXd4QHVE3DuLXxSkrVcUk4L+ajPUUmJR90HQMqtxeDKuQ2i8bELfjcskp/cg6Kv1n9Dd+5mRyYZ8PRngx5oXcj/3JMHI42H8/SHe9PaiZXBB3bpfXefYjG3xvkJ9UWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPLgDzP1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPLgDzP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFAAC2BD10;
	Sat, 20 Jul 2024 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721461403;
	bh=SXN+gBJcErBmdJHeulGYWX8/O+1JBPPNS2SRTZEpCgI=;
	h=From:To:Cc:Subject:Date:From;
	b=cPLgDzP1xDCVd2Wy/UdRsW7Xlq3BYU/Y/CALW15l82YVagp2mEqc/c6O/WIWwEmNO
	 99kQvhnIii771O/efwiWgrk9riv788Xx34eV1HFQkUKzkYezn7DbBg/6eg1DtQE+8q
	 28g/M3m9bPT7VhxDmqwumezttGi1BCU0xWCMOHwJw8wGpS7EK7u5cZ3AsaabwdOMbS
	 jrelTeBtv6X20V4tjTiEbnFITpn+G2iTrIi9YQB0xr/bt8n9wLY+qEWgXwpwHFUhWO
	 6+5MU5wHmBGGtonVqRbbNQEtbWlSUJmuLEsv8MYmmLnqdVDzahCj0pvNsSMAQBF8Yp
	 K7Gf7ItFaRy3Q==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: test for race condition in between atomic_write and gc
Date: Sat, 20 Jul 2024 15:43:16 +0800
Message-Id: <20240720074316.3302470-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that we will simulate sqlite atomic write logic w/ below steps:
1. create a regular file, and initialize it w/ 0xff data
2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
3. write transaction data
4. trigger foreground GC to migrate data block of the file
5. commit and end the transaction
6. check consistency of transaction
This is a regression test to check handling of race condition in
between atomic_write and GC.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add kill&wait in _clean() to avoid umount failure
- some cleanups
- use exported helpler
 tests/f2fs/003     | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/003.out | 11 ++++++++
 2 files changed, 76 insertions(+)
 create mode 100755 tests/f2fs/003
 create mode 100644 tests/f2fs/003.out

diff --git a/tests/f2fs/003 b/tests/f2fs/003
new file mode 100755
index 00000000..c30e874a
--- /dev/null
+++ b/tests/f2fs/003
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oppo.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/003
+#
+# Test that we will simulate sqlite atomic write logic w/ below steps:
+# 1. create a regular file, and initialize it w/ 0xff data
+# 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
+# 3. write transaction data
+# 4. trigger foreground GC to migrate data block of the file
+# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
+# 6. check consistency of transaction w/ in-memory and on-disk data
+# This is a regression test to check handling of race condition in
+# between atomic_write and GC.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/filter
+
+_cleanup()
+{
+	kill -9 $atomic_write_pid > /dev/null 2>&1
+	wait > /dev/null 2>&1
+}
+
+_require_scratch
+_require_xfs_io_command "fpunch"
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+dbfile=$SCRATCH_MNT/dbfile
+foo=$SCRATCH_MNT/foo
+bar=$SCRATCH_MNT/bar
+
+$XFS_IO_PROG -c "pwrite 0 512k -S 0xff" -c "fsync" -f $dbfile >> $seqres.full
+$XFS_IO_PROG -c "pwrite 0 2m" -c "fsync" -f $foo >> $seqres.full
+sync
+
+# start atomic_write on dbfile & write data to dbfile
+$F2FS_IO_PROG write 1 0 32 zero atomic_commit $dbfile 3000 >> $seqres.full &
+atomic_write_pid=$!
+
+$XFS_IO_PROG -c "fpunch 0 2m" $foo >> $seqres.full
+$XFS_IO_PROG -c "pwrite 0 2m" -c "fsync" -f $bar >> $seqres.full
+
+# persist all dirty data
+sync
+echo 3 > /proc/sys/vm/drop_caches
+
+# trigger foreground GC to migrate data block of atomic_file
+$F2FS_IO_PROG gc 1 $SCRATCH_MNT > /dev/null 2>&1
+
+# wait for atomic_write commit completion
+sleep 5
+# print in-memory data
+_hexdump $dbfile
+echo 3 > /proc/sys/vm/drop_caches
+# print on-disk data
+_hexdump $dbfile
+
+status=0
+exit
diff --git a/tests/f2fs/003.out b/tests/f2fs/003.out
new file mode 100644
index 00000000..64698d84
--- /dev/null
+++ b/tests/f2fs/003.out
@@ -0,0 +1,11 @@
+QA output created by 003
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+020000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  >................<
+*
+080000
+000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+020000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  >................<
+*
+080000
-- 
2.40.1

