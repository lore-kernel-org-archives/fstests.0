Received: from mx2.suse.de ([195.135.220.15]:57884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbfC1Kv2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Mar 2019 06:51:28 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4A0BBAA3
        for <fstests@vger.kernel.org>; Thu, 28 Mar 2019 10:51:27 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH] Fix fsx errors due to unsupported FIDEDUPERANGE
Date: Thu, 28 Mar 2019 11:51:19 +0100
Message-Id: <20190328105119.31257-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Older kernels (prior commit 494633fac7896 "vfs: vfs_dedupe_file_range()
doesn't return EOPNOTSUPP") will return EINVAL when operation is not
supported. Make fsx treat this error as a sign of unsupported
deduplication as well to make it usable with these older kernels.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 ltp/fsx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index f4a1c7cf820b..391824bfbc68 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1482,7 +1482,8 @@ test_dedupe_range(void)
 	else
 		error = 0;
 
-	if (error == EOPNOTSUPP || error == ENOTTY) {
+	/* Older kernels may return EINVAL... */
+	if (error == EOPNOTSUPP || error == ENOTTY || error == EINVAL) {
 		if (!quiet)
 			fprintf(stderr,
 				"main: filesystem does not support "
-- 
2.16.4
