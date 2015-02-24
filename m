Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:20177 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752516AbbBXW7v (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Feb 2015 17:59:51 -0500
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YQONF-0004vy-V7
	for fstests@vger.kernel.org; Wed, 25 Feb 2015 09:54:42 +1100
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YQONF-0002g4-Tx
	for fstests@vger.kernel.org; Wed, 25 Feb 2015 09:54:41 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/4] xfs: don't output mkfs sector sizes into golden output
Date: Wed, 25 Feb 2015 09:54:37 +1100
Message-Id: <1424818479-10083-3-git-send-email-david@fromorbit.com>
In-Reply-To: <1424818479-10083-1-git-send-email-david@fromorbit.com>
References: <1424818479-10083-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

The mkfs sector sizes are dependent on the underlying device in use,
and so is not fixed. hence it needs to be filtered from any golden
output file, otherwise tests that just differ by sector size will
fail.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/096          |  8 ++++++--
 tests/xfs/096.external | 15 +++++++--------
 tests/xfs/096.internal | 16 ++++++++--------
 tests/xfs/119          |  2 +-
 tests/xfs/206          | 33 +++++++++++++++------------------
 5 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/tests/xfs/096 b/tests/xfs/096
index 0ecf88f..2da8fa1 100755
--- a/tests/xfs/096
+++ b/tests/xfs/096
@@ -47,6 +47,8 @@ _cleanup()
 #
 # filter out counts which will vary
 #   - extsz, blocks, agsize, agcount, device name, rtextents
+#   - log version varies for crc enabled fs
+#   - lsunit varies for 512/4k sector devices
 # filter out differences between linux and irix:
 #   - sectsz on Linux
 #   - mmr, mixed-case on IRIX
@@ -63,7 +65,7 @@ _cleanup()
 #           =                       sunit=0 blks
 #  realtime =none                   extsz=65536  blocks=N, rtextents=N
 #
