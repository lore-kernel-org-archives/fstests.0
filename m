Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC484457A9
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386372; cv=none; b=GF8G7Ez7iNc8hEaetbkS58E0jQ5dgquyJ3sVql281yIPRpGD1Wm4+FG89FnEyVSp9EM628Itit3yg/iIm+9vY5i33IrW+M+GcJ1RWngwYKycGKKAkWQuT71ATa6Hk2UvqdRNS07DtfeMMjZtJocvWDrgf10m/8ivQKddzXd86LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386372; c=relaxed/simple;
	bh=pjxTEdPtCcxt1F81Mwv6qTPwO/NyDF5UGEOqwxtTIF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUlkiFFNlnc7Xf/A0ox/XvhbYZwXVGAUvoEkFRbiO3U5J7LhKq5xrcFkgQwa41yhPngHmAQS3EWKthgLAYuMcLu2H3SotVZac7/PYfrZTgwsVX6gddrKE5Budw+u2RGi/orpbtX9a5SDmAwo/gV1egT7Pr0XbC3SA5iBA/BEKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e3gfnAPq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e3gfnAPq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tBqKh86gmQ5/eksO0VKHg5bGz54x4B8ZxDYueWRMPqI=; b=e3gfnAPqGcAjIaCHcZwiwuKXgh
	VlOhe/m9/w0P/JrHDDKh/kTIoiVjJCQY6/ibOppBRYI5Zkk/b7zNYg966TS1GtCIcz5ZsqpdmLMWv
	2YB28kA0D2T+ESZqtMohReHr61R5stFh88CH8pa4NiV109ProbwvxszCyKF3nDc00q/moZXXIGWwA
	pv6C1Odq75Aatu7p3OzfaBPUGR0SGxoZhsOQhZjvcVFM4kCCUj6QehXbYUxCO3qLxUcA0WEcb7TNH
	ykjdzCQMQ42ux7QVUHpsFNo/BG2kVVDJkD12i2J5pgm1s8KnUSe1VrwIltMQvnytep43D6rBxuQk5
	ETdDt28g==;
Received: from [195.12.231.4] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x658U-00000003N16-24W1;
	Mon, 14 Sep 2026 11:46:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 5/5] generic/760: enable sub-block reads
Date: Mon, 14 Sep 2026 13:45:47 +0200
Message-ID: <20260914114550.2451308-6-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914114550.2451308-1-hch@lst.de>
References: <20260914114550.2451308-1-hch@lst.de>
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
Reviewed-by: Zorro Lang <zlang@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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

