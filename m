Received: from mx2.suse.de ([195.135.220.15]:46346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729870AbfAUQdp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 11:33:45 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82B49AFB8
        for <fstests@vger.kernel.org>; Mon, 21 Jan 2019 16:33:44 +0000 (UTC)
From: jeffm@suse.com
Subject: [PATCH 2/7] filter: fix assumed whitespace in _filefrag_filter regex
Date: Mon, 21 Jan 2019 11:33:11 -0500
Message-Id: <20190121163316.20616-2-jeffm@suse.com>
In-Reply-To: <20190121163316.20616-1-jeffm@suse.com>
References: <20190121163316.20616-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

The regex assumes there will be whitespace after the .. in the ranges
and, with larger offsets, there may not be any.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 common/filter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/filter b/common/filter
index ed082d24..b4443a34 100644
--- a/common/filter
+++ b/common/filter
@@ -532,7 +532,7 @@ _filter_filefrag()
 		next
 	}
 	($ext, $logical, $physical, $length) =
-		(/^\s*(\d+):\s+(\d+)..\s+\d+:\s+(\d+)..\s+\d+:\s+(\d+):/)
+		(/^\s*(\d+):\s+(\d+)\.\.\s*\d+:\s+(\d+)\.\.\s*\d+:\s+(\d+):/)
 	or next;
 	($flags) = /.*:\s*(\S*)$/;
 	print $physical * $blocksize, "#",
-- 
2.16.4
