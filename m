Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9B1E3777
	for <fstests@vger.kernel.org>; Tue,  3 Dec 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225183; cv=none; b=piX7/WtngInKwIA3X6eGjBPMDISGiyqFN46Xm0xXCZYA59cLncCf/SFjaX+vQA4TcRRAHDD7QrjuA27jYbHPnMHiT+scXu8AWWEPpI7jk7Ciq/eqKDpcm6N/67PtY7gC8XesGGTY6ZOmDweNWPU1EkrAlQBACAJRtkxBkVmAbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225183; c=relaxed/simple;
	bh=Xb4RldGYMblNFnvTTFHKocXMgSxQA1PsdRWp6ce3rWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LMPHHzc+uhzoUn4TLTuD02A1mKjuO4naIxMR1SstvmLpt5x3G72yvBzUJiI/+NmchzXjRb8j6cyDOZ9aCqUUEvk+lGwaK/jDLDCwxtzaMhjM6yZeS5OBjK4oMyMj60kFMy2gh6vL1KZSX2zrI7uqbVGjA9w9H8K/bg3/wI7rOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6cv/hRj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6cv/hRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2548C4CECF;
	Tue,  3 Dec 2024 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733225183;
	bh=Xb4RldGYMblNFnvTTFHKocXMgSxQA1PsdRWp6ce3rWY=;
	h=From:To:Cc:Subject:Date:From;
	b=B6cv/hRj3kj0SFo8i9HH6lcH7bPtsosUFBc4JzjhqXIH3G6CMoMxcSVbKs7Oc0YFv
	 6Ty4rMcuTCBjAYu5ap3fuuachNEj10UO3/cLc8PAdHWjp4jEvCaFK9bg636lJoFBu7
	 qZnBdd1J9BUZT3jsrlSyQkSbHuVVnr0mno4S/rXw1ncGUvVbEzco88pWuub5QHzhrt
	 RlbGjEyFYzvh2FMNmHsZelQYSFBMXWsPy8KOl0XuucFxd/fIcPtm3cRveZ+T6qgSgF
	 w3ZD6KgYqD2kW62JULMLW8tG6E7JsKyAP0TI+L6w53mhRqgn7UzX7LedRbKdz75P+2
	 qqBdQravuQoEw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: add commit id to _fixed_by_kernel_commit
Date: Mon,  2 Dec 2024 23:57:27 +0800
Message-Id: <20241202155727.4221-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bugs related to f2fs/00[5-7] regression testcases have been fixed
by below commits:

- d5c367ef8287 ("f2fs: fix f2fs_bug_on when uninstalling filesystem call
f2fs_evict_inode.")

- 1acd73edbbfe ("f2fs: fix to account dirty data in __get_secs_required()")

- 26413ce18e85 ("f2fs: compress: fix inconsistent update of i_blocks in
release_compress_blocks and reserve_compress_blocks")

Let's add commit id to _fixed_by_kernel_commit in f2fs/00[5-7].

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/005 | 2 +-
 tests/f2fs/006 | 2 +-
 tests/f2fs/007 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/f2fs/005 b/tests/f2fs/005
index a817d51a..33d4fdb9 100755
--- a/tests/f2fs/005
+++ b/tests/f2fs/005
@@ -11,7 +11,7 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit d5c367ef8287 \
 	"f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode."
 
 _require_scratch
diff --git a/tests/f2fs/006 b/tests/f2fs/006
index a9c823c1..c1f8d4ff 100755
--- a/tests/f2fs/006
+++ b/tests/f2fs/006
@@ -16,7 +16,7 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 1acd73edbbfe \
 	"f2fs: fix to account dirty data in __get_secs_required()"
 
 _require_scratch
diff --git a/tests/f2fs/007 b/tests/f2fs/007
index 6451d4b4..37388433 100755
--- a/tests/f2fs/007
+++ b/tests/f2fs/007
@@ -11,7 +11,7 @@
 . ./common/preamble
 _begin_fstest auto quick rw compress
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 26413ce18e85 \
         "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
 
 _require_scratch
-- 
2.40.1

