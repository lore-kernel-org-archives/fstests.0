Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16FE275847
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423745; cv=none; b=qivwIdxBIg2ytT9Rob46o1up3LP4zAjY+TBD5mpYTkQzfBNzxUqNnUAs+X0o49+XRqaiSNezDT7jPmz0VQ+1lA9fmP7CBq8z65ANR9HQ8sCGX59NCQpSVKNxuaGTCj5aOkMWrXHyzBH8xBQNHf0fv+nXfIHC0bMXe1w5ScTfCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423745; c=relaxed/simple;
	bh=iNyautF6hl2DVI4Gbn8An01T3tfmVDPoKALs76zlhxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Amc+KW9eyEcBluy3rVPffnAQpTYh9kNL8HCQBqhLSWEZdZALlPIib8eDD/hQWeqeF+kzKO6AZp8vlG8t38sL5OPB0Af6DB3nDrmbGjTxAsElgxR46i0HmUjHheeFXN199si+iuID+6kBhm5AYyUrG7o/41+govD9RF7FvzbLCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=B5xojEG+; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="B5xojEG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748423743; x=1779959743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6T5vSkkbNyxnHQcXen+uphD+IgdWwfHaeCfAK5eUBwg=;
  b=B5xojEG+v7jYlDUxcS3uVqwIzO6wS2XM5GT6oGSnnZzh0+V3StvwLtia
   g8GlVYJRCqgeoDBF9brKnal32HRUOBKVSc35XqGJDaRmxooqhJGDZ9Kdk
   rbAa/PFMU4ORvAQpLVDgzj2zE5KVXSP7cOo9TQp5gPqqILAt3/fAPVzGi
   w0m+Ph5j0U9cfZnmVJzkeek283u39NPKf6ROjTItjNX9qhYS6kYic4FWU
   KxV2c84UgD6vn5yUOl1RzZyHiPKHfkTqg7vMmia89BeMhfi2PUZ6Fgtbc
   fvInPQ7fTv8XoqtjLCgrCtaN6LA/3AZoNBJmAAoLp5UP2dPyf6UdqVLIG
   g==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:15:32 +0900
X-IronPort-AV: E=Sophos;i="6.15,320,1739804400"; 
   d="scan'208";a="534970976"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 28 May 2025 18:15:32 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	friendy.su@sony.com
Subject: [PATCH v1 2/7] generic/656: add _require_chown
Date: Wed, 28 May 2025 17:15:25 +0800
Message-ID: <20250528091530.1218188-3-Yuezhang.Mo@sony.com>
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

This test uses chown to set GID and UID, which requires chown
support, so add _require_chown to check for chown support.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
---
 tests/generic/656 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/656 b/tests/generic/656
index cd49c4f6..2ff1c517 100755
--- a/tests/generic/656
+++ b/tests/generic/656
@@ -17,6 +17,7 @@ _begin_fstest auto attr cap idmapped mount perms
 
 _require_idmapped_mounts
 _require_test
+_require_chown
 _require_user fsgqa
 _require_user fsgqa2
 _require_group fsgqa
-- 
2.25.1

