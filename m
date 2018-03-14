Received: from mx2.suse.de ([195.135.220.15]:36728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbeCNOsp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 14 Mar 2018 10:48:45 -0400
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] generic/015: Issue sync after deleting the fillup file
Date: Wed, 14 Mar 2018 16:48:37 +0200
Message-Id: <1521038917-20863-1-git-send-email-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

This test fails on btrfs due to the presence of delayed processing
of file deletes if the file is smaller than 32mb. Initially commit
97575acd7495b412435d06229a6d94ed9a814ada tried to fix a similar
failure by bumping the size of the filesystem. However that change
had a knock-on effect in that the scratch filesystem created is
larger than 100mb and thus not created in mixed mode. This in turn
causes the fs to have only 20mb for file data (rest is taken by DUP
metadata). Naturally, this leads to file freeing taking up to
"transaction commit interval" (default 30 s) time to properly account
the freed space.

Not standards define when unlink operations should be accounted so
btrfs is well within its right to be implemented in that way. So
to avoid this edge case just issue a sync before taking the 2nd
free space reading.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/generic/015 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/015 b/tests/generic/015
index bdae86dd..cb7252b9 100755
--- a/tests/generic/015
+++ b/tests/generic/015
@@ -115,6 +115,8 @@ fi
 
 echo "check free space:"
 
+sync
+
 free2=`_free`
 if [ -z "$free2" ]
 then
-- 
2.12.3

