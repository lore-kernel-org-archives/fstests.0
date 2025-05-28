Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0CB2750FA
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423745; cv=none; b=P632N7wjuzLzc1zrJTJrXNaqJj9IgBMbT9CaXaQaf+YPICFJJCHLrz06GHJdZuwrINdTZLAuF4kSNOAGaqY8CVZx6eenjh5PJ7nUGpBckN9kh2RmeTcjHW5MNKdRb6PMJS3tad/p/C3oDCWPzjiISs+iw4OkfhREZXJ5yPVH9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423745; c=relaxed/simple;
	bh=453lQ8X4nNK1AtlDn5WBoGg+qGJXc0IGTIDTZ4GICeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeV73MRm3mF+dbkLladykkpjm2A5BWWEPJP1yUkJRhSUIDoU/iVgV4gQGB1pks3R7nC2Ohz4uDDTNC41I1YiHvF+CN2GzVAd8pV2SQHTs5p0gdIzrWS0t+AS23wvRUpn6xAyP8kB0eo3K+TH3tN5f24snmDrjaNgKwEM/S5pFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=tpsgW+Pg; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="tpsgW+Pg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748423744; x=1779959744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E9Qb3EzdBE12wEY3MDI9HVorXWQGfT5mAj33iO9Xmkk=;
  b=tpsgW+Pglp/Y8PFIShT/bBpHH6fUSKHvJZz7MbhmONrBfO7qK8JroQ++
   NKmT1TZkhZLeVjdj2j4jfI4Rb9n+Nykq/rCMGAvwj19shp/nK7Yf11/Ck
   SjHErpnIg7L3Sr8aQ7vv75tkCTW/S54PAOoeABMn+6+fVk4Ji7IGtMjuU
   WYRu0LAZYcYGAWwJe7mVnViou89UMV0r87AGpXyYnqZUCDPV528SH9YId
   xcs/hT5BvqqasSndBdaGJuBs+zJaZyhEWXB6bw9GRGszbn9GjQV2JkFMQ
   OpM3rjL2tvFEn0h+yTZKhugA323sDzeYhItZ301QL8jA380G8E6iQ4Eya
   w==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:15:32 +0900
X-IronPort-AV: E=Sophos;i="6.15,320,1739804400"; 
   d="scan'208";a="534970977"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 28 May 2025 18:15:32 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	friendy.su@sony.com
Subject: [PATCH v1 3/7] generic/754: add _require_symlinks
Date: Wed, 28 May 2025 17:15:26 +0800
Message-ID: <20250528091530.1218188-4-Yuezhang.Mo@sony.com>
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

This test tests whether xattrs can be added to a symbolic link,
which requires symlink support, so add _require_symlinks to check
for symlink support.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
---
 tests/generic/754 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/754 b/tests/generic/754
index 7afda609..c1016641 100755
--- a/tests/generic/754
+++ b/tests/generic/754
@@ -10,6 +10,7 @@
 #
 . ./common/preamble
 _begin_fstest auto
+_require_symlinks
 
 _require_scratch
 
-- 
2.25.1

