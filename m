Received: from mx2.suse.de ([195.135.220.15]:46336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730171AbfAUQdo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 11:33:44 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83757AFB5
        for <fstests@vger.kernel.org>; Mon, 21 Jan 2019 16:33:43 +0000 (UTC)
From: jeffm@suse.com
Subject: [PATCH 3/7] filter: add support for old filefrag -v
Date: Mon, 21 Jan 2019 11:33:12 -0500
Message-Id: <20190121163316.20616-3-jeffm@suse.com>
In-Reply-To: <20190121163316.20616-1-jeffm@suse.com>
References: <20190121163316.20616-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

e2fsprogs versions prior to v1.42.7 had a different format for
filefrag -v that is incompatible with the regex in _filefrag_filter.

This patch adds support for the older format to test on older releases

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 common/filter | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/common/filter b/common/filter
index b4443a34..a8ddf571 100644
--- a/common/filter
+++ b/common/filter
@@ -528,13 +528,27 @@ _filter_filefrag()
 {
 	perl -ne '
 	if (/blocks? of (\d+) bytes/) {
+		$oldfmt = 0;
 		$blocksize = $1;
-		next
+		next;
+	} elsif (/\d+ blocks, blocksize (\d+)/) {
+		$oldfmt = 1;
+		$blocksize = $1;
+		next;
+	}
+	if ($oldfmt) {
+		chomp;
+		($ext, $logical, $physical, $ignore, $length1, $length2, $flags) =
+			(/^\s*(\d+)\s+(\d+)\s+(\d+)\s+((\d+)|\d+\s+(\d+))\s+([a-z0-9,]*)$/)
+		or next;
+		$length = "$length1$length2";
+	} else {
+		($ext, $logical, $physical, $length) =
+			(/^\s*(\d+):\s+(\d+)\.\.\s*\d+:\s+(\d+)\.\.\s*\d+:\s+(\d+):/)
+		or next;
+		($flags) = /.*:\s*(\S*)$/;
 	}
-	($ext, $logical, $physical, $length) =
-		(/^\s*(\d+):\s+(\d+)\.\.\s*\d+:\s+(\d+)\.\.\s*\d+:\s+(\d+):/)
-	or next;
-	($flags) = /.*:\s*(\S*)$/;
+
 	print $physical * $blocksize, "#",
 	      $length * $blocksize, "#",
 	      $logical * $blocksize, "#",
-- 
2.16.4
