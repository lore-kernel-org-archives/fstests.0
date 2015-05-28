Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:33395 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679AbbE1A6u (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 27 May 2015 20:58:50 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/2] fsstress: add the -c option
Date: Wed, 27 May 2015 20:58:46 -0400
Message-Id: <1432774726-26824-2-git-send-email-tytso@mit.edu>
In-Reply-To: <1432774726-26824-1-git-send-email-tytso@mit.edu>
References: <1432774726-26824-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

This option causes fsstress to delete the test directory between each
run.  This is the opposite from the ltp version of fsstress, which
deletes the test directory by default, and the -c option caused ltp's
fsstress _not_ to delete the test directory.

It can be useful to be able to have the same test behavior as ltp
version, and although reversing the sense of the option is
unfortunate, it also reserves the -c option, which makes it a bit
easier if we want to eventually have one version which is a superset
of the xfstest and ltp version of fsstress.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 ltp/fsstress.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index ad0c65f..1e6c913 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -258,6 +258,7 @@ int		procid;
 int		rtpct;
 unsigned long	seed = 0;
 ino_t		top_ino;
+int		cleanup = 0;
 int		verbose = 0;
 int		verifiable_log = 0;
 sig_atomic_t	should_stop = 0;
@@ -331,7 +332,7 @@ int main(int argc, char **argv)
 	xfs_error_injection_t	        err_inj;
 	struct sigaction action;
 	int		loops = 1;
-	const char	*allopts = "d:e:f:i:l:m:M:n:o:p:rs:S:vVwx:X:zH";
+	const char	*allopts = "cd:e:f:i:l:m:M:n:o:p:rs:S:vVwx:X:zH";
 
 	errrange = errtag = 0;
 	umask(0);
@@ -340,6 +341,9 @@ int main(int argc, char **argv)
 	myprog = argv[0];
 	while ((c = getopt(argc, argv, allopts)) != -1) {
 		switch (c) {
+		case 'c':
+			cleanup = 1;
+			break;
 		case 'd':
 			dirname = optarg;
 			break;
@@ -862,6 +866,7 @@ doproc(void)
 {
 	struct stat64	statbuf;
 	char		buf[10];
+	char		cmd[64];
 	int		opno;
 	int		rval;
 	opdesc_t	*p;
@@ -907,6 +912,10 @@ doproc(void)
 	}
 errout:
 	chdir("..");
+	if (cleanup) {
+		sprintf(cmd, "rm -rf %s", buf);
+		system(cmd);
+	}
 }
 
 /*
@@ -1579,10 +1588,11 @@ void
 usage(void)
 {
 	printf("Usage: %s -H   or\n", myprog);
-	printf("       %s [-d dir][-e errtg][-f op_name=freq][-l loops][-n nops]\n",
+	printf("       %s [-c][-d dir][-e errtg][-f op_name=freq][-l loops][-n nops]\n",
 		myprog);
 	printf("          [-p nproc][-r len][-s seed][-v][-w][-x cmd][-z][-S][-X ncmd]\n");
 	printf("where\n");
+	printf("   -c               clean up the test directory after each run\n");
 	printf("   -d dir           specifies the base directory for operations\n");
 	printf("   -e errtg         specifies error injection stuff\n");
 	printf("   -f op_name=freq  changes the frequency of option name to freq\n");
-- 
2.3.0

