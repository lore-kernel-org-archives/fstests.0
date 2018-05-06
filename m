Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:43750 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751849AbeEFXFi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 May 2018 19:05:38 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fFSil-0000XG-HG
        for fstests@vger.kernel.org; Mon, 07 May 2018 09:05:35 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fFSil-0001i8-E9
        for fstests@vger.kernel.org; Mon, 07 May 2018 09:05:35 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] fstests: many dangerous+auto tests are not dangerous anymore
Date: Mon,  7 May 2018 09:05:35 +1000
Message-Id: <20180506230535.6535-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

There are a bunch of tests that are run by the auto group that are
marked dangerous. This was done because the test exercised a crash
or other fatal error that has since been fixed. Remove the dangerous
tag from the auto tests that pass on a 4.17-rc3 kernel as they are
not dangerous anymore.

Signed-Off-By: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/group | 14 +++++++-------
 tests/xfs/group     | 16 ++++++++--------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/generic/group b/tests/generic/group
index 505383f70645..5de7facf0de7 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -70,7 +70,7 @@
 065 metadata auto quick
 066 metadata auto quick
 067 auto quick mount
-068 other auto freeze dangerous stress
+068 other auto freeze stress
 069 rw udf auto quick
 070 attr udf auto quick stress
 071 auto quick prealloc
@@ -282,7 +282,7 @@
 277 auto ioctl quick metadata
 278 auto quick clone
 279 auto quick clone
-280 auto quota freeze dangerous
+280 auto quota freeze
 281 auto quick clone
 282 auto quick clone
 283 auto quick clone
@@ -392,7 +392,7 @@
 387 auto clone
 388 shutdown auto log metadata
 389 auto quick acl
-390 auto freeze stress dangerous
+390 auto freeze stress
 391 auto quick rw
 392 shutdown auto quick metadata
 393 auto quick rw
@@ -408,7 +408,7 @@
 403 auto quick attr
 404 auto quick insert
 405 auto mkfs
-406 auto quick dangerous
+406 auto quick
 407 auto quick clone metadata
 408 auto quick clone dedupe metadata
 409 auto quick mount
@@ -448,7 +448,7 @@
 443 auto quick rw
 444 auto quick acl
 445 auto quick rw
-446 auto quick rw dangerous
+446 auto quick rw
 447 auto clone
 448 auto quick rw
 449 auto quick acl enospc
@@ -461,11 +461,11 @@
 456 auto quick metadata
 457 auto log replay clone
 458 auto quick clone
-459 auto dangerous
+459 auto
 460 auto quick rw
 461 auto shutdown stress
 462 auto quick dax
-463 auto quick clone dangerous
+463 auto quick clone
 464 auto rw
 465 auto rw quick aio
 466 auto quick rw
diff --git a/tests/xfs/group b/tests/xfs/group
index aeb8ba963ade..01a0b5afad88 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -112,11 +112,11 @@
 112 fuzzers
 113 fuzzers
 114 auto quick clone rmap
-115 auto quick fuzzers dangerous
+115 auto quick fuzzers
 116 quota auto quick
 117 fuzzers
-118 auto quick fsr dangerous
-119 log v2log auto freeze dangerous
+118 auto quick fsr
+119 log v2log auto freeze
 120 fuzzers
 121 shutdown log auto quick
 122 other auto quick clone
@@ -290,7 +290,7 @@
 291 auto repair
 292 auto mkfs quick
 293 auto quick
-294 auto dir metadata dangerous
+294 auto dir metadata
 295 auto logprint quick
 296 dump auto quick
 297 auto freeze
@@ -302,12 +302,12 @@
 303 auto quick quota
 304 auto quick quota
 305 auto quota
-306 auto dangerous quick punch
+306 auto quick punch
 307 auto quick clone
 308 auto quick clone
 309 auto clone
 310 auto clone rmap
-311 auto dangerous quick
+311 auto quick
 312 auto quick clone
 313 auto quick clone
 314 auto quick clone
@@ -427,14 +427,14 @@
 428 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 429 dangerous_fuzzers dangerous_scrub dangerous_repair
 430 dangerous_fuzzers dangerous_scrub dangerous_online_repair
-431 auto quick dangerous
+431 auto quick
 432 auto quick dir metadata
 433 auto quick attr
 434 auto quick clone fsr
 435 auto quick clone
 436 auto quick clone fsr
 437 auto quick other
-438 auto quick quota dangerous
+438 auto quick quota
 439 auto quick fuzzers log
 440 auto quick clone quota
 441 auto quick clone quota
-- 
2.17.0

