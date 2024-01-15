Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36F137B
	for <fstests@vger.kernel.org>; Mon, 15 Jan 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="134485879"
X-IronPort-AV: E=Sophos;i="6.04,195,1695654000"; 
   d="scan'208";a="134485879"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 09:59:20 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5580ED7AE4
	for <fstests@vger.kernel.org>; Mon, 15 Jan 2024 09:59:18 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 86916BF3C5
	for <fstests@vger.kernel.org>; Mon, 15 Jan 2024 09:59:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1B46822CDF3
	for <fstests@vger.kernel.org>; Mon, 15 Jan 2024 09:59:17 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 49DF51A0072;
	Mon, 15 Jan 2024 08:59:16 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: fstests@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] xfs: Fix no executable permission
Date: Mon, 15 Jan 2024 08:59:13 +0800
Message-Id: <20240115005913.3829532-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28120.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28120.003
X-TMASE-Result: 10--2.370000-10.000000
X-TMASE-MatchedRID: 0KSlClBsfT6ROBVNmXUDuDyjd/AizytBCZa9cSpBObkrfoFYrvlA5ATg
	sjIJUJZIWGH5wVAlhqGlEtDJyVR88h8TzIzimOwPO6pzAGRBlFzZs3HUcS/scCq2rl3dzGQ1P0U
	wwWYR9x5Q2tk/ZySAhhtGKnF33geIXicK2T4zYMf8uHCCP42LxLgPzh0rT9im6yIPuGmYr74s5j
	DxYPoEN0wNCMOrF1tKhLvAid2uj0YVxRB/din+uJ07T8ZSLiAVvR84/OmB1wQp4n8eQBnwiw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Give them the executable permission, this also make the git status keep clean
after `./check`

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tests/xfs/557 | 0
 tests/xfs/567 | 0
 tests/xfs/568 | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/xfs/557
 mode change 100644 => 100755 tests/xfs/567
 mode change 100644 => 100755 tests/xfs/568

diff --git a/tests/xfs/557 b/tests/xfs/557
old mode 100644
new mode 100755
diff --git a/tests/xfs/567 b/tests/xfs/567
old mode 100644
new mode 100755
diff --git a/tests/xfs/568 b/tests/xfs/568
old mode 100644
new mode 100755
-- 
2.29.2

