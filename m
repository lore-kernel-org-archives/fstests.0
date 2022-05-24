Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6601BC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 07:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiEXHeW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiEXHeV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 03:34:21 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E22262A20
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 00:34:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 99E0E10E6B12
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 17:34:14 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-00FkVE-Fj
        for fstests@vger.kernel.org; Tue, 24 May 2022 17:34:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-008A5w-EX
        for fstests@vger.kernel.org;
        Tue, 24 May 2022 17:34:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 3/8] xfs/*: clean up _cleanup override
Date:   Tue, 24 May 2022 17:34:06 +1000
Message-Id: <20220524073411.1943480-4-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524073411.1943480-1-david@fromorbit.com>
References: <20220524073411.1943480-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=628c8a77
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=yYIGlYhAp0FBg-SU3vMA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Use a local cleanup function and _register_cleanup properly.

Remove local cleanups that just do what the standard _cleanup and
test exist does.

Remove local cleanups that just remove test files and then do
standard _cleanup functionality.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/004     |  7 -------
 tests/xfs/006     |  7 ++++---
 tests/xfs/008     |  9 ++-------
 tests/xfs/009     |  7 -------
 tests/xfs/009.out |  1 -
 tests/xfs/010     |  8 --------
 tests/xfs/011     | 12 +++---------
 tests/xfs/012     | 10 ++--------
 tests/xfs/013     |  8 +++-----
 tests/xfs/014     |  8 +++-----
 tests/xfs/016     |  9 ---------
 tests/xfs/016.out |  1 -
 tests/xfs/017     |  7 -------
 tests/xfs/019     |  8 --------
 tests/xfs/019.out |  1 -
 tests/xfs/020     |  9 ++++-----
 tests/xfs/021     |  8 --------
 tests/xfs/021.out |  1 -
 tests/xfs/022     |  7 +++----
 tests/xfs/023     |  7 +++----
 tests/xfs/024     |  7 +++----
 tests/xfs/025     |  7 +++----
 tests/xfs/026     |  7 +++----
 tests/xfs/027     |  7 +++----
 tests/xfs/028     |  7 +++----
 tests/xfs/030     |  8 --------
 tests/xfs/033     |  8 --------
 tests/xfs/034     |  9 ---------
 tests/xfs/034.out |  1 -
 tests/xfs/035     |  6 +++---
 tests/xfs/036     |  7 +++----
 tests/xfs/037     |  7 +++----
 tests/xfs/038     |  7 +++----
 tests/xfs/039     |  7 +++----
 tests/xfs/041     |  8 --------
 tests/xfs/042     |  7 -------
 tests/xfs/043     |  7 +++----
 tests/xfs/046     |  7 +++----
 tests/xfs/047     |  7 +++----
 tests/xfs/049     | 21 +++++++++------------
 tests/xfs/050     |  8 --------
 tests/xfs/051     |  9 ++++-----
 tests/xfs/052     |  8 --------
 tests/xfs/055     |  7 +++----
 tests/xfs/056     |  7 +++----
 tests/xfs/057     | 16 ++++++++++------
 tests/xfs/059     |  7 +++----
 tests/xfs/060     |  7 +++----
 tests/xfs/061     |  7 +++----
 tests/xfs/063     |  7 +++----
 tests/xfs/064     |  7 +++----
 tests/xfs/065     |  7 +++----
 tests/xfs/066     |  9 ++++-----
 tests/xfs/068     |  7 +++----
 tests/xfs/070     |  7 +++----
 tests/xfs/071     |  8 --------
 tests/xfs/072     |  8 --------
 tests/xfs/073     | 11 +++++------
 tests/xfs/074     |  8 ++++----
 tests/xfs/076     |  8 --------
 tests/xfs/078     |  9 +++------
 tests/xfs/079     | 11 +++++------
 tests/xfs/080     |  7 -------
 tests/xfs/083     |  7 +++----
 tests/xfs/085     |  7 +++----
 tests/xfs/086     |  7 +++----
 tests/xfs/087     |  7 +++----
 tests/xfs/088     |  7 +++----
 tests/xfs/089     |  7 +++----
 tests/xfs/091     |  7 +++----
 tests/xfs/093     |  7 +++----
 tests/xfs/097     |  7 +++----
 tests/xfs/098     |  7 +++----
 tests/xfs/099     |  7 +++----
 tests/xfs/100     |  7 +++----
 tests/xfs/101     |  7 +++----
 tests/xfs/102     |  7 +++----
 tests/xfs/105     |  7 +++----
 tests/xfs/112     |  7 +++----
 tests/xfs/113     |  7 +++----
 tests/xfs/117     |  7 +++----
 tests/xfs/120     |  7 +++----
 tests/xfs/123     |  7 +++----
 tests/xfs/124     |  7 +++----
 tests/xfs/125     |  7 +++----
 tests/xfs/126     |  7 +++----
 tests/xfs/129     |  9 ++++-----
 tests/xfs/130     |  7 +++----
 tests/xfs/131     |  8 --------
 tests/xfs/139     |  7 -------
 tests/xfs/140     |  7 -------
 tests/xfs/141     | 11 +++++------
 tests/xfs/148     |  7 +++----
 tests/xfs/149     | 15 ++++++++-------
 tests/xfs/152     | 21 +++++++++------------
 tests/xfs/153     |  8 --------
 tests/xfs/157     |  8 ++++----
 tests/xfs/159     |  8 --------
 tests/xfs/167     |  9 +++++----
 tests/xfs/169     |  8 --------
 tests/xfs/177     |  6 +++---
 tests/xfs/181     | 10 ++++------
 tests/xfs/185     | 10 +++++-----
 tests/xfs/188     |  8 --------
 tests/xfs/189     |  8 +++-----
 tests/xfs/194     | 12 ------------
 tests/xfs/195     |  8 +-------
 tests/xfs/197     |  7 +------
 tests/xfs/199     |  7 -------
 tests/xfs/201     |  6 ------
 tests/xfs/206     | 12 ++++++------
 tests/xfs/220     |  7 -------
 tests/xfs/229     |  7 +------
 tests/xfs/231     |  7 +++----
 tests/xfs/232     |  7 +++----
 tests/xfs/234     |  9 ++++-----
 tests/xfs/236     |  8 --------
 tests/xfs/237     | 10 +++++-----
 tests/xfs/239     |  8 ++++----
 tests/xfs/240     | 10 +++++-----
 tests/xfs/241     |  8 ++++----
 tests/xfs/244     |  8 --------
 tests/xfs/250     |  6 +++---
 tests/xfs/253     |  9 ---------
 tests/xfs/259     |  8 +++++---
 tests/xfs/260     | 11 +----------
 tests/xfs/261     |  7 -------
 tests/xfs/264     |  7 +++----
 tests/xfs/265     |  8 --------
 tests/xfs/266     |  7 +++----
 tests/xfs/267     |  7 +++----
 tests/xfs/268     |  8 +++-----
 tests/xfs/269     |  7 -------
 tests/xfs/271     |  8 ++++----
 tests/xfs/272     |  8 ++++----
 tests/xfs/273     |  8 ++++----
 tests/xfs/274     |  8 ++++----
 tests/xfs/275     |  8 ++++----
 tests/xfs/276     |  8 ++++----
 tests/xfs/277     |  9 +++++----
 tests/xfs/279     |  9 ++++-----
 tests/xfs/281     |  7 +++----
 tests/xfs/282     |  7 +++----
 tests/xfs/283     |  7 +++----
 tests/xfs/284     | 10 ++++------
 tests/xfs/287     |  7 +++----
 tests/xfs/289     | 17 +++++++++--------
 tests/xfs/296     |  9 ++++-----
 tests/xfs/299     |  8 --------
 tests/xfs/301     |  9 ++++-----
 tests/xfs/302     |  9 ++++-----
 tests/xfs/309     |  8 --------
 tests/xfs/310     |  8 +++-----
 tests/xfs/311     | 10 ++++------
 tests/xfs/312     |  8 --------
 tests/xfs/313     |  8 --------
 tests/xfs/314     |  8 --------
 tests/xfs/315     |  8 --------
 tests/xfs/316     |  8 --------
 tests/xfs/317     |  8 --------
 tests/xfs/318     |  8 --------
 tests/xfs/319     |  8 --------
 tests/xfs/320     |  8 --------
 tests/xfs/321     |  8 --------
 tests/xfs/322     |  8 --------
 tests/xfs/323     |  8 --------
 tests/xfs/324     |  8 --------
 tests/xfs/325     |  8 --------
 tests/xfs/326     |  8 --------
 tests/xfs/327     |  8 --------
 tests/xfs/336     |  7 -------
 tests/xfs/432     |  8 ++++----
 tests/xfs/438     | 16 ++++++++++------
 tests/xfs/442     | 10 +++++-----
 tests/xfs/447     |  7 +++----
 tests/xfs/501     |  7 +++----
 tests/xfs/503     | 10 ++++------
 tests/xfs/507     | 13 +++++--------
 tests/xfs/511     |  8 --------
 tests/xfs/512     |  8 +-------
 tests/xfs/513     | 15 +++++----------
 tests/xfs/514     | 10 ++++------
 tests/xfs/515     | 10 ++++------
 tests/xfs/516     |  7 -------
 tests/xfs/517     |  9 +++------
 tests/xfs/520     |  8 --------
 tests/xfs/521     |  8 ++++----
 tests/xfs/522     |  7 -------
 tests/xfs/523     |  7 -------
 tests/xfs/524     |  8 ++++----
 tests/xfs/525     |  7 -------
 tests/xfs/526     |  7 -------
 tests/xfs/528     |  6 +++---
 tests/xfs/530     |  6 +++---
 tests/xfs/542     |  7 ++++---
 tests/xfs/543     |  7 -------
 tests/xfs/544     | 11 ++++++++---
 197 files changed, 477 insertions(+), 1106 deletions(-)

diff --git a/tests/xfs/004 b/tests/xfs/004
index f18316b3..f8cfeb6a 100755
--- a/tests/xfs/004
+++ b/tests/xfs/004
@@ -11,13 +11,6 @@ _begin_fstest db auto quick
 
 status=0
 
-# Override the default cleanup function.
-_cleanup()
-{
-	_scratch_unmount
-	rm -f $tmp.*
-}
-
 _populate_scratch()
 {
 	echo "=== mkfs output ===" >>$seqres.full
diff --git a/tests/xfs/006 b/tests/xfs/006
index cecceaa3..fd8d8071 100755
--- a/tests/xfs/006
+++ b/tests/xfs/006
@@ -11,11 +11,10 @@
 _begin_fstest auto quick mount eio
 
 # Override the default cleanup function.
-_cleanup()
+_dmerror_cleanup()
 {
-	cd /
-	rm -f $tmp.*
 	_dmerror_cleanup
+	_cleanup
 }
 
 # Import common functions.
@@ -28,6 +27,8 @@ _require_scratch
 _require_dm_target error
 _require_fs_sysfs error/fail_at_unmount
 
+_register_cleanup _dmerror_cleanup
+
 _scratch_mkfs > $seqres.full 2>&1
 _dmerror_init
 _dmerror_mount
diff --git a/tests/xfs/008 b/tests/xfs/008
index a53f6c92..5bef44bb 100755
--- a/tests/xfs/008
+++ b/tests/xfs/008
@@ -12,13 +12,6 @@ _begin_fstest rw ioctl auto quick
 status=0	# success is the default!
 pgsize=`$here/src/feature -s`
 
-# Override the default cleanup function.
-_cleanup()
-{
-    rm -f $tmp.*
-    rm -rf $TEST_DIR/randholes.$$.*
-}
-
 _filter()
 {
     sed -e "s/-b $pgsize/-b PGSIZE/g" \
@@ -68,6 +61,8 @@ _do_test()
 _supported_fs xfs
 _require_test
 
+rm -rf $TEST_DIR/randholes.$$.*
+
 # Note on special numbers here.
 #
 # We are trying to create roughly 50 or 100 holes in a file
diff --git a/tests/xfs/009 b/tests/xfs/009
index 54270243..186ba5b3 100755
--- a/tests/xfs/009
+++ b/tests/xfs/009
@@ -9,13 +9,6 @@
 . ./common/preamble
 _begin_fstest rw ioctl auto prealloc quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-    echo "*** unmount"
-    _scratch_unmount
-}
-
 _init()
 {
     echo "*** mkfs"
diff --git a/tests/xfs/009.out b/tests/xfs/009.out
index 02b5d82a..596c686f 100644
--- a/tests/xfs/009.out
+++ b/tests/xfs/009.out
@@ -111,4 +111,3 @@ filesize = 500
         [ofs,count]: start..end
         [0,1000]: BLOCKRANGE
 filesize = 500
-*** unmount
diff --git a/tests/xfs/010 b/tests/xfs/010
index 16c08b85..bdca950c 100755
--- a/tests/xfs/010
+++ b/tests/xfs/010
@@ -15,14 +15,6 @@ _begin_fstest auto quick repair
 . ./common/filter
 . ./common/repair
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
-}
-
 _sparse_inode_populate()
 {
 	dir=$1
diff --git a/tests/xfs/011 b/tests/xfs/011
index d6e9099e..161f263c 100755
--- a/tests/xfs/011
+++ b/tests/xfs/011
@@ -11,17 +11,13 @@
 . ./common/preamble
 _begin_fstest auto freeze log metadata quick
 
-# Import common functions.
-
-# Override the default cleanup function.
-_cleanup()
+_fsstress_cleanup()
 {
 	$KILLALL_PROG -9 fsstress 2>/dev/null
 	wait
-	cd /
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _fsstress_cleanup
 
 # Use the information exported by XFS to sysfs to determine whether the log has
 # active reservations after a filesystem freeze.
@@ -85,7 +81,5 @@ done
 $KILLALL_PROG $FSSTRESS_PROG
 wait
 
-_scratch_unmount
-
 status=0
 exit
diff --git a/tests/xfs/012 b/tests/xfs/012
index 5ebc9058..c5569f6d 100755
--- a/tests/xfs/012
+++ b/tests/xfs/012
@@ -11,14 +11,6 @@ _begin_fstest rw auto quick
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-    rm -rf $TEST_DIR/holes.$$.*
-}
-
 _filesize()
 {
     ls -l $1 | $AWK_PROG '{print "    filesize = " $5}'
@@ -85,6 +77,8 @@ _do_test()
 _supported_fs xfs
 _require_test
 
+rm -rf $TEST_DIR/holes.$$.*
+
 # small & fairly dense
 _do_test 1 "-l 40960000 -b 40960 -i 10 -c 1" 100
 
diff --git a/tests/xfs/013 b/tests/xfs/013
index 2d005753..c451ded3 100755
--- a/tests/xfs/013
+++ b/tests/xfs/013
@@ -16,15 +16,13 @@ _begin_fstest auto metadata stress
 # Import common functions.
 . ./common/filter
 
-# Override the default cleanup function.
-_cleanup()
+_fsstress_cleanup()
 {
 	$KILLALL_PROG -9 fsstress 2>/dev/null
 	wait
-	cd /
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _fsstress_cleanup
 
 filter_enospc() {
 	sed -e '/^.*No space left on device.*/d'
