Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C313D8B1
	for <fstests@vger.kernel.org>; Mon, 22 Jun 2026 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782093926; cv=none; b=CjKqwnW9x6eSWwbjWBq77YMnc7Kom1jbz6gOBG9pbRkRdWY+0hXGu3eGzoAy+N5pKsO7OYIl3IbOEWBFiM55MDNSqz+aGrPq/jW/p0ryjydEaIP9zPqj0dCONVymt+9zCQQSo0jPsxcvL+cwblC8bNvwHE/uGiHXqN/vEX+3lsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782093926; c=relaxed/simple;
	bh=GlaUE0lfmpCetvpeDRbwWs6J6u5i0Lm+/5MJSps1oM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StfMUciVYsdXxg2aqxC+glzrlxaMdXcv79iV9C1057SvQrbL1InqIbAdELdwpJ7qFkpd3wzdfF5zdu5bfckX1wL/+cL42Stiaf/psx6y2CYVmB+vaGqwIkAHBrZHM+SuHZHzpZD1ePVIMaldFz06A2bxL2eO1H2lkGfRPyqznUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR8Y8W7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR8Y8W7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE8A1F000E9;
	Mon, 22 Jun 2026 02:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782093924;
	bh=Lu5iU7fBtv4Chc3ojEDmb6o6SqWI3VKMJzPc8hK6LqQ=;
	h=From:To:Cc:Subject:Date;
	b=LR8Y8W7zFK6TydC2zO+xSIFnWFpzqSY3NZMRh4jT2TxVMn7+CeeSBijiFkjomLgsU
	 jfD2Y5smk22rkUClGwQ1fNlj2J+oe+e58WhFP7hcwZLkFX04SjyCUG+Tdom7GlKSYB
	 +octpONMW4v4NQy6flDiL4tFGgMQDhKY8LwlHWfKsgLPJYldim5zkf5pvZl3tn1Bel
	 KdqpqBL21dxGXQHidvkercGf4uYT6SkX2dJqa+ExIxh0E0nuaOhaCDPxweLHFGBY9H
	 hq2iQMizIg8fykZaJptiikBVegwJQ6ivopLs6Kv1lzE2+3qsUC2NS+CE6HX75xXt4T
	 VIw0u1eB182yg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] common/f2fs: introduce _require_f2fs_io_command
Date: Mon, 22 Jun 2026 02:05:16 +0000
Message-ID: <20260622020516.2372277-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update existing f2fs testcases to utilize the new
_require_f2fs_io_command() helper for verifying required f2fs_io
subcommands instead of basic executable checks or open coding.

Suggested-by: Zorro Lang <zlang@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2: add Suggested-by tag of Zorro
 common/f2fs    | 16 ++++++++++++++++
 tests/f2fs/003 |  1 +
 tests/f2fs/004 |  1 +
 tests/f2fs/007 |  1 +
 tests/f2fs/009 |  1 +
 tests/f2fs/010 |  2 +-
 tests/f2fs/011 |  2 +-
 tests/f2fs/012 |  2 +-
 tests/f2fs/013 |  2 +-
 tests/f2fs/025 |  2 +-
 10 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/common/f2fs b/common/f2fs
index 82d3102ea..025d29a76 100644
--- a/common/f2fs
+++ b/common/f2fs
@@ -96,3 +96,19 @@ _require_inject_f2fs_command()
 	$F2FS_INJECT_PROG "--$metaarea" "$val" "-h" | grep "$member:" > /dev/null || \
 		_notrun "--$metaarea --mb $member support is missing"
 }
+
+# Check that f2fs_io supports specific subcommand(s)
+_require_f2fs_io_command()
+{
+	_require_command "$F2FS_IO_PROG" f2fs_io
+
+	if [ -z "$1" ]; then
+		echo "Usage: _require_f2fs_io_command command..." 1>&2
+		_exit 1
+	fi
+
+	for command in "$@"; do
+		$F2FS_IO_PROG help | awk '{print $1}' | grep -qw "$command" || \
+			_notrun "f2fs_io $command support is missing"
+	done
+}
diff --git a/tests/f2fs/003 b/tests/f2fs/003
index fbb08a3e9..94885904c 100755
--- a/tests/f2fs/003
+++ b/tests/f2fs/003
@@ -30,6 +30,7 @@ _fixed_by_kernel_commit b40a2b003709 \
 
 _require_scratch
 _require_xfs_io_command "fpunch"
