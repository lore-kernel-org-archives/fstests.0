Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C63B3264D9
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159103; cv=none; b=eK3llNCl9V58cMI+i3OtktuTmcubIXp1uhkC8c4QT8jsHz9UR1+Z2ZMfaoWF67m8nrBLCWtTo8AzsN+3o+I2HZqk9ekR6fCkIDtDLtQ1JC/pyEb8bzBt7U8syPGl9IDj81oRhEepZFQxMpIG6JfeZpHfe1NGaEi5BI+oGE7UOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159103; c=relaxed/simple;
	bh=J97iiaa8nuDgtGyM+NMTt93Mj9cWzHBJYj+oBxGgv4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eznCdoodrYNRObtbs8BKdIAK13tgZ7ItvuZvd3lmyHsl+3ygEpwziV1OD91wT7KHczmBySLRID7qOJHnXy9FSKTVo1lHUc2EJ4RUFYIGmo5NX6CvOtIB1KrUEhvqJ56fY8InYKdhwFnD/OA2LzyKAdy4kpNysu5+t6TMBBtfRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VM7Y9BWx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VM7Y9BWx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Cjb/6U6g/yAEGqlkLEVXJiVtwOsNj6yHCGiWdpYIQdc=; b=VM7Y9BWxkZ/zefOebCTFQqdq9j
	v9ba/Epu1pUX8L0htH9MEHl3RZnW5X+gWkBMukgicMfD08yxC6PMRwwGiqs6uY2mS/UVLxsbWfD15
	Uc35xlmERk5yibTypAwXRtShYC65mXEplC91gkggIyz7+YAvTemlVyc57DyiJWdTkEU32+EEmbGJL
	5FEGvuH+lz76Va5DRAVVPbddHoLFCGvgFEabYR7shXNvG/kfRVn404G7z4xNARIyebEdlLJVMDkeP
	dETWTUuP8b7PpiTr43iy0kROXLsaU+lxfM4139AzSOJ+RjkK1DFEHXoj3rqpbZW4QIz3jxEfVPAcy
	kh+UaCHg==;
Received: from [2001:4bb8:2f9:3a59:1608:d03f:db12:ee92] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0vro-00000008eZr-40LZ;
	Mon, 31 Aug 2026 06:51:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: [PATCH 4/5] generic/263: enable sub-block reads
Date: Mon, 31 Aug 2026 09:51:07 +0300
Message-ID: <20260831065120.2578146-5-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831065120.2578146-1-hch@lst.de>
References: <20260831065120.2578146-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The description of generic/263 claims that it tries to exercise sub-block
direct I/O, but the test currently limits reads to PAGE_SIZE alignment.

Use the new min_dio_alignment -r option to query the minimal read
alignment and only limit the read alignment to that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/263 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/263 b/tests/generic/263
index 91cfbe5253bd..c456d62ebd43 100755
--- a/tests/generic/263
+++ b/tests/generic/263
@@ -15,7 +15,7 @@ _begin_fstest rw auto quick
 _require_test
 _require_odirect
 
-psize=`$here/src/feature -s`
+psize=`$here/src/min_dio_alignment -r $TEST_DIR $TEST_DEV`
 bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
 
 run_fsx -N 10000  -o 8192   -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
-- 
2.53.0

