Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16EE274FFD
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423743; cv=none; b=R4CWS2hPhLgyYszCjm5wrDICs4cRw50b0DAcg559GwlkzFviXpRap/EGFx4ooYpD26OTUzeqXyM3lqi1UG6ah3c1XWEa0vES90kf4arQeH6ouBcG++4MOat5Omw7JrWkWe00VlSMHDwTIIJMptCBdXfnrWA1IcRUbypAJOSRG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423743; c=relaxed/simple;
	bh=/ZCl787T4AeuV/uCml3vCgv0Trdjfte2Uhc6Sz2nmxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Suu1oOje3X6bpX5fflxYsaiO6q1auheaRpRrtXaJxw0pSgCavZYUevgfNQjEsY+khuaPwcV3liwy2loHZqtQXBmLKo4txd5X0GQKKNI4BRUyxMotO8fMU69OnO7E1/Fw+/VCjF41ayUESRLTa8zevy08dWOa49ERsK0YGAeUK24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=S7E9a/VJ; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="S7E9a/VJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748423742; x=1779959742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KFT5BvTdgfx8QNSd5WLV72+5wWYYsmX9oSR+7sBabyQ=;
  b=S7E9a/VJxqZZ3tj3n7SzjL/SDQX4Kd4iLXt/U8XV1P2/62w9obQG+sWd
   i+9TzSIjLv/TVTyS1fO0cEPkdWj8Tf5mh7e3df9FBmcm9I7AGwxdCS6a8
   WL9RlUNSWYSunARLMXt2+cUxXVjnw4jS6VNHrQ/swYDGMplv2iv8TBUlB
   9e4xLeTo5SjYk4FD9TQJ8iQmNKakJtHoPy+TWO2G0/bi61xV5D7QD1ucV
   huQy5T+bgNCS8haySDyOLPNVJRjygZ0e+fwfjsZLLG7tzUy84RDWd+p5U
   kXr10NJn7aarUI0XKCEa4VcTuWNKxq08WMgyRN1TmimXkggSJZb1JhFX0
   w==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:15:32 +0900
X-IronPort-AV: E=Sophos;i="6.15,320,1739804400"; 
   d="scan'208";a="534970975"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 28 May 2025 18:15:32 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	friendy.su@sony.com
Subject: [PATCH v1 1/7] generic/696: add _require_chmod
Date: Wed, 28 May 2025 17:15:24 +0800
Message-ID: <20250528091530.1218188-2-Yuezhang.Mo@sony.com>
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

This test uses chmod to set the S_ISGID bit, which requires chmod
support, so add _require_chmod to check for chmod support.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
---
 tests/generic/696 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/696 b/tests/generic/696
index d2e86c96..8731cad2 100755
--- a/tests/generic/696
+++ b/tests/generic/696
@@ -20,6 +20,7 @@ _begin_fstest auto quick cap idmapped mount perms rw unlink
 _require_idmapped_mounts
 _require_test
 _require_scratch
+_require_chmod
 _fixed_by_kernel_commit ac6800e279a2 \
 	"fs: Add missing umask strip in vfs_tmpfile" \
 1639a49ccdce "fs: move S_ISGID stripping into the vfs_*() helpers"
-- 
2.25.1

