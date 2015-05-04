Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:33469 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751499AbbEDWBw (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 4 May 2015 18:01:52 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YpOQi-0005b0-Kd
	for fstests@vger.kernel.org; Tue, 05 May 2015 08:01:36 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YpOQi-0006gG-Jw
	for fstests@vger.kernel.org; Tue, 05 May 2015 08:01:36 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/4] filter: latest xfs_repair is more verbose
Date: Tue,  5 May 2015 08:01:31 +1000
Message-Id: <1430776893-25158-3-git-send-email-david@fromorbit.com>
In-Reply-To: <1430776893-25158-1-git-send-email-david@fromorbit.com>
References: <1430776893-25158-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

It detects more errors, so we need to filter them out to prevent
golden image mismatches on successful recovery.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/repair | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/repair b/common/repair
index 7a99546..ce6d258 100644
--- a/common/repair
+++ b/common/repair
@@ -83,6 +83,7 @@ s/\s+- \d+:\d\d:\d\d:.*\n//g;
 /^Metadata corruption detected/ && next;
 /^Metadata CRC error detected/ && next;
 /^agfl has bad CRC/ && next;
+/^bad CRC for inode/ && next;
 # finobt enabled filesystem output
 s/(inode chunk) (\d+)\/(\d+)/AGNO\/INO/;
 # sunit/swidth reset messages
-- 
2.0.0

