Received: from mx1.mpynet.fi ([82.197.21.84]:22301 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755311AbdLTRAe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 20 Dec 2017 12:00:34 -0500
From: Ari Sundholm <ari@tuxera.com>
Subject: [PATCH 2/2] fsstress: getcwd() return value fixes
Date: Wed, 20 Dec 2017 19:00:11 +0200
Message-ID: <1513789211-23061-2-git-send-email-ari@tuxera.com>
In-Reply-To: <1513789211-23061-1-git-send-email-ari@tuxera.com>
References: <1513789211-23061-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Ari Sundholm <ari@tuxera.com>
List-ID: <fstests@vger.kernel.org>

Add a check for the return value of getcwd(). Fix another check
which mistakenly checks if the return value is less than zero
instead of checking whether the return value is NULL.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 ltp/fsstress.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 13d5dd5..028c232 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -495,7 +495,7 @@ int main(int argc, char **argv)
 
 	(void)mkdir(dirname, 0777);
 	if (logname && logname[0] != '/') {
-		if (getcwd(rpath, sizeof(rpath)) < 0){
+		if (!getcwd(rpath, sizeof(rpath))){
 			perror("getcwd failed");
 			exit(1);
 		}
@@ -970,6 +970,10 @@ doproc(void)
 	}
 	top_ino = statbuf.st_ino;
 	homedir = getcwd(NULL, 0);
+	if (!homedir) {
+		perror("getcwd failed");
+		_exit(1);
+	}
 	seed += procid;
 	srandom(seed);
 	if (namerand)
-- 
2.7.4

