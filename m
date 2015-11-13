Received: from mail.kernel.org ([198.145.29.136]:56503 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932444AbbKMQrf (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 13 Nov 2015 11:47:35 -0500
From: fdmanana@kernel.org
Subject: [PATCH] fstests: Fix generic/269 failure due to race killing fsstress job
Date: Fri, 13 Nov 2015 16:47:24 +0000
Message-Id: <1447433244-25894-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

When running the test generic/269 against a fast scratch device (loopback
device backed by a file on tmpfs) I often got a test failure due to the
fact that the fsstress job had already completed before the test attempted
to kill it, producing the following failure output:

generic/269 91s ... - output mismatch (see .../generic/269.out.bad)
    --- tests/generic/269.out	2014-11-17 20:59:50.974203000 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//generic/269.out.bad	2015-11-13 15:41:59.669893035 +0000
    @@ -3,3 +3,4 @@
     Run fsstress

     Run dd writers in parallel
    +./tests/generic/269: line 59: kill: (13417) - No such process
    ...
    (Run 'diff -u tests/generic/269.out .../generic/269.out.bad'  to see the entire diff)

So fix this false failure by redirecting the standard output and error
from the kill into the seq file.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/269 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/269 b/tests/generic/269
index fe648b5..0958222 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -56,7 +56,8 @@ _workout()
 			>> $seqres.full 2>&1
 		sleep $enospc_time
 	done
-	kill $pid
+	echo "Killing fsstress process..." >> $seqres.full
+	kill $pid >> $seqres.full 2>&1
 	wait $pid
 }
 
-- 
2.1.3

