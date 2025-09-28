Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BCD2BEC42
	for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049582; cv=none; b=LHOX0vlz9f9xQCs0+H0RV5+i8wv7bIQpD/tM6jPKrgpDW69CuHF2Ipu15k0FlRKUY2cvfwNeFESVmg+MRfkwL0BjCyyHGJBUpbHUzSxdnA68etqdGzNoObLooAuBN+3m60Y89OxWMNpxxZgNZExabuo8BwkE3AXIiyUY+ETdpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049582; c=relaxed/simple;
	bh=Ba3s8CZ9Sh7orNoDoBFCVy6+HFnC2PXzqvsdQw7kHSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khIDN5cMViAX84Lr2UT5MMyXtZnGuKjHxcfAXkBJTojA21rwfkz2D2k+SSS+MzFKyPAnfEjelzTukzj+/QMQrqIy4qz3uX+Y7PL4tPpNhtzoSKZBNsL4xo+ZiC5pC2CBtiRCAGBoNPdiU1KbVMl8q3UO9IPqjBLGVNydxUp3pWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc/aRr25; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc/aRr25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433CDC116B1;
	Sun, 28 Sep 2025 08:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759049582;
	bh=Ba3s8CZ9Sh7orNoDoBFCVy6+HFnC2PXzqvsdQw7kHSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jc/aRr25flDU00t8YIcZZnzKyeXVnl1knO3csJW9eXK3KO7SaDYzaJbsLDi3Rhvmq
	 QCLBeVIPvrlrJ2HmG/ZwtBlyV5HDmVI7ygLdgjbzyXDsyoUdSMVqZDPSFpUQObAAzB
	 I5zL7YawFv9YsPadNPpJZqr5lrOD/951X4W4jAPNzErLoG6hSixnTWjZ1TFKmdzmOo
	 aNXxuq5qYoKZRlHezBCk2sYiIwvhRWsnAmSNe2hAho81mc4CoNBGgaB6wHBV7CtyLz
	 42t8O3Qq6Km2TXiYUddDYwjZPKrpFWB6U4O9UQWddKSxy3wym+R0wZCF6QrsC+LFI3
	 EkwfewwKF0AOw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/2] f2fs/022: do sanity check on footer of non inode dnode
Date: Sun, 28 Sep 2025 16:34:42 +0800
Message-Id: <20250928083442.7955-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250928083442.7955-1-chao@kernel.org>
References: <20250928083442.7955-1-chao@kernel.org>
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
---
v2:
- remove "_require_kernel_config CONFIG_F2FS_CHECK_FS"
- update comments a bit
 tests/f2fs/022     | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/022.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/f2fs/022
 create mode 100644 tests/f2fs/022.out

diff --git a/tests/f2fs/022 b/tests/f2fs/022
new file mode 100755
index 00000000..ed3b4f2b
--- /dev/null
+++ b/tests/f2fs/022
@@ -0,0 +1,54 @@
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
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"f2fs: fix to do sanity check on node footer for non inode dnode"
+
+_require_scratch_nocheck
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+
+# remove all mkfs options to avoid layout change of on-disk inode
+export MKFS_OPTIONS=""
+
+foo_path=$SCARTCH_MNT/foo
+bar_path=$SCARTCH_MNT/bar
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+touch $foo_path
+touch $bar_path
+$XFS_IO_PROG $foo_path -c "pwrite 0 8M"
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
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/022.out b/tests/f2fs/022.out
new file mode 100644
index 00000000..394c6a7c
--- /dev/null
+++ b/tests/f2fs/022.out
@@ -0,0 +1,2 @@
+QA output created by 022
+Silence is golden
-- 
2.40.1

