Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29A6AB8
	for <fstests@vger.kernel.org>; Tue, 15 Oct 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728960690; cv=none; b=aJmP5LaVc9KEynAR1Hrmy5f4pIekUn39r7Q5EHDthiamIjx6UX3WsRr29oj5BNZridpTeiWOArR45PE6jCUdT4pcDqxe0Tu/cLcjWxZEjXQLqNQjbARpvBNcflVyHwBr5Jesd+nhXHBN8z0M0LAGR4YETxaDc97HUxp00AFB5EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728960690; c=relaxed/simple;
	bh=Tk/AWN8N3hXZ7c5itZX1115sbx+Ry+VXv7ESB2Mj4wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JxLmBPZs/JhX1VBRwJVd2Wk6UTONVzJwxMpU7Jp5cHHXLbQ+gDPjJRxFhB0dRIgbcO65qycIFs/pUOBLWfZ/U1yrYfFc3+rIWBPKr5+CK6St9o16iV+NiQQwacLKCF2UM1crGqT7ZuXalhjAkzI9zngsQcfJaOX5NxlX7J53nu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuIsZsQi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuIsZsQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7875AC4CEC3;
	Tue, 15 Oct 2024 02:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728960689;
	bh=Tk/AWN8N3hXZ7c5itZX1115sbx+Ry+VXv7ESB2Mj4wc=;
	h=From:To:Cc:Subject:Date:From;
	b=NuIsZsQiZCXwAyDb3AbPU44TCnAKmuX3wW86P4efeHQpjgjV9o6LAKfzNuUjE4F7z
	 /EO9uSYMD2ux0xpQmNv1QmMiMsFJlX9pvtoVRiVXriler7UlH8WYUnW5IPycUnTb+q
	 sgjehBdMNK4qoejxuNi/UvNTraagbbzsPxqviKtp4L+hELS08nEa4HNSEKlYIDnLtp
	 BMrgUgMftgUccpBlWkA8ejjzLxDQJ2UMo1L0uDI5D3ynEsFXpk9408bR/axSPY45R7
	 n9kZAd/Ff6FbUPlweBBgytjejQRN/rrSk5W+NYgEksLVbcLxgxRZjJUYGvfxmTpmRY
	 tN7HOOqxUqvnQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs/006: add testcase to check out-of-space case
Date: Tue, 15 Oct 2024 10:51:05 +0800
Message-Id: <20241015025106.3203676-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression test to check whether f2fs handles dirty
data correctly when checkpoint is disabled, if lfs mode is on,
it will trigger OPU for all overwritten data, this will cost
free segments, so f2fs must account overwritten data as OPU
data when calculating free space, otherwise, it may run out
of free segments in f2fs' allocation function, resulting in
panic.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/006     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/006.out |  6 ++++++
 2 files changed, 58 insertions(+)
 create mode 100755 tests/f2fs/006
 create mode 100644 tests/f2fs/006.out

diff --git a/tests/f2fs/006 b/tests/f2fs/006
new file mode 100755
index 00000000..b359ef8f
--- /dev/null
+++ b/tests/f2fs/006
@@ -0,0 +1,52 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oppo.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/006
+#
+# This is a regression test to check whether f2fs handles dirty
+# data correctly when checkpoint is disabled, if lfs mode is on,
+# it will trigger OPU for all overwritten data, this will cost
+# free segments, so f2fs must account overwritten data as OPU
+# data when calculating free space, otherwise, it may run out
+# of free segments in f2fs' allocation function, resulting in
+# panic.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_cleanup()
+{
+	rm -f $img
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
+
+mkdir $mnt
+dd if=/dev/zero of=$img bs=1M count=100 2>/dev/null
+$MKFS_F2FS_PROG -f $img >/dev/null 2>&1
+sync
+
+# use mode=lfs to let f2fs always triggers OPU
+mount -t $FSTYP -o loop,mode=lfs,checkpoint=disable:10%,noinline_dentry $img $mnt
+
+dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
+
+# it may run out of free space of f2fs and hang kernel
+dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
+dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
+
+mount -o remount,checkpoint=enable $mnt
+umount $mnt
+
+status=0
+exit
diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
new file mode 100644
index 00000000..a2c7ba48
--- /dev/null
+++ b/tests/f2fs/006.out
@@ -0,0 +1,6 @@
+QA output created by 006
+50+0 records in
+50+0 records out
+dd: error writing '/mnt/scratch_f2fs/f2fs.mnt/testfile': No space left on device
+3+0 records in
+2+0 records out
-- 
2.40.1

