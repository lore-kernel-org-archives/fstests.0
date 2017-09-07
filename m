Received: from mail-wr0-f193.google.com ([209.85.128.193]:38579 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdIGH0P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 03:26:15 -0400
Received: by mail-wr0-f193.google.com with SMTP id p37so1897496wrb.5
        for <fstests@vger.kernel.org>; Thu, 07 Sep 2017 00:26:14 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 3/5] fsx: add support for recording operations to a file
Date: Thu,  7 Sep 2017 10:26:36 +0300
Message-Id: <1504769198-4921-4-git-send-email-amir73il@gmail.com>
In-Reply-To: <1504769198-4921-1-git-send-email-amir73il@gmail.com>
References: <1504769198-4921-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
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
index 4e733f9..67d76dc 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -180,6 +180,7 @@ int aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset);
 #endif
 
 const char *replayops = NULL;
+const char *recordops = NULL;
 FILE *	fsxlogf = NULL;
 FILE *	replayopsf = NULL;
 char opsfile[1024];
@@ -1676,6 +1677,8 @@ usage(void)
 	-W: mapped write operations DISabled\n\
         -R: read() system calls only (mapped reads disabled)\n\
         -Z: O_DIRECT (use -R, -W, -r and -w too)\n\
+	--replay-ops opsfile: replay ops from recorded .fsxops file\n\
+	--record-ops[=opsfile]: dump ops file also on success. optionally specify ops file name\n\
 	fname: this filename is REQUIRED (no default)\n");
 	exit(90);
 }
@@ -1844,6 +1847,7 @@ __test_fallocate(int mode, const char *mode_str)
 
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

