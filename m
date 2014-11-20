Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:20482 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756563AbaKTAKm (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 19 Nov 2014 19:10:42 -0500
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1XrFIQ-00024R-Bx
	for fstests@vger.kernel.org; Thu, 20 Nov 2014 11:08:26 +1100
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1XrFIQ-0003gh-BB
	for fstests@vger.kernel.org; Thu, 20 Nov 2014 11:08:26 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH V2] xfs/096: strip log stripe warnings from mkfs.xfs
Date: Thu, 20 Nov 2014 11:08:26 +1100
Message-Id: <1416442106-14140-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

The warnings have been removed when stripe unit/width are too big
for the log stripe unit to be set. Hence add them to the mkfs.xfs
filter and strip them from golden output file so the test succeeds
on both new and old mfks binaries.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/096          | 4 +++-
 tests/xfs/096.external | 2 --
 tests/xfs/096.internal | 4 ----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tests/xfs/096 b/tests/xfs/096
index b2719bc..0ecf88f 100755
--- a/tests/xfs/096
+++ b/tests/xfs/096
@@ -88,6 +88,8 @@ _mkfs_filter()
 	-e '/.*crc=/d' \
 	-e 's/ *$//' \
 	-e 's/ ftype=[01]//' \
+	-e '/^log stripe unit.*too large/d' \
+	-e '/^log stripe unit adjusted/d' \
    | grep -v parent
 }
 
@@ -143,7 +145,7 @@ do
     fi
     echo "--- mkfs=$mkfs ---"
     export MKFS_OPTIONS="$mkfs"
-    _scratch_mkfs_xfs | _mkfs_filter
+    _scratch_mkfs_xfs 2>&1 | _mkfs_filter
     echo ""
     echo ""
 done
diff --git a/tests/xfs/096.external b/tests/xfs/096.external
index 9175904..95833c8 100644
--- a/tests/xfs/096.external
+++ b/tests/xfs/096.external
@@ -7,8 +7,6 @@ log stripe unit (262656) must be a multiple of the block size (4096)
 
 # test log stripe greater than LR size
 --- mkfs=-l version=2,su=266240 ---
-log stripe unit (266240 bytes) is too large (maximum is 256KiB)
-log stripe unit adjusted to 32KiB
 meta-data=DEV isize=256    agcount=N, agsize=N blks
 data     =                       bsize=4096   blocks=N, imaxpct=N
          =                       sunit=0      swidth=0 blks, unwritten=1
diff --git a/tests/xfs/096.internal b/tests/xfs/096.internal
index cf75037..7bf848c 100644
--- a/tests/xfs/096.internal
+++ b/tests/xfs/096.internal
@@ -7,8 +7,6 @@ log stripe unit (262656) must be a multiple of the block size (4096)
 
 # test log stripe greater than LR size
 --- mkfs=-l version=2,su=266240 ---
-log stripe unit (266240 bytes) is too large (maximum is 256KiB)
-log stripe unit adjusted to 32KiB
 meta-data=DEV isize=256    agcount=N, agsize=N blks
 data     =                       bsize=4096   blocks=N, imaxpct=N
          =                       sunit=0      swidth=0 blks, unwritten=1
@@ -20,8 +18,6 @@ realtime =REALTIME               extsz=N, blocks=N, rtextents=N
 
 # same test but get log stripe from data stripe
 --- mkfs=-l version=2 -d su=266240,sw=1 ---
-log stripe unit (266240 bytes) is too large (maximum is 256KiB)
-log stripe unit adjusted to 32KiB
 meta-data=DEV isize=256    agcount=N, agsize=N blks
 data     =                       bsize=4096   blocks=N, imaxpct=N
          =                       sunit=65     swidth=65 blks, unwritten=1
-- 
2.0.0

