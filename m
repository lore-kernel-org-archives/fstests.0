Received: from mx2.suse.de ([195.135.220.15]:54921 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbcDRTcq (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 Apr 2016 15:32:46 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 8B175AB5D
	for <fstests@vger.kernel.org>; Mon, 18 Apr 2016 19:32:43 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 5/5] generic/038: Avoid EBUSY errors on umount
Date: Mon, 18 Apr 2016 21:32:35 +0200
Message-Id: <1461007955-7921-6-git-send-email-jack@suse.cz>
In-Reply-To: <1461007955-7921-1-git-send-email-jack@suse.cz>
References: <1461007955-7921-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Although the test waits for running subshells after sending SIGTERM
signal to them, it does not wait for subprocesses of those subshells
properly. Thus we can hit EBUSY errors when umount is called. Make
subshells wait for executed subprocesses when receiving SIGTERM to avoid
the problem.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/038 | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/generic/038 b/tests/generic/038
index 59aed67ab2ff..025e1b0fe7a6 100755
--- a/tests/generic/038
+++ b/tests/generic/038
@@ -77,6 +77,10 @@ rm -f $seqres.full
 # fstrim loop below.
 fallocate_loop()
 {
+	# Wait for running subcommand before exitting so that
+	# mountpoint is not busy when we try to unmount it
+	trap "wait; exit" SIGTERM
+
 	local name=$1
 	while true; do
 		$XFS_IO_PROG -f -c "falloc -k 0 1G" \
@@ -90,6 +94,10 @@ fallocate_loop()
 
 trim_loop()
 {
+	# Wait for running subcommand before exitting so that
+	# mountpoint is not busy when we try to unmount it
+	trap "wait; exit" SIGTERM
+
 	while true; do
 		$FSTRIM_PROG $SCRATCH_MNT
 	done
@@ -115,7 +123,9 @@ create_files()
 	for ((n = 0; n < 4; n++)); do
 		mkdir $SCRATCH_MNT/$n
 		(
-               for ((i = 1; i <= $nr_files; i++)); do
+		trap "wait; exit" SIGTERM
+
+		for ((i = 1; i <= $nr_files; i++)); do
 			$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 3900" \
 				$SCRATCH_MNT/$n/"${prefix}_$i" &> /dev/null
 			if [ $? -ne 0 ]; then
@@ -152,9 +162,6 @@ kill ${fallocate_pids[@]}
 kill ${trim_pids[@]}
 wait
 
-# Sleep a bit, otherwise umount fails often with EBUSY (TODO: investigate why).
-sleep 3
-
 # The fstests framework will now check for fs consistency with fsck.
 # The trimming was racy and caused some btree nodes to get full of zeroes on
 # disk, which obviously caused fs metadata corruption. The race often lead
-- 
2.6.6

