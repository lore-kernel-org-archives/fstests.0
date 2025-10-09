Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD02D73B9
	for <fstests@vger.kernel.org>; Thu,  9 Oct 2025 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000932; cv=none; b=pevIvNW3FKIEpKmqu9DeF/bslJ9xtxR6/H7Sqv+OFsEKbMu5eGG2UX2U+40hFmE66ZHmayBoms9/P9osPNqJkiI2WFRNRahpBIjse1DHdYAwonXgZmOGMx7P0XszXi5AQVlR3JzO9Q3fYNyDi9KWQvPi1BYz7jjFOTRMxyVwZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000932; c=relaxed/simple;
	bh=cSF5nnWAkuG+2VjrxbmPPHyWmyDje6wogp0OrhnscnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UTFMvKDu2ZG88HmW/hlZXFhyERcx8ddcYgbIKWKxhpqUTgeNz2WCMBsYm+zMbm60F6+A87gS3NFKmQJJs3cRNebV8RHt34HnwKCmJU1SkcDqA0F0YQ/NRYnOCRku6XT+f0gXJqUvN29boJdVyGlfFLkGWujQ/IeAnecvP2qy/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsOd2I7Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsOd2I7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A5EC4CEFE;
	Thu,  9 Oct 2025 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760000931;
	bh=cSF5nnWAkuG+2VjrxbmPPHyWmyDje6wogp0OrhnscnA=;
	h=From:To:Cc:Subject:Date:From;
	b=rsOd2I7QI7V1OweWULDrGrHF1WCddyzoKz8XXXxhoiESV7M3flR330qa7JgqT5jlV
	 zCQMb1bpy0tiszdFs3roJjEbh1Oe14MXJeK464dmmYX4gR8NDkVNx4VfdJCawFgxYu
	 rhqzDWn2+TiC2jQJ5VP8ZkrSyKUghb0YUCmmRlUq2SvhiG6SARs1YOUO+WjSUITW5c
	 r2bgm+VHBK3jfh7ZTRgmuFZJVDrbbv0r+KPxajmLQ5Mme4xyqoIw69EJxRZVzcsf81
	 OgK4QJPUXOM0vbcH+/jPocSL1gst1AxxnuR1YfYNMbD7och2VxtH1nFgxuyFaiYvgg
	 Wf06o3xaxJ4Tg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] common/config: source common/f2fs in _source_specific_fs()
Date: Thu,  9 Oct 2025 16:50:41 +0800
Message-Id: <20251009085043.16910-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's source common/f2fs in _source_specific_fs() instead of in each
testcase.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/config  | 1 +
 tests/f2fs/002 | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 22b52432..1420e35d 100644
--- a/common/config
+++ b/common/config
@@ -509,6 +509,7 @@ _source_specific_fs()
 		;;
 	f2fs)
 		[ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
+		. ./common/f2fs
 		;;
 	nfs)
 		. ./common/nfs
diff --git a/tests/f2fs/002 b/tests/f2fs/002
index 74146217..d2f6e413 100755
--- a/tests/f2fs/002
+++ b/tests/f2fs/002
@@ -43,7 +43,6 @@
 _begin_fstest auto quick rw encrypt compress fiemap
 
 . ./common/filter
-. ./common/f2fs
 . ./common/encrypt
 
 # Prerequisites to create a file that is both encrypted and LZ4-compressed
-- 
2.40.1

