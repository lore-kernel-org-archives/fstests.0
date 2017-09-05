Received: from mail-wm0-f67.google.com ([74.125.82.67]:34240 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdIETK6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Sep 2017 15:10:58 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v3 05/13] fsx: add support for keeping existing file
Date: Tue,  5 Sep 2017 22:11:12 +0300
Message-Id: <1504638680-25682-6-git-send-email-amir73il@gmail.com>
In-Reply-To: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

With fsxk -k, do not truncate existing file and use its size as upper
bound on file size.

This is needed to prevent fsx from truncating the file on start of
test when testing fsx on cloned files.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 ltp/fsx.c | 49 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 3510ace..7a34577 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -629,17 +629,18 @@ void
 check_trunc_hack(void)
 {
 	struct stat statbuf;
+	off_t offset = file_size + (off_t)100000;
 
-	if (ftruncate(fd, (off_t)0))
+	if (ftruncate(fd, file_size))
 		goto ftruncate_err;
-	if (ftruncate(fd, (off_t)100000))
+	if (ftruncate(fd, offset))
 		goto ftruncate_err;
 	fstat(fd, &statbuf);
-	if (statbuf.st_size != (off_t)100000) {
+	if (statbuf.st_size != offset) {
 		prt("no extend on truncate! not posix!\n");
 		exit(130);
 	}
-	if (ftruncate(fd, 0)) {
+	if (ftruncate(fd, file_size)) {
 ftruncate_err:
 		prterr("check_trunc_hack: ftruncate");
 		exit(131);
@@ -1636,7 +1637,7 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dnqxAFLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
+		"fsx [-dknqxAFLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
@@ -1644,6 +1645,7 @@ usage(void)
 	-g X: write character X instead of random generated data\n\
 	-i logdev: do integrity testing, logdev is the dm log writes device\n\
 	-j logid: prefix logs with this id\n\
+	-k: do not truncate existing file and use its size as upper bound on file size\n\
 	-l flen: the upper bound on file size (default 262144)\n\
 	-m startop:endop: monitor (print debug output) specified byte range (default 0:infinity)\n\
 	-n: no verifications of file size\n\
@@ -1834,7 +1836,7 @@ __test_fallocate(int mode, const char *mode_str)
 #ifdef HAVE_LINUX_FALLOC_H
 	int ret = 0;
 	if (!lite) {
-		if (fallocate(fd, mode, 0, 1) && errno == EOPNOTSUPP) {
+		if (fallocate(fd, mode, file_size, 1) && errno == EOPNOTSUPP) {
 			if(!quiet)
 				fprintf(stderr,
 					"main: filesystem does not support "
@@ -1842,7 +1844,7 @@ __test_fallocate(int mode, const char *mode_str)
 					mode_str);
 		} else {
 			ret = 1;
-			if (ftruncate(fd, 0)) {
+			if (ftruncate(fd, file_size)) {
 				warn("main: ftruncate");
 				exit(132);
 			}
@@ -1866,6 +1868,7 @@ main(int argc, char **argv)
 	char goodfile[1024];
 	char logfile[1024];
 	struct stat statbuf;
+	int o_flags = O_RDWR|O_CREAT|O_TRUNC;
 
 	goodfile[0] = 0;
 	logfile[0] = 0;
@@ -1879,7 +1882,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "b:c:dfg:i:j:l:m:no:p:qr:s:t:w:xyAD:FKHzCILN:OP:RS:WZ",
+				 "b:c:dfg:i:j:kl:m:no:p:qr:s:t:w:xyAD:FKHzCILN:OP:RS:WZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -1920,6 +1923,9 @@ main(int argc, char **argv)
 		case 'j':
 			logid = getnum(optarg, &endp);
 			break;
+		case 'k':
+			o_flags &= ~O_TRUNC;
+			break;
 		case 'l':
 			maxfilelen = getnum(optarg, &endp);
 			if (maxfilelen <= 0)
@@ -2007,6 +2013,7 @@ main(int argc, char **argv)
 			break;
 		case 'L':
 		        lite = 1;
+			o_flags &= ~(O_CREAT|O_TRUNC);
 			break;
 		case 'N':
 			numops = getnum(optarg, &endp);
@@ -2046,6 +2053,7 @@ main(int argc, char **argv)
 			break;
 		case 'Z':
 			o_direct = O_DIRECT;
+			o_flags |= O_DIRECT;
 			break;
 		case 255:  /* --record-ops */
 			if (optarg)
@@ -2089,8 +2097,7 @@ main(int argc, char **argv)
 	signal(SIGUSR2,	cleanup);
 
 	srandom(seed);
-	fd = open(fname,
-		O_RDWR|(lite ? 0 : O_CREAT|O_TRUNC)|o_direct, 0666);
+	fd = open(fname, o_flags, 0666);
 	if (fd < 0) {
 		prterr(fname);
 		exit(91);
@@ -2150,9 +2157,10 @@ main(int argc, char **argv)
 		aio_setup();
 #endif
 
-	if (lite) {
+	if (!(o_flags & O_TRUNC)) {
 		off_t ret;
-		file_size = maxfilelen = lseek(fd, (off_t)0, SEEK_END);
+		file_size = maxfilelen = biggest = lseek(fd, (off_t)0, SEEK_END);
+		printf("file_size=%lu\n", file_size);
 		if (file_size == (off_t)-1) {
 			prterr(fname);
 			warn("main: lseek eof");
@@ -2189,8 +2197,23 @@ main(int argc, char **argv)
 					maxfilelen);
 			exit(98);
 		}
-	} else 
+	} else {
+		ssize_t ret, len = file_size;
+		off_t off = 0;
+
+		while (len > 0) {
+			ret = read(fd, good_buf + off, len);
+			if (ret == -1) {
+				prterr(fname);
+				warn("main: error on read");
+				exit(98);
+			}
+			len -= ret;
+			off += ret;
+		}
+
 		check_trunc_hack();
+	}
 
 	if (fallocate_calls)
 		fallocate_calls = test_fallocate(0);
-- 
2.7.4

