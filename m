Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10871 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbaFET0j (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 5 Jun 2014 15:26:39 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s55JQcO2008182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Thu, 5 Jun 2014 15:26:39 -0400
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s55JQcmP009216
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO)
	for <fstests@vger.kernel.org>; Thu, 5 Jun 2014 15:26:38 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] resvtest.c: fix invalid use of sizeof()
Date: Thu, 05 Jun 2014 15:26:37 -0400
Message-ID: <x49lhtbw42a.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

sizeof(pointer) will give you the size of a pointer, not the space
allocated to it.  I noticed this when gcc complained:

resvtest.c:76:33: warning: argument to 'sizeof' in 'memset' call is the same expression as the destination; did you mean to provide an explicit length? [-Wsizeof-pointer-memaccess]
  memset(writebuffer, 'A', sizeof(writebuffer));

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/src/resvtest.c b/src/resvtest.c
index 037d9ea..ecad031 100644
--- a/src/resvtest.c
+++ b/src/resvtest.c
@@ -73,7 +73,7 @@ main(int argc, char **argv)
 		perror("open");
 		exit(1);
 	}
-	memset(writebuffer, 'A', sizeof(writebuffer));
+	memset(writebuffer, 'A', bsize);
 
 	unlink(filename);
 	writefd = open(filename, O_RDWR | O_CREAT | O_EXCL, S_IRUSR | S_IWUSR);
@@ -111,7 +111,7 @@ main(int argc, char **argv)
 		char *p;
 		int numerrors;
 
-		if (write(writefd, writebuffer, sizeof(writebuffer)) < 0) {
+		if (write(writefd, writebuffer, bsize) < 0) {
 			perror("write");
 			exit(1);
 		}
@@ -128,11 +128,11 @@ main(int argc, char **argv)
 		lseek(readfd, SEEK_SET, 0);
 		numerrors = 0;
 		for (j = 0; j < n; j++) {
-			if (read(readfd, readbuffer, sizeof(readbuffer)) < 0) {
+			if (read(readfd, readbuffer, bsize) < 0) {
 				perror("read");
 				exit(1);
 			}
-			for (i = 0; i < sizeof(readbuffer); i++) {
+			for (i = 0; i < bsize; i++) {
 				if (readbuffer[i] != 'A') {
 					fprintf(stderr,
 "errors detected in file, pos: %d (%lld+%d), nwrites: %d [val=0x%x].\n",