diff --git a/tests/xfs/014 b/tests/xfs/014
index 1f0ebac3..1e099df6 100755
--- a/tests/xfs/014
+++ b/tests/xfs/014
@@ -18,14 +18,12 @@ _begin_fstest auto enospc quick quota
 . ./common/filter
 . ./common/quota
 
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-	cd /
 	umount $LOOP_MNT 2>/dev/null
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Create a file using a repeated open, extending write and close pattern. This
 # causes the preallocation to persist after the file is closed. Preallocation
diff --git a/tests/xfs/016 b/tests/xfs/016
index 6337bb1f..04c7ce95 100755
--- a/tests/xfs/016
+++ b/tests/xfs/016
@@ -22,15 +22,6 @@
 . ./common/preamble
 _begin_fstest rw auto quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-    echo "*** unmount"
-    _scratch_unmount 2>/dev/null
-}
-
 _block_filter()
 {
     sed -e 's/[0-9][0-9]*\.\.[0-9][0-9]*/BLOCKRANGE/g'
diff --git a/tests/xfs/016.out b/tests/xfs/016.out
index f4c8f88d..7c2bd144 100644
--- a/tests/xfs/016.out
+++ b/tests/xfs/016.out
@@ -117,4 +117,3 @@ Wrote 51200.00Kb (value 0xc6)
    *** fiddle
    *** unmount
 *** check for corruption
-*** unmount
diff --git a/tests/xfs/017 b/tests/xfs/017
index 8a20e592..14e29b98 100755
--- a/tests/xfs/017
+++ b/tests/xfs/017
@@ -11,13 +11,6 @@ _begin_fstest mount auto quick stress
 
 _register_cleanup "_cleanup; rm -f $tmp.*"
 
-# Override the default cleanup function.
-_cleanup()
-{
-    echo "*** unmount"
-    _scratch_unmount 2>/dev/null
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/019 b/tests/xfs/019
index 790a6821..9aa02f22 100755
--- a/tests/xfs/019
+++ b/tests/xfs/019
@@ -14,14 +14,6 @@ rm -f $seqfull
 # Import common functions.
 . ./common/filter
 
-# Override the default cleanup function.
-_cleanup()
-{
-    echo "*** unmount"
-    _scratch_unmount 2>/dev/null
-    rm -f $tmp.*
-}
-
 _full()
 {
     echo ""            >>$seqfull
diff --git a/tests/xfs/019.out b/tests/xfs/019.out
index 9db157f9..65a0d8b2 100644
--- a/tests/xfs/019.out
+++ b/tests/xfs/019.out
@@ -90,4 +90,3 @@ Device: <DEVICE> Inode: <INODE> Links: 1
 Device: <DEVICE> Inode: <INODE> Links: 1 
 *** unmount FS
 *** done
-*** unmount
diff --git a/tests/xfs/020 b/tests/xfs/020
index d6ee3a15..6e2deb6b 100755
--- a/tests/xfs/020
+++ b/tests/xfs/020
@@ -12,13 +12,12 @@
 . ./common/preamble
 _begin_fstest auto repair
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-    cd /
-    rm -f $tmp.*
-    rm -f $fsfile
+	rm -f $fsfile
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/021 b/tests/xfs/021
index 9432e2ac..eed7fa49 100755
--- a/tests/xfs/021
+++ b/tests/xfs/021
@@ -14,14 +14,6 @@ status=0	# success is the default!
 . ./common/filter
 . ./common/attr
 
-# Override the default cleanup function.
-_cleanup()
-{
-	echo "*** unmount"
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
-}
-
 _attr()
 {
 	${ATTR_PROG} $* 2>$tmp.err >$tmp.out
diff --git a/tests/xfs/021.out b/tests/xfs/021.out
index aea4a605..3b9d6e87 100644
--- a/tests/xfs/021.out
+++ b/tests/xfs/021.out
@@ -54,4 +54,3 @@ nvlist[2].namelen = 7
 nvlist[2].name = "a2-----"
 nvlist[2].value = "value_2\d"
 *** done
-*** unmount
diff --git a/tests/xfs/022 b/tests/xfs/022
index 2f011b28..e9310365 100755
--- a/tests/xfs/022
+++ b/tests/xfs/022
@@ -15,13 +15,12 @@ _begin_fstest dump ioctl tape
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 . ./common/dump
 
diff --git a/tests/xfs/023 b/tests/xfs/023
index f6f6503a..1019831d 100755
--- a/tests/xfs/023
+++ b/tests/xfs/023
@@ -13,13 +13,12 @@ _begin_fstest dump ioctl tape
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/024 b/tests/xfs/024
index 83a8882c..dcb6b9fc 100755
--- a/tests/xfs/024
+++ b/tests/xfs/024
@@ -11,13 +11,12 @@ _begin_fstest dump ioctl tape
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/025 b/tests/xfs/025
index bafe82d7..dd3c8588 100755
--- a/tests/xfs/025
+++ b/tests/xfs/025
@@ -11,13 +11,12 @@ _begin_fstest dump ioctl tape
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/026 b/tests/xfs/026
index fba385dc..18529003 100755
--- a/tests/xfs/026
+++ b/tests/xfs/026
@@ -11,13 +11,12 @@ _begin_fstest dump ioctl auto quick
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/027 b/tests/xfs/027
index 16cd203d..df6ee2ac 100755
--- a/tests/xfs/027
+++ b/tests/xfs/027
@@ -11,13 +11,12 @@ _begin_fstest dump ioctl auto quick
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/028 b/tests/xfs/028
index 1ff9d7d2..d0518317 100755
--- a/tests/xfs/028
+++ b/tests/xfs/028
@@ -11,13 +11,12 @@ _begin_fstest dump ioctl auto quick
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/030 b/tests/xfs/030
index 201a9015..617a34e3 100755
--- a/tests/xfs/030
+++ b/tests/xfs/030
@@ -10,14 +10,6 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest repair auto quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/repair
diff --git a/tests/xfs/033 b/tests/xfs/033
index d47da0d6..06c4c100 100755
--- a/tests/xfs/033
+++ b/tests/xfs/033
@@ -10,14 +10,6 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest repair auto quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    _scratch_unmount 2>/dev/null
-    rm -f $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/repair
diff --git a/tests/xfs/034 b/tests/xfs/034
index 52b0a5f7..5625631c 100755
--- a/tests/xfs/034
+++ b/tests/xfs/034
@@ -9,15 +9,6 @@
 . ./common/preamble
 _begin_fstest other auto quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-    echo "*** unmount"
-    _scratch_unmount 2>/dev/null
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/034.out b/tests/xfs/034.out
index b307447d..040d3b97 100644
--- a/tests/xfs/034.out
+++ b/tests/xfs/034.out
@@ -2,4 +2,3 @@ QA output created by 034
 *** init FS
 *** test
 *** done
-*** unmount
diff --git a/tests/xfs/035 b/tests/xfs/035
index f100bb18..6461884b 100755
--- a/tests/xfs/035
+++ b/tests/xfs/035
@@ -11,12 +11,12 @@ seqfull=$0
 _begin_fstest dump ioctl tape auto
 
 # Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/036 b/tests/xfs/036
index 73eb7cd5..becbc83c 100755
--- a/tests/xfs/036
+++ b/tests/xfs/036
@@ -10,13 +10,12 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest dump ioctl remote tape
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/037 b/tests/xfs/037
index b19ba9e9..0cbd0b16 100755
--- a/tests/xfs/037
+++ b/tests/xfs/037
@@ -9,13 +9,12 @@
 . ./common/preamble
 _begin_fstest dump ioctl remote tape
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/038 b/tests/xfs/038
index 397c354d..da5507af 100755
--- a/tests/xfs/038
+++ b/tests/xfs/038
@@ -9,13 +9,12 @@
 . ./common/preamble
 _begin_fstest dump ioctl remote tape
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/039 b/tests/xfs/039
index d54e9975..69a1092d 100755
--- a/tests/xfs/039
+++ b/tests/xfs/039
@@ -10,13 +10,12 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest dump ioctl remote tape
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/041 b/tests/xfs/041
index 05de5578..8e584643 100755
--- a/tests/xfs/041
+++ b/tests/xfs/041
@@ -12,14 +12,6 @@ set +x
 . ./common/preamble
 _begin_fstest growfs ioctl auto
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    _scratch_unmount
-    rm -f $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/042 b/tests/xfs/042
index d62eb045..8af43671 100755
--- a/tests/xfs/042
+++ b/tests/xfs/042
@@ -13,13 +13,6 @@ set +x
 . ./common/preamble
 _begin_fstest fsr ioctl auto
 
-# Override the default cleanup function.
-_cleanup()
-{
-    _scratch_unmount
-    rm -f $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/043 b/tests/xfs/043
index 415ed16e..7ce74539 100755
--- a/tests/xfs/043
+++ b/tests/xfs/043
@@ -12,13 +12,12 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest dump ioctl tape
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/046 b/tests/xfs/046
index 48daff87..3ac4a180 100755
--- a/tests/xfs/046
+++ b/tests/xfs/046
@@ -9,13 +9,12 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/047 b/tests/xfs/047
index 6d0dc5f7..c2f66e31 100755
--- a/tests/xfs/047
+++ b/tests/xfs/047
@@ -9,13 +9,12 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/049 b/tests/xfs/049
index 69656a85..fec99386 100755
--- a/tests/xfs/049
+++ b/tests/xfs/049
@@ -9,20 +9,17 @@
 . ./common/preamble
 _begin_fstest rw auto quick
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-    cd /
-    umount $SCRATCH_MNT/test2 > /dev/null 2>&1
-    umount $SCRATCH_MNT/test > /dev/null 2>&1
-    rm -f $tmp.*
-
-    if [ -w $seqres.full ]
-    then
-        echo "--- mounts at end (after cleanup)" >> $seqres.full
-        mount >> $seqres.full
-    fi
+	umount $SCRATCH_MNT/test2 > /dev/null 2>&1
+	umount $SCRATCH_MNT/test > /dev/null 2>&1
+	if [ -w $seqres.full ]; then
+		echo "--- mounts at end (after cleanup)" >> $seqres.full
+		mount >> $seqres.full
+	fi
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/050 b/tests/xfs/050
index 2220e470..a020543a 100755
--- a/tests/xfs/050
+++ b/tests/xfs/050
@@ -14,14 +14,6 @@ _begin_fstest quota auto quick
 . ./common/filter
 . ./common/quota
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
-}
-
 # real QA test starts here
 _supported_fs xfs
 
diff --git a/tests/xfs/051 b/tests/xfs/051
index ea70cb50..4718099d 100755
--- a/tests/xfs/051
+++ b/tests/xfs/051
@@ -11,14 +11,13 @@
 . ./common/preamble
 _begin_fstest shutdown auto log metadata
 
-# Override the default cleanup function.
-_cleanup()
+_fsstress_cleanup()
 {
-	cd /
-	rm -f $tmp.*
 	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
-	_scratch_unmount > /dev/null 2>&1
+	wait
+	_cleanup
 }
+_register_cleanup fsstress_cleanup
 
 # Import common functions.
 . ./common/dmflakey
diff --git a/tests/xfs/052 b/tests/xfs/052
index 75761022..c8409574 100755
--- a/tests/xfs/052
+++ b/tests/xfs/052
@@ -16,14 +16,6 @@ _begin_fstest quota db auto quick
 . ./common/filter
 . ./common/quota
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
-}
-
 # real QA test starts here
 _supported_fs xfs
 
diff --git a/tests/xfs/055 b/tests/xfs/055
index c6ecae3d..d663bfab 100755
--- a/tests/xfs/055
+++ b/tests/xfs/055
@@ -10,13 +10,12 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest dump ioctl remote tape
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/056 b/tests/xfs/056
index f742f419..7a4b2423 100755
--- a/tests/xfs/056
+++ b/tests/xfs/056
@@ -12,13 +12,12 @@ _begin_fstest dump ioctl auto quick
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/057 b/tests/xfs/057
index 9fb3f406..983479ab 100755
--- a/tests/xfs/057
+++ b/tests/xfs/057
@@ -23,16 +23,20 @@
 . ./common/preamble
 _begin_fstest auto log recoveryloop
 
-# Override the default cleanup function.
-_cleanup()
+_fsstress_cleanup()
+{
+	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
+	wait
+	_cleanup
+}
+
+local_cleanup()
 {
-	cd /
-	rm -f $tmp.*
-	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
 	[ -e /sys/fs/xfs/$sdev/errortag/log_item_pin ] &&
 		echo 0 > /sys/fs/xfs/$sdev/errortag/log_item_pin
-	wait > /dev/null 2>&1
+	_fsstress_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/inject
diff --git a/tests/xfs/059 b/tests/xfs/059
index 515ef2a4..9428a9da 100755
--- a/tests/xfs/059
+++ b/tests/xfs/059
@@ -11,13 +11,12 @@ _begin_fstest dump ioctl auto quick
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/060 b/tests/xfs/060
index 0c0dc981..b5939f67 100755
--- a/tests/xfs/060
+++ b/tests/xfs/060
@@ -11,13 +11,12 @@ _begin_fstest dump ioctl auto quick
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/061 b/tests/xfs/061
index 0b20cc30..dcaac20c 100755
--- a/tests/xfs/061
+++ b/tests/xfs/061
@@ -11,13 +11,12 @@ _begin_fstest dump ioctl auto quick
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/063 b/tests/xfs/063
index 660b300f..9193745a 100755
--- a/tests/xfs/063
+++ b/tests/xfs/063
@@ -9,13 +9,12 @@
 . ./common/preamble
 _begin_fstest dump attr auto quick
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/064 b/tests/xfs/064
index a81b226b..e332daee 100755
--- a/tests/xfs/064
+++ b/tests/xfs/064
@@ -9,13 +9,12 @@
 . ./common/preamble
 _begin_fstest dump auto
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/065 b/tests/xfs/065
index 8485dee6..9b31ff34 100755
--- a/tests/xfs/065
+++ b/tests/xfs/065
@@ -12,13 +12,12 @@
 . ./common/preamble
 _begin_fstest dump auto
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/066 b/tests/xfs/066
index 2c369ad7..22eb10cc 100755
--- a/tests/xfs/066
+++ b/tests/xfs/066
@@ -13,13 +13,12 @@ _begin_fstest dump ioctl auto quick
 . ./common/filter
 . ./common/dump
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
-    _cleanup_dump
-    cd /
-    rm -f $tmp.*
+	_cleanup_dump
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/068 b/tests/xfs/068
index f80b53e5..ed281881 100755
--- a/tests/xfs/068
+++ b/tests/xfs/068
@@ -16,13 +16,12 @@ _begin_fstest auto stress dump
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 . ./common/dump
 
diff --git a/tests/xfs/070 b/tests/xfs/070
index 43ca7f84..b9839597 100755
--- a/tests/xfs/070
+++ b/tests/xfs/070
@@ -21,14 +21,13 @@
 . ./common/preamble
 _begin_fstest auto quick repair
 
-# Override the default cleanup function.
-_cleanup()
+_xfs_repair_cleanup()
 {
-	cd /
-	rm -f $tmp.*
 	$KILLALL_PROG -9 $XFS_REPAIR_PROG > /dev/null 2>&1
 	wait > /dev/null 2>&1
+	_cleanup
 }
+_register_cleanup _xfs_repair_cleanup
 
 # Start and monitor an xfs_repair of the scratch device. This test can induce a
 # time consuming brute force superblock scan. Since a brute force scan means
diff --git a/tests/xfs/071 b/tests/xfs/071
index 8373878a..b43deb75 100755
--- a/tests/xfs/071
+++ b/tests/xfs/071
@@ -9,14 +9,6 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest rw auto
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-    _scratch_unmount 2>/dev/null
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/072 b/tests/xfs/072
index 54c1207c..196c4df1 100755
--- a/tests/xfs/072
+++ b/tests/xfs/072
@@ -9,14 +9,6 @@
 . ./common/preamble
 _begin_fstest rw auto prealloc quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-	_scratch_unmount 2>/dev/null
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/073 b/tests/xfs/073
index c7616b9e..f44687c4 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -16,17 +16,16 @@ _begin_fstest copy auto
 # don't put fs images in /tmp
 imgs=$TEST_DIR/$$
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
 	_scratch_unmount 2>/dev/null
 	umount $imgs.loop 2>/dev/null
-	[ -d $imgs.loop ] && rmdir $imgs.loop
 	umount $imgs.source_dir 2>/dev/null
-	[ -d $imgs.source_dir ] && rm -rf $imgs.source_dir
-	rm -f $imgs.* $tmp.* /var/tmp/xfs_copy.log.*
+	rm -rf $imgs.* /var/tmp/xfs_copy.log.*
+
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 _filter_copy()
 {
diff --git a/tests/xfs/074 b/tests/xfs/074
index f27700ee..cf8dd244 100755
--- a/tests/xfs/074
+++ b/tests/xfs/074
@@ -22,13 +22,13 @@
 . ./common/preamble
 _begin_fstest quick auto prealloc rw
 
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-	cd /
 	_destroy_loop_device $LOOP_DEV
-	rm -f $tmp.* $LOOP_FILE
+	rm -f $LOOP_FILE
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/076 b/tests/xfs/076
index 8eef1367..09fea1d6 100755
--- a/tests/xfs/076
+++ b/tests/xfs/076
@@ -23,14 +23,6 @@ _begin_fstest auto enospc punch
 # Import common functions.
 . ./common/filter
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
-}
-
 _consume_freesp()
 {
 	file=$1
diff --git a/tests/xfs/078 b/tests/xfs/078
index 1f475c96..dbd9af5b 100755
--- a/tests/xfs/078
+++ b/tests/xfs/078
@@ -9,19 +9,16 @@
 . ./common/preamble
 _begin_fstest growfs auto quick
 
-_register_cleanup "_cleanup; rm -f $tmp.*"
-
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-	cd /
-	rm -f $tmp.*
 	$UMOUNT_PROG $LOOP_MNT 2>/dev/null
 	[ -n "$LOOP_DEV" ] && _destroy_loop_device $LOOP_DEV 2>/dev/null
 	# try to keep the image file if test fails
 	[ $status -eq 0 ] && rm -f $LOOP_IMG
 	rmdir $LOOP_MNT
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/079 b/tests/xfs/079
index dd5dbd35..fc30181b 100755
--- a/tests/xfs/079
+++ b/tests/xfs/079
@@ -17,14 +17,13 @@
 . ./common/preamble
 _begin_fstest shutdown auto log quick
 
-# Override the default cleanup function.
-_cleanup()
+_fsstress_cleanup()
 {
-	cd /
-	rm -f $tmp.*
-	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
-	wait > /dev/null 2>&1
+	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
+	wait
+	_cleanup
 }
+_register_cleanup fsstress_cleanup
 
 # Import common functions.
 . ./common/log
diff --git a/tests/xfs/080 b/tests/xfs/080
index 20b20a08..3cf5f7ff 100755
--- a/tests/xfs/080
+++ b/tests/xfs/080
@@ -12,13 +12,6 @@ _begin_fstest rw ioctl
 # Import common functions.
 . ./common/filter
 
-# Override the default cleanup function.
-_cleanup()
-{ 
-    cd /
-    rm -f $tmp.*
-}
-
 _supported_fs xfs
 _require_test
 
diff --git a/tests/xfs/083 b/tests/xfs/083
index a9acc9f5..7666d204 100755
--- a/tests/xfs/083
+++ b/tests/xfs/083
@@ -11,12 +11,11 @@
 . ./common/preamble
 _begin_fstest dangerous_fuzzers punch
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/085 b/tests/xfs/085
index dc82f28d..8aa8f2a0 100755
--- a/tests/xfs/085
+++ b/tests/xfs/085
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/086 b/tests/xfs/086
index c8c6d86e..031cb445 100755
--- a/tests/xfs/086
+++ b/tests/xfs/086
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/087 b/tests/xfs/087
index f7cae328..9d1f59f0 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/088 b/tests/xfs/088
index 156c6669..de824223 100755
--- a/tests/xfs/088
+++ b/tests/xfs/088
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/089 b/tests/xfs/089
index ae8f6564..dae2d0d0 100755
--- a/tests/xfs/089
+++ b/tests/xfs/089
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/091 b/tests/xfs/091
index 85c881ae..c5db3337 100755
--- a/tests/xfs/091
+++ b/tests/xfs/091
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/093 b/tests/xfs/093
index 04b09e85..9fe1799a 100755
--- a/tests/xfs/093
+++ b/tests/xfs/093
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/097 b/tests/xfs/097
index 4cad7216..d66df458 100755
--- a/tests/xfs/097
+++ b/tests/xfs/097
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/098 b/tests/xfs/098
index 1e60271f..21215ee5 100755
--- a/tests/xfs/098
+++ b/tests/xfs/098
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/099 b/tests/xfs/099
index a7eaff6e..2791e2df 100755
--- a/tests/xfs/099
+++ b/tests/xfs/099
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/100 b/tests/xfs/100
index 79da8cb0..e71e760e 100755
--- a/tests/xfs/100
+++ b/tests/xfs/100
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/101 b/tests/xfs/101
index 64f4705a..1cbcc973 100755
--- a/tests/xfs/101
+++ b/tests/xfs/101
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/102 b/tests/xfs/102
index 24dce430..0ce3588a 100755
--- a/tests/xfs/102
+++ b/tests/xfs/102
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/105 b/tests/xfs/105
index 22a8bf9f..8a583da5 100755
--- a/tests/xfs/105
+++ b/tests/xfs/105
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/112 b/tests/xfs/112
index bc1ab628..4362f31c 100755
--- a/tests/xfs/112
+++ b/tests/xfs/112
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/113 b/tests/xfs/113
index e820ed96..e3f4fd4d 100755
--- a/tests/xfs/113
+++ b/tests/xfs/113
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/117 b/tests/xfs/117
index e4195d9b..4962c201 100755
--- a/tests/xfs/117
+++ b/tests/xfs/117
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/120 b/tests/xfs/120
index 0a4d72a0..653948ee 100755
--- a/tests/xfs/120
+++ b/tests/xfs/120
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/123 b/tests/xfs/123
index 81f39b96..e191623a 100755
--- a/tests/xfs/123
+++ b/tests/xfs/123
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/124 b/tests/xfs/124
index 39307218..af738212 100755
--- a/tests/xfs/124
+++ b/tests/xfs/124
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/125 b/tests/xfs/125
index fb5f5695..a7280e2c 100755
--- a/tests/xfs/125
+++ b/tests/xfs/125
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/126 b/tests/xfs/126
index c3a74b1c..55a12178 100755
--- a/tests/xfs/126
+++ b/tests/xfs/126
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/129 b/tests/xfs/129
index 90887d54..ea284049 100755
--- a/tests/xfs/129
+++ b/tests/xfs/129
@@ -11,13 +11,12 @@
 . ./common/preamble
 _begin_fstest auto quick clone metadump
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-    cd /
-    _scratch_unmount > /dev/null 2>&1
-    rm -rf $tmp.* $testdir $metadump_file $TEST_DIR/image
+	rm -rf $testdir $metadump_file $TEST_DIR/image
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/130 b/tests/xfs/130
index 9465cbb0..e7a0e6e3 100755
--- a/tests/xfs/130
+++ b/tests/xfs/130
@@ -10,12 +10,11 @@
 . ./common/preamble
 _begin_fstest fuzzers clone
 
-# Override the default cleanup function.
-_cleanup()
+_no_cleanup()
 {
-    cd /
-    #rm -f $tmp.*
+	cd /
 }
+_register_cleanup _no_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/131 b/tests/xfs/131
index 879e2dc6..57848564 100755
--- a/tests/xfs/131
+++ b/tests/xfs/131
@@ -9,14 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone realtime
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    umount $SCRATCH_MNT > /dev/null 2>&1
-    rm -rf $tmp.* $testdir $metadump_file
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/139 b/tests/xfs/139
index 118930a5..96dce077 100755
--- a/tests/xfs/139
+++ b/tests/xfs/139
@@ -10,13 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    rm -rf $tmp.* $testdir
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/140 b/tests/xfs/140
index ba7694c3..5b51f540 100755
--- a/tests/xfs/140
+++ b/tests/xfs/140
@@ -10,13 +10,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    rm -rf $tmp.* $testdir
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/141 b/tests/xfs/141
index d9b2474d..0b0cac81 100755
--- a/tests/xfs/141
+++ b/tests/xfs/141
@@ -14,14 +14,13 @@
 . ./common/preamble
 _begin_fstest auto log metadata
 
-# Override the default cleanup function.
-_cleanup()
+_fsstress_cleanup()
 {
-	cd /
-	rm -f $tmp.*
-	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
-	wait > /dev/null 2>&1
+	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
+	wait
+	_cleanup
 }
+_register_cleanup fsstress_cleanup
 
 # Import common functions.
 . ./common/inject
diff --git a/tests/xfs/148 b/tests/xfs/148
index 5d0a0bf4..ce829e20 100755
--- a/tests/xfs/148
+++ b/tests/xfs/148
@@ -10,14 +10,13 @@
 . ./common/preamble
 _begin_fstest auto quick fuzzers
 
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-	cd /
 	$UMOUNT_PROG $mntpt > /dev/null 2>&1
 	_destroy_loop_device $loopdev > /dev/null 2>&1
-	rm -r -f $tmp.*
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/149 b/tests/xfs/149
index 503eff65..82ff6093 100755
--- a/tests/xfs/149
+++ b/tests/xfs/149
@@ -19,15 +19,16 @@ loopfile=$TEST_DIR/fsfile
 mntdir=$TEST_DIR/mntdir
 loop_symlink=$TEST_DIR/loop_symlink.$$
 
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-    $UMOUNT_PROG $mntdir
-    [ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
-    rmdir $mntdir
-    rm -f $loop_symlink
-    rm -f $loopfile
+	$UMOUNT_PROG $mntdir
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
+	rmdir $mntdir
+	rm -f $loop_symlink
+	rm -f $loopfile
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/152 b/tests/xfs/152
index dd33801d..bb136d7c 100755
--- a/tests/xfs/152
+++ b/tests/xfs/152
@@ -13,19 +13,12 @@
 . ./common/preamble
 _begin_fstest auto quick quota idmapped
 
-wipe_mounts()
+_idmapped_cleanup()
 {
 	umount "${SCRATCH_MNT}/idmapped" >/dev/null 2>&1
-	_scratch_unmount >/dev/null 2>&1
-}
-
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	wipe_mounts
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _idmapped_cleanup
 
 # Import common functions.
 . ./common/filter
@@ -232,6 +225,12 @@ test_restore()
 			$SCRATCH_MNT | _filter_scratch
 }
 
+wipe_mounts()
+{
+	umount "${SCRATCH_MNT}/idmapped" >/dev/null 2>&1
+	_scratch_unmount >/dev/null 2>&1
+}
+
 wipe_scratch()
 {
 	wipe_mounts
@@ -367,8 +366,6 @@ idmapped=1
 qmount_idmapped
 test_xfs_quota "gquota,sync"
 
-wipe_mounts
-
 # success, all done
 status=0
 exit
diff --git a/tests/xfs/153 b/tests/xfs/153
index dbe26b68..bb9295c0 100755
--- a/tests/xfs/153
+++ b/tests/xfs/153
@@ -16,14 +16,6 @@ _begin_fstest auto quick quota idmapped
 . ./common/filter
 . ./common/quota
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
-}
-
 # real QA test starts here
 _supported_fs xfs
 
diff --git a/tests/xfs/157 b/tests/xfs/157
index 8222d7ee..17b162f3 100755
--- a/tests/xfs/157
+++ b/tests/xfs/157
@@ -20,12 +20,12 @@
 . ./common/preamble
 _begin_fstest auto quick admin
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -f $tmp.* $fake_logfile $fake_rtfile $fake_datafile
+	rm -f $fake_logfile $fake_rtfile $fake_datafile
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/159 b/tests/xfs/159
index eaee590e..709baa2e 100755
--- a/tests/xfs/159
+++ b/tests/xfs/159
@@ -11,14 +11,6 @@
 . ./common/preamble
 _begin_fstest auto quick bigtime
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-}
-
-# Import common functions.
-
 # real QA test starts here
 _supported_fs xfs
 _require_scratch
diff --git a/tests/xfs/167 b/tests/xfs/167
index 5f985010..50d3c41b 100755
--- a/tests/xfs/167
+++ b/tests/xfs/167
@@ -9,12 +9,13 @@
 . ./common/preamble
 _begin_fstest rw metadata auto stress
 
-# Override the default cleanup function.
-_cleanup()
+_fsstress_cleanup()
 {
-	$KILLALL_PROG -r -q -TERM fsstress 2> /dev/null
-	wait	# ensures all fsstress processes died
+	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
+	wait
+	_cleanup
 }
+_register_cleanup fsstress_cleanup
 
 workout()
 {
diff --git a/tests/xfs/169 b/tests/xfs/169
index 7ea5af99..84ad7db4 100755
--- a/tests/xfs/169
+++ b/tests/xfs/169
@@ -11,14 +11,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    umount $SCRATCH_MNT > /dev/null 2>&1
-    rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/177 b/tests/xfs/177
index 10891550..0179e37a 100755
--- a/tests/xfs/177
+++ b/tests/xfs/177
@@ -25,12 +25,12 @@
 . ./common/preamble
 _begin_fstest auto ioctl
 
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -r -f $tmp.*
 	test -n "$old_centisecs" && echo "$old_centisecs" > "$xfs_centisecs_file"
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/181 b/tests/xfs/181
index a399ae5a..b6f9760b 100755
--- a/tests/xfs/181
+++ b/tests/xfs/181
@@ -13,12 +13,12 @@
 . ./common/preamble
 _begin_fstest shutdown log auto quick
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-    rm -f $tmp.*
-    [ -n "$pid" ] && kill $pid
+	[ -n "$pid" ] && kill $pid
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 pid=""
 
@@ -29,8 +29,6 @@ pid=""
 # real QA test starts here
 _supported_fs xfs
 
-rm -f $tmp.log
-
 _require_scratch
 
 echo "mkfs"
diff --git a/tests/xfs/185 b/tests/xfs/185
index f0e87642..d46bd4bf 100755
--- a/tests/xfs/185
+++ b/tests/xfs/185
@@ -18,17 +18,17 @@
 . ./common/preamble
 _begin_fstest auto fsmap
 
-_cleanup()
+_loop_cleanup()
 {
-	cd /
-	rm -r -f $tmp.*
 	_scratch_unmount
 	test -n "$ddloop" && _destroy_loop_device "$ddloop"
 	test -n "$rtloop" && _destroy_loop_device "$rtloop"
-	test -n "$ddfile" && rm -f "$ddfile"
-	test -n "$rtfile" && rm -f "$rtfile"
+	rm -f "$ddfile"
+	rm -f "$rtfile"
 	test -n "$old_use_external" && USE_EXTERNAL="$old_use_external"
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/188 b/tests/xfs/188
index d40e4123..3111d41b 100755
--- a/tests/xfs/188
+++ b/tests/xfs/188
@@ -18,14 +18,6 @@ _begin_fstest ci dir auto
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-    rm -rf $SCRATCH_MNT/$seq
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/189 b/tests/xfs/189
index e601881a..82c94145 100755
--- a/tests/xfs/189
+++ b/tests/xfs/189
@@ -38,14 +38,12 @@ _begin_fstest mount auto quick
 
 tag="added by qa $seq"
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	_scratch_unmount 2>/dev/null
 	_putback_scratch_fstab
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 _scratch_filter()
 {
diff --git a/tests/xfs/194 b/tests/xfs/194
index 5a1dff5d..15739c87 100755
--- a/tests/xfs/194
+++ b/tests/xfs/194
@@ -9,18 +9,6 @@
 . ./common/preamble
 _begin_fstest rw auto
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    # Unmount the V4 filesystem we forcibly created to run this test so that
-    # the post-test wrapup checks won't try to remount the filesystem with
-    # different MOUNT_OPTIONS (specifically, the ones that get screened out by
-    # _force_xfsv4_mount_options) and fail.
-    _scratch_unmount
-    rm -f $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/195 b/tests/xfs/195
index 3e388142..65d68b47 100755
--- a/tests/xfs/195
+++ b/tests/xfs/195
@@ -11,13 +11,6 @@
 . ./common/preamble
 _begin_fstest ioctl dump auto quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-	rm -rf $TEST_DIR/d
-	rm -f $TEST_DIR/dumpfile
-}
-
 #
 # Perform a level 0 dump that respects the chattr dump exclude flag,
 # and grep the output for the inode number we expect / do not expect
@@ -46,6 +39,7 @@ _require_user
 _require_command "$XFSDUMP_PROG" xfsdump
 
 echo "Preparing subtree"
+rm -rf $TEST_DIR/d
 mkdir $TEST_DIR/d
 touch $TEST_DIR/d/t
 inum=`stat -c "%i" $TEST_DIR/d/t`
diff --git a/tests/xfs/197 b/tests/xfs/197
index 109bf478..9e5c63d3 100755
--- a/tests/xfs/197
+++ b/tests/xfs/197
@@ -15,12 +15,6 @@
 . ./common/preamble
 _begin_fstest dir auto quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-	rm -rf $TEST_DIR/ttt
-}
-
 # Import common functions.
 . ./common/filter
 
@@ -33,6 +27,7 @@ if [ "$bitsperlong" -ne 32 ]; then
 	_notrun "This test is only valid on 32 bit machines"
 fi
 
+rm -rf $TEST_DIR/ttt
 mkdir $TEST_DIR/ttt
 for n in {1..168}; do
     touch $TEST_DIR/ttt/$n;
diff --git a/tests/xfs/199 b/tests/xfs/199
index 4669f2c3..0485a904 100755
--- a/tests/xfs/199
+++ b/tests/xfs/199
@@ -12,13 +12,6 @@
 . ./common/preamble
 _begin_fstest mount auto quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount >/dev/null 2>&1
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/201 b/tests/xfs/201
index b9f2aab1..101134e8 100755
--- a/tests/xfs/201
+++ b/tests/xfs/201
@@ -12,12 +12,6 @@
 . ./common/preamble
 _begin_fstest metadata auto quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-	_scratch_unmount
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/206 b/tests/xfs/206
index cb346b6d..71f07be8 100755
--- a/tests/xfs/206
+++ b/tests/xfs/206
@@ -15,14 +15,14 @@
 . ./common/preamble
 _begin_fstest growfs auto quick
 
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-    umount $tmpdir
-    rmdir $tmpdir
-    rm -f $tmp
-    rm -f $tmpfile
+	umount $tmpdir
+	rm -f $tmpfile
+	rmdir $tmpdir
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/220 b/tests/xfs/220
index 88eedf51..9b6c3d0b 100755
--- a/tests/xfs/220
+++ b/tests/xfs/220
@@ -12,13 +12,6 @@
 . ./common/preamble
 _begin_fstest auto quota quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount >/dev/null 2>&1
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/quota
diff --git a/tests/xfs/229 b/tests/xfs/229
index 2221b9c4..a6ce97f1 100755
--- a/tests/xfs/229
+++ b/tests/xfs/229
@@ -15,12 +15,6 @@
 . ./common/preamble
 _begin_fstest auto rw
 
-# Override the default cleanup function.
-_cleanup()
-{
-    rm -rf ${TDIR}
-}
-
 # Import common functions.
 
 # real QA test starts here
@@ -34,6 +28,7 @@ EXTSIZE="256k"
 _xfs_force_bdev data $TEST_DIR
 
 # Create the test directory
+rm -rf ${TDIR}
 mkdir ${TDIR}
 
 # Set the test directory extsize
diff --git a/tests/xfs/231 b/tests/xfs/231
index 8155d0ab..179131ea 100755
--- a/tests/xfs/231
+++ b/tests/xfs/231
@@ -14,14 +14,13 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
 	test -n "$old_cowgc_interval" && \
 		_xfs_set_cowgc_interval $old_cowgc_interval
-	rm -rf $tmp.*
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/232 b/tests/xfs/232
index 06217466..a96502a7 100755
--- a/tests/xfs/232
+++ b/tests/xfs/232
@@ -15,14 +15,13 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
 	test -n "$old_cowgc_interval" && \
 		_xfs_set_cowgc_interval $old_cowgc_interval
-	rm -rf $tmp.*
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/234 b/tests/xfs/234
index 6ff2f228..f1c3222e 100755
--- a/tests/xfs/234
+++ b/tests/xfs/234
@@ -11,13 +11,12 @@
 . ./common/preamble
 _begin_fstest auto quick rmap punch metadump
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-    cd /
-    _scratch_unmount > /dev/null 2>&1
-    rm -rf $tmp.* $metadump_file $TEST_DIR/image
+	rm -f $metadump_file $TEST_DIR/image
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/236 b/tests/xfs/236
index a66ea2d5..4d23b500 100755
--- a/tests/xfs/236
+++ b/tests/xfs/236
@@ -11,14 +11,6 @@
 . ./common/preamble
 _begin_fstest auto rmap punch
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    umount $SCRATCH_MNT > /dev/null 2>&1
-    rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/237 b/tests/xfs/237
index 34d54a6c..46d72d08 100755
--- a/tests/xfs/237
+++ b/tests/xfs/237
@@ -9,13 +9,13 @@
 . ./common/preamble
 _begin_fstest auto quick clone eio
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-    cd /
-    rm -rf $tmp.* $TEST_DIR/moo
-    _dmerror_cleanup
+	rm -rf $TEST_DIR/moo
+	_dmerror_cleanup
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/239 b/tests/xfs/239
index 5143cc2e..bead5d51 100755
--- a/tests/xfs/239
+++ b/tests/xfs/239
@@ -9,12 +9,12 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-    cd /
-    rm -rf $tmp.* $TEST_DIR/moo
+	rm -rf $TEST_DIR/moo
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/240 b/tests/xfs/240
index e5d35a83..94b1a36d 100755
--- a/tests/xfs/240
+++ b/tests/xfs/240
@@ -9,13 +9,13 @@
 . ./common/preamble
 _begin_fstest auto quick clone eio
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-    cd /
-    rm -rf $tmp.* $TEST_DIR/moo
-    _dmerror_cleanup
+	rm -rf $TEST_DIR/moo
+	_dmerror_cleanup
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/241 b/tests/xfs/241
index 7988c2d8..17e41618 100755
--- a/tests/xfs/241
+++ b/tests/xfs/241
@@ -9,12 +9,12 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-    cd /
-    rm -rf $tmp.* $TEST_DIR/moo
+	rm -rf $TEST_DIR/moo
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/244 b/tests/xfs/244
index 28f1328a..f33f6ecd 100755
--- a/tests/xfs/244
+++ b/tests/xfs/244
@@ -13,14 +13,6 @@ _begin_fstest auto quota quick
 . ./common/filter
 . ./common/quota
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
-}
-
 # real QA test starts here
 _supported_fs xfs
 _require_xfs_quota
diff --git a/tests/xfs/250 b/tests/xfs/250
index 8af32711..2575959e 100755
--- a/tests/xfs/250
+++ b/tests/xfs/250
@@ -9,14 +9,14 @@
 . ./common/preamble
 _begin_fstest auto quick rw prealloc metadata
 
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-	cd /
 	umount $LOOP_MNT 2>/dev/null
 	rm -f $LOOP_DEV
 	rmdir $LOOP_MNT
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/253 b/tests/xfs/253
index 1899ce52..884d8a4b 100755
--- a/tests/xfs/253
+++ b/tests/xfs/253
@@ -20,15 +20,6 @@
 . ./common/preamble
 _begin_fstest auto quick metadump
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-    rm -rf "${OUTPUT_DIR}"
-    rm -f "${METADUMP_FILE}"
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/259 b/tests/xfs/259
index 88e2f3ee..bdb6a492 100755
--- a/tests/xfs/259
+++ b/tests/xfs/259
@@ -9,11 +9,13 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-    rm -f "$testfile"
+	losetup -d $lofile 2> /dev/null
+	rm -f "$testfile"
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/260 b/tests/xfs/260
index a780365f..a03520d8 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -14,22 +14,13 @@
 . ./common/preamble
 _begin_fstest auto quick mkfs
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-	rm -f $localfile
-}
-
-# Import common functions.
-
 echo 'Silence is golden'
 
 _supported_fs xfs
 _require_test
 
 localfile=$TEST_DIR/$seq.$$
+rm -f $localfile
 
 $XFS_IO_PROG -f -c "truncate 10444800" $localfile
 
diff --git a/tests/xfs/261 b/tests/xfs/261
index eb8a72cd..58d942a9 100755
--- a/tests/xfs/261
+++ b/tests/xfs/261
@@ -17,13 +17,6 @@ my_mtab=${tmp}.mtab
 
 mtab=/proc/self/mounts
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    rm -f ${tmp}.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/quota
diff --git a/tests/xfs/264 b/tests/xfs/264
index 191f57d5..6529cd8f 100755
--- a/tests/xfs/264
+++ b/tests/xfs/264
@@ -10,13 +10,12 @@
 . ./common/preamble
 _begin_fstest auto quick mount eio
 
-# Override the default cleanup function.
-_cleanup()
+_dm_error_cleanup()
 {
-	cd /
-	rm -f $tmp.*
 	_dmerror_cleanup
+	_cleanup
 }
+_register_cleanup _dm_error_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/265 b/tests/xfs/265
index c0edb6d2..9ec03844 100755
--- a/tests/xfs/265
+++ b/tests/xfs/265
@@ -12,14 +12,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-    cd /
-    umount $SCRATCH_MNT > /dev/null 2>&1
-    rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/266 b/tests/xfs/266
index eeca8822..1a57f644 100755
--- a/tests/xfs/266
+++ b/tests/xfs/266
@@ -11,13 +11,12 @@ _begin_fstest dump ioctl auto quick
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 #
 # Add a new file and append a subset of the fill'ed files
diff --git a/tests/xfs/267 b/tests/xfs/267
index 89b968be..19e1f030 100755
--- a/tests/xfs/267
+++ b/tests/xfs/267
@@ -11,13 +11,12 @@ _begin_fstest dump ioctl tape
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 #
 # create a 40 MiB file with an extended attr.
diff --git a/tests/xfs/268 b/tests/xfs/268
index 8c991fba..fd668856 100755
--- a/tests/xfs/268
+++ b/tests/xfs/268
@@ -13,15 +13,13 @@ _begin_fstest dump ioctl tape
 
 status=0	# success is the default!
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
-#
 # create two 12 MiB files with extended attrs.
 # xfsdump writes file data in "extent groups", currently 16 MiB in size. After
 # writing an extent group or finishing a file, xfsdump will start a new media
diff --git a/tests/xfs/269 b/tests/xfs/269
index c1477373..d467d08d 100755
--- a/tests/xfs/269
+++ b/tests/xfs/269
@@ -9,13 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick ioctl
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -rf "$tmp".* $TEST_DIR/fsmap $TEST_DIR/testout
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/attr
diff --git a/tests/xfs/271 b/tests/xfs/271
index 14d64cd0..34c40795 100755
--- a/tests/xfs/271
+++ b/tests/xfs/271
@@ -9,12 +9,12 @@
 . ./common/preamble
 _begin_fstest auto quick rmap fsmap
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -rf "$tmp".* $TEST_DIR/fsmap $TEST_DIR/testout
+	rm -f $TEST_DIR/fsmap $TEST_DIR/testout
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/272 b/tests/xfs/272
index 7ed8b951..43a9ce1b 100755
--- a/tests/xfs/272
+++ b/tests/xfs/272
@@ -9,12 +9,12 @@
 . ./common/preamble
 _begin_fstest auto quick rmap fsmap
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -rf "$tmp".* $TEST_DIR/fsmap $TEST_DIR/bmap
+	rm -f $TEST_DIR/fsmap $TEST_DIR/bmap
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/273 b/tests/xfs/273
index a22e9d47..7f6adbb4 100755
--- a/tests/xfs/273
+++ b/tests/xfs/273
@@ -9,12 +9,12 @@
 . ./common/preamble
 _begin_fstest auto rmap fsmap
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -rf "$tmp".* $TEST_DIR/a $TEST_DIR/b
+	rm -f $TEST_DIR/a $TEST_DIR/b
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/274 b/tests/xfs/274
index dcaea688..0d1f2d04 100755
--- a/tests/xfs/274
+++ b/tests/xfs/274
@@ -9,12 +9,12 @@
 . ./common/preamble
 _begin_fstest auto quick rmap fsmap
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -rf "$tmp".* $TEST_DIR/fsmap $TEST_DIR/bmap
+	rm -f $TEST_DIR/fsmap $TEST_DIR/bmap
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/275 b/tests/xfs/275
index d22e21e9..f4c22f9e 100755
--- a/tests/xfs/275
+++ b/tests/xfs/275
@@ -9,12 +9,12 @@
 . ./common/preamble
 _begin_fstest auto quick rmap fsmap
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -rf "$tmp".* $TEST_DIR/fsmap $TEST_DIR/testout
+	rm -f $TEST_DIR/fsmap $TEST_DIR/testout
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/276 b/tests/xfs/276
index 8cc48675..487a3a42 100755
--- a/tests/xfs/276
+++ b/tests/xfs/276
@@ -9,12 +9,12 @@
 . ./common/preamble
 _begin_fstest auto quick rmap fsmap realtime
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -rf "$tmp".* $TEST_DIR/fsmap $TEST_DIR/bmap
+	rm -f $TEST_DIR/fsmap $TEST_DIR/bmap
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/277 b/tests/xfs/277
index 03208ef2..dc2ecd74 100755
--- a/tests/xfs/277
+++ b/tests/xfs/277
@@ -9,12 +9,13 @@
 . ./common/preamble
 _begin_fstest auto quick rmap fsmap
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -rf "$tmp".* $TEST_DIR/fsmap $TEST_DIR/testout
+	rm -f $TEST_DIR/fsmap $TEST_DIR/testout
+	_cleanup
 }
+_register_cleanup local_cleanup
+
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/279 b/tests/xfs/279
index 835d187f..09f1a59e 100755
--- a/tests/xfs/279
+++ b/tests/xfs/279
@@ -10,13 +10,12 @@
 . ./common/preamble
 _begin_fstest auto mkfs
 
-# Override the default cleanup function.
-_cleanup()
+_scsi_debug_cleanup()
 {
-    cd /
-    rm -f $tmp.*
-    _put_scsi_debug_dev
+	_put_scsi_debug_dev
+	_cleanup
 }
+_register_cleanup _scsi_debug_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/281 b/tests/xfs/281
index 6b148a94..eba8e39c 100755
--- a/tests/xfs/281
+++ b/tests/xfs/281
@@ -9,13 +9,12 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/282 b/tests/xfs/282
index 50303b08..53c7dc49 100755
--- a/tests/xfs/282
+++ b/tests/xfs/282
@@ -11,13 +11,12 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/283 b/tests/xfs/283
index 59ea5f3b..6d377615 100755
--- a/tests/xfs/283
+++ b/tests/xfs/283
@@ -11,13 +11,12 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/dump
diff --git a/tests/xfs/284 b/tests/xfs/284
index fa7bfdd0..69906f90 100755
--- a/tests/xfs/284
+++ b/tests/xfs/284
@@ -10,14 +10,12 @@
 . ./common/preamble
 _begin_fstest auto quick dump copy db mkfs repair metadump
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -f $tmp.*
-	rm -f $METADUMP_FILE 2>/dev/null
-	rm -f $COPY_FILE 2>/dev/null
+	rm -f $METADUMP_FILE $COPY_FILE
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/287 b/tests/xfs/287
index 31bbf0d7..fea453f5 100755
--- a/tests/xfs/287
+++ b/tests/xfs/287
@@ -14,13 +14,12 @@ _begin_fstest auto dump quota quick
 . ./common/quota
 . ./common/dump
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -rf $tmp.*
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 _print_projid()
 {
diff --git a/tests/xfs/289 b/tests/xfs/289
index c722deff..adc6d4db 100755
--- a/tests/xfs/289
+++ b/tests/xfs/289
@@ -10,16 +10,17 @@
 . ./common/preamble
 _begin_fstest growfs auto quick
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-    $UMOUNT_PROG $tmpdir
-    $UMOUNT_PROG $tmpbind
-    rmdir $tmpdir
-    rm -f $tmpsymlink
-    rmdir $tmpbind
-    rm -f $tmpfile
+	$UMOUNT_PROG $tmpdir
+	$UMOUNT_PROG $tmpbind
+	rmdir $tmpdir
+	rm -f $tmpsymlink
+	rmdir $tmpbind
+	rm -f $tmpfile
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/296 b/tests/xfs/296
index efd303e2..96268cee 100755
--- a/tests/xfs/296
+++ b/tests/xfs/296
@@ -9,13 +9,12 @@
 . ./common/preamble
 _begin_fstest dump auto quick
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
-    _cleanup_dump
-    cd /
-    rm -f $tmp.*
+	_cleanup_dump
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/299 b/tests/xfs/299
index 4b9df3c6..9846aef1 100755
--- a/tests/xfs/299
+++ b/tests/xfs/299
@@ -15,14 +15,6 @@ _begin_fstest auto quota
 . ./common/filter
 . ./common/quota
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
-}
-
 # real QA test starts here
 _supported_fs xfs
 
diff --git a/tests/xfs/301 b/tests/xfs/301
index 71ec1420..12e8bc1a 100755
--- a/tests/xfs/301
+++ b/tests/xfs/301
@@ -9,13 +9,12 @@
 . ./common/preamble
 _begin_fstest auto dump
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
-    _cleanup_dump
-    cd /
-    rm -f $tmp.*
+	_cleanup_dump
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/302 b/tests/xfs/302
index 2e16890c..14907273 100755
--- a/tests/xfs/302
+++ b/tests/xfs/302
@@ -9,13 +9,12 @@
 . ./common/preamble
 _begin_fstest auto dump
 
-# Override the default cleanup function.
-_cleanup()
+_dump_cleanup()
 {
-    _cleanup_dump
-    cd /
-    rm -f $tmp.*
+	_cleanup_dump
+	_cleanup
 }
+_register_cleanup _dump_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/309 b/tests/xfs/309
index 3e909509..f6a2ef20 100755
--- a/tests/xfs/309
+++ b/tests/xfs/309
@@ -12,14 +12,6 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/310 b/tests/xfs/310
index 3214e04b..c635b39a 100755
--- a/tests/xfs/310
+++ b/tests/xfs/310
@@ -9,14 +9,12 @@
 . ./common/preamble
 _begin_fstest auto clone rmap
 
-# Override the default cleanup function.
-_cleanup()
+_dmhuge_cleanup()
 {
-	cd /
-	umount $SCRATCH_MNT > /dev/null 2>&1
 	_dmhugedisk_cleanup
-	rm -rf $tmp.*
+	_cleanup
 }
+_register_cleanup _dmhuge_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/311 b/tests/xfs/311
index d5e3afbf..92d521d0 100755
--- a/tests/xfs/311
+++ b/tests/xfs/311
@@ -13,14 +13,12 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-# Override the default cleanup function.
-_cleanup()
+_dmdelay_cleanup()
 {
-	cd /
-	rm -f $tmp.*
-	_scratch_unmount > /dev/null 2>&1
-	_cleanup_delay > /dev/null 2>&1
+	_cleanup_delay
+	_cleanup
 }
+_register_cleanup _dmdelay_cleanup
 
 # Import common functions.
 . ./common/dmdelay
diff --git a/tests/xfs/312 b/tests/xfs/312
index 94f868fe..8a1dff27 100755
--- a/tests/xfs/312
+++ b/tests/xfs/312
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/313 b/tests/xfs/313
index 9c7cf5b9..6501a090 100755
--- a/tests/xfs/313
+++ b/tests/xfs/313
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/314 b/tests/xfs/314
index 9ac311d0..ae0df258 100755
--- a/tests/xfs/314
+++ b/tests/xfs/314
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/315 b/tests/xfs/315
index 105515ab..154e9770 100755
--- a/tests/xfs/315
+++ b/tests/xfs/315
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/316 b/tests/xfs/316
index f0af19d2..2b07346b 100755
--- a/tests/xfs/316
+++ b/tests/xfs/316
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/317 b/tests/xfs/317
index 1ca2672d..49434170 100755
--- a/tests/xfs/317
+++ b/tests/xfs/317
@@ -9,14 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick rmap
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/inject
diff --git a/tests/xfs/318 b/tests/xfs/318
index 38c7aa60..c673d680 100755
--- a/tests/xfs/318
+++ b/tests/xfs/318
@@ -9,14 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick rw
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/inject
diff --git a/tests/xfs/319 b/tests/xfs/319
index d64651fb..97bfeeae 100755
--- a/tests/xfs/319
+++ b/tests/xfs/319
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/320 b/tests/xfs/320
index d22d76d9..2a4303cb 100755
--- a/tests/xfs/320
+++ b/tests/xfs/320
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/321 b/tests/xfs/321
index 06a34347..eb824ca6 100755
--- a/tests/xfs/321
+++ b/tests/xfs/321
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/322 b/tests/xfs/322
index 89a2f741..ca0a39e6 100755
--- a/tests/xfs/322
+++ b/tests/xfs/322
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/323 b/tests/xfs/323
index 66737da0..3c535535 100755
--- a/tests/xfs/323
+++ b/tests/xfs/323
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/324 b/tests/xfs/324
index 9909db62..c753a170 100755
--- a/tests/xfs/324
+++ b/tests/xfs/324
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/325 b/tests/xfs/325
index 5b26b2b3..4046d908 100755
--- a/tests/xfs/325
+++ b/tests/xfs/325
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/326 b/tests/xfs/326
index 8b95a18a..df8c1738 100755
--- a/tests/xfs/326
+++ b/tests/xfs/326
@@ -12,14 +12,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/327 b/tests/xfs/327
index 25855f77..285b6b49 100755
--- a/tests/xfs/327
+++ b/tests/xfs/327
@@ -12,14 +12,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount > /dev/null 2>&1
-	rm -rf $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
diff --git a/tests/xfs/336 b/tests/xfs/336
index 6592419d..31df95bf 100755
--- a/tests/xfs/336
+++ b/tests/xfs/336
@@ -9,13 +9,6 @@
 . ./common/preamble
 _begin_fstest auto rmap realtime metadump
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -rf "$tmp".* $metadump_file
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/432 b/tests/xfs/432
index 86012f0b..8206616d 100755
--- a/tests/xfs/432
+++ b/tests/xfs/432
@@ -16,12 +16,12 @@
 . ./common/preamble
 _begin_fstest auto quick dir metadata metadump
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -f "$tmp".* $metadump_file $metadump_img
+	rm -f $metadump_file $metadump_img
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/438 b/tests/xfs/438
index c3008b1c..3531e46d 100755
--- a/tests/xfs/438
+++ b/tests/xfs/438
@@ -23,17 +23,21 @@
 . ./common/preamble
 _begin_fstest auto quick quota
 
-# Override the default cleanup function.
-_cleanup()
+_dmflakey_cleanup()
+{
+	_unmount_flakey
+	_cleanup_flakey
+	cleanup
+}
+local_cleanup()
 {
 	[ -z "${interval}" ] || \
 		sysctl -w fs.xfs.xfssyncd_centisecs=${interval} >/dev/null 2>&1
-	cd /
-	rm -f $tmp.*
-	_unmount_flakey >/dev/null 2>&1
-	_cleanup_flakey > /dev/null 2>&1
+	_dmflakey_cleanup
 }
 
+_register_cleanup local_cleanup
+
 # inject IO write error for the XFS filesystem except its log section
 make_xfs_scratch_flakey_table()
 {
diff --git a/tests/xfs/442 b/tests/xfs/442
index b04b1c83..a4a76ce2 100755
--- a/tests/xfs/442
+++ b/tests/xfs/442
@@ -12,13 +12,13 @@
 . ./common/preamble
 _begin_fstest auto stress clone quota
 
-# Override the default cleanup function.
-_cleanup()
+_fsstress_cleanup()
 {
-	cd /
-	rm -f $tmp.*
-	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
+	$KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
+	wait
+	_cleanup
 }
+_register_cleanup fsstress_cleanup
 
 # Import common functions.
 . ./common/quota
diff --git a/tests/xfs/447 b/tests/xfs/447
index 795c43b9..088c1c4e 100755
--- a/tests/xfs/447
+++ b/tests/xfs/447
@@ -9,13 +9,12 @@
 . ./common/preamble
 _begin_fstest auto mount
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -f $tmp.*
 	echo 0 > /sys/fs/xfs/debug/mount_delay
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/501 b/tests/xfs/501
index a9acf0af..aa74836f 100755
--- a/tests/xfs/501
+++ b/tests/xfs/501
@@ -17,13 +17,12 @@ testfile=$TEST_DIR/$seq.txt
 
 delay_knob="/sys/fs/xfs/debug/log_recovery_delay"
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
 	test -e "$delay_knob" && echo 0 > "$delay_knob"
-	rm -f $tmp.*
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/inject
diff --git a/tests/xfs/503 b/tests/xfs/503
index 6c4bfd1c..9dec0ff0 100755
--- a/tests/xfs/503
+++ b/tests/xfs/503
@@ -10,14 +10,12 @@
 . ./common/preamble
 _begin_fstest auto copy metadump
 
-_register_cleanup "_cleanup" BUS
-
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -rf $tmp.* $testdir
+	rm -rf $testdir
+	_cleanup
 }
+_register_cleanup local_cleanup BUS
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/507 b/tests/xfs/507
index b9c9ab29..abd16e38 100755
--- a/tests/xfs/507
+++ b/tests/xfs/507
@@ -16,16 +16,13 @@
 . ./common/preamble
 _begin_fstest auto clone
 
-_register_cleanup "_cleanup" BUS
-
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-	cd /
-	test -n "$loop_mount" && $UMOUNT_PROG $loop_mount > /dev/null 2>&1
-	test -n "$loop_dev" && _destroy_loop_device $loop_dev
-	rm -rf $tmp.*
+	UMOUNT_PROG $loop_mount > /dev/null 2>&1
+	test -n "$loop_dev" &&_destroy_loop_device $loop_dev
+	_cleanup
 }
+_register_cleanup _loop_cleanup BUS
 
 # Import common functions.
 . ./common/reflink
diff --git a/tests/xfs/511 b/tests/xfs/511
index d2550404..a91fde65 100755
--- a/tests/xfs/511
+++ b/tests/xfs/511
@@ -10,14 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick quota
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount
-	rm -f $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/quota
diff --git a/tests/xfs/512 b/tests/xfs/512
index 4595770e..7aee8b78 100755
--- a/tests/xfs/512
+++ b/tests/xfs/512
@@ -10,13 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick acl attr
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -f $FILE
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/attr
@@ -31,6 +24,7 @@ _require_attrs
 _require_user
 
 FILE=$TEST_DIR/foo
+rm -f $FILE
 
 echo "This is a test" > ${FILE}
 chmod g-r $FILE
diff --git a/tests/xfs/513 b/tests/xfs/513
index bfdfd4f6..13084f4d 100755
--- a/tests/xfs/513
+++ b/tests/xfs/513
@@ -9,22 +9,17 @@
 . ./common/preamble
 _begin_fstest auto mount
 
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-	cd /
-	rm -f $tmp.*
 	$UMOUNT_PROG $LOOP_MNT 2>/dev/null
-	if [ -n "$LOOP_DEV" ];then
-		_destroy_loop_device $LOOP_DEV 2>/dev/null
-	fi
-	if [ -n "$LOOP_SPARE_DEV" ];then
-		_destroy_loop_device $LOOP_SPARE_DEV 2>/dev/null
-	fi
+	[ -n "$LOOP_DEV" ] && _destroy_loop_device $LOOP_DEV
+	[ -n "$LOOP_SPARE_DEV" ] && _destroy_loop_device $LOOP_SPARE_DEV
 	rm -f $LOOP_IMG
 	rm -f $LOOP_SPARE_IMG
 	rmdir $LOOP_MNT
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/514 b/tests/xfs/514
index cf5588f2..431a3f95 100755
--- a/tests/xfs/514
+++ b/tests/xfs/514
@@ -9,14 +9,12 @@
 . ./common/preamble
 _begin_fstest auto quick db
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -f $tmp.* $file
+	rm -f $file
+	_cleanup
 }
