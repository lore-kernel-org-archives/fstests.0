Received: from mx2.suse.de ([195.135.220.15]:46334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730023AbfAUQdo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 11:33:44 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81786AFA3
        for <fstests@vger.kernel.org>; Mon, 21 Jan 2019 16:33:43 +0000 (UTC)
From: jeffm@suse.com
Subject: [PATCH 5/7] btrfs/023: skip trying to test raid56 without kernel support
Date: Mon, 21 Jan 2019 11:33:14 -0500
Message-Id: <20190121163316.20616-5-jeffm@suse.com>
In-Reply-To: <20190121163316.20616-1-jeffm@suse.com>
References: <20190121163316.20616-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

Older kernels don't support raid56.  This test is still valid for
other profiles, so skip raid56 if the kernel doesn't support it.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 tests/btrfs/023 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/023 b/tests/btrfs/023
index 6d9cc443..6c02113b 100755
--- a/tests/btrfs/023
+++ b/tests/btrfs/023
@@ -63,11 +63,13 @@ check_group_profile "RAID1"
 create_group_profile "raid10"
 check_group_profile "RAID10"
 
-create_group_profile "raid5"
-check_group_profile "RAID5"
+if [ -e "/sys/fs/btrfs/features/raid56" ]; then
+	create_group_profile "raid5"
+	check_group_profile "RAID5"
 
-create_group_profile "raid6"
-check_group_profile "RAID6"
+	create_group_profile "raid6"
+	check_group_profile "RAID6"
+fi
 
 # success, all done
 echo "Silence is golden"
-- 
2.16.4
