Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39684C001DF
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Aug 2023 17:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjHARwk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjHARwf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Aug 2023 13:52:35 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B706F126
        for <fstests@vger.kernel.org>; Tue,  1 Aug 2023 10:52:30 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:ab96:0:640:dd69:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 4E4BB6001E;
        Tue,  1 Aug 2023 20:52:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OqVuX9uDSa60-kdsakYPZ;
        Tue, 01 Aug 2023 20:52:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690912347;
        bh=oCoduA0px3qI7MxkkCN190GpHh/pRIGjY5JIrH6EtU4=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=F9gkJLk6c3kiMwbxjJfbLbM7+HqWdOFb47fb0wl2U6/Vl5OoYWA2EcllDGRDxAbLn
         yHGDhP2H8zcLcOS75zPMZ0GtA1aFqAgjbGvKSGwBmLurQ+zBNH091nkqv9wi/iHqg3
         KBw2HVzX7iItc8gBzETVl2O4qrEW8MG10v36dP8w=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     fstests@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Murphy Zhou <xzhou@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH 2/2] t_ofd_locks: fix sem initialization sequence
Date:   Tue,  1 Aug 2023 22:52:20 +0500
Message-Id: <20230801175220.1558342-3-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801175220.1558342-1-stsp2@yandex.ru>
References: <20230801175220.1558342-1-stsp2@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The locker was waiting for sem_otime on sem0 to became non-zero after
incrementing sem0 himself. So sem_otime was never 0 at the time of
checking it, so the check was redundant/wrong.

This patch:
- moves the increment of sem1 to the lock-tester site
- lock-setter waits for that sem1 event, for which this patch replaces
  the wait loop on sem_otime with GETVAL loop, adding a small sleep
- increment of sem0 to 2 moved past that sem1 event. That sem0 event
  is currently not used/waited.

This guarantees that the lock-setter is working only after lock-getter
is fully initialized.

CC: fstests@vger.kernel.org
CC: Murphy Zhou <xzhou@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Zorro Lang <zlang@redhat.com>

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
---
 src/t_ofd_locks.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
index 88ef2690..58cb0959 100644
--- a/src/t_ofd_locks.c
+++ b/src/t_ofd_locks.c
@@ -294,32 +294,29 @@ int main(int argc, char **argv)
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
@@ -385,6 +382,15 @@ int main(int argc, char **argv)
 				err_exit("wait sem1 1", errno);
 		} while (ret != 1);
 
+		/* inc sem1 to 2 (initialization completed) */
+		sop.sem_num = 1;
+		sop.sem_op = 1;
+		sop.sem_flg = 0;
+		ts.tv_sec = 5;
+		ts.tv_nsec = 0;
+		if (semtimedop(semid, &sop, 1, &ts) == -1)
+			err_exit("inc sem1 2", errno);
+
 		/* wait sem0 == 0 (setlk and close fd done) */
 		sop.sem_num = 0;
 		sop.sem_op = 0;
-- 
2.39.2

