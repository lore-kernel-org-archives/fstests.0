Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0230E85B
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159107; cv=none; b=nTt/QWtvVmcdEmu9PRSRhdqFirLpBU9SJ6NeI8ssQuhvfpUIgwByP4Y2xxRMhi338eotF14QjDBp25/S+6j15uOWqEMwCfdjB2qp0yuUTCyg07mjUrKJHV8S0BBjQoNDPrQ95cK2ymixzntat3BssmryTFehBrdHk0EnQv+Wd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159107; c=relaxed/simple;
	bh=kKiYEcyDVaUbFuv9l6dD+OmeVFdAEFhUXbt5g9Qim/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAVw5Jp4vyWmVDYP/nHORH72uOAadTByVcsR4DstQQMRfeWxNDAKJdeP4zY6K25XjKlaGwc9HNXzJFvyDtS/XS/E4NgvOalBrzi2ez+ZfgdwtosO4C4FICVlIyT6hRzquKhfQpKW3Z55LpnCngQCkkewKOrk0Xd8DPfSaY/U7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xTneMCU7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xTneMCU7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DGT9hJD2CzTlp2CHEHevENvNCCLVxQPsPLZcB/FllAQ=; b=xTneMCU7kg/TFruWq3cylJUgEg
	JeJLFuhvbyj0SHYN6jU1h2VeQEGxN9vnJj3uLCl6sJvrIjo3xI3/xsAMN7giJq0y/AzMXj0kj1GCo
	pytvsgapux8ftMRgbHwokWVFwm8gH71GXStUxGZSWv1GVBL7LLWP3w263UHYcEMFEuOSJP08mkev7
	l78hK7jj0EcOVnHsnDOCqcuop1Q32s5Y33FRGwswpHtOFyIbyroXQw4vTDCBYgnFIiAjS7bl/U9fV
	x4y5zMy7i/sZkZASUZQQikqjGnKHvHH3zra5kJVCnxzTp+3/2o712akX8gHCReMLT2yaup4aRwEqz
	u3BCEQsw==;
Received: from [2001:4bb8:2f9:3a59:1608:d03f:db12:ee92] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0vrt-00000008ea5-0Yim;
	Mon, 31 Aug 2026 06:51:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: [PATCH 5/5] generic/760: enable sub-block reads
Date: Mon, 31 Aug 2026 09:51:08 +0300
Message-ID: <20260831065120.2578146-6-hch@lst.de>
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

generic/760 currently limits reads to PAGE_SIZE alignments while allowing
smaller writes. Use the new min_dio_alignment -r option to query the minimal
read alignment and only limit the read alignment to that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/760 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/760 b/tests/generic/760
index f270636e56a3..facd83e4af0c 100755
--- a/tests/generic/760
+++ b/tests/generic/760
@@ -16,7 +16,7 @@ _require_odirect
 _require_thp
 _require_hugepage_fsx
 
-psize=`$here/src/feature -s`
+psize=`$here/src/min_dio_alignment -r $TEST_DIR $TEST_DEV`
 bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
 
 _run_hugepage_fsx -N 10000            -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
-- 
2.53.0

