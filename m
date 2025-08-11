Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4A2DEA6F
	for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905472; cv=none; b=XmlTJE5mKuXeR4y0ncgm8UmgYh8mg3vcrY+jMeEK+0Xa6Gg4Dhb7JJTXd5Nwfn1ZfYZ1v/oCaZD/u9QPLJ3+TO7477xi+5ecuBzABoOPbdYkwxPOkP7nxtrDd/RFhjIy44y1yQxLCNg6NdiO2NXp61NxbP6qelqX7uzwAZigZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905472; c=relaxed/simple;
	bh=LKcb1574o+3PoXZ7MKHkrqJSJnJcs5pnN0cceyo12IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESWw9bZcIlKRfktb2to9WP8gpJYYGRAwdIRmaefeA/i3LmJYXdy+yJX+KjDYMRoP50RwtB6bpT91aWG8P1a8iv3aYZ+Uk7rhRd9Q4I0n1QvBtSygC7X3mjjrBWoxdc1x1L2TgAtQENuviWccbxbmSFvDs314nUPmJ0Np6ayBQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXoZ88IF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXoZ88IF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E76BC4CEED;
	Mon, 11 Aug 2025 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754905471;
	bh=LKcb1574o+3PoXZ7MKHkrqJSJnJcs5pnN0cceyo12IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXoZ88IFZJesgEgXhZJao5GyQtO1veDMVXUjly/qVnnXTvdoi8UqIhjtcqEavmTWM
	 fSn3V1cyjY0n3hWQwbyrrLwm88yIP0heb6dnLjfzihzGfoNfcGEFoc4TSynTnUHvlA
	 Vq2fh64Ou3bKsiPTGdL92SzQRf/LDxf74bY0N+x7cwtV4YWLrRB8ytexL38YLMfitz
	 2NKYTXe7V6fSlCdB+sjh9XBAm3GWKypecWLcpx7zdoMRTeK6mpghqvO9ogmqevSNyX
	 gqwCnIQJvyYA4r3M/QmmWy1LNb22HqOdeAwH+iYRMSrJflfNS1PTiaVVsyvgRtb5qU
	 ZfyDEtXHu/RmA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs/020: do sanity check on i_xattr_nid
Date: Mon, 11 Aug 2025 17:44:15 +0800
Message-ID: <20250811094415.1053545-3-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
In-Reply-To: <20250811094415.1053545-1-chao@kernel.org>
References: <20250811094415.1053545-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression test:
1. create directory
2. add a new xattr entry to create xattr node
3. use inject.f2fs to inject nid of xattr node w/ ino in a file
4. check whether f2fs kernel module will detect and report such
   corruption in the file

Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/020     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/020.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/f2fs/020
 create mode 100644 tests/f2fs/020.out

diff --git a/tests/f2fs/020 b/tests/f2fs/020
new file mode 100755
index 00000000..a6a08c8f
--- /dev/null
+++ b/tests/f2fs/020
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/020
+#
+# This is a regression test:
+# 1. create directory
+# 2. add a new xattr entry to create xattr node
+# 3. use inject.f2fs to inject nid of xattr node w/ ino in a file
+# 4. check whether f2fs kernel module will detect and report such
+#    corruption in the file
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+_cleanup()
+{
+	_scratch_mkfs >> $seqres.full
+}
+
+_fixed_by_kernel_commit 061cf3a84bde \
+	"f2fs: fix to do sanity check on ino and xnid"
+
+export MKFS_OPTIONS=""
+_require_scratch
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+
+testdir=$SCRATCH_MNT/testdir
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount "-o user_xattr,noinline_xattr"
+
+mkdir $testdir
+# add a new xattr entry to create xattr node
+setfattr -n user.abc -v 123 $testdir
+
+_scratch_unmount
+
+# inject i_xattr_nid w/ nid of inode node
+$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full
+
+_scratch_mount
+mkdir $testdir/dir >> $seqres.full 2>&1
+_scratch_unmount
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/020.out b/tests/f2fs/020.out
new file mode 100644
index 00000000..20d7944e
--- /dev/null
+++ b/tests/f2fs/020.out
@@ -0,0 +1,2 @@
+QA output created by 020
+Silence is golden
-- 
2.49.0

