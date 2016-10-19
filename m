Received: from mx1.redhat.com ([209.132.183.28]:42900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941971AbcJSOvm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Oct 2016 10:51:42 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB760C056790
        for <fstests@vger.kernel.org>; Wed, 19 Oct 2016 10:06:32 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] xfs_io: Fix initial -m option
Date: Wed, 19 Oct 2016 12:06:30 +0200
Message-Id: <1476871590-15561-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Like "open -m mode", the initial -m option requires a mode argument.

Document these options correctly as well.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 io/init.c | 4 ++--
 io/open.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/io/init.c b/io/init.c
index efe7390..f792934 100644
--- a/io/init.c
+++ b/io/init.c
@@ -32,7 +32,7 @@ void
 usage(void)
 {
 	fprintf(stderr,
-		_("Usage: %s [-adfmnrRstVx] [-p prog] [-c cmd]... file\n"),
+		_("Usage: %s [-adfnrRstVx] [-m mode] [-p prog] [-c cmd]... file\n"),
 		progname);
 	exit(1);
 }
@@ -140,7 +140,7 @@ init(
 	pagesize = getpagesize();
 	gettimeofday(&stopwatch, NULL);
 
-	while ((c = getopt(argc, argv, "ac:dFfmp:nrRstTVx")) != EOF) {
+	while ((c = getopt(argc, argv, "ac:dFfm:p:nrRstTVx")) != EOF) {
 		switch (c) {
 		case 'a':
 			flags |= IO_APPEND;
diff --git a/io/open.c b/io/open.c
index 8f934ee..caf7895 100644
--- a/io/open.c
+++ b/io/open.c
@@ -918,7 +918,7 @@ open_init(void)
 	open_cmd.argmin = 0;
 	open_cmd.argmax = -1;
 	open_cmd.flags = CMD_NOMAP_OK | CMD_NOFILE_OK | CMD_FOREIGN_OK;
-	open_cmd.args = _("[-acdrstxT] [path]");
+	open_cmd.args = _("[-acdrstxT] [-m mode] [path]");
 	open_cmd.oneline = _("open the file specified by path");
 	open_cmd.help = open_help;
 
-- 
2.7.4

