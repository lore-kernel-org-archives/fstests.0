Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092513C820
	for <fstests@vger.kernel.org>; Mon,  2 Sep 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272343; cv=none; b=eZAwWC5KQYEV8DKzArBuvUtvkrm/QV4qI254pLIkohRtCtYoJhXFql4uT1v2gPBCJXMzuQsgPLE78bSSWOgDejzW1UMJjycKCD7T8hcptEPXyBOnSHs8QvkBDWevCAWmKJKCVqdkKbl6YcrwsAp3VcxFE28Lwpnm6xmWZFmK1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272343; c=relaxed/simple;
	bh=iSO8NbaF0kFDuKsCNSKwzKt21e5E2/HlI7tcDkavf8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R43j4mDDiD00YfNb1M1Lo7x7xf5CaH1cnRR7MMJLOHFeVT8L89mNOABT91ENFOM2mduDhBNi/u7sU70EiXAU3jSHu12Rmh5XEiCGR49dAVxnTaZdgx4vNtQjVRmr61klSvgpCwFrdK7zbr5BbVOsU2O8GXQHwk/PDIyUGfaqEH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMLuN3Gr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMLuN3Gr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361AFC4CEC8;
	Mon,  2 Sep 2024 10:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725272342;
	bh=iSO8NbaF0kFDuKsCNSKwzKt21e5E2/HlI7tcDkavf8Q=;
	h=From:To:Cc:Subject:Date:From;
	b=AMLuN3Grmj0UHnAc0I1DNfOKHS6MMn/9JDFLsBmztdI2+ysFH+XZTwHsT/6puthae
	 EGMnl/4nV+p/I9eefm8gbXA4BAaYSk/r0GaJnEVCTt36A2TvreMwSQzzO684DW8IDI
	 dj7/lQ+S+ianSiL1JiAxFfDi3BKa8esseHH/6Opku/WVBqx2ysMKh7s4kQDSI/1ANi
	 vxtyI0QNbNIRdbkMbCwisbojsUIeDYQFI3uldcMV3IAwglrXwSVETK5SAglxgPyju9
	 z2VMnMxjXvVjUhSP33IsoYm8XVHWPGKt/2THUYOBEYW5Cjx1oQTOMBhWfK7mFk/1hN
	 3voKb1VesiZJQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs/003: add missing _fixed_by_kernel_commit line
Date: Mon,  2 Sep 2024 18:18:44 +0800
Message-Id: <20240902101844.4042983-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug related to this regression testcase has been fixed by commit
b40a2b003709 ("f2fs: use meta inode for GC of atomic file"), let's
add missing _fixed_by_kernel_commit line for this testcase.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/003 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/f2fs/003 b/tests/f2fs/003
index 62821ed7..fbb08a3e 100755
--- a/tests/f2fs/003
+++ b/tests/f2fs/003
@@ -25,6 +25,9 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
+_fixed_by_kernel_commit b40a2b003709 \
+	"f2fs: use meta inode for GC of atomic file"
+
 _require_scratch
 _require_xfs_io_command "fpunch"
 
-- 
2.40.1

