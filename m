Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01E3BBFD2
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159099; cv=none; b=Q0/5WmDlo2L/heFYHFJXGYqR5MLrm0fLs7dH0Ny1VpuuWGdIIoZMk52/dcwz4od8+1FWoOBhBQlZ4iGxEd/LptVDWxQ/z29nXMxA22xuNJszxMR1YVoDZNObCzY3ZgPoT5gTQxarKoFQ82AOX0TwN/eCzFYCrO9azbsmTEVnSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159099; c=relaxed/simple;
	bh=WIMaRjoaAOrs4Fp15IIkKSkgvQMbIgXtCAfKksRMs44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxnFaSGllFLAWLJs+UsHncIWoE1CSLU+CMcX6kaD59LHxl/PXmvR7+O8s938BvyufN8EuG/3QWOe5Mo5FPmvWKA47qRvmigm2pSN2tyU7b4lwfaAyiuyZvD40WYbk757TNM18vinhhVUUIIjhL95pp3oTi/XsA0jCi3lnbQ0hTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RQb0B3V/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RQb0B3V/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IwWhzSoB+Bc72IVaokksvinDyPeBelNxDW62GRnGOv4=; b=RQb0B3V/+9wyqs0zSZzr/CLMgP
	R/EHRCn+A8DjroFFmAb43tFJFis317y5mJAtp2Ahuum514OaO4KRctiehI5yCjDQAO2oP92gv13Jy
	kphsiuwpKhJKjonwDApq8ekxhUgPBEuosr4nOLtGasIj7D41NsVpCpTLh0D3QP+r5VHGxqtO+M0vy
	o1gadYje84C324Ai8phfXmJbbdA48zQOQYKa6hDdBFbz3LkGcmU9Sr418d+7U5N995uH2VBRTTdrv
	kYql7Lk6kdclR7b6H7rj0J8gSmB6pK4u0wioJ/sLWr1LDrH5aEZvBO5gG2ilcqxooB+CWxdF0mmGC
	D+n46gpQ==;
Received: from [2001:4bb8:2f9:3a59:1608:d03f:db12:ee92] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0vrk-00000008eZJ-3A2x;
	Mon, 31 Aug 2026 06:51:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: [PATCH 3/5] generic/091: enable sub-block reads
Date: Mon, 31 Aug 2026 09:51:06 +0300
Message-ID: <20260831065120.2578146-4-hch@lst.de>
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

The description of generic/091 claims that it tries to exercise sub-block
direct I/O, but the test currently limits reads to PAGE_SIZE alignment.

Use the new min_dio_alignment -r option to query the minimal read
alignment and only limit the read alignment to that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

