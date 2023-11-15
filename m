Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB07E
	for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E9DB
	for <fstests@vger.kernel.org>; Tue, 14 Nov 2023 21:57:10 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="127718017"
X-IronPort-AV: E=Sophos;i="6.03,304,1694703600"; 
   d="scan'208";a="127718017"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 14:57:08 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id F27E4D4F5A
	for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 14:57:05 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 373A9CFA5A
	for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 14:57:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id C00426B806
	for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 14:57:04 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 66CDF1A006F;
	Wed, 15 Nov 2023 13:57:04 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: fstests@vger.kernel.org
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] xfs/263: increase data section size to 1024M
Date: Wed, 15 Nov 2023 00:56:59 -0500
Message-Id: <20231115055659.2027-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27998.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27998.005
X-TMASE-Result: 10--4.655900-10.000000
X-TMASE-MatchedRID: r2UsUYnETSIObebKdnmixgXtykVcrvpNi/c1Us2QTkCZLRO16GOkknFC
	0fMeQA5w1SLrct07oQxHW7omdzHbHV9CEME3KQfX3IFFT9wqfr2OVGny5q72hownGKAoIKJLvwU
	evDt+uW5/XjpbSJS7axK4lG1JTzijwktTXgr7N6ieAiCmPx4NwGmRqNBHmBveVDC1CbuJXmMqtq
	5d3cxkNaUs4whL2uiUN7BzNJawAMu3EWUHozc8ucfRC+/F5VM7SYlNex9K/JXjIKzCAUo+m0lRE
	BUgzA5Tao+nkfRSQWjJJbTdB6arFP8jyjqYHnMRFcUQf3Yp/ridO0/GUi4gFb0fOPzpgdcEKeJ/
	HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

On machine with using raid, this case will trigger
the following error:
==== NO CRC ====
+mkfs.xfs: small data volume, ignoring data volume stripe unit 512 and stripe width 512
== Options: rw ==
== Options: usrquota,rw ==

mkfs.xfs generates this error since xfsprogs commit 42371fb36
("mkfs: ignore data blockdev stripe geometry for small filesystems").
It disables automatic detection of stripe unit and width if the
data device is less than 1GB.

To slove false poistive, just increase data section size to 1G.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/263 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/263 b/tests/xfs/263
index fadd6280..48581bac 100755
--- a/tests/xfs/263
+++ b/tests/xfs/263
@@ -73,11 +73,11 @@ function test_all_state()
 
 echo "==== NO CRC ===="
 # Control size to control inode numbers
-_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=512m" >> $seqres.full
+_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=1024m" >> $seqres.full
 test_all_state
 
 echo "==== CRC ===="
-_scratch_mkfs_xfs "-m crc=1 -d size=512m" >>$seqres.full
+_scratch_mkfs_xfs "-m crc=1 -d size=1024m" >>$seqres.full
 test_all_state
 
 status=0
-- 
2.39.1

