Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F925EE69
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="133959212"
X-IronPort-AV: E=Sophos;i="6.04,189,1695654000"; 
   d="scan'208";a="133959212"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 18:45:35 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 12104D9D8F
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 18:45:34 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 50150D501D
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 18:45:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D0BCD68957
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 18:45:32 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 556AF1A0070;
	Fri, 12 Jan 2024 17:45:32 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: fstests@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] gitignore: Add missing /src/t_reflink_read_race
Date: Fri, 12 Jan 2024 17:45:24 +0800
Message-Id: <20240112094524.3797754-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28114.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28114.006
X-TMASE-Result: 10--0.563200-10.000000
X-TMASE-MatchedRID: UpZ+EYxJ0vlSuJfEWZSQfE7nLUqYrlslFIuBIWrdOePfUZT83lbkEJzi
	pOOCnHvUGYDb3Nl5wdP6iHjvPRitWEkjllSXrjtQFEUknJ/kEl6xlUYThzDU2/oLR4+zsDTtjoc
	zmuoPCq0h036LQL4lW2P2RuloqrpxVQ2jI+vVZ9OMDfVY0snn+KVu9xx+ZpjDmw0Qaktp+ussz+
	cQMs/Tnp75MOLIf/j3DF+QsB+Q01JoBmTSwRxjXg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Add the binary to gitignore, make git status clean

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 7508b6e8b282..e567a56ff129 100644
--- a/.gitignore
+++ b/.gitignore
@@ -165,6 +165,7 @@ tags
 /src/t_readdir_1
 /src/t_readdir_2
 /src/t_readdir_3
+/src/t_reflink_read_race
 /src/t_rename_overwrite
 /src/t_stripealign
 /src/t_truncate_cmtime
-- 
2.29.2

