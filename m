Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A912B93
	for <fstests@vger.kernel.org>; Tue, 25 Jun 2024 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719284675; cv=none; b=g+fSB3QGub3vJ7NJwwbqnx/2m9JXsBOIg04yyUcDTT5J+birCI9FXN1dELLXhKGjHkIw7FvnSXHc4HOHFnOw50sMeieENwItxQ/t8VXUGRXJam49EGYIq3tmxNreEo2pBKHi+COfYQ7V+flJ4ycdMmnLv5QHCoPbwi7R/280smc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719284675; c=relaxed/simple;
	bh=3qp5M9qrvzMvlVOT64dhGbSx4k2GXMlWUR49FPME47g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zdc/RXN3iqED2rnP0c08kkT5W7Un2I3K8lYRx2o0CjStrd+E0OHEi6r03YsoX1dKAucriRWUfxOonfCy0DdSd1XbCOnmmoI3OVGw684f0LJBo2lKZwW1scOz/6mKgJVpcYOkubLuGsrOvgYTdozZZb6lTDCEJX6bSKmGZQhdFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am8qlQkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am8qlQkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3EBC2BBFC;
	Tue, 25 Jun 2024 03:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719284675;
	bh=3qp5M9qrvzMvlVOT64dhGbSx4k2GXMlWUR49FPME47g=;
	h=From:To:Cc:Subject:Date:From;
	b=Am8qlQkGKcNLYotSsceceb+HWUp+0tSkcvmf6nte9blfdmFFaHUg8U4pulnqm++jZ
	 3+qR0DIyNMHJCs+dlcdYFv8tBU5LhAbbOAnCSMCg1lfVwQuo9eYSLfIFo1Zsh8ukN3
	 3WM149bOXlnTmdstTsWnOkC40LsivnBx/28Ixq7ek9CnIDBrsDXtnoikAoeFGFgKaZ
	 xtaHDPql/58Hfnd+aXlVrXcCdaSggigpsy7nuzqzhf/buqhaiOsv4wncbu1DzGm0VC
	 7Dk6xfk3bsG4e30k/Ke/60qgaC9A3o21FseV1BMqEHk7mDKQ6xaHNiWOypreiDmSvX
	 DLtFpZ/ezQXsw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: test for race condition in between atomic_write and gc
Date: Tue, 25 Jun 2024 11:04:16 +0800
Message-Id: <20240625030416.3553498-1-chao@kernel.org>
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
5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
6. check consistency of transaction w/ in-memory and on-disk data
This is a regression test to check handling of race condition in
between atomic_write and GC.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/003     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/003.out | 11 +++++++++
 2 files changed, 72 insertions(+)
 create mode 100755 tests/f2fs/003
 create mode 100644 tests/f2fs/003.out

diff --git a/tests/f2fs/003 b/tests/f2fs/003
new file mode 100755
index 00000000..d8311c4c
--- /dev/null
+++ b/tests/f2fs/003
@@ -0,0 +1,61 @@
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
+_supported_fs f2fs
+_require_scratch
+_require_xfs_io_command "pwrite"
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
+od -x $dbfile
+echo 3 > /proc/sys/vm/drop_caches
+# print on-disk data
+od -x $dbfile
+
+_scratch_unmount
+
+status=0
+exit
diff --git a/tests/f2fs/003.out b/tests/f2fs/003.out
new file mode 100644
index 00000000..d6c8a637
--- /dev/null
+++ b/tests/f2fs/003.out
@@ -0,0 +1,11 @@
+QA output created by 003
+0000000 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0400000 ffff ffff ffff ffff ffff ffff ffff ffff
+*
+2000000
+0000000 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0400000 ffff ffff ffff ffff ffff ffff ffff ffff
+*
+2000000
-- 
2.40.1

