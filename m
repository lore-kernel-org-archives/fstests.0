Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E21E5B75
	for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779083; cv=none; b=nZ3gyXlcsIYfZ1/KXD8qRizKdX+cJ8q4nqrclAwpW3pYI0aciIG5E/ZoFkKVzAJtpnn2izMoEZXbSb7tyGA/5XI3YQQm1cIfOO5m5Ggel5ZDh2gzykUJWEW9EG1+ieQhEP0dSUck8JYJXAqBM/KoCCKAQW+tQVL3/hdBX9pGNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779083; c=relaxed/simple;
	bh=6lKVJY1muXsbfGsez5S3WFaKdj3VGMg0rfRbktSHCLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HrCZarH0sL1ZRSpscnjubWKnPwkk9CBcPTSQfEx1tRaFxWgeYcI4g6ia/F5Ws75l9TbLGq18DQQyRIei6T7iiD7zBcroDuxUrBFkxrK6cuqs+YJYJbMBeEMvhxcgkZKiRJcn/LyuU9BF8LEd0KSOQydLCt9N4XIyRzK7P5QEGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q30ZQZHn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q30ZQZHn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pUvUzC5Xg1oM9y1RcWXtnuQVBWOZNviejZQddiofZQw=; b=q30ZQZHnhgXSQeHVJ9xQG56i6g
	g+xpvgDl3Oao8LRpAcAiO9Pu8BXtzjiOPAzK06VimWou5fFM43cKJV3KG2wXLNNUkUWHBGJ/uWscD
	iO8ukmCJUNPQGAIrSVHnlEYYo60HctbaBCASkxtHz8a3/PCS4EXyc1UxFSEA6uctXQZnZLnLTNzRm
	Pi+FNoMe2o2Ll6iP2ziNnLKVPDPWPl5WnPnF1wldcaIe8U86Kya+boh5Jt/xUW3kUuE5yCtB7Lody
	YAxtmO28qOROy0w12AxkVIvBvj2ZVh3X4mJ1KPmT0Glmt/YtjaBwzbK7pmfqW8k2jqplMXWJoIL9S
	15CaT0Hw==;
Received: from 213-147-164-187.nat.highway.webapn.at ([213.147.164.187] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4uk4-00000008C35-3wXx;
	Wed, 16 Apr 2025 04:51:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH 1/2] generic/231: use relative path to invoke fsx
Date: Wed, 16 Apr 2025 06:51:11 +0200
Message-ID: <20250416045112.617815-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This test uses su to run fsx as $qa_user.  Because the shell calling
fsx is run as $qa_user it might not be able to access the xfstests or
parent directory which might only be accessible to the user xfstests
is run as (e.g. root).  Switch back to calling fsx using a relative
path, partially reverting commit 1c67e8b191fe
("config: add FSX_PROG variable").

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/231 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/231 b/tests/generic/231
index b598a5d568bd..ce7e62ea1886 100755
--- a/tests/generic/231
+++ b/tests/generic/231
@@ -23,8 +23,10 @@ _fsx()
 	echo "=== FSX Standard Mode, Memory Mapping, $tasks Tasks ==="
 	for (( i = 1; i <= $tasks; i++ )); do
 		SEED=$RANDOM
-		echo "$FSX_PROG $FSX_ARGS -S $SEED $SCRATCH_MNT/fsx_file$i" >>$seqres.full
-		_su $qa_user -c "$FSX_PROG $FSX_ARGS -S $SEED \
+		# The absolute path $here might not be traversable (+x) for
+		# $qa_user, so supply a relative path to fsx here.
+		echo "ltp/fsx $FSX_ARGS -S $SEED $SCRATCH_MNT/fsx_file$i" >>$seqres.full
+		_su $qa_user -c "ltp/fsx $FSX_ARGS -S $SEED \
 			$FSX_AVOID $SCRATCH_MNT/fsx_file$i" >$tmp.output$i 2>&1 &
 	done
 
-- 
2.47.2

