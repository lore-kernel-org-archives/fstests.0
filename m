Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4D2571BD
	for <fstests@vger.kernel.org>; Mon, 18 Aug 2025 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502059; cv=none; b=uvuo6Li93yoCKbPIUT1mH6dK1iEJ/E5FwzFcD0EWAgVw7jqDDRYshLYAFj2X5Vqhnzkgvh0qJEE9O/0l6raZy5iKE1GxYkYNZE/hfNHQB2yCXIB7ULIxbRqooju2/R3hywxiGCZjHmHOhb81xsMHkQ13fEAYRzDPxJtollj83C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502059; c=relaxed/simple;
	bh=mRzv0ENwxbauzLTsFs6nVPxVF50usN3p/7w8kpsnQoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh2ea6M6fP1PanLU+7wl5SD/PZVBkF3o8qUtPvRzQPz8+1L7UckdRbMMmb7aDwRZmuC/X50qBWt1hEF+8+x0PM9lAodG9RFtpqfvogT3Yq0uSZjqH++vdbpF7kzuSsk7jXThP+iWjh56uBfjdvq+H206tXET4QwVuJ/YmN91obY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qLoyFBLW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qLoyFBLW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=L0JnGL5fz3KwV9NdIgvXoQKuqCsx52yn96HAgfVaveI=; b=qLoyFBLWbZslfPJHLjgaDfu/UH
	6e+AzByKAh0Hhv2pa7jgiANvo5h7kYbZ/y7FHnnlR+/wChFoE1LkLCQzeZkrkCf1yhnLIuDT8VXZB
	jHx/5hV6ivjgrFz8swgy/ojFlxLAPcz0YyETIQENtcmo+revoTsLvtaaRtpuCEdaFlbYDh5G3hMia
	vTouRL35XtO6E884IGCDaKDd620fqVGsiRC970QhYKsX8dKZIy360uhKjBT2Y8sXG2y10+E3vhHwx
	kbqy9xDa3noGWbkRU4eaI12rNcvGpCI9qUHe+VdFGIOL7mcIjsFR10sFEMdU3jZmZfGQW/Fvk/zsr
	sRXNw/RA==;
Received: from 85-127-105-248.dsl.dynamic.surfer.at ([85.127.105.248] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unuHH-00000006mkV-2DK9;
	Mon, 18 Aug 2025 07:27:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: [PATCH 2/3] generic/081: don't hang when running on devices with protection information
Date: Mon, 18 Aug 2025 09:27:17 +0200
Message-ID: <20250818072724.1559133-3-hch@lst.de>
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

The dm snapshot target does not work on devices with protection
information, and the udevadm settle command simply hangs when lvcreate
failed because of that.  Avoid that by doing a strategic _notrun when
lvcreate fails.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/081 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/081 b/tests/generic/081
index 97928bf4a435..00280e9cff3b 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -73,7 +73,8 @@ $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1 || \
 	_notrun "LVM is too stupid for this device"
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
-yes | $LVM_PROG lvcreate -L ${lvsize}M -n $lvname $vgname >>$seqres.full 2>&1
+yes | $LVM_PROG lvcreate -L ${lvsize}M -n $lvname $vgname >>$seqres.full 2>&1 \
+	|| _notrun "Can't set up LVM"
 _udev_wait /dev/mapper/$vgname-$lvname
 
 
-- 
2.47.2

