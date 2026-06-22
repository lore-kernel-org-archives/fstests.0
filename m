Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B7F25B0B9
	for <fstests@vger.kernel.org>; Mon, 22 Jun 2026 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782093515; cv=none; b=QObbpNIl/r6PMSZKxO34SvaeRogh+JmBYflxmdXXe5tWdNRVQEZabBLgnevP+zhTNroE/Z2cxuI0UCcnE7o3TSMII/kpV9jUc+u451f1SwRO9GiBTwVFGFl7gcmZqrFihUIMxP6qrKtbaFCOKt8XMpA/x8vH2tZ26H9x0eByMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782093515; c=relaxed/simple;
	bh=xbX2/a2cQEZmSSFe5dUxj6JHKL0m5G8k9l6/v/UjbCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXSSFuA70nuueWPtlOA/YgnhRG5+HhyfxhHgHWbl8tnotXjIlCDK0cEK5B4duO8bALIgThRW5fLllYwnX3RqM0AlnyCKb3hZ5sl7Lii8cQNJmOIj7X4V6Tnjh5zsqmfo+s1oWTrQUeoy6iK6HsMgcU/iJ/74KCg3uHDBte3Gr/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2gjm5hI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2gjm5hI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F911F000E9;
	Mon, 22 Jun 2026 01:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782093514;
	bh=Dtf5/pJLwpCVA1mBxYREJNiC2NC0806gE2r8IszMhpw=;
	h=From:To:Cc:Subject:Date;
	b=c2gjm5hIWPXYwq8yzjQBnE1OF/jcg2/YR1rbsrPtaHmHDjbJc5scjBnOL0d2MzOG+
	 cuBs4k5av9eDULrRA2QsH4MRqfOuTSMmLiXuSQEUIFf8D4VpTNe7BZ0b5A48bvDjYp
	 E8mXRsjLdKv5YjTLoJiHLVRZ4j1/8k8dbvFJVJFc9I4SBultXgqSpgQg/0vkxHqUKK
	 p7iHsbvj1IZYnDHuJtJQjkYBuy4jechs1xC2wqrhL9IWVEE63GYbbKmQsCYyYaiv2i
	 xQW/aBWynuMWqwxQpemJJVlidajuBhBgQTQwOYI8kCCsqgGE/D8Pqr07B701FCFVxX
	 8k7sqrNtZ8QcA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] common/f2fs: introduce _require_f2fs_io_command
Date: Mon, 22 Jun 2026 01:58:23 +0000
Message-ID: <20260622015823.2361449-1-chao@kernel.org>
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

Signed-off-by: Chao Yu <chao@kernel.org>
---
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

