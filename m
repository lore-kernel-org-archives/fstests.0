Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A925393E
	for <fstests@vger.kernel.org>; Thu, 14 May 2026 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758830; cv=none; b=ALvjhtJo4U5yyXsHTvdChIZrF7mkMmYZCiRNnPx2dIsQ4VYzdb5RmMMAHgtp4ua3Qc0e4W8xf0dfUcB2JHK+iYpPYhzYqTguXl6ZJj9TRCWoFRC2HPJ/QnkHjpN4DZ0+9+uGvykil6jAL6lO0DywezADu5NhPT8mMgLmx3X6ybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758830; c=relaxed/simple;
	bh=C83uSPYflsSfMT9vgnrBoK6x+aT9HEi6eQCWHhTP7XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kugVz4LjDIXMxw5kTO9olfgpox/+b7dPNJidXN5FnXl0BxxzdZ+4cXIol/oZm/yZuw0MZ8wzjk+Afs0+819lJKVYtIcrnMSZ2RJCaUn7O3CIdeGQAJUJrc4V1N6DgWoyLMLe31nAKocLUkWSoNSV5vrIuh9id3R7G09Gnhrg5oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 6A983180F2D5;
	Thu, 14 May 2026 13:40:25 +0200 (CEST)
Received: from trufa.intra.herbolt.com.com ([172.168.31.30])
	by mx0.herbolt.com with ESMTPSA
	id uaW8NIm0BWoNiioAKEJqOA:T3
	(envelope-from <lukas@herbolt.com>); Thu, 14 May 2026 13:40:25 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: zlang@kernel.org,
	djwong@kernel.org
Cc: fstests@vger.kernel.org,
	xfs-linux@kernel.org,
	Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH v2 2/4] common/xfs: helper function to check if -l/-d/-r concurrecy flags.
Date: Thu, 14 May 2026 13:39:11 +0200
Message-ID: <20260514113910.866888-6-lukas@herbolt.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514113910.866888-2-lukas@herbolt.com>
References: <20260514113910.866888-2-lukas@herbolt.com>
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
---
 changes v2:
	-l/-d were introduced at same release no need to check both
 common/xfs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/xfs b/common/xfs
index f7a6d2f2f03a..c48b043faf80 100644
--- a/common/xfs
+++ b/common/xfs
@@ -2399,3 +2399,12 @@ _require_xfs_healer()
 	_xfs_healer --supported "$@" &>/dev/null || \
 		_notrun "health monitoring not supported on this kernel"
 }
+
+# -l/-d concurrency came in same xfsprogs release v6.7
+ _scratch_mkfs_xfs_supports_concurrency()
+{
+    local arg="${1:-d}"
+
+    test "$arg" = "-l" && arg="-d"
+    _scratch_mkfs_xfs_supported "$arg" concurrency=0
+}
-- 
2.54.0

