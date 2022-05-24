Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FF1C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 07:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiEXHeV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 03:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbiEXHeU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 03:34:20 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D97616AA4A
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 00:34:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A2BD110E6B14
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 17:34:14 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-00FkVS-JP
        for fstests@vger.kernel.org; Tue, 24 May 2022 17:34:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-008A6F-II
        for fstests@vger.kernel.org;
        Tue, 24 May 2022 17:34:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 7/8] fstests: Set up BUS trap for tests by default
Date:   Tue, 24 May 2022 17:34:10 +1000
Message-Id: <20220524073411.1943480-8-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524073411.1943480-1-david@fromorbit.com>
References: <20220524073411.1943480-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=628c8a77
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=qAQehwIhCC8NqeAZNDsA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

About 160 individual tests re-register the cleanup trap just to have
it run on a BUS error signal. Just add the BUS signal to the default
set of traps initialised by _register_cleanup() and get rid of these
extra registrations.

This was mostly done with this script:

$ for f in `git grep -l "register_cleanup.*BUS"` ; do
> sed -i -e '/_register_cleanup "_cleanup" BUS/,+1d'
> done

With a small number of non-matching conversions done by hand.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/preamble   | 4 ++--
 tests/ext4/023    | 2 --
 tests/generic/161 | 2 --
 tests/generic/162 | 2 --
 tests/generic/163 | 2 --
 tests/generic/164 | 2 --
 tests/generic/165 | 2 --
 tests/generic/166 | 2 --
 tests/generic/167 | 2 --
 tests/generic/168 | 2 --
 tests/generic/170 | 2 --
 tests/generic/247 | 2 --
 tests/generic/333 | 2 --
 tests/generic/334 | 2 --
 tests/generic/349 | 2 --
 tests/generic/350 | 2 --
 tests/generic/351 | 2 --
 tests/generic/356 | 2 --
 tests/generic/357 | 2 --
 tests/generic/358 | 2 --
 tests/generic/359 | 2 --
 tests/generic/372 | 2 --
 tests/generic/373 | 2 --
 tests/generic/374 | 2 --
 tests/generic/414 | 2 --
 tests/generic/425 | 2 --
 tests/generic/553 | 2 --
 tests/generic/554 | 2 --
 tests/generic/564 | 2 --
 tests/generic/565 | 2 --
 tests/generic/670 | 2 --
 tests/generic/671 | 2 --
 tests/generic/672 | 2 --
 tests/xfs/017     | 2 --
 tests/xfs/138     | 2 --
 tests/xfs/162     | 2 --
 tests/xfs/262     | 2 --
 tests/xfs/280     | 2 --
 tests/xfs/285     | 2 --
 tests/xfs/286     | 2 --
 tests/xfs/349     | 2 --
 tests/xfs/350     | 2 --
 tests/xfs/351     | 2 --
 tests/xfs/352     | 2 --
 tests/xfs/353     | 2 --
 tests/xfs/354     | 2 --
 tests/xfs/355     | 2 --
 tests/xfs/356     | 2 --
 tests/xfs/357     | 2 --
 tests/xfs/358     | 2 --
 tests/xfs/359     | 2 --
 tests/xfs/360     | 2 --
 tests/xfs/361     | 2 --
 tests/xfs/362     | 2 --
 tests/xfs/363     | 2 --
 tests/xfs/364     | 2 --
 tests/xfs/365     | 2 --
 tests/xfs/366     | 2 --
 tests/xfs/367     | 2 --
 tests/xfs/368     | 2 --
 tests/xfs/369     | 2 --
 tests/xfs/370     | 2 --
 tests/xfs/371     | 2 --
 tests/xfs/372     | 2 --
 tests/xfs/373     | 2 --
 tests/xfs/374     | 2 --
 tests/xfs/375     | 2 --
 tests/xfs/376     | 2 --
 tests/xfs/377     | 2 --
 tests/xfs/378     | 2 --
 tests/xfs/379     | 2 --
 tests/xfs/380     | 2 --
 tests/xfs/381     | 2 --
 tests/xfs/382     | 2 --
 tests/xfs/383     | 2 --
 tests/xfs/384     | 2 --
 tests/xfs/385     | 2 --
 tests/xfs/386     | 2 --
 tests/xfs/387     | 2 --
 tests/xfs/388     | 2 --
 tests/xfs/389     | 2 --
 tests/xfs/390     | 2 --
 tests/xfs/391     | 2 --
 tests/xfs/392     | 2 --
 tests/xfs/393     | 2 --
 tests/xfs/394     | 2 --
 tests/xfs/395     | 2 --
 tests/xfs/396     | 2 --
 tests/xfs/397     | 2 --
 tests/xfs/398     | 2 --
 tests/xfs/399     | 2 --
 tests/xfs/400     | 2 --
 tests/xfs/401     | 2 --
 tests/xfs/402     | 2 --
 tests/xfs/403     | 2 --
 tests/xfs/404     | 2 --
 tests/xfs/405     | 2 --
 tests/xfs/406     | 2 --
 tests/xfs/407     | 2 --
 tests/xfs/408     | 2 --
 tests/xfs/409     | 2 --
 tests/xfs/410     | 2 --
 tests/xfs/411     | 2 --
 tests/xfs/412     | 2 --
 tests/xfs/413     | 2 --
 tests/xfs/414     | 2 --
 tests/xfs/415     | 2 --
 tests/xfs/416     | 2 --
 tests/xfs/417     | 2 --
 tests/xfs/418     | 2 --
 tests/xfs/422     | 2 --
 tests/xfs/423     | 2 --
 tests/xfs/425     | 2 --
 tests/xfs/426     | 2 --
 tests/xfs/427     | 2 --
 tests/xfs/428     | 2 --
 tests/xfs/429     | 2 --
 tests/xfs/430     | 2 --
 tests/xfs/444     | 2 --
 tests/xfs/453     | 2 --
 tests/xfs/454     | 2 --
 tests/xfs/455     | 2 --
 tests/xfs/456     | 2 --
 tests/xfs/457     | 2 --
 tests/xfs/458     | 2 --
 tests/xfs/459     | 2 --
 tests/xfs/460     | 2 --
 tests/xfs/461     | 2 --
 tests/xfs/462     | 2 --
 tests/xfs/463     | 2 --
 tests/xfs/464     | 2 --
 tests/xfs/465     | 2 --
 tests/xfs/466     | 2 --
 tests/xfs/467     | 2 --
 tests/xfs/468     | 2 --
 tests/xfs/469     | 2 --
 tests/xfs/470     | 2 --
 tests/xfs/471     | 2 --
 tests/xfs/472     | 2 --
 tests/xfs/473     | 2 --
 tests/xfs/474     | 2 --
 tests/xfs/475     | 2 --
 tests/xfs/476     | 2 --
 tests/xfs/477     | 2 --
 tests/xfs/478     | 2 --
 tests/xfs/479     | 2 --
 tests/xfs/480     | 2 --
 tests/xfs/481     | 2 --
 tests/xfs/482     | 2 --
 tests/xfs/483     | 2 --
 tests/xfs/484     | 2 --
 tests/xfs/485     | 2 --
 tests/xfs/486     | 2 --
 tests/xfs/487     | 2 --
 tests/xfs/488     | 2 --
 tests/xfs/489     | 2 --
 tests/xfs/495     | 2 --
 tests/xfs/496     | 2 --
 tests/xfs/497     | 2 --
 tests/xfs/498     | 2 --
 tests/xfs/499     | 2 --
 tests/xfs/503     | 2 +-
 tests/xfs/507     | 2 +-
 tests/xfs/517     | 2 +-
 164 files changed, 5 insertions(+), 325 deletions(-)

