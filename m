Return-Path: <fstests-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:42922 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbaIZNEa (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 26 Sep 2014 09:04:30 -0400
Received: from hch by bombadil.infradead.org with local (Exim 4.80.1 #2 (Red Hat Linux))
	id 1XXVCI-0002me-1a
	for fstests@vger.kernel.org; Fri, 26 Sep 2014 13:04:30 +0000
Date: Fri, 26 Sep 2014 06:04:30 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] fsx: increase number of logged operations
Message-ID: <20140926130430.GA9240@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

1000 operations is nearly enough to debug complex data integrity
issues, so increase the log buffer by an order of magnitude.

Signed-off-by: Christoph Hellwig <hch@lst.de>

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 47d3ee8..3709419 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -49,7 +49,7 @@ struct log_entry {
 	int	args[3];
 };
 
-#define	LOGSIZE	1000
+#define	LOGSIZE	10000
 
 struct log_entry	oplog[LOGSIZE];	/* the log */
 int			logptr = 0;	/* current position in log */
