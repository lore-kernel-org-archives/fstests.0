Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56454 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006AbaLKM3e (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Dec 2014 07:29:34 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBBCTRlg012851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 11 Dec 2014 07:29:33 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/299: various fixes
Date: Thu, 11 Dec 2014 18:49:12 +0800
Message-Id: <1418294952-20035-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Fix three problems in generic/299

1. Use $XFS_IO_PROG instead of fallocate/truncate, old distros like
RHEL5 don't have these commands.

2. Remove $seqres.full before test, otherwise the file is growing all
the time.

3. Make sure fio really exits, otherwise fio would block umount. $pid is
the pid of function run_check not fio, sometimes fio is still there when
$pid is dead and blocking umount.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/299 | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/generic/299 b/tests/generic/299
index e8685a4..ae1bf74 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -125,20 +125,23 @@ _workout()
 	do
 	    for ((k=1; k <= NUM_JOBS; k++))
 	    do
-		fallocate -l $FILE_SIZE $SCRATCH_MNT/direct_aio.$k.0 \
+		$XFS_IO_PROG -f -c "falloc 0 $FILE_SIZE" $SCRATCH_MNT/direct_aio.$k.0 \
 			>> $seqres.full 2>&1
 	    done
 	    for ((k=1; k <= NUM_JOBS; k++))
 	    do
-		truncate -s 0 $SCRATCH_MNT/direct_aio.$k.0 >> $seqres.full 2>&1
+		$XFS_IO_PROG -f -c "truncate 0" $SCRATCH_MNT/direct_aio.$k.0 \
+			>>$seqres.full 2>&1
 	    done
 	    # Following like will check that pid is still run.
 	    # Once fio exit we can stop fallocate/truncate loop
-	    kill -0 $pid > /dev/null 2>&1 || break
+	    pgrep fio >/dev/null 2>&1 || break
 	done
 	wait $pid
 }
 
+rm -f $seqres.full
+
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 
-- 
1.8.3.1