diff --git a/common/preamble b/common/preamble
index 99e60a40..e96dd36b 100644
--- a/common/preamble
+++ b/common/preamble
@@ -42,10 +42,10 @@ _register_cleanup()
 	shift
 
 	# clear out existing traps first
-	trap - EXIT HUP INT QUIT TERM $*
+	trap - EXIT HUP INT QUIT TERM BUS $*
 
 	test -n "$cleanup" && cleanup="${cleanup}; "
-	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
+	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM BUS $*
 }
 
 # Prepare to run a fstest by initializing the required global variables to
diff --git a/tests/ext4/023 b/tests/ext4/023
index ebc5ffe3..06d2aeba 100755
--- a/tests/ext4/023
+++ b/tests/ext4/023
@@ -11,8 +11,6 @@
 . ./common/preamble
 _begin_fstest auto quick scrub
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/generic/161 b/tests/generic/161
index 44d3d8f0..6f5e5edc 100755
--- a/tests/generic/161
+++ b/tests/generic/161
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/162 b/tests/generic/162
index 0dc17f75..9d35c5bd 100755
--- a/tests/generic/162
+++ b/tests/generic/162
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone dedupe
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/163 b/tests/generic/163
index 4a6c341e..157bb090 100755
--- a/tests/generic/163
+++ b/tests/generic/163
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone dedupe
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/164 b/tests/generic/164
index 8e0b630b..f0fa74e0 100755
--- a/tests/generic/164
+++ b/tests/generic/164
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/165 b/tests/generic/165
index d9e6a6e9..cdfb7f7f 100755
--- a/tests/generic/165
+++ b/tests/generic/165
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/166 b/tests/generic/166
index 0eb2ec9c..2f3f4453 100755
--- a/tests/generic/166
+++ b/tests/generic/166
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/167 b/tests/generic/167
index ae5fa5eb..a2e3aac3 100755
--- a/tests/generic/167
+++ b/tests/generic/167
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/168 b/tests/generic/168
index 575ff08c..f45cda58 100755
--- a/tests/generic/168
+++ b/tests/generic/168
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/170 b/tests/generic/170
index d323ab8f..1c1fbe2f 100755
--- a/tests/generic/170
+++ b/tests/generic/170
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/247 b/tests/generic/247
index becc89e7..d88038c9 100755
--- a/tests/generic/247
+++ b/tests/generic/247
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick rw
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/333 b/tests/generic/333
index bf1967ce..32f90bdd 100755
--- a/tests/generic/333
+++ b/tests/generic/333
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/334 b/tests/generic/334
index b9c14b87..90102295 100755
--- a/tests/generic/334
+++ b/tests/generic/334
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/349 b/tests/generic/349
index da331b95..b879e866 100755
--- a/tests/generic/349
+++ b/tests/generic/349
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest blockdev rw zero
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/scsi_debug
diff --git a/tests/generic/350 b/tests/generic/350
index d8b2f272..4a65bd87 100755
--- a/tests/generic/350
+++ b/tests/generic/350
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest blockdev rw punch
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/scsi_debug
diff --git a/tests/generic/351 b/tests/generic/351
index fb16da16..8f5af94f 100755
--- a/tests/generic/351
+++ b/tests/generic/351
@@ -13,8 +13,6 @@
 . ./common/preamble
 _begin_fstest blockdev rw punch collapse insert zero
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/scsi_debug
diff --git a/tests/generic/356 b/tests/generic/356
index ffc7bed5..d34255e1 100755
--- a/tests/generic/356
+++ b/tests/generic/356
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone swap
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/357 b/tests/generic/357
index ce748f85..359a2530 100755
--- a/tests/generic/357
+++ b/tests/generic/357
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone swap
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/358 b/tests/generic/358
index 8c73ba36..676e93f3 100755
--- a/tests/generic/358
+++ b/tests/generic/358
@@ -13,8 +13,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/359 b/tests/generic/359
index 25692058..76ba7b15 100755
--- a/tests/generic/359
+++ b/tests/generic/359
@@ -15,8 +15,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/372 b/tests/generic/372
index b83aa598..b502c364 100755
--- a/tests/generic/372
+++ b/tests/generic/372
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/373 b/tests/generic/373
index e85308c7..ad4c9d7f 100755
--- a/tests/generic/373
+++ b/tests/generic/373
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/374 b/tests/generic/374
index f66d1397..f6c8bb54 100755
--- a/tests/generic/374
+++ b/tests/generic/374
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone dedupe
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/414 b/tests/generic/414
index 01b9da8e..3dfee41b 100755
--- a/tests/generic/414
+++ b/tests/generic/414
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/425 b/tests/generic/425
index 13a76563..885d99bf 100755
--- a/tests/generic/425
+++ b/tests/generic/425
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick attr
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/553 b/tests/generic/553
index 4a3d3953..884ac0a5 100755
--- a/tests/generic/553
+++ b/tests/generic/553
@@ -12,8 +12,6 @@
 . ./common/preamble
 _begin_fstest auto quick copy_range
 
