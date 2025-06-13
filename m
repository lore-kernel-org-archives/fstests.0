Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772519B5B1
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822776; cv=none; b=jvJkmg3jHxk6NZ0/GHP9apqIq348r3SN2t6oqfvjBBglLO8sMwzm9G8vCculw1CpPTAayHupfijy/620ZaSz27fkhWW1qN/hgRbMwxfvenbDzZ7QO0WS8CNBi+0HxRoddC2e2IVUGZZa9lZylpHM5MbbLwLrsXc6XFZRSLP1xvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822776; c=relaxed/simple;
	bh=EgA7pC4mW7LppapN9syBis1xhUDdtxAy7K0RHuIsEZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mk5/4y6w+LDGGgzeRl+PJZlOty8nvJmFo2DXmeqG/Nkpt6dq3NQGAYnjTBE8q2JUH3h/MU23U1zuh3VdVkb2TafeK/Jzbas/jXPvQ9wn04etGHRgSelAvrfdpfwOd+1J9POx4ryTy2HlPC2QaNmkqo37EUhyyqB2138SoMDGdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Vdd23/qH; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Vdd23/qH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1749822775; x=1781358775;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IvcyULr3LQfRRyxatKYy+cCSSlY67rdhey3eXBe93rg=;
  b=Vdd23/qHNOVW5K8cG/B4uDYN+YV/zv+G3/jcueJROZo4pqmYLqGxSMd8
   Zz8d0Uohxl3/OFFmFN2W6o8cpqYWyRMD3fhJF+NdH3GtHmYacLzjDwk8S
   mLBpxRb3Wk0BLqjLBKtCOLDam85D7DpursgLsvJRkQICgU0xDZOmp+S5G
   V9gJqebpmfPw606l3JFrskY0TNWVKTWOHEyutLvN4mZdp6q5mG1MputQq
   3sLQZMCHZkmd5PDWTACnhqFfo/SVGe3qDkjmJozjEoIwsgx+6vi0nbD9k
   EKG/fZIXsNGAr1tTevBKIVkhMLwegGMcFqlcf2xQysx735m+qzTqdNihE
   Q==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 22:52:48 +0900
X-IronPort-AV: E=Sophos;i="6.16,233,1744038000"; 
   d="scan'208";a="541594889"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 13 Jun 2025 22:52:47 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Friendy Su <friendy.su@sony.com>
Subject: [PATCH] generic/633: add _require_chown
Date: Fri, 13 Jun 2025 21:52:10 +0800
Message-ID: <20250613135209.645818-2-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For file systems that do not support chown, such as exfat,
running this test does not make sense and should be skipped.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
---
 tests/generic/633 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/633 b/tests/generic/633
index b683c427..d75d4dc8 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -13,6 +13,7 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
 . ./common/filter
 
 _require_test
+_require_chown
 
 echo "Silence is golden"
 
-- 
2.25.1

