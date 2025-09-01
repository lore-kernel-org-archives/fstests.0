Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15C1EE7C6
	for <fstests@vger.kernel.org>; Mon,  1 Sep 2025 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692223; cv=none; b=JP1I89olNbIZVeTp41/H+RVqDjZiI+EvBtrwGsSu5dWvpZDXRn4aok16teZhxWbyG1GeFOofhsvRgLjqxSFCrTAsS+z63gIjubi78qI3HnMYPI2Wt7jBZeW7EIWXy50H80Tx5CwiWq6Tea3Tn1pRI3vNXxm9pXNhpHhQYqC5Z/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692223; c=relaxed/simple;
	bh=PTR9olxR+6Cv0v/ngn9kPVgymR2ombpHO6ievh61MH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7/iLrTZDhoKChUsP02GaDvzxkXnzK82rWMSNhjE8ba1xRi3RspxbtaXAwBYi8WyxL7FRTLVfFd4b6MkVlO0GwYVYUjZi7swbNF9iMOsqB89HkhYkRqC0IMXGFIxC26IhZRWN04IMo9tzcFLRwY4jvlyeyakbR/rGUuNBbRtbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGddBssW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGddBssW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFBEC4CEF6;
	Mon,  1 Sep 2025 02:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756692222;
	bh=PTR9olxR+6Cv0v/ngn9kPVgymR2ombpHO6ievh61MH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGddBssWWAimjHdH4jnAkHd72XGEkdSP/98dCqxbUjV9+0btGK2cldnWqbI2qenl2
	 EZBaJSR5dR4A4DUkucubgWfSiQy4Goq/upg161vULmG4gRaBwXpXl1KadvFpakg2Zv
	 oZqzAMxyfJhFynkR3+VEsVdlCRsXUfb8JdTLK9K5eqaNBAd6a1Lg+9LBGz709ySj4i
	 i2YTiOSGP3vZ4HbSTN119oZBSgnHNw9dmilA2cYj2nZfmWzGa+k2F5oqIszijozus5
	 TMPmuJjmXbkeuWOuaxrT2hAB0zCFKR6mCbbQcASKQf5Stp48qZXmnNXE+KDzRx60wm
	 qI3XwJDZFIFAQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs/022: do sanity check on footer of non inode dnode
Date: Mon,  1 Sep 2025 10:03:31 +0800
Message-ID: <20250901020331.2171502-2-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
In-Reply-To: <20250901020331.2171502-1-chao@kernel.org>
References: <20250901020331.2171502-1-chao@kernel.org>
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
on corrupted dnode, result in panic in step 4).

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/022     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/022.out |  2 ++
 2 files changed, 54 insertions(+)
 create mode 100755 tests/f2fs/022
 create mode 100644 tests/f2fs/022.out

diff --git a/tests/f2fs/022 b/tests/f2fs/022
new file mode 100755
index 00000000..a5e19a71
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
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"f2fs: fix to do sanity check on node footer for non inode dnode"
+
+_require_scratch_nocheck
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_xfs_io_command "fpunch"
+_require_kernel_config CONFIG_F2FS_CHECK_FS
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
+# expect to trigger panic
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

