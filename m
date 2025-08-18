Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A89279912
	for <fstests@vger.kernel.org>; Mon, 18 Aug 2025 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502055; cv=none; b=AcBEWvZaffKuoihOgRaO0JwcPwHwWQKbyNnLIZx0l4bD+5ST+DO1HhD33Wo3tNKoHaz8awF1OXitvcfWBcOZmkdBmXqSKAvHSCv2OHJbgSFSWEUJk1b5gUV9VZGLBZTOJ1rD3hH63WhcRYyaUz3jaNvM92I8A4TwC0kaOJPTpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502055; c=relaxed/simple;
	bh=WkS6COpZ3FbswIiYVtoT0nmqIJ6MqqPPIfRNGjjjXIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bubwd+koyObH/XN5pkBnS4XuNv99PpC49N8uQej9EJ7kRWW0KyqGD70cD6N68GBvPVixeuD9JhIB9k277MS7/gt6mdDZyXYD1wlq1yWy5HP3oJwWOiFijbwfxp3F9UJITHXTdP2zG1Qs+oU0Ljw3k1DgfNA1li+8SjnaZ3XvXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BReirCvy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BReirCvy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=me00rVAv9P/xAncVaoack4S6NsGJSMaaV35AHZqdhYA=; b=BReirCvyAoZiLWR+T6C7wYgSeD
	GJi3FHOWDKUaQQrf+wrqY0O7HY35Wc2uan0r0b8YbhG8TCI9YsMsGo2mxXOYOcab6OljH3TZ23uYd
	J8k7YSuaUh3V8ErUX6LmAgpXT1J+pFTVX+RKNjJXu//ybQv8zFgt6g/PojakMdCeQ1GFzvtDeuxlE
	RUyrL0wgmGvjYGRoFlAPP8jXRFmsETOLUlD/OEPJ4/vthDVs1v717iYamNezKs6TT8Nf4jXHatfzL
	NtXvJh5uJrpCwnc+QD/I/E6Y1d8z05o7DMW9vl9kKDC6cUGwbh73cRNY4WJIh7lxTLgEB63YRrW6D
	ReuAAZwA==;
Received: from 85-127-105-248.dsl.dynamic.surfer.at ([85.127.105.248] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unuHE-00000006mkK-0Mnj;
	Mon, 18 Aug 2025 07:27:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: [PATCH 1/3] dmthin: _notrun when dm-thin setup fails
Date: Mon, 18 Aug 2025 09:27:16 +0200
Message-ID: <20250818072724.1559133-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818072724.1559133-1-hch@lst.de>
References: <20250818072724.1559133-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

dm-think does not work on device with protection information.  Instead
of failing the tests using it in obscure ways, _norun them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/dmthin | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/dmthin b/common/dmthin
index 453e43a0499e..a1e1fb8763c0 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -105,13 +105,13 @@ _dmthin_init()
 	# Metadata device
 	DMTHIN_META_TABLE="0 $meta_dev_size linear $dm_backing_dev $meta_dev_offset"
 	_dmsetup_create $DMTHIN_META_NAME --table "$DMTHIN_META_TABLE" || \
-		_fatal "failed to create dm thin meta device"
+		_notrun "failed to create dm thin meta device"
 
 	# Data device
 	local data_dev_offset=$((meta_dev_offset + $meta_dev_size))
 	DMTHIN_DATA_TABLE="0 $data_dev_size linear $dm_backing_dev $data_dev_offset"
 	_dmsetup_create $DMTHIN_DATA_NAME --table "$DMTHIN_DATA_TABLE" || \
-		_fatal "failed to create dm thin data device"
+		_notrun "failed to create dm thin data device"
 
 	# Zap the pool metadata dev.  Explicitly fsync the zeroes to disk
 	# because a slow-running udev running concurrently with dd can maintain
@@ -124,16 +124,16 @@ _dmthin_init()
 	# "start length thin-pool metadata_dev data_dev data_block_size low_water_mark"
 	DMTHIN_POOL_TABLE="0 $data_dev_size thin-pool $DMTHIN_META_DEV $DMTHIN_DATA_DEV $cluster_size $low_water"
 	_dmsetup_create $DMTHIN_POOL_NAME --table "$DMTHIN_POOL_TABLE" || \
-		_fatal "failed to create dm thin pool device"
+		_notun "failed to create dm thin pool device"
 
 	# Thin volume
 	$DMSETUP_PROG message $DMTHIN_POOL_DEV 0 "create_thin $pool_id" || \
-		_fatal "failed to message pool device"
+		_notrun "failed to message pool device"
 
 	# start length thin pool_dev dev_id [external_origin_dev]
 	DMTHIN_VOL_TABLE="0 $virtual_size thin $DMTHIN_POOL_DEV $pool_id"
 	_dmsetup_create $DMTHIN_VOL_NAME --table "$DMTHIN_VOL_TABLE" || \
-		_fatal "failed to create dm thin volume device"
+		_notrun "failed to create dm thin volume device"
 
 }
 
-- 
2.47.2

