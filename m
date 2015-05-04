Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:33469 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751403AbbEDWBv (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 4 May 2015 18:01:51 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YpOQi-0005az-K7
	for fstests@vger.kernel.org; Tue, 05 May 2015 08:01:36 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YpOQi-0006gB-JP
	for fstests@vger.kernel.org; Tue, 05 May 2015 08:01:36 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/4] filter: latest mkfs.xfs makes logical sector size noise
Date: Tue,  5 May 2015 08:01:30 +1000
Message-Id: <1430776893-25158-2-git-send-email-david@fromorbit.com>
In-Reply-To: <1430776893-25158-1-git-send-email-david@fromorbit.com>
References: <1430776893-25158-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

On devices that have a logical sector smaller than physical sector,
this extra, harmless output now occurs:

     QA output created by 060
    +specified blocksize 1024 is less than device physical sector size 4096
    +switching to logical sector size 512
     Creating directory system to dump using src/fill.
     Setup .......................................
     Dumping to files...

And it causes lots of tests to fail unnecessarily. Filter it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/rc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 6ea107e..242dedb 100644
--- a/common/rc
+++ b/common/rc
@@ -365,9 +365,12 @@ _scratch_mkfs_xfs()
 		mkfs_status=$?
 	fi
 
-	# output stored mkfs output
-	cat $tmp_dir.mkfserr >&2
+	# output stored mkfs output, filtering unnecessary warnings from stderr
 	cat $tmp_dir.mkfsstd
+	cat $tmp_dir.mkfserr | sed \
+		-e '/less than device physical sector/d' \
+		-e '/switching to logical sector/d' \
+		>&2
 	rm -f $tmp_dir.mkfserr $tmp_dir.mkfsstd
 
 	return $mkfs_status
-- 
2.0.0

