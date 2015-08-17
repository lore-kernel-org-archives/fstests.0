Received: from mx1.redhat.com ([209.132.183.28]:57887 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbbHQNt6 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 17 Aug 2015 09:49:58 -0400
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] generic/084: use src/multi_open_unlink to replace tail command
Date: Mon, 17 Aug 2015 21:49:53 +0800
Message-Id: <1439819393-7713-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, david@fromorbit.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

generic/084 try to run 'tail' command, tail will use inotify.
There're some limit about the number of inotify. For example
fs.inotify.max_user_instances specifies an upper limit on
the number of inotify instances that can be created per real
user ID.

When I test on a machine with 154 cpu cores, this case run
failed, and hit many warning likes:

    +tail: inotify cannot be used, reverting to polling: Too many open files

Because the fs.inotify.max_user_instances is 128, so if we
try to tail 154 files, it will be failed.

So use src/multi_open_unlink to instead of tail will avoid
this problem.

Signed-off-by: Zorro Lang <zlang@redhat.com>
Reviewed-by: Eryu Guan <eguan@redhat.com>
Reviewed-by: Dave Chinner <david@fromorbit.com>
---
 tests/generic/084 | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/tests/generic/084 b/tests/generic/084
index 3fec6c2..d5061a7 100755
--- a/tests/generic/084
+++ b/tests/generic/084
@@ -69,15 +69,8 @@ _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
 # create, open & unlinked files so unlinked inode list is not empty
-for i in `seq 1 $nr_cpu`; do
-	testfile=$SCRATCH_MNT/$seq.unlinked.$i
-	touch $testfile
-	tail -f $testfile &
-	tail_pids="$tail_pids $!"
-done
-# give tail some time to open the file before the file is removed
-sleep 1
-rm -f $SCRATCH_MNT/$seq.unlinked.*
+src/multi_open_unlink -f $SCRATCH_MNT/$seq.unlinked -n $nr_cpu -s 1000 &
+open_pid=$!
 
 # start link/unlink storm
 src=$SCRATCH_MNT/$seq.target
@@ -96,8 +89,8 @@ done &
 sleep 5
 kill $! >/dev/null 2>&1
 
-kill $tail_pids $link_pids >/dev/null 2>&1
-wait $tail_pids $link_pids
+kill $open_pid $link_pids >/dev/null 2>&1
+wait $open_pid $link_pids
 
 # all done, no oops/hang expected, _check_filesystems checks SCRATCH_DEV after test
 status=0
-- 
1.9.3

