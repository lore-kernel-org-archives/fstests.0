Received: from mail.kernel.org ([198.145.29.99]:39040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbdKENZi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 5 Nov 2017 08:25:38 -0500
From: Chao Yu <chao@kernel.org>
Subject: [PATCH] generic/392: support to test fallocate
Date: Sun,  5 Nov 2017 20:39:35 +0800
Message-Id: <20171105123935.14702-1-chao@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, eguan@redhat.com
Cc: jaegeuk@kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

From: Chao Yu <yuchao0@huawei.com>

f2fs can skip isize updating in fsync(), since during mount, f2fs tries
to recovery isize according to valid block address or preallocated flag
in last fsynced dnode block.

However, fallocate() breaks our rule with setting FALLOC_FL_KEEP_SIZE
flag, since it can preallocated block cross EOF, once the file is fsynced,
in POR, we will recover isize incorrectly based on these fallocated
blocks.

This patch enables generic/392 to test fallocate case, in order to verify
whether filesystem will do incorrect recovery on isize.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 tests/generic/392     | 14 ++++++++++++++
 tests/generic/392.out |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/tests/generic/392 b/tests/generic/392
index 6922f7d2..f4ebeb2f 100755
--- a/tests/generic/392
+++ b/tests/generic/392
@@ -125,12 +125,26 @@ test_punch()
 	check_inode_metadata $1
 }
 
+test_falloc()
+{
+	echo "==== falloc $2 test with $1 ====" | tee -a $seqres.full
+	$XFS_IO_PROG -f -c "truncate 4202496"	\
+			-c "pwrite 0 4202496"	\
+			-c "fsync"		\
+			-c "falloc -k 4202496 $2"\
+			$testfile >/dev/null
+	check_inode_metadata $1
+}
+
 for i in fsync fdatasync; do
 	test_i_size $i 1024
 	test_i_size $i 4096
 	test_i_time $i
 	test_punch $i 1024
 	test_punch $i 4096
+	test_falloc $i 1024
+	test_falloc $i 4096
+	test_falloc $i 104857600
 done
 
 exit
diff --git a/tests/generic/392.out b/tests/generic/392.out
index 5d3330a6..d278bdf9 100644
--- a/tests/generic/392.out
+++ b/tests/generic/392.out
@@ -4,8 +4,14 @@ QA output created by 392
 ==== i_time test with fsync ====
 ==== fpunch 1024 test with fsync ====
 ==== fpunch 4096 test with fsync ====
+==== falloc 1024 test with fsync ====
+==== falloc 4096 test with fsync ====
+==== falloc 104857600 test with fsync ====
 ==== i_size 1024 test with fdatasync ====
 ==== i_size 4096 test with fdatasync ====
 ==== i_time test with fdatasync ====
 ==== fpunch 1024 test with fdatasync ====
 ==== fpunch 4096 test with fdatasync ====
+==== falloc 1024 test with fdatasync ====
+==== falloc 4096 test with fdatasync ====
+==== falloc 104857600 test with fdatasync ====
-- 
2.14.1.145.gb3622a4ee

