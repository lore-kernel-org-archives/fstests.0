Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F5027584C
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423748; cv=none; b=uobf9TdTOdN5su0ms7yYuUpPyT8srHRUrd5gFL6xyE1HbH0d+REgWsJsLdu9CIzztRUbgy/FjML8pgUfGOp+fai5y9sXcmFBxrAo9e8ahdFjoBi6XMyKqFDQb7IawxGyyoDLLFJmx2QvEgE/33cx8a5vy+mPb3jZpQ678qbCw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423748; c=relaxed/simple;
	bh=yuFagBmuGu+9L7V2267QyD3tv5b/YO6nAu6pL74mcjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9dNd8cHXnma+Vu5A9IZV44N4xUY36EWVyxTIjNn2PEwyBToquBFWI86YEbApsebBmxKa2Z9Y2LO/saiTqyLW21O9YYU322bCPnAGCTu6Sd7Y0g5z3a6b5GIt9jVO/I2bUYcOBAzeAxE3GyAe7ayKIZ+35OvidL62v21kRp4CI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=OwThcXrv; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="OwThcXrv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748423746; x=1779959746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8I85qcPMSWV/eHJO5qWfVFBZ4bB5b1BCTt7wcrPYLnI=;
  b=OwThcXrvr19RGbBCQ9Q4oTpPmhJ7HCrN7k5o0WaVNbAptoAad3uI1Gs7
   uvCSIVN4Aj/zBNdOtE6q5jqZtaJnIR/H6AC+irOhVd1/plPQJUHLG1EGM
   y2HxViWx7ib+3XRlvM1a5crBdq9jzNmdSdW+n52rwJJc296VkNUAw/AYr
   kMFdjqFTBZQ+/qIrrT25+Uh59Gy+FFLN38U03pkCi5HPTCIhBE/Yd/k93
   kOnckZfa6luORWzp5a246szlpIb+IPWErGrLEVlD0Raejum2vSJUdBedY
   uq4xbK11MFFscJObRWeZlx+A5pev2Ofv2mHxBPw7ararVcq7L7Oyqqyy/
   A==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:15:33 +0900
X-IronPort-AV: E=Sophos;i="6.15,320,1739804400"; 
   d="scan'208";a="534970979"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 28 May 2025 18:15:33 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	friendy.su@sony.com
Subject: [PATCH v1 5/7] generic/730: add _require_scratch_shutdown
Date: Wed, 28 May 2025 17:15:28 +0800
Message-ID: <20250528091530.1218188-6-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
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
index 6251980e..1dce547f 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -25,6 +25,7 @@ _cleanup()
 _require_test
 _require_block_device $TEST_DEV
 _require_scsi_debug
+_require_scratch_shutdown
 
 size=$(_small_fs_size_mb 256)
 SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 $size`
-- 
2.25.1

