Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144D3126
	for <fstests@vger.kernel.org>; Sun, 19 Nov 2023 22:59:26 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SYdZQ1dwrz1P8b3;
	Mon, 20 Nov 2023 14:55:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 Nov
 2023 14:59:23 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <fstests@vger.kernel.org>
CC: <zlang@redhat.com>, <guaneryu@gmail.com>, <amir73il@gmail.com>,
	<ritesh.list@gmail.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2] ext4: Regression test of ext4_lblk_t overflow
Date: Mon, 20 Nov 2023 15:03:27 +0800
Message-ID: <20231120070327.1922631-1-libaokun1@huawei.com>
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
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

Append writes to a file approaching 16T and observe if a kernel crash is
caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
This is a regression test for commit bc056e7163ac ("ext4: fix BUG in
ext4_mb_new_inode_pa() due to overflow")

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	Changes to make the use case more generic, not just for testing
	ext4.(ext4 and xfs have been tested)

 tests/generic/737     | 55 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/737.out |  2 ++
 2 files changed, 57 insertions(+)
 create mode 100755 tests/generic/737
 create mode 100644 tests/generic/737.out

diff --git a/tests/generic/737 b/tests/generic/737
new file mode 100755
index 00000000..a65c448b
--- /dev/null
+++ b/tests/generic/737
@@ -0,0 +1,55 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 HUAWEI.  All Rights Reserved.
+#
+# FS QA Test No. 737
+#
+# Append writes to a file approaching 16T and observe if a kernel crash is
+# caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
+# This is a regression test for commit
+# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
+#
+#set -x
+. ./common/preamble
+. ./common/populate
+_begin_fstest auto quick insert prealloc
+
+# real QA test starts here
+_fixed_by_kernel_commit bc056e7163ac \
+	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
+
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "finsert"
+
+# Initalize a 4k 100M fs
+dev_size=$((100 * 1024 * 1024))
+_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1 || _fail "mkfs failed"
+
+_scratch_mount
+blksz="$(_get_block_size ${SCRATCH_MNT})"
+_require_odirect $blksz
+
+# Reserve 1M space
+$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full
+
+# Create a file (~16T) with logical block numbers close to overflow
+$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full
+insert_size=$((blksz * 4096 - 10 - 3))
+$XFS_IO_PROG -f -c "finsert 1M ${insert_size}M" "${SCRATCH_MNT}/file" >> $seqres.full
+
+# Filling up the free space ensures that the pre-allocated space is the reserved space.
+nr_free=$(stat -f -c '%f' ${SCRATCH_MNT})
+_fill_fs $((nr_free * blksz)) ${SCRATCH_MNT}/fill $blksz 0 >> $seqres.full 2>&1
+sync
+
+# Remove reserved space to gain free space for allocation
+rm -f ${SCRATCH_MNT}/tmp
+
+# Trying to allocate two blocks triggers BUG_ON.
+$XFS_IO_PROG -c "open -ad ${SCRATCH_MNT}/file" -c "pwrite -S 0xff 0 8192" >> $seqres.full
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/737.out b/tests/generic/737.out
new file mode 100644
index 00000000..67b83d78
--- /dev/null
+++ b/tests/generic/737.out
@@ -0,0 +1,2 @@
+QA output created by 737
+Silence is golden
-- 
2.31.1

