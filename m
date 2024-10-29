Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF11DED5A
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197613; cv=none; b=i9OuIyHRqA8Nz09RTlvnQj2n1B88o+Yb7g4IIO0aiDvDKhQpO10dbYlBFYVSNAwkTKpn5mKu0hjoT2IikfUC/OfnSDQcYJlYcLXEnk4LhMO+DgQZ12Y3BEm7JP148Aj0nE498ITRAJM5r9oNKO/yJwwVTeTJTTJRDhSfG4+nIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197613; c=relaxed/simple;
	bh=uhspLuIwFPfx6QENhvvgKhq9bsNMkOhFAw8IZSRMdqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QX/3LuLngBvAX4Haaban6Kcuhru6zVfWoYdB6KUxqitFiZFKy/U7rG5qFrcwUoIzz68M+UuxPR0Qoyg0fUEqpaawcy9s0NGS8uncATbAjlk6ocvHkHc+lwxXB82kGgyL8Qwg588cuzfYeHBEWEmTmsPxnRSzOBwttBxJl28ENEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDF8uIv1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDF8uIv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12829C4CEE5;
	Tue, 29 Oct 2024 10:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730197612;
	bh=uhspLuIwFPfx6QENhvvgKhq9bsNMkOhFAw8IZSRMdqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LDF8uIv149FAGVd5hpoVVtG2HrUGKJ8IYGi85LRMC5y6xn51dNvSTQ7Ih4pQnaHko
	 nxfCmHau1T7mM+hFZE4h2t+L8IoyeJT7TO8hKitD8XGz08D00AJrGvarULTay8hyiR
	 nSSelkABiKXooXzoBfYoTigFBrSimqqNGGFzT8vYsgRmF8cL2kQasE6ku6S1S9f1Cb
	 TgIwo2wKOxwNrdIJBCLoJoNH6uEKdLeX+NTT73Wx3hyHqFRjeCSUBaDVKt+cMR5eoI
	 WY6zW8A8iUeB5t1WMrkZDu71XM/A/0RY1bvThaM4CEchvs1VJD5g+sex085AQmLD/h
	 4rckYTcz4vZlg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH v4 2/2] f2fs/007: add testcase to check consistency of compressed inode metadata
Date: Tue, 29 Oct 2024 18:26:44 +0800
Message-Id: <20241029102644.4027606-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241029102644.4027606-1-chao@kernel.org>
References: <20241029102644.4027606-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

metadata of compressed inode should always be consistent after file
compression, reservation, releasement and decompression, let's add
a testcase to check it.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Qi Han <hanqi@vivo.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- fix typo
- add rvb tag from Zorro
 tests/f2fs/007     | 108 +++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/007.out |  16 +++++++
 2 files changed, 124 insertions(+)
 create mode 100755 tests/f2fs/007
 create mode 100644 tests/f2fs/007.out

diff --git a/tests/f2fs/007 b/tests/f2fs/007
new file mode 100755
index 00000000..6451d4b4
--- /dev/null
+++ b/tests/f2fs/007
@@ -0,0 +1,108 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oppo.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/007
+#
+# This is a regression test to check whether compressed metadata
+# can become inconsistent after file compression, reservation
+# releasement, and decompression.
+#
+. ./common/preamble
+_begin_fstest auto quick rw compress
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+        "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
+
+_require_scratch
+testfile_prefix=$SCRATCH_MNT/testfile
+fio_config=$tmp.fio
+
+cat >$fio_config <<EOF
+[write_compressed_data_30]
+name=mytest
+ioengine=psync
+rw=write
+direct=0
+bs=1M
+filesize=1M
+numjobs=1
+filename=${testfile_prefix}30
+buffer_compress_percentage=30
+
+[write_compressed_data_60]
+name=mytest
+ioengine=psync
+rw=write
+direct=0
+bs=1M
+filesize=1M
+numjobs=1
+filename=${testfile_prefix}60
+buffer_compress_percentage=60
+
+[write_compressed_data_90]
+name=mytest
+ioengine=psync
+rw=write
+direct=0
+bs=1M
+filesize=1M
+numjobs=1
+filename=${testfile_prefix}90
+buffer_compress_percentage=90
+EOF
+
+_require_fio $fio_config
+_scratch_mkfs "-f -O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
+_scratch_mount "-o compress_mode=user,compress_extension=*" >> $seqres.full
+
+echo -e "Run fio to initialize file w/ specified compress ratio" >> $seqres.full
+cat $fio_config >> $seqres.full
+$FIO_PROG $fio_config >> $seqres.full
+_scratch_unmount
+
+# force to repair if filesystem is corrupted
+export FSCK_OPTIONS="-f $FSCK_OPTIONS"
+
+for i in 30 60 90; do
+	testfile=$testfile_prefix$i
+
+	_scratch_mount "-o compress_mode=user" >> $seqres.full
+	$F2FS_IO_PROG compress $testfile >> $seqres.full
+	cblocks=`$F2FS_IO_PROG get_cblocks $testfile`
+	echo "compression ratio is: "$cblocks" / 256"
+
+	_scratch_unmount
+
+	# 1. check after compression
+	echo "check fs after compress"
+	_check_scratch_fs
+
+	_scratch_mount >> $seqres.full
+	$F2FS_IO_PROG release_cblocks $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 2. check after releasement
+	echo "check fs after release_cblocks"
+	_check_scratch_fs
+
+	_scratch_mount >> $seqres.full
+	$F2FS_IO_PROG reserve_cblocks $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 3. check after rservation
+	echo "check fs after reserve_cblocks"
+	_check_scratch_fs
+
+	_scratch_mount "-o compress_mode=user" >> $seqres.full
+	$F2FS_IO_PROG decompress $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 4. check after decompression
+	echo "check fs after decompress"
+	_check_scratch_fs
+done
+
+status=0
+exit
diff --git a/tests/f2fs/007.out b/tests/f2fs/007.out
new file mode 100644
index 00000000..a4b76300
--- /dev/null
+++ b/tests/f2fs/007.out
@@ -0,0 +1,16 @@
+QA output created by 007
+compression ratio is: 64 / 256
+check fs after compress
+check fs after release_cblocks
+check fs after reserve_cblocks
+check fs after decompress
+compression ratio is: 128 / 256
+check fs after compress
+check fs after release_cblocks
+check fs after reserve_cblocks
+check fs after decompress
+compression ratio is: 192 / 256
+check fs after compress
+check fs after release_cblocks
+check fs after reserve_cblocks
+check fs after decompress
-- 
2.40.1

