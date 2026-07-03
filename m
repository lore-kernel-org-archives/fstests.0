Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6D3C98BE
	for <fstests@vger.kernel.org>; Fri,  3 Jul 2026 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086309; cv=none; b=aQKYNNOqhGhPpzgMabFOu0gdaegRi58dPMMIZ360uWNKro8QhLqztyJieC/kdHb2+sLzMY7YnbYPhQd8vwYLn/mrH9hcg1rw0H9iYd4JS1g/o1ScFYJ9pCyI/DCHm5pZcmKxykFOJvqm/prxQQvvEPzO/Q5fFWcva1LEVidVRSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086309; c=relaxed/simple;
	bh=7GHrZedaba9UwV9E7+ieccLRHjyw444gjzicV3CK/X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCYBWf0uyJaGoqJNlYQV/yQLjFaeoVg0W1VV8TGyAWNgOGg2rBWVmVs9Nx/XGKW4mRjaN3j3JdysFm/6cOpMRWru5lmjw5QxlvLQRiTr8NhVr8H0MGOfeIsoXbYwUWnceNG/tbAufH9B2F7oESg6P7DtsODtzBpAzNThOrioQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=motw6gND; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="motw6gND"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nE3CUHgU3MEptUxDqD06EkZvkeC/jZS8w8piUApNMRI=; b=motw6gNDM7lPYvboHf2VjfNWU+
	EqeFefybjNiOu1L7c7YbxcWznZu14l2YMPuQIWDnn3aKfszmsPuvyW+34OmbSKTXZZKb2rww6etgv
	U3wWts99zjTyGg1ed0oH+mChtP4btyenwt8IYN5rfIERVf8LiTOGzpe6Rj0GwYnIu95Ub/myxM2Ia
	xqNQS6Ev3Vkvv2xKJGm0AxGchKdA0idRRU/u36unXudjgSvNW6Jti4ZDGves0koDYbR4FSfAfpz40
	UisQE5CrLwo0BBOWRPVj23wgf0jdBrTOVcx1Vl/IxSBJ18b2ssyLFT0/TBQ/huFLvFe80s/hh0gkJ
	Z5vAivvg==;
Received: from [45.156.240.119] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfeCX-0000000782H-0F0I;
	Fri, 03 Jul 2026 13:45:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] common: log mkfs output in _test_streams
Date: Fri,  3 Jul 2026 15:44:38 +0200
Message-ID: <20260703134459.4075731-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Log the mkfs output to allow debugging the mkfs paramters,
especially when mkfs and thus the test fails.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - append to  $seqres.full instead of overwriting it

 common/filestreams | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/filestreams b/common/filestreams
index 459de8c6b6a6..c40b33e4b0b8 100644
--- a/common/filestreams
+++ b/common/filestreams
@@ -89,7 +89,7 @@ _test_streams() {
 	# Skip these tests on zoned file systems as filestreams don't work
 	# with the zoned allocator, and the operation below would force it into
 	# the tiny data section only used for metadata anyway.
-	_try_scratch_mkfs_xfs >/dev/null 2>&1 || _fail "mkfs failed"
+	_try_scratch_mkfs_xfs 2>$seqres.full 2>&1 || _fail "mkfs failed"
 	_scratch_mount
 	_require_xfs_scratch_non_zoned
 	_scratch_unmount 2>/dev/null
-- 
2.53.0

