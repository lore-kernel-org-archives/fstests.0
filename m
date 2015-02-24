Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:64690 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751194AbbBXHUo (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Feb 2015 02:20:44 -0500
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YQ9nM-00033t-Qh
	for fstests@vger.kernel.org; Tue, 24 Feb 2015 18:20:40 +1100
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YQ9nM-0000rN-PZ
	for fstests@vger.kernel.org; Tue, 24 Feb 2015 18:20:40 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/4] xfs: don't output mkfs sector sizes into golden output
Date: Tue, 24 Feb 2015 18:20:33 +1100
Message-Id: <1424762435-3237-3-git-send-email-david@fromorbit.com>
In-Reply-To: <1424762435-3237-1-git-send-email-david@fromorbit.com>
References: <1424762435-3237-1-git-send-email-david@fromorbit.com>
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
 tests/xfs/096 |  5 +++--
 tests/xfs/206 | 33 +++++++++++++++------------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/tests/xfs/096 b/tests/xfs/096
index 0ecf88f..d216aa2 100755
--- a/tests/xfs/096
+++ b/tests/xfs/096
@@ -63,7 +63,7 @@ _cleanup()
 #           =                       sunit=0 blks
 #  realtime =none                   extsz=65536  blocks=N, rtextents=N
 #
-_mkfs_filter()
+mkfs_filter()
 {
    tee -a $seqres.full | \
    sed \
@@ -80,6 +80,7 @@ _mkfs_filter()
 	-e '/ *= *mmr=[0-9][0-9]* *$/d' \
 	-e 's/ *mixed-case=[YN]//' \
 	-e 's/ *ascii-ci=[01]//' \
+	-e "s/\(sunit=\)\([0-9]* blks,\)/\11 blks,/" \
 	-e 's/sectsz=[0-9][0-9]* *//' \
 	-e 's/, lazy-count.*//' \
 	-e '/inode-paths/d' \
@@ -145,7 +146,7 @@ do
     fi
     echo "--- mkfs=$mkfs ---"
     export MKFS_OPTIONS="$mkfs"
-    _scratch_mkfs_xfs 2>&1 | _mkfs_filter
+    _scratch_mkfs_xfs 2>&1 | mkfs_filter
     echo ""
     echo ""
 done
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

