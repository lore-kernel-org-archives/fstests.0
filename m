Received: from mx1.redhat.com ([209.132.183.28]:52923 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbcFBJLK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 2 Jun 2016 05:11:10 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C5EB85364
	for <fstests@vger.kernel.org>; Thu,  2 Jun 2016 09:11:10 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH] xfstests: update xfs/096 for new behaviour
Date: Thu,  2 Jun 2016 11:10:59 +0200
Message-Id: <1464858659-610-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Because we recently changed how mkfs behaves when it gets incorrect/invalid
values, update the expected output to reflect the change.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 tests/xfs/096.out.internal | 60 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/tests/xfs/096.out.internal b/tests/xfs/096.out.internal
index 80201d2..82c2043 100644
--- a/tests/xfs/096.out.internal
+++ b/tests/xfs/096.out.internal
@@ -2,18 +2,62 @@ QA output created by 096
 
 # su too big but must be a multiple of fs block size too
 --- mkfs=-l version=2,su=262656 ---
-log stripe unit (262656) must be a multiple of the block size (4096)
+Illegal value 262656 for -l su option. value is too large
+Usage: mkfs.xfs
+/* blocksize */		[-b log=n|size=num]
+/* data subvol */	[-d agcount=n,agsize=n,file,name=xxx,size=num,
+			    (sunit=value,swidth=value|su=num,sw=num|noalign),
+			    sectlog=n|sectsize=num
+/* force overwrite */	[-f]
+/* inode size */	[-i log=n|perblock=n|size=num,maxpct=n,attr=0|1|2,
+			    projid32bit=0|1,sparse=0|1]
+/* no discard */	[-K]
+/* log subvol */	[-l agnum=n,internal,size=num,logdev=xxx,version=n
+			    sunit=value|su=num,sectlog=n|sectsize=num,
+			    lazy-count=0|1]
+/* label */		[-L label (maximum 12 characters)]
+/* naming */		[-n log=n|size=num,version=N|ci,ftype=0|1]
+/* no-op info only */	[-N]
+/* prototype file */	[-p fname]
+/* quiet */		[-q]
+/* realtime subvol */	[-r extsize=num,size=num,rtdev=xxx]
+/* sectorsize */	[-s log=n|size=num]
+/* version */		[-V]
+			devicename
+<devicename> is required unless -d name=xxx is given.
+<num> is xxx (bytes), xxxs (sectors), xxxb (fs blocks), xxxk (xxx KiB),
+      xxxm (xxx MiB), xxxg (xxx GiB), xxxt (xxx TiB) or xxxp (xxx PiB).
+<value> is xxx (512 byte blocks).
 
 
 # test log stripe greater than LR size
 --- mkfs=-l version=2,su=266240 ---
-meta-data=DEV isize=N    agcount=N, agsize=N blks
-data     =                       bsize=4096   blocks=N, imaxpct=N
-         =                       sunit=0      swidth=0 blks, unwritten=1
-naming   =version 2              bsize=4096
-log      =LOG                    bsize=4096   blocks=N, version=N
-         =                       sunit=N blks
-realtime =REALTIME               extsz=N, blocks=N, rtextents=N
+Illegal value 266240 for -l su option. value is too large
+Usage: mkfs.xfs
+/* blocksize */		[-b log=n|size=num]
+/* data subvol */	[-d agcount=n,agsize=n,file,name=xxx,size=num,
+			    (sunit=value,swidth=value|su=num,sw=num|noalign),
+			    sectlog=n|sectsize=num
+/* force overwrite */	[-f]
+/* inode size */	[-i log=n|perblock=n|size=num,maxpct=n,attr=0|1|2,
+			    projid32bit=0|1,sparse=0|1]
+/* no discard */	[-K]
+/* log subvol */	[-l agnum=n,internal,size=num,logdev=xxx,version=n
+			    sunit=value|su=num,sectlog=n|sectsize=num,
+			    lazy-count=0|1]
+/* label */		[-L label (maximum 12 characters)]
+/* naming */		[-n log=n|size=num,version=N|ci,ftype=0|1]
+/* no-op info only */	[-N]
+/* prototype file */	[-p fname]
+/* quiet */		[-q]
+/* realtime subvol */	[-r extsize=num,size=num,rtdev=xxx]
+/* sectorsize */	[-s log=n|size=num]
+/* version */		[-V]
+			devicename
+<devicename> is required unless -d name=xxx is given.
+<num> is xxx (bytes), xxxs (sectors), xxxb (fs blocks), xxxk (xxx KiB),
+      xxxm (xxx MiB), xxxg (xxx GiB), xxxt (xxx TiB) or xxxp (xxx PiB).
+<value> is xxx (512 byte blocks).
 
 
 # same test but get log stripe from data stripe
-- 
2.5.5

