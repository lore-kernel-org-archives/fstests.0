Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:17795 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754185AbbHFA1n (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 5 Aug 2015 20:27:43 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1ZN91s-00087T-4J
	for fstests@vger.kernel.org; Thu, 06 Aug 2015 10:27:28 +1000
Received: from dave by disappointment with local (Exim 4.86_RC4)
	(envelope-from <dave@disappointment.disaster>)
	id 1ZN91s-0003TZ-3K
	for fstests@vger.kernel.org; Thu, 06 Aug 2015 10:27:28 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] generic/038: speed up file creation
Date: Thu,  6 Aug 2015 10:27:28 +1000
Message-Id: <1438820848-13325-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Now that generic/038 is running on my test machine, I notice how
slow it is:

generic/038      692s

11-12 minutes for a single test is way too long.
The test is creating
400,000 single block files, which can be easily parallelised and
hence run much faster than the test is currently doing.

Split the file creation up into 4 threads that create 100,000 files
each. 4 is chosen because XFS defaults to 4AGs, ext4 still has decent
speedups at 4 concurrent creates, and other filesystems aren't hurt
by excessive concurrency. The result:

generic/038      237s

on the same machine, which is roughly 3x faster and so it (just)
fast enough to to be considered acceptible.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/038 | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tests/generic/038 b/tests/generic/038
index 4d108cf..3c94a3b 100755
--- a/tests/generic/038
+++ b/tests/generic/038
@@ -105,19 +105,30 @@ trim_loop()
 # the fallocate calls happen. So we don't really care if they all succeed or
 # not, the goal is just to keep metadata space usage growing while data block
 # groups are deleted.
+#
+# reating 400,000 files sequentially is really slow, so speed it up a bit
+# by doing it concurrently with 4 threads in 4 separate directories.
 create_files()
 {
 	local prefix=$1
 
-	for ((i = 1; i <= 400000; i++)); do
-		$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 3900" \
-			$SCRATCH_MNT/"${prefix}_$i" &> /dev/null
-		if [ $? -ne 0 ]; then
-			echo "Failed creating file ${prefix}_$i" >>$seqres.full
-			break
-		fi
+	for ((n = 0; n < 4; n++)); do
+		mkdir $SCRATCH_MNT/$n
+		(
+		for ((i = 1; i <= 100000; i++)); do
+			$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 3900" \
+				$SCRATCH_MNT/$n/"${prefix}_$i" &> /dev/null
+			if [ $? -ne 0 ]; then
+				echo "Failed creating file $n/${prefix}_$i" >>$seqres.full
+				break
+			fi
+		done
+		) &
+		create_pids[$n]=$!
 	done
 
+	wait ${create_pids[@]}
+
 }
 
 _scratch_mkfs >>$seqres.full 2>&1
-- 
2.1.4

