Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951863B14D8
	for <fstests@vger.kernel.org>; Wed, 17 Jun 2026 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676318; cv=none; b=h1UWammODlARBnPiHryoKTkHaFW1JQiEhofHXDiYf8wzOLylp0UIBz9quwzXz7shzlpNqXzIf26by7okOUjK7jYHqnrAJaVVj/ayu1SonauJXJ0E6CBWFaYO3go2SC/agLySWfeQEg/e1skeCvlIPB4VuLgkZaH4k/BNPYBW93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676318; c=relaxed/simple;
	bh=It7VEIg/Jt8Wsu1OHf/5FiUyhRCleJU5GyIUEe9xMmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxVlf1FrvSYU6v5itvgsl6SKecdCM/bEte/thgxMQgbYk9O3odCd2/atI+mnAK63wFlKbp/jNW8f8rcDVOYfsWLn5/MPgefdvLyWBN6r34MqQogPWLyTmbxXP87bHLyOLCmyveOL7qlrDrMn3AlNUgfnwH85drVvO6qNmuXdLbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4g6pJfoV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4g6pJfoV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0Fj2zwTlXqQRv8sje+dq3pNi4TYx6SafRIXr7ZWIvm8=; b=4g6pJfoVQYg17o9djx5D7sejvA
	wh/Utm/sLeDIhKQhMvE7dH/6LDTS2+wcG/lH4Yna93Rz0GTM0Bo1FoajFklNMkCQMEHKKkUM6MxTr
	hCkQuYS6OJbK9CdUgqYDkJfjaGltakMS1rJDiJ2bqtDTOkiaDL0uW1tPRflaEteAwC5sfJarO/6ZV
	njegIW0tLEsO6+rOWXnJRgVnGsj1wqz1itap3yz1aqYv6zYKRW2O+di9NJERmlSQoR5uIEgTm1Weq
	JHZzo9nhLDI1SSg+mBQCpG4yYfFo0YhFc2Zp1JakwhAXcQEM+j0vDVpdUHAIk3SyIQRYlYuhXCxmk
	TwGa01HQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZjOU-0000000GgQb-3jIj;
	Wed, 17 Jun 2026 06:04:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH v2] generic/366: check minimum dio size correctly
Date: Wed, 17 Jun 2026 08:04:17 +0200
Message-ID: <20260617060456.3843384-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

min_dio_alignment requires the file system to be checked to be mounted,
so move the call into the main loop.  Drop the pointless blocksize
argument to _require_odirect, which is only tested on the test device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - only calculate the block size once, based on a code snipplet from
   Zorro Lang

 tests/generic/366 | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tests/generic/366 b/tests/generic/366
index 271a01bc2eac..cb183c1bfe21 100755
--- a/tests/generic/366
+++ b/tests/generic/366
@@ -20,7 +20,7 @@ _begin_fstest auto quick rw
 . ./common/filter
 
 _require_scratch
-_require_odirect 512	# see fio job1 config below
+_require_odirect
 _require_aio
 
 _fixed_by_fs_commit btrfs xxxxxxxxxxxx \
@@ -30,7 +30,7 @@ iterations=$((32 * LOAD_FACTOR))
 
 fio_config=$tmp.fio
 fio_out=$tmp.fio.out
-blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
+
 cat >$fio_config <<EOF
 [global]
 bs=8k
@@ -57,9 +57,19 @@ filename=file1
 EOF
 _require_fio $fio_config
 
+blksz=""
+
 for (( i = 0; i < $iterations; i++)); do
 	_scratch_mkfs >>$seqres.full 2>&1
 	_scratch_mount
+
+	if [ -z "$blksz" ]; then
+		blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
+		if [[ $blksz -gt 512 ]]; then
+			_notrun "512 byte dio alignment required"
+		fi
+	fi
+
 	# There's a known EIO failure to report collisions between directio and buffered
 	# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
 	# at here.
-- 
2.53.0

