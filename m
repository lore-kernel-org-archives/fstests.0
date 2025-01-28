Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1C198842
	for <fstests@vger.kernel.org>; Tue, 28 Jan 2025 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048494; cv=none; b=eAqFzM9090F7HE2iL5eqet3/vh1vLLeUxFh5C+UMqtuqFx5kBtD6j7Dnnb65AtO7ZBb3eIS+tK9gWvRr89B7nGcDUxNpE/7Aaz3k9MMUYni0w8nJTORk/WaJR9CrLtzpIeJ2B4o8h2/RdFH9zjOcQYkY0nIShnT83AtBKZMO8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048494; c=relaxed/simple;
	bh=jQwk7q+lvO7vCv0YqiY2vv3D1TGSHyN+H0JeMPy8iy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mub4kMomE4LbxdhsFv4k8iWFTEylJ0GoqAcodtIgrc36JKgLFMrosFFvifybbeS/6KZYv76tuNY5yyIJfMbJxFA8Ir5s831snyMIzKppwENOKwNsiYDXMhEAScprNnjbahwynUD4anszNxVBDmonS0/S8wdszbg3gk14uG2lICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KEmYBfjR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KEmYBfjR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=/nlCq97NMjtka+qYrJyZreYp33jgLY5Yjau9UtcFbTg=; b=KEmYBfjRmxNZ8g1alDAvUXDIiZ
	CVDMbkeL5tNgdIYrRkAzPaoLgnjsix4nEffcxGYwSEAPy8OOGBp0u0RXIa9rfXROhb1cS7qcDeJLw
	x9uLjvwzZG/ocYLR87OoBojIk4K10bRPyzCK7QXonvkaW65kaCLnGog+IQRT/oeMpDq2IZKPRS6lM
	24e4tPW3i4n/tdrzkMpSJBkAQZssKh9PzvLzIwiWLL75hA1JWGzSgTgVbI5TRyFYqPr3vpkbvtyB0
	1JvhgBrARbbPYNLZUXP8eWPTKlIIgYHev0XN+2OS1baAu2/uhv0USmawg4qcax6vV1ObQBaeuZK+K
	dYSCgZoQ==;
Received: from 2a02-8389-2341-5b80-d7c6-3fcb-a44b-90d7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d7c6:3fcb:a44b:90d7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcfoC-00000004GT2-153d;
	Tue, 28 Jan 2025 07:14:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] xfs/541: _notrun if the file system can't mount
Date: Tue, 28 Jan 2025 08:14:48 +0100
Message-ID: <20250128071449.676462-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

A file system created without an RT section might not be able to mount
with an rtdev specified if the RT device has a larger LBA size.

Instead of letting the test fail, _notrun it for that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/xfs/541 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/541 b/tests/xfs/541
index 42bcd95802c5..c8b312fddc92 100755
--- a/tests/xfs/541
+++ b/tests/xfs/541
@@ -26,7 +26,7 @@ _require_scratch
 
 # Format scratch fs with no realtime section.
 SCRATCH_RTDEV="" _scratch_mkfs | _filter_mkfs 2> $tmp.mkfs >> $seqres.full
-_scratch_mount
+_try_scratch_mount || _notrun "Can't mount file system"
 
 # Zoned file systems don't support rtextsize > 1
 _require_xfs_scratch_non_zoned
-- 
2.45.2

