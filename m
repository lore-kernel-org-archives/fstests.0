Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6972248B5
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607845; cv=none; b=hKlVi3qX57nXqCDgbA1uCCF7Z1993+OJ0hoLwHbI3A3y2V9XpizcToxfVB1R3uuwiZHTA1aingly4IAc2jdXP5v0uzYeC55EGFvb/lKUZ6ubP7lBzGNc8OznYNaXOLdvGn5bertHtIhlqtIZT816c7QWRhrRrttZKkyoTCc5mcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607845; c=relaxed/simple;
	bh=GXwM4rv65Xwt4R+oS85AFKlhzvJB3Sm5lKewF7AKtVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyab2xuJmA/P0DuLu6375Qwq6/lEtPFdyPJAMy6BF3I7Qn7FGTNFfLriH5w5J0j5u88j00J6Ei7mN1fO4veye7gjerRNCMdFTMYEtQmJaduiacvmFXVWeuWV3WBBR0M3bgoRNeU9HyXkfJ1ZjvxjBAXKcxv6iduhikINnmBVrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPir2eoR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPir2eoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2B6C4CEEA;
	Mon, 10 Mar 2025 11:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741607844;
	bh=GXwM4rv65Xwt4R+oS85AFKlhzvJB3Sm5lKewF7AKtVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPir2eoR1GUsB4L4vasstxgPxb92c2zjBGMTPJYtWa99cOgktzWPNJ8onHeFJDZB8
	 7I/cPCWkRFEKZkcwpa3FvKN6yHE7TzweJv7gRBaKDLoUGNGzyB33Wa0RElwknB4X0C
	 MCHTLLATfPZhGVLG1Pa2nl9v5x7syYuMAYFx2Q2AdHauUksffV0YMfKc2I25TOdjVC
	 waLh76xc0iGhAUjNM8hDZENNKGTUG4lmPl+K5Jm3L8D0qzYusQt+g8NECzCJ5+ZELH
	 tEpNg81g3HqzwJVhmL2fX9xnTJuJZUsQex3g6of+zOXXe9I3D4ie6g/99UjLuOe/2H
	 0zhAjHZF3aoMw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 4/4] f2fs/009: detect and repair nlink corruption
Date: Mon, 10 Mar 2025 19:56:21 +0800
Message-ID: <20250310115621.3441518-4-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250310115621.3441518-1-chao@kernel.org>
References: <20250310115621.3441518-1-chao@kernel.org>
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
v2:
- make _scratch_mkfs() to format f2fs image forcely
- adjust _check_scratch_fs() to allow specified parameter of f2fs
- add _fixed_by_git_commit
- add _require_command inject.f2fs
- simply return value handling
 common/rc          |   9 ++-
 tests/f2fs/009     | 133 +++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/009.out |   2 +
 3 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100755 tests/f2fs/009
 create mode 100644 tests/f2fs/009.out

diff --git a/common/rc b/common/rc
index bf24da4e..e156f3af 100644
--- a/common/rc
+++ b/common/rc
@@ -993,7 +993,7 @@ _scratch_mkfs()
 		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
 		;;
 	f2fs)
-		mkfs_cmd="$MKFS_F2FS_PROG"
+		mkfs_cmd="$MKFS_F2FS_PROG -f"
 		mkfs_filter="cat"
 		;;
 	ocfs2)
@@ -3682,6 +3682,13 @@ _check_scratch_fs()
     ubifs)
 	# there is no fsck program for ubifs yet
 	;;
+    f2fs)
+        if [ "$FSCK_OPTIONS" == "--dry-run" ]; then
+            fsck -t $FSTYP $device -- $FSCK_OPTIONS >> $seqres.full 2>&1
+        else
+            _check_generic_filesystem $device
+        fi
+        ;;
     *)
 	_check_generic_filesystem $device
 	;;
diff --git a/tests/f2fs/009 b/tests/f2fs/009
new file mode 100755
index 00000000..d14df968
--- /dev/null
+++ b/tests/f2fs/009
@@ -0,0 +1,133 @@
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
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+
+_fixed_by_git_commit f2fs-tools 958cd6e
+
+filename=$SCRATCH_MNT/foo
+hardlink=$SCRATCH_MNT/bar
+
+for ((i=0;i<14;i++)) do
+	echo "round: " $i >> $seqres.full
+
+	_scratch_mkfs "-f" >> $seqres.full
+	_scratch_mount >> $seqres.full
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
+	export FSCK_OPTIONS="--dry-run"
+	_check_scratch_fs >>$seqres.full 2>&1 && _fail "can't find corruption"
+	_repair_scratch_fs >> $seqres.full
+	_check_scratch_fs
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

