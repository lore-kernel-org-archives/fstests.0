Received: from mx1.redhat.com ([209.132.183.28]:54148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbdGYIE1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Jul 2017 04:04:27 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] generic/446: make sure all background processes are dead before umount
Date: Tue, 25 Jul 2017 16:04:21 +0800
Message-Id: <20170725080421.15306-1-eguan@redhat.com>
In-Reply-To: <20170724101125.13309-1-eguan@redhat.com>
References: <20170724101125.13309-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: yangx.jy@cn.fujitsu.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

The $dread_pid refers to the while-true-do loop, wait for $dread_pid
doesn't mean the xfs_io direct read process is already dead,
sometimes xfs_io process is still running and blocking
_scratch_unmount.

Fix it by making the direct read does a fixed number of loop and
break out the second mmap-fpunch loop if the first loop exits. At
this point we're sure that there's no unfinished background process
blocking the umount.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- move 'kill' to while loop condition to simplify the second loop
- add more comments about when to exit the loop

 tests/generic/446 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/generic/446 b/tests/generic/446
index 62ae449de6b1..6a1b69aa2edc 100755
--- a/tests/generic/446
+++ b/tests/generic/446
@@ -61,20 +61,20 @@ filesz=$((65536 * 2))
 $XFS_IO_PROG -f -c "truncate $((filesz * 2))" $SCRATCH_MNT/file >> $seqres.full
 
 # run a background dio read to a hole in a loop
-while true; do
+for i in `seq 0 999`; do
 	$XFS_IO_PROG -d -c "pread 0 $filesz" $SCRATCH_MNT/file > /dev/null 2>&1
 done &
 
 dread_pid=$!
 
 # run mapped write to the same hole as dio read
-for i in `seq 0 999`; do
+# loop until background dio read exits
+while kill -s 0 $dread_pid >/dev/null 2>&1; do
 	$XFS_IO_PROG -c "mmap 0 $filesz" -c "mwrite 0 $filesz" $SCRATCH_MNT/file \
 		> /dev/null
 	$XFS_IO_PROG -c "fpunch 0 $filesz" $SCRATCH_MNT/file > /dev/null
 done
 
-kill -9 $dread_pid > /dev/null 2>&1
 wait $dread_pid > /dev/null 2>&1
 
 echo "Silence is golden"
-- 
2.13.3

