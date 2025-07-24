Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD522DA06
	for <fstests@vger.kernel.org>; Thu, 24 Jul 2025 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341923; cv=none; b=Z6zft2bgeAwOdwQsSJSLpHSe2MKbuFx6X1NvTu18TkNh/xi8lKkYU6Nr0L346sYjOsDdGK3DLOHf6oDekpRee4/jT5c6CebnPmM5ZFUfK3UtaGUUg/mZN2fGPQ6Tfm7oD5DdXVODnLAD+3OfODo9yuJG5uErh3jrQAbBY3WZ480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341923; c=relaxed/simple;
	bh=myvHVi2+uv1mHeMiAeouDOX+6kVJmYtVLhXddLnfZI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7jQLHQa61EGUsRN5e+5nXl6eO1O5HanIqLewG6YZMkZew4jF1PX1P6L04HxxwO1Ds9Pa+0X/dp14uTcrU1Nwt+0SdqQ4BqQs9AYZSZ2bM73wbbCN2lqU/x+7M3OHKS2SVcFwoPEsAsAz7gJYsya7sZ+7NaG1qA84pOXVW5IkNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gIGXMiw1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gIGXMiw1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SAKRVDUA4jnhky0Fl248C0ImBGdMxCWzyzgrlMlQifA=; b=gIGXMiw1mCksATWH4uIm8oVq1V
	bhKRgTBUig1bqkymvtG2iRnnAf5qApvQHQIa9vnyO0q0fIAy57EykkLji/1hs605TCP49Mh1KFPBO
	BR/MZvKQOTmV/9fkQ4dwR5UCmvCDJ9nkPYOywUpXQPTk+/pqIXhaNHkxKTd+IkX0WpLiCxi1RDrOv
	Y0tLPadRhZnneGEi7L9ke3euiUO9317WCPk8EIEWEEq+pLC7TD2RUicWwmwh41Vb3IO7MwN/PwfnV
	ihcp4kZ0ebH94j6W0TqpHGls9ZkoSCCx0XwlCzgL+dZe6qx5ygGEWPuVkyuEcyW98AZYOcYSM3OMv
	Bfx1Hmzw==;
Received: from [2001:4bb8:2a7:db10:26f5:37a8:33a9:27cb] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueqKM-00000006hDT-0P28;
	Thu, 24 Jul 2025 07:25:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: Yuezhang.Mo@sony.com,
	fstests@vger.kernel.org
Subject: [PATCH] Revert "generic/730: add _require_scratch_shutdown"
Date: Thu, 24 Jul 2025 09:25:14 +0200
Message-ID: <20250724072514.3313006-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This reverts commit 68c9ac2ad74ba31c02275fcbb11d1cf90f0435b1.

The test does not actually use the xfs_io shutdown functionality,
and it does not use the scatch device.  Adding this checks causes
it to fail for setups that do not use SCRATCH_DEV at all.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/730 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/730 b/tests/generic/730
index 6b5d319675f7..6251980e33e1 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -29,7 +29,6 @@ _require_scsi_debug
 size=$(_small_fs_size_mb 256)
 SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 $size`
 test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
-SCRATCH_DEV=$SCSI_DEBUG_DEV _require_scratch_shutdown
 echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
 
 run_check _mkfs_dev $SCSI_DEBUG_DEV
-- 
2.47.2

