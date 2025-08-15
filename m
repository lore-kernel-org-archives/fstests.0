Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54622A4F4
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245652; cv=none; b=FQ8/93Qq29fV0tZgQ4Smbtn2lOBnx+bxWCPoJpZmAGOWzRohciNs73ckuEqzbmFyi/1EwJX+hMVDWvgVntgV/GCh2/Hj0bYnOPd3dMbqVG8Bq+jUPwI6IpjKL8yWTtLt5SJMMFMH6uevQmEWRYVN0NGmT7XC3htyfexTV8AC9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245652; c=relaxed/simple;
	bh=QsHEVt06CDo9H2tnF/vlxmAvcKj6cilFpixxqBet9ME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkSIT30IUO7PcQBwesmXHYwNsydAZXQj2eQs6MWBbjqX2YuFCBOqIx4+QcojSlgdxX6JUYD0DwPvb+10sEV4ZaD7Z5UAaUJkpfotgMih4U2aB7PTRya+bBoDPiMf3K3ELbvl5aZ3BABgh72aDPew8hGC5KH5IsxSF/srLnpm7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTH08axz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTH08axz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FADFC4CEEB;
	Fri, 15 Aug 2025 08:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755245652;
	bh=QsHEVt06CDo9H2tnF/vlxmAvcKj6cilFpixxqBet9ME=;
	h=From:To:Cc:Subject:Date:From;
	b=qTH08axzFyJFIaLwJ0qtgZrQaOS+4tcepPdvEVi/JIi91C9n19UJEhoQ1aEISq+hw
	 OuLgRZXAFdpY0GaWUi8yys9wEYcAsu3XN8nlQ4iAkJc6ilcuCFPwwliN/aL9moBZlN
	 +kIxVPZUPdebIGll76TXZtlnEsiBokMawJYBDgdDRS5wBDNorNX+RyGGfNCQb+rRwv
	 GmxP5/0rCXYzOV6IEKt2drxlUWxBrMmBzgGocEMhKrALwBfeCUKBNX/9VK/BwnRFEX
	 oMv06xVlmQZ9dt1aqzwDz83mFHwNYz2BF/YcQeHG2+egyRTamZIKgqlyKCpl2JziCx
	 kqFW7XXRfwtSg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 1/3] f2fs/018: check data eof after partial truncation on compressed cluster
Date: Fri, 15 Aug 2025 16:14:03 +0800
Message-ID: <20250815081405.2523015-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression testcase, it is added to check below case
and its variants:
- write 16k data into compressed file (data will be compressed)
- truncate file to 12k (truncate partial data in compressed cluster)
- truncate file to 20k
- verify data in range of [12k, 16k] to see whether data is all zero
or not

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- introduce build_fio_config() for cleanup
- use run_check() to check return value of check_data_eof()
- add _cleanup
- use $XFS_IO_PROG instead of xfs_io
 tests/f2fs/018     | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/018.out |  2 ++
 2 files changed, 91 insertions(+)
 create mode 100755 tests/f2fs/018
 create mode 100644 tests/f2fs/018.out

diff --git a/tests/f2fs/018 b/tests/f2fs/018
new file mode 100755
index 00000000..8013042d
--- /dev/null
+++ b/tests/f2fs/018
@@ -0,0 +1,89 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/018
+#
+# This is a regression test to check whether page eof will be
+# zero or not after we truncate partial data in compressed
+# cluster.
+#
+. ./common/preamble
+_begin_fstest auto quick rw compress
+
+_fixed_by_kernel_commit ba8dac350faf \
+	"f2fs: fix to zero post-eof page"
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"f2fs: fix to zero data after EOF for compressed file correctly"
+
+_require_xfs_io_command "truncate"
+_require_scratch
+
+testfile=$SCRATCH_MNT/testfile
+fio_config=$tmp.fio
+
+build_fio_config()
+{
+	local offset=$1
+	local size=$2
+
+	cat >$fio_config <<EOF
+[verify-data]
+filename=$testfile
+rw=read
+verify=pattern
+verify_pattern=0x00
+do_verify=1
+verify_only
+offset=$offset
+size=$size
+numjobs=1
+EOF
+	cat $fio_config >> $seqres.full
+}
+
+build_fio_config 0 4k
+_require_fio $fio_config
+
+_cleanup()
+{
+       rm -f $testfile
+}
+
+_scratch_mkfs "-O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
+_scratch_mount "-o compress_extension=*" >> $seqres.full
+
+check_data_eof()
+{
+	local eof_start=$1
+	local eof_size=$2
+	local filesize=$3
+	local offset1=$4
+	local offset2=$5
+	local offset3=$6
+
+	rm -f $testfile
+
+	$XFS_IO_PROG -f -c "pwrite 0 $filesize" -c "fsync" $testfile >> $seqres.full
+	$XFS_IO_PROG -c "truncate $offset1" $testfile
+	$XFS_IO_PROG -c "truncate $offset2" $testfile
+
+	if [ "$offset3" ]; then
+		$XFS_IO_PROG -c "truncate $offset3" $testfile
+	fi
+
+	build_fio_config $eof_start $eof_size
+	$FIO_PROG $fio_config >> $seqres.full 2>&1
+
+	return $?
+}
+
+run_check check_data_eof 12k 4k 16k 12k 20k
+run_check check_data_eof 10k 6k 16k 10k 20k
+run_check check_data_eof 12k 4k 16k 8k 12k 20k
+run_check check_data_eof 10k 6k 16k 8k 10k 20k
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/018.out b/tests/f2fs/018.out
new file mode 100644
index 00000000..8849e303
--- /dev/null
+++ b/tests/f2fs/018.out
@@ -0,0 +1,2 @@
+QA output created by 018
+Silence is golden
-- 
2.49.0

