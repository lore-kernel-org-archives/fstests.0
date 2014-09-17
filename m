Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:42768 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753385AbaIQBmM (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Sep 2014 21:42:12 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1XU4Fo-0003kY-8g
	for fstests@vger.kernel.org; Wed, 17 Sep 2014 11:41:56 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1XU4Fo-0006OE-7z
	for fstests@vger.kernel.org; Wed, 17 Sep 2014 11:41:56 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/5] check: more tests that shouldn't check the scratch device
Date: Wed, 17 Sep 2014 11:41:50 +1000
Message-Id: <1410918113-23516-3-git-send-email-david@fromorbit.com>
In-Reply-To: <1410918113-23516-1-git-send-email-david@fromorbit.com>
References: <1410918113-23516-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

xfs/200 leaves a dirty log as readonly filesystems don't write
unmount records to mark the log clean.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/200 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/200 b/tests/xfs/200
index f4db64f..f0c4337 100755
--- a/tests/xfs/200
+++ b/tests/xfs/200
@@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs xfs
 _supported_os Linux
 
-_require_scratch
+_require_scratch_nocheck
 
 _scratch_mkfs_xfs >/dev/null 2>&1
 
-- 
2.0.0

