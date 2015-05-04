Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:2516 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751232AbbEDWBw (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 4 May 2015 18:01:52 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YpOQi-0005b1-LD
	for fstests@vger.kernel.org; Tue, 05 May 2015 08:01:36 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YpOQi-0006gL-KT
	for fstests@vger.kernel.org; Tue, 05 May 2015 08:01:36 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 3/4] xfs/045: can't change UUID on v5 filesystems.
Date: Tue,  5 May 2015 08:01:32 +1000
Message-Id: <1430776893-25158-4-git-send-email-david@fromorbit.com>
In-Reply-To: <1430776893-25158-1-git-send-email-david@fromorbit.com>
References: <1430776893-25158-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

So pass "-m crc=0" to the scratch_mkfs command so that we only run
on old v4 format filesystems where the UUID can be changed.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/045 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/045 b/tests/xfs/045
index 7d8a4a1..2f5508f 100755
--- a/tests/xfs/045
+++ b/tests/xfs/045
@@ -50,7 +50,7 @@ _require_scratch_nocheck
 echo "*** get uuid"
 uuid=`_get_existing_uuid`
 echo "*** mkfs"
-if ! _scratch_mkfs_xfs >$tmp.out 2>&1
+if ! _scratch_mkfs_xfs -m crc=0 >$tmp.out 2>&1
 then
     cat $tmp.out
     echo "!!! failed to mkfs on $SCRATCH_DEV"
-- 
2.0.0

