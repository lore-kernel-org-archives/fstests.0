Received: from imap.thunk.org ([74.207.234.97]:41712 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965311AbeE2TBc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 15:01:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] fstests: update the punch, collapse, insert, and zero groups
Date: Tue, 29 May 2018 15:01:28 -0400
Message-Id: <20180529190128.20807-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Update the group files to annotate those tests which have a
_require_xfs_io_command for punch, collapse, insert, and zero.  This
makes it easier to exclude tests that use one of these fallocate
commands.  Or if you want to specifically test for those fallocate
commands you can do this.

I maintain an out-of-tree xfstests patch which uses an XFS_IO_AVOID
environment variable to suppress running tests that use punch,
collapse, insert, etc.  This was rejected because of the claim that it
could be done using groups.  The reason why I still keep it as an
out-of-tree patch is because I was sure that when people added or
remove tests, they would forget to update the groups file with these
groups.

This commit is a demonstration of why my reason for keeping support
for XFS_IO_AVOID as an out-of-tree patch was prescient.  :-)

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/btrfs/group   |  4 ++--
 tests/generic/group | 10 +++++-----
 tests/xfs/group     | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index f04ee8d5..487f3e10 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -110,7 +110,7 @@
 105 auto quick send
 106 auto quick clone compress
 107 auto quick prealloc
-108 auto quick send clone punch
+108 auto quick send clone punch collapse
 109 auto quick send clone compress
 110 auto quick send
 111 auto quick send
@@ -161,5 +161,5 @@
 156 auto quick trim
 157 auto quick raid
 158 auto quick raid scrub
-159 auto quick
+159 auto quick collapse
 160 auto quick
diff --git a/tests/generic/group b/tests/generic/group
index d0d42e97..349a66a6 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -350,7 +350,7 @@
 345 auto
 346 auto quick rw
 347 auto quick rw thin
-348 auto quick metadata
+348 auto quick metadata insert
 349 blockdev rw zero
 350 blockdev rw punch
 351 blockdev rw punch collapse insert zero
@@ -394,7 +394,7 @@
 389 auto quick acl
 390 auto freeze stress
 391 auto quick rw
-392 shutdown auto quick metadata
+392 shutdown auto quick metadata punch
 393 auto quick rw
 394 auto quick
 395 auto quick encrypt
@@ -448,7 +448,7 @@
 443 auto quick rw
 444 auto quick acl
 445 auto quick rw
-446 auto quick rw
+446 auto quick rw punch
 447 auto clone
 448 auto quick rw
 449 auto quick acl enospc
@@ -460,7 +460,7 @@
 455 auto log replay
 456 auto quick metadata
 457 auto log replay clone
-458 auto quick clone
+458 auto quick clone collapse zero
 459 auto thin
 460 auto quick rw
 461 auto shutdown stress
@@ -495,7 +495,7 @@
 491 auto quick freeze mount
 492 auto quick
 493 auto quick swap
-494 auto quick swap
+494 auto quick swap punch
 495 auto quick swap
 900 auto quick verity
 901 auto quick verity
diff --git a/tests/xfs/group b/tests/xfs/group
index e5fd1c6d..2319f58f 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -111,7 +111,7 @@
 111 ioctl
 112 fuzzers
 113 fuzzers
-114 auto quick clone rmap
+114 auto quick clone rmap collapse insert
 115 auto quick fuzzers
 116 quota auto quick
 117 fuzzers
@@ -329,7 +329,7 @@
 329 auto quick clone fsr
 330 auto quick clone fsr quota
 331 auto quick rmap clone
-332 auto quick rmap clone
+332 auto quick rmap clone collapse punch insert zero
 333 auto quick rmap
 334 auto quick rmap
 335 auto rmap
@@ -340,7 +340,7 @@
 340 auto quick rmap
 341 auto quick rmap
 342 auto quick rmap
-343 auto quick rmap
+343 auto quick rmap collapse punch insert zero
 344 auto quick clone
 345 auto quick clone
 346 auto quick clone
@@ -417,8 +417,8 @@
 417 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 418 dangerous_fuzzers dangerous_scrub dangerous_repair
 419 auto quick swap
-420 auto quick clone dedupe
-421 auto quick clone dedupe
+420 auto quick clone dedupe punch
+421 auto quick clone dedupe punch
 422 dangerous_scrub dangerous_online_repair
 423 dangerous_scrub
 424 auto quick db
@@ -440,7 +440,7 @@
 440 auto quick clone quota
 441 auto quick clone quota
 442 auto stress clone quota
-443 auto quick ioctl fsr
+443 auto quick ioctl fsr punch
 444 auto quick
 445 auto quick filestreams
 446 auto quick
-- 
2.16.1.72.g5be1f00a9a

