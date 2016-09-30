Received: from mx2.suse.de ([195.135.220.15]:48583 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932105AbcI3LxS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 30 Sep 2016 07:53:18 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 753FEAC7E
        for <fstests@vger.kernel.org>; Fri, 30 Sep 2016 11:52:28 +0000 (UTC)
From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] fsx: fix compiler warning due to bad prototype
Date: Fri, 30 Sep 2016 13:52:18 +0200
Message-Id: <1475236338-7906-1-git-send-email-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
List-ID: <fstests@vger.kernel.org>

I see the following with gcc 4.8.5 [-Wunprototyped-calls]:
	warning: call to function 'cleanup' without a real prototype

Fix this by moving the function definition up, and dropping the
prototype.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 ltp/fsx.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index a7b36c1..ebe8ecf 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1272,7 +1272,14 @@ do {						\
 	TRIM_LEN(off, len, size);		\
 } while (0)
 
-void cleanup();
+void
+cleanup(int sig)
+{
+	if (sig)
+		prt("signal %d\n", sig);
+	prt("testcalls = %lu\n", testcalls);
+	exit(sig);
+}
 
 static int
 read_op(struct log_entry *log_entry)
@@ -1532,17 +1539,6 @@ out:
 
 
 void
-cleanup(sig)
-	int	sig;
-{
-	if (sig)
-		prt("signal %d\n", sig);
-	prt("testcalls = %lu\n", testcalls);
-	exit(sig);
-}
-
-
-void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-- 
2.6.6

