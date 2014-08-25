Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:58570 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755138AbaHYWea (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 25 Aug 2014 18:34:30 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1XM2q1-0008Pa-O1
	for fstests@vger.kernel.org; Tue, 26 Aug 2014 08:34:09 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1XM2q1-0008Co-N6
	for fstests@vger.kernel.org; Tue, 26 Aug 2014 08:34:09 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/2] filter: update xfs_repair filter for new sunit/swidth warning
Date: Tue, 26 Aug 2014 08:34:03 +1000
Message-Id: <1409006043-31495-3-git-send-email-david@fromorbit.com>
In-Reply-To: <1409006043-31495-1-git-send-email-david@fromorbit.com>
References: <1409006043-31495-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

New xfs_repair programs have a different sunit/swidth warning that
is triggering failures such as:

    -Note - stripe unit (0) and width (0) fields have been reset.
    -Please set with mount -o sunit=<value>,swidth=<value>
    +Note - stripe unit (0) and width (0) were copied from a backup superblock.
    +Please reset with mount -o sunit=<value>,swidth=<value> if necessary

Update the filter to catch both cases and output the old message so
tests pass again.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/repair | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/repair b/common/repair
index 46ca9e0..a157580 100644
--- a/common/repair
+++ b/common/repair
@@ -85,6 +85,9 @@ s/\s+- \d+:\d\d:\d\d:.*\n//g;
 /^agfl has bad CRC/ && next;
 # finobt enabled filesystem output
 s/(inode chunk) (\d+)\/(\d+)/AGNO\/INO/;
+# sunit/swidth reset messages
+s/^(Note - .*) were copied.*/\1 fields have been reset./;
+s/^(Please) reset (with .*) if necessary/\1 set \2/;
 	print;'
 }
 
-- 
2.0.0

