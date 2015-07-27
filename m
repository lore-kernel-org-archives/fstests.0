Received: from imap.thunk.org ([74.207.234.97]:46577 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753578AbbG0OWv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 27 Jul 2015 10:22:51 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/4] xfstests: use the Posix st_mode defines instead of the obsolete SysV ones
Date: Mon, 27 Jul 2015 10:22:46 -0400
Message-Id: <1438006967-18815-4-git-send-email-tytso@mit.edu>
In-Reply-To: <1438006967-18815-1-git-send-email-tytso@mit.edu>
References: <1438006967-18815-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Instead of S_IEXEC, S_IREAD, and S_IWRITE, use the Posix defines of
S_I[WRX]{OTH,GRP,USR}.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 src/lstat64.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/lstat64.c b/src/lstat64.c
index 3b68c66..c8a0cc6 100644
--- a/src/lstat64.c
+++ b/src/lstat64.c
@@ -92,23 +92,23 @@ main(int argc, char **argv)
 			printf("  Size: %-10llu", (unsigned long long)sbuf.st_size);
 		}
 
-		if (sbuf.st_mode & (S_IEXEC>>6))
+		if (sbuf.st_mode & S_IXOTH)
 			mode[9] = 'x';
-		if (sbuf.st_mode & (S_IWRITE>>6))
+		if (sbuf.st_mode & S_IWOTH)
 			mode[8] = 'w';
-		if (sbuf.st_mode & (S_IREAD>>6))
+		if (sbuf.st_mode & S_IROTH)
 			mode[7] = 'r';
-		if (sbuf.st_mode & (S_IEXEC>>3))
+		if (sbuf.st_mode & S_IXGRP)
 			mode[6] = 'x';
-		if (sbuf.st_mode & (S_IWRITE>>3))
+		if (sbuf.st_mode & S_IWGRP)
 			mode[5] = 'w';
-		if (sbuf.st_mode & (S_IREAD>>3))
+		if (sbuf.st_mode & S_IRGRP)
 			mode[4] = 'r';
-		if (sbuf.st_mode & S_IEXEC)
+		if (sbuf.st_mode & S_IXUSR)
 			mode[3] = 'x';
-		if (sbuf.st_mode & S_IWRITE)
+		if (sbuf.st_mode & S_IWUSR)
 			mode[2] = 'w';
-		if (sbuf.st_mode & S_IREAD)
+		if (sbuf.st_mode & S_IRUSR)
 			mode[1] = 'r';
 		if (sbuf.st_mode & S_ISVTX)
 			mode[9] = 't';
-- 
2.3.0

