Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD7C1D8DFB
	for <fstests@vger.kernel.org>; Mon,  2 Dec 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139729; cv=none; b=ZLSnhlY3UBszJVdO2i9YSVnkkF8NHzYTmWLmAuxsqC5T2r7b9A5Dm1cUp71OZk06YwJJ4ZUrs8uE8C42UfAh8ZmUiuydMcnTXm6TvyD43I05vU6sGucNhRiH91nVspWwsF73i5AKNGCg2Tj+Uxr0jokyqk2X/9xi9dRaCcZ3KLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139729; c=relaxed/simple;
	bh=Nnyh6xskfE29vfL92J+XXFzsEGl4lmpiruvLoSERMBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZQMRQnYuncDj8JnPnqFLgADcANJwxIRVYBLtRRCHcY1+EPhbocDd2+N7jUDju3USZBFAxONXvGgFBm9fSTx35+F3n9yQQ+osLnvyZECRRs7u49E6AwdGV47maSwmPAgqIK4JufETRz6rGpJYSeuspm1jiM22dvOvdj3+nKgLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4I6b/Kz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4I6b/Kz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AF1C4CED1;
	Mon,  2 Dec 2024 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733139729;
	bh=Nnyh6xskfE29vfL92J+XXFzsEGl4lmpiruvLoSERMBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4I6b/KzQHaGD2AYRELrgNM77ONY6x65fBPMeuTHqPuvJ512xcAvfNUpV0B0lLDs4
	 0VpaDo3fkgg2Dq1fHTgnF3B4AhUnzCZ5V8Thu7RJhS59l7H8uyRW4snzuJ5WU3fUFv
	 KmsLAn/zvunikO+F1Ws5vZ1pmPVDYqxHp552k7vJY7To/YmP0fV/9kYI8u5yKH/7+L
	 lGTDpeKAsSezK8BYn3MHXyuH83qHgAJJZox4tazWkbl6bMQhxIAnpVVP4V3q3YRR/x
	 eLRk3QNNLZBk6wRF8wCpOkkbwnl3SwdB+H8fphpmot5AEl/5rCpVmy6aSsJVx6auDb
	 5gFDHyLCqa/ig==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs/007: update commit id in _fixed_by_kernel_commit line
Date: Mon,  2 Dec 2024 19:41:49 +0800
Message-Id: <20241202114149.2666-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241202114149.2666-1-chao@kernel.org>
References: <20241202114149.2666-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug related to this regression testcase has been fixed by commit
26413ce18e85 ("f2fs: compress: fix inconsistent update of i_blocks in
release_compress_blocks and reserve_compress_blocks"), let's update
commit id in _fixed_by_kernel_commit line.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/007 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

