Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45FC28F50C
	for <fstests@vger.kernel.org>; Wed,  4 Jun 2025 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043169; cv=none; b=gc24p6JciJGauUMAIQDnyjuHyUfhnIj/inf0E8GI9mlU6q6aP6C1fwgKzCzxXa1slHOdxr1TvNIAGvyxCmD1QVkTwTCY/R0UkG9EPtmMfDVef/Q088t07at8789gkcaBTUoKNaSbFO2/2IHkNSLgCjVl9vjjgwz/PgiBWn5ks2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043169; c=relaxed/simple;
	bh=k737KcEhzNlau3kT0dpS6IdPkMNlECMP5Dh/Q8QbCuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dgce4g3v/JtaLzrN9uTlcVDPAuYfA8PIKlUkjmgbtYKaH6t/2J81zObUFCifChQJttHaMhW6DGWm4vQOUH8XZbfUJfv1rBEZd/jkF5soWtr0F6pPV170kp2t0EANkPKqIg/y6znJs/LtfB7WOTgK+ZgCpufjb4Fkf6U7PV8gE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KhKQR659; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KhKQR659"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MYWkc2eGwAqNV1kGyk32A69uceagSlsmAunsnj0b9Mc=; b=KhKQR659mT4Ey1HYdD3L0irh3/
	RyMjF1GacgPGVBDLPz5e1A01opZ3DIHQw6P8S9pV88kVY5QYs3JoF3MvsA/qgxMu0NrD8Jz2T5d+s
	RLDnecL1LI7qBvilVqjS6fA7bru+R2nYfJsOdc8qk/FYvH4cmyaEtCisSpdLKOpX79C/E3s6TjG/d
	xo7VBhcZ9DdfRWSxPxCxdfdJx6VTQkqc99N4vr0HDJwtUG38+lIaalhahOqoc18TwLtScKjGjyg7g
	PM+8wf8lpbQcGjzQe6DYL3PJXe+A1XKKzaLsMTWJwC3w+cM3bJK3yPa/idlgYiWJMKqaVAu2VA92S
	vk9NwGZA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMo1d-0000000DQXm-2WFG;
	Wed, 04 Jun 2025 13:19:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] generic/740: add _require_scratch
Date: Wed,  4 Jun 2025 15:19:22 +0200
Message-ID: <20250604131922.848228-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This test requires a scratch device.

Found while playing around with a setup that only has a TEST_DIR.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/740 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/740 b/tests/generic/740
index c0a634f2302b..d14e873b2fac 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -21,6 +21,7 @@ _exclude_fs jfs
 _exclude_fs ocfs2
 _exclude_fs udf
 
+_require_scratch
 _require_block_device "${SCRATCH_DEV}"
 # not all the FS support zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
-- 
2.47.2

