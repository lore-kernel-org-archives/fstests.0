Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404F383A5
	for <fstests@vger.kernel.org>; Tue, 28 Jan 2025 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048574; cv=none; b=uUAvlxDeN0MOB3e4NBUTIEKdN4Imoi8dWUUMJWqIzbL5i/ZC8X3UdINTUYDosUa3Z/zni9kPWrv/FOQZR7VyphULiBA9o4z7DOHVp34oHyx9eEoQw6/x1r+c2VHeXqHS+VK/VfDTHhkgT9p7pUvLjxnP2fH8h1OT4RoB+BC1n1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048574; c=relaxed/simple;
	bh=LBSDtJQTQ52TdMm+57TWbc9YqKHk1JBrT9A4yVWr/BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MyGrfU5nnI+kBnf3HtH/vdC8hRgCNMTMSanKElRQ0TDVGc6Ui3Jsk4GmcaHDkCW6lEn9ihT5va5YUuYVI/43z9mSMxII+IOon24gGcMjrQ3Tp51SWCcXp3oD2exAIjxGd9iQbqPpHpGnbiwxl/KRO67rrQQNONPHgHNosD8VYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Txerw6HC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Txerw6HC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=aBQBPEsmxBmn0ax0j5FKyBmF7p5ZMkjUc25Kdk1HRSY=; b=Txerw6HCWsa+rrQ4TM1JoPs1nu
	1R4RBaTA3anWergqsQ+b5YELSqdRCukyxR+ctDWE12u/ZF9hyaNQtrDSs257hWkPKRDWC5yp8l4U2
	lYGYkQJm+sZhMf1RmJBvPd5fmiawAX98nvIj9o7zYvil+VeArIZEn2KxsJTfyZXvJI620ZJo9Cnwc
	6UPIsOqf5kK0yYVosZXcgqYyFjVZ0cksGB6EAsnM1Mq1wojucO2F6+mDHlwqXZOQPf7GSRlJ3bMdX
	FoGAXKIiYTRcKk9ZTP5KND7HDysXy5HEennTPpk2tNjM+0MsCVGei+CMqjA6Iv0L40rofmC1SNmXY
	m4N8DAiA==;
Received: from 2a02-8389-2341-5b80-d7c6-3fcb-a44b-90d7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d7c6:3fcb:a44b:90d7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcfpT-00000004Gex-3Syd;
	Tue, 28 Jan 2025 07:16:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] common: skip tests using LVM when the device is no known
Date: Tue, 28 Jan 2025 08:16:05 +0100
Message-ID: <20250128071609.676581-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

LVM has a lot of elaborate code to make the users life painful.  This
includes claiming the device type is unknown if it doesn't match it's
elaborately crafted internal list instead of just letting the user use
it.  Skip tests using LVM if this is the case to avoid arcane failures
due to missing lvm devices when using null_blk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/081 | 6 +++++-
 tests/generic/108 | 6 +++++-
 tests/generic/459 | 6 +++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tests/generic/081 b/tests/generic/081
index 37137d937b05..97928bf4a435 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -66,7 +66,11 @@ lvsize=$((size * 85 / 100))	 # ~256M
 # make sure there's enough disk space for 256M lv, test for 300M here in case
 # lvm uses some space for metadata
 _scratch_mkfs_sized $((size * 1024 * 1024)) >>$seqres.full 2>&1
-$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
+
+# lvm has a hardcoded list of valid devices and fails with
+# "device type is unknown" for those not in the list like null_blk
+$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1 || \
+	_notrun "LVM is too stupid for this device"
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
 yes | $LVM_PROG lvcreate -L ${lvsize}M -n $lvname $vgname >>$seqres.full 2>&1
diff --git a/tests/generic/108 b/tests/generic/108
index f630450ec66d..4f86ec946511 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -51,7 +51,11 @@ test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
 echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
 
 # create striped volume with 4MB stripe size
-$LVM_PROG pvcreate -f $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
+#
+# lvm has a hardcoded list of valid devices and fails with
+# "device type is unknown" for those not in the list like null_blk
+$LVM_PROG pvcreate -f $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1 || \
+	_notrun "LVM is too stupid for this device"
 $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
diff --git a/tests/generic/459 b/tests/generic/459
index 40c87e20f8b9..3f5f0f2b7dc1 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -84,7 +84,11 @@ is_shutdown_or_ro()
 _scratch_mkfs_sized $((350 * 1024 * 1024)) >>$seqres.full 2>&1
 
 # Create a 200MB dm-thin POOL
-$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
+#
+# lvm has a hardcoded list of valid devices and fails with
+# "device type is unknown" for those not in the list like null_blk
+$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1 || \
+	_notrun "LVM is too stupid for this device"
 $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
 
 $LVM_PROG lvcreate  --thinpool $poolname  --errorwhenfull y \
-- 
2.45.2

