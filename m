Received: from bombadil.infradead.org ([198.137.202.9]:54893 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbcFNPIS (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 14 Jun 2016 11:08:18 -0400
Received: from [83.175.99.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1bCpwv-0003sL-MB
	for fstests@vger.kernel.org; Tue, 14 Jun 2016 15:08:18 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] generic/346: add to the quick and rw groups
Date: Tue, 14 Jun 2016 17:08:09 +0200
Message-Id: <1465916890-28135-2-git-send-email-hch@lst.de>
In-Reply-To: <1465916890-28135-1-git-send-email-hch@lst.de>
References: <1465916890-28135-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The test runs quickly and covers code not covered by any other test, so add
it to the quick group.  Also add it to the rw group while we're at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index 36fb759..217ffaa 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -348,7 +348,7 @@
 343 auto quick metadata
 344 auto
 345 auto
-346 auto
+346 auto quick rw
 347 auto quick rw thin
 348 auto quick metadata
 349 blockdev quick rw
-- 
2.1.4

