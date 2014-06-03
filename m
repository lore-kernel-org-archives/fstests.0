Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22411 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbaFCS3D (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 3 Jun 2014 14:29:03 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH] xfs/013: allow non-write fsstress operations in background workload
Date: Tue,  3 Jun 2014 14:28:49 -0400
Message-Id: <1401820129-6543-1-git-send-email-bfoster@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

It has been reported that test xfs/013 probably uses more space than
necessary, exhausting space if run against a several GB sized ramdisk.
xfs/013 primarily creates, links and removes inodes. Most of the space
consumption occurs via the background fsstress workload.

Remove the fsstress -w option that suppresses non-write operations. This
slightly reduces the storage footprint while still providing a
background workload for the test.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Dave,

I was able to squeeze an xfs/013 run into a 3GB ramdisk on my VM with
this tweak. Let me know if this works for you. If not, we could probably
start turning off some of the heavier allocating fsstress ops so long as
the cost isn't too much. I'm measuring the effectiveness of this test
via the fibt stats exported to /proc.

Brian

 tests/xfs/013 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/013 b/tests/xfs/013
index e95d027..d47bf53 100755
--- a/tests/xfs/013
+++ b/tests/xfs/013
@@ -121,7 +121,7 @@ _create $SCRATCH_MNT/dir1 $COUNT
 _cleaner $SCRATCH_MNT $LOOPS $MINDIRS &
 
 # start a background stress workload on the fs
-$FSSTRESS_PROG -d $SCRATCH_MNT/fsstress -w -n 9999999 -p 2 -S t \
+$FSSTRESS_PROG -d $SCRATCH_MNT/fsstress -n 9999999 -p 2 -S t \
 	>> $seqres.full 2>&1 &
 
 # Each cycle clones the current directory and makes a random file replacement
-- 
1.8.3.1

