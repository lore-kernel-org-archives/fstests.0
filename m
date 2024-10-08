Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CFF1D0E38
	for <fstests@vger.kernel.org>; Tue,  8 Oct 2024 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371535; cv=none; b=IrO6QyDbmGY3EyMzJNHJgT8wMSIWohAXsYNLikJLwSP+JmPgVKEyDHF6Bhsw0vh0YCEreHm7Da6j+pRQWn5XjcpD1yQnaGR9/ea2mcYR85CsLl7BGpGlDCrFy5go0XyXvSyjxvvWwhNvRm3PF7b4rLjpVtXpNAhW1oeNe4+M67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371535; c=relaxed/simple;
	bh=cek0TtSTSHklIoBaw149vMnzyT8X1gxNgN6g6YFAFKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npmSnP8w1+sxwfuHoy/M5tPSbtTMgryjOLnBTvj2SrjSeMBD+dDQ84tdRi0f5qxCVCfy8oIWpSWwQa5Uq57+se3/oAL7Lq5NGvK8nQywp00a7r51QFM9cOSddYn394O77tdy8vOMwVxyUIbONj5sf5tGzKEkdOJAoh3avXgMmvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JQcL/mrM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JQcL/mrM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MrYoj+9giM7mi0tiR2jDlQAM0l1Tjzlo25StbjqgtQw=; b=JQcL/mrMsQpvMx40tdZKyFFLKw
	Gme0bu+GUteNcG4zZG3DF4BkWfjM4J0ktqLkx0EvqdpExKCBifn41y4xIoilAM7sxaIhmXrIVm0KC
	6cp9JqzQEFi0De6V0VoceefbVqmqLhqdjPR05i35joj//R6URza9/2kIpdUYDEy5Tntm7vFsTbtPc
	AKSpnOjNN78iLV6Ej+RF7cwOMegvQGboyzWiRDWlooo6Icwj671lHqGVz0mv5SzN9C21guBNOQoSr
	uFmGljMS19a04xS5k2H75lPfzaF5Zhwk/zIPOQNs2jvMP1g44SF1wzq6tCcLyAn3fj2ilGe+mR3Ga
	ydoPJYbg==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy4OD-00000004lAl-1GWk;
	Tue, 08 Oct 2024 07:12:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] generic/694: sync before sampling i_blocks
Date: Tue,  8 Oct 2024 09:12:09 +0200
Message-ID: <20241008071209.160188-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Without a sync there might still be temporary blocks in i_blocks like
indirect block reservations or additional blocks reserved for out of
place writes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/694 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/694 b/tests/generic/694
index 02253ef75..b6bc8a75f 100755
--- a/tests/generic/694
+++ b/tests/generic/694
@@ -37,6 +37,10 @@ if [ $? -ne 0 ]; then
 	echo "Could not create 4G test file"
 fi
 
+# make sure indirect block reservations and other temporary block reservations
+# are release before sampling i_blocks
+sync
+
 iblocks=`stat -c '%b' $junk_file`
 
 _test_cycle_mount
-- 
2.45.2

