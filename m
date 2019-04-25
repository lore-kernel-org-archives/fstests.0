Received: from mx2.suse.de ([195.135.220.15]:51332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726916AbfDYRhv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 Apr 2019 13:37:51 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F3BAACD5
        for <fstests@vger.kernel.org>; Thu, 25 Apr 2019 17:37:50 +0000 (UTC)
From: David Sterba <dsterba@suse.com>
Subject: [PATCH] generic/487: reorder logdev detection after filesystem detection
Date: Thu, 25 Apr 2019 19:31:30 +0200
Message-Id: <20190425173130.21706-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
List-ID: <fstests@vger.kernel.org>

If SCRATCH_LOGDEV variable is unset, the _require_logdev check fails
earlier than the following check that decides that this test should not
be run on 'btrfs'.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/generic/487 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/487 b/tests/generic/487
index 8952284cf66f..75db3bfb1333 100755
--- a/tests/generic/487
+++ b/tests/generic/487
@@ -36,7 +36,6 @@ _require_scratch_nocheck
 # This test uses "dm" without taking into account the data could be on
 # realtime subvolume, thus the test will fail with rtinherit=1
 _require_no_rtinherit
-_require_logdev
 
 sflag='-s'
 case $FSTYP in
@@ -47,6 +46,7 @@ case $FSTYP in
                 ;;
 esac
 
+_require_logdev
 _require_dm_target error
 
 rm -f $seqres.full
-- 
2.21.0
