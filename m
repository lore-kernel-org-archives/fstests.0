Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBBF2032D
	for <fstests@vger.kernel.org>; Mon, 29 Sep 2025 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759116739; cv=none; b=BISMQJTSf3uO60UEFIMAkV0wgB/ZUTYMMt0at24sr41ECk6IFimjdB4LmbYorCYuF4wpYzP137/bCKeYyRNYO1fWbQWnr8VVb5xQdQfeEO2WftD9aoW3BokmXsh2PY7ZroPDrQ+XMTLQg8bRzwwjwSPqGjN0EmYqcSyPGSOyugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759116739; c=relaxed/simple;
	bh=PU1QNux6aoZAR6SFJ0X21Ec4Y+EpyDnrb6A4Oki76PA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lChQy+yHrg7ms6hKiicVF9DbO6QjT3RkWkKaWQh23pCoLTOzLjUcZ1zrQuitGcpzgqxrIMAj5xxU6cgTHqKn/pFiFJzE7/Lb7P/2zviG5yV9fjrNSlmStBX7CFM7JrQEoaRC6mH4J3yQnZeR+OH849Lm+y/dPZcfDgqHtbe/eyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlqGzRdQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlqGzRdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F61C4CEF0;
	Mon, 29 Sep 2025 03:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759116739;
	bh=PU1QNux6aoZAR6SFJ0X21Ec4Y+EpyDnrb6A4Oki76PA=;
	h=From:To:Cc:Subject:Date:From;
	b=DlqGzRdQxBiws8TPnPsTdVH20UQNNStgEljkCWqByFxaiXEPT6dKhPAk+Jkm/TM6n
	 3zrs6dTmQPVag+XAzgkiXFw+euBIg38Fg5F+GOMIHjbhGABfxM6fLugvgqQ/YnR/bQ
	 FWLk9fxpMlqgQTUomhowXBfbB90j6W9JStK0RagAEZuMXcQLc+X5dFr3+9Wl2NGKzj
	 vCUWTycZVeXdWxaY3WVrhDWoNsKVypQL2cpgOMT9sTsV4rUCt99jzyytc457nC86hf
	 KOGCOfpd+5tp8sdTF3rEQhcjYK2lNT1eNmUdDN45LvfceAEXgPQvuf0AYA/AXb0cAF
	 CjDib0+LomEJA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] common/f2fs: introduce _require_inject_f2fs_command()
Date: Mon, 29 Sep 2025 02:52:40 +0800
Message-Id: <20250928185240.57862-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce _require_inject_f2fs_command() to check whether inject.f2fs
supports specific metaarea and member parameters.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/f2fs    | 25 +++++++++++++++++++++++++
 tests/f2fs/009 |  2 ++
 tests/f2fs/012 |  2 ++
 tests/f2fs/019 |  2 ++
 tests/f2fs/020 |  2 ++
 tests/f2fs/022 |  2 ++
 6 files changed, 35 insertions(+)

diff --git a/common/f2fs b/common/f2fs
index 1b39d8ce..4b01e032 100644
--- a/common/f2fs
+++ b/common/f2fs
@@ -25,3 +25,28 @@ _require_scratch_f2fs_compression()
 		_scratch_unmount
 	fi
 }
+
+# check that inject.f2fs supports to inject specific field in specific meta area
+_require_inject_f2fs_command()
+{
+	if [ $# -ne 2 ]; then
+		echo "Usage: _require_inject_f2fs_command metaarea member" 1>&2
+		_exit 1
+	fi
+	metaarea=$1
+	member=$2
+
+	case $metaarea in
+	sb|cp|nat|sit)
+		val=0
+		;;
+	ssa|node|dent)
+		;;
+	*)
+		_notrun "unsupport metaarea: $metaarea"
+		;;
+	esac
+
+	$F2FS_INJECT_PROG "--$metaarea" "$val" "-h" | grep "$member:" > /dev/null || \
+		_notrun "--$metaarea --mb $member support is missing"
+}
diff --git a/tests/f2fs/009 b/tests/f2fs/009
index 7333d484..465be874 100755
--- a/tests/f2fs/009
+++ b/tests/f2fs/009
@@ -9,10 +9,12 @@
 # and expects fsck.f2fs can detect such corruption and do the repair.
 #
 . ./common/preamble
+. ./common/f2fs
 _begin_fstest auto quick
 
 _require_scratch
 _require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_inject_f2fs_command node i_links
 _require_command "$(type -P socket)" socket
 
 _fixed_by_git_commit f2fs-tools 958cd6e \
diff --git a/tests/f2fs/012 b/tests/f2fs/012
index 7438d9ce..8e156772 100755
--- a/tests/f2fs/012
+++ b/tests/f2fs/012
@@ -12,6 +12,7 @@
 # 4.enable linear lookup, expect lookup succeed
 #
 . ./common/preamble
+. ./common/f2fs
 _begin_fstest auto quick casefold
 
 _fixed_by_kernel_commit 91b587ba79e1 \
@@ -21,6 +22,7 @@ export LC_ALL=C.UTF-8
 _require_scratch_nocheck
 _require_command "$F2FS_IO_PROG" f2fs_io
 _require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_inject_f2fs_command dent d_hash
 
 #check whether f2fs supports "lookup_mode=x" mount option
 mntopt=""
diff --git a/tests/f2fs/019 b/tests/f2fs/019
index 2307bd96..f6bb0b52 100755
--- a/tests/f2fs/019
+++ b/tests/f2fs/019
@@ -12,6 +12,7 @@
 #    corruption in the file
 #
 . ./common/preamble
+. ./common/f2fs
 _begin_fstest auto quick rw
 
 _fixed_by_kernel_commit 77de19b6867f \
@@ -19,6 +20,7 @@ _fixed_by_kernel_commit 77de19b6867f \
 
 _require_scratch_nocheck
 _require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_inject_f2fs_command node addr
 
 # remove all mkfs options to avoid layout change of on-disk inode
 export MKFS_OPTIONS=""
diff --git a/tests/f2fs/020 b/tests/f2fs/020
index 38bc6582..332848d0 100755
--- a/tests/f2fs/020
+++ b/tests/f2fs/020
@@ -12,6 +12,7 @@
 #    corruption in the file
 #
 . ./common/preamble
+. ./common/f2fs
 _begin_fstest auto quick rw
 
 . ./common/attr
@@ -21,6 +22,7 @@ _fixed_by_kernel_commit 061cf3a84bde \
 
 _require_scratch_nocheck
 _require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_inject_f2fs_command node i_xattr_nid
 _require_attrs user
 
 # remove all mkfs options to avoid layout change of on-disk inode
diff --git a/tests/f2fs/022 b/tests/f2fs/022
index ed3b4f2b..f81180e8 100755
--- a/tests/f2fs/022
+++ b/tests/f2fs/022
@@ -11,6 +11,7 @@
 # 4. fpunch in foo w/ specified range
 #
 . ./common/preamble
+. ./common/f2fs
 _begin_fstest auto quick rw
 
 . ./common/attr
@@ -20,6 +21,7 @@ _fixed_by_kernel_commit xxxxxxxxxxxx \
 
 _require_scratch_nocheck
 _require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_inject_f2fs_command node i_nid
 
 # remove all mkfs options to avoid layout change of on-disk inode
 export MKFS_OPTIONS=""
-- 
2.40.1

