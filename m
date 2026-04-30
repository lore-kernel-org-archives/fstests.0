Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5439F192
	for <fstests@vger.kernel.org>; Thu, 30 Apr 2026 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554864; cv=none; b=SR06L7D0nEOTijyVymf2HAEFT7rOtvRmEiXxi3xTPe8d4MAfvcTUaN4o3iIs8JPDt5w7hZAvaTHsH/pxdZabKkQCY7AQkTaa8rXRAUZj9WYqhSMwNPxO4mQVHHV0lS4Tt46YBoKHjMPIINF1JjFyIuMhjvkS/m8Y+FPLIJf5itw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554864; c=relaxed/simple;
	bh=NMhKm+DsLUbsCh8H/mL9vfUEH1k1hpnhBfiaSdmLBWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubv0qmLjBXeNXo1skPmRwjEqQMuVA8EgRJ8ikzcTxDNc/fkKn0tyBSGvZL8mSUeU1NV2ZE63GWWSEXrjKXefiU60PgVO1eFJqjcU6hTLlbeeh7AjS6+R7MoytOHIopZMNjXxTXvhva4CyP8GC6SGlOTCUZMmmYhqzuT0MefdqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 7F1F6180F244;
	Thu, 30 Apr 2026 15:14:16 +0200 (CEST)
Received: from trufa.intra.herbolt.com.com ([172.168.31.30])
	by mx0.herbolt.com with ESMTPSA
	id HBgTK4ZV82m0DRoAKEJqOA:T3
	(envelope-from <lukas@herbolt.com>); Thu, 30 Apr 2026 15:14:16 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: zlang@kernel.org,
	djwong@kernel.org
Cc: fstests@vger.kernel.org,
	Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH 2/4] common/xfs: helper function to check if -l/-d/-r concurrecy flags.
Date: Thu, 30 Apr 2026 15:13:18 +0200
Message-ID: <20260430131317.693845-6-lukas@herbolt.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430131317.693845-2-lukas@herbolt.com>
References: <20260430131317.693845-2-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if the requested flag is supported by the mkfs.xfs on scratch
device.

Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
---
 common/xfs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/xfs b/common/xfs
index f7a6d2f2f03a..12cf6c273c53 100644
--- a/common/xfs
+++ b/common/xfs
@@ -2399,3 +2399,9 @@ _require_xfs_healer()
 	_xfs_healer --supported "$@" &>/dev/null || \
 		_notrun "health monitoring not supported on this kernel"
 }
+
+# Check if -l/-d/-r concurrency is supported.
+_scratch_mkfs_supports_concurrency()
+{
+        _scratch_mkfs_xfs_supported $1 concurrency=0
+}
-- 
2.53.0

