Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85935E1A4
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158847; cv=none; b=VBBEnY6kuTHylOT8JqevXtP32+NHYAM4fIO7i+3H6xpZ/PJRdGIGyg6m0kKCcm75HmXJNLU2Soc7CRStm0A/eNaPDcXxYtthZwVOMAcleqd/+lbOg7oS9lLTBGewEr6diVLdsUfqMFNZW67IFoxRN24R82VlM/InvN7MadcIDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158847; c=relaxed/simple;
	bh=BkrVawsVryLT9+0Eo4Pek2wnWpoZsohkx6y3p35oJIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UY2kGibAO81GJ78GxgoQnWt4sF7Ey9CYWG6qEBFVFgKj0DVpkAxKsqWnesxEA3ttpqnSBBtG26QrVk/bh+fORRJ1dkwT5T+cPllqjznLGY1K6aBHC8RO4esVmyYa1EjFlw1FPrimvQiDswpa849SCbuBB7tJwDCAycWrGuXl96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o8iyRGJT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o8iyRGJT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2Kiz8uIvwiGU5O1vOt0JaW4BdUaCt7Tel++1YB/Wlbc=; b=o8iyRGJTcjbJ0JpaVreu01OTKu
	eTKheVPSSQ/MOqNeqOikIXaoVbOO+RYkCzUlp7UYCBQc0KhKuWzqMEcZPgFTgA9SdFdbVU8X0spKn
	io0c2H8Bma7wfcXXB+/pM1Dg+AyKKl6DsTtrr1UVyaJbRip3+L1/k4ILwNKJu3IPfCFsmjT8pg2xM
	tPTpEMziec8LdWtbRX5AS4Ce+V9cdCHxyf0P3Qfzz8XjvygoEN6qJQEL6Hop5HmJzwrsfc5P0Am0t
	AwqV3TpRG/397iDIAC9MIjHIXmtw7iuogyLH7NZuwh8c5u15U4XZwZNJ8uWNhCgm8ZB91PDjGbAy8
	gHIQtbKg==;
Received: from [2001:4bb8:2f9:3a59:1608:d03f:db12:ee92] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0vng-00000008dQE-3tLt;
	Mon, 31 Aug 2026 06:47:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] common: fix spelling of SCRATCH_DEV_POOL
Date: Mon, 31 Aug 2026 09:47:21 +0300
Message-ID: <20260831064721.2577381-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
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
index 5e709dd79993..d5af3a6743ec 100644
--- a/common/rc
+++ b/common/rc
@@ -1066,7 +1066,7 @@ _scratch_mkfs()
 }
 
 # Helper function to get a spare or replace-target device from
-# configured SCRATCH_DEV_POLL, must call _scratch_dev_pool_get()
+# configured SCRATCH_DEV_POOL, must call _scratch_dev_pool_get()
 # before _spare_dev_get(). Replace-target-device/Spare-device will
 # be assigned to SPARE_DEV.
 # As of now only one replace-target-device/spare-device can be
-- 
2.53.0

