Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EED2E3386
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249108; cv=none; b=M39I+jqLv0Q1bEk706nJpO9RVyeQJ8onsmKosGURSXsVrN/1uA38nxh1k5PHOMVBkcF6O0/KE5zvZIu8Hnxw455TMxHgOGVYF2Jy7q0baBlPb9G80GDA3Gpdi3nrkKPG0u/7YKsmiKJt7QGyQAyR7h69fNiWM0020AkAsvhkFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249108; c=relaxed/simple;
	bh=kyXXro/OE6+H623m77kqlXTNMmRNhmQ9EpAFZfE9lXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSQzKohjSmhE5brnV5T1LZyv5f9X0f5p+bgbx/6Ov8yo8YnPby/znxSgwmJb+Zjf5iqz/Q68/FHfhiFunyYCeJdjuhAy49hp/ANkH21aYjcP08h1qlc443rGJFt91In9HRuUQjNR8G4ubciH1Dn2oiepyPHYVDYAOl8nqEAb60c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJgO1Qml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJgO1Qml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08786C4CEE9;
	Thu,  6 Mar 2025 08:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741249108;
	bh=kyXXro/OE6+H623m77kqlXTNMmRNhmQ9EpAFZfE9lXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJgO1Qmlv0WA1k0LdotT3Mi3qZAuvPVcSJKC5CYGJHKNPHcN05dLY6/VwnaOHpIBF
	 9AbLC9Ok4cvmDJhOZ0eFdYc68jzUs6CVHDVsJiiCtuXS7keh54eDn+cZgddROCOO0o
	 OmaeN+wkT6YzHsne1CGa852e7eAS8Ch0yCNcrJukkqA18zb6IJv+qJvCiO1jpY+SgS
	 Cvf3gFtyLwoXu2t63NAo8vJRRMrcdYgFLo5tfvaSdiFdSGb1QLuF38l7ZG39VeEVnL
	 Skb/+7JN8BYm0WEqj2PiVdMTp7c8ZEcYb/7fBxHREHEcUVvivnqwGMGhhtWjuxpi0M
	 bgVu+FgD4qOSw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 4/4] f2fs/009: detect and repair nlink corruption
Date: Thu,  6 Mar 2025 16:18:09 +0800
Message-ID: <20250306081809.2397527-4-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250306081809.2397527-1-chao@kernel.org>
References: <20250306081809.2397527-1-chao@kernel.org>
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
 tests/f2fs/009     | 142 +++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/009.out |   2 +
 2 files changed, 144 insertions(+)
 create mode 100755 tests/f2fs/009
 create mode 100644 tests/f2fs/009.out

diff --git a/tests/f2fs/009 b/tests/f2fs/009
new file mode 100755
index 00000000..8f6a3e11
--- /dev/null
+++ b/tests/f2fs/009
@@ -0,0 +1,142 @@
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
+_require_scratch
+
+dir=$SCRATCH_MNT
+filename=$dir/foo
+hardlink=$dir/bar
+
+for ((i=0;i<14;i++)) do
+	echo "round: " $i >> $seqres.full
+
+	_scratch_mkfs "-f" >> $seqres.full
+	_scratch_mount >> $seqres.full
+
+	if [ $i == 0 ]; then
+		touch $filename
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		nlink=0
+	elif [ $i == 1 ]; then
+		mkdir $filename
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		nlink=1
+	elif [ $i == 2 ]; then
+		mknod $filename c 9 0
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		nlink=0
+	elif [ $i == 3 ]; then
+		mknod $filename b 8 0
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		nlink=0
+	elif [ $i == 4 ]; then
+		mkfifo $filename
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		nlink=0
+	elif [ $i == 5 ]; then
+		socket -s $filename >> $seqres.full 2>&1 &
+		pid=$!
+		sleep 2
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		kill $pid >> $seqres.full 2>&1
+		nlink=0
+	elif [ $i == 6 ]; then
+		ln -s $dir/empty $filename
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		nlink=0
+	elif [ $i == 7 ]; then
+		# orphan inode
+		touch $filename
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		$F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
+		stat $filename >> $seqres.full
+		rm $filename
+		$F2FS_IO_PROG shutdown 1 $dir/ >> $seqres.full
+		sleep 6
+		nlink=1
+	elif [ $i == 8 ]; then
+		# hardlink on file
+		touch $filename
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		ln $filename $hardlink
+		nlink=0
+	elif [ $i == 9 ]; then
+		# hardlink on charactor
+		mknod $filename c 9 0
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		ln $filename $hardlink
+		nlink=0
+	elif [ $i == 10 ]; then
+		# hardlink on blockdev
+		mknod $filename b 8 0
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		ln $filename $hardlink
+		nlink=0
+	elif [ $i == 11 ]; then
+		# hardlink on pipe
+		mkfifo $filename
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		ln $filename $hardlink
+		nlink=0
+	elif [ $i == 12 ]; then
+		# hardlink on socket
+		socket -s $filename >> $seqres.full 2>&1 &
+		pid=$!
+		sleep 2
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		kill $pid >> $seqres.full 2>&1
+		ln $filename $hardlink
+		nlink=0
+	elif [ $i == 13 ]; then
+		# hardlink on symlink
+		ln -s $dir/empty $filename
+		ino=`stat $filename | awk '/Inode:/ {print $4}'`
+		ln $filename $hardlink
+		nlink=0
+	fi
+
+	if [ $i != 7 ]; then
+		stat $dir/* >> $seqres.full
+	fi
+	echo "ino:"$ino >> $seqres.full
+	echo "nlink:"$nlink >> $seqres.full
+
+	_scratch_unmount
+
+	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV >> $seqres.full
+	if [ $? != 0 ]; then
+		exit
+	fi
+
+	export FSCK_OPTIONS="-f"
+	_repair_scratch_fs >> $seqres.full
+	if [ $? != 1 ]; then
+		_fail "fsck can not detect and repair zero nlink corruption "$i
+		exit
+	fi
+
+	export FSCK_OPTIONS=""
+	_check_scratch_fs >> $seqres.full
+	if [ $? != 0 ]; then
+		_fail "fsck hasn't fixed nlink corruption "$i
+		exit
+	fi
+
+	_scratch_mount >> $seqres.full
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

