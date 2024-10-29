Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083161DED5A
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197611; cv=none; b=gEdQCOrVy95hvKtXGsAHOMeVtimWx4N8qNKlmXcpEV0ipi0EAX1VAe6umRwit6w71D++pZp736H/hoFTs1gYGEYC1voIEsLovK5FJMJI8d98JYWyt0lmnpuJAdMTjwfJ/r/voGYsBQSXo1qDuozFhBaKtYP4O4FqEGKK24EaIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197611; c=relaxed/simple;
	bh=S2dJa1XpxHgGda35JR6CQ12ebtFG53YRSXoa6le1mmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uODU6A0b2o944nH8SBysfNOCkxYfbCuA8/nuhPWg3Os+AnRX9YRFew9Vv571J5Jb6fAAtyFSEYE/5LBnpMV5LjTVyGaENQFiPUqHjQpu8iHR42GhHbzfiYB7J6gEyopUR6xIwRvdxahsbAQabRpsmmH4UkxIF5+anHkU9pPNf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpKUUPbA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpKUUPbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2558BC4CECD;
	Tue, 29 Oct 2024 10:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730197610;
	bh=S2dJa1XpxHgGda35JR6CQ12ebtFG53YRSXoa6le1mmU=;
	h=From:To:Cc:Subject:Date:From;
	b=OpKUUPbA6uQD2ogIjxU17JqDUmIkBvK3gTK0dW1c2uzEQ1hH72mtcl+BMjUlrP7tR
	 NzWL/GUHsQ/GFFmwEIOmsRQT3WBGVpxABW8159quxbuC1Zi0RFzOLd4X1yz6dXcF4j
	 nJrUt6zyJnOFQra0e6yoogAIKj4Qma5jcKgYpJV4dizyjseSbuO7w9lSlp3Dwh14al
	 oXE6i7B1dkYk6FHMbAj30JlOolT4sos4MKJgluuolQof5B29cT58Zf9fOJP59Awgh8
	 dAxo6qWvDyPv22NcTslRyt2BNVPVl+LP5oGImPmQaPSDiiIWsjWkTtGKE2ikZY54Pk
	 JKboIfjb44V0Q==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v4 1/2] f2fs/006: add testcase to check out-of-space case
Date: Tue, 29 Oct 2024 18:26:43 +0800
Message-Id: <20241029102644.4027606-1-chao@kernel.org>
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
of free segments in f2fs' allocation function. If kernel config
CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
dd may encounter I/O error.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- check dmesg instead of unstable output from dd
 tests/f2fs/006     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/006.out |  2 ++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/f2fs/006
 create mode 100644 tests/f2fs/006.out

diff --git a/tests/f2fs/006 b/tests/f2fs/006
new file mode 100755
index 00000000..a9c823c1
--- /dev/null
+++ b/tests/f2fs/006
@@ -0,0 +1,42 @@
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
+# of free segments in f2fs' allocation function. If kernel config
+# CONFIG_F2FS_CHECK_FS is on, it will cause system panic, otherwise,
+# dd may encounter I/O error.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"f2fs: fix to account dirty data in __get_secs_required()"
+
+_require_scratch
+_scratch_mkfs_sized $((1024*1024*100)) >> $seqres.full
+
+# use mode=lfs to let f2fs always triggers OPU
+_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
+
+testfile=$SCRATCH_MNT/testfile
+
+dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
+
+# The 2nd dd might run out of space, and trigger a kernel warning or
+# hang on unfixed kernel
+dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >>$seqres.full 2>&1
+dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync >>$seqres.full 2>&1
+
+_scratch_remount checkpoint=enable
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
new file mode 100644
index 00000000..675c1b7c
--- /dev/null
+++ b/tests/f2fs/006.out
@@ -0,0 +1,2 @@
+QA output created by 006
+Silence is golden
-- 
2.40.1

