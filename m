Received: from mail-wm0-f68.google.com ([74.125.82.68]:36688 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752052AbdIETK5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Sep 2017 15:10:57 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v3 04/13] fsx: add support for writing constant instead of random data
Date: Tue,  5 Sep 2017 22:11:11 +0300
Message-Id: <1504638680-25682-5-git-send-email-amir73il@gmail.com>
In-Reply-To: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
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
index 85fd50a..3510ace 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -132,6 +132,7 @@ unsigned long	simulatedopcount = 0;	/* -b flag */
 int	closeprob = 0;			/* -c flag */
 int	debug = 0;			/* -d flag */
 unsigned long	debugstart = 0;		/* -D flag */
+char	filldata = 0;			/* -g flag */
 int	logid = 0;			/* -j flag */
 int	flush = 0;			/* -f flag */
 int	do_fsync = 0;			/* -y flag */
@@ -814,9 +815,13 @@ void
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
@@ -1631,11 +1636,12 @@ void
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
 	-j logid: prefix logs with this id\n\
 	-l flen: the upper bound on file size (default 262144)\n\
@@ -1873,7 +1879,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "b:c:dfi:j:l:m:no:p:qr:s:t:w:xyAD:FKHzCILN:OP:RS:WZ",
+				 "b:c:dfg:i:j:l:m:no:p:qr:s:t:w:xyAD:FKHzCILN:OP:RS:WZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -1900,6 +1906,9 @@ main(int argc, char **argv)
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

