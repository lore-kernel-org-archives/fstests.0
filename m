Received: from mx2.suse.de ([195.135.220.15]:53376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbfCZPCB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 26 Mar 2019 11:02:01 -0400
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] fstests: Don't delete seqres.full file in generic/077
Date: Tue, 26 Mar 2019 17:01:58 +0200
Message-Id: <20190326150158.17700-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

When this test finishes there is no 079.full file with output from commands. 
Sometimes this information is useful for post mortem so stop deleting the 
file upon test completion. 

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/generic/077 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/077 b/tests/generic/077
index 284e25253c9e..d11b49c6ff15 100755
--- a/tests/generic/077
+++ b/tests/generic/077
@@ -73,6 +73,5 @@ cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
 _check_scratch_fs
 
 echo "*** all done"
-rm -f $seqres.full
 status=0
 exit
-- 
2.7.4
