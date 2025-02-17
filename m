Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F1383A5
	for <fstests@vger.kernel.org>; Mon, 17 Feb 2025 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773902; cv=none; b=byeroCA/ABOLkpTFoAjJwv7q33hAfk3Squ8Ab/ZyM3MBcW74eGePKd0Z2FZf8g8ezxO81NR/fc9arjsezrlbOXHCkaCle8dgj1QtaL7OZWWnbvy2wuNmcfOExsqZJTmzmk/zrkSY3+THKSo1dsTjlcqpqdjgEWrNPSMZK2zTzPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773902; c=relaxed/simple;
	bh=7pnVRnKY5d6/d4q4TiMGQt6hNgfFAdckK/P/bqTlgc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ao25LHxeHnm23ac7525KFx+o46/jqjoM4ZR4UyGNYKv+JNqt8Qe3ZN1/tDaXQn4iRtjPbsfPcmh8LzRd1uSoFGJ0kRnxrvXYl+4od4b9TkqV4i2xxXiSombCbeEpPDamAr/vXV3+sHzdFQJy70cyRukQ405wDDlQtdUqA/iM3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kgcwguIN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kgcwguIN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PO8tGeFkMwZTu8NlKR/EK9EcDryhYpbSvbCl0OLGJEw=; b=kgcwguINcxlYgBuk6awBxkFu5A
	jIIJSq0eh64ewF8AHiJ8YnlF+Oi8+JA4i86exQFStPBUQlv5mEo4objb7zFULY0hh72WLpfhvyIfd
	AQIkqajw/jS9eMVyeAGWD5tBD3mLvsk9+371y3FuoZsacvo3clOxASyYt5x+0m8Xsmjl/LDNrDw4g
	uekbLA7wB01MkTDJrSwFzunowItwza+LUhonGs88s1HCeCK3SnWgqsDgIeaEu5c/Bi2xa5fWUxQzN
	sYtew1YbSfaJnD4lq4zQT/fXYmAD4AVyt8m3kdy6bEUdbWPZCT1H1q5UAd46UZYgeUkuHE31RiBSQ
	Ol2u8n1g==;
Received: from 2a02-8389-2341-5b80-a8df-74d2-0b85-4db2.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a8df:74d2:b85:4db2] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tjufL-00000003U6M-1fNZ;
	Mon, 17 Feb 2025 06:31:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] generic/370: don't exclude XFS
Date: Mon, 17 Feb 2025 07:31:35 +0100
Message-ID: <20250217063135.3728305-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Skipping tests just because a file system is broken is always a bad idea
as it hides bugs.

(Fortunately despite hiding the bug this is now getting fixed in XFS as
 well).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/370 | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tests/generic/370 b/tests/generic/370
index 8adffd2e9650..8101ef42724e 100755
--- a/tests/generic/370
+++ b/tests/generic/370
@@ -22,14 +22,6 @@ _cleanup()
 [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 03018e5d8508 \
     "btrfs: fix swap file activation failure due to extents that used to be shared"
 
-# Skip XFS for now because this exposes an issue that is hard to fix.
-# See the following threads for details about it:
-#
-# https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
-# https://lore.kernel.org/fstests/dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com/
-#
-_exclude_fs xfs
-
 _require_scratch_swapfile
 _require_scratch_reflink
 _require_cp_reflink
-- 
2.45.2

