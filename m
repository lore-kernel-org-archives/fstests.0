Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DCB259C87
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245656; cv=none; b=EdNJnwtUr3a8GY6BYPHmZpfpoAGJG2/P32OKicchWA4gFvuYwwSNsZ+5ufY/PxSyIsaQztTlVYwE4365HXdGqc/VIZor6FjYuPxK2jpOqmMx5zlJ+8PMF1JJtoxzcrYOuxfypUBj0j/y59ttYwRtGKqb+ITH7bnNLDNqSsEdbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245656; c=relaxed/simple;
	bh=g9W+KR8VTvP30/K9dU4YxJpyh9Nh4m0whgOQj9vtep4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvvoAu0jKRivqSJAv0uxCnb+1ovkmibr9lcnw1xj9l03Z8HNeF8sK6vwEjwtyM9/LUNqlWU1vtbU7y4mto01Cw6BbJTGwMcj4Y4VlG9KIRCbH8rwuP9fzQxKsYHCl/qNq75h/LUui8bzkVuhBryLidBW7Ljp4y8OAlUxSD0VRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe1ZY7oc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe1ZY7oc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C08C4CEEB;
	Fri, 15 Aug 2025 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755245656;
	bh=g9W+KR8VTvP30/K9dU4YxJpyh9Nh4m0whgOQj9vtep4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xe1ZY7ocA4eVqD0VIZOqT0p0FLTSczacl0u+lLog0Mn0ZJnsUscUDf9EAx+Zy/yud
	 fT4r45qYWpJplFkdiSRvcoxD9eF7HAbgDRh6kBW1MqUke3FnYLItZIp+tO4Gl+NY64
	 0nu6Gs3oEPfAjb/zm31fsPTBAdhebGfTAAGdIGbbbkIrO2vx87+HTDdt8mMfWVrhjs
	 PR6Bx9oUH+0fWoMTVu+i1ibwvOV3D0ZlzhzNa/AxY3qvI/jNvvm5KNVDG0Ln3GvPlB
	 CiTGLPyal3xcc5MlV3FICrYcXHipQdNxajm0yKnhOf5GdQ5w+5PbBSIUTNcqOwuXqG
	 hIQF1is1ndlpg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 3/3] f2fs/020: do sanity check on i_xattr_nid
Date: Fri, 15 Aug 2025 16:14:05 +0800
Message-ID: <20250815081405.2523015-3-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250815081405.2523015-1-chao@kernel.org>
References: <20250815081405.2523015-1-chao@kernel.org>
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

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- fix mount option
- check return value of inject.f2fs
 tests/f2fs/020     | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/020.out |  2 ++
 2 files changed, 53 insertions(+)
 create mode 100755 tests/f2fs/020
 create mode 100644 tests/f2fs/020.out

diff --git a/tests/f2fs/020 b/tests/f2fs/020
new file mode 100755
index 00000000..38bc6582
--- /dev/null
+++ b/tests/f2fs/020
@@ -0,0 +1,51 @@
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
+. ./common/attr
+
+_fixed_by_kernel_commit 061cf3a84bde \
+	"f2fs: fix to do sanity check on ino and xnid"
+
+_require_scratch_nocheck
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_attrs user
+
+# remove all mkfs options to avoid layout change of on-disk inode
+export MKFS_OPTIONS=""
+
+testdir=$SCRATCH_MNT/testdir
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount "-o user_xattr,noinline_xattr"
+
+mkdir $testdir
+# add a new xattr entry to create xattr node
+$SETFATTR_PROG -n user.abc -v 123 $testdir
+
+_scratch_unmount
+
+# inject i_xattr_nid w/ nid of inode node
+$F2FS_INJECT_PROG --node --mb i_xattr_nid --nid 4 --val 4 $SCRATCH_DEV >> $seqres.full || _fail "failed to inject"
+
+_scratch_mount "-o acl,user_xattr"
+# may potentially trigger a deadlock w/ double inode_lock on parent's inode
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

