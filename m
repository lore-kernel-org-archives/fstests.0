Received: from mail.kernel.org ([198.145.29.99]:43480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbdIMNG1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 13 Sep 2017 09:06:27 -0400
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] fsync-err: write to different offset on each fd
Date: Wed, 13 Sep 2017 09:06:24 -0400
Message-Id: <20170913130624.24028-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, neilb@suse.com
List-ID: <fstests@vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

NFS currently has slightly different semantics from other fs' and
fails this test due to the fact that the same range is overwritten
via each fd.

Change it so that each fd overwrites a different region, which is
more representative of a real workload anyway.

Reported-by: Neil Brown <neilb@suse.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 src/fsync-err.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/fsync-err.c b/src/fsync-err.c
index 4b0205cf2fd4..146688ddb01e 100644
--- a/src/fsync-err.c
+++ b/src/fsync-err.c
@@ -106,7 +106,7 @@ int main(int argc, char **argv)
 	memset(buf, 0x7c, bufsize);
 
 	for (i = 0; i < numfds; ++i) {
-		ret = write(fd[i], buf, bufsize);
+		ret = pwrite(fd[i], buf, bufsize, i * bufsize);
 		if (ret < 0) {
 			printf("First write on fd[%d] failed: %m\n", i);
 			return 1;
@@ -149,7 +149,7 @@ int main(int argc, char **argv)
 	}
 
 	for (i = 0; i < numfds; ++i) {
-		ret = write(fd[i], buf, bufsize);
+		ret = pwrite(fd[i], buf, bufsize, i * bufsize);
 		if (ret < 0) {
 			printf("Second write on fd[%d] failed: %m\n", i);
 			return 1;
-- 
2.13.5

