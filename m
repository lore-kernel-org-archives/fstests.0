Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F015748F
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749179147; cv=none; b=g0kGynUjl+6K0IcRTWdJbE61jzq3Y7a7agCm71IrC1iRrB2VV2IesDylIfAR9wlrPHZlao2gHT13zUuEG9wch+WAARi7u+MethEMoIi9M5cA7SK4SSPgFNVYtzahsddDS7mx4NLuKKcV5/CDxq/v4gnHj/DbBcc3SI/z9TUrypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749179147; c=relaxed/simple;
	bh=OhsVRXM1hc0p/+Vo5imDwBnTRNtuMtv+b/pbPtmV//Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDUsAtfUdh7MzfMqPejQ9V3k8oX0/iNu3jOs+7M08v7qDDJgxpui9hpN6Lz61jjfInIymhHsSTX7KlMZ7bNXpBPr8djDjKBvqb8pyzLB/7EYURBHl2Lj2Bzbyca2DtUqp9PNrYyiUd9ifUe7lCOvjTWI71uTVZRqjC1nTOjcc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=fum5W0go; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="fum5W0go"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1749179145; x=1780715145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rl7aZAvaaeFfCeWCuLoOasc0hanT630ruJEyLE0f5sQ=;
  b=fum5W0goIxL5IrSI8rQSrf7+qn79PYbcrzYs98X5WB6Mwx9sD5lWzv9z
   lZSo9kFPyl0kSMMdflCa3oioOZ1uNZsFQY/nY5qzCUr2WNNQrwvHuMNT4
   qoLKoTDXNpqOnT88DgE62XFg70/hvgFrxX359wJUE3w29InjNNcCaUFoK
   da0vcgjD/tTbUk0uU8n/dgippQPFxtUheLshPgZI2txKpUCKvjqzh6NpD
   7h8aOUQT+2EEwCN3xp4VaVqCPHO7yb8umBrOU39I9UqlOYhQLrTw2ORBl
   T/zozPB3lChAH60udwcsPOawvuPELerIZ/qoy6AORQzIIhN8Omv2vWuND
   Q==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 11:55:36 +0900
X-IronPort-AV: E=Sophos;i="6.16,213,1744038000"; 
   d="scan'208";a="569310628"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 06 Jun 2025 11:55:35 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@redhat.com
Cc: Friendy.Su@sony.com,
	fstests@vger.kernel.org,
	zlang@kernel.org,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Friendy Su <friendy.su@sony.com>
Subject: [PATCH v2 5/7] generic/730: add _require_scratch_shutdown
Date: Fri,  6 Jun 2025 10:54:54 +0800
Message-ID: <20250606025454.3218911-1-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <PUZPR04MB6316F2B7B8CCE7386E6E7BE9816EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316F2B7B8CCE7386E6E7BE9816EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before testing for shutdown, check whether the file system
supports it with _require_scratch_shutdown.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
---
 tests/generic/730 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/730 b/tests/generic/730
index 6251980e..6b5d3196 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -29,6 +29,7 @@ _require_scsi_debug
 size=$(_small_fs_size_mb 256)
 SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 $size`
 test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
+SCRATCH_DEV=$SCSI_DEBUG_DEV _require_scratch_shutdown
 echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
 
 run_check _mkfs_dev $SCSI_DEBUG_DEV
-- 
2.25.1

