Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C743A1A2
	for <fstests@vger.kernel.org>; Wed, 21 Feb 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497466; cv=none; b=TRejuDveEsQAu97vatsuXj35annOVRqammxA8hq54V+cfndKtZqK9Tw3clvgjDfbJKJdmUvqdLTaizUzdeu02y7+3AfGEzvz1FZ24c58PSJCTQLLLCbfrpH5iizW/9RWBE5hZ88RA+3D/klMfCIcObeOH2eeCt8vkXFvIp2aNnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497466; c=relaxed/simple;
	bh=6BMHqsIIcNHNIlPjPc9XTFTAxSYypttRvhMALqHIBq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gsvVP2xY6BcLGktBBPhwJ8fcVElUePK8UYOs5WidgHhX9REokFVIYnU3I0IemGOhv8xFNuDWAz3tw4NNgxguey/EXBTAXgnG4ZcvCuwsqqnzc3mZoEJFzGrlrsq/6HEIitfS/+Vi7lTYTDl7V/s3wmIe87q9TiYt/chYTtM6Y1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iGnne90T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iGnne90T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=i6woih4PWTV/IrJFPiI2B6dcSr1daxjr1u7bbielahQ=; b=iGnne90TAEmpfH+wIRATurLwKP
	HV7I9k5MSJjUgKFU5BfXC8wFeBITWrBD9Yrd/7c93Co1wD8svteShS6m9JBNeEo1ElDt+rz7MRTOG
	C33b7ETdyBKLrigkFaPaXpC7Ts/BlBWQSnT9EqYSBcN/WvWGMBYZXCXxG0Efw5J7FNhJC30mHJfAN
	0G88T+TpeqYK2iyuESCGFeOw0nuZb091ALa92VvuzdorVQaBnIH5XLwbvLzCUPzs4w3C9mp1s4wWL
	PcfCEMMSczz+CvytrztsrjjZQ07xcY8fx560BPgWgKs4sJa1eW+Y/rJzkDcd6PsNDAQL12hmLQmPc
	MiT/Jgew==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcgEh-0000000HMET-3VYB;
	Wed, 21 Feb 2024 06:37:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] common: dm-error now supports zoned devices
Date: Wed, 21 Feb 2024 07:37:41 +0100
Message-Id: <20240221063741.3563039-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Since kernel commit a951104333bd ("dm error: Add support for zoned block
devices") dm-error fully supports zoned devices.  Make use of that to
also run error injection tests for zoned device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/rc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 524ffa02a..f207d8ab2 100644
--- a/common/rc
+++ b/common/rc
@@ -2193,12 +2193,10 @@ _require_dm_target()
 		_notrun "This test requires dm $target support"
 	fi
 
-	# dm-error cannot handle the zone information
-	#
 	# dm-snapshot and dm-thin-pool cannot ensure sequential writes on
 	# the backing device
 	case $target in
-	error|snapshot|thin-pool)
+	snapshot|thin-pool)
 		_require_non_zoned_device ${SCRATCH_DEV}
 		;;
 	esac
-- 
2.39.2