+_require_f2fs_io_command "write" "gc"
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount >> $seqres.full
diff --git a/tests/f2fs/004 b/tests/f2fs/004
index ac824c437..0592e23c4 100755
--- a/tests/f2fs/004
+++ b/tests/f2fs/004
@@ -30,6 +30,7 @@ _fixed_by_kernel_commit b2c160f4f3cf \
 
 _require_scratch
 _require_odirect
+_require_f2fs_io_command "write"
 _scratch_mkfs >> $seqres.full
 _scratch_mount >> $seqres.full
 
diff --git a/tests/f2fs/007 b/tests/f2fs/007
index 37388433e..e45b6cea9 100755
--- a/tests/f2fs/007
+++ b/tests/f2fs/007
@@ -15,6 +15,7 @@ _fixed_by_kernel_commit 26413ce18e85 \
         "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
 
 _require_scratch
+_require_f2fs_io_command "compress" "get_cblocks" "release_cblocks" "reserve_cblocks" "decompress"
 testfile_prefix=$SCRATCH_MNT/testfile
 fio_config=$tmp.fio
 
diff --git a/tests/f2fs/009 b/tests/f2fs/009
index 39a4bad3d..afb3bc98f 100755
--- a/tests/f2fs/009
+++ b/tests/f2fs/009
@@ -15,6 +15,7 @@ _require_scratch
 _require_scratch_shutdown
 _require_inject_f2fs_command node i_links
 _require_command "$(type -P socket)" socket
+_require_f2fs_io_command "write"
 
 _fixed_by_git_commit f2fs-tools 958cd6e \
 	"fsck.f2fs: support to repair corrupted i_links"
diff --git a/tests/f2fs/010 b/tests/f2fs/010
index 50e378177..b8899dedc 100755
--- a/tests/f2fs/010
+++ b/tests/f2fs/010
@@ -30,7 +30,7 @@ _fixed_by_kernel_commit 03511e936916 \
 	"f2fs: fix inconsistent dirty state of atomic file"
 
 _require_scratch
-_require_command "$F2FS_IO_PROG" f2fs_io
+_require_f2fs_io_command "write"
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount >> $seqres.full
diff --git a/tests/f2fs/011 b/tests/f2fs/011
index 07c94d8c9..aa939c9e7 100755
--- a/tests/f2fs/011
+++ b/tests/f2fs/011
@@ -27,7 +27,7 @@ _fixed_by_kernel_commit f7f8932ca6bb \
 	"f2fs: fix to avoid running out of free segments"
 
 _require_scratch
-_require_command "$F2FS_IO_PROG" f2fs_io
+_require_f2fs_io_command "pinfile"
 
 _scratch_mkfs_sized $((1*1024*1024*1024)) >> $seqres.full
 _scratch_mount -o checkpoint=disable:10%
diff --git a/tests/f2fs/012 b/tests/f2fs/012
index 53d54bf6b..15b0e5055 100755
--- a/tests/f2fs/012
+++ b/tests/f2fs/012
@@ -19,7 +19,7 @@ _fixed_by_kernel_commit 91b587ba79e1 \
 
 export LC_ALL=C.UTF-8
 _require_scratch_nocheck
-_require_command "$F2FS_IO_PROG" f2fs_io
+_require_f2fs_io_command "setflags"
 _require_inject_f2fs_command dent d_hash
 
 #check whether f2fs supports "lookup_mode=x" mount option
diff --git a/tests/f2fs/013 b/tests/f2fs/013
index 80ed2702b..086a5b4bb 100755
--- a/tests/f2fs/013
+++ b/tests/f2fs/013
@@ -19,7 +19,7 @@
 . ./common/preamble
 _begin_fstest auto quick
 _require_kernel_config CONFIG_F2FS_FAULT_INJECTION
-_require_command "$F2FS_IO_PROG" f2fs_io
+_require_f2fs_io_command "write" "fsync"
 
 _cleanup()
 {
diff --git a/tests/f2fs/025 b/tests/f2fs/025
index 807f18f23..6fc18d989 100755
--- a/tests/f2fs/025
+++ b/tests/f2fs/025
@@ -20,7 +20,7 @@ _require_scratch
 _require_scratch_shutdown
 _require_xfs_io_command "pwrite"
 _require_xfs_io_command "truncate"
-_require_command "$F2FS_IO_PROG" f2fs_io
+_require_f2fs_io_command gc_urgent
 _require_fs_sysfs_attr $TEST_DEV gc_urgent
 _require_check_dmesg
 
-- 
2.49.0