-_mkfs_filter()
+mkfs_filter()
 {
    tee -a $seqres.full | \
    sed \
@@ -80,6 +82,8 @@ _mkfs_filter()
 	-e '/ *= *mmr=[0-9][0-9]* *$/d' \
 	-e 's/ *mixed-case=[YN]//' \
 	-e 's/ *ascii-ci=[01]//' \
+	-e 's/\(version=\)\([12]\)/\1N/' \
+	-e 's/\(sunit=\)\([018] blks\)/\1N blks/' \
 	-e 's/sectsz=[0-9][0-9]* *//' \
 	-e 's/, lazy-count.*//' \
 	-e '/inode-paths/d' \
@@ -145,7 +149,7 @@ do
     fi
     echo "--- mkfs=$mkfs ---"
     export MKFS_OPTIONS="$mkfs"
-    _scratch_mkfs_xfs 2>&1 | _mkfs_filter
+    _scratch_mkfs_xfs 2>&1 | mkfs_filter
     echo ""
     echo ""
 done
diff --git a/tests/xfs/096.external b/tests/xfs/096.external
index 95833c8..7923340 100644
--- a/tests/xfs/096.external
+++ b/tests/xfs/096.external
@@ -11,8 +11,7 @@ meta-data=DEV isize=256    agcount=N, agsize=N blks
 data     =                       bsize=4096   blocks=N, imaxpct=N
          =                       sunit=0      swidth=0 blks, unwritten=1
 naming   =version 2              bsize=4096
-log      =LOG                    bsize=4096   blocks=N, version=2
-         =                       sunit=8 blks
+log      =LOG                    bsize=4096   blocks=N, version=N
 realtime =REALTIME               extsz=N, blocks=N, rtextents=N
 
 
@@ -22,8 +21,8 @@ meta-data=DEV isize=256    agcount=N, agsize=N blks
 data     =                       bsize=4096   blocks=N, imaxpct=N
          =                       sunit=65     swidth=65 blks, unwritten=1
 naming   =version 2              bsize=4096
-log      =LOG                    bsize=4096   blocks=N, version=2
-         =                       sunit=0 blks
+log      =LOG                    bsize=4096   blocks=N, version=N
+         =                       sunit=N blks
 realtime =REALTIME               extsz=N, blocks=N, rtextents=N
 
 
@@ -33,8 +32,8 @@ meta-data=DEV isize=256    agcount=N, agsize=N blks
 data     =                       bsize=4096   blocks=N, imaxpct=N
          =                       sunit=65     swidth=65 blks, unwritten=1
 naming   =version 2              bsize=4096
-log      =LOG                    bsize=4096   blocks=N, version=1
-         =                       sunit=0 blks
+log      =LOG                    bsize=4096   blocks=N, version=N
+         =                       sunit=N blks
 realtime =REALTIME               extsz=N, blocks=N, rtextents=N
 
 
@@ -44,8 +43,8 @@ meta-data=DEV isize=256    agcount=N, agsize=N blks
 data     =                       bsize=4096   blocks=N, imaxpct=N
          =                       sunit=65     swidth=65 blks, unwritten=1
 naming   =version 2              bsize=4096
-log      =LOG                    bsize=4096   blocks=N, version=1
-         =                       sunit=0 blks
+log      =LOG                    bsize=4096   blocks=N, version=N
+         =                       sunit=N blks
 realtime =REALTIME               extsz=N, blocks=N, rtextents=N
 
 
diff --git a/tests/xfs/096.internal b/tests/xfs/096.internal
index 7bf848c..eaba13f 100644
--- a/tests/xfs/096.internal
+++ b/tests/xfs/096.internal
@@ -11,8 +11,8 @@ meta-data=DEV isize=256    agcount=N, agsize=N blks
 data     =                       bsize=4096   blocks=N, imaxpct=N
          =                       sunit=0      swidth=0 blks, unwritten=1
 naming   =version 2              bsize=4096
-log      =LOG                    bsize=4096   blocks=N, version=2
-         =                       sunit=8 blks
+log      =LOG                    bsize=4096   blocks=N, version=N
+         =                       sunit=N blks
 realtime =REALTIME               extsz=N, blocks=N, rtextents=N
 
 
@@ -22,8 +22,8 @@ meta-data=DEV isize=256    agcount=N, agsize=N blks
 data     =                       bsize=4096   blocks=N, imaxpct=N
          =                       sunit=65     swidth=65 blks, unwritten=1
 naming   =version 2              bsize=4096
-log      =LOG                    bsize=4096   blocks=N, version=2
-         =                       sunit=8 blks
+log      =LOG                    bsize=4096   blocks=N, version=N
+         =                       sunit=N blks
 realtime =REALTIME               extsz=N, blocks=N, rtextents=N
 
 
@@ -33,8 +33,8 @@ meta-data=DEV isize=256    agcount=N, agsize=N blks
 data     =                       bsize=4096   blocks=N, imaxpct=N
          =                       sunit=65     swidth=65 blks, unwritten=1
 naming   =version 2              bsize=4096
-log      =LOG                    bsize=4096   blocks=N, version=1
-         =                       sunit=0 blks
+log      =LOG                    bsize=4096   blocks=N, version=N
+         =                       sunit=N blks
 realtime =REALTIME               extsz=N, blocks=N, rtextents=N
 
 
@@ -44,8 +44,8 @@ meta-data=DEV isize=256    agcount=N, agsize=N blks
 data     =                       bsize=4096   blocks=N, imaxpct=N
          =                       sunit=65     swidth=65 blks, unwritten=1
 naming   =version 2              bsize=4096
-log      =LOG                    bsize=4096   blocks=N, version=1
-         =                       sunit=0 blks
+log      =LOG                    bsize=4096   blocks=N, version=N
+         =                       sunit=N blks
 realtime =REALTIME               extsz=N, blocks=N, rtextents=N
 
 
diff --git a/tests/xfs/119 b/tests/xfs/119
index 490495b..156d5e4 100755
--- a/tests/xfs/119
+++ b/tests/xfs/119
@@ -54,7 +54,7 @@ _require_scratch
 # this may hang
 sync
 
-export MKFS_OPTIONS="-l version=2,size=2500b,su=64k" 
+export MKFS_OPTIONS="-l version=2,size=2560b,su=64k" 
 export MOUNT_OPTIONS="-o logbsize=64k"
 _scratch_mkfs_xfs >/dev/null
 
diff --git a/tests/xfs/206 b/tests/xfs/206
index f6dcca6..198e413 100755
--- a/tests/xfs/206
+++ b/tests/xfs/206
@@ -73,34 +73,31 @@ echo "=== truncate file ==="
 dd if=/dev/zero of=$tmpfile bs=1 seek=19998630180864 count=1 >/dev/null 2>&1 \
 	|| _fail "!!! failed to truncate loopback file to correct size"
 
+mkfs_filter()
+{
+	sed -e "s,^meta-data=.*isize,meta-data=FILE                   isize,g" \
+	    -e "s/\(^log.*blocks=\)\([0-9]*,\)/\1XXXXX,/" \
+	    -e "s/, projid32bit=[0-9]//" \
+	    -e "s/ ftype=[0-9]//" \
+	    -e "s/\(sectsz\)\(=[0-9]* *\)/\1=512   /" \
+	    -e "s/\(sunit=\)\([0-9]* blks,\)/\10 blks,/" \
+	    -e "/.*crc=/d"
+}
+
 # mkfs slightly smaller than that
 echo "=== mkfs.xfs ==="
-mkfs.xfs -f -bsize=4096 -dagsize=76288719b,size=3905982455b -llazy-count=0 $tmpfile \
-	| sed -e "s,^meta-data=.*isize,meta-data=FILE                   isize,g" \
-		-e "s/\(^log.*blocks=\)\([0-9]*,\)/\1XXXXX,/" \
-		-e "s/, projid32bit=[0-9]//" \
-		-e "s/ ftype=[0-9]//" \
-		-e "/.*crc=/d"
+mkfs.xfs -f -bsize=4096 -dagsize=76288719b,size=3905982455b \
+	 -llazy-count=0 $tmpfile  | mkfs_filter
 
 mount -o loop $tmpfile $tmpdir || _fail "!!! failed to loopback mount"
 
 # see what happens when we growfs it
 echo "=== xfs_growfs ==="
-xfs_growfs $tmpdir \
-	| sed -e "s,^meta-data=.*isize,meta-data=FILE                   isize,g" \
-		-e "s/\(^log.*blocks=\)\([0-9]*,\)/\1XXXXX,/" \
-		-e "s/, projid32bit=[0-9]//" \
-		-e "s/ ftype=[0-9]//" \
-		-e "/.*crc=/d"
+xfs_growfs $tmpdir  | mkfs_filter
 
 # and double-check the new geometry
 echo "=== xfs_info ==="
-xfs_info $tmpdir \
-	| sed -e "s,^meta-data=.*isize,meta-data=FILE                   isize,g" \
-		-e "s/\(^log.*blocks=\)\([0-9]*,\)/\1XXXXX,/" \
-		-e "s/, projid32bit=[0-9]//" \
-		-e "s/ ftype=[0-9]//" \
-		-e "/.*crc=/d"
+xfs_info $tmpdir | mkfs_filter
 
 # _cleanup cleans up for us
 
-- 
2.0.0

