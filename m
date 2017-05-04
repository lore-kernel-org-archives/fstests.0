Received: from mx1.redhat.com ([209.132.183.28]:41642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbdEDPQ4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 May 2017 11:16:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08A937F4C6
        for <fstests@vger.kernel.org>; Thu,  4 May 2017 15:16:55 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB7137D958
        for <fstests@vger.kernel.org>; Thu,  4 May 2017 15:16:54 +0000 (UTC)
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] punch-alternating: add some options
Message-ID: <ad311156-c99a-4269-051e-082b259bb0de@redhat.com>
Date: Thu, 4 May 2017 10:16:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

I didn't end up using this, but somebody else might find
it useful, so sending it.

This change lets us specify punch patterns other than
literally every other block.

i.e. punch-alternating with no options will do:

...HDHDHDHDHDHD...

-i 4 -s 2 will do:

...DDHHDDHHDDHH...

or -i 3 -s 1 will do:

...DDHDDHDDHDDH...

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/src/punch-alternating.c b/src/punch-alternating.c
index 4148622..0c7a7ff 100644
--- a/src/punch-alternating.c
+++ b/src/punch-alternating.c
@@ -11,6 +11,14 @@
 #include <string.h>
 #include "global.h"
 
+void usage(char *cmd)
+{
+	printf("Usage: %s [-i interval] [-s size] file\n", cmd);
+	printf("Punches every other block in the file by default,\n");
+	printf("or 'size' blocks every 'interval' blocks with options.\n");
+	exit(1);
+}
+
 int main(int argc, char *argv[])
 {
 	struct stat	s;
@@ -21,14 +29,27 @@ int main(int argc, char *argv[])
 	off_t		sz;
 	int		mode;
 	int		error;
+	int		c;
+	int		size = 1;	/* punch $SIZE blocks ... */
+	int		interval = 2;	/* every $INTERVAL blocks */
+
+	if (argc < 2)
+		usage(argv[0]);
 
-	if (argc != 2) {
-		printf("Usage: %s file\n", argv[0]);
-		printf("Punches every other block in the file.\n");
-		return 1;
+	while ((c = getopt(argc, argv, "i:s:")) != EOF) {
+		switch (c) {
+		case 'i':
+			interval = atoi(optarg);
+			break;
+		case 's':
+			size = atoi(optarg);
+			break;
+		default:
+			usage(argv[0]);
+		}
 	}
 
-	fd = open(argv[1], O_WRONLY);
+	fd = open(argv[optind], O_WRONLY);
 	if (fd < 0)
 		goto err;
 
@@ -44,8 +65,8 @@ int main(int argc, char *argv[])
 	blksz = sf.f_bsize;
 
 	mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
-	for (offset = 0; offset < sz; offset += blksz * 2) {
-		error = fallocate(fd, mode, offset, blksz);
+	for (offset = 0; offset < sz; offset += blksz * interval) {
+		error = fallocate(fd, mode, offset, blksz * size);
 		if (error)
 			goto err;
 	}


