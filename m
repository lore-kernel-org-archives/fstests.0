Received: from mail.kernel.org ([198.145.29.99]:47918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfIJO0I (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Sep 2019 10:26:08 -0400
From: fdmanana@kernel.org
Subject: [PATCH] btrfs/079: fix failure to umount scratch fs due to running filefrag process
Date: Tue, 10 Sep 2019 15:26:01 +0100
Message-Id: <20190910142601.19752-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

The test fails sporadically when trying to unmount the scratch filesystem
because a filefrag process is still running against a file that exists on
the scrach filesystem. This is because killing the subshell running the
fiemap_work() function does not wait for any filefrag process to complete
first. We need to set a trap for the SIGTERM signal on the subshell so
that it waits for any filefrag process before exitting.

The failure resulted in error messages like the following:

  btrfs/079 57s ... umount: /home/fdmanana/btrfs-tests/scratch_1: target is busy
          (In some cases useful info about processes that
           use the device is found by lsof(8) or fuser(1).)
  _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
  (see /home/fdmanana/git/hub/xfstests/results//btrfs/079.full for details)

Fix this by adding a trap for SIGTERM.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/079 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/btrfs/079 b/tests/btrfs/079
index e848a261..1e9411be 100755
--- a/tests/btrfs/079
+++ b/tests/btrfs/079
@@ -77,6 +77,12 @@ _filter_error() {
 }
 
 fiemap_work() {
+	# Wait for any running 'filefrag' subcommand before exitting so that
+	# after the test kills the subshell running this function, it does not
+	# fail with EBUSY when unmounting the scratch device because the filefrag
+	# subcommand is still running with an open file on the scratch fs.
+	trap "wait; exit" SIGTERM
+
 	filename=$1
 	while true; do
 		$FILEFRAG_PROG $filename 2> $tmp.output 1> /dev/null
-- 
2.11.0
