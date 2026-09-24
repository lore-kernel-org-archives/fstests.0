Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3038B7CD
	for <fstests@vger.kernel.org>; Thu, 24 Sep 2026 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230885; cv=none; b=sW5wyWwG+zrcuiCXiPU0MyeHrgEX5MEkoV+ttmeLeX4O0KNgTEQ9na6P+h+kUvLjFXqe6PkhF9WHIwXo6dY6tFuDVvRK448X7IHLjv+R8xCEfkMnGF5dM4vGNUJ0Mi8FGydpnPUI+lEG6c7wwmUVPdUQjt+2p/xs13JdsFq1LMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230885; c=relaxed/simple;
	bh=k046fZ8rAMK00DIy+O7aPmFPUM9pW3eF6YtbML+WLaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2s04TyeovnzWibAKOypDrprELPKh1vSKsVpg7qvRBg24WXr2GeGOz7m/ry680kPflXfW2Z6f1Iyr4DPygOL9vexTBI9PuX90nu9e12mSNPmVAJGxyb88cvvAwR+MxcxDpfcnhUZWGFalDW8qBHij9XKmxzu8/zIHvTbS74DIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fJOb9n94; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fJOb9n94"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DUB3CYaSRX/QNftDEm/XxJ5sVTyPXpjODx8P2kF/YbQ=; b=fJOb9n94staWxgQ8ITcr1g2RQh
	cfANseX3gvizT0uwef8gTFk5bHoCfcxcGX0B4rj7RZrlrfhPIe5/ZRvgnQzHcucZbDVAiUytnwzC9
	gSi7/fDN9DNTsl54pW3/P1p+rkoJ1G0PwZPnlGlBsNOF0tAAkZIrhIf07UHaopVY53HQZvgBFvUNa
	F37MUsU4Fr0zdL2sqQz4qxNgH80zIMwZ+TgXT5gjzeSwTLvbRMHI29soQUuJhoR3EeSgUeen0YyQF
	o4WTPtpHCIFNuWeJegP5LoR3VELXBXjpLSD/XSuKC4vcmIMysf7D1olJO0mPwymPOas1ny0273zEd
	cBbdx4lA==;
Received: from 2a02-8389-2301-9f00-b711-947d-6c5b-1af5.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b711:947d:6c5b:1af5] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9cpf-0000000A8zk-1DDR;
	Thu, 24 Sep 2026 06:21:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: moritz.tanner@linbit.com,
	fstests@vger.kernel.org
Subject: [PATCH] generic/805: fix for external RT devices
Date: Thu, 24 Sep 2026 08:21:18 +0200
Message-ID: <20260924062118.2684441-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

use _mkfs_dev on the dm device instead of _scratch_mkfs_sized, otherwise
the file system could be created with an external RT device, and will
then fail to mount without it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/805 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/805 b/tests/generic/805
index ae498f5c6698..401829c4c6fc 100755
--- a/tests/generic/805
+++ b/tests/generic/805
@@ -31,7 +31,7 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-_require_scratch
+_require_scratch_nocheck
 _require_dm_target linear
 _require_freeze
 
@@ -39,13 +39,13 @@ echo "Silence is golden"
 
 size=$((256 * 1024 * 1024))
 size_in_sector=$((size / 512))
-_scratch_mkfs_sized $size >> $seqres.full 2>&1
 
 node=$seq-test
 lvdev=/dev/mapper/$node
 table="0 $size_in_sector linear $SCRATCH_DEV 0"
 _dmsetup_create $node --table "$table" || \
 	_fail "failed to create dm device"
+_mkfs_dev $lvdev >> $seqres.full 2>&1
 
 _mount $lvdev $SCRATCH_MNT || _fail "failed to mount dm device"
 
-- 
2.53.0

