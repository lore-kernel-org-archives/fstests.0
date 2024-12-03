Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D61F428D
	for <fstests@vger.kernel.org>; Tue,  3 Dec 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230097; cv=none; b=iw5GUEVB8J+uQF7B/yMJcSTk5LcoLgRRU+QsmvMu/ShFjrI1XmRx64u+N/jafZGQZ5tpfxPrTWSQDtzJWARjGcgP5HnwlFpm3I54u4gk5QWoSetP//9R5WXg18zA0H+byI05DlvuiyZKeDCoQ8d2+nFE9ZUwzSz0C3CiXXh0ITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230097; c=relaxed/simple;
	bh=9kkOUppllqfErLKqYMj32kwHN14CE3JFkuSoBkCnMYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LkafA8yghnE+CCjqeOfofhVHaSnNaI5TuxQaglaU0vrujPkfbnPvvwkNo7tD9U4UxyntW42OQZA20x5h2yaur2IOj/6rW0ungQWdI+Vkwpf/+EJgBbyHpFBELSuHs0S3OdHDAETXgwwPBeavxvKnj4qvnJf6cHJ+vHtsZjD6uJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE/6VDhD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE/6VDhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F48C4CEDA;
	Tue,  3 Dec 2024 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733230097;
	bh=9kkOUppllqfErLKqYMj32kwHN14CE3JFkuSoBkCnMYU=;
	h=From:To:Cc:Subject:Date:From;
	b=mE/6VDhDGJ9exN82I3g4d+BT3qNBahu777RtHjJVbJdle0xHPrGGRb2l5TESsJO9/
	 OZCcKn9KZ6sRLv243FlTICcbd6MRBxv6jkTivLKAKLFN/7MoM1gbCUVapxm7n/3LtV
	 t93fpE2uNncMeR48Pm6GH7zAD/QjJ1Ra8SJ0hk+bgb15ec8DwYqfuPiAJLIJglxzJ0
	 Oaon4oWk8caw9y8FBJ0ngtMhexJMX3VslUW44u0jRk7RH8CMJqS4YL2Wp6ycl+bdQS
	 K5HbPXf14htqeIvwS/PWzrJKq1ONtv0smn2d5fp8pRa+z0Rsr8ZL7A0gyPkCkU4wc6
	 a2jAdGBnBbRag==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs/008: test snapshot creation/deletion on lvm device
Date: Tue,  3 Dec 2024 20:46:56 +0800
Message-Id: <20241203124657.4997-1-chao@kernel.org>
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
v2:
- fix typo
 tests/f2fs/008     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/008.out |  2 ++
 2 files changed, 55 insertions(+)
 create mode 100755 tests/f2fs/008
 create mode 100644 tests/f2fs/008.out

diff --git a/tests/f2fs/008 b/tests/f2fs/008
new file mode 100755
index 00000000..38581c7b
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
+lvname=lv_$seq
+vgname=vg_$seq
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

