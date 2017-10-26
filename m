Received: from synology.com ([59.124.61.242]:52093 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbdJZGCj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Oct 2017 02:02:39 -0400
From: robbieko <robbieko@synology.com>
Subject: [PATCH] btrfs: fix offset in test Btrfs delalloc accounting overflow
Date: Thu, 26 Oct 2017 14:02:15 +0800
Message-Id: <1508997735-10630-1-git-send-email-robbieko@synology.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Robbie Ko <robbieko@synology.com>
List-ID: <fstests@vger.kernel.org>

From: Robbie Ko <robbieko@synology.com>

Found it when test btrfs delalloc accounting overflow, Fix offset error.
We will fill in the gaps between the created extents,
then outstanding extents will all be merged into 1.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 tests/btrfs/010 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/010 b/tests/btrfs/010
index ea201ad..00cac67 100755
--- a/tests/btrfs/010
+++ b/tests/btrfs/010
@@ -58,7 +58,7 @@ done
 # Fill in the gaps between the created extents. The outstanding extents will
 # all be merged into 1, but there will still be 32k reserved.
 for ((i = 0; i < 32 * 1024; i++)); do
-	$XFS_IO_PROG -f -c "pwrite $((2 * 4096 * i + 1)) 4096" "$test_file" >>"$seqres.full"
+	$XFS_IO_PROG -f -c "pwrite $((2 * 4096 * i + 4096)) 4096" "$test_file" >>"$seqres.full"
 done
 
 # Flush the delayed allocations.
-- 
1.9.1

