Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86BFC8FE
	for <fstests@vger.kernel.org>; Sat, 12 Oct 2024 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728695670; cv=none; b=DiHwg/c0BuQXcoGRTk2KOo8gocUQ1vI3wScbHjvbN6m9U4bL+wkKaCAhyxkuYOPLiwe/2YV065yxfBSf8z719YR5ttduSohdtjADK8ab+3ZZuoSDDFbLZ4fiJ2HQpK4kHm3AnywD37Mal92MH/YjUfmyaSM7x60DhmJffO+1qu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728695670; c=relaxed/simple;
	bh=k4D5x4KbEGce1yIU0y1WdlxGh1G84wK2Xz30+tWn5OE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gR425QYJOZ0fNv0DDrWhRVrTrq4HNzCHsALHjGFVNVcJYcFdGVkcPHMSPF1J4Tee821Svi2dAhnGme/Xokoi0zNB/lXie4Uu4CUo3xvph0zKHAaDJw9NxgHcCAwNnPBk+BGKpGSGhBQdATtOONeZuH5KwOijjhczMhNH7EISW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLnA0TSt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLnA0TSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B308EC4CEC3;
	Sat, 12 Oct 2024 01:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728695669;
	bh=k4D5x4KbEGce1yIU0y1WdlxGh1G84wK2Xz30+tWn5OE=;
	h=From:To:Cc:Subject:Date:From;
	b=FLnA0TStGvO2/bt4qkew1Pi3HWgV/AExdP0PjMk7Cdd3qYvCJQCaaka/hLw+sT63e
	 w69ZfgyQWbxp+21rqSEFgeZedoYjdgnzgOpTW7xHiVqM4kBY1MJ+oTMdNwHPrFhmuv
	 TKD9Sh12B89RN3tgqhdxKqTOXJgGOBiyg0Z6Ox3T/O7ApUtOa6Reqj2Cuohp/j6QbR
	 dyZbr0nZV7tW3o6DKo3W06UzKFVGeEGoGKZRDhZRHlQNlrAnhDwXLuXegA871lDQyT
	 +Vi33gBj8rMZTFjD39ttyfYCYyw+jpE9cvfztWIKJ294U+bnlswekeX6qYgVMyMwOr
	 KJLmqdOQjk8Gw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs/004: add missing _fixed_by_kernel_commit line
Date: Sat, 12 Oct 2024 09:14:19 +0800
Message-Id: <20241012011419.4066147-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug related to this regression testcase has been fixed by commit
b2c160f4f3cf ("f2fs: atomic: fix to forbid dio in atomic_file"), let's
add missing _fixed_by_kernel_commit line for this testcase.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/004 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/f2fs/004 b/tests/f2fs/004
index dd1ed5c1..e08cee11 100755
--- a/tests/f2fs/004
+++ b/tests/f2fs/004
@@ -25,6 +25,9 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
+_fixed_by_kernel_commit b2c160f4f3cf \
+	"f2fs: atomic: fix to forbid dio in atomic_file"
+
 _require_scratch
 _require_odirect
 _scratch_mkfs >> $seqres.full
-- 
2.40.1

