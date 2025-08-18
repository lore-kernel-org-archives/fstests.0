Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF65279912
	for <fstests@vger.kernel.org>; Mon, 18 Aug 2025 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502061; cv=none; b=vBt6JSCQa3xvUHXlaQ9F+w62qrm+a9CtEbojMRY3MiC8yzDCclmGV9U7AcA0nquNbHBwbyJ/NZtGIBp+fR+rIm4juwE9VPm8843nJWO7fY/FoB+zKPdBYT14riiCYSZL/aW+vcqjiX+1b2fNqBANzdGak4UEqkcU2sgCjCLkvmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502061; c=relaxed/simple;
	bh=pQWrx1JRFhKjqhzywoVDyLcVGqheDRjESzvZNP/LTPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWae2BrgYK/sqIC2HJ4Ko9NpsltOqsGUGcKZymsjZv9uEiPcXB9v5/vkoVNJ1IUjE9X1nEDDV/6tfQMrHwWLNo8hWGauheFEfgtkTXfj/erpz7SovXdCIA41B54RS6oMhhl5YP+baWWCkoWImJSddtIXpwZDJjXXJdXpQyPUolo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fb24h24u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fb24h24u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yVyuZ0VYB/l3oOzEvU0hX9v6NhXDRtUI8iBqm3CHLqg=; b=Fb24h24uLFN3GvqBQ9IYXnhCY2
	7x7SUyH699d8tbR05s71cGN4WnjkXqHM8g9l9L4/nmf6un93XI4bxGlKS1hwcSJ28J0SxEyen8SPF
	VAabiz0AP+10LHlEl+IXoMO+wa9c9Ari3yE75i1P/acghfgjVIJ6XBqfOQ90enxN0Ad/pyad7cn+0
	ksCH0nGP8Y8FxD7uH5VHZiJ4NRMnGdbtQIANPVl894UFHuMiHK59imVChvayhqI+1IMgTpLtYQCvM
	nYBTc3r5o7v6jZIdEdZLVgzscgznEAEyMLlb+dtREC7cXEvp/czcYoHKvYVG/PojeeJ76Hx3kPnG5
	3swAuTfA==;
Received: from 85-127-105-248.dsl.dynamic.surfer.at ([85.127.105.248] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unuHL-00000006mke-1Ldv;
	Mon, 18 Aug 2025 07:27:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: [PATCH 3/3] generic/450: don't hang when running on devices with protection information
Date: Mon, 18 Aug 2025 09:27:18 +0200
Message-ID: <20250818072724.1559133-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818072724.1559133-1-hch@lst.de>
References: <20250818072724.1559133-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The dm thinp target does not work on devices with protection information,
and the udevadm settle command simply hangs when lvcreate failed because
of that.  Avoid that by doing a strategic _notrun when lvcreate fails.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/459 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/459 b/tests/generic/459
index 3f5f0f2b7dc1..48520f9f4af0 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -93,12 +93,14 @@ $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
 
 $LVM_PROG lvcreate  --thinpool $poolname  --errorwhenfull y \
 		    --zero n -L $origpsize \
-		    --poolmetadatasize 4M $vgname >>$seqres.full 2>&1
+		    --poolmetadatasize 4M $vgname >>$seqres.full 2>&1 || \
+	_notrun "Can't create thin pool"
 
 # Create a overprovisioned 300MB dm-thin virt. device
 $LVM_PROG lvcreate  --virtualsize $virtsize \
 		    -T $vgname/$poolname \
-		    -n $lvname >>$seqres.full 2>&1
+		    -n $lvname >>$seqres.full 2>&1 || \
+	_notrun "Can't create thin volume"
 _udev_wait /dev/mapper/$vgname-$lvname
 _mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
 
-- 
2.47.2

