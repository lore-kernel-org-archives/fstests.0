Received: from mx1.mpynet.fi ([82.197.21.84]:21566 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755287AbdLTRAW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 20 Dec 2017 12:00:22 -0500
From: Ari Sundholm <ari@tuxera.com>
Subject: [PATCH 1/2] fsstress: Eliminate valgrind noise
Date: Wed, 20 Dec 2017 19:00:10 +0200
Message-ID: <1513789211-23061-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Ari Sundholm <ari@tuxera.com>
List-ID: <fstests@vger.kernel.org>

This patch plugs what we think are the remaining sources of
valgrind noise we found when running fsstress under valgrind.
The noise is caused by memory being left unfreed before process
termination.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 ltp/fsstress.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 96f48b1..13d5dd5 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -614,6 +614,9 @@ int main(int argc, char **argv)
 				return 1;
 			}
 #endif
+
+			cleanup_flist();
+			free(freq_table);
 			return 0;
 		}
 	}
@@ -640,6 +643,7 @@ int main(int argc, char **argv)
 		close(fd);
 	}
 
+	free(freq_table);
 	unlink(buf);
 	return 0;
 }
@@ -997,6 +1001,7 @@ doproc(void)
 	}
 errout:
 	chdir("..");
+	free(homedir);
 	if (cleanup) {
 		sprintf(cmd, "rm -rf %s", buf);
 		system(cmd);
-- 
2.7.4

