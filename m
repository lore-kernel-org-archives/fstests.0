Received: from bombadil.infradead.org ([198.137.202.133]:42068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfBRJFT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Feb 2019 04:05:19 -0500
Received: from [88.128.83.71] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gverV-0007Pw-VC
        for fstests@vger.kernel.org; Mon, 18 Feb 2019 09:05:18 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] add a seek group
Date: Mon, 18 Feb 2019 10:05:03 +0100
Message-Id: <20190218090503.12034-3-hch@lst.de>
In-Reply-To: <20190218090503.12034-1-hch@lst.de>
References: <20190218090503.12034-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This groups all tests exercising SEEK_DATA / SEEK_HOLE behavior.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/group   |  2 +-
 tests/generic/group | 12 ++++++------
 tests/xfs/group     |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index e32c84e4..8881c29d 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -9,7 +9,7 @@
 004 auto rw metadata
 005 auto defrag
 006 auto quick volume
-007 auto quick rw metadata send
+007 auto quick rw metadata send seek
 008 auto quick send
 009 auto quick subvol
 010 auto
diff --git a/tests/generic/group b/tests/generic/group
index cfd003d3..06e61fa7 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -287,8 +287,8 @@
 282 auto quick clone
 283 auto quick clone
 284 auto quick clone
-285 auto rw
-286 auto quick other
+285 auto rw seek
+286 auto quick other seek
 287 auto quick clone
 288 auto quick ioctl trim
 289 auto quick clone
@@ -438,7 +438,7 @@
 433 auto quick copy
 434 auto quick copy
 435 auto encrypt
-436 auto quick rw
+436 auto quick rw seek
 437 auto quick dax
 438 auto
 439 auto quick punch
@@ -447,10 +447,10 @@
 442 blockdev
 443 auto quick rw
 444 auto quick acl
-445 auto quick rw
+445 auto quick rw seek
 446 auto quick rw punch
 447 auto clone
-448 auto quick rw
+448 auto quick rw seek
 449 auto quick acl enospc
 450 auto quick rw
 451 auto quick rw aio
@@ -492,7 +492,7 @@
 487 auto quick
 488 auto quick
 489 auto quick attr log
-490 auto quick rw
+490 auto quick rw seek
 491 auto quick freeze mount
 492 auto quick
 493 auto quick swap
diff --git a/tests/xfs/group b/tests/xfs/group
index cd4bb72f..4f00ae10 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -417,8 +417,8 @@
 417 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 418 dangerous_fuzzers dangerous_scrub dangerous_repair
 419 auto quick swap
-420 auto quick clone punch
-421 auto quick clone punch
+420 auto quick clone punch seek
+421 auto quick clone punch seek
 422 dangerous_scrub dangerous_online_repair
 423 dangerous_scrub
 424 auto quick db
-- 
2.20.1
