Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:33394 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbbE1A6u (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 27 May 2015 20:58:50 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 1/2] fsstress: add the [-l loops] option
Date: Wed, 27 May 2015 20:58:45 -0400
Message-Id: <1432774726-26824-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

This feature is in the ltp version of fsstress; port it into
xfstests.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 ltp/fsstress.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index aa3e0c3..ad0c65f 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -330,7 +330,8 @@ int main(int argc, char **argv)
 	int             nousage = 0;
 	xfs_error_injection_t	        err_inj;
 	struct sigaction action;
-	const char	*allopts = "d:e:f:i:m:M:n:o:p:rs:S:vVwx:X:zH";
+	int		loops = 1;
+	const char	*allopts = "d:e:f:i:l:m:M:n:o:p:rs:S:vVwx:X:zH";
 
 	errrange = errtag = 0;
 	umask(0);
@@ -372,6 +373,9 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			break;
+		case 'l':
+			loops = atoi(optarg);
+			break;
 		case 'n':
 			operations = atoi(optarg);
 			break;
@@ -538,7 +542,8 @@ int main(int argc, char **argv)
 				}
 			}
 			procid = i;
-			doproc();
+			for (i = 0; !loops || (i < loops); i++)
+				doproc();
 			return 0;
 		}
 	}
@@ -896,10 +901,12 @@ doproc(void)
 			rval = stat64(".", &statbuf);
 			if (rval == EIO)  {
 				fprintf(stderr, "Detected EIO\n");
-				return;
+				goto errout;
 			}
 		}
 	}
+errout:
+	chdir("..");
 }
 
 /*
@@ -1572,7 +1579,7 @@ void
 usage(void)
 {
 	printf("Usage: %s -H   or\n", myprog);
-	printf("       %s [-d dir][-e errtg][-f op_name=freq][-n nops]\n",
+	printf("       %s [-d dir][-e errtg][-f op_name=freq][-l loops][-n nops]\n",
 		myprog);
 	printf("          [-p nproc][-r len][-s seed][-v][-w][-x cmd][-z][-S][-X ncmd]\n");
 	printf("where\n");
@@ -1582,6 +1589,8 @@ usage(void)
 	printf("                    the valid operation names are:\n");
 	show_ops(-1, "                        ");
 	printf("   -i filenum       get verbose output for this nth file object\n");
+	printf("   -l loops         specifies the no. of times the testrun should loop.\n");
+	printf("                     *use 0 for infinite (default 1)\n");
 	printf("   -m modulo        uid/gid modulo for chown/chgrp (default 32)\n");
 	printf("   -n nops          specifies the no. of operations per process (default 1)\n");
 	printf("   -o logfile       specifies logfile name\n");
-- 
2.3.0

