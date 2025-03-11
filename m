Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721D31EB9E8
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680284; cv=none; b=PtcteYD30aIlSPWYtEAz0IItD7nyafaQ0z7icJ94KoiPhgaoerSJVQXzqbkdNdxXWXGzgU6njD3O3KQ7H8HyWkAdjHJxDMz+I+4eH24dXyCYQDcLw+QyVQuNyegSTVlX2p11HKb+EGZnu7wEFIon93w61WzDjme67yPASl8Wh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680284; c=relaxed/simple;
	bh=XL3A7DGgzbEVQ+T7xxGaX1NshajX/nnAL3gi393T8K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fn8Do6BUCHAAYoDBXI6dDbVQohoh6KQjRiC6IuV2ovYEdJqH3XJoSUx7RTJ8ofURWhRj8pNx+MGnl8sNNNUsvBADEEdAqusY6Q6TYDzXZxpH50rMl5/zCrzLwxWipK0swRaAMehydNrj89I4Ls+CKG4S9ksxIUFvuQ76JuTMbgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAuGGNIA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAuGGNIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6592C4CEE9;
	Tue, 11 Mar 2025 08:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741680283;
	bh=XL3A7DGgzbEVQ+T7xxGaX1NshajX/nnAL3gi393T8K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAuGGNIAbeGfHSBK+GPbWZHNKmwGqdz6cJEHlGTZLBxevolrP6AsR7WkCmIHll+jN
	 QhS4wo2J6SaiteTVzx2J1/0U10XpKvSYF0fAgP91p7gN8Ol1G/uCeg0Szjm3VMRcmU
	 po8brzwLnaJyw6DMTvKs2h+wfgZW71ir7fGGrL2s77+p6RM0cj5Uw8mt5EQyFiH+k1
	 ilL/JBLZGIHKozD7LxluxU+kS1LNHQcQ0fi5DItB4lpTKHy3uVvybdlWIe/Nk1NNgW
	 GsSBlZFmTOgheegFAncJk6MmGfwkO6Gd4JvXAvUdfGnvSklB+3yhX8fFM76GVSczw5
	 5B25vbr6H+1ag==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 6/6] f2fs/009: detect and repair nlink corruption
Date: Tue, 11 Mar 2025 16:04:30 +0800
Message-ID: <20250311080430.3696582-6-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250311080430.3696582-1-chao@kernel.org>
References: <20250311080430.3696582-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression test to check whether fsck can handle corrupted
nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
and expects fsck.f2fs can detect such corruption and do the repair.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- check socket command
- add _cleanup to kill & wait background thread
- add commit title in _fixed_by_git_commit line
- clean up codes
 tests/f2fs/009     | 145 +++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/009.out |   2 +
 2 files changed, 147 insertions(+)
 create mode 100755 tests/f2fs/009
 create mode 100644 tests/f2fs/009.out

