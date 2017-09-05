Received: from mail-wr0-f194.google.com ([209.85.128.194]:37084 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbdIETKz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Sep 2017 15:10:55 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v3 03/13] fsx: add support for recording operations to a file
Date: Tue,  5 Sep 2017 22:11:10 +0300
Message-Id: <1504638680-25682-4-git-send-email-amir73il@gmail.com>
In-Reply-To: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Usually, fsx dumps an .fsxops file on failure with same basename
as work file and possibly under dirctory specified by -P dirpath.

The --record-ops[=opsfile] flag can be use to dump ops file also
on success and to optionally specify the ops file name.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 ltp/fsx.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 16684cc..85fd50a 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -180,6 +180,7 @@ int aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset);
 #endif
 
 const char *replayops = NULL;
+const char *recordops = NULL;
 FILE *	fsxlogf = NULL;
 FILE *	replayopsf = NULL;
 char opsfile[1024];
@@ -1677,6 +1678,8 @@ usage(void)
 	-W: mapped write operations DISabled\n\
         -R: read() system calls only (mapped reads disabled)\n\
         -Z: O_DIRECT (use -R, -W, -r and -w too)\n\
+	--replay-ops opsfile: replay ops from recorded .fsxops file\n\
+	--record-ops[=opsfile]: dump ops file also on success. optionally specify ops file name\n\
 	fname: this filename is REQUIRED (no default)\n");
 	exit(90);
 }
@@ -1845,6 +1848,7 @@ __test_fallocate(int mode, const char *mode_str)
 
 static struct option longopts[] = {
 	{"replay-ops", required_argument, 0, 256},
+	{"record-ops", optional_argument, 0, 255},
 	{ }
 };
 
@@ -2034,6 +2038,11 @@ main(int argc, char **argv)
 		case 'Z':
 			o_direct = O_DIRECT;
 			break;
+		case 255:  /* --record-ops */
+			if (optarg)
+				strncpy(opsfile, optarg, sizeof(opsfile));
+			recordops = opsfile;
+			break;
 		case 256:  /* --replay-ops */
 			replayops = optarg;
 			break;
@@ -2113,8 +2122,10 @@ main(int argc, char **argv)
 		prterr(logfile);
 		exit(93);
 	}
-	strncat(opsfile, dirpath ? bname : fname, 256);
-	strcat(opsfile, ".fsxops");
+	if (!*opsfile) {
+		strncat(opsfile, dirpath ? bname : fname, 256);
+		strcat(opsfile, ".fsxops");
+	}
 	unlink(opsfile);
 
 	if (replayops) {
@@ -2195,6 +2206,8 @@ main(int argc, char **argv)
 		report_failure(99);
 	}
 	prt("All %lu operations completed A-OK!\n", testcalls);
+	if (recordops)
+		logdump();
 
 	exit(0);
 	return 0;
-- 
2.7.4

