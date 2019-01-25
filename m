Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfAYLqa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 25 Jan 2019 06:46:30 -0500
From: fdmanana@kernel.org
Subject: [PATCH 2/2] fstests: btrfs/081, fix killing of reader loop subshell
Date: Fri, 25 Jan 2019 11:46:24 +0000
Message-Id: <20190125114624.4004-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

The test creates a subshell that keeps running the 'cat' command against a
test file in an infinite loop, and after it kills the subshell it unmounts
the filesystem, after which point any 'cat' subcommand that runs after or
at that time will fail resulting in an unexpected golden output:

  $ ./check btrfs/081
  btrfs/081 3s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/081.out.bad)
      --- tests/btrfs/081.out	2018-09-16 21:30:48.501104179 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/081.out.bad	2019-01-24 20:36:18.989746185 +0000
      @@ -206,5 +206,6 @@
       Verifying file digests after cloning
       14968c092c68e32fa35e776392d14523  SCRATCH_MNT/foo
       14968c092c68e32fa35e776392d14523  SCRATCH_MNT/bar
      +cat: /mnt/scratch/bar: No such file or directory
       Verifying target file digest after umount + mount
       14968c092c68e32fa35e776392d14523  SCRATCH_MNT/bar
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/081.out /home/fdmanana/git/hub/xfstests/results//btrfs/081.out.bad'  to see the entire diff)
  Ran: btrfs/081
  Failures: btrfs/081
  Failed 1 of 1 tests

Fix that by adding a proper trap to the reader loop function so that the
subshell waits for executed 'cat' commands when it receives SIGTERM.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/081 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/btrfs/081 b/tests/btrfs/081
index 7e83525f..726a370f 100755
--- a/tests/btrfs/081
+++ b/tests/btrfs/081
@@ -69,6 +69,12 @@ create_target_file()
 
 reader_loop()
 {
+	# Wait for any running 'cat' subcommand before exitting so that after
+	# the test kills the reader loop subshell it does not fail with an
+	# error message from a 'cat' subcommand due to the test file being
+	# temporarily unavailable due to the scratch fs unmount operation.
+	trap "wait; exit" SIGTERM
+
 	local name=$1
 
 	while true; do
-- 
2.11.0