diff --git a/tests/f2fs/009 b/tests/f2fs/009
new file mode 100755
index 00000000..4f8b2079
--- /dev/null
+++ b/tests/f2fs/009
@@ -0,0 +1,145 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/009
+#
+# This is a regression test to check whether fsck can handle corrupted
+# nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
+# and expects fsck.f2fs can detect such corruption and do the repair.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+if [ ! -x "$(type -P socket)" ]; then
+	_notrun "Couldn't find socket"
+fi
+
+_require_scratch
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_command "$F2FS_FSCK_PROG" fsck.f2fs
+
+_fixed_by_git_commit f2fs-tools 958cd6e "fsck.f2fs: support to repair corrupted i_links"
+
+filename=$SCRATCH_MNT/foo
+hardlink=$SCRATCH_MNT/bar
+
+_cleanup()
+{
+	if [ -n "$pid" ]; then
+		kill $pid &> /dev/null
+		wait
+	fi
+}
+
+for ((i=0;i<14;i++)) do
+	echo "round: " $i >> $seqres.full
+
+	_scratch_mkfs >> $seqres.full
+	_scratch_mount
+
+	if [ $i == 0 ]; then
+		touch $filename
+		ino=`stat -c '%i' $filename`
+		nlink=0
+	elif [ $i == 1 ]; then
+		mkdir $filename
+		ino=`stat -c '%i' $filename`
+		nlink=1
+	elif [ $i == 2 ]; then
+		mknod $filename c 9 0
+		ino=`stat -c '%i' $filename`
+		nlink=0
+	elif [ $i == 3 ]; then
+		mknod $filename b 8 0
+		ino=`stat -c '%i' $filename`
+		nlink=0
+	elif [ $i == 4 ]; then
+		mkfifo $filename
+		ino=`stat -c '%i' $filename`
+		nlink=0
+	elif [ $i == 5 ]; then
+		socket -s $filename >> $seqres.full 2>&1 &
+		pid=$!
+		sleep 2
+		ino=`stat -c '%i' $filename`
+		kill $pid >> $seqres.full 2>&1
+		nlink=0
+	elif [ $i == 6 ]; then
+		ln -s $SCRATCH_MNT/empty $filename
+		ino=`stat -c '%i' $filename`
+		nlink=0
+	elif [ $i == 7 ]; then
+		# orphan inode
+		touch $filename
+		ino=`stat -c '%i' $filename`
+		$F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
+		stat $filename >> $seqres.full
+		rm $filename
+		$F2FS_IO_PROG shutdown 1 $SCRATCH_MNT/ >> $seqres.full
+		sleep 6
+		nlink=1
+	elif [ $i == 8 ]; then
+		# hardlink on file
+		touch $filename
+		ino=`stat -c '%i' $filename`
+		ln $filename $hardlink
+		nlink=0
+	elif [ $i == 9 ]; then
+		# hardlink on charactor
+		mknod $filename c 9 0
+		ino=`stat -c '%i' $filename`
+		ln $filename $hardlink
+		nlink=0
+	elif [ $i == 10 ]; then
+		# hardlink on blockdev
+		mknod $filename b 8 0
+		ino=`stat -c '%i' $filename`
+		ln $filename $hardlink
+		nlink=0
+	elif [ $i == 11 ]; then
+		# hardlink on pipe
+		mkfifo $filename
+		ino=`stat -c '%i' $filename`
+		ln $filename $hardlink
+		nlink=0
+	elif [ $i == 12 ]; then
+		# hardlink on socket
+		socket -s $filename >> $seqres.full 2>&1 &
+		pid=$!
+		sleep 2
+		ino=`stat -c '%i' $filename`
+		kill $pid >> $seqres.full 2>&1
+		ln $filename $hardlink
+		nlink=0
+	elif [ $i == 13 ]; then
+		# hardlink on symlink
+		ln -s $SCRATCH_MNT/empty $filename
+		ino=`stat -c '%i' $filename`
+		ln $filename $hardlink
+		nlink=0
+	fi
+
+	if [ $i != 7 ]; then
+		stat $SCRATCH_MNT/* >> $seqres.full
+	fi
+	echo "ino:"$ino >> $seqres.full
+	echo "nlink:"$nlink >> $seqres.full
+
+	_scratch_unmount
+
+	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV \
+		>> $seqres.full || _fail "fail to inject"
+
+	_check_scratch_fs >> $seqres.full 2>&1 && _fail "can't find corruption"
+	_repair_scratch_fs >> $seqres.full
+	_check_scratch_fs >> $seqres.full 2>&1 || _fail "fsck can't fix corruption"
+
+	_scratch_mount
+	_scratch_unmount
+done
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/009.out b/tests/f2fs/009.out
new file mode 100644
index 00000000..7e977155
--- /dev/null
+++ b/tests/f2fs/009.out
@@ -0,0 +1,2 @@
+QA output created by 009
+Silence is golden
-- 
2.48.1

