Received: from imap.thunk.org ([74.207.234.97]:37887 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbbGZMVH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 26 Jul 2015 08:21:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 4/6] xfsprogs: avoid use of si_tid in struct xlog_split_item
Date: Sun, 26 Jul 2015 08:20:53 -0400
Message-Id: <1437913255-7524-5-git-send-email-tytso@mit.edu>
In-Reply-To: <1437913255-7524-1-git-send-email-tytso@mit.edu>
References: <1437913255-7524-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: xfs@oss.sgi.com
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

In Android's bionic libc (as well as the Linux kernel's
include/uapi/asm-generic/siginfo.h), si_tid is a #define to provide
backwards compatibility for the timerid in the siginfo structure.
This breaks the compile of logprint/log_misc.c.  Change this to be
si_xtid in order to avoid a namespace collision

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 logprint/log_misc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/logprint/log_misc.c b/logprint/log_misc.c
index c9286c6..c0a5c97 100644
--- a/logprint/log_misc.c
+++ b/logprint/log_misc.c
@@ -76,7 +76,7 @@ char *trans_type[] = {
 typedef struct xlog_split_item {
 	struct xlog_split_item	*si_next;
 	struct xlog_split_item	*si_prev;
-	xlog_tid_t		si_tid;
+	xlog_tid_t		si_xtid;
 	int			si_skip;
 } xlog_split_item_t;
 
@@ -161,7 +161,7 @@ xlog_print_add_to_trans(xlog_tid_t	tid,
     xlog_split_item_t *item;
 
     item	  = (xlog_split_item_t *)calloc(sizeof(xlog_split_item_t), 1);
-    item->si_tid  = tid;
+    item->si_xtid  = tid;
     item->si_skip = skip;
     item->si_next = split_list;
     item->si_prev = NULL;
@@ -183,7 +183,7 @@ xlog_print_find_tid(xlog_tid_t tid, uint was_cont)
 	    return 0;
     }
     while (listp) {
-	if (listp->si_tid == tid)
+	if (listp->si_xtid == tid)
 	    break;
 	listp = listp->si_next;
     }
-- 
2.3.0

