From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/206: filter out reflink related outputs
Date: Wed, 30 Mar 2016 15:56:49 +0800
Message-Id: <1459324609-5531-1-git-send-email-eguan@redhat.com>
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, darrick.wong@oracle.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Commit 13717ffc96fe ("xfs/206: fix output when mkfs knows about
reflink") added extra lines to xfs/206.out to fit the mkfs output with
reflink support, but broke tests without reflink support.

Fix it by filtering out reflink related outputs, just like filtering out
crc related outputs in the test.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

Tested with v4.5 xfsprogs as well as Darrick's xfsprogs (for-dave-for-4.6
branch) with reflink support.

https://github.com/djwong/xfsprogs.git

 tests/xfs/206     | 2 +-
 tests/xfs/206.out | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/xfs/206 b/tests/xfs/206
index 24e690a..d549a4c 100755
--- a/tests/xfs/206
+++ b/tests/xfs/206
@@ -80,7 +80,7 @@ mkfs_filter()
 	    -e "s/\(^log.*blocks=\)\([0-9]*,\)/\1XXXXX,/" \
 	    -e "s/, projid32bit=[0-9]//" \
 	    -e "s/ ftype=[0-9]//" \
-	    -e "s/ reflink=[0-9]//" \
+	    -e "/.*reflink=/d" \
 	    -e "s/\(sectsz\)\(=[0-9]* *\)/\1=512   /" \
 	    -e "s/\(sunit=\)\([0-9]* blks,\)/\10 blks,/" \
 	    -e "s/, lazy-count=[0-9]//" \
diff --git a/tests/xfs/206.out b/tests/xfs/206.out
index e73a954..2db839d 100644
--- a/tests/xfs/206.out
+++ b/tests/xfs/206.out
@@ -12,7 +12,6 @@ realtime =none                   extsz=4096   blocks=0, rtextents=0
 === xfs_growfs ===
 meta-data=FILE isize=N    agcount=52, agsize=76288719 blks
          =                       sectsz=512   attr=2
-         =                      
 data     =                       bsize=4096   blocks=3905982455, imaxpct=5
          =                       sunit=0      swidth=0 blks
 naming   =version 2              bsize=4096   ascii-ci=0
@@ -23,7 +22,6 @@ data blocks changed from 3905982455 to 4882478016
 === xfs_info ===
 meta-data=FILE isize=N    agcount=64, agsize=76288719 blks
          =                       sectsz=512   attr=2
-         =                      
 data     =                       bsize=4096   blocks=4882478016, imaxpct=5
          =                       sunit=0      swidth=0 blks
 naming   =version 2              bsize=4096   ascii-ci=0
-- 
2.5.5
