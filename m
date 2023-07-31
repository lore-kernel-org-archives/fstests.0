Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA0C001E0
	for <linux-fstests@archiver.kernel.org>; Mon, 31 Jul 2023 11:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjGaL2h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 31 Jul 2023 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGaL2h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 31 Jul 2023 07:28:37 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3760BF
        for <fstests@vger.kernel.org>; Mon, 31 Jul 2023 04:28:35 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:150a:0:640:1aa5:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 6030960066;
        Mon, 31 Jul 2023 14:28:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id MSOJdagWl0U0-KYnGl77G;
        Mon, 31 Jul 2023 14:28:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690802911;
        bh=GATLOu1LaHyBPlnFRlJKJrrgqGFi0jVwZeALJwdkdsA=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=HxGsFCA9TLyOcclwJXTkTUhrBxMkxYOW6WIYyqW+AbVjlBlvi5iXY7Q6hJev2EsoD
         mczMHtcLejmD7m/2SvUA5sFYjbQOATGUMeSz2xhl+Vco5M9btjaJYji4Od0PwoutuS
         MeFI//TnlpgD2doj5s/quSFggsX1GIHnqO9Eg8j8=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     fstests@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Murphy Zhou <xzhou@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH 1/2] t_ofd_locks: fix stalled semaphore handling
Date:   Mon, 31 Jul 2023 16:28:06 +0500
Message-Id: <20230731112807.1463846-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731112807.1463846-1-stsp2@yandex.ru>
References: <20230731112807.1463846-1-stsp2@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently IPC_RMID was attempted on a semid returned after failed
semget() with flags=IPC_CREAT|IPC_EXCL. So nothing was actually removed.

This patch introduces the much more reliable scheme where the sem key
is provided from the wrapper script, after making sure there are no
stalled semaphores with that key.

This patch uses $BASHPID for sem key, and adds the -K option to
t_ofd_locks to pass the sem key.

CC: fstests@vger.kernel.org
CC: Murphy Zhou <xzhou@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Zorro Lang <zlang@redhat.com>

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
---
 src/t_ofd_locks.c | 48 ++++++++++++-----------------------------------
 tests/generic/478 | 14 ++++++++++----
 2 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
index e77f2659..95739dc7 100644
--- a/src/t_ofd_locks.c
+++ b/src/t_ofd_locks.c
@@ -180,16 +180,16 @@ int main(int argc, char **argv)
 	int setlk_macro = F_OFD_SETLKW;
 	int getlk_macro = F_OFD_GETLK;
 	struct timespec ts;
-	key_t semkey;
+	key_t semkey = -1;
 	unsigned short vals[2];
 	union semun semu;
 	struct semid_ds sem_ds;
 	struct sembuf sop;
-	int opt, ret, retry;
+	int opt, ret;
 
 	//avoid libcap errno bug
 	errno = 0;
-	while((opt = getopt(argc, argv, "sgrwo:l:PRWtFd")) != -1) {
+	while((opt = getopt(argc, argv, "sgrwo:l:PRWtFdK:")) != -1) {
 		switch(opt) {
 		case 's':
 			lock_cmd = 1;
@@ -227,6 +227,9 @@ int main(int argc, char **argv)
 		case 'd':
 			use_dup = 1;
 			break;
+		case 'K':
+			semkey = atoi(optarg);
+			break;
 		default:
 			usage(argv[0]);
 			return -1;
@@ -276,37 +279,15 @@ int main(int argc, char **argv)
 		err_exit("test_ofd_getlk", errno);
 	}
 
-	if((semkey = ftok(argv[optind], 255)) == -1)
+	if (semkey == -1)
+		semkey = ftok(argv[optind], 255);
+	if (semkey == -1)
 		err_exit("ftok", errno);
 
 	/* setlk, and always init the semaphore at setlk time */
 	if (lock_cmd == 1) {
-		/*
-		 * Init the semaphore, with a key related to the testfile.
-		 * getlk routine will wait untill this sem has been created and
-		 * iniialized.
-		 *
-		 * We must make sure the semaphore set is newly created, rather
-		 * then the one left from last run. In which case getlk will
-		 * exit immediately and left setlk routine waiting forever.
-		 * Also because newly created semaphore has zero sem_otime,
-		 * which is used here to sync with getlk routine.
-		 */
-		retry = 0;
-		do {
-			semid = semget(semkey, 2, IPC_CREAT|IPC_EXCL);
-			if (semid < 0 && errno == EEXIST) {
-				/* remove sem set after one round of test */
-				if (semctl(semid, 2, IPC_RMID, semu) == -1)
-					err_exit("rmid 0", errno);
-				retry++;
-			} else if (semid < 0)
-				err_exit("semget", errno);
-			else
-				retry = 10;
-		} while (retry < 5);
-		/* We can't create a new semaphore set in 5 tries */
-		if (retry == 5)
+		semid = semget(semkey, 2, IPC_CREAT|IPC_EXCL);
+		if (semid < 0)
 			err_exit("semget", errno);
 
 		/* Init both new sem to 1 */
@@ -393,7 +374,7 @@ int main(int argc, char **argv)
 	/* getlck */
 	if (lock_cmd == 0) {
 		/* wait sem created and initialized */
-		retry = 5;
+		int retry = 5;
 		do {
 			semid = semget(semkey, 2, 0);
 			if (semid != -1)
@@ -406,11 +387,6 @@ int main(int argc, char **argv)
 				err_exit("getlk_semget", errno);
 			}
 		} while (1);
-		do {
-			memset(&sem_ds, 0, sizeof(sem_ds));
-			semu.buf = &sem_ds;
-			ret = semctl(semid, 0, IPC_STAT, semu);
-		} while (!(ret == 0 && sem_ds.sem_otime != 0));
 
 		/* wait sem0 == 0 (setlk and close fd done) */
 		sop.sem_num = 0;
diff --git a/tests/generic/478 b/tests/generic/478
index 480762d2..2478256b 100755
--- a/tests/generic/478
+++ b/tests/generic/478
@@ -94,6 +94,9 @@ _supported_fs generic
 _require_test
 _require_ofd_locks
 
+# rm possibly stalled sem
+ipcrm -S $BASHPID 2>/dev/null
+
 # real QA test starts here
 # prepare a 4k testfile in TEST_DIR
 $XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
@@ -101,8 +104,11 @@ $XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
 
 do_test()
 {
-	local soptions="$1"
-	local goptions="$2"
+	local _so="$1 -K $BASHPID"
+	local _go="$2 -K $BASHPID"
+	shift 2
+	local soptions="$_so"
+	local goptions="$_go"
 	# print options and getlk output for debug
 	echo $* >> $seqres.full 2>&1
 	# -s : do setlk
@@ -113,7 +119,7 @@ do_test()
 	wait $!
 
 	# add -F to clone with CLONE_FILES
-	soptions="$1 -F"
+	soptions="$_so -F"
 	# with -F, new locks are always file to place
 	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
 	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
@@ -121,7 +127,7 @@ do_test()
 	wait $!
 
 	# add -d to dup and close
-	soptions="$1 -d"
+	soptions="$_so -d"
 	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
 	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
 		tee -a $seqres.full
-- 
2.39.2

