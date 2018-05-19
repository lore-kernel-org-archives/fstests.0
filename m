Received: from imap.thunk.org ([74.207.234.97]:56268 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752546AbeESVrY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 19 May 2018 17:47:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic: add tests 405 and 459 to the group 'thin'
Date: Sat, 19 May 2018 17:47:19 -0400
Message-Id: <20180519214719.14821-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Currently the only test in group 'thin' is 347.  On some recent
kernels tests that use dm-thin causing kernel crashes, so it's useful
to be able to be exclude all tests that use dm-thin.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/group | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/group b/tests/generic/group
index 65152cf6..5588a596 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -407,7 +407,7 @@
 402 auto quick rw
 403 auto quick attr
 404 auto quick insert
-405 auto mkfs
+405 auto mkfs thin
 406 auto quick
 407 auto quick clone metadata
 408 auto quick clone dedupe metadata
@@ -461,7 +461,7 @@
 456 auto quick metadata
 457 auto log replay clone
 458 auto quick clone
-459 auto
+459 auto thin
 460 auto quick rw
 461 auto shutdown stress
 462 auto quick dax
-- 
2.16.1.72.g5be1f00a9a

