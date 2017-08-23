Received: from mail-wm0-f65.google.com ([74.125.82.65]:34377 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932277AbdHWPs5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2017 11:48:57 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [RFC][PATCH 5/8] fsx: add support for integrity check with dm-log-writes target
Date: Wed, 23 Aug 2017 18:49:14 +0300
Message-Id: <1503503357-26234-6-git-send-email-amir73il@gmail.com>
In-Reply-To: <1503503357-26234-1-git-send-email-amir73il@gmail.com>
References: <1503503357-26234-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Cherry-picked the relevant fsx bits from commit 70d41e17164b
in Josef Bacik's fstests tree (https://github.com/josefbacik/fstests).
Quoting from Josef's commit message:

  I've rigged up fsx to have an integrity check mode.  Basically it works
  like it normally works, but when it fsync()'s it marks the log with a
  unique mark and dumps it's buffer to a file with the mark in the filename.
  I did this with a system() call simply because it was the fastest.  I can
  link the device-mapper libraries and do it programatically if that would
  be preferred, but this works pretty well.

  Signed-off-by: Josef Bacik <jbacik@fb.com>

[Amir:]
- Fix some exit codes
- Require -P dirpath for -i logdev

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 ltp/fsx.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 120 insertions(+), 22 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 1502905..7e9713e 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -67,15 +67,17 @@ int			logcount = 0;	/* total ops */
  * be careful in how we select the different operations. The active operations
  * are mapped to numbers as follows:
  *
- *		lite	!lite
- * READ:	0	0
- * WRITE:	1	1
- * MAPREAD:	2	2
- * MAPWRITE:	3	3
- * TRUNCATE:	-	4
- * FALLOCATE:	-	5
- * PUNCH HOLE:	-	6
- * ZERO RANGE:	-	7
+ *			lite	!lite	integrity
+ * READ:		0	0	0
+ * WRITE:		1	1	1
+ * MAPREAD:		2	2	2
+ * MAPWRITE:		3	3	3
+ * TRUNCATE:		-	4	4
+ * FALLOCATE:		-	5	5
+ * PUNCH HOLE:		-	6	6
+ * ZERO RANGE:		-	7	7
+ * COLLAPSE RANGE:	-	8	8
+ * FSYNC:		-	-	9
  *
  * When mapped read/writes are disabled, they are simply converted to normal
  * reads and writes. When fallocate/fpunch calls are disabled, they are
@@ -102,6 +104,10 @@ int			logcount = 0;	/* total ops */
 #define OP_INSERT_RANGE	9
 #define OP_MAX_FULL		10
 
+/* integrity operations */
+#define OP_FSYNC		10
+#define OP_MAX_INTEGRITY	11
+
 #undef PAGE_SIZE
 #define PAGE_SIZE       getpagesize()
 #undef PAGE_MASK
@@ -111,6 +117,9 @@ char	*original_buf;			/* a pointer to the original data */
 char	*good_buf;			/* a pointer to the correct data */
 char	*temp_buf;			/* a pointer to the current data */
 char	*fname;				/* name of our test file */
+char	*bname;				/* basename of our test file */
+char	*logdev;			/* -i flag */
+char	dname[1024];			/* -P flag */
 int	fd;				/* fd for our test file */
 
 blksize_t	block_size = 0;
@@ -148,9 +157,11 @@ int     zero_range_calls = 1;           /* -z flag disables */
 int	collapse_range_calls = 1;	/* -C flag disables */
 int	insert_range_calls = 1;		/* -I flag disables */
 int 	mapped_reads = 1;		/* -R flag disables it */
+int	integrity = 0;			/* -i flag */
 int	fsxgoodfd = 0;
 int	o_direct;			/* -Z */
 int	aio = 0;
+int	mark_nr = 0;
 
 int page_size;
 int page_mask;
@@ -397,6 +408,9 @@ logdump(void)
 			if (overlap)
 				prt("\t******IIII");
 			break;
+		case OP_FSYNC:
+			prt("FSYNC");
+			break;
 		default:
 			prt("BOGUS LOG ENTRY (operation code = %d)!",
 			    lp->operation);
@@ -500,6 +514,42 @@ report_failure(int status)
 				        *(((unsigned char *)(cp)) + 1)))
 
 void
+mark_log(void)
+{
+	char command[256];
+	int ret;
+
+	snprintf(command, 256, "dmsetup message %s 0 mark %s.mark%d", logdev,
+		 bname, mark_nr);
+	ret = system(command);
+	if (ret) {
+		prterr("dmsetup mark failed");
+		exit(101);
+	}
+}
+
+void
+dump_fsync_buffer(void)
+{
+	char fname_buffer[1024];
+	int good_fd;
+
+	if (!good_buf)
+		return;
+
+	snprintf(fname_buffer, 1024, "%s%s.mark%d", dname,
+		 bname, mark_nr);
+	good_fd = open(fname_buffer, O_WRONLY|O_CREAT|O_TRUNC, 0666);
+	if (good_fd < 0) {
+		prterr(fname_buffer);
+		exit(102);
+	}
+
+	save_buffer(good_buf, file_size, good_fd);
+	close(good_fd);
+}
+
+void
 check_buffers(unsigned offset, unsigned size)
 {
 	unsigned char c, t;
@@ -1250,6 +1300,26 @@ docloseopen(void)
 	}
 }
 
