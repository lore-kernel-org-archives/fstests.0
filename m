Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751699AbeCWCto (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Mar 2018 22:49:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0824D406E8A4
        for <fstests@vger.kernel.org>; Fri, 23 Mar 2018 02:49:44 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH] generic/478: fix potential test blocking
Date: Fri, 23 Mar 2018 10:49:37 +0800
Message-Id: <1521773377-19814-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Reduce semtimedop timeout to 5s, 15s is too long if something
get tangled up. Add retry counting to getlk routine, infinite
loop is dangerous. If something goes wrong unexpextedly, test
is blocked wasting time.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

We are hitting this when testing on cifs samba 2.0.

 src/t_ofd_locks.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
index d578cd7..454b2ce 100644
--- a/src/t_ofd_locks.c
+++ b/src/t_ofd_locks.c
@@ -317,14 +317,14 @@ int main(int argc, char **argv)
 		sop.sem_num = 0;
 		sop.sem_op = 1;
 		sop.sem_flg = 0;
-		ts.tv_sec = 15;
+		ts.tv_sec = 5;
 		ts.tv_nsec = 0;
 		if (semtimedop(semid, &sop, 1, &ts) == -1)
 			err_exit("inc sem0 2", errno);
 		sop.sem_num = 1;
 		sop.sem_op = 1;
 		sop.sem_flg = 0;
-		ts.tv_sec = 15;
+		ts.tv_sec = 5;
 		ts.tv_nsec = 0;
 		if (semtimedop(semid, &sop, 1, &ts) == -1)
 			err_exit("inc sem1 2", errno);
@@ -376,7 +376,7 @@ int main(int argc, char **argv)
 		sop.sem_num = 1;
 		sop.sem_op = 0;
 		sop.sem_flg = 0;
-		ts.tv_sec = 15;
+		ts.tv_sec = 5;
 		ts.tv_nsec = 0;
 		if (semtimedop(semid, &sop, 1, &ts) == -1)
 			err_exit("wait sem1 0", errno);
@@ -391,13 +391,16 @@ int main(int argc, char **argv)
 	/* getlck */
 	if (lock_cmd == 0) {
 		/* wait sem created and initialized */
+		retry = 5;
 		do {
 			semid = semget(semkey, 2, 0);
 			if (semid != -1)
 				break;
-			if (errno == ENOENT)
+			if (errno == ENOENT && retry) {
+				sleep(1);
+				retry--;
 				continue;
-			else
+			} else
 				err_exit("getlk_semget", errno);
 		} while (1);
 		do {
@@ -410,7 +413,7 @@ int main(int argc, char **argv)
 		sop.sem_num = 0;
 		sop.sem_op = 0;
 		sop.sem_flg = 0;
-		ts.tv_sec = 15;
+		ts.tv_sec = 5;
 		ts.tv_nsec = 0;
 		if (semtimedop(semid, &sop, 1, &ts) == -1)
 			err_exit("wait sem0 0", errno);
-- 
1.8.3.1

