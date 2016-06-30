Received: from bombadil.infradead.org ([198.137.202.9]:44470 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbcF3HEE (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2016 03:04:04 -0400
Received: from 213162068074.public.t-mobile.at ([213.162.68.74] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.85_2 #1 (Red Hat Linux))
	id 1bIW15-0000Lr-41
	for fstests@vger.kernel.org; Thu, 30 Jun 2016 07:04:03 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] generic/042: remove from quick group
Date: Thu, 30 Jun 2016 09:03:58 +0200
Message-Id: <1467270238-28429-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This test has been removed from the auto group because it fails without
an expected fix.  Remove it from the quick group as well, as the quick
group should be a subset of the auto group.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index 7491282..d320d8e 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -44,7 +44,7 @@
 039 metadata auto quick
 040 metadata auto quick
 041 metadata auto quick
-042 quick rw
+042 rw
 043 metadata log auto
 044 metadata log auto
 045 metadata log auto
-- 
2.1.4

