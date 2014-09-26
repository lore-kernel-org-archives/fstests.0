Return-Path: <fstests-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44327 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbaIZNFi (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 26 Sep 2014 09:05:38 -0400
Received: from hch by bombadil.infradead.org with local (Exim 4.80.1 #2 (Red Hat Linux))
	id 1XXVDO-0004Lt-BP
	for fstests@vger.kernel.org; Fri, 26 Sep 2014 13:05:38 +0000
Date: Fri, 26 Sep 2014 06:05:38 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] fstest: fix dumping of miscompare buffer
Message-ID: <20140926130538.GB9240@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When fstests finds a miscompare it tries to dump the corrupted
bytes from the buffer, but due to an incorrect comparism actully
dumps the correct part of it.

Signed-off-by: Christoph Hellwig <hch@lst.de>

diff --git a/src/fstest.c b/src/fstest.c
index 2e92fd8..f7e2d3e 100644
--- a/src/fstest.c
+++ b/src/fstest.c
@@ -73,7 +73,7 @@ static void check_buffer(uchar *buf, int loop, int child, int fnum, int ofs)
 		for (j=0;j<MIN(20, block_size-i);j++) {
 			printf("%02x ", buf[j+i]);
 		}
-		for (j=i;buf[j] == buf2[j] && j<block_size;j++) ;
+		for (j=i;buf[j] != buf2[j] && j<block_size;j++) ;
 		printf("Corruption length: %d\n", j - i);
 		printf("\n");
 		exit(1);
