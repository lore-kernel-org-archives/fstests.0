Received: from mx2.suse.de ([195.135.220.15]:54105 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751345AbdFFNhc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Jun 2017 09:37:32 -0400
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] generic/019: Silence possible kill failure
Date: Tue,  6 Jun 2017 16:37:22 +0300
Message-Id: <1496756242-16390-1-git-send-email-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

When the filesystem is force-killed in generic/019 and fsstress is compiled
with DEBUG then it's possible for check_cwd() to fail. In this case fsstress
would just die and invoking kill on its pid would produce an error to the
output file:

	+./tests/generic/019: line 157: kill: (32750) - No such process

Fix this possibility by ignoring the result of the output command,
this won't affect the test coverage.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/generic/019 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/019 b/tests/generic/019
index 84e62f5c..3b24c87c 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -154,7 +154,7 @@ _workout()
 	    >> $seqres.full 2>&1 && \
 	    _fail "failed: still able to perform integrity fsync on $SCRATCH_MNT"
 
-	kill $fs_pid
+	kill $fs_pid &> /dev/null
 	wait $fs_pid
 	wait $fio_pid
 
-- 
2.12.3

