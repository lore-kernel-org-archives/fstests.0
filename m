Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046BD39FCD7
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386366; cv=none; b=WQZb4zuoUQwJMxvVVfb3aInEkcCIi+aNyoKaGZqFLmsovr4H6L5wk4jWDw4QDnBemLqqcog8rIrlttvQBQBqSqcuQ7y+B8ddvEOzHFDohL8bdQIA0zdHosr9SNLbe+HZ5ynlURtCI5FLV/2DufKyCsERTvh/qKgqcvYOlRXVulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386366; c=relaxed/simple;
	bh=6nZ4M44hEQ3Ojnjn1ma/1OZsChbFYvx+7iSc25mhmP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnTxrGq90YccYhT6x1SD9T6IpbXdLRnUJUv/88gqwGbhU2vXDrrDRnW6ui9vH21Brfb7d8/fqpL8Hek/DhqJxyoBW+hVX/a1h+roImH0XwNko7D9nCDv+azYICAKhz8ZokCjGR+O0cyWdzVfpL/wU4QboZcSCi2SPx8Ek4EhOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N3tMWAQe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N3tMWAQe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LxSkWpGLqmGFOGCqGWIQn57bfX1cpQS18LeodP9rtHY=; b=N3tMWAQeME5OsPNmqtuY56jyla
	JyZhXknxf0/D3gbSZc00TEHZsQaIYbwMWj+dEGoMW2y95+uBbF87X/o6yaai17W1gYmdRwO2aPH+p
	1gseLPz3+l/0seyZI5oX09WAvx5Ajpntv62IHUcViESUcNzqMv3cKcJrtD0b9A95LQAF4S4I/Umse
	DeCsn+MTf41kfexRWCp+sjLH+408e1U+3CoQc28GWiqKcTjZv1V9JspXtNeNYm4ib6w9WXV0JTrfM
	xA90PICMvc6f5qIuyBI1tbh4ursFcohQLsZ9naf6dTL8r1j6ww2pFhwsqAWpHM2n1aM+J6EMHa74H
	Qok8zECQ==;
Received: from [195.12.231.4] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x658N-00000003N02-29Ph;
	Mon, 14 Sep 2026 11:46:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 3/5] generic/091: enable sub-block reads
Date: Mon, 14 Sep 2026 13:45:45 +0200
Message-ID: <20260914114550.2451308-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914114550.2451308-1-hch@lst.de>
References: <20260914114550.2451308-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The description of generic/091 claims that it tries to exercise sub-block
direct I/O, but the test currently limits reads to PAGE_SIZE alignment.

Use the new min_dio_alignment -r option to query the minimal read
alignment and only limit the read alignment to that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Zorro Lang <zlang@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/091 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/091 b/tests/generic/091
index 5cdf04890c0e..b2fba09d39ef 100755
--- a/tests/generic/091
+++ b/tests/generic/091
@@ -15,8 +15,8 @@ _begin_fstest rw auto quick
 _require_test
 _require_odirect
 
-psize=`$here/src/feature -s`
 bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
+psize=`$here/src/min_dio_alignment -r $TEST_DIR $TEST_DEV`
 
 # fsx usage:
 # 
-- 
2.53.0

