Received: from mx1.redhat.com ([209.132.183.28]:57208 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933011AbbLVUyO (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 22 Dec 2015 15:54:14 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id CAD075375
	for <fstests@vger.kernel.org>; Tue, 22 Dec 2015 20:54:14 +0000 (UTC)
Received: from schleppi.home.com (vpn1-6-224.ams2.redhat.com [10.36.6.224])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tBMKs3S8007345
	for <fstests@vger.kernel.org>; Tue, 22 Dec 2015 15:54:13 -0500
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 4/6] fsx: Generate test parameters in test()
Date: Tue, 22 Dec 2015 21:53:54 +0100
Message-Id: <1450817636-11416-5-git-send-email-agruenba@redhat.com>
In-Reply-To: <1450817636-11416-1-git-send-email-agruenba@redhat.com>
References: <1450817636-11416-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Generate all test parameters in test(), including keep_size.

The code is slightly more complicated than it could be to produce the
same sequence of operations for the same random seed.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 ltp/fsx.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 0f4c49e..5385ed3 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -914,11 +914,10 @@ do_punch_hole(unsigned offset, unsigned length)
 
 #ifdef FALLOC_FL_ZERO_RANGE
 void
-do_zero_range(unsigned offset, unsigned length)
+do_zero_range(unsigned offset, unsigned length, int keep_size)
 {
 	unsigned end_offset;
 	int mode = FALLOC_FL_ZERO_RANGE;
-	int keep_size = 0;
 
 	if (length == 0) {
 		if (!quiet && testcalls > simulatedopcount)
@@ -927,9 +926,6 @@ do_zero_range(unsigned offset, unsigned length)
 		return;
 	}
 
-	if (keep_size_calls)
-		keep_size = random() % 2;
-
 	end_offset = keep_size ? 0 : offset + length;
 
 	if (end_offset > biggest) {
@@ -966,7 +962,7 @@ do_zero_range(unsigned offset, unsigned length)
 
 #else
 void
-do_zero_range(unsigned offset, unsigned length)
+do_zero_range(unsigned offset, unsigned length, int keep_size)
 {
 	return;
 }
@@ -1080,10 +1076,9 @@ do_insert_range(unsigned offset, unsigned length)
 #ifdef HAVE_LINUX_FALLOC_H
 /* fallocate is basically a no-op unless extending, then a lot like a truncate */
 void
-do_preallocate(unsigned offset, unsigned length)
+do_preallocate(unsigned offset, unsigned length, int keep_size)
 {
 	unsigned end_offset;
-	int keep_size = 0;
 
         if (length == 0) {
                 if (!quiet && testcalls > simulatedopcount)
@@ -1092,9 +1087,6 @@ do_preallocate(unsigned offset, unsigned length)
                 return;
         }
 
-	if (keep_size_calls)
-		keep_size = random() % 2;
-
 	end_offset = keep_size ? 0 : offset + length;
 
 	if (end_offset > biggest) {
@@ -1132,7 +1124,7 @@ do_preallocate(unsigned offset, unsigned length)
 }
 #else
 void
-do_preallocate(unsigned offset, unsigned length)
+do_preallocate(unsigned offset, unsigned length, int keep_size)
 {
 	return;
 }
@@ -1211,6 +1203,7 @@ test(void)
 	unsigned long	size = maxoplen;
 	unsigned long	rv = random();
 	unsigned long	op;
+	int		keep_size = 0;
 
 	if (simulatedopcount > 0 && testcalls == simulatedopcount)
 		writefileimage();
@@ -1236,6 +1229,17 @@ test(void)
 	else
 		op = rv % OP_MAX_FULL;
 
+	switch(op) {
+	case OP_FALLOCATE:
+		if (fallocate_calls && size && keep_size_calls)
+			keep_size = random() % 2;
+		break;
+	case OP_ZERO_RANGE:
+		if (zero_range_calls && size && keep_size_calls)
+			keep_size = random() % 2;
+		break;
+	}
+
 	switch (op) {
 	case OP_MAPREAD:
 		if (!mapped_reads)
@@ -1306,7 +1310,7 @@ test(void)
 
 	case OP_FALLOCATE:
 		TRIM_OFF_LEN(offset, size, maxfilelen);
-		do_preallocate(offset, size);
+		do_preallocate(offset, size, keep_size);
 		break;
 
 	case OP_PUNCH_HOLE:
@@ -1315,7 +1319,7 @@ test(void)
 		break;
 	case OP_ZERO_RANGE:
 		TRIM_OFF_LEN(offset, size, file_size);
-		do_zero_range(offset, size);
+		do_zero_range(offset, size, keep_size);
 		break;
 	case OP_COLLAPSE_RANGE:
 		TRIM_OFF_LEN(offset, size, file_size - 1);
-- 
2.4.3

