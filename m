Received: from prv3-mh.provo.novell.com ([137.65.250.26]:45738 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdJWBtT (ORCPT
        <rfc822;groupwise-fstests@vger.kernel.org:0:0>);
        Sun, 22 Oct 2017 21:49:19 -0400
From: Qu Wenruo <wqu@suse.com>
Subject: [PATCH] fstests: btrfs/130: Remove from auto group
Date: Mon, 23 Oct 2017 09:48:54 +0800
Message-Id: <20171023014854.24367-1-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

No agreement on how to fix it in the foreseeable future.
So remove it from auto group to prevent newbie tester from spending days
waiting it to finish.

Reported-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index a7ff7b06dcae..e17c275e2bb0 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -132,7 +132,7 @@
 127 auto quick send
 128 auto quick send
 129 auto quick send
-130 auto clone send
+130 clone send dangerous
 131 auto quick
 132 auto enospc
 133 auto quick send
-- 
2.14.2

