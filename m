Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8E2DE200
	for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905467; cv=none; b=PMODFsISUGHmbv1QS8hjTxJIArpiet1eubSAeCCsprR8u8Aod8S3D9M/0QSyadN6ztzizJu+RzKoGJe14RlWU9R+o2cU9i4wrX9X60ZBbkyIVhEX4EY/Hw1kldFzOnSG+ihKpRB0tFwuuG2mGqPgUTBHOgKzEteglZjMXaKJH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905467; c=relaxed/simple;
	bh=zq73lEqMNIN5nVGXtc894pn3tXcy2I8u6DhVq5U9hvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zk5FdBLRXAV5xRTekYwF/KeEy8gjt6Mjje7/RKPj+UhITCU5W8fxr6zP7iq+D1vbow15jCl90Wyc/IECaPZmUTXbmfyro+GqN5gNe7LZ94Rh9ms47Cm9F7/4Dk6f8wvaHSAdv54epJMrKg9XCe+vy4zE1trSDbnpOykiDP9m4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUsOPRQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUsOPRQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F2CC4CEF7;
	Mon, 11 Aug 2025 09:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754905466;
	bh=zq73lEqMNIN5nVGXtc894pn3tXcy2I8u6DhVq5U9hvU=;
	h=From:To:Cc:Subject:Date:From;
	b=BUsOPRQ3tnCzSbSTt1LIpiMwqQam093jZv0o6uhtpHBqUTQd5kDBRIrvDDu6MuyXq
	 5wLtH6L0d4ieZywdBCZW4VkPgd5QCw+skhgeRiElPsqZl7ucdD8VkFPSvt2GY9SbNm
	 O8zdySABRDW/W0GndWa9XAGGX8l/BUzJwROmwK1BSV/wbT/WFrAUFRgf3YTfX7TUld
	 V1q6n02f8Sb3K9Qwx3aeaQJzoyWhK38f23p0vwQ4tf3fSCdbJSmrdYuN/29cZDnhL/
	 9eX0L1O8Ac6PTlxvc5Xd0nmbBRdoE0XUFaX+oxCCXgdaRjt0YtWGp2NSzqDcS7zH4C
	 zPwYb15xhh1uw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs/018: check data eof after partial truncation on compressed cluster
Date: Mon, 11 Aug 2025 17:44:13 +0800
Message-ID: <20250811094415.1053545-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
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
 tests/f2fs/018     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/018.out |  2 ++
 2 files changed, 60 insertions(+)
 create mode 100755 tests/f2fs/018
 create mode 100644 tests/f2fs/018.out

diff --git a/tests/f2fs/018 b/tests/f2fs/018
new file mode 100755
index 00000000..ca727d24
--- /dev/null
+++ b/tests/f2fs/018
@@ -0,0 +1,58 @@
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
+_require_scratch
+_require_fio
+
+testfile=$SCRATCH_MNT/testfile
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
+	_scratch_mkfs "-O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
+	_scratch_mount "-o compress_extension=*" >> $seqres.full
+
+	xfs_io -f -c "pwrite 0 $filesize" -c "fsync" $testfile >> $seqres.full
+	xfs_io -c "truncate $offset1" $testfile
+	xfs_io -c "truncate $offset2" $testfile
+
+	if [ "$offset3" ]; then
+		xfs_io -c "truncate $offset3" $testfile
+	fi
+
+	$FIO_PROG --name=verify-data --filename=$testfile --rw=read --verify=pattern \
+		--verify_pattern=0x00 --do_verify=1 --verify_only --offset=$eof_start \
+		--size=$eof_size >> $seqres.full 2>&1 || _fail "eof data is not zero"
+	_scratch_unmount
+}
+
+check_data_eof 12k 4k 16k 12k 20k
+check_data_eof 10k 6k 16k 10k 20k
+check_data_eof 12k 4k 16k 8k 12k 20k
+check_data_eof 10k 6k 16k 8k 10k 20k
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

