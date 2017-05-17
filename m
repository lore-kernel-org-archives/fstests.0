Received: from mx1.redhat.com ([209.132.183.28]:42110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751300AbdEQPsy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 17 May 2017 11:48:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61A09C04B94B
        for <fstests@vger.kernel.org>; Wed, 17 May 2017 15:48:53 +0000 (UTC)
Received: from localhost.localdomain.com (vpn1-5-79.pek2.redhat.com [10.72.5.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C8CB5DD70
        for <fstests@vger.kernel.org>; Wed, 17 May 2017 15:48:52 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] fsstress: cleanup flist with test directory together
Date: Wed, 17 May 2017 23:48:47 +0800
Message-Id: <1495036127-11648-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The "-c" option of fsstress will clean up the test directory after
each run. But it only does "rm -rf $dir". If run fsstress likes:

  fsstress -d $test_dir -n 1000 -p 10 -l 0 -c

fsstress will remove all test directories at the end of each run,
but the flist still save those *deleted* entries. It'll cause
more and more useless ENOENT failures. So we need to release all
entries in flist too.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 ltp/fsstress.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 6d8f117..e9fd276 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -280,6 +280,7 @@ int	attr_list_path(pathname_t *, char *, const int, int, attrlist_cursor_t *);
 int	attr_remove_path(pathname_t *, const char *, int);
 int	attr_set_path(pathname_t *, const char *, const char *, const int, int);
 void	check_cwd(void);
+void	cleanup_flist(void);
 int	creat_path(pathname_t *, mode_t);
 void	dcache_enter(int, int);
 void	dcache_init(void);
@@ -794,6 +795,25 @@ check_cwd(void)
 #endif
 }
 
+/*
+ * go thru flist and release all entries
+ *
+ * NOTE: this function shouldn't be called until the end of a process
+ */
+void
+cleanup_flist(void)
+{
+	flist_t	*flp;
+	int	i;
+
+	for (i = 0, flp = flist; i < FT_nft; i++, flp++) {
+		flp->nslots = 0;
+		flp->nfiles = 0;
+		free(flp->fents);
+		flp->fents = NULL;
+	}
+}
+
 int
 creat_path(pathname_t *name, mode_t mode)
 {
@@ -945,6 +965,7 @@ errout:
 	if (cleanup) {
 		sprintf(cmd, "rm -rf %s", buf);
 		system(cmd);
+		cleanup_flist();
 	}
 }
 
-- 
2.7.4

