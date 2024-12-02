Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669531D8DFB
	for <fstests@vger.kernel.org>; Mon,  2 Dec 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139725; cv=none; b=FJSBtVuE3eUqUJDWPvUgUOvHwL/uwBvlItA7wEP5vWqUc3AiwVw3ktSL5xYEMMN8NeWYBdvDCh7zU6RkDrIn6uHNOnX0aJA1q0rX3e8h4R8RlPG27ekUvhhq++J/6HKQsCcH8zvENWIeb1ksgaeZIGgjaAwY+zQ7S679zLgzCxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139725; c=relaxed/simple;
	bh=wt8fAHvHw7fq8a87xaaoMOWZCAti1YWLt5GHipDkHCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qdF0lDRL2NzraByfmiZH7EdaKpQTAoQ7dfNwFY8dRINR9gsuMApB8tH+AyWa/re8qBG+Vbj1wWLhjkTkANYT4HpF8iPvQbUU1x59Y09g4JATAiR+kwNfqk6fHvNRgkA5l1CXNHbEvhbnFdoSY0aT4hPHFZV1CSYoPJXdE+WD20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3d+cSr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3d+cSr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7FCC4CED1;
	Mon,  2 Dec 2024 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733139724;
	bh=wt8fAHvHw7fq8a87xaaoMOWZCAti1YWLt5GHipDkHCo=;
	h=From:To:Cc:Subject:Date:From;
	b=g3d+cSr2v1UXfdbZSEwdv1CU8+txVdv03HJ8gLdvz53ElvVcBmEnTMIhsId78juYX
	 4z+2vMOfY5T23Zm/wgRcAfygnDnix+O9cno3rESijLI1/1aoDmkn1S06GMF97NhC2/
	 u3PP+DXXb5fKc4sR+3+k9z56AAIbAlyAGfD19cRkFKudwahVO1tCsdSJxrOByjAZB0
	 lSUKgJT7YFX0asJTBxybXwkYu8Q1TIousyjajaMJilYOgPKLBnvCcDe/ye1PfN8wm2
	 F+W/8NeyTTvgHe2XKztaR13V/FmhqAeUeMuLNH8ag86YdogNPOeV4Es6BV2y3fe3Sc
	 1+fZ9sUG7+l1A==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs/005: update commit id in _fixed_by_kernel_commit line
Date: Mon,  2 Dec 2024 19:41:47 +0800
Message-Id: <20241202114149.2666-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug related to this regression testcase has been fixed by commit
d5c367ef8287 ("f2fs: fix f2fs_bug_on when uninstalling filesystem call
f2fs_evict_inode."), let's update commit id in _fixed_by_kernel_commit
line.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/005 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.40.1