-
-# Import common functions.
+_register_cleanup local_cleanup
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/515 b/tests/xfs/515
index 2d7bbb35..4e0d681c 100755
--- a/tests/xfs/515
+++ b/tests/xfs/515
@@ -9,14 +9,12 @@
 . ./common/preamble
 _begin_fstest auto quick quota
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -f $tmp.* $file
+	rm -f $file
+	_cleanup
 }
-
-# Import common functions.
+_register_cleanup local_cleanup
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/516 b/tests/xfs/516
index 9e1b9931..2aa20696 100755
--- a/tests/xfs/516
+++ b/tests/xfs/516
@@ -10,13 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-	rm -f $tmp.*
-	cd /
-}
-
 # Import common functions.
 . ./common/fuzzy
 
diff --git a/tests/xfs/517 b/tests/xfs/517
index 512f795f..015a7a5f 100755
--- a/tests/xfs/517
+++ b/tests/xfs/517
@@ -9,15 +9,12 @@
 . ./common/preamble
 _begin_fstest auto quick fsmap freeze
 
-_register_cleanup "_cleanup" BUS
-
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
 	$XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT > /dev/null 2>&1
-	rm -rf $tmp.*
+	_cleanup
 }
+_register_cleanup local_cleanup BUS
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/520 b/tests/xfs/520
index 2fceb07c..b24d4fee 100755
--- a/tests/xfs/520
+++ b/tests/xfs/520
@@ -14,14 +14,6 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-	_scratch_unmount > /dev/null 2>&1
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/521 b/tests/xfs/521
index 60f28740..d93b74b9 100755
--- a/tests/xfs/521
+++ b/tests/xfs/521
@@ -16,14 +16,14 @@
 . ./common/preamble
 _begin_fstest auto quick realtime growfs
 
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-	cd /
 	_scratch_unmount >> $seqres.full 2>&1
 	test -e "$rtdev" && losetup -d $rtdev >> $seqres.full 2>&1
