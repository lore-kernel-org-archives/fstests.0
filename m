Received: from mx1.redhat.com ([209.132.183.28]:48838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfDHCjH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 7 Apr 2019 22:39:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3649F18DF7B
        for <fstests@vger.kernel.org>; Mon,  8 Apr 2019 02:39:07 +0000 (UTC)
From: Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH] generic/504: fix hard coded fd number
Date: Mon,  8 Apr 2019 10:38:59 +0800
Message-Id: <20190408023859.1985-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Murphy Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Bash supports file discriptor assignment in this way. So remove the hard
coded numbers. Also close this opened fd in cleanup.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 tests/generic/504 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/generic/504 b/tests/generic/504
index 21d86051..19c6a0e7 100755
--- a/tests/generic/504
+++ b/tests/generic/504
@@ -21,6 +21,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
+	exec {test_fd}<&-
 	cd /
 	rm -f $tmp.*
 }
@@ -45,9 +46,9 @@ tf_inode=$(stat -c %i $testfile)
 echo inode $tf_inode >> $seqres.full
 
 # Create new fd by exec
-exec 9> $testfile
+exec {test_fd}> $testfile
 # flock locks the fd then exits, we should see the lock info even the owner is dead
-flock -x 9
+flock -x $test_fd
 cat /proc/locks >> $seqres.full
 
 # Checking
-- 
2.21.0
