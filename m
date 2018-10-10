Received: from mx2.suse.de ([195.135.220.15]:33006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbeJKHUb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 Oct 2018 03:20:31 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3858FB0B2
        for <fstests@vger.kernel.org>; Wed, 10 Oct 2018 23:56:00 +0000 (UTC)
From: Anthony Iliopoulos <ailiopoulos@suse.com>
Subject: [PATCH] common/reflink: fix error messages in _require_scratch_dedupe()
Date: Thu, 11 Oct 2018 01:55:50 +0200
Message-Id: <20181010235550.18742-1-ailiopoulos@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Anthony Iliopoulos <ailiopoulos@suse.com>
List-ID: <fstests@vger.kernel.org>

In case dedupe returns an error in _require_scratch_dedupe(),
report the error for the scratch rather than for the test
filesystem.

Signed-off-by: Anthony Iliopoulos <ailiopoulos@suse.com>
---
 common/reflink | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/reflink b/common/reflink
index e2663277..11561a76 100644
--- a/common/reflink
+++ b/common/reflink
@@ -145,11 +145,11 @@ _require_scratch_dedupe()
 	$XFS_IO_PROG -f -c "pwrite -S 0x61 0 65536" "$SCRATCH_MNT/file2" > /dev/null
 	testio="$($XFS_IO_PROG -f -c "dedupe $SCRATCH_MNT/file1 0 0 65536" "$SCRATCH_MNT/file2" 2>&1)"
 	echo $testio | grep -q "Operation not supported" && \
-		_notrun "Dedupe not supported by test filesystem type: $FSTYP"
+		_notrun "Dedupe not supported by scratch filesystem type: $FSTYP"
 	echo $testio | grep -q "Inappropriate ioctl for device" && \
-		_notrun "Dedupe not supported by test filesystem type: $FSTYP"
+		_notrun "Dedupe not supported by scratch filesystem type: $FSTYP"
 	echo $testio | grep -q "Invalid argument" && \
-		_notrun "Dedupe not supported by test filesystem type: $FSTYP"
+		_notrun "Dedupe not supported by scratch filesystem type: $FSTYP"
 	_scratch_unmount
 }
 
-- 
2.16.3