-	rm -f $tmp.* $TEST_DIR/$seq.rtvol
+	rm -f $TEST_DIR/$seq.rtvol
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/522 b/tests/xfs/522
index 2475d584..ff0726a9 100755
--- a/tests/xfs/522
+++ b/tests/xfs/522
@@ -10,13 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick mkfs
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -f $tmp.* $def_cfgfile $fsimg
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/523 b/tests/xfs/523
index bd9b7553..ce4cecd6 100755
--- a/tests/xfs/523
+++ b/tests/xfs/523
@@ -10,13 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick mkfs
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -f $tmp.* $def_cfgfile $fsimg
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/524 b/tests/xfs/524
index fe4d134b..9811c294 100755
--- a/tests/xfs/524
+++ b/tests/xfs/524
@@ -9,12 +9,12 @@
 . ./common/preamble
 _begin_fstest auto quick mkfs
 
-# Override the default cleanup function.
-_cleanup()
+local_cleanup()
 {
-	cd /
-	rm -f $tmp.* $def_cfgfile $fsimg
+	rm -f $def_cfgfile $fsimg
+	_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/525 b/tests/xfs/525
index a17c9f19..9700f960 100755
--- a/tests/xfs/525
+++ b/tests/xfs/525
@@ -9,13 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick mkfs
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -f $tmp.* $def_cfgfile
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/526 b/tests/xfs/526
index 4261e849..edd20826 100755
--- a/tests/xfs/526
+++ b/tests/xfs/526
@@ -9,13 +9,6 @@
 . ./common/preamble
 _begin_fstest auto quick mkfs
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -f $tmp.* $def_cfgfile
-}
-
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/528 b/tests/xfs/528
index 29e81228..f76bd15f 100755
--- a/tests/xfs/528
+++ b/tests/xfs/528
@@ -10,14 +10,14 @@
 . ./common/preamble
 _begin_fstest auto quick rw realtime
 
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-	cd /
 	_scratch_unmount >> $seqres.full 2>&1
 	test -e "$rtdev" && losetup -d $rtdev >> $seqres.full 2>&1
 	rm -f $tmp.* $TEST_DIR/$seq.rtvol
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/530 b/tests/xfs/530
index 9c6f44d7..226ebd2a 100755
--- a/tests/xfs/530
+++ b/tests/xfs/530
@@ -10,14 +10,14 @@
 . ./common/preamble
 _begin_fstest auto quick realtime growfs
 
