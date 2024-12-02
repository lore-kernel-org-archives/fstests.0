Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4141D8DFB
	for <fstests@vger.kernel.org>; Mon,  2 Dec 2024 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139793; cv=none; b=I8Vb6jlfABG3y6smxXQUzu1r7BTfVygsMSIr4V857/KDc6pX+h4j2Z4zqRtkzn1yO1/vUzTDrlKM54mmPaZCJ50dyb8qGWamsGPkWvVMsjCCqFJhNYHpLns3tdRXZuc09S/bEi/inTIsuStKSY3M/4CiE7Jd3vcAzzB9R71o4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139793; c=relaxed/simple;
	bh=hspy3GOF2R29pUWjr+WGkU33VslKmEFqfIpp0rB2bWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jEjiT9SbKdw8fEeIMmacNiNELAwMxoOgrDHvf7R2U9ulm9n1vYM2vycRu2xmiziXwyWu5YOrtox7FvGkcWiCjUPwP+eoaLwKoNkT5M8OITJO6H+DFCGFGPCAOTfK2pq/EHD6VDKCAWZ1SwgiftplMDeWxRjR9gcZn/dOViDVy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dlt8EKPp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dlt8EKPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA02C4CED1;
	Mon,  2 Dec 2024 11:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733139793;
	bh=hspy3GOF2R29pUWjr+WGkU33VslKmEFqfIpp0rB2bWA=;
	h=From:To:Cc:Subject:Date:From;
	b=Dlt8EKPpR+AKXdYBnibD+j0F1C4Nk4DlCk0YLWLoQ8f2EEsaAMmYOKLGBA/j2xfuz
	 fo710RYwY9Ey+0VVh1UqDGpJrvyqROGGRhxPK8YtmFI0CiNKyf1dmj+d8OQjxQQVxo
	 QQ0P8vHURLlETtK4DrTa01xqrXW+wj0At8jI0Fa/XFOIG70+/WfepWN4wQ+YoLux0T
	 9cM+jdMFJfLaCGEASnz/J5+atGUDA3SPy8DHpmfShUDosi6DceW6OgokZmFUZA2mXu
	 SIrbRo6HCGjafpSerRBJy3uOJrVOOREreSWaaQx9s1oLKUprMs2NlYHeeZEYZziqB8
	 bu1xFUlXtFFUQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs/008: test snapshot creation/deletion on lvm device
Date: Mon,  2 Dec 2024 19:43:07 +0800
Message-Id: <20241202114307.2747-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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
 tests/f2fs/008     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/008.out |  2 ++
 2 files changed, 55 insertions(+)
 create mode 100755 tests/f2fs/008
 create mode 100644 tests/f2fs/008.out

diff --git a/tests/f2fs/008 b/tests/f2fs/008
new file mode 100755
index 00000000..a9a3f263
--- /dev/null
+++ b/tests/f2fs/008
@@ -0,0 +1,53 @@
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
+lvname=lv_$sed
+vgname=vg_$Sseg
+testfile=$SCRATCH_MNT/testfile
+
+_cleanup()
+{
+	$LVM_PROG lvremove -f /dev/mapper/$lvname-snapshot $vgname >>$seqres.full 2>&1
+	$LVM_PROG lvremove -f /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
+	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
+	$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
+}
+
+$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
+$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
+$LVM_PROG lvcreate -L 1024m -n $lvname $vgname >>$seqres.full 2>&1
+
+$MKFS_F2FS_PROG /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
+mount -o discard /dev/mapper/$vgname-$lvname $SCRATCH_MNT >>$seqres.full 2>&1
+
+dd if=/dev/zero of=$testfile bs=1M count=20 >>$seqres.full 2>&1
+sync
+rm $testfile
+sync
+
+# create a snapshot on lvm device
+$LVM_PROG lvcreate -L 1024m -s -n $lvname-snapshot /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
+umount $SCRATCH_MNT
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

