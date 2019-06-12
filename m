Received: from mail.kernel.org ([198.145.29.99]:58370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437919AbfFLKFu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Jun 2019 06:05:50 -0400
From: fdmanana@kernel.org
Subject: [PATCH] btrfs/146: remove unnecessary scratch unmount to avoid test failure
Date: Wed, 12 Jun 2019 11:05:44 +0100
Message-Id: <20190612100544.1890-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Right at the beginning of the test we are unmonting the scratch device,
however at this point the device was never mounted, so the unmount fails
with an error message like the following:

  umount: /home/fdmanana/btrfs-tests/scratch_1: not mounted

Which is not expected by the golden output and therefore causes the test
to fail.

Since the device/mount point was not mounted yet in the test, and since
the test framework unmounts the scratch device after each test finishes,
just remove the call to _scratch_unmount.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/146 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/btrfs/146 b/tests/btrfs/146
index 8ec3128b..18e2eec0 100755
--- a/tests/btrfs/146
+++ b/tests/btrfs/146
@@ -38,7 +38,6 @@ _require_test_program fsync-err
 _require_test_program dmerror
 
 # bring up dmerror device
-_scratch_unmount
 _dmerror_init
 
 # Replace first device with error-test device
-- 
2.11.0
