Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B9ECA
	for <fstests@vger.kernel.org>; Sat, 28 Oct 2023 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A9AB
	for <fstests@vger.kernel.org>; Fri, 27 Oct 2023 23:56:50 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SHVZK0G3MzpWXC;
	Sat, 28 Oct 2023 14:51:53 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 28 Oct
 2023 14:56:47 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <fstests@vger.kernel.org>
CC: <zlang@redhat.com>, <guaneryu@gmail.com>, <amir73il@gmail.com>,
	<ritesh.list@gmail.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH] ext4: Regression test of ext4_lblk_t overflow
Date: Sat, 28 Oct 2023 15:01:23 +0800
Message-ID: <20231028070123.971548-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

Append writes to a file approaching 16T and observe if a kernel crash is
caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
This is a regression test for commit bc056e7163ac ("ext4: fix BUG in
ext4_mb_new_inode_pa() due to overflow")

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 tests/ext4/062     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/062.out |  2 ++
 2 files changed, 55 insertions(+)
 create mode 100755 tests/ext4/062
 create mode 100644 tests/ext4/062.out

diff --git a/tests/ext4/062 b/tests/ext4/062
new file mode 100755
index 00000000..0ae4ed80
--- /dev/null
+++ b/tests/ext4/062
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 HUAWEI.  All Rights Reserved.
+#
+# FS QA Test No. 062
+#
+# Append writes to a file approaching 16T and observe if a kernel crash is
+# caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
+# This is a regression test for commit
+# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
+#
+. ./common/preamble
+_begin_fstest auto quick insert
+
+# real QA test starts here
+_supported_fs ext4
+_fixed_by_kernel_commit bc056e7163ac \
+	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
+
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "open"
+_require_xfs_io_command "pwrite"
+_require_scratch_size_nocheck $((100 * 1024))   # 100MB in KB
+
+# Initalize a 4k 100M ext4 fs
+dev_size=$((100 * 1024 * 1024))
+MKFS_OPTIONS="-b 4096 $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
+	>>$seqres.full 2>&1 || _fail "mkfs failed"
+
+_scratch_mount
+
+# Reserve 1M space
+$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full 2>&1
+
+# Create a file with logical block numbers close to overflow
+$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full 2>&1
+$XFS_IO_PROG -f -c "finsert 1M 16777203M" "${SCRATCH_MNT}/file" >> $seqres.full 2>&1
+
+# Filling up the free space ensures that the pre-allocated space is the reserved space.
+$XFS_IO_PROG -f -c "falloc 0 80388096" "${SCRATCH_MNT}/fill" >> $seqres.full 2>&1
+
+# Remove reserved space to gain free space for allocation
+rm -f ${SCRATCH_MNT}/tmp
+
+# Trying to allocate two blocks triggers BUG_ON.
+$XFS_IO_PROG -c "open -ad ${SCRATCH_MNT}/file" -c "pwrite -S 0xff 0 8192" >> $seqres.full 2>&1
+
+umount "${SCRATCH_MNT}"
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/062.out b/tests/ext4/062.out
new file mode 100644
index 00000000..a1578f48
--- /dev/null
+++ b/tests/ext4/062.out
@@ -0,0 +1,2 @@
+QA output created by 062
+Silence is golden
-- 
2.31.1

