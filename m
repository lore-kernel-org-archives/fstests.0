Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E781DA631
	for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125031; cv=none; b=JRTgdzoXxovsqfm54tKLigTsmZnCkMfuvoVNdi9iXtbVdU6yF0EqVY8bjnDfmPiZl3nQcpnVqxiV0ktzZWb8t+/wUMbPQhOcK78ObC5Zcqay0OmDgnkLs37KukdzVhUaYzeODpwnZRUhfRRiRhL9R7+f8rP2z8pO1eEVlbhNRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125031; c=relaxed/simple;
	bh=13NmpUuvQKu+mf37Nk9SCTUSkhBhhJMc0Dxpa9mrkDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X+tVpWB8HZk224cuTNHN5wj2aF2YtBAzbsZsTM+zNkDKwSJj2H4YAajal51OqNiYInDgHs5fScLc4q9MSUG6M/D9hUKju/hxo86tXakzNnJ9jb4iArroyUUvov64ph7zUmTGsKNqOooASqhm7xlKgSd+nE0nuVNqqyZzON7POqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rcjv5Ebu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rcjv5Ebu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BFAC4CEC3;
	Mon, 28 Oct 2024 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125030;
	bh=13NmpUuvQKu+mf37Nk9SCTUSkhBhhJMc0Dxpa9mrkDs=;
	h=From:To:Cc:Subject:Date:From;
	b=Rcjv5EbuumUE/S8e5ufISL4s5iOVmqP8klqvecKdUIfTqUfO+nvLZ2/Luf4fl5UEL
	 zazobn3iz6wUdQon5k8NelBnVYXzo/WIHsrzneQE7M/udrt7iuNaip5ZMhM+pyEuvC
	 FwECn7Yhl+0tx2yoMWWb/nKHzJ9r11JR8zPO934d3mie1dMYdwE5XhsK1CXGzWBElM
	 yYX5QHedl/WDLoCuGugBWU2foO8vLg3/2X5jdsFEd2fbSNij07ZAZAxCH4pWaQukB7
	 ZVX3mT/OaIHQmlnQuNQLkXEHpeyF0jcThhvLuR8OxvDFdEkNuNjeMq7ydLSADYFqIw
	 IcXXKAgmDVTrQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH v2] f2fs/005: add testcase to check checkpoint disabling functionality
Date: Mon, 28 Oct 2024 22:17:00 +0800
Message-Id: <20241028141700.1786745-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduce a regression test to check whether f2fs handles
dirty inode correctly when checkpoint is disabled in a corner case,
it may hang umount before the bug is fixed.

Cc: Qi Han <hanqi@vivo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add _fixed_by_kernel_commit()
- use _scratch_mkfs_sized() rather than formating size-specified
loop device
- code cleanup
 tests/f2fs/005     | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/005.out |  2 ++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/f2fs/005
 create mode 100644 tests/f2fs/005.out

diff --git a/tests/f2fs/005 b/tests/f2fs/005
new file mode 100755
index 00000000..a817d51a
--- /dev/null
+++ b/tests/f2fs/005
@@ -0,0 +1,47 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oppo.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/005
+#
+# This is a regression test to check whether f2fs handles dirty
+# inode correctly when checkpoint is disabled, it may hang umount
+# before the bug is fixed.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode."
+
+_require_scratch
+_scratch_mkfs_sized $((1024*1024*50)) >> $seqres.full
+
+# use mode=lfs to let f2fs always triggers OPU
+_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
+
+testfile=$SCRATCH_MNT/testfile
+tmpfile=$SCRATCH_MNT/tmpfile
+tmpdir=$SCRATCH_MNT/tmpdir
+
+dd if=/dev/zero of=$testfile bs=1M count=5 2>/dev/null
+mkdir $tmpdir
+touch $tmpfile
+sync
+
+# it dirties tmpdir inode by updating ctime,
+# but it doesn't moving the inode to gdirty_list.
+mv $tmpfile $tmpdir
+
+# it runs out of free segment
+dd if=/dev/zero of=$testfile bs=1M count=5 conv=notrunc conv=fsync 2>/dev/null
+
+_scratch_mount -o remount,checkpoint=enable
+
+# it may hang umount if tmpdir is still dirty during evict()
+_scratch_unmount
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/005.out b/tests/f2fs/005.out
new file mode 100644
index 00000000..a5027f12
--- /dev/null
+++ b/tests/f2fs/005.out
@@ -0,0 +1,2 @@
+QA output created by 005
+Silence is golden
-- 
2.40.1

