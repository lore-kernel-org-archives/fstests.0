Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58448125D6
	for <fstests@vger.kernel.org>; Mon, 23 Dec 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964488; cv=none; b=LjJzHggGdGgfINZzW5yWJDI3pPdC3Z3IAj1ER0zx2MCFbu4nBIpIhr/MGwah7y1GRZXg8A0KrcFAgagRFLg0fzBHzArZfibu2WPPMI/w2j7Wyp6QfKiuxohC/LthKGgvYbbD603YKhwjGXcDjNDWBtKfc4jpv04eY8+tygV6vrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964488; c=relaxed/simple;
	bh=VoExVT7XSETeqfLPoMzHOXZlM95/se/ZF/joAL/Vt28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jD3fW3CFys7T6V6lVd8mfNI50KhR4zdHBgE5E+HFdSwLTtfHpny8KN9d+7DCRwX4xmYuM5eDi+HpLEOk1CSZ3KrPMfgiVIO97SDvmf2sbridcyAkXNDNLIbxdCC+Pk2Bb47k2PcaQQzXkUeo7qv0b9Zhj1kxkcopEeJnXEvwokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1KYSWAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1KYSWAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06BDC4CED6;
	Mon, 23 Dec 2024 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734964487;
	bh=VoExVT7XSETeqfLPoMzHOXZlM95/se/ZF/joAL/Vt28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1KYSWARLYFHMwTOj65ClztiCVzvCWL4Q+ugeAs0BK6ctDb28XWtHErG9rOgJ2wVT
	 Wh5TCfVjIyMrqfHmSXJPApWhA5vQ7ZErYS9C1CyEgHQNjRx7gmRA82GLfeMPcD67nM
	 XyqWg3T4rN/2e5z0K9Lgp8BOZOXW6ENIB3dEHiHl2DPCNTmsx3iTbYmDcwJJLpygSn
	 w1kONiZUU8rc3goNVf0YgumE2Vi3wWoMwDmiawH4dqKQ9if5n4DblaLN47N5zieGH5
	 3m7z8aE3yjNlUY9y34jlCHFdwXVWpvmdwT9daztsPJWAc1bh+cRgOylc6z4C1G2ar5
	 O6Gg9s2RPGdhQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 2/2] f2fs/008: test snapshot creation/deletion on lvm device
Date: Sat, 21 Dec 2024 16:23:45 +0800
Message-Id: <20241221082345.196029-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241221082345.196029-1-chao@kernel.org>
References: <20241221082345.196029-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduce a regression testcase to check whether
f2fs can handle discard correctly once underlying lvm device
changes to not support discard after user creates snapshot
on it.

Related bug was fixed by commit bc8aeb04fd80 ("f2fs: fix to
drop all discards after creating snapshot on lvm device")

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- rebase to last for-next branch
- update according to Zorro's comments.
 tests/f2fs/008     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/008.out |  2 ++
 2 files changed, 59 insertions(+)
 create mode 100755 tests/f2fs/008
 create mode 100644 tests/f2fs/008.out

diff --git a/tests/f2fs/008 b/tests/f2fs/008
new file mode 100755
index 00000000..b85e321c
--- /dev/null
+++ b/tests/f2fs/008
@@ -0,0 +1,57 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oppo.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/008
+#
+# This is a regression test to check whether f2fs can handle
+# discard correctly once underlying lvm device changes to not
+# support discard after user creates snapshot on it.
+#
+
+. ./common/preamble
+_begin_fstest auto quick rw
+
+_fixed_by_kernel_commit bc8aeb04fd80 \
+        "f2fs: fix to drop all discards after creating snapshot on lvm device"
+
+_require_scratch_nolvm
+_require_block_device $SCRATCH_DEV
+_require_command "$LVM_PROG" lvm
+
+lvname=lv_$seq
+vgname=vg_$seq
+testfile=$SCRATCH_MNT/testfile
+
+_cleanup()
+{
+	_unmount $SCRATCH_MNT >>$seqres.full 2>&1
+	$LVM_PROG lvremove -ff /dev/mapper/$lvname-snapshot $vgname >>$seqres.full 2>&1
+	$LVM_PROG lvremove -ff /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
+	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
+	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
+	_udev_wait --removed /dev/mapper/$vgname-$lvname
+	cd /
+	rm -f $tmp.*
+}
+
+$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
+$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
+$LVM_PROG lvcreate -L 1024m -n $lvname $vgname >>$seqres.full 2>&1
+_udev_wait /dev/mapper/$vgname-$lvname
+
+_mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
+_mount -o discard /dev/mapper/$vgname-$lvname $SCRATCH_MNT >>$seqres.full 2>&1
+
+dd if=/dev/zero of=$testfile bs=1M count=20 >>$seqres.full 2>&1
+sync
+rm -f $testfile
+sync
+
+# create a snapshot on lvm device
+$LVM_PROG lvcreate -L 1024m -s -n $lvname-snapshot /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/008.out b/tests/f2fs/008.out
new file mode 100644
index 00000000..dd68d5a4
--- /dev/null
+++ b/tests/f2fs/008.out
@@ -0,0 +1,2 @@
+QA output created by 008
+Silence is golden
-- 
2.40.1

