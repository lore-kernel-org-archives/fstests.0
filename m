Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2218DB1E
	for <fstests@vger.kernel.org>; Mon, 14 Apr 2025 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631910; cv=none; b=ggwg9ytW0maXxw1vxSvIUYHuV4uB6+j5m2gtKG6uHyTZp34Lv6IfrrKAZ6cTbORGx0J9xULgykGA6xWL+XRaq9fu8VnmKaKNwNwNV/dxVU4yJZe/HUVpJMfOO8MuVQ0PgPqe65mOsuZ3u8x2eGxVwPLeWuaLsdutLuRPv8Ggg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631910; c=relaxed/simple;
	bh=d9oINBvcYRIsvuPu1mHIsMe9RNkL8NFVLsreN8q4TT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtlVuK6U4sJoZNSjY1WEdvFVZHvZr7cOQ8xb4ZQdckd/rKqInNjAchaza5FzI+MkfTLwXMXccYL0tnThtiN87F+mATW+nx1hqqehdo3FKhmMtjDN9/1+6WWCbOG8APAKlkrWr8PFDxbt09bMbQTwk1yYoL676y9Es+gZaNQ/xiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=artvMcyA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="artvMcyA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+Zic7NO4a8Bhfqvj9nzu2243yHCg/1NgxL1EawD5pEE=; b=artvMcyAqUounvdjs+qZDCX/hx
	UTDG8atBKzywR8Hh30kgDzttR3aSh3NgNjgfcNQJhOu/hD6E2ZeqwSIfdDjh29/0taZomvQdrl18V
	RsJA9Wodmj2pSYeY5oI9H+Jf2igA7DaMOA8+iF4BeAJxfTiPCl7/3viAuE6nBWmQh15+uIyzvFrnh
	pAAKFqwlEEPSV9j1hr1HM+ta2Hy5DK6UHpBHvZ3T3YSk0PEdXVrNnCJP+kyMxXT1jSMfREHjbzhrB
	IbMjjHL/S8pH1CwCMM2VQgbXadiOnQKWQmE7LPXhwauM9zLO9Fn8lvHuob0ILDMGBYcVQ6Z6dHqRX
	FfvzBUjw==;
Received: from 213-147-166-27.nat.highway.webapn.at ([213.147.166.27] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ISJ-00000001rPd-2zoA;
	Mon, 14 Apr 2025 11:58:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] generic/233: use relative path to invoke fsstress
Date: Mon, 14 Apr 2025 13:58:20 +0200
Message-ID: <20250414115820.399980-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This test uses su to run fsstress as $qa_user.  Because the shell calling
fsstress is run as $qa_user it might not be able to access the xfstests
or parent directory which might only be accessible to the user xfstests
is run as (e.g. root).  Switch back to calling fsstress using a relative
path, partially reverting the effects of commit c475ff6ff6d7
("common/config: add $here to FSSTRESS_PROG").

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/233 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/233 b/tests/generic/233
index df67b39092b7..91dc554d3478 100755
--- a/tests/generic/233
+++ b/tests/generic/233
@@ -43,7 +43,7 @@ _fsstress()
 	# temporarily.
 	ulimit -l unlimited
 	echo "fsstress $args" >> $seqres.full
-	if ! _su $qa_user -c "$FSSTRESS_PROG $args" | tee -a $seqres.full | _filter_num
+	if ! _su $qa_user -c "ltp/fsstress $args" | tee -a $seqres.full | _filter_num
 	then
 		echo "    fsstress $args returned $?"
 		cat $tmp.out | tee -a $seqres.full
-- 
2.47.2

