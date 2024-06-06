Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB425779
	for <fstests@vger.kernel.org>; Thu,  6 Jun 2024 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653559; cv=none; b=s8BmGIqs9Mk0hgZWr/fDsUqlByeqY5XZl2zW3u4kxAO94K8IAqFPz3GpyAzMkeiyGS8oaIO1hRzoDd4ZS/mpDQ176Nz+x6PG5L0MbnufqP3KbE0h/xklWC7/E/r0IZbq1sxJ5+E/6R0lx+Vy0cISMYgfpmfCtmWDMZoWmkaqsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653559; c=relaxed/simple;
	bh=DRpGBIwnHguwTe2MY/ftCzZ6tXMycme7jXTj1SpeIQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J/BMnTAgj9tGejucMRQObEoW40jISgjtmA0aq5gEDofPjhAIcNJddbXzD+RC+mdW1OcDiLOyGLNbHjYT+M1l4zhnBoMBUCH3cC3CQ/DAG/7lwit0rphkveopuTTqd5Q8FEuk6r9hzxPF1otNXsv0381eBi6CSe0lC670Xmg0Cd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=C/CceX3I; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="C/CceX3I"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717653556; x=1749189556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DRpGBIwnHguwTe2MY/ftCzZ6tXMycme7jXTj1SpeIQ8=;
  b=C/CceX3IyyhZEcD8RB35lmmd/tbW6vCmisocjphWUwoQ25mDg2vP4SmW
   vKDc0Ve+f03DkBGKogHFNTJXNnAhxF30ThKbZ0P2SMK/Huhx7/m8tzN1T
   21asImvubPHyMvz3I+OZhBmcz03WjdwVf6otvWCjEsxLpjGn7PgUVm8S7
   1iiZVfiq6L9Q4rnfXNrYZ/uA1Em94ATcg0ZrU/f8ewMfL1ixm9y7zpvdi
   YtKib6R54OSSt8PjKtBj0Cs6+PbVgovxq4ArlEq06t3qwtt/q+rYf7C7t
   RvGI0DEoNLkepuNuTPcF0Fvx9UlRu6NoJ3AXJIkAQoarA/svfEwMlYtqG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="150140083"
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; 
   d="scan'208";a="150140083"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 14:59:07 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 36DF0D501A
	for <fstests@vger.kernel.org>; Thu,  6 Jun 2024 14:59:05 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 71742CFBC1
	for <fstests@vger.kernel.org>; Thu,  6 Jun 2024 14:59:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id F1437E2B2B
	for <fstests@vger.kernel.org>; Thu,  6 Jun 2024 14:59:03 +0900 (JST)
Received: from G08FNSTD200053.g08.fujitsu.local (unknown [10.167.226.137])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 674DF1A000A;
	Thu,  6 Jun 2024 13:59:03 +0800 (CST)
From: Ma Xinjian <maxj.fnst@fujitsu.com>
To: fstests@vger.kernel.org
Cc: Ma Xinjian <maxj.fnst@fujitsu.com>
Subject: [PATCH] generic/747: Redirect stderr of _scratch_mkfs_sized
Date: Thu,  6 Jun 2024 13:58:00 +0800
Message-Id: <20240606055759.2594-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.26.1.windows.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28434.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28434.005
X-TMASE-Result: 10-1.771800-10.000000
X-TMASE-MatchedRID: 88J8FubNcKUHfDG7EtfjbBqkhv3OdF4DBGvINcfHqhfk++hGM2nSe0Si
	2ut9sl80aX+uAFI0N8TOpNM1ipw4yy/7QU2czuUNA9lly13c/gFr2qJoNIuCjWe8w91Oa1epo8W
	MkQWv6iUoTQl7wNH8Pg1fA1QHegDv3QfwsVk0UbvqwGfCk7KUs5fxE7D/jU+ZCZPMCtiAm7kRlU
	ZQ5g6WFu7xw6v0bzPCJHuN6n4RpnP8hx1weNWK7Cr0LK1Cq4H1a5kifV53MX0/7PV9KIUU/yHJp
	2UYVccqxOB8J0pRLhyJxKSZiwBX6QtRTXOqKmFVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The mkfs tool may output some information into stderr, which will cause the
output check failed.

In _scratch_mkfs_sized, the return value of mkfs tool is checked. So the
error message can be redirect to stdout, just like what other cases do.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 tests/generic/747 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/747 b/tests/generic/747
index 50b7ae11..a0da1be5 100755
--- a/tests/generic/747
+++ b/tests/generic/747
@@ -99,7 +99,7 @@ seed=$RANDOM
 RANDOM=$seed
 echo "Running test with seed=$seed" >>$seqres.full
 
-_scratch_mkfs_sized $((8 * 1024 * 1024 * 1024)) >>$seqres.full
+_scratch_mkfs_sized $((8 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
 echo "Starting fillup using direct IO"
-- 
2.39.3

