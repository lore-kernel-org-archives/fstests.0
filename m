Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43043 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbaLKLpp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Dec 2014 06:45:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBBBjgs9031032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 11 Dec 2014 06:45:45 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] generic/299: various fixes
Date: Thu, 11 Dec 2014 18:58:49 +0800
Message-Id: <1418295529-20565-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1418294952-20035-1-git-send-email-eguan@redhat.com>
References: <1418294952-20035-1-git-send-email-eguan@redhat.com>
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

v2:
- remove $seqres.full before _require_fio, which writes to $seqres.full too

 tests/generic/299 | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/generic/299 b/tests/generic/299
index e8685a4..7d0fb5b 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -109,6 +109,8 @@ rw=randrw
 filename=buffered-aio-verifier
 EOF
 
+rm -f $seqres.full
+
 _require_fio $fio_config
 
 _workout()
@@ -125,16 +127,17 @@ _workout()
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
-- 
1.8.3.1

