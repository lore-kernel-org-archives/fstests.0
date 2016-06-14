Received: from bombadil.infradead.org ([198.137.202.9]:54961 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcFNPI0 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 14 Jun 2016 11:08:26 -0400
Received: from [83.175.99.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1bCpwy-0003uA-Oa
	for fstests@vger.kernel.org; Tue, 14 Jun 2016 15:08:21 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] generic/042: add to auto group
Date: Tue, 14 Jun 2016 17:08:10 +0200
Message-Id: <1465916890-28135-3-git-send-email-hch@lst.de>
In-Reply-To: <1465916890-28135-1-git-send-email-hch@lst.de>
References: <1465916890-28135-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an odd one as it's in the quick group but not the auto one.
And it actually fails on XFS for me..

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index 217ffaa..2daff9f 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -44,7 +44,7 @@
 039 metadata auto quick
 040 metadata auto quick
 041 metadata auto quick
-042 quick rw
+042 auto quick rw
 043 metadata log auto
 044 metadata log auto
 045 metadata log auto
-- 
2.1.4