-# Override the default cleanup function.
-_cleanup()
+_loop_cleanup()
 {
-	cd /
 	_scratch_unmount >> $seqres.full 2>&1
 	test -e "$rtdev" && losetup -d $rtdev >> $seqres.full 2>&1
 	rm -f $tmp.* $TEST_DIR/$seq.rtvol
+	_cleanup
 }
+_register_cleanup _loop_cleanup
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/542 b/tests/xfs/542
index 5c45eed7..f4d3ae9d 100755
--- a/tests/xfs/542
+++ b/tests/xfs/542
@@ -13,12 +13,13 @@
 . ./common/preamble
 _begin_fstest auto quick clone
 
-_cleanup()
+_dmflakey_cleanup()
 {
+	_unmount_flakey
 	_cleanup_flakey
-	cd /
-	rm -r -f $tmp.*
+	_cleanup
 }
+_register_cleanup _dmflakey_cleanup
 
 # Import common functions.
 . ./common/reflink
diff --git a/tests/xfs/543 b/tests/xfs/543
index 913276c8..1562f563 100755
--- a/tests/xfs/543
+++ b/tests/xfs/543
@@ -11,13 +11,6 @@
 . ./common/preamble
 _begin_fstest auto quick mkfs
 
-_cleanup()
-{
-	rm -f $TEST_DIR/fubar.img
-	cd /
-	rm -r -f $tmp.*
-}
-
 # Import common functions.
 # . ./common/filter
 
diff --git a/tests/xfs/544 b/tests/xfs/544
index c7251fc3..f76aaa24 100755
--- a/tests/xfs/544
+++ b/tests/xfs/544
@@ -10,15 +10,20 @@
 . ./common/preamble
 _begin_fstest auto quick dump
 
-_cleanup()
+_dump_cleanup()
 {
 	_cleanup_dump
-	cd /
-	rm -r -f $tmp.*
+	_cleanup
+}
+
+local_cleanup()
+{
 	$UMOUNT_PROG $TEST_DIR/dest.$seq 2> /dev/null
 	rmdir $TEST_DIR/src.$seq 2> /dev/null
 	rmdir $TEST_DIR/dest.$seq 2> /dev/null
+	_dump_cleanup
 }
+_register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
-- 
2.35.1

