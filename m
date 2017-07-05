Received: from mail-pg0-f68.google.com ([74.125.83.68]:34405 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdGEUjJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Jul 2017 16:39:09 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so42523pge.1
        for <fstests@vger.kernel.org>; Wed, 05 Jul 2017 13:39:08 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] generic/247: unmount test device, not scratch device
Date: Wed,  5 Jul 2017 13:37:54 -0700
Message-Id: <20170705203754.92140-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Brian Foster <bfoster@redhat.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Commit d55123c080cb ("generic/247: filter out expected XFS warnings for
mixed mmap/direct I/O") made generic/247 start explicitly unmounting the
scratch device.  However, the test doesn't actually use the scratch
device, so it will fail if SCRATCH_DEV is undefined.  Fix it by
unmounting the test device instead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/247 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/247 b/tests/generic/247
index 509e8808..aac70780 100755
--- a/tests/generic/247
+++ b/tests/generic/247
@@ -82,7 +82,7 @@ echo "Silence is golden."
 
 # unmount and check dmesg, filtering out expected XFS warnings about mixed
 # mmap/dio
-_scratch_unmount
+_test_unmount
 if [ "$FSTYP" == "xfs" ]; then
 	_check_dmesg _filter_xfs_dmesg
 else
-- 
2.13.2.725.g09c95d1e9-goog

