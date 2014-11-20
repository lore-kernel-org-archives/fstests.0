Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:61992 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756737AbaKTABW (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 19 Nov 2014 19:01:22 -0500
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1XrFBW-00022Y-Kt
	for fstests@vger.kernel.org; Thu, 20 Nov 2014 11:01:18 +1100
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1XrFBW-0003VS-Jn
	for fstests@vger.kernel.org; Thu, 20 Nov 2014 11:01:18 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] xfs/096: strip log stripe warnings from mkfs.xfs
Date: Thu, 20 Nov 2014 11:01:18 +1100
Message-Id: <1416441678-13445-1-git-send-email-david@fromorbit.com>
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
 tests/xfs/096          | 1 +
 tests/xfs/096.external | 2 --
 tests/xfs/096.internal | 4 ----
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/tests/xfs/096 b/tests/xfs/096
index b2719bc..0179e77 100755
--- a/tests/xfs/096
+++ b/tests/xfs/096
@@ -88,6 +88,7 @@ _mkfs_filter()
 	-e '/.*crc=/d' \
 	-e 's/ *$//' \
 	-e 's/ ftype=[01]//' \
+	-e '/^log stripe unit/d' \
    | grep -v parent
 }
 
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

