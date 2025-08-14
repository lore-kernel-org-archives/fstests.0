Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA02F39C0
	for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162441; cv=none; b=JjeqP+yGPt/3jG/TM5jY7ttvqmSE2XnNzgYgA5vLuVHlnngb33Wf8AJX+klQiy0sZzcX+RBi2zWsJRiohU+r/W/PfcmpI+4wBqEKhvyoVAzrvY4cOc5kCcmhZKnnWIDRuP3uv0oxU1bWCbENIwo7wpzDqMYfzMFG9s0YIysG2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162441; c=relaxed/simple;
	bh=qkKDvLSf4uMSfrwG1DW03hrJDPS0n39bGOJKm8+9eUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXZ7DuC70X+J4bbWIneQcBC8a/d57/+8bU08itwj3cyufiNP8DWBWlhip3bV4w1NIL/af3se7UJECAR/FknK9KoebHU1iR85Pvgvc5i7A0Yzume9U4kbzrrgbYXCBPOYMJHrffu33x1cY96YGjJjHgkwhF6FzxLBaz3/fmRu7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNpVmwyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNpVmwyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C345AC4CEED;
	Thu, 14 Aug 2025 09:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162441;
	bh=qkKDvLSf4uMSfrwG1DW03hrJDPS0n39bGOJKm8+9eUo=;
	h=From:To:Cc:Subject:Date:From;
	b=oNpVmwyKVtZB5XyBSUwsPWdZwBbfQ2fT8WVRbKsNt7ZcExWRj9Jou7XcHbnpblcKy
	 fYwEJQCZUWAyJ4hd34pFiBDPMnKlPCUMTB3xbscjY9Ixo+ibbXW+vAa9WOKOemKjYF
	 EdAqCX1uEuxsK1VOdwOWvyhnwgp9dzy33M2yff7TDTkbaffizodFzDWgLMoHusON5l
	 v6BqsfbdYteGSGICDqO7IBv1QIDPJOZ/oIeTOD74Vtb9SckFdv8+aje61BKtomtvnT
	 hBtXO85VMyW0TcE5jGTGSQ73SjUrdsTep7BCnl3meYyYI6odeIuaNdxxtmTng4cUX/
	 A0C3DdUgSa6gg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 1/3] f2fs/018: check data eof after partial truncation on compressed cluster
Date: Thu, 14 Aug 2025 17:07:10 +0800
Message-ID: <20250814090712.2119455-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
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
v2:
- add missing _require_xfs_io_command "truncate"
- add missing _require_fio $fio_config
- use $XFS_IO_PROG instead of xfs_io
- avoid mkfs&mount .. umount for each round test
 tests/f2fs/018     | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/018.out |  2 ++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/f2fs/018
 create mode 100644 tests/f2fs/018.out

diff --git a/tests/f2fs/018 b/tests/f2fs/018
new file mode 100755
index 00000000..e1047f78
--- /dev/null
+++ b/tests/f2fs/018
@@ -0,0 +1,77 @@
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
+cat >$fio_config <<EOF
+[global]
+filename=$testfile
+rw=read
+verify=pattern
+verify_pattern=0x00
+do_verify=1
+verify_only
+offset=0
+size=4k
+numjobs=1
+EOF
+_require_fio $fio_config
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
+
+	$XFS_IO_PROG -f -c "pwrite 0 $filesize" -c "fsync" $testfile >> $seqres.full
+	$XFS_IO_PROG -c "truncate $offset1" $testfile
+	$XFS_IO_PROG -c "truncate $offset2" $testfile
+
+	if [ "$offset3" ]; then
+		xfs_io -c "truncate $offset3" $testfile
+	fi
+
+	$FIO_PROG --name=verify-data --filename=$testfile --rw=read --verify=pattern \
+		--verify_pattern=0x00 --do_verify=1 --verify_only --offset=$eof_start \
+		--size=$eof_size >> $seqres.full 2>&1 || _fail "eof data is not zero"
+
+	rm -f $testfile
+}
+
+check_data_eof 12k 4k 16k 12k 20k
+check_data_eof 10k 6k 16k 10k 20k
+check_data_eof 12k 4k 16k 8k 12k 20k
+check_data_eof 10k 6k 16k 8k 10k 20k
+
+_scratch_unmount
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

