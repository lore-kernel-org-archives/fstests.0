Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0214B953
	for <fstests@vger.kernel.org>; Wed, 23 Oct 2024 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671372; cv=none; b=gshXlnEI3+tGEx/ul7W/W0B8z/IVp3+3Mzt1MnYn3OsoF3755Eo8N59eLrQVNi7KLlBVobB/tdSuTWBU84pHoxLaMKhTxE9mpTHLMejBDipomrhfLYzSfQZsB2xMyu9cWrKs1PBIVBFaVt7JGb4QoBIAyLV79Ftj2BBaFEtY3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671372; c=relaxed/simple;
	bh=KH/gWcSQ5ANQNjmXmGKqkINjKdTgHSCalEu+VVxzM4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QXEYxnDQiqPtxFTaDKsUolSvx2sR01EsFjj3pbLyX6qlfmo64ahl13faGiOMEeNtCUP5PytrvEAgj453RGnAZ4s3D5IS/KI2MCEHx0TBU2SdRXJ4hf4t2LvevsY2qkD1CK5b8LJewcFjKNcRTLAOYue6bT7xjkZR/nlp6DRXAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJBPCmuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJBPCmuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC91C4CEC6;
	Wed, 23 Oct 2024 08:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729671372;
	bh=KH/gWcSQ5ANQNjmXmGKqkINjKdTgHSCalEu+VVxzM4U=;
	h=From:To:Cc:Subject:Date:From;
	b=eJBPCmufUaeUA2pqPon5iP/uBjut/5s5logH6swRmeABCtLh+2XNyR0kmB+tTMK4B
	 a2hij41IONX97f5t1YyI6A2/ajXMV5sNDZ/UVxkNmiU33IRBm/F+Sd6lhXSNx0b37R
	 e51lTXe9zebFAkt1W6amt8GgQje95Ndbg4Zv0NLjg8W79pwbAbhXCwojYfuaokqnCX
	 i/L5QUg152mBhdsgmjHXz0GSRvHR8IX+N96Xp2tWHwRGAaOZUr0QGae/lDYEXEUr5v
	 dT/+5KyOAr0isPrsbfXtirFa1Z0gopD8u5iBTSthmCF8cY6SudLjL/O40m/wnYHTFj
	 N20hTvUV2Wrqg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2 1/2] f2fs/006: add testcase to check out-of-space case
Date: Wed, 23 Oct 2024 16:16:01 +0800
Message-Id: <20241023081602.3806579-1-chao@kernel.org>
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
v2:
- add _fixed_by_kernel_commit()
- use _scratch_mkfs_sized() rather than formating size-specified
loop device
- code cleanup
 tests/f2fs/006     | 38 ++++++++++++++++++++++++++++++++++++++
 tests/f2fs/006.out |  6 ++++++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/f2fs/006
 create mode 100644 tests/f2fs/006.out

diff --git a/tests/f2fs/006 b/tests/f2fs/006
new file mode 100755
index 00000000..63d00018
--- /dev/null
+++ b/tests/f2fs/006
@@ -0,0 +1,38 @@
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
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"f2fs: fix to account dirty data in __get_secs_required()"
+
+testfile=$SCRATCH_MNT/testfile
+
+_require_scratch
+_scratch_mkfs_sized $((1024*1024*100)) >> $seqres.full
+
+# use mode=lfs to let f2fs always triggers OPU
+_scratch_mount -o mode=lfs,checkpoint=disable:10%,noinline_dentry >> $seqres.full
+
+dd if=/dev/zero of=$testfile bs=1M count=50 2>/dev/null
+
+# it may run out of free space of f2fs and hang kernel
+dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
+dd if=/dev/zero of=$testfile bs=1M count=50 conv=notrunc conv=fsync
+
+_scratch_remount checkpoint=enable
+
+status=0
+exit
diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
new file mode 100644
index 00000000..0d7b3910
--- /dev/null
+++ b/tests/f2fs/006.out
@@ -0,0 +1,6 @@
+QA output created by 006
+50+0 records in
+50+0 records out
+dd: error writing '/mnt/scratch_f2fs/testfile': No space left on device
+3+0 records in
+2+0 records out
-- 
2.40.1

