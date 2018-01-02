Received: from mx2.suse.de ([195.135.220.15]:37816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeABRRQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 Jan 2018 12:17:16 -0500
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] generic/050: fix _require_local_device $SCRATCH_DEV check order
Date: Tue,  2 Jan 2018 17:17:05 +0000
Message-Id: <20180102171705.24066-1-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chengguang Xu <cgxu519@icloud.com>, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

Commit 2b4eae7fd825 ("common/rc: add scratch shutdown support for
overlayfs") added a _require_local_device check to generic tests 042 and
050.  However, for test 050, this check was added _before_ actually
verifying that a SCRATCH_DEV actually exists.  This patch simply re-orders
the _require_local_device to the right place.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 tests/generic/050 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/050 b/tests/generic/050
index dbf0ac5cd185..e6e8bc1b9733 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -44,9 +44,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 
-_require_local_device $SCRATCH_DEV
 _require_scratch_nocheck
 _require_scratch_shutdown
+_require_local_device $SCRATCH_DEV
 _require_norecovery
 
 _scratch_mkfs >/dev/null 2>&1
