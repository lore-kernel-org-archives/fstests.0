Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E69721507E
	for <fstests@vger.kernel.org>; Tue,  4 Feb 2025 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676781; cv=none; b=tJJgC/VfJwg8twNlx5jGJ/4zYTmaS3nvmMpURmFo+/A4+z8V+RdMllTgJnWoVYOSX1zMVa1R4o2YkFPnLMyx7yz+/NIRS/PWqyBXT8KsypjBtflCsoa+a6g4W+t5/OmSbstNklf7k3TS3hY0B46gz8pQa7I2bCZ7r+5W4urwmYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676781; c=relaxed/simple;
	bh=mO33P4WEQD8cWo8cfl13YSIisSlQDCBcy7ROlOe/N2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bi9lMQ2nVyVGd0xZqf6oAeGcAMfwsZJgQIY+UEXM3GJSQgedHZ3xKaZPwBwv2aI/5VnUjLSLR3eqCCMRlK1ymKxTnmFtzhE+OgViCO1LsEOl0cFiDbLggoI3y2BdYJ0nb23J3dhbK64C7bHNGKLubbsU+y5cVBcFf07fOq7vZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bBCckd+7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bBCckd+7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=iP1J69hf4Qj60IsrDBCssvPD+67GhfJGQQRJq7ecvrs=; b=bBCckd+7BbwVjrkWDl8sJIJs6g
	X0/P3ZqDGFqpMN2niwhIa8jthTe6kRBkLsJeX4MgPtCUiCqEHXTr8dZ8xJaOuq09kUqmkAhisRd30
	45BxfiHtcfxkfx0fOj2U3v7zh7Puk7CVeAtb+sJveTngaxH8qdnZedFMIslnGvYCYkZr/MzBQXzUu
	RnlKAng6d5JH5FDx56mHXJnvDjNte5ynRzY4Vxhyt74I2bCHE0eftSJmPG/cYBQS7eX+uj7IUaqfk
	6Z43GJhIr5ili13Y/vWjnDO1ayUj0/lq/QCFgOAN69CQhuBsQHc6YfOcsQ2KdMuTQ+x7x2MilkBpr
	5DPr3PfQ==;
Received: from 2a02-8389-2341-5b80-c653-ac45-db09-df54.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c653:ac45:db09:df54] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfJFn-00000000ZMa-3ASM;
	Tue, 04 Feb 2025 13:46:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] common: fix a spelling error in _require_zoned_device
Date: Tue,  4 Feb 2025 14:46:12 +0100
Message-ID: <20250204134612.2017269-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 4658e3b8be74..6840bb1dfa10 100644
--- a/common/rc
+++ b/common/rc
@@ -2473,7 +2473,7 @@ _require_zoned_device()
 
 	local type=`_zone_type ${target}`
 	if [ "${type}" = "none" ]; then
-		_notrun "this test require zoned block device"
+		_notrun "this test requires a zoned block device"
 	fi
 }
 
-- 
2.45.2

