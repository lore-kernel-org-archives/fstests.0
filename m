Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECDF2D7DDF
	for <fstests@vger.kernel.org>; Thu,  9 Oct 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000935; cv=none; b=tw2Q+JyTvSSA0I9YLZDv/0SBgKRsO5LsFTViMQ5h+914cyGwMI1gOl8sd05VRA9Me2WIKndoEi+Y6Rowl5RwY6M+1zJnAmyJvyRIe82XXKEg4Y5LHnuYkBGKmNUgBgW8nk2LdGLUPYu2decPbOmoBtJ51/GjoJj1Cm3BoPJbSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000935; c=relaxed/simple;
	bh=rafZBb+BEGY7+V0BVWM7lcH+DPHEnQbVHTH/W0YjSso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DrDRjSNgYIZ3xiE/8c+Jux/6SnI31M84pB+n5S2wkqSY7SkFc6TA/ote3y1xS2PxCrp7OMZH+jSYp2Vq3HYRgN3XanWywOLXssEZj1rxhO1Ihc2q5viZL8h0NGdXquqqVjUaWDPLxF6wsBCtHs0aCi+kqX0d1hB/gPAG+q4UZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDTogICe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDTogICe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098EEC4CEE7;
	Thu,  9 Oct 2025 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760000935;
	bh=rafZBb+BEGY7+V0BVWM7lcH+DPHEnQbVHTH/W0YjSso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDTogICeHrWrW6XWrY/ZcJyC39NGqE8RfRAnZzTN3aOg0jpDnmCdH/rSHPxKS+y5L
	 /N+F3OjHSEFeHyfiF+exNeHHILbLKNcdmZV/KwBg0OadLKNcxfeybTJXUaKG9ggPSU
	 TA00VzmGvOcE1Bt2nijfuqVhkuSoNwEcbGIWLN35S/Z1O1FE2VwxMsR1fyBiVeHLk5
	 JDgBNneGscFKu2MO2Q2kGK/Cyb3gtD5MAHBsLBWrftTeFuhZIVV+JHDnJ4QpOcVKRz
	 1HsFQ9Rh0E0xNlr/q/CZ4tOFwe08AGSC+KV+VIOCxBPzvt9vkG4PoAH6Xoh3xdAEX7
	 YKGTy4GOiP2iw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] common/f2fs: introduce _require_inject_f2fs_command()
Date: Thu,  9 Oct 2025 16:50:43 +0800
Message-Id: <20251009085043.16910-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20251009085043.16910-1-chao@kernel.org>
References: <20251009085043.16910-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce _require_inject_f2fs_command() to check whether inject.f2fs
supports specific metaarea and member parameters.

Meanwhile, let's check inject.f2fs requirement inside
_require_inject_f2fs_command() for cleanup.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/f2fs    | 27 +++++++++++++++++++++++++++
 tests/f2fs/009 |  2 +-
 tests/f2fs/012 |  2 +-
 tests/f2fs/019 |  2 +-
 tests/f2fs/020 |  2 +-
 tests/f2fs/022 |  2 +-
 6 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/common/f2fs b/common/f2fs
index 4d0d688b..82d3102e 100644
--- a/common/f2fs
+++ b/common/f2fs
@@ -69,3 +69,30 @@ _check_f2fs_filesystem()
 
     return 0
 }
+
+# check that inject.f2fs supports to inject specific field in specific meta area
+_require_inject_f2fs_command()
+{
+	_require_command "$F2FS_INJECT_PROG" inject.f2fs
+
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
index 7333d484..4c179f2d 100755
--- a/tests/f2fs/009
+++ b/tests/f2fs/009
@@ -12,7 +12,7 @@
 _begin_fstest auto quick
 
 _require_scratch
-_require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_inject_f2fs_command node i_links
 _require_command "$(type -P socket)" socket
 
 _fixed_by_git_commit f2fs-tools 958cd6e \
diff --git a/tests/f2fs/012 b/tests/f2fs/012
index 7438d9ce..53d54bf6 100755
--- a/tests/f2fs/012
+++ b/tests/f2fs/012
@@ -20,7 +20,7 @@ _fixed_by_kernel_commit 91b587ba79e1 \
 export LC_ALL=C.UTF-8
 _require_scratch_nocheck
 _require_command "$F2FS_IO_PROG" f2fs_io
-_require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_inject_f2fs_command dent d_hash
 
 #check whether f2fs supports "lookup_mode=x" mount option
 mntopt=""
diff --git a/tests/f2fs/019 b/tests/f2fs/019
index 2307bd96..a6e6e38c 100755
--- a/tests/f2fs/019
+++ b/tests/f2fs/019
@@ -18,7 +18,7 @@ _fixed_by_kernel_commit 77de19b6867f \
 	"f2fs: fix to avoid out-of-boundary access in dnode page"
 
 _require_scratch_nocheck
-_require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_inject_f2fs_command node addr
 
 # remove all mkfs options to avoid layout change of on-disk inode
 export MKFS_OPTIONS=""
diff --git a/tests/f2fs/020 b/tests/f2fs/020
index 38bc6582..a6933134 100755
--- a/tests/f2fs/020
+++ b/tests/f2fs/020
@@ -20,7 +20,7 @@ _fixed_by_kernel_commit 061cf3a84bde \
 	"f2fs: fix to do sanity check on ino and xnid"
 
 _require_scratch_nocheck
-_require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_inject_f2fs_command node i_xattr_nid
 _require_attrs user
 
 # remove all mkfs options to avoid layout change of on-disk inode
diff --git a/tests/f2fs/022 b/tests/f2fs/022
index ed3b4f2b..48a8386b 100755
--- a/tests/f2fs/022
+++ b/tests/f2fs/022
@@ -19,7 +19,7 @@ _fixed_by_kernel_commit xxxxxxxxxxxx \
 	"f2fs: fix to do sanity check on node footer for non inode dnode"
 
 _require_scratch_nocheck
-_require_command "$F2FS_INJECT_PROG" inject.f2fs
+_require_inject_f2fs_command node i_nid
 
 # remove all mkfs options to avoid layout change of on-disk inode
 export MKFS_OPTIONS=""
-- 
2.40.1

