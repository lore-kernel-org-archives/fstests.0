Received: from imap.thunk.org ([74.207.234.97]:50614 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdBUARO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 20 Feb 2017 19:17:14 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic,ext4: add defrag group
Date: Mon, 20 Feb 2017 19:17:02 -0500
Message-Id: <20170221001702.12575-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Apparently btrfs already has tests marked as belonging in the defrag
group, but none of the ext4 or generic tests were so marked.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/group    | 14 +++++++-------
 tests/generic/group |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/ext4/group b/tests/ext4/group
index c9e66b65..70d619e4 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -22,16 +22,16 @@
 017 fuzzers
 018 fuzzers
 019 fuzzers
-020 auto quick ioctl rw
+020 auto quick ioctl rw defrag
 021 auto quick
 022 auto quick attr dangerous
 023 auto quick scrub
 271 auto rw quick
-301 aio auto ioctl rw stress
-302 aio auto ioctl rw stress
-303 aio auto ioctl rw stress
-304 aio auto ioctl rw stress
+301 aio auto ioctl rw stress defrag
+302 aio auto ioctl rw stress defrag
+303 aio auto ioctl rw stress defrag
+304 aio auto ioctl rw stress defrag
 305 auto
 306 auto rw resize quick
-307 auto ioctl rw
-308 auto ioctl rw prealloc quick
+307 auto ioctl rw defrag
+308 auto ioctl rw prealloc quick defrag
diff --git a/tests/generic/group b/tests/generic/group
index 6fd5bcd2..bd358d52 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -20,7 +20,7 @@
 015 other auto quick enospc
 016 auto quick prealloc punch collapse
 017 auto prealloc collapse
-018 auto fsr quick
+018 auto fsr quick defrag
 019 aio dangerous enospc rw stress
 020 metadata attr udf auto quick
 021 auto quick prealloc punch collapse
@@ -326,7 +326,7 @@
 321 auto quick metadata log
 322 auto quick metadata log
 323 auto aio stress
-324 auto fsr quick
+324 auto fsr quick defrag
 325 auto quick data log
 326 auto quick clone
 327 auto quick clone
-- 
2.11.0.rc0.7.gbe5a750

