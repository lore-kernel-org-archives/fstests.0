Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4DD19D087
	for <fstests@vger.kernel.org>; Sat, 11 Oct 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760172467; cv=none; b=Syzu6TGLmuOhejmW5Vkx86jJ3HxAuavmm9T9X5AkF7tRQ309oiEV7/3g4y5Ury/kiIwHyT9kZOjxCTd9uMVCVbBU7QzXDwzNPiXC4KEIZbNQyJXH47Sf+WFSnnM79AobSuAwKNIlCnpIoKSYacc3je015Y3lfSB67Nf3Vpkz9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760172467; c=relaxed/simple;
	bh=ICK2QtCKRm4PbgXspSFQYE73re2fxQXKto45NArjRVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpGRzJekWI83vIVMMRDWeObofH2Km4DQzfhmTgYyfZNVb4ZhBphZj59jTvmchBbUqRRtWoZU/62AkCqP4qKISq/D33D23YayKb6u8jq3mrWTLEYzoTo6ySsVSa8XpbVAH9i7SKEctC3vgcNBr3zcXaElLLMdPbqDWO9qnNvAUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQddnMhf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQddnMhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16739C113D0;
	Sat, 11 Oct 2025 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760172467;
	bh=ICK2QtCKRm4PbgXspSFQYE73re2fxQXKto45NArjRVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQddnMhfbM7yUO5D/23J2itcNHIYcoirDPlT3n2lg39AiDJQDu6MytOKCzcpEjTcv
	 ahdaN0G8Gq+/k4SrwKIzJU2ChpILNX26yN2HuOkzwJprsvwp2kIcXn7EI2Xwr38H12
	 6LmiSCAZkEYJRjtekbaizcDpFtOe5pLvveFenfam46e2B2UdEOQ2OKACGuyuT/2Q0M
	 RiIdcTSN+4uLXMR3Kvc6Hub+HTc18zqjtotdqTRSZboqys+gyzBXSe5USCXkDDBJ6V
	 YgYVuQJoJHNLoNX/+g5mOjB8aAp93hUQ6Snv0tiAM8TcLWnJdWcKlVSpjG+TKGZg2R
	 DYK7sRkeOE6zw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3 2/2] f2fs/022: do sanity check on footer of non inode dnode
Date: Sat, 11 Oct 2025 16:47:15 +0800
Message-ID: <20251011084715.608562-2-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
In-Reply-To: <20251011084715.608562-1-chao@kernel.org>
References: <20251011084715.608562-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression test:
1. create foo & bar
2. write 8M data to foo
3. use inject.f2fs to inject i_nid[0] of foo w/ ino of bar
4. fpunch in foo w/ specified range

If we haven't applied kernel patch ("f2fs: fix to do sanity check on
node footer for non inode dnode"), f2fs may missed to do sanity check
on corrupted dnode, result in panic or deadloop in step 4).

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
v3:
- update commit id in _fixed_by_kernel_commit line
- fix to update output to "fallocate: Structure needs cleaning"
- fix typo for foo_path & bar_path
 tests/f2fs/022     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/022.out |  2 ++
 2 files changed, 54 insertions(+)
 create mode 100755 tests/f2fs/022
 create mode 100644 tests/f2fs/022.out

diff --git a/tests/f2fs/022 b/tests/f2fs/022
new file mode 100755
index 00000000..e5dd3077
--- /dev/null
+++ b/tests/f2fs/022
@@ -0,0 +1,52 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/022
+#
+# This is a regression test:
+# 1. create foo & bar
+# 2. write 8M data to foo
+# 3. use inject.f2fs to inject i_nid[0] of foo w/ ino of bar
+# 4. fpunch in foo w/ specified range
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+. ./common/attr
+
+_fixed_by_kernel_commit c18ecd99e0c7 \
+	"f2fs: fix to do sanity check on node footer for non inode dnode"
+
+_require_scratch_nocheck
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+
+# remove all mkfs options to avoid layout change of on-disk inode
+export MKFS_OPTIONS=""
+
+foo_path=$SCRATCH_MNT/foo
+bar_path=$SCRATCH_MNT/bar
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+touch $foo_path
+touch $bar_path
+$XFS_IO_PROG $foo_path -c "pwrite 0 8M" >> $seqres.full
+sync
+foo_ino=`stat -c '%i' $foo_path`
+bar_ino=`stat -c '%i' $bar_path`
+_scratch_unmount
+
+# inject foo inode to replace i_nid[0] w/ to bar ino
+$F2FS_INJECT_PROG --node --mb i_nid --nid $foo_ino --idx 0 --val $bar_ino $SCRATCH_DEV >> $seqres.full || _fail "failed to inject"
+
+_scratch_mount
+
+# if CONFIG_F2FS_CHECK_FS is enabled, it will trigger a kernel panic,
+# otherwise, it will enter a deadloop.
+$XFS_IO_PROG $foo_path -c "fpunch 6984k 4k"
+_scratch_unmount
+
+status=0
+exit
diff --git a/tests/f2fs/022.out b/tests/f2fs/022.out
new file mode 100644
index 00000000..5307e3d7
--- /dev/null
+++ b/tests/f2fs/022.out
@@ -0,0 +1,2 @@
+QA output created by 022
+fallocate: Structure needs cleaning
-- 
2.49.0