+void
+dofsync(void)
+{
+	int ret;
+
+	if (testcalls <= simulatedopcount)
+		return;
+	if (debug)
+		prt("%lu fsync\n", testcalls);
+	log4(OP_FSYNC, 0, 0, 0);
+	ret = fsync(fd);
+	if (ret < 0) {
+		prterr("dofsync");
+		report_failure(190);
+	}
+	mark_log();
+	dump_fsync_buffer();
+	printf("Dumped fsync buffer mark %d\n", mark_nr);
+	mark_nr++;
+}
 
 #define TRIM_OFF(off, size)			\
 do {						\
@@ -1397,8 +1467,10 @@ test(void)
 	/* calculate appropriate op to run */
 	if (lite)
 		op = rv % OP_MAX_LITE;
-	else
+	else if (!integrity)
 		op = rv % OP_MAX_FULL;
+	else
+		op = rv % OP_MAX_INTEGRITY;
 
 	switch(op) {
 	case OP_TRUNCATE:
@@ -1522,6 +1594,9 @@ have_op:
 
 		do_insert_range(offset, size);
 		break;
+	case OP_FSYNC:
+		dofsync();
+		break;
 	default:
 		prterr("test: unknown operation");
 		report_failure(42);
@@ -1541,7 +1616,7 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dnqxAFLOWZ] [-b opnum] [-c Prob] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
+		"fsx [-dnqxAFLOWZ] [-b opnum] [-c Prob] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] [-i logdev] fname\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
@@ -1586,6 +1661,7 @@ usage(void)
 	-W: mapped write operations DISabled\n\
         -R: read() system calls only (mapped reads disabled)\n\
         -Z: O_DIRECT (use -R, -W, -r and -w too)\n\
+	-i logdev: do integrity testing, logdev is the dm log writes device\n\
 	fname: this filename is REQUIRED (no default)\n");
 	exit(90);
 }
@@ -1758,7 +1834,7 @@ int
 main(int argc, char **argv)
 {
 	int	i, style, ch;
-	char	*endp;
+	char	*endp, *tmp;
 	char goodfile[1024];
 	char logfile[1024];
 	int dirpath = 0;
@@ -1766,6 +1842,7 @@ main(int argc, char **argv)
 
 	goodfile[0] = 0;
 	logfile[0] = 0;
+	dname[0] = 0;
 
 	page_size = getpagesize();
 	page_mask = page_size - 1;
@@ -1775,7 +1852,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "b:c:dfl:m:no:p:qr:s:t:w:xyAD:FKHzCILN:OP:RS:WZ",
+				 "b:c:dfl:m:no:p:qr:s:t:w:xyAD:FKHzCILN:OP:RS:WZi:",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -1899,13 +1976,13 @@ main(int argc, char **argv)
 			randomoplen = 0;
 			break;
 		case 'P':
-			strncpy(goodfile, optarg, sizeof(goodfile));
-			strcat(goodfile, "/");
-			strncpy(logfile, optarg, sizeof(logfile));
-			strcat(logfile, "/");
-			strncpy(opsfile, optarg, sizeof(logfile));
-			strcat(opsfile, "/");
+			strncpy(dname, optarg, sizeof(dname));
+			strcat(dname, "/");
 			dirpath = 1;
+
+			strncpy(goodfile, dname, sizeof(goodfile));
+			strncpy(logfile, dname, sizeof(logfile));
+			strncpy(opsfile, dname, sizeof(logfile));
 			break;
                 case 'R':
                         mapped_reads = 0;
@@ -1929,6 +2006,14 @@ main(int argc, char **argv)
 		case 'Z':
 			o_direct = O_DIRECT;
 			break;
+		case 'i':
+			integrity = 1;
+			logdev = strdup(optarg);
+			if (!logdev) {
+				prterr("strdup");
+				exit(99);
+			}
+			break;
 		case 256:  /* --replay-ops */
 			replayops = optarg;
 			break;
@@ -1940,7 +2025,19 @@ main(int argc, char **argv)
 	argv += optind;
 	if (argc != 1)
 		usage();
+
+	if (integrity && !dirpath) {
+		fprintf(stderr, "option -i <logdev> requires -P <dirpath>\n");
+		usage();
+	}
+
 	fname = argv[0];
+	tmp = strdup(fname);
+	if (!tmp) {
+		prterr("strdup");
+		exit(99);
+	}
+	bname = basename(tmp);
 
 	signal(SIGHUP,	cleanup);
 	signal(SIGINT,	cleanup);
@@ -1982,21 +2079,21 @@ main(int argc, char **argv)
 		}
 	}
 #endif
-	strncat(goodfile, dirpath ? basename(fname) : fname, 256);
+	strncat(goodfile, dirpath ? bname : fname, 256);
 	strcat (goodfile, ".fsxgood");
 	fsxgoodfd = open(goodfile, O_RDWR|O_CREAT|O_TRUNC, 0666);
 	if (fsxgoodfd < 0) {
 		prterr(goodfile);
 		exit(92);
 	}
-	strncat(logfile, dirpath ? basename(fname) : fname, 256);
+	strncat(logfile, dirpath ? bname : fname, 256);
 	strcat (logfile, ".fsxlog");
 	fsxlogf = fopen(logfile, "w");
 	if (fsxlogf == NULL) {
 		prterr(logfile);
 		exit(93);
 	}
-	strncat(opsfile, dirpath ? basename(fname) : fname, 256);
+	strncat(opsfile, dirpath ? bname : fname, 256);
 	strcat(opsfile, ".fsxops");
 	unlink(opsfile);
 
@@ -2072,6 +2169,7 @@ main(int argc, char **argv)
 		if (!test())
 			break;
 
+	free(tmp);
 	if (close(fd)) {
 		prterr("close");
 		report_failure(99);
-- 
2.7.4

