Received: from imap.thunk.org ([74.207.234.97]:32824 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbcBURmm (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 21 Feb 2016 12:42:42 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] gitignore: add src/test-nextquota
Date: Sun, 21 Feb 2016 00:51:50 -0500
Message-Id: <1456033910-30307-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Commit 1dfb50585c09 (quota: test Q_GETNEXTQUOTA) added a new binary
without updating .gitignore.  Fix this.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index c98c7bf..28fa205 100644
--- a/.gitignore
+++ b/.gitignore
@@ -95,6 +95,7 @@
 /src/t_mtab
 /src/t_stripealign
 /src/t_truncate_cmtime
+/src/test-nextquota
 /src/testx
 /src/trunc
 /src/truncfile
-- 
2.5.0

