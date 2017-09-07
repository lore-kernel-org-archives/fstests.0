Received: from mail-wm0-f66.google.com ([74.125.82.66]:36931 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbdIGH0Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 03:26:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id f4so756042wmh.4
        for <fstests@vger.kernel.org>; Thu, 07 Sep 2017 00:26:15 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 4/5] fsx: add support for writing constant instead of random data
Date: Thu,  7 Sep 2017 10:26:37 +0300
Message-Id: <1504769198-4921-5-git-send-email-amir73il@gmail.com>
In-Reply-To: <1504769198-4921-1-git-send-email-amir73il@gmail.com>
References: <1504769198-4921-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

-g X: write character X instead of random generated data

This is useful to compare holes between good and bad files
because hexdump of good and bad files compacts the contigious
ranges of X and zeroes.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 ltp/fsx.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 67d76dc..fd00962 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -133,6 +133,7 @@ unsigned long	simulatedopcount = 0;	/* -b flag */
 int	closeprob = 0;			/* -c flag */
 int	debug = 0;			/* -d flag */
 unsigned long	debugstart = 0;		/* -D flag */
+char	filldata = 0;			/* -g flag */
 int	flush = 0;			/* -f flag */
 int	do_fsync = 0;			/* -y flag */
 unsigned long	maxfilelen = 256 * 1024;	/* -l flag */
@@ -813,9 +814,13 @@ void
 gendata(char *original_buf, char *good_buf, unsigned offset, unsigned size)
 {
 	while (size--) {
-		good_buf[offset] = testcalls % 256; 
-		if (offset % 2)
-			good_buf[offset] += original_buf[offset];
+		if (filldata) {
+			good_buf[offset] = filldata;
+		} else {
+			good_buf[offset] = testcalls % 256;
+			if (offset % 2)
+				good_buf[offset] += original_buf[offset];
+		}
 		offset++;
 	}
 }
@@ -1630,11 +1635,12 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dnqxAFLOWZ] [-b opnum] [-c Prob] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
+		"fsx [-dnqxAFLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
 	-f flush and invalidate cache after I/O\n\
+	-g X: write character X instead of random generated data\n\
 	-i logdev: do integrity testing, logdev is the dm log writes device\n\
 	-j logid: prefix debug log messsages with this id\n\
 	-l flen: the upper bound on file size (default 262144)\n\
@@ -1872,7 +1878,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "b:c:dfi:j:l:m:no:p:qr:s:t:w:xyAD:FKHzCILN:OP:RS:WZ",
+				 "b:c:dfg:i:j:l:m:no:p:qr:s:t:w:xyAD:FKHzCILN:OP:RS:WZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -1896,6 +1902,9 @@ main(int argc, char **argv)
 		case 'f':
 			flush = 1;
 			break;
+		case 'g':
+			filldata = *optarg;
+			break;
 		case 'i':
 			integrity = 1;
 			logdev = strdup(optarg);
-- 
2.7.4

