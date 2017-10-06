Received: from mx1.mpynet.fi ([82.197.21.84]:51740 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbdJFIT6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 6 Oct 2017 04:19:58 -0400
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH v2] holetest: Use pid_t type for fork(2) return value
Date: Fri, 6 Oct 2017 08:19:46 +0000
Message-ID: <1507277986-17326-1-git-send-email-rostislav@tuxera.com>
In-Reply-To: <20171005194826.GB21115@infradead.org>
References: <20171005194826.GB21115@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

---
Hello Christoph,

I think using uint64_t is fine since pthread_t is either a pointer or a ulong,
and pid_t is an int, so uint64_t acts as a "superset" of those types. Valid
PIDs are positive, so the difference in signedness should not be a problem.

I made a minimal patch as you suggested.
 src/holetest.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/holetest.c b/src/holetest.c
index 1939b35..ab582f5 100644
--- a/src/holetest.c
+++ b/src/holetest.c
@@ -199,22 +199,22 @@ int test_this(int fd, loff_t sz)
 			tid[i] = (uint64_t)t[i];
 			printf("INFO: thread %d created\n", i);
 		} else {
+			pid_t pid;
 			/*
 			 * Flush stdout before fork, otherwise some lines get
 			 * duplicated... ?!?!?
 			 */
 			fflush(stdout);
-			tid[i] = fork();
-			if (tid[i] < 0) {
+			pid = fork();
+			if (pid < 0) {
 				int j;
 
 				perror("fork");
 				for (j = 0; j < i; j++)
 					waitpid(tid[j], NULL, 0);
 				exit(21);
-			}
-			/* Child? */
-			if (!tid[i]) {
+			} else if (!pid) {
+				/* Child? */
 				void *ret;
 
 				if (use_wr[i])
@@ -223,6 +223,7 @@ int test_this(int fd, loff_t sz)
 					ret = pt_page_marker(&targs[i]);
 				exit(ret ? 1 : 0);
 			}
+			tid[i] = pid;
 			printf("INFO: process %d created\n", i);
 		}
 	}
-- 
2.1.4

