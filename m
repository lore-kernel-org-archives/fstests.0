Received: from mail.kernel.org ([198.145.29.99]:38718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392592AbfIXJtI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 24 Sep 2019 05:49:08 -0400
From: fdmanana@kernel.org
Subject: [PATCH] btrfs/036: fix sporadic failures when unmounting scratch filesystem
Date: Tue, 24 Sep 2019 10:49:02 +0100
Message-Id: <20190924094902.1243-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Often this test can fail on unmount because a 'btrfs subvolume snapshot'
command is still running and using the scratch the mount point:

  btrfs/036 168s ... umount: /home/fdmanana/btrfs-tests/scratch_1: target is busy
          (In some cases useful info about processes that
           use the device is found by lsof(8) or fuser(1).)
  _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
  (see /home/fdmanana/git/hub/xfstests/results//btrfs/036.full for details)

This happens because when we kill the process running the do_snapshots()
function we only kill the subshell and don't wait for any processes it
has spawned to finish before the subshell exits. Fix this by setting a
trap in the do_snapshots() function, so that when the subshell receives
a SIGTERM signal it waits for any running 'btrfs subvolume snapshot'
to finish before exitting. We were also not waiting for the subshell
to exit after sending it the SIGTERM signal, so fix that as well by
calling the 'wait' command after calling 'kill' to send that signal.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/036 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/btrfs/036 b/tests/btrfs/036
index cb578569..4280a84f 100755
--- a/tests/btrfs/036
+++ b/tests/btrfs/036
@@ -20,12 +20,19 @@ _cleanup()
 	# kill backgroud snapshots
 	if [ $snapshots_pid -ne 0 ] && ps -p $snapshots_pid | grep -q $snapshots_pid; then
 		kill -TERM $snapshots_pid 2> /dev/null
+		wait $snapshots_pid
 	fi
 	rm -f $tmp.*
 }
 
 do_snapshots()
 {
+	# Wait for any running 'btrfs subvolume snapshot' subcommand before
+	# exitting so that after the test kills the subshell running this
+	# function, it does not fail with EBUSY when unmounting the scratch
+	# device.
+	trap "wait; exit" SIGTERM
+
 	i=2
 	while [ 1 ]
 	do
-- 
2.11.0
