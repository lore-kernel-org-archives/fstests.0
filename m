Received: from bombadil.infradead.org ([198.137.202.9]:41237 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966513AbcKLQsu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Nov 2016 11:48:50 -0500
Received: from hch by bombadil.infradead.org with local (Exim 4.85_2 #1 (Red Hat Linux))
        id 1c5bU1-0004oS-NR
        for fstests@vger.kernel.org; Sat, 12 Nov 2016 16:48:49 +0000
Date: Sat, 12 Nov 2016 08:48:49 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: fstests: fix fsx fallocate error messages
Message-ID: <20161112164849.GB18127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Many of the commands using fallocate had an extra % at the beggining
of the error messages, missed the 0x prefix for hex output and printed
the length where it should print the end of the region.

Signed-off-by: Christoph Hellwig <hch@lst.de>

diff --git a/ltp/fsx.c b/ltp/fsx.c
index ebe8ecf..74a3b74 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -964,7 +964,7 @@ do_punch_hole(unsigned offset, unsigned length)
 			offset, offset+length, length);
 	}
 	if (fallocate(fd, mode, (loff_t)offset, (loff_t)length) == -1) {
-		prt("%punch hole: %x to %x\n", offset, length);
+		prt("punch hole: 0x%x to 0x%x\n", offset, offset + length);
 		prterr("do_punch_hole: fallocate");
 		report_failure(161);
 	}
@@ -1026,7 +1026,7 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
 			offset, offset+length, length);
 	}
 	if (fallocate(fd, mode, (loff_t)offset, (loff_t)length) == -1) {
-		prt("%pzero range: %x to %x\n", offset, length);
+		prt("zero range: 0x%x to 0x%x\n", offset, offset + length);
 		prterr("do_zero_range: fallocate");
 		report_failure(161);
 	}
@@ -1076,7 +1076,7 @@ do_collapse_range(unsigned offset, unsigned length)
 			offset, offset+length, length);
 	}
 	if (fallocate(fd, mode, (loff_t)offset, (loff_t)length) == -1) {
-		prt("collapse range: %x to %x\n", offset, length);
+		prt("collapse range: 0x%x to 0x%x\n", offset, offset + length);
 		prterr("do_collapse_range: fallocate");
 		report_failure(161);
 	}
@@ -1128,7 +1128,7 @@ do_insert_range(unsigned offset, unsigned length)
 			offset, offset+length, length);
 	}
 	if (fallocate(fd, mode, (loff_t)offset, (loff_t)length) == -1) {
-		prt("insert range: %x to %x\n", offset, length);
+		prt("insert range: 0x%x to 0x%x\n", offset, offset + length);
 		prterr("do_insert_range: fallocate");
 		report_failure(161);
 	}
@@ -1193,7 +1193,7 @@ do_preallocate(unsigned offset, unsigned length, int keep_size)
 		prt("%lu falloc\tfrom 0x%x to 0x%x (0x%x bytes)\n", testcalls,
 				offset, offset + length, length);
 	if (fallocate(fd, keep_size ? FALLOC_FL_KEEP_SIZE : 0, (loff_t)offset, (loff_t)length) == -1) {
-	        prt("fallocate: %x to %x\n", offset, length);
+	        prt("fallocate: 0x%x to 0x%x\n", offset, offset + length);
 		prterr("do_preallocate: fallocate");
 		report_failure(161);
 	}
