Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA82DE6FA
	for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905469; cv=none; b=EpKQPnbmELRc5eVEGm+7Igh9qwFdQHK6PHNxEKLtUseTTfSTmPHwK0HKNXOjr2u0fmLA3srhqCZxaSyzMv6wHOXZ9nVwhK7a1hbGiT1hAqPNLIHYKrQTUZprpMuGS1+CdM8qvm6Oe9KyeDdz3+Osxxd0qv2avVI7gvbR5qpZgZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905469; c=relaxed/simple;
	bh=SCX+YjKJkJ/VeztokqRniYPe2UUt02QoTX+IsmNZPMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOJZj8LvpaQdZRtJl5amKoytxfYtCpaqwMe9+ONelZMSGl+Pj2niqwjNkm9XWWVjbRmCnVQCNwofLA7k3Ax3kgdyrqh2l7wwgNVqvdslCD642baUuwuo+jTrLTYwxA7jzEXy+Sy4Rq0NsYYXUAdmPflZFOsk9dgstEy90v0KqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imYecZVx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imYecZVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD2EC4CEFB;
	Mon, 11 Aug 2025 09:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754905469;
	bh=SCX+YjKJkJ/VeztokqRniYPe2UUt02QoTX+IsmNZPMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imYecZVxMec/Sl1bQn8PRf2MG90/oUrXlZXAt0x+OMZMXEHAyDHKzHYPDoY/I3Tzj
	 phy0EN/RkRT3BLi9fbBx7W8iOUvlZWwU0yWzLovDRlq2tZVHD4aSM6FZk8wg7WxmFP
	 3lZ/CRLp88Mllh/JWcYGoRo8FGM8GK+6ve4farZBLlTDCAg1DW96gxPNM7bTIyK643
	 6wBtWHrztySEbbi3ZKKCmFd00GC+fGLsX+ydRJHKrmh2jufXXkKHetukkfmXH8+zj0
	 DgM9WLYSpl4/7qBS1/lsFdWYngHL+c976wu99JZORaGt6uzgsdCpgE9D1NeMSVD0Hi
	 6jdCHB7yoBlPQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs/019: do sanity check on mapping table
Date: Mon, 11 Aug 2025 17:44:14 +0800
Message-ID: <20250811094415.1053545-2-chao@kernel.org>
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
1. create a file
2. write file to create a direct node at special offset
3. use inject.f2fs to inject nid of direct node w/ ino of the inode
4. check whether f2fs kernel module will detect and report such
   corruption in the fil

Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/019     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/019.out |  2 ++
 2 files changed, 47 insertions(+)
 create mode 100755 tests/f2fs/019
 create mode 100644 tests/f2fs/019.out

diff --git a/tests/f2fs/019 b/tests/f2fs/019
new file mode 100755
index 00000000..0a02eb2f
--- /dev/null
+++ b/tests/f2fs/019
@@ -0,0 +1,45 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/019
+#
+# This is a regression test:
+# 1. create a file
+# 2. write file to create a direct node at special offset
+# 3. use inject.f2fs to inject nid of direct node w/ ino of the inode
+# 4. check whether f2fs kernel module will detect and report such
+#    corruption in the file
+#
+. ./common/preamble
+_begin_fstest auto quick rw compress
+
+_cleanup()
+{
+	_scratch_mkfs >> $seqres.full
+}
+
+_fixed_by_kernel_commit 77de19b6867f \
+	"f2fs: fix to avoid out-of-boundary access in dnode page"
+
+export MKFS_OPTIONS=""
+_require_scratch
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+
+testfile=$SCRATCH_MNT/testfile
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+xfs_io -f -c "pwrite 3738M 1M" -c "fsync" $testfile >> $seqres.full
+
+_scratch_unmount
+
+$F2FS_INJECT_PROG --node --mb addr --nid 5 --idx 937 --val 4 $SCRATCH_DEV >> $seqres.full
+
+_scratch_mount
+xfs_io -c "pread 3700M 40M" $testfile
+_scratch_unmount
+
+status=0
+exit
diff --git a/tests/f2fs/019.out b/tests/f2fs/019.out
new file mode 100644
index 00000000..2f7469e2
--- /dev/null
+++ b/tests/f2fs/019.out
@@ -0,0 +1,2 @@
+QA output created by 019
+pread: Structure needs cleaning
-- 
2.49.0

