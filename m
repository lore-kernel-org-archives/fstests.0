Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751640AbeBUKzX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 21 Feb 2018 05:55:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B257C406E808
        for <fstests@vger.kernel.org>; Wed, 21 Feb 2018 10:55:22 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] fsx: Fix -P errors
Date: Wed, 21 Feb 2018 11:55:20 +0100
Message-Id: <20180221105520.1810-1-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

When -P is used, report the correct *.fsxgood filename in report_failure
and fix the default *.fsxops filename.
---
 ltp/fsx.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 9c358f27..ac9e9291 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -121,6 +121,7 @@ char	*bname;				/* basename of our test file */
 char	*logdev;			/* -i flag */
 char	*logid;				/* -j flag */
 char	dname[1024];			/* -P flag */
+char	goodfile[1024];
 int	dirpath = 0;			/* -P flag */
 int	fd;				/* fd for our test file */
 
@@ -510,8 +511,8 @@ report_failure(int status)
 		if (good_buf) {
 			save_buffer(good_buf, file_size, fsxgoodfd);
 			prt("Correct content saved for comparison\n");
-			prt("(maybe hexdump \"%s\" vs \"%s.fsxgood\")\n",
-			    fname, fname);
+			prt("(maybe hexdump \"%s\" vs \"%s\")\n",
+			    fname, goodfile);
 		}
 		close(fsxgoodfd);
 	}
@@ -1864,12 +1865,10 @@ main(int argc, char **argv)
 {
 	int	i, style, ch;
 	char	*endp, *tmp;
-	char goodfile[1024];
 	char logfile[1024];
 	struct stat statbuf;
 	int o_flags = O_RDWR|O_CREAT|O_TRUNC;
 
-	goodfile[0] = 0;
 	logfile[0] = 0;
 	dname[0] = 0;
 
@@ -2027,10 +2026,6 @@ main(int argc, char **argv)
 			strncpy(dname, optarg, sizeof(dname));
 			strcat(dname, "/");
 			dirpath = strlen(dname);
-
-			strncpy(goodfile, dname, sizeof(goodfile));
-			strncpy(logfile, dname, sizeof(logfile));
-			strncpy(opsfile, dname, sizeof(logfile));
 			break;
                 case 'R':
                         mapped_reads = 0;
@@ -2124,24 +2119,28 @@ main(int argc, char **argv)
 		}
 	}
 #endif
-	strncat(goodfile, dirpath ? bname : fname, 256);
-	strcat (goodfile, ".fsxgood");
+
+	if (dirpath) {
+		snprintf(goodfile, sizeof(goodfile), "%s%s.fsxgood", dname, bname);
+		snprintf(logfile, sizeof(logfile), "%s%s.fsxlog", dname, bname);
+		if (!*opsfile)
+			snprintf(opsfile, sizeof(opsfile), "%s%s.fsxops", dname, bname);
+	} else {
+		snprintf(goodfile, sizeof(goodfile), "%s.fsxgood", fname);
+		snprintf(logfile, sizeof(logfile), "%s.fsxlog", fname);
+		if (!*opsfile)
+			snprintf(opsfile, sizeof(opsfile), "%s.fsxops", fname);
+	}
 	fsxgoodfd = open(goodfile, O_RDWR|O_CREAT|O_TRUNC, 0666);
 	if (fsxgoodfd < 0) {
 		prterr(goodfile);
 		exit(92);
 	}
-	strncat(logfile, dirpath ? bname : fname, 256);
-	strcat (logfile, ".fsxlog");
 	fsxlogf = fopen(logfile, "w");
 	if (fsxlogf == NULL) {
 		prterr(logfile);
 		exit(93);
 	}
-	if (!*opsfile) {
-		strncat(opsfile, dirpath ? bname : fname, 256);
-		strcat(opsfile, ".fsxops");
-	}
 	unlink(opsfile);
 
 	if (replayops) {
-- 
2.14.3

