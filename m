Received: from mail-wr0-f193.google.com ([209.85.128.193]:38576 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbdIGH0O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 03:26:14 -0400
Received: by mail-wr0-f193.google.com with SMTP id p37so1897481wrb.5
        for <fstests@vger.kernel.org>; Thu, 07 Sep 2017 00:26:13 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 2/5] fsx: add optional logid prefix to log messages
Date: Thu,  7 Sep 2017 10:26:35 +0300
Message-Id: <1504769198-4921-3-git-send-email-amir73il@gmail.com>
In-Reply-To: <1504769198-4921-1-git-send-email-amir73il@gmail.com>
References: <1504769198-4921-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When redirecting the intermixed output of several fsx processes
to a single output file, it is usefull to prefix debug log messages
with a log id. Use fsx -j <logid> to define the log messages prefix.

Fix implementation of prt() function to avoid using a temp buffer
and convert some more printf() calls to use ptr() instead.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 ltp/fsx.c | 56 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index ac466ee..4e733f9 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -119,6 +119,7 @@ char	*temp_buf;			/* a pointer to the current data */
 char	*fname;				/* name of our test file */
 char	*bname;				/* basename of our test file */
 char	*logdev;			/* -i flag */
+char	*logid;				/* -j flag */
 char	dname[1024];			/* -P flag */
 int	dirpath = 0;			/* -P flag */
 int	fd;				/* fd for our test file */
@@ -195,13 +196,16 @@ static void *round_ptr_up(void *ptr, unsigned long align, unsigned long offset)
 }
 
 void
-vwarnc(int code, const char *fmt, va_list ap) {
-  fprintf(stderr, "fsx: ");
-  if (fmt != NULL) {
-	vfprintf(stderr, fmt, ap);
-	fprintf(stderr, ": ");
-  }
-  fprintf(stderr, "%s\n", strerror(code));
+vwarnc(int code, const char *fmt, va_list ap)
+{
+	if (logid)
+		fprintf(stderr, "%s: ", logid);
+	fprintf(stderr, "fsx: ");
+	if (fmt != NULL) {
+		vfprintf(stderr, fmt, ap);
+		fprintf(stderr, ": ");
+	}
+	fprintf(stderr, "%s\n", strerror(code));
 }
 
 void
@@ -212,20 +216,21 @@ warn(const char * fmt, ...)  {
 	va_end(ap);
 }
 
-#define BUF_SIZE 1024
-
 void
 prt(const char *fmt, ...)
 {
 	va_list args;
-	char buffer[BUF_SIZE];
 
+	if (logid)
+		fprintf(stdout, "%s: ", logid);
 	va_start(args, fmt);
-	vsnprintf(buffer, BUF_SIZE, fmt, args);
+	vfprintf(stdout, fmt, args);
 	va_end(args);
-	fprintf(stdout, "%s", buffer);
-	if (fsxlogf)
-		fprintf(fsxlogf, "%s", buffer);
+	if (fsxlogf) {
+		va_start(args, fmt);
+		vfprintf(fsxlogf, fmt, args);
+		va_end(args);
+	}
 }
 
 void
@@ -1624,12 +1629,13 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dnqxAFLOWZ] [-b opnum] [-c Prob] [-i logdev] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
+		"fsx [-dnqxAFLOWZ] [-b opnum] [-c Prob] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
 	-f flush and invalidate cache after I/O\n\
 	-i logdev: do integrity testing, logdev is the dm log writes device\n\
+	-j logid: prefix debug log messsages with this id\n\
 	-l flen: the upper bound on file size (default 262144)\n\
 	-m startop:endop: monitor (print debug output) specified byte range (default 0:infinity)\n\
 	-n: no verifications of file size\n\
@@ -1862,14 +1868,13 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "b:c:dfi:l:m:no:p:qr:s:t:w:xyAD:FKHzCILN:OP:RS:WZ",
+				 "b:c:dfi:j:l:m:no:p:qr:s:t:w:xyAD:FKHzCILN:OP:RS:WZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
 			simulatedopcount = getnum(optarg, &endp);
 			if (!quiet)
-				fprintf(stdout, "Will begin at operation %ld\n",
-					simulatedopcount);
+				prt("Will begin at operation %ld\n", simulatedopcount);
 			if (simulatedopcount == 0)
 				usage();
 			simulatedopcount -= 1;
@@ -1877,9 +1882,7 @@ main(int argc, char **argv)
 		case 'c':
 			closeprob = getnum(optarg, &endp);
 			if (!quiet)
-				fprintf(stdout,
-					"Chance of close/open is 1 in %d\n",
-					closeprob);
+				prt("Chance of close/open is 1 in %d\n", closeprob);
 			if (closeprob <= 0)
 				usage();
 			break;
@@ -1897,6 +1900,13 @@ main(int argc, char **argv)
 				exit(101);
 			}
 			break;
+		case 'j':
+			logid = strdup(optarg);
+			if (!logid) {
+				prterr("strdup");
+				exit(101);
+			}
+			break;
 		case 'l':
 			maxfilelen = getnum(optarg, &endp);
 			if (maxfilelen <= 0)
@@ -2012,14 +2022,14 @@ main(int argc, char **argv)
 				seed += (int)getpid();
 			}
 			if (!quiet)
-				fprintf(stdout, "Seed set to %d\n", seed);
+				prt("Seed set to %d\n", seed);
 			if (seed < 0)
 				usage();
 			break;
 		case 'W':
 		        mapped_writes = 0;
 			if (!quiet)
-				fprintf(stdout, "mapped writes DISABLED\n");
+				prt("mapped writes DISABLED\n");
 			break;
 		case 'Z':
 			o_direct = O_DIRECT;
-- 
2.7.4

