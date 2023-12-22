Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C7524F
	for <fstests@vger.kernel.org>; Fri, 22 Dec 2023 04:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="132282622"
X-IronPort-AV: E=Sophos;i="6.04,294,1695654000"; 
   d="scan'208";a="132282622"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 13:42:58 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 81B68D502C
	for <fstests@vger.kernel.org>; Fri, 22 Dec 2023 13:42:55 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C197FCF7D8
	for <fstests@vger.kernel.org>; Fri, 22 Dec 2023 13:42:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 564062008633E
	for <fstests@vger.kernel.org>; Fri, 22 Dec 2023 13:42:54 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0515E1A006F;
	Fri, 22 Dec 2023 12:42:53 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: fstests@vger.kernel.org
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] generic/650: add kernel commit id
Date: Thu, 21 Dec 2023 21:48:00 -0500
Message-Id: <20231222024800.138907-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28072.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28072.004
X-TMASE-Result: 10--5.301100-10.000000
X-TMASE-MatchedRID: z3J1J1uQCpJeDnPFO4EAXwXtykVcrvpN/GjNw6YlcZVGQgIVrmBL5LiR
	FJnWDxklVDm736+f1IfaZPmMVOmjhyTEsdOrCx36qhcdnP91eXFh1mb42cZVB8eQfu6iwSfsvwU
	evDt+uW5/XjpbSJS7az0PUzN6kKueTPmZYEXmxpHGL//8mlodA03yuY9BGW8rGFIIpkEhCjw7F9
	AtyyT2qCBixTwvaPIsgDLqnrRlXrYlb7vXIR6fpmrz/G/ZSbVq+gtHj7OwNO31Kzk40dEY9STQi
	nyMWSsz4BcqJJvDMrJY6Qtl/W5m+0MlvMTXm3Qh
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This week, this case crashed when I test xfstests on xfs. Then, I found
this kernel patch to slove this problem, so add it.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/generic/650 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/650 b/tests/generic/650
index 773f93c7..e152c398 100755
--- a/tests/generic/650
+++ b/tests/generic/650
@@ -10,6 +10,9 @@
 . ./common/preamble
 _begin_fstest auto rw stress soak
 
+[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit ecd49f7a36fb \
+        "xfs: fix per-cpu CIL structure aggregation racing with dying cpus"
+
 # Override the default cleanup function.
 _cleanup()
 {
-- 
2.27.0

