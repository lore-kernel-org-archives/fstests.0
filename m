Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD41547FD
	for <fstests@vger.kernel.org>; Wed, 23 Oct 2024 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671374; cv=none; b=Gce4YXF9XZzemRy4rdKE0dUNCBGXl/8szgKQSua+PvCFwuCJkKPqZqohEk6WGkwZx3D80viReoZnUPOFUAUWp2d3mzz+d+divDKeyL1xJV8SCjct2GwJB6p2Ve07DxiAD7oKpxATDpL3ghgOq6HEExO1WzscuKMchdaF/HH7UuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671374; c=relaxed/simple;
	bh=ny96yE+u0tbc540OPl+68cxi48B5XhGbATbld3m9Zf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZX08Uesndg2v1GfXzJap8DNTakypX8nsaed7TsuJWDwmOtnIP+vrH6vQec1gNsmlyZFz0oz67nl6nnkHx1j513z6T5KGiAhFv87bbI2uL2sDdGoFDB32boCzq7If9hxP3kV6tq+le0aBvc9TWwfBVeIAhZez40K7+v0TVlCFto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO68x6pu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO68x6pu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749DBC4CECD;
	Wed, 23 Oct 2024 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729671374;
	bh=ny96yE+u0tbc540OPl+68cxi48B5XhGbATbld3m9Zf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aO68x6puPuyvAX9fExYgnnr6gVbl2DVv/nNC+5LVHw2aStd4sbDJTF0KNG74H8xmG
	 CmM/TcCTc1t7sOEVjNnvKnpSwkpYb+gbPT8t9EGfuTsQQQavPKBFa6+4exFZ79WW1+
	 GJf53si/dnz9lAMfl/hI9oKr7LJX5prZn2GSJPyq03/UJJmrSVgzun5kFDXqVb4C1g
	 4J4XW6pnGPLU/TUe48t9S1udOLJbykh7oI5tpdnekA1Iy/NeKn44DLNqeB9dVSYRzm
	 rnmFbt3mEPOXOKnxZVfv4Yg48cO8wPhwS84OUIhlTUTGax1zLuGwyjKVcWKqDpoXz1
	 k5y9NybdiSNxw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH v2 2/2] f2fs/007: add testcase to check consistency of compressed inode metadata
Date: Wed, 23 Oct 2024 16:16:02 +0800
Message-Id: <20241023081602.3806579-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241023081602.3806579-1-chao@kernel.org>
References: <20241023081602.3806579-1-chao@kernel.org>
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
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add _fixed_by_kernel_commit()
- code cleanup
- add error handling for _scratch_mkfs()
 tests/f2fs/007     | 116 +++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/007.out |   4 ++
 2 files changed, 120 insertions(+)
 create mode 100755 tests/f2fs/007
 create mode 100644 tests/f2fs/007.out

diff --git a/tests/f2fs/007 b/tests/f2fs/007
new file mode 100755
index 00000000..8979c21c
--- /dev/null
+++ b/tests/f2fs/007
@@ -0,0 +1,116 @@
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
+_require_scratch
+_require_fio $fio_config
+_scratch_mkfs "-f -O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
+_scratch_mount "-o compress_mode=user,compress_extension=*" >> $seqres.full
+
+echo -e "Run fio to initialize file w/ specified compress ratio" >> $seqres.full
+cat $fio_config >> $seqres.full
+$FIO_PROG $fio_config >> $seqres.full
+_scratch_unmount
+
+# force to repaire if filesystem is corrupted
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
+	_check_scratch_fs
+	if [ $? -ne 0 ]; then
+		_fail "filesystem becomes corrupted after compress"
+	fi
+
+	_scratch_mount >> $seqres.full
+	$F2FS_IO_PROG release_cblocks $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 2. check after releasement
+	_check_scratch_fs
+	if [ $? -ne 0 ]; then
+		_fail "filesystem becomes corrupted after release_cblocks"
+	fi
+
+	_scratch_mount >> $seqres.full
+	$F2FS_IO_PROG reserve_cblocks $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 3. check after rservation
+	_check_scratch_fs
+	if [ $? -ne 0 ]; then
+		_fail "filesystem becomes corrupted after reserve_cblocks"
+	fi
+
+	_scratch_mount "-o compress_mode=user" >> $seqres.full
+	$F2FS_IO_PROG decompress $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 4. check after decompression
+	_check_scratch_fs
+	if [ $? -ne 0 ]; then
+		_fail "filesystem becomes corrupted after decompress"
+	fi
+done
+
+status=0
+exit
diff --git a/tests/f2fs/007.out b/tests/f2fs/007.out
new file mode 100644
index 00000000..2ea71c18
--- /dev/null
+++ b/tests/f2fs/007.out
@@ -0,0 +1,4 @@
+QA output created by 007
+compression ratio is: 64 / 256
+compression ratio is: 128 / 256
+compression ratio is: 192 / 256
-- 
2.40.1