-_register_cleanup "_cleanup" BUS
-
 workdir="$TEST_DIR/test-$seq"
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/554 b/tests/generic/554
index b9efee0d..918ee5c6 100755
--- a/tests/generic/554
+++ b/tests/generic/554
@@ -12,8 +12,6 @@
 . ./common/preamble
 _begin_fstest auto quick copy_range swap
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/generic/564 b/tests/generic/564
index 7ed5ccc1..e47c9868 100755
--- a/tests/generic/564
+++ b/tests/generic/564
@@ -12,8 +12,6 @@
 . ./common/preamble
 _begin_fstest auto quick copy_range
 
-_register_cleanup "_cleanup" BUS
-
 # Override the default cleanup function.
 _cleanup()
 {
diff --git a/tests/generic/565 b/tests/generic/565
index fd71d1e3..20e199bf 100755
--- a/tests/generic/565
+++ b/tests/generic/565
@@ -12,8 +12,6 @@
 . ./common/preamble
 _begin_fstest auto quick copy_range
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/generic/670 b/tests/generic/670
index 4a895d90..49e66d90 100755
--- a/tests/generic/670
+++ b/tests/generic/670
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/generic/671 b/tests/generic/671
index b6cc0573..d72bee2c 100755
--- a/tests/generic/671
+++ b/tests/generic/671
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/generic/672 b/tests/generic/672
index 9e3a97ec..dd4870d2 100755
--- a/tests/generic/672
+++ b/tests/generic/672
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/017 b/tests/xfs/017
index 14e29b98..514ca198 100755
--- a/tests/xfs/017
+++ b/tests/xfs/017
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest mount auto quick stress
 
-_register_cleanup "_cleanup; rm -f $tmp.*"
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/138 b/tests/xfs/138
index 966ac03a..a5aca080 100755
--- a/tests/xfs/138
+++ b/tests/xfs/138
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 
 # real QA test starts here
diff --git a/tests/xfs/162 b/tests/xfs/162
index 16922ff6..d3c8f72c 100755
--- a/tests/xfs/162
+++ b/tests/xfs/162
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick attr repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/262 b/tests/xfs/262
index 78db5e34..a36b947a 100755
--- a/tests/xfs/262
+++ b/tests/xfs/262
@@ -11,8 +11,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/fuzzy
diff --git a/tests/xfs/280 b/tests/xfs/280
index bc26e629..0552009c 100755
--- a/tests/xfs/280
+++ b/tests/xfs/280
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/285 b/tests/xfs/285
index 711211d4..e1cd18df 100755
--- a/tests/xfs/285
+++ b/tests/xfs/285
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/fuzzy
diff --git a/tests/xfs/286 b/tests/xfs/286
index 7edc9c42..a6fdcde5 100755
--- a/tests/xfs/286
+++ b/tests/xfs/286
@@ -9,8 +9,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/fuzzy
diff --git a/tests/xfs/349 b/tests/xfs/349
index 76745097..058a8e51 100755
--- a/tests/xfs/349
+++ b/tests/xfs/349
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers scrub
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/350 b/tests/xfs/350
index aeb99578..6ffad920 100755
--- a/tests/xfs/350
+++ b/tests/xfs/350
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/351 b/tests/xfs/351
index 74765aea..7fa8b12c 100755
--- a/tests/xfs/351
+++ b/tests/xfs/351
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/352 b/tests/xfs/352
index 49bd85b2..9dbe5275 100755
--- a/tests/xfs/352
+++ b/tests/xfs/352
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/353 b/tests/xfs/353
index b58dc9cb..346066ed 100755
--- a/tests/xfs/353
+++ b/tests/xfs/353
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/354 b/tests/xfs/354
index b10ce1d6..de7eb31d 100755
--- a/tests/xfs/354
+++ b/tests/xfs/354
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/355 b/tests/xfs/355
index 530c9a97..fa523dfd 100755
--- a/tests/xfs/355
+++ b/tests/xfs/355
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/356 b/tests/xfs/356
index 9d5ff251..9293efba 100755
--- a/tests/xfs/356
+++ b/tests/xfs/356
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/357 b/tests/xfs/357
index 8a2c920e..6f285380 100755
--- a/tests/xfs/357
+++ b/tests/xfs/357
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/358 b/tests/xfs/358
index a00eb6f9..d886f59a 100755
--- a/tests/xfs/358
+++ b/tests/xfs/358
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/359 b/tests/xfs/359
index f0a82db4..4851c9c1 100755
--- a/tests/xfs/359
+++ b/tests/xfs/359
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/360 b/tests/xfs/360
index 3942ffd1..6a5e6031 100755
--- a/tests/xfs/360
+++ b/tests/xfs/360
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/361 b/tests/xfs/361
index b7ee0f6f..1934fd69 100755
--- a/tests/xfs/361
+++ b/tests/xfs/361
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/362 b/tests/xfs/362
index f711661b..553ed2f0 100755
--- a/tests/xfs/362
+++ b/tests/xfs/362
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/363 b/tests/xfs/363
index 6be9109e..a556715c 100755
--- a/tests/xfs/363
+++ b/tests/xfs/363
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/364 b/tests/xfs/364
index fcd18fe6..dc283576 100755
--- a/tests/xfs/364
+++ b/tests/xfs/364
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/365 b/tests/xfs/365
index 6f116f9b..0c017f50 100755
--- a/tests/xfs/365
+++ b/tests/xfs/365
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/366 b/tests/xfs/366
index 4c651288..2630ad69 100755
--- a/tests/xfs/366
+++ b/tests/xfs/366
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/367 b/tests/xfs/367
index c474a9e7..bed1106e 100755
--- a/tests/xfs/367
+++ b/tests/xfs/367
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/368 b/tests/xfs/368
index b1c1f976..926497fa 100755
--- a/tests/xfs/368
+++ b/tests/xfs/368
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/369 b/tests/xfs/369
index 5e6d8d9b..5fda356f 100755
--- a/tests/xfs/369
+++ b/tests/xfs/369
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/370 b/tests/xfs/370
index 0a916242..f8dcb39c 100755
--- a/tests/xfs/370
+++ b/tests/xfs/370
@@ -11,8 +11,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/371 b/tests/xfs/371
index a9b914d9..e9ebce27 100755
--- a/tests/xfs/371
+++ b/tests/xfs/371
@@ -11,8 +11,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/372 b/tests/xfs/372
index c39a9175..9525f71f 100755
--- a/tests/xfs/372
+++ b/tests/xfs/372
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/373 b/tests/xfs/373
index 324aa9fe..2876e48e 100755
--- a/tests/xfs/373
+++ b/tests/xfs/373
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/374 b/tests/xfs/374
index e3af7e4b..a5e2182b 100755
--- a/tests/xfs/374
+++ b/tests/xfs/374
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/375 b/tests/xfs/375
index cb0efefe..f0db9223 100755
--- a/tests/xfs/375
+++ b/tests/xfs/375
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/376 b/tests/xfs/376
index 2470e1d9..3334bd1e 100755
--- a/tests/xfs/376
+++ b/tests/xfs/376
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/377 b/tests/xfs/377
index eabb03fb..34d15fc3 100755
--- a/tests/xfs/377
+++ b/tests/xfs/377
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/378 b/tests/xfs/378
index c1fb40e6..84722f2e 100755
--- a/tests/xfs/378
+++ b/tests/xfs/378
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/379 b/tests/xfs/379
index 1b5bfa41..ca45b603 100755
--- a/tests/xfs/379
+++ b/tests/xfs/379
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/380 b/tests/xfs/380
index aba8441c..5581ca9a 100755
--- a/tests/xfs/380
+++ b/tests/xfs/380
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/381 b/tests/xfs/381
index ea0c44db..b7124a98 100755
--- a/tests/xfs/381
+++ b/tests/xfs/381
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/382 b/tests/xfs/382
index 6cbc2bcf..f4e92572 100755
--- a/tests/xfs/382
+++ b/tests/xfs/382
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/383 b/tests/xfs/383
index a7875998..d2a99040 100755
--- a/tests/xfs/383
+++ b/tests/xfs/383
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/384 b/tests/xfs/384
index 409dbbf4..f4cd4c82 100755
--- a/tests/xfs/384
+++ b/tests/xfs/384
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/385 b/tests/xfs/385
index 2133d296..c4bf2084 100755
--- a/tests/xfs/385
+++ b/tests/xfs/385
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/386 b/tests/xfs/386
index edeaa9a0..34d6a43d 100755
--- a/tests/xfs/386
+++ b/tests/xfs/386
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/387 b/tests/xfs/387
index cd46f6fc..c4200aa8 100755
--- a/tests/xfs/387
+++ b/tests/xfs/387
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/388 b/tests/xfs/388
index 42e780c8..59866eb3 100755
--- a/tests/xfs/388
+++ b/tests/xfs/388
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/389 b/tests/xfs/389
index 258c5ef0..8dec5595 100755
--- a/tests/xfs/389
+++ b/tests/xfs/389
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/390 b/tests/xfs/390
index c3fecd44..6f2050d6 100755
--- a/tests/xfs/390
+++ b/tests/xfs/390
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/391 b/tests/xfs/391
index f5b90467..9cdc0f5c 100755
--- a/tests/xfs/391
+++ b/tests/xfs/391
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/392 b/tests/xfs/392
index 9044da0c..f746b842 100755
--- a/tests/xfs/392
+++ b/tests/xfs/392
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/393 b/tests/xfs/393
index 700691e1..c0a05b5c 100755
--- a/tests/xfs/393
+++ b/tests/xfs/393
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/394 b/tests/xfs/394
index c9eabcd8..e4d5c3a6 100755
--- a/tests/xfs/394
+++ b/tests/xfs/394
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/395 b/tests/xfs/395
index dcbfb51e..45c42247 100755
--- a/tests/xfs/395
+++ b/tests/xfs/395
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/396 b/tests/xfs/396
index 3209967d..8b9dff61 100755
--- a/tests/xfs/396
+++ b/tests/xfs/396
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/397 b/tests/xfs/397
index ebfd7f63..df7905d2 100755
--- a/tests/xfs/397
+++ b/tests/xfs/397
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/398 b/tests/xfs/398
index 08573f36..34d807c4 100755
--- a/tests/xfs/398
+++ b/tests/xfs/398
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/399 b/tests/xfs/399
index 0a5a0bd5..3f72b0c0 100755
--- a/tests/xfs/399
+++ b/tests/xfs/399
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/400 b/tests/xfs/400
index f85c04cc..f43b785e 100755
--- a/tests/xfs/400
+++ b/tests/xfs/400
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/401 b/tests/xfs/401
index 4c19665e..6c47354d 100755
--- a/tests/xfs/401
+++ b/tests/xfs/401
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/402 b/tests/xfs/402
index f42b6465..87a75888 100755
--- a/tests/xfs/402
+++ b/tests/xfs/402
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/403 b/tests/xfs/403
index 8e7ab07b..6b3a0154 100755
--- a/tests/xfs/403
+++ b/tests/xfs/403
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/404 b/tests/xfs/404
index c0f5c917..54ec36bf 100755
--- a/tests/xfs/404
+++ b/tests/xfs/404
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/405 b/tests/xfs/405
index e33eb8f1..ab5cdbeb 100755
--- a/tests/xfs/405
+++ b/tests/xfs/405
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/406 b/tests/xfs/406
index 78db1807..0adfdf56 100755
--- a/tests/xfs/406
+++ b/tests/xfs/406
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair realtime
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/407 b/tests/xfs/407
index 5a43775b..1c4665ad 100755
--- a/tests/xfs/407
+++ b/tests/xfs/407
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair realtime
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/408 b/tests/xfs/408
index 8049d6be..45ac8b23 100755
--- a/tests/xfs/408
+++ b/tests/xfs/408
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair realtime
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/409 b/tests/xfs/409
index adac95fe..275ef70d 100755
--- a/tests/xfs/409
+++ b/tests/xfs/409
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair realtime
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/410 b/tests/xfs/410
index e98a63eb..8d14de99 100755
--- a/tests/xfs/410
+++ b/tests/xfs/410
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/411 b/tests/xfs/411
index cfe77961..203670ce 100755
--- a/tests/xfs/411
+++ b/tests/xfs/411
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/412 b/tests/xfs/412
index 8b89dd6a..6007846a 100755
--- a/tests/xfs/412
+++ b/tests/xfs/412
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/413 b/tests/xfs/413
index c4b525c2..ceccc803 100755
--- a/tests/xfs/413
+++ b/tests/xfs/413
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/414 b/tests/xfs/414
index ee5db9c8..5db4f4bf 100755
--- a/tests/xfs/414
+++ b/tests/xfs/414
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/415 b/tests/xfs/415
index ab757629..0725b3de 100755
--- a/tests/xfs/415
+++ b/tests/xfs/415
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/416 b/tests/xfs/416
index 3e213068..77b8e789 100755
--- a/tests/xfs/416
+++ b/tests/xfs/416
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/417 b/tests/xfs/417
index 3d09ec7e..68bdd6c2 100755
--- a/tests/xfs/417
+++ b/tests/xfs/417
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/418 b/tests/xfs/418
index c4ba385c..a9b81952 100755
--- a/tests/xfs/418
+++ b/tests/xfs/418
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/422 b/tests/xfs/422
index 77db492e..09125fa8 100755
--- a/tests/xfs/422
+++ b/tests/xfs/422
@@ -11,8 +11,6 @@
 . ./common/preamble
 _begin_fstest dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/fuzzy
diff --git a/tests/xfs/423 b/tests/xfs/423
index be56f311..b196e0a4 100755
--- a/tests/xfs/423
+++ b/tests/xfs/423
@@ -12,8 +12,6 @@
 . ./common/preamble
 _begin_fstest dangerous_scrub
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/fuzzy
diff --git a/tests/xfs/425 b/tests/xfs/425
index c2e16ee8..47639543 100755
--- a/tests/xfs/425
+++ b/tests/xfs/425
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/426 b/tests/xfs/426
index e52b15f2..8df30fbd 100755
--- a/tests/xfs/426
+++ b/tests/xfs/426
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/427 b/tests/xfs/427
index 19f45fbd..9ab28e1b 100755
--- a/tests/xfs/427
+++ b/tests/xfs/427
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/428 b/tests/xfs/428
index 338e659d..10fcf3f7 100755
--- a/tests/xfs/428
+++ b/tests/xfs/428
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/429 b/tests/xfs/429
index a4aeb6e4..1a38c574 100755
--- a/tests/xfs/429
+++ b/tests/xfs/429
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/430 b/tests/xfs/430
index d94f65bd..09086810 100755
--- a/tests/xfs/430
+++ b/tests/xfs/430
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/444 b/tests/xfs/444
index 69158f03..ac63ae13 100755
--- a/tests/xfs/444
+++ b/tests/xfs/444
@@ -13,8 +13,6 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-_register_cleanup "_cleanup; rm -f $tmp.*"
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/453 b/tests/xfs/453
index 62974453..d0084508 100755
--- a/tests/xfs/453
+++ b/tests/xfs/453
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/454 b/tests/xfs/454
index 2540cd01..2f84bf67 100755
--- a/tests/xfs/454
+++ b/tests/xfs/454
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/455 b/tests/xfs/455
index 96820bc3..7628030d 100755
--- a/tests/xfs/455
+++ b/tests/xfs/455
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/456 b/tests/xfs/456
index dca03e10..ecc3999d 100755
--- a/tests/xfs/456
+++ b/tests/xfs/456
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/457 b/tests/xfs/457
index 332eeb98..20d7d2f2 100755
--- a/tests/xfs/457
+++ b/tests/xfs/457
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/458 b/tests/xfs/458
index ce03d687..c9ffe967 100755
--- a/tests/xfs/458
+++ b/tests/xfs/458
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/459 b/tests/xfs/459
index d166160f..f980b2c8 100755
--- a/tests/xfs/459
+++ b/tests/xfs/459
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/460 b/tests/xfs/460
index 0daafa30..be2016d3 100755
--- a/tests/xfs/460
+++ b/tests/xfs/460
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/461 b/tests/xfs/461
index 2d20c69d..effb7933 100755
--- a/tests/xfs/461
+++ b/tests/xfs/461
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/462 b/tests/xfs/462
index 587facc0..067bfd6a 100755
--- a/tests/xfs/462
+++ b/tests/xfs/462
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/463 b/tests/xfs/463
index 7270f701..dc197cf4 100755
--- a/tests/xfs/463
+++ b/tests/xfs/463
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/464 b/tests/xfs/464
index 59d25ae1..a0c5766e 100755
--- a/tests/xfs/464
+++ b/tests/xfs/464
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/465 b/tests/xfs/465
index 71399300..095b98f5 100755
--- a/tests/xfs/465
+++ b/tests/xfs/465
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/466 b/tests/xfs/466
index c1a1628a..5d435fa0 100755
--- a/tests/xfs/466
+++ b/tests/xfs/466
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/467 b/tests/xfs/467
index 42b820d1..ecd73223 100755
--- a/tests/xfs/467
+++ b/tests/xfs/467
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/468 b/tests/xfs/468
index 34612c88..58ad0a77 100755
--- a/tests/xfs/468
+++ b/tests/xfs/468
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/469 b/tests/xfs/469
index 630b3329..85aa832e 100755
--- a/tests/xfs/469
+++ b/tests/xfs/469
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/470 b/tests/xfs/470
index acc43ba7..d1285a52 100755
--- a/tests/xfs/470
+++ b/tests/xfs/470
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/471 b/tests/xfs/471
index 7883a00a..a8e29d72 100755
--- a/tests/xfs/471
+++ b/tests/xfs/471
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/472 b/tests/xfs/472
index a4ab9d75..60bee9a5 100755
--- a/tests/xfs/472
+++ b/tests/xfs/472
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/473 b/tests/xfs/473
index cbeed345..4ce19861 100755
--- a/tests/xfs/473
+++ b/tests/xfs/473
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/474 b/tests/xfs/474
index 746e3531..a10edcbb 100755
--- a/tests/xfs/474
+++ b/tests/xfs/474
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/475 b/tests/xfs/475
index 20053afe..2d843b9b 100755
--- a/tests/xfs/475
+++ b/tests/xfs/475
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/476 b/tests/xfs/476
index f8f79e4f..8ff03331 100755
--- a/tests/xfs/476
+++ b/tests/xfs/476
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/477 b/tests/xfs/477
index 0c2e2b36..de12b8df 100755
--- a/tests/xfs/477
+++ b/tests/xfs/477
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/478 b/tests/xfs/478
index 44e42e3e..9d867b12 100755
--- a/tests/xfs/478
+++ b/tests/xfs/478
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/479 b/tests/xfs/479
index 9101d651..ef91f5c2 100755
--- a/tests/xfs/479
+++ b/tests/xfs/479
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/480 b/tests/xfs/480
index 4f3ae6dc..3cc3adbf 100755
--- a/tests/xfs/480
+++ b/tests/xfs/480
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/481 b/tests/xfs/481
index 48c7580c..43a32ce5 100755
--- a/tests/xfs/481
+++ b/tests/xfs/481
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair realtime
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/482 b/tests/xfs/482
index 0192b94c..35e1edc8 100755
--- a/tests/xfs/482
+++ b/tests/xfs/482
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair realtime
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/483 b/tests/xfs/483
index d7b0101a..f4a141cb 100755
--- a/tests/xfs/483
+++ b/tests/xfs/483
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/484 b/tests/xfs/484
index 27522bbd..9284d7fa 100755
--- a/tests/xfs/484
+++ b/tests/xfs/484
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/485 b/tests/xfs/485
index efffbb85..015d93c9 100755
--- a/tests/xfs/485
+++ b/tests/xfs/485
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/486 b/tests/xfs/486
index 6d7f4031..474f05a0 100755
--- a/tests/xfs/486
+++ b/tests/xfs/486
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/487 b/tests/xfs/487
index 337541bb..38909b53 100755
--- a/tests/xfs/487
+++ b/tests/xfs/487
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/488 b/tests/xfs/488
index 43477689..fb1e7e4c 100755
--- a/tests/xfs/488
+++ b/tests/xfs/488
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/489 b/tests/xfs/489
index c70e674c..c1886888 100755
--- a/tests/xfs/489
+++ b/tests/xfs/489
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/495 b/tests/xfs/495
index 8da61f23..d0cc51a5 100755
--- a/tests/xfs/495
+++ b/tests/xfs/495
@@ -12,8 +12,6 @@
 . ./common/preamble
 _begin_fstest auto quick repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/496 b/tests/xfs/496
index a2624d2e..c09e5a75 100755
--- a/tests/xfs/496
+++ b/tests/xfs/496
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/497 b/tests/xfs/497
index 9a985d8c..f16eb5c6 100755
--- a/tests/xfs/497
+++ b/tests/xfs/497
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_scrub dangerous_online_repair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/498 b/tests/xfs/498
index 20bd326a..4543a5e8 100755
--- a/tests/xfs/498
+++ b/tests/xfs/498
@@ -10,8 +10,6 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers dangerous_norepair
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 . ./common/filter
 . ./common/populate
diff --git a/tests/xfs/499 b/tests/xfs/499
index b5597708..34728cf4 100755
--- a/tests/xfs/499
+++ b/tests/xfs/499
@@ -11,8 +11,6 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-_register_cleanup "_cleanup" BUS
-
 # Import common functions.
 
 # real QA test starts here
diff --git a/tests/xfs/503 b/tests/xfs/503
index 9dec0ff0..c23a0dbb 100755
--- a/tests/xfs/503
+++ b/tests/xfs/503
@@ -15,7 +15,7 @@ local_cleanup()
 	rm -rf $testdir
 	_cleanup
 }
-_register_cleanup local_cleanup BUS
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/507 b/tests/xfs/507
index abd16e38..a180290b 100755
--- a/tests/xfs/507
+++ b/tests/xfs/507
@@ -22,7 +22,7 @@ _loop_cleanup()
 	test -n "$loop_dev" &&_destroy_loop_device $loop_dev
 	_cleanup
 }
-_register_cleanup _loop_cleanup BUS
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/reflink
diff --git a/tests/xfs/517 b/tests/xfs/517
index 015a7a5f..bab0efa8 100755
--- a/tests/xfs/517
+++ b/tests/xfs/517
@@ -14,7 +14,7 @@ local_cleanup()
 	$XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT > /dev/null 2>&1
 	_cleanup
 }
-_register_cleanup local_cleanup BUS
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
-- 
2.35.1

