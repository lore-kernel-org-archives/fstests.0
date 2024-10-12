Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A1E1509B4
	for <fstests@vger.kernel.org>; Sat, 12 Oct 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728110; cv=none; b=ow1jEZy6gzOvfCtHVjYgai8y5sZSuYDInJuwdUpKvCwXNLPU3YJAlKKF6B366MjHLJJ2As2N4wSZgQqbu7PM+sarsbjOE9iIBs31ae7VV21vfRGLsc3PvGVLuWJDIwoK6pgCluYWsm1rhRZ/MVc7iwJnQFItqO1MqZvv18ak5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728110; c=relaxed/simple;
	bh=OdH4TBBkFTCEwViZ350PE+nPM3XleI6+E0e5t7R/34g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GhEGrtHjmTnkKgLLMnSLn+FlAkFkfPa7fCUbOLUujD9NrNIQpipD29uvS4bFdIZ+ffqhb6Z/psCjHiafkpyOM3CUmxPEm1yFcVJ/qDBdC5M8fDy4e25n57GI1pdxQxunFnmpZAZTwW35kBhc/YlNrdzQfqA0FtMGunuNfudZc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl8I4Bq5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl8I4Bq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB425C4CEC6;
	Sat, 12 Oct 2024 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728728110;
	bh=OdH4TBBkFTCEwViZ350PE+nPM3XleI6+E0e5t7R/34g=;
	h=From:To:Cc:Subject:Date:From;
	b=Vl8I4Bq59AlmRmq43BJsY5HjQa/0hbbAFkAIW9fImqm+VtBwFj6ErqkoeFEZWNpmI
	 7jlL9OaSLd2JpgYjNsRseJRc72HkE+lZqgab+/n4jWDk0o7uaH+PXtcY1L0LAHLeqq
	 r47DLy7FGWaOjbP+0Be+VjpzLi8o4neH0oGxr0eD4rxgzkCs9O8wgKvdSXAKG1ZmJ3
	 XYvoflqStZEniEdgFxm60aHIwxLgVbaXQbnRDQeQgu21k19PlLFQJlDQ7DC6oTyWoC
	 bIqgwH5sZkg893nZJCx3s0drHxCrvcERGWbpsKN+BkO+74BwtSz2oJyEJUXET/UNqg
	 +FUduMyuN/Y5g==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH] f2fs/005: add testcase to check checkpoint disabling functionality
Date: Sat, 12 Oct 2024 18:15:01 +0800
Message-Id: <20241012101501.377899-1-chao@kernel.org>
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
 tests/f2fs/005     | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/005.out |  1 +
 2 files changed, 60 insertions(+)
 create mode 100755 tests/f2fs/005
 create mode 100644 tests/f2fs/005.out

diff --git a/tests/f2fs/005 b/tests/f2fs/005
new file mode 100755
index 00000000..4faf1bb9
--- /dev/null
+++ b/tests/f2fs/005
@@ -0,0 +1,59 @@
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
+_cleanup()
+{
+	rm -f $img
+	rmdir $mnt
+	_scratch_unmount >> $seqres.full
+	cd /
+	rm -r -f $tmp.*
+}
+
+_require_scratch
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+img=$SCRATCH_MNT/f2fs.img
+mnt=$SCRATCH_MNT/f2fs.mnt
+testfile=$mnt/testfile
+tmpfile=$mnt/tmpfile
+tmpdir=$mnt/tmpdir
+
+mkdir $mnt
+dd if=/dev/zero of=$img bs=1M count=50 2>/dev/null
+$MKFS_F2FS_PROG -f $img >/dev/null 2>&1
+sync
+
+# use mode=lfs to let f2fs always triggers OPU
+mount -t $FSTYP -o loop,mode=lfs,checkpoint=disable:10%,noinline_dentry $img $mnt
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
+mount -o remount,checkpoint=enable $mnt
+
+# it may hang umount if tmpdir is still dirty during evict()
+umount $mnt
+
+status=0
+exit
diff --git a/tests/f2fs/005.out b/tests/f2fs/005.out
new file mode 100644
index 00000000..caa3c880
--- /dev/null
+++ b/tests/f2fs/005.out
@@ -0,0 +1 @@
+QA output created by 005
-- 
2.40.1

