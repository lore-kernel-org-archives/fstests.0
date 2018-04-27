Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758785AbeD0QfB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Apr 2018 12:35:01 -0400
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] fsync-err: don't truncate files on second open
Date: Fri, 27 Apr 2018 12:34:59 -0400
Message-Id: <20180427163459.20864-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

...and no need for O_CREAT flag.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 src/fsync-err.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/fsync-err.c b/src/fsync-err.c
index 146688ddb01e..bd05dcc0a898 100644
--- a/src/fsync-err.c
+++ b/src/fsync-err.c
@@ -170,9 +170,9 @@ int main(int argc, char **argv)
 			ret = fsync(fd[i]);
 			if (ret < 0) {
 				/*
-				 * We did a failed write and fsync on each fd before.
-				 * Now the error should be clear since we've not done
-				 * any writes since then.
+				 * We did a failed write and fsync on each fd
+				 * before.  Now the error should be clear since
+				 * we've not done any writes since then.
 				 */
 				printf("Third fsync on fd[%d] failed: %m\n", i);
 				return 1;
@@ -220,7 +220,7 @@ int main(int argc, char **argv)
 			printf("Close of fd[%d] returned unexpected error: %m\n", i);
 			return 1;
 		}
-		fd[i] = open(fname, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+		fd[i] = open(fname, O_WRONLY, 0644);
 		if (fd[i] < 0) {
 			printf("Second open of fd[%d] failed: %m\n", i);
 			return 1;
-- 
2.14.3

