Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07561B7F7
	for <fstests@vger.kernel.org>; Tue, 25 Jun 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324161; cv=none; b=OP/VJORAjPWZQicCQU/F8nd+NoPjEFnai4e5xwEFBsy+zsRvwBT56M49s41wwc/BELhvxKEifj0m4I35cYN4eyXZV1CVIqCnDq+b4JEJMOy4aqXdCiYs1IGugPwBpQ0VPHPLII8XTym076/+DSYvQQ5aBwLoiNPe3Ok/mMFf2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324161; c=relaxed/simple;
	bh=5UjL4GyZrjz619WsFq1WHy8mcigCmMBJuw6biomyaJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o3lIzP0GClndceiGGktyoS5gIAYZXq+kF7ljcWC7eRzia12pcFxiJoc89ynTKwn5Xzw3Ou6IX1bzEBwTx6QJcARi+e9RvLZQudyjl8NF7U+s329wLS9o5J4gfzGi+YPt6MBgJ8MCEwm9Kreb3ifJxOwtt/rz1bgAlqM51+CoSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrpH7IF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrpH7IF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4177C32781;
	Tue, 25 Jun 2024 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719324160;
	bh=5UjL4GyZrjz619WsFq1WHy8mcigCmMBJuw6biomyaJU=;
	h=From:To:Cc:Subject:Date:From;
	b=RrpH7IF5FEgP1IJSfWRQ9+74A11Jaz23GSmjPswh4v3g/J1K6SXfboqD8BLAGoZob
	 CWwufwqM3CylgWg2sAajvlO0GI44G+r52edV+mPu3G5rdMu8iaFv5zXiNBnk2sYwD+
	 MJr5mPgVccNYjszsTtmxv8/AwySfLMUAxrINmyeLbqDX+cBhT3Ly3ZhJUMrolvx2XP
	 I6E6kUhncJbMlRyONW2Dx0GNUgRf/HfPJG/iL62DIlRYLjeQCPlAnb8TRzw/nXYMYo
	 vIhcZNQQ8xz5IF57XsHctiNv4d0PIo/7hZzgjn8qdQDSyZAXo/HdBK6sJiQpJIdZ1h
	 B2ENuIT4NgaCQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: test for race condition in between atomic_write and dio
Date: Tue, 25 Jun 2024 22:02:33 +0800
Message-Id: <20240625140233.3907012-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this patch, we simulate race case in between sqlite atomic write
and direct IO w/ below steps:
1. create a regular file, and initialize it w/ 0xff data
2. start transaction (via F2FS_IOC_START_ATOMIC_WRITE) on it
3. write transaction data
4. trigger direct read/write IO on it to check whether it fails or not
5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
This is a regression test to check handling of race condition in
between atomic_write and direct IO.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/004     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/004.out |  3 +++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/f2fs/004
 create mode 100644 tests/f2fs/004.out

diff --git a/tests/f2fs/004 b/tests/f2fs/004
new file mode 100755
index 00000000..26862cb5
--- /dev/null
+++ b/tests/f2fs/004
@@ -0,0 +1,45 @@
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
+_supported_fs f2fs
+_require_scratch
+_require_xfs_io_command "pwrite"
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+dbfile=$SCRATCH_MNT/dbfile
+
+# start atomic_write on dbfile & write data to dbfile
+touch $dbfile
+$F2FS_IO_PROG write 1 0 32 zero atomic_commit $dbfile 3000 >> $seqres.full &
+
+# simulate concurrent direct read/write IO
+$XFS_IO_PROG -d -c "pread 0 128k" $dbfile
+$XFS_IO_PROG -d -c "pwrite 0 128k" $dbfile
+
+# wait for atomic_write commit completion
+sleep 5
+
+_scratch_unmount
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

