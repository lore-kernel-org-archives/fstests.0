Received: from mx2.suse.de ([195.135.220.15]:50094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3B2V (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 29 May 2019 21:28:21 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B590AF2D
        for <fstests@vger.kernel.org>; Thu, 30 May 2019 01:28:20 +0000 (UTC)
From: Qu Wenruo <wqu@suse.com>
Subject: [PATCH] fstests: btrfs/190: Fix a typo for seqres.full
Date: Thu, 30 May 2019 09:28:15 +0800
Message-Id: <20190530012815.11053-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

$seqref.full -> $seqres.full

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/190 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/190 b/tests/btrfs/190
index a594c6319060..7d3d300737c2 100755
--- a/tests/btrfs/190
+++ b/tests/btrfs/190
@@ -66,7 +66,7 @@ _log_writes_remove
 cur=$(_log_writes_find_next_fua 0)
 echo "cur=$cur" >> $seqres.full
 while [ ! -z "$cur" ]; do
-	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqref.full
+	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
 
 	# Test that no crashes happen or any other kind of failure.
 	_scratch_mount
-- 
2.21.0
