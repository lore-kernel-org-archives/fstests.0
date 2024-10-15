Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201236AB8
	for <fstests@vger.kernel.org>; Tue, 15 Oct 2024 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728960692; cv=none; b=PJhF9J6+KW5yCiTWmpTugWDFZLOpoAGpnobAo5Omt2ZJaXvg0iKLgS30l0oZEVo34rzOaaY8wa9RgustzcZPbDpE7NUKj7wCKrara8eTFZvxQjl3NggISnnsE8+MFMcnWreVtR0ioAlkCK4A57zBWK8Fd9CnM67jtlbNfxR75CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728960692; c=relaxed/simple;
	bh=Y05EfT0ASAjNhTImYRlNb+wZ7uQbgocCROAhY9S4ZAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YR6SadNA55cEzAk6667dFw1Z0govst9BAyBiwTbHdM5lWW+JWpXFdm3E+uv5Djukn7mnMA6OSIEmbd8XMujWOqE/6n5LLvRHeoungoCfwch7d/8aBDtM4YE+MFrh+UR1e70VR9V4b3TXTHvwsgn3Ua5KFGHmPI09L9iz0wrdFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWKKJK7v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWKKJK7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8F1C4CED0;
	Tue, 15 Oct 2024 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728960691;
	bh=Y05EfT0ASAjNhTImYRlNb+wZ7uQbgocCROAhY9S4ZAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWKKJK7vFQn9sRsbVTHVJFDV0KhaqMyDA65XyYsIdE6xEcXx7KE3wklyotJ7CET06
	 6bIvhp+iaxew4tV+3FuQnvzI2Cz82mURHKCzMd2su6As/Davr92etlVH8Xe9uLxCjG
	 6lhQ+Ts+YgrJmNCUhLj/8lgcZJR8p7ShTrnXW0VqRTQRrLlNN0BOPhGzGQV1Dt3km1
	 aS8BfKruyBeHgn8c0JDh/3YJY7T/QLWs8r3kgice8P/2ImNvHZLDr4IuWgB5V8PTey
	 jhomZNcd/L+UrZWWjPGOxrkDdyRAKrNi+q3HpurZl6wM3p50ASaWu12Ud/75XG+KW5
	 ++/itwbhoM0Mg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH 2/2] f2fs/007: add testcase to check consistency of compressed inode metadata
Date: Tue, 15 Oct 2024 10:51:06 +0800
Message-Id: <20241015025106.3203676-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241015025106.3203676-1-chao@kernel.org>
References: <20241015025106.3203676-1-chao@kernel.org>
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
 tests/f2fs/007     | 116 +++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/007.out |   4 ++
 2 files changed, 120 insertions(+)
 create mode 100755 tests/f2fs/007
 create mode 100644 tests/f2fs/007.out

diff --git a/tests/f2fs/007 b/tests/f2fs/007
new file mode 100755
index 00000000..274be806
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
+_begin_fstest auto quick
+
+_cleanup()
+{
+	cd /
+	rm -r -f tmp.*
+}
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
+filename=/mnt/scratch_f2fs/testfile30
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
+filename=/mnt/scratch_f2fs/testfile60
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
+filename=/mnt/scratch_f2fs/testfile90
+buffer_compress_percentage=90
+EOF
+
+_require_fio $fio_config
+_require_scratch
+_scratch_mkfs "-f -O extra_attr,compression" >> $seqres.full
+_scratch_mount "-o compress_mode=user,compress_extension=*" >> $seqres.full
+
+echo -e "Run fio to initialize file w/ specified compress ratio" >> $seqres.full
+cat $fio_config >> $seqres.full
+$FIO_PROG $fio_config >> $seqres.full
+_scratch_unmount
+
+for i in 30 60 90; do
+	testfile=$testfile_prefix$i
+
+	_scratch_mount "-o compress_mode=user" >> $seqres.full
+	f2fs_io compress $testfile >> $seqres.full
+	cblocks=`f2fs_io get_cblocks $testfile`
+	echo "compression ratio is: "$cblocks" / 256"
+
+	_scratch_unmount
+
+	# 1. check after compression
+	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full
+	if [ $? -ne 0 ]; then
+		_fail "filesystem becomes corrupted after compress"
+	fi
+
+	_scratch_mount >> $seqres.full
+	f2fs_io release_cblocks $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 2. check after releasement
+	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full
+	if [ $? -ne 0 ]; then
+		_fail "filesystem becomes corrupted after release_cblocks"
+	fi
+
+	_scratch_mount >> $seqres.full
+	f2fs_io reserve_cblocks $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 3. check after rservation
+	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full
+	if [ $? -ne 0 ]; then
+		_fail "filesystem becomes corrupted after reserve_cblocks"
+	fi
+
+	_scratch_mount "-o compress_mode=user" >> $seqres.full
+	f2fs_io decompress $testfile >> $seqres.full
+	_scratch_unmount
+
+	# 4. check after decompression
+	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full
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

