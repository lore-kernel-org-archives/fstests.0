Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC5229B3C
	for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779086; cv=none; b=IME9vOJEJAl66VJk43Z1+0FkQnICKaSztWcFfzPbIRUVRQjUbSWurhqDhC5tJChW0z6I11K5E1rKX8G9Sns9AUWzCQsg2r2vb4M5yGiC6GdKGPM30ho8F+kN7QJcdxOafnoKDcrURGWuOhuA4Eix3I9KI0odC7Xqwc8UJvVaScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779086; c=relaxed/simple;
	bh=+Cv6z8rA4klCwmr5cRIX4GDyeDUPq+uVOcD4eAdbdik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRXM1VJzbYWV57iQpicOgALn2nAY+inCSce22UcQfenKu8xBrW7ITtZdolhwlw1I6EsV+QLeYZhS9g7hqXgAYBeRluxG9bQ7Rd645RxtbIldG9+X2itOqMAf3/oAHhSTTFVNVXcY92GxhC25nHh3X6L9/PyHKV/aYbcrPViaSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0x3KGoXE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0x3KGoXE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mmfZtHzWXUflqoodbYlhSM0XgoRm0G7amNjWpZP9Xyw=; b=0x3KGoXEVlUyqp6IpCZw5C9Asp
	Lfjo3nQptsF38IwzpNdX/oFPA7ld1Gv4B9YBucf0Wc4KVFeqlhQz80yDZp1DhOLAXk7Fym4KIdqot
	t6n7Q9riloobZhjV/547KVWh46ORZuQ+Ot4S2MB5ODPRpQIQWWXpSnQXgh+He41+coGDosJjflw+b
	fuBiYoSW3o4fJdLcMPxpr/sBHXIA5lmaiAtlkREnPlmkPWUZWnvYcNbT7fabAxM1Bwu9pVvA4YhmH
	PLScM+rkSTzYuamdlDXpWm9xbqmH2yWD3qTI/YYUF2kAfO+7pxq6CgIOzvgHSvzbsAAQbe5oOSSno
	bzCxKwbg==;
Received: from 213-147-164-187.nat.highway.webapn.at ([213.147.164.187] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4uk8-00000008C3G-107O;
	Wed, 16 Apr 2025 04:51:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH 2/2] generic/233: use relative path to invoke fsstress
Date: Wed, 16 Apr 2025 06:51:12 +0200
Message-ID: <20250416045112.617815-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250416045112.617815-1-hch@lst.de>
References: <20250416045112.617815-1-hch@lst.de>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/233 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/generic/233 b/tests/generic/233
index df67b39092b7..3fc1b63abb24 100755
--- a/tests/generic/233
+++ b/tests/generic/233
@@ -42,8 +42,11 @@ _fsstress()
 	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
 	# temporarily.
 	ulimit -l unlimited
+
+	# The absolute path $here might not be traversable (+x) for $qa_user, so
+	# supply a relative path to fsstress here.
 	echo "fsstress $args" >> $seqres.full
-	if ! _su $qa_user -c "$FSSTRESS_PROG $args" | tee -a $seqres.full | _filter_num
+	if ! _su $qa_user -c "ltp/fsstress $args" | tee -a $seqres.full | _filter_num
 	then
 		echo "    fsstress $args returned $?"
 		cat $tmp.out | tee -a $seqres.full
-- 
2.47.2

