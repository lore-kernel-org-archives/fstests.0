Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B582EB64D7
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Jun 2023 09:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjF3JlX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 30 Jun 2023 05:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjF3JlS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 30 Jun 2023 05:41:18 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A37A2122
        for <fstests@vger.kernel.org>; Fri, 30 Jun 2023 02:41:08 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:2481:0:640:e0:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 4662B600E4
        for <fstests@vger.kernel.org>; Fri, 30 Jun 2023 12:41:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4fKncTCDg4Y0-spkEXtaP;
        Fri, 30 Jun 2023 12:41:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688118066;
        bh=QZskR+yBX0wDuUe7oIn/RqXvPvwDEvAmZzJBCXKn5NY=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=F3EvyfHXpJhc+NHTbfEtY8xvYrELHuD0CapnEl50zvNXNgaqBLU6ZZKcpNeCXouhi
         drsp4QXgt4ZcXex/fkqSfeVSElpzwEIaJpFaN7g1OqtqsBzV88H6RkrWIoYXpO8w0e
         bueMHJ7kod6UhDjN2883zHsvY60dXVyoQ6Ed2Gbw=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     fstests@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>
Subject: [PATCH] t_ofd_locks: fix initialization sequence
Date:   Fri, 30 Jun 2023 14:40:51 +0500
Message-Id: <20230630094051.3765376-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently IPC_RMID was attempted on a semid returned after failed
semget() with flags=IPC_CREAT|IPC_EXCL. So nothing was actually removed.
To get a proper semid, this patch retries semget() without IPC_EXCL.

This opens up a race: if the lock-tester grabbed the old sem before
lock-setter used that magic to remove it, then the lock-tester will
remain with removed sem.

Additionally locker was waiting for sem_otime on sem0 to became
non-zero after incrementing sem0 himself. So sem_otime was never
0 at the time of checking it.

So basically the code was all wrong.
This patch:
- fixes RMID after IPC_EXCL to actually remove the sem
- moves the increment of sem1 to the lock-tester site, and the
  lock-setter waits for that event
- replaces the wait loop on sem_otime with GETVAL, adding a small sleep.
- lock-tester during the init sequence checks for removed sem, and
  if it is - retries the init from semget()

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
---
 src/t_ofd_locks.c | 73 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
index e77f2659..daa6f96c 100644
--- a/src/t_ofd_locks.c
+++ b/src/t_ofd_locks.c
@@ -297,6 +297,7 @@ int main(int argc, char **argv)
 			semid = semget(semkey, 2, IPC_CREAT|IPC_EXCL);
 			if (semid < 0 && errno == EEXIST) {
 				/* remove sem set after one round of test */
+				semid = semget(semkey, 2, IPC_CREAT);
 				if (semctl(semid, 2, IPC_RMID, semu) == -1)
 					err_exit("rmid 0", errno);
 				retry++;
@@ -315,32 +316,29 @@ int main(int argc, char **argv)
 		semu.array = vals;
 		if (semctl(semid, 2, SETALL, semu) == -1)
 			err_exit("init sem", errno);
-		/* Inc both new sem to 2 */
-		sop.sem_num = 0;
-		sop.sem_op = 1;
-		sop.sem_flg = 0;
-		ts.tv_sec = 5;
-		ts.tv_nsec = 0;
-		if (semtimedop(semid, &sop, 1, &ts) == -1)
-			err_exit("inc sem0 2", errno);
-		sop.sem_num = 1;
-		sop.sem_op = 1;
-		sop.sem_flg = 0;
-		ts.tv_sec = 5;
-		ts.tv_nsec = 0;
-		if (semtimedop(semid, &sop, 1, &ts) == -1)
-			err_exit("inc sem1 2", errno);
 
 		/*
-		 * Wait initialization complete. semctl(2) only update
-		 * sem_ctime, semop(2) will update sem_otime.
+		 * Wait initialization complete.
 		 */
 		ret = -1;
 		do {
+			if (ret != -1)
+				usleep(100000);
 			memset(&sem_ds, 0, sizeof(sem_ds));
 			semu.buf = &sem_ds;
-			ret = semctl(semid, 0, IPC_STAT, semu);
-		} while (!(ret == 0 && sem_ds.sem_otime != 0));
+			ret = semctl(semid, 1, GETVAL, semu);
+			if (ret == -1)
+				err_exit("wait sem1 2", errno);
+		} while (ret != 2);
+
+		/* Inc sem0 to 2 */
+		sop.sem_num = 0;
+		sop.sem_op = 1;
+		sop.sem_flg = 0;
+		ts.tv_sec = 5;
+		ts.tv_nsec = 0;
+		if (semtimedop(semid, &sop, 1, &ts) == -1)
+			err_exit("inc sem0 2", errno);
 
 		/* place the lock */
 		if (fcntl(fd, setlk_macro, &flk) < 0)
@@ -393,10 +391,26 @@ int main(int argc, char **argv)
 	/* getlck */
 	if (lock_cmd == 0) {
 		/* wait sem created and initialized */
+again:
 		retry = 5;
 		do {
 			semid = semget(semkey, 2, 0);
-			if (semid != -1)
+			ret = -1;
+			if (semid != -1) do {
+				if (ret != -1)
+					usleep(100000);
+				memset(&sem_ds, 0, sizeof(sem_ds));
+				semu.buf = &sem_ds;
+				ret = semctl(semid, 0, GETVAL, semu);
+				if (ret == -1 && (errno == EINVAL
+					       || errno == EIDRM)) {
+					/* sem removed */
+					goto again;
+				}
+				if (ret == -1)
+					break;
+			} while (ret != 1);
+			if (ret == 1)
 				break;
 			if (errno == ENOENT && retry) {
 				sleep(1);
@@ -406,11 +420,15 @@ int main(int argc, char **argv)
 				err_exit("getlk_semget", errno);
 			}
 		} while (1);
-		do {
-			memset(&sem_ds, 0, sizeof(sem_ds));
-			semu.buf = &sem_ds;
-			ret = semctl(semid, 0, IPC_STAT, semu);
-		} while (!(ret == 0 && sem_ds.sem_otime != 0));
+
+		/* inc sem1 to 2 (initialization completed) */
+		sop.sem_num = 1;
+		sop.sem_op = 1;
+		sop.sem_flg = 0;
+		ts.tv_sec = 5;
+		ts.tv_nsec = 0;
+		if (semtimedop(semid, &sop, 1, &ts) == -1)
+			err_exit("inc sem1 2", errno);
 
 		/* wait sem0 == 0 (setlk and close fd done) */
 		sop.sem_num = 0;
@@ -418,8 +436,11 @@ int main(int argc, char **argv)
 		sop.sem_flg = 0;
 		ts.tv_sec = 5;
 		ts.tv_nsec = 0;
-		if (semtimedop(semid, &sop, 1, &ts) == -1)
+		if (semtimedop(semid, &sop, 1, &ts) == -1) {
+			if (errno == EIDRM || errno == EINVAL)
+				goto again;
 			err_exit("wait sem0 0", errno);
+		}
 
 		if (fcntl(fd, getlk_macro, &flk) < 0)
 			err_exit("getlk", errno);
-- 
2.39.2

