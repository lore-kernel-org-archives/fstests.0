Received: from bombadil.infradead.org ([198.137.202.9]:48392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdAMQiU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Jan 2017 11:38:20 -0500
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1cS4rr-0001fJ-5S
        for fstests@vger.kernel.org; Fri, 13 Jan 2017 16:38:19 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] common/rc: use /bin/bash in _user_do()
Date: Fri, 13 Jan 2017 17:38:16 +0100
Message-Id: <1484325496-3995-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Without this the epressions in generic/256 will fail on a system
where /bin/sh is the Default (e.g. modern Debian versions).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 37d0fc8..63cabfd 100644
--- a/common/rc
+++ b/common/rc
@@ -1809,7 +1809,7 @@ _user_do()
 	then
 	echo $1 | /bin/bash "su $qa_user 2>&1" | _filter_user_do
     else
-	echo $1 | su $qa_user 2>&1 | _filter_user_do
+	echo $1 | su -s /bin/bash $qa_user 2>&1 | _filter_user_do
     fi
 }
 
-- 
2.1.4

