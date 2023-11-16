Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 23:34:31 PST
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F8120
	for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 23:34:30 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="139892494"
X-IronPort-AV: E=Sophos;i="6.03,307,1694703600"; 
   d="scan'208";a="139892494"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 16:33:27 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 118A0D7AE5
	for <fstests@vger.kernel.org>; Thu, 16 Nov 2023 16:33:24 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 10184BF4C8
	for <fstests@vger.kernel.org>; Thu, 16 Nov 2023 16:33:23 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 923B96B80D
	for <fstests@vger.kernel.org>; Thu, 16 Nov 2023 16:33:22 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 398791A006F;
	Thu, 16 Nov 2023 15:33:22 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: fstests@vger.kernel.org
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2] xfs/263: Remove mkfs.xfs data section argument
Date: Thu, 16 Nov 2023 02:33:15 -0500
Message-Id: <20231116073315.3748-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28000.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28000.003
X-TMASE-Result: 10--4.406500-10.000000
X-TMASE-MatchedRID: a8MPMWx7TRget1TxvngNg77KoGyf6JSDfeeWNV6+vcPmWHHSYEnI8WiX
	cD8fWgFvCOAB2JMe4rvGRSyN4YgWiC0+EsApCrRREhGH3CRdKUWu2GmdldmiUEekR3VSvOYVEZc
	2cPY2ad0i+t+0AiFaYvL3NxFKQpq1CtNdSL7NMxSqh5pv1eDPz30tCKdnhB58I/9UW5M5dRNp7q
	EhmmPgy46HM5rqDwqtv/hga1o6V2jLweTCIPTrZZt2cCZ1xUma1y+JiXSXKXuK8PN+qUL0gvKwE
	tWO2rOdiAKEW3c8EkzAR/GcbCkjEZWA9JIJFdJqFcG3+ZRETICP9kUX1Z+buE3LumkbQiNwVCqT
	SPu8tVR7AxIEOt4h2Q==
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

But, since xfstests commit baaa392c("xfs/263: don't hardcode inode numbers in output"),
we don't care the inode number. So let's remove this data section size argument
instead of increasing this size to 1G, then we can solve this false
positive.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/263 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/xfs/263 b/tests/xfs/263
index fadd6280..bce4e13f 100755
--- a/tests/xfs/263
+++ b/tests/xfs/263
@@ -72,12 +72,11 @@ function test_all_state()
 }
 
 echo "==== NO CRC ===="
-# Control size to control inode numbers
-_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=512m" >> $seqres.full
+_scratch_mkfs_xfs "-m crc=0 -n ftype=0" >> $seqres.full
 test_all_state
 
 echo "==== CRC ===="
-_scratch_mkfs_xfs "-m crc=1 -d size=512m" >>$seqres.full
+_scratch_mkfs_xfs "-m crc=1" >>$seqres.full
 test_all_state
 
 status=0
-- 
2.39.1

