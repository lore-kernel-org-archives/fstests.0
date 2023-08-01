Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F02C04A94
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Aug 2023 17:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjHARwl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjHARwf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Aug 2023 13:52:35 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788FE1FCB
        for <fstests@vger.kernel.org>; Tue,  1 Aug 2023 10:52:29 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:ab96:0:640:dd69:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 3DBDC60039;
        Tue,  1 Aug 2023 20:52:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OqVuX9uDSa60-ZLkJP35k;
        Tue, 01 Aug 2023 20:52:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690912346;
        bh=xNZ/B5wtmMGFUyvS7n0RsMtdLrFU+AO8nPCckqsTMxc=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=A0vGTmsFLAQ5UXTCjiKqhsw81qaw35qtpe4hvtdHsNLp1/R6NlpRI/stujcj1ovHq
         n2J+OEbgJQ2R02iMnDUtrqvIMeAsb+/8H53qRLPljVzFX5RElcsNQvY6SCo5gndnxk
         zU9ESjNbh4ny+C1EifFg+ryhRd7jop/Ck4aE23pI=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     fstests@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Murphy Zhou <xzhou@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH 1/2] t_ofd_locks: fix stalled semaphore handling
Date:   Tue,  1 Aug 2023 22:52:19 +0500
Message-Id: <20230801175220.1558342-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801175220.1558342-1-stsp2@yandex.ru>
References: <20230801175220.1558342-1-stsp2@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently IPC_RMID was attempted on a semid returned after failed
semget() with flags=IPC_CREAT|IPC_EXCL. So nothing was actually removed.

This patch introduces the much more reliable scheme where the wrapper
script creates and removes semaphores, passing a sem key to the test
binary via new -K option.

This patch speeds up the test ~5 times by removing the sem-awaiting
loop in a lock-getter process. As the semaphore is now created before
the test process started, there is no need to wait for anything.

CC: fstests@vger.kernel.org
CC: Murphy Zhou <xzhou@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Zorro Lang <zlang@redhat.com>

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
---
 src/t_ofd_locks.c | 77 +++++++++++++++--------------------------------
 tests/generic/478 | 37 ++++++++++++++++++++---
 2 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
index e77f2659..88ef2690 100644
--- a/src/t_ofd_locks.c
+++ b/src/t_ofd_locks.c
@@ -87,8 +87,6 @@ static void err_exit(char *op, int errn)
 	fprintf(stderr, "%s: %s\n", op, strerror(errn));
 	if (fd > 0)
 		close(fd);
-	if (semid > 0 && semctl(semid, 2, IPC_RMID) == -1)
-		perror("exit rmid");
 	exit(errn);
 }
 
@@ -180,16 +178,16 @@ int main(int argc, char **argv)
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
@@ -227,6 +225,9 @@ int main(int argc, char **argv)
 		case 'd':
 			use_dup = 1;
 			break;
+		case 'K':
+			semkey = strtol(optarg, NULL, 16);
+			break;
 		default:
 			usage(argv[0]);
 			return -1;
@@ -276,37 +277,15 @@ int main(int argc, char **argv)
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
+		semid = semget(semkey, 2, 0);
+		if (semid < 0)
 			err_exit("semget", errno);
 
 		/* Init both new sem to 1 */
@@ -382,35 +361,29 @@ int main(int argc, char **argv)
 		ts.tv_nsec = 0;
 		if (semtimedop(semid, &sop, 1, &ts) == -1)
 			err_exit("wait sem1 0", errno);
-
-		/* remove sem set after one round of test */
-		if (semctl(semid, 2, IPC_RMID, semu) == -1)
-			err_exit("rmid", errno);
 		close(fd);
 		exit(0);
 	}
 
 	/* getlck */
 	if (lock_cmd == 0) {
-		/* wait sem created and initialized */
-		retry = 5;
-		do {
-			semid = semget(semkey, 2, 0);
-			if (semid != -1)
-				break;
-			if (errno == ENOENT && retry) {
-				sleep(1);
-				retry--;
-				continue;
-			} else {
-				err_exit("getlk_semget", errno);
-			}
-		} while (1);
+		semid = semget(semkey, 2, 0);
+		if (semid < 0)
+			err_exit("getlk_semget", errno);
+
+		/*
+		 * Wait initialization complete.
+		 */
+		ret = -1;
 		do {
+			if (ret != -1)
+				usleep(100000);
 			memset(&sem_ds, 0, sizeof(sem_ds));
 			semu.buf = &sem_ds;
-			ret = semctl(semid, 0, IPC_STAT, semu);
-		} while (!(ret == 0 && sem_ds.sem_otime != 0));
+			ret = semctl(semid, 1, GETVAL, semu);
+			if (ret == -1)
+				err_exit("wait sem1 1", errno);
+		} while (ret != 1);
 
 		/* wait sem0 == 0 (setlk and close fd done) */
 		sop.sem_num = 0;
diff --git a/tests/generic/478 b/tests/generic/478
index 480762d2..419acc94 100755
--- a/tests/generic/478
+++ b/tests/generic/478
@@ -99,33 +99,62 @@ _require_ofd_locks
 $XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
 	$TEST_DIR/testfile >> $seqres.full 2>&1
 
+mk_sem()
+{
+	SEMID=$(ipcmk -S 2 | cut -d ":" -f 2 | tr -d '[:space:]')
+	if [ -z "$SEMID" ]; then
+		echo "ipcmk failed"
+		exit 1
+	fi
+	SEMKEY=$(ipcs -s | grep $SEMID | cut -d " " -f 1)
+	if [ -z "$SEMKEY" ]; then
+		echo "ipcs failed"
+		exit 1
+	fi
+}
+
+rm_sem()
+{
+	ipcrm -s $SEMID 2>/dev/null
+}
+
 do_test()
 {
-	local soptions="$1"
-	local goptions="$2"
+	local soptions
+	local goptions
 	# print options and getlk output for debug
 	echo $* >> $seqres.full 2>&1
+	mk_sem
+	soptions="$1 -K $SEMKEY"
+	goptions="$2 -K $SEMKEY"
 	# -s : do setlk
 	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
 	# -g : do getlk
 	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
 		tee -a $seqres.full
 	wait $!
+	rm_sem
 
+	mk_sem
 	# add -F to clone with CLONE_FILES
-	soptions="$1 -F"
+	soptions="$1 -F -K $SEMKEY"
+	goptions="$2 -K $SEMKEY"
 	# with -F, new locks are always file to place
 	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
 	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
 		tee -a $seqres.full
 	wait $!
+	rm_sem
 
+	mk_sem
 	# add -d to dup and close
-	soptions="$1 -d"
+	soptions="$1 -d -K $SEMKEY"
+	goptions="$2 -K $SEMKEY"
 	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
 	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
 		tee -a $seqres.full
 	wait $!
+	rm_sem
 }
 
 # Always setlk at range [0,9], getlk at range [0,9] [5,24] or [20,29].
-- 
2.39.2

