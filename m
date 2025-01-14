Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B70240234
	for <fstests@vger.kernel.org>; Tue, 14 Jan 2025 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826522; cv=none; b=U0PHEOsMy5/ekDKXvPXfvX2BIJ09OdTDIej9F3RIocqTde4lNm2QWSRQA+Y1jBtNmqO68c+2MP/8skYOheM6hfbTNf//Yhw4QqPMjXqEDMqSNfTV9AQm0JiM/b5njF3DnY7XlrKOm1onduKdiKXy1erSVsOsoLIagSAj90GicRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826522; c=relaxed/simple;
	bh=GlxOjdMCmBft1ICBlrdIvne8Hm9TyFVvQRdBMcc1iL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A2FniLEZ7u8T1ZqgsELQ6kP/iKAOTyMGbRJ4j+RFw/jvUAXgW3Gg5zBO+5pXx40d06lR4XHk2zlbxh/Xotbu6Ek6/vrLcTEoiuJsrhj/4fSRfBujPOoeq3j+Bb3BM6ZdPmzSPKYOBkx8Gp79t1c9FYjvFSwE0izxeQ1X7bxPkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WotVnpYA; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WotVnpYA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736826520; x=1768362520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GlxOjdMCmBft1ICBlrdIvne8Hm9TyFVvQRdBMcc1iL0=;
  b=WotVnpYA57GU1hm0fx6vMX4Rr82/hlGXIC9fYDaavXw0Ptp10ARxPeYG
   c4S/QyP/DxebGhq3q4IuMSRltmXi3DOluBWzqTLYD0enjIZhrRDc6ZPNh
   nNC8exIpxjiz3jKGyAd8TRFQimjJ4OEniEwB56r+4VlmmLz8tLVav1U+5
   9hvhhKyJv0IKYQAEp3DO+rWmjdfAnfUyH/TJ9iNhLi+4glkQTZn1OmdLm
   p/nfTezllt7JW3bvSvZNuyuP1g8oGBZFM3ZmLQi9/scFovidwXfzemA3P
   4HM/z62spmyiA+XsfefiBCqDvRRLxsSoMW6cCFFbIjWlm8cMk0yEWyQfS
   g==;
X-CSE-ConnectionGUID: n49BiVMTTIWwQNUEdhDikg==
X-CSE-MsgGUID: dymwb4lWRYeP/mOy6Y9Skg==
X-IronPort-AV: E=Sophos;i="6.12,313,1728921600"; 
   d="scan'208";a="35647644"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2025 11:48:32 +0800
IronPort-SDR: 6785d105_9iBDm/IBb0OwSWXWnlJAemXvy+ZoeFk2x6ACfgWOZVlm0gl
 j9GjYustaITJ7/GIJU4vdneQjioJapUcUUSkQWQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2025 18:50:45 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Jan 2025 19:48:32 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: fstests@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] fsx: fix compile error for preadv2()
Date: Tue, 14 Jan 2025 12:48:31 +0900
Message-ID: <20250114034831.1128945-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d6b9d8eff076 ("fsx: add support for RWF_DONTCACHE") introduced
preadv2() calls in ltp/fsx.c. However, sys/uio.h is not included to the
source file, which causes compile errors with the gcc option
-Werror-implicit-function-declaration:

fsx.c: In function 'test_dontcache_io':
fsx.c:1956:15: error: implicit declaration of function 'preadv2'; did you mean 'pread64'? [-Wimplicit-function-declaration]
 1956 |         ret = preadv2(fd, &iov, 1, 0, RWF_DONTCACHE);
      |               ^~~~~~~
      |               pread64
fsx.c: In function 'fsx_rw':
fsx.c:2836:31: error: implicit declaration of function 'pwritev2'; did you mean 'pwrite64'? [-Wimplicit-function-declaration]
 2836 |                         ret = pwritev2(fd, &iov, 1, offset, flags);
      |                               ^~~~~~~~
      |                               pwrite64

To fix it, add the include directive.

Fixes: d6b9d8eff076 ("fsx: add support for RWF_DONTCACHE")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 ltp/fsx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 9efd2f5c..3e89d570 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -20,6 +20,7 @@
 #include <strings.h>
 #include <sys/file.h>
 #include <sys/mman.h>
+#include <sys/uio.h>
 #include <stdbool.h>
 #ifdef HAVE_ERR_H
 #include <err.h>
-- 
2.47.0

