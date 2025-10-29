Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A902D47FD
	for <fstests@vger.kernel.org>; Wed, 29 Oct 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738864; cv=none; b=flBrurK/n6iQFq4iryL+qR69yfr3HBKvgu5hwV2jmUyaNIeJKvto1FZqoNkhLTf9vWwklK5HMXh+urIqOTk454AD2KS12TvXmjGr+Xxe0jX5v9AbX2eFm03Cx9Y/h4f6Li71xMwP0xpxnTeOgGH7NRWlxLZt/VJnt0JagksSYmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738864; c=relaxed/simple;
	bh=QYWNcLUo1Xo3vHpwv4dqRFJ8Nq83iubr9cMZzymfZkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nBLOU/FQ61oL+kK8UvrLLAamT1Q6iOkho6z8alSC+uQJFQAbrdkzUitJ/6aDisXqZW9LB8n6AxpwilzP35atCVqgbUMLggabsaSQs8JIt8df4ZLQMz+tetj1xlf+U/VSHLxbwNsYMWbGP9Ez7CYxtwWssNELkdYooPAYl0fcjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQUWMLGe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQUWMLGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA8EC4CEF7;
	Wed, 29 Oct 2025 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761738862;
	bh=QYWNcLUo1Xo3vHpwv4dqRFJ8Nq83iubr9cMZzymfZkg=;
	h=From:To:Cc:Subject:Date:From;
	b=PQUWMLGeW9qxxL5p8urexuWi7vtflz7CHm83HfSJeXr7Ur1TBquTPW8oGwv7nqr9e
	 niojTbZzHamkt07AMUT3kvliHLszdn4HUwhpaxNL8saZXUEtvXUs11nz+jcav5+UGv
	 I8jvbm4JmrxhEzSbd+HdNjg1L8e1l+fBTf1Nk2kopzgFMDr2+La9USjKrBRuIWBOhD
	 12bZFPOUVUesE+HvgUvHOiWcTSQWBG/Ybgv2+vezHHWgJijrnhFbbR3PFfQW7TmvMy
	 FDAGm4/rPTsuVrjppAHd6fM7udDf3sGH49qxPeQ3PNbhkjRrBpvfNGHJmMgY5r3Tz+
	 Yadj345HoB/Yw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs/023: test sanity check condition w/ error injection
Date: Wed, 29 Oct 2025 19:54:13 +0800
Message-ID: <20251029115413.1085987-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 5c1768b67250 ("f2fs: fix to do sanity check correctly on
i_inline_xattr_size"), f2fs should handle corrupted i_inline_xattr_size
correctly, let's add this regression testcase to check that.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/023     | 44 ++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/023.out |  2 ++
 2 files changed, 46 insertions(+)
 create mode 100755 tests/f2fs/023
 create mode 100644 tests/f2fs/023.out

diff --git a/tests/f2fs/023 b/tests/f2fs/023
new file mode 100755
index 00000000..d1b7df32
--- /dev/null
+++ b/tests/f2fs/023
@@ -0,0 +1,44 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu <chao@kernel.org>
+#
+# FS QA Test No. f2fs/023
+#
+# This testcase tries to inject fault into inode.i_inline_xattr_size,
+# and check whether sanity check of f2fs can handle fault correctly.
+#
+
+. ./common/preamble
+_begin_fstest auto quick rw
+
+_fixed_by_kernel_commit 5c1768b67250 \
+        "f2fs: fix to do sanity check correctly on i_inline_xattr_size"
+
+_require_scratch_nocheck
+_require_inject_f2fs_command node i_inline
+_require_inject_f2fs_command node i_inline_xattr_size
+
+testfile=$SCRATCH_MNT/testfile
+
+# remove all mkfs options to avoid layout change of on-disk inode
+export MKFS_OPTIONS=""
+
+_scratch_mkfs "-O extra_attr,flexible_inline_xattr" >> $seqres.full
+_scratch_mount "-o inline_xattr_size=512" >>$seqres.full 2>&1
+touch $testfile
+_scratch_unmount
+
+# inject .i_inline field: clear F2FS_EXTRA_ATTR bit
+$F2FS_INJECT_PROG --node --mb i_inline --nid 4 --val 0x1 $SCRATCH_DEV \
+		>>$seqres.full || _fail "failed to inject i_inline"
+
+# inject .i_inline_xattr_size field from 512 to 2048
+$F2FS_INJECT_PROG --node --mb i_inline_xattr_size --nid 4 --val 2048 $SCRATCH_DEV \
+		>>$seqres.full || _fail "failed to inject i_inline_xattr_size"
+
+_scratch_mount
+
+getfattr -n user.test "$testfile" 2>&1 | awk -F ': ' '/Structure needs cleaning/ { print $NF }'
+
+status=0
+exit
diff --git a/tests/f2fs/023.out b/tests/f2fs/023.out
new file mode 100644
index 00000000..7f16f33f
--- /dev/null
+++ b/tests/f2fs/023.out
@@ -0,0 +1,2 @@
+QA output created by 023
+Structure needs cleaning
-- 
2.49.0

