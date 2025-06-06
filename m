Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6A2C3242
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206152; cv=none; b=P/DI3MrEGMba3R4mM+XftO9wTEZWSaK/fabLSyCwXAjBSbzSJC3vlsCZBomMDpqtXuobCdGuQGfb/pkzdHbBNC9T+ls4qMfzSG0+OCKQq/4uY0hBk7/R0uEgthRI0SAeuWj+5KYv2aKTWQN9pHfpbwnUYhelgYrcZmWjiv3NKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206152; c=relaxed/simple;
	bh=Q7xgMpqukGASjGryZBJf2hBYoNowJjWxB2h5DoPpIaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OcebV/c+4lHWgqni7X2+xTIlNgB45fs8KoFka+veBZ+G2+uDPZRvaMWoKkxcw9bKVL3ahIq8LcHjqtmTaFY+dNEiawNEt59cbIi6vxaiBq0FsFuQozTxp5GlqI+8hf8eCY5XQkR0LVYfZroTZ57xuamN3qrP7jfOEIALu4txs2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=yA3HZNL5; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="yA3HZNL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1749206151; x=1780742151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5PRIluNYilenGNJQPDM7aqRiJKdAPBm/Hh+aUYvZLJI=;
  b=yA3HZNL5+tU/r6IignxsvVafHY+2iJIDF4syxKesPoDIkIlONyfP/Vub
   G8dP3HXOVpyUBzncRj6yS+QXdIyVRQxQ0PvJh4kqQQxI/YbpA2kKKm15X
   YGqmmRHg4CrXv/2UgyspbChzYI3d+QGRJ6l3PEdQXx3GDz2Ww4WeN6S7k
   D78Bc/h1iw7rUBJzdTN+3kW21IPYoafcM6X/MGMBH5dHkj+JK0RrBjboW
   OHAYBZ91reDWjpALWPuLl1EpePX75ME29Cz3JKBnDQfkz/jzXv9R98zLn
   KbucZMAbqgtPELkp/oioptr53rAKdK8WFHAZUJi1HSOMtbapV4m1ZzthR
   Q==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 19:35:48 +0900
X-IronPort-AV: E=Sophos;i="6.16,214,1744038000"; 
   d="scan'208";a="569460000"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 06 Jun 2025 19:35:48 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1] generic/689: add _require_acls
Date: Fri,  6 Jun 2025 18:35:17 +0800
Message-ID: <20250606103516.3349389-2-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before testing for ACLs, check whether the file system supports it
with _require_acls.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
---
 tests/generic/689 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/689 b/tests/generic/689
index 36c74cd7..739d10b3 100755
--- a/tests/generic/689
+++ b/tests/generic/689
@@ -15,10 +15,12 @@ _begin_fstest auto quick perms idmapped
 
 # Import common functions.
 . ./common/filter
+. ./common/attr
 
 
 _require_test
 _require_idmapped_mounts
+_require_acls
 _require_user fsgqa
 _require_group fsgqa
 
-- 
2.25.1

