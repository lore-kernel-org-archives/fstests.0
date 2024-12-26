Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A91D3194
	for <fstests@vger.kernel.org>; Thu, 26 Dec 2024 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735220209; cv=none; b=beBT5ZB+98nuDsZud0HcJ62F6XMT/uMJU2ECNnltWjqoXWljE0ZG0Ba/Cvg75FG86TcHdNECf7HecXezh1ijx8QCXb0QUmcpS0jN/OLcYi/Tft8AxH72bJNbMX761ZwsOSsmGwnk3Hd9k3F6yPTngn8AujzgzmYY0ggDe4Wqlbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735220209; c=relaxed/simple;
	bh=BYUglw7DJWN7duggSCr6mnasekJoaUVqgYsQ7B7Q5Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PYg3q9FLWGtEz+GUuiIhKPPe8JNyLzpXj46hLcL3GCCXpArS9beQWY5sk+KAR6FUZ3XtJYX56jWbViRqrxSLHSyvNpnaSJWwTj83VZaJ9JucpBGVIZiHl6WXWYPGToZrMJArAdFNLLwBd/HgHcE+CEA9QBG2qjmC6WUw7NV6dCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJpIIpJh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJpIIpJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8272C4CED4;
	Thu, 26 Dec 2024 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735220208;
	bh=BYUglw7DJWN7duggSCr6mnasekJoaUVqgYsQ7B7Q5Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJpIIpJh4WeKthGOv3lq/ddKyRreI1JC1F07iO4wa1FdV0QFoPNw642vHH8pCIK8c
	 CAxHjvCBaApE1N8jidry7739R8/JhxKm+Avcsd9Kx0SehNwr4W/FHcm+SFzFMYqpJt
	 32IfRjxRx+fhqby3z9EjCmSRBAR2w2vtVAVF5sj+3JYHz+2t2x5Q68W6tPAFWF4YQd
	 VUVtCw3tgi3n7mMk4MtaGSOQghGpUyGAwEzFjlKBo+Xhtvosgycee4hiDLJoN950Ao
	 6OU2iwMNzZJBUUfmMsBk56cXc8puL3ZZ3o13GaoyxbBa4QwtskaA1q61/zw45Gzf/X
	 caUGewOauVwtg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 2/2] f2fs/008: test snapshot creation/deletion on lvm device
Date: Thu, 26 Dec 2024 21:36:31 +0800
Message-Id: <20241226133631.9486-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241226133631.9486-1-chao@kernel.org>
References: <20241226133631.9486-1-chao@kernel.org>
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
v4:
- use "lvcreate -y" to force wiping stale data in device.
 tests/f2fs/008     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/008.out |  2 ++
 2 files changed, 59 insertions(+)
 create mode 100755 tests/f2fs/008
 create mode 100644 tests/f2fs/008.out

diff --git a/tests/f2fs/008 b/tests/f2fs/008
new file mode 100755
index 00000000..47696f2b
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
+$LVM_PROG lvcreate -y -L 1024m -n $lvname $vgname >>$seqres.full 2>&1
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

