Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383E1803D
	for <fstests@vger.kernel.org>; Sat, 20 Jul 2024 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721461550; cv=none; b=VJpSlfYiZZmUcMwIBUEFRge3HUzlLJ9fpLhkq3sX4qLYjvE6QCzlj9Jca4jzkZe9ae7iCbjSxrUVIomkXHCfdnOVhn3TE5g5FFu8zIK5SEspyZMscqsuzo4HVqn+aVake0eonqUindmpggqmhux7eIo9cizxgm7KIN2boiJNwqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721461550; c=relaxed/simple;
	bh=dCyD68OyC/gKP1RXCzAdoiPNMWoVuTKpjEPYoboihqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b9PdHtkPmv2XFBLGsH4NqgSCSA/jpntqj2jaAR0R8kJj6OzrBBQ+OtPQMiKvzmIjD3ee924/ABVwrQwkQGvVwsTWVn9hIjdHa3Y01mvTRK5La1GO7T7Isj07CbgAjkVDAXdGc6DjLD7IgkN1aIJHMISUTzOuPg37SM4puTzrEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R75o2qib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R75o2qib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D466BC2BD10;
	Sat, 20 Jul 2024 07:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721461550;
	bh=dCyD68OyC/gKP1RXCzAdoiPNMWoVuTKpjEPYoboihqk=;
	h=From:To:Cc:Subject:Date:From;
	b=R75o2qibEPvmIH7ju9BCmTzUqerYB8T5URb4lNIfCVfGepQ+fKVOQNwTBTD6XNRTe
	 7VrPXWssg+/tK6+4zmeYOM5o+wjORKr1cX284PJdC/rFXdciSKoD8IFls7qszVIEHA
	 fGoMu7OjCXqv0FsPn5bJE6/JeVLKklySr2ZR07Y5RgEfh7FxzoxrDkxmosnJhlafT4
	 Ck7TVIycsi2ISID2MJf38U0cth04yRHV+Ip4xayGlzsBGZUjEnhLSF+TqsYBu4Pls1
	 762HEbr+3lnRPlFS7vhbw7QSkJDp6dgdKxRnbuIoyHJ7fpiPGH801M04/bUf8VRqfV
	 eAvYlTzf0XK7A==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: test for race condition in between atomic_write and dio
Date: Sat, 20 Jul 2024 15:45:40 +0800
Message-Id: <20240720074540.3303154-1-chao@kernel.org>
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
4. trigger direct read/write IO to check whether it fails or not
5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
This is a regression test to check handling of race condition in
between atomic_write and direct IO.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add kill&wait in _clean() to avoid umount failure
- some cleanups
- use exported helpler
 tests/f2fs/004     | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/004.out |  3 +++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/f2fs/004
 create mode 100644 tests/f2fs/004.out

diff --git a/tests/f2fs/004 b/tests/f2fs/004
new file mode 100755
index 00000000..d71e99ea
--- /dev/null
+++ b/tests/f2fs/004
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oppo.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/004
+#
+# Test that we will simulate race case in between sqlite atomic write
+# and direct IO w/ below steps:
+# 1. create a regular file, and initialize it w/ 0xff data
+# 2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
+# 3. write transaction data
+# 4. trigger direct read/write IO to check whether it fails or not
+# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
+# This is a regression test to check handling of race condition in
+# between atomic_write and direct IO.
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
+_require_odirect
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+dbfile=$SCRATCH_MNT/dbfile
+
+# start atomic_write on dbfile & write data to dbfile
+touch $dbfile
+$F2FS_IO_PROG write 1 0 32 zero atomic_commit $dbfile 3000 >> $seqres.full &
+atomic_write_pid=$!
+
+# simulate concurrent direct read/write IO
+$XFS_IO_PROG -d -c "pread 0 128k" $dbfile
+$XFS_IO_PROG -d -c "pwrite 0 128k" $dbfile
+
+# wait for atomic_write commit completion
+sleep 5
+
+status=0
+exit
diff --git a/tests/f2fs/004.out b/tests/f2fs/004.out
new file mode 100644
index 00000000..3af79541
--- /dev/null
+++ b/tests/f2fs/004.out
@@ -0,0 +1,3 @@
+QA output created by 004
+pread: Operation not supported
+pwrite: Operation not supported
-- 
2.40.1

