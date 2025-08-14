Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD62F5499
	for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162447; cv=none; b=o5fh/G8yM7lJvBAp2xqV3AHMNWK4c2PkT7SNeQk0j/omLSra78hyKa85t7gI0jMszOIFudJD1YohHj6d74YFc9LbQ7HGlcMxNt1cBgf7kd1eoEiP1/9R/ynC/gBU8A5znDS5TpThvCSPHZ9t13f8/iWMJdDeE0wO5fNTbl+ALyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162447; c=relaxed/simple;
	bh=bvKDV0EG2kLIX5QM3RKwjkNu18T+4tLdYQJQooGxJzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ma/+VIXUCvBWU62TBoFzK6f6+zqD+6PTxerR8szXVM/Lc0swrq25xvK/4ygLV5cDBPjSdsr1hh6nwWf4huseYLgGM5iXmktyEXXvMI0k2O3fY9H9ZtLpol0pw69nKBvQ0mKcPy6bkEGyAogKkrARsrLAuHFmwgLxmuE9Ps/Na8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFXuVIQR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFXuVIQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D144C4CEED;
	Thu, 14 Aug 2025 09:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162446;
	bh=bvKDV0EG2kLIX5QM3RKwjkNu18T+4tLdYQJQooGxJzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFXuVIQRjUYfjaGzu1aaTjF7GjP1ZGOeVaLft7ZnlvV0w96+ow6Jg6t5cRVfVJVDz
	 bQUoZZ8XAKJK1cbQSkAgg3njCeyAXrS5+5TYZbl9Vl6FkwaQ1WuOi48Z9lMiQTMXGB
	 XxnBBS49OlPYglQYdGMp7ntYeXFzY2QAI4jvwAqCDsTVLM/BsKnmVwpO3tSz5XGcj9
	 R5VtqYhzZifcev69YiAGhWEqifbDMG1pP2vmUu7NFXp3JxnhiCLITGIZksFs2kmWHT
	 SVMV10Qn01MfcIqdf6LJd5RxmEi+EzBLLPc55eFg9xX50RI8awuQxU3LUx32FT0LvZ
	 PFU3bpBSQGBcA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 3/3] f2fs/020: do sanity check on i_xattr_nid
Date: Thu, 14 Aug 2025 17:07:12 +0800
Message-ID: <20250814090712.2119455-3-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
In-Reply-To: <20250814090712.2119455-1-chao@kernel.org>
References: <20250814090712.2119455-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression test:
1. create directory
2. add a new xattr entry to create xattr node
3. use inject.f2fs to inject nid of xattr node w/ ino in a file
4. check whether f2fs kernel module will detect and report such
   corruption in the file

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- use _require_scratch_nocheck instead of _require_scratch
- add missing _require_attrs user
- add comments for why exporting MKFS_OPTIONS=""
 tests/f2fs/020     | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/020.out |  2 ++
 2 files changed, 53 insertions(+)
 create mode 100755 tests/f2fs/020
 create mode 100644 tests/f2fs/020.out

diff --git a/tests/f2fs/020 b/tests/f2fs/020
new file mode 100755
index 00000000..7ce1f92f
--- /dev/null
+++ b/tests/f2fs/020
@@ -0,0 +1,51 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/020
+#
+# This is a regression test:
+# 1. create directory
+# 2. add a new xattr entry to create xattr node
+# 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
+# 4. check whether f2fs kernel module will detect and report such
+#    corruption in the file
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+. ./common/attr
+
+_fixed_by_kernel_commit 061cf3a84bde \
+	"f2fs: fix to do sanity check on ino and xnid"
+
+_require_scratch_nocheck
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_attrs user
+
+# remove all mkfs options to avoid layout change of on-disk inode
+export MKFS_OPTIONS=""
+
+testdir=$SCRATCH_MNT/testdir
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount "-o user_xattr,noinline_xattr"
+
+mkdir $testdir
+# add a new xattr entry to create xattr node
+$SETFATTR_PROG -n user.abc -v 123 $testdir
+
+_scratch_unmount
+
+# inject i_xattr_nid w/ nid of inode node
+$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full
+
+_scratch_mount
+# may potentially trigger a deadlock w/ double inode_lock on parent's inode
+mkdir $testdir/dir >> $seqres.full 2>&1
+_scratch_unmount
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/020.out b/tests/f2fs/020.out
new file mode 100644
index 00000000..20d7944e
--- /dev/null
+++ b/tests/f2fs/020.out
@@ -0,0 +1,2 @@
+QA output created by 020
+Silence is golden
-- 
2.49.0

