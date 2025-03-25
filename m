Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8191425A2B2
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907531; cv=none; b=F1E7Jwxvf865/gDmaEnTvYy+39kQhskpwij+dAuBD6ofADHim8hOTQFfrnLnidOEWdKImR35vT6aumT50REAaCaaWsG1AirnYkATsMYAlFi9M1OYtkhMvcFOBIIivjI6nYcOOYEEU4pRJQoCFScufKBf/t283GESNDuj36JLbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907531; c=relaxed/simple;
	bh=RQvIBzy9bgK+sBeTLXLeBY1V+fYe6vVoOMsaan4bsAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cC7HX13hRcMh9LN0iHyAj7Xr+dsKhP1I0JyNRzMYecpDHP87BBUJa5XD2WRQIDuv0MjTXImV7eiTan3Zei9NUFUiMF+yfv0p+Oj0bHnVdX9pYwYdRm0lTbe0zOsnHKlSubaLEllPr8UrtbL26Y2vRuniV+s8v60DZoIjAqIwGYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZf6xIXK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZf6xIXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461EDC4CEE4;
	Tue, 25 Mar 2025 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907531;
	bh=RQvIBzy9bgK+sBeTLXLeBY1V+fYe6vVoOMsaan4bsAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZf6xIXKU/sV5eIXWbbfwXe+VikVmrCO6GOa2mf/aV/4TBSO3BQwDUVub6/RfRACG
	 0LayZkzm6moWPKWROfluC9SAFIa6mFzlJqvenLEP8NXNWuDEB/VosZIiIAh/3Vio6T
	 8B4D4vd87yXCStFSgE1gzsyuYnpasJ7dem+QmgOyOj+3VuiQoxkjnhQWT0uRjyzInR
	 Rwb3TSdyjlb++huL74Bzjp+yJHc53LVkj+BHXZ3S+AlHDvFNOYzHW4hUoP6+xF6yab
	 aDpfhN6TEz5h8fCh6DwshzR6yIENwxmDppflMdmR8hIlQPzNk+KySgImA+xwCiZnMJ
	 ovqGVfgH3XF3A==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v5 6/6] f2fs/009: detect and repair nlink corruption
Date: Tue, 25 Mar 2025 20:58:24 +0800
Message-ID: <20250325125824.3367060-6-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250325125824.3367060-1-chao@kernel.org>
References: <20250325125824.3367060-1-chao@kernel.org>
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
v5:
- clean up codes suggested by Dave.
 tests/f2fs/009     | 141 +++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/009.out |   2 +
 2 files changed, 143 insertions(+)
 create mode 100755 tests/f2fs/009
 create mode 100644 tests/f2fs/009.out

diff --git a/tests/f2fs/009 b/tests/f2fs/009
new file mode 100755
index 00000000..864fdcfb
--- /dev/null
+++ b/tests/f2fs/009
@@ -0,0 +1,141 @@
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
+
+_fixed_by_git_commit f2fs-tools 958cd6e \
+	"fsck.f2fs: support to repair corrupted i_links"
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
+	cd /
+	rm -r -f $tmp.*
+}
+
+_inject_and_check()
+{
+	local nlink=$1
+	local ino=$2
+
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
+
+	_scratch_mkfs >> $seqres.full
+	_scratch_mount
+}
+
+inject_and_check()
+{
+	local nlink=$1
+	local create_hardlink=$2
+	local ino=$3
+
+	if [ -z $ino ]; then
+		ino=`stat -c '%i' $filename`
+	fi
+
+	if [ $create_hardlink == 1 ]; then
+		ln $filename $hardlink
+	fi
+
+	_inject_and_check $nlink $ino
+}
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+touch $filename
+inject_and_check 0 0
+
+mkdir $filename
+inject_and_check 1 0
+
+mknod $filename c 9 0
+inject_and_check 0 0
+
+mknod $filename b 8 0
+inject_and_check 0 0
+
+mkfifo $filename
+inject_and_check 0 0
+
+socket -s $filename >> $seqres.full 2>&1 &
+pid=$!
+sleep 2
+ino=`stat -c '%i' $filename`
+kill $pid >> $seqres.full 2>&1
+inject_and_check 0 0 $ino
+
+ln -s $SCRATCH_MNT/empty $filename
+inject_and_check 0 0
+
+touch $filename
+ino=`stat -c '%i' $filename`
+$F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
+stat $filename >> $seqres.full
+rm $filename
+$F2FS_IO_PROG shutdown 1 $SCRATCH_MNT/ >> $seqres.full
+sleep 6
+inject_and_check 1 0 $ino
+
+# hardlink
+touch $filename
+inject_and_check 0 1
+
+mknod $filename c 9 0
+inject_and_check 0 1
+
+mknod $filename b 8 0
+inject_and_check 0 1
+
+mkfifo $filename
+inject_and_check 0 1
+
+socket -s $filename >> $seqres.full 2>&1 &
+pid=$!
+sleep 2
+ino=`stat -c '%i' $filename`
+kill $pid >> $seqres.full 2>&1
+inject_and_check 0 1 $ino
+
+ln -s $SCRATCH_MNT/empty $filename
+inject_and_check 0 1
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

