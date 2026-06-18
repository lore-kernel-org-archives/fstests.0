Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54A24E4A1
	for <fstests@vger.kernel.org>; Thu, 18 Jun 2026 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810595; cv=none; b=SRds0yTpkyYVWVLgOXoIdHyYcP/s0v6A0eAQaRPitPzgyTNztKao+MQek1R1hbXpHEu2yiuPIH0303iH8vR2ZvY5+5ir0FAwluEsMPPuT06QT62OKzdC2j8pSb37nFfSg45HSawduWr1kFlZyHzpP9ZM9LH/zkRNPeBF84stRXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810595; c=relaxed/simple;
	bh=+w3tv3lNPq6y4Fn7C7zpP8Hhy/FxcsNuEOArRzRPlgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3wklaypyjDbpBXaEFwk0ILW2oeey++4/XuURMvLiIGgrzbCTNJ410DwBbYLHQIVidp/V1WS0XYKn3pTT4DsMsUmQi6e2tLgYq6IDqc+eAtimSboExqV/PRivwD0CMawxqBV3d/AE9rneAKs1rKGKxwmwom3vs/ZjS2DKTNN9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=iG349VK5; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="iG349VK5"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id CA9521D485;
	Thu, 18 Jun 2026 19:23:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me CA9521D485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1781810592; bh=+w3tv3lNPq6y4Fn7C7zpP8Hhy/FxcsNuEOArRzRPlgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iG349VK5gCZAmYZEKk3CmPOniAOgUCTJFG6MWi0sPHA82kGLccdp9IhEJkE1uiDeP
	 i6gb8wu4dkaEMq+LNOizVAmQztY6c62r0MwEJMuh6QSRs7yrU3FBKTeeDsEl4LW15C
	 ui+NY8uZ9W0VguqhBNatKGFXgSEJozccTuDwxpN8=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id SooBCZtFNGqfogYA8KYfjw:T2
	(envelope-from <dxdt@dev.snart.me>); Thu, 18 Jun 2026 19:23:11 +0000
From: David Timber <dxdt@dev.snart.me>
To: Zorro Lang <zlang@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH 2/2] generic/740: add --force option to mkfs.ntfs
Date: Fri, 19 Jun 2026 04:22:36 +0900
Message-ID: <20260618192236.654082-2-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618192236.654082-1-dxdt@dev.snart.me>
References: <20260618192236.654082-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mkntfs refuses to format the target if it's backed by a "real" device
but not a partition to maintain compatibility with Windows. When
formatting the scratch device in NTFS for testing, this behaviour has
to be overridden so that any type of blockdev can be used as a scratch
device.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 tests/generic/740 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/740 b/tests/generic/740
index 4f8bf099..718d983d 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -72,8 +72,10 @@ do
 		postargs=2000
 		;;
 	ntfs)
-		# "quick" format that doesn't zero the entire device
-		postargs="--quick"
+		# "quick" format that doesn't zero the entire device. Use -F so
+		# that NTFS-3G mkfs formats the volume even if the scratch
+		# blockdev is not a partition.
+		postargs="--quick --force"
 		;;
 	reiser4)
 		preop="echo y |"
-- 
2.54.0

