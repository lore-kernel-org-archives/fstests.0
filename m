Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8028E571
	for <fstests@vger.kernel.org>; Mon,  3 Nov 2025 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150924; cv=none; b=CEQtEO2B2FMSDaYVBYPqgd4VOCWe/5ZiSTD/ZdSsHFV4hQPPsX6KqSXD0UvOKQJ2bJPx2fRXkMGLfaims0wI2/y8ApN5OUnn7i8NgXvRBIFOQDAGlypTGEWM7DSz56+M6NQTx0ODRx4ZalUbjIRIH+GZHRJDoAyXm0ui4uIOx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150924; c=relaxed/simple;
	bh=g/JQOKGipvOMYcBy5UArWqQ/sYChVVWIl6QTs6ySaBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thezxNqs9aJHG6PwLiqLPzoZbWt4M6fSJTj0ImbQqqlipOvVCF+CJ4Atp5riaAwPBEzZ4Of7dqSNby47Y/YbJzinIzPWa52XXS9IEKR422Xpom9XAPpIgUvhas7xe1h4O2CQ2n8Hnnim+wfiMA2gNO/RnZTPXiRtX69/i4COIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYYvCPfh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYYvCPfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE8BC4CEE7;
	Mon,  3 Nov 2025 06:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762150923;
	bh=g/JQOKGipvOMYcBy5UArWqQ/sYChVVWIl6QTs6ySaBg=;
	h=From:To:Cc:Subject:Date:From;
	b=PYYvCPfhungoYhiPN3AlD76m0j+VshgoiK8EiACUZra2T9V+A2E+DqVKO3VpDa3Vb
	 +utrL6Tb7CPnyoc4kGypyvTNzhJ36Xs9ZKh0JITRanuXIx+LAtow3TO9kV/jcaC0y+
	 V/7n4KrD+CcXAPGGJbIRoXjcGe/Ms9NaGSVZYxZFd9G3KlHgFVMbcqXMftEa8qnyoF
	 8lfk/XhCLsPlSdNW+YBezzs3nX0Tpy38daPyQvNOaKUhGGOECwdtmoa92obtowRFAK
	 kYG0+STgFbRpaPOzjbPuJdUEpZXLsWI4ByYGVV/gCQ2qPaOgKuoxcnRPTQBf4Ahmex
	 sNQ21pDwiqoDw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs/023: test sanity check condition w/ error injection
Date: Mon,  3 Nov 2025 14:21:43 +0800
Message-ID: <20251103062143.2657116-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 5c1768b67250 ("f2fs: fix to do sanity check correctly on
i_inline_xattr_size"), f2fs should handle corrupted i_inline_xattr_size
correctly, let's add this regression testcase to check that.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- use _filter_scratch to filter scratch mountpoint
- check output message of inject.f2fs rather than return value
- add _require_attrs
- add f2fs/023 to attr group
- fail testcase if mkfs failed
 tests/f2fs/023     | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/023.out |  2 ++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/f2fs/023
 create mode 100644 tests/f2fs/023.out

diff --git a/tests/f2fs/023 b/tests/f2fs/023
new file mode 100755
index 00000000..33108421
--- /dev/null
+++ b/tests/f2fs/023
@@ -0,0 +1,49 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu <chao@kernel.org>
+#
+# FS QA Test No. f2fs/023
+#
+# This testcase tries to inject fault into inode.i_inline_xattr_size,
+# and check whether sanity check of f2fs can handle fault correctly.
+#
+
+. ./common/preamble
+. ./common/attr
+. ./common/filter
+_begin_fstest auto quick rw attr
+
+_fixed_by_kernel_commit 5c1768b67250 \
+        "f2fs: fix to do sanity check correctly on i_inline_xattr_size"
+
+_require_attrs
+_require_scratch_nocheck
+_require_inject_f2fs_command node i_inline
+_require_inject_f2fs_command node i_inline_xattr_size
+
+testfile=$SCRATCH_MNT/testfile
+
+# remove all mkfs options to avoid layout change of on-disk inode
+export MKFS_OPTIONS=""
+
+_scratch_mkfs "-O extra_attr,flexible_inline_xattr" >> $seqres.full || _fail "mkfs failed"
+_scratch_mount "-o inline_xattr_size=512" >>$seqres.full 2>&1
+touch $testfile
+_scratch_unmount
+
+# inject .i_inline field: clear F2FS_EXTRA_ATTR bit
+output=`$F2FS_INJECT_PROG --node --mb i_inline --nid 4 --val 0x1 $SCRATCH_DEV`
+echo "$output" >> $seqres.full
+echo "$output" | grep "unknown or unsupported member" && _fail "i_inline is unsupported"
+
+# inject .i_inline_xattr_size field from 512 to 2048
+output=`$F2FS_INJECT_PROG --node --mb i_inline_xattr_size --nid 4 --val 2048 $SCRATCH_DEV`
+echo "$output" >> $seqres.full
+echo "$output" | grep "unknown or unsupported member" && _fail "i_inline_xattr_size is unsupported"
+
+_scratch_mount
+
+$GETFATTR_PROG -n user.test "$testfile" 2>&1 | _filter_scratch
+
+status=0
+exit
diff --git a/tests/f2fs/023.out b/tests/f2fs/023.out
new file mode 100644
index 00000000..f9635d38
--- /dev/null
+++ b/tests/f2fs/023.out
@@ -0,0 +1,2 @@
+QA output created by 023
+getfattr: SCRATCH_MNT/testfile: Structure needs cleaning
-- 
2.49.0

