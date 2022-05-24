Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E44CC4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 07:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiEXHeU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 03:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiEXHeS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 03:34:18 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B76B6A418
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 00:34:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0666553454D
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 17:34:14 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-00FkVF-Gc
        for fstests@vger.kernel.org; Tue, 24 May 2022 17:34:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-008A61-FX
        for fstests@vger.kernel.org;
        Tue, 24 May 2022 17:34:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 4/8] fstests: define a common _dump_cleanup function
Date:   Tue, 24 May 2022 17:34:07 +1000
Message-Id: <20220524073411.1943480-5-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524073411.1943480-1-david@fromorbit.com>
References: <20220524073411.1943480-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=628c8a77
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=6Au0ueZs_1D9ZwnV3WUA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Almost all xfsdump tests now use the same cleanup function.
Deduplicate them.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/dump   | 53 ++++++++++++++++++++++++++-------------------------
 tests/xfs/022 | 12 ++----------
 tests/xfs/023 | 13 ++-----------
 tests/xfs/024 | 12 ++----------
 tests/xfs/025 | 12 ++----------
 tests/xfs/026 | 12 ++----------
 tests/xfs/027 | 12 ++----------
 tests/xfs/028 | 12 ++----------
 tests/xfs/035 | 10 +---------
 tests/xfs/036 |  9 +--------
 tests/xfs/037 | 10 +---------
 tests/xfs/038 |  9 +--------
 tests/xfs/039 |  9 +--------
 tests/xfs/043 |  9 +--------
 tests/xfs/046 |  9 +--------
 tests/xfs/047 |  9 +--------
 tests/xfs/055 |  9 +--------
 tests/xfs/056 | 11 +----------
 tests/xfs/059 | 12 ++----------
 tests/xfs/060 | 12 ++----------
 tests/xfs/061 | 12 ++----------
 tests/xfs/063 |  9 ++-------
 tests/xfs/064 |  9 ++-------
 tests/xfs/065 |  9 ++-------
 tests/xfs/066 | 11 +++--------
 tests/xfs/068 | 12 ++----------
 tests/xfs/266 | 14 +++-----------
 tests/xfs/267 | 13 +++----------
 tests/xfs/268 | 12 +++---------
 tests/xfs/281 |  9 +--------
 tests/xfs/282 |  9 +--------
 tests/xfs/283 |  9 +--------
 tests/xfs/287 | 11 +++--------
 tests/xfs/296 | 11 ++---------
 tests/xfs/301 | 11 ++---------
 tests/xfs/302 | 11 ++---------
 tests/xfs/544 | 10 ++--------
 37 files changed, 91 insertions(+), 347 deletions(-)

diff --git a/common/dump b/common/dump
index 0dcc9655..b6001016 100644
--- a/common/dump
+++ b/common/dump
@@ -219,41 +219,42 @@ _require_tape()
 
 #
 # Cleanup created dirs and files
-# Called by trap
-#
+# Called by trap, needs to call generic cleanup when done.
 _cleanup_dump()
 {
-    # Some tests include this before checking _supported_fs xfs
-    # and the sleeps & checks here get annoying
-    if [ "$FSTYP" != "xfs" ]; then
-       return
-    fi
+	# Some tests include this before checking _supported_fs xfs
+	# and the sleeps & checks here get annoying
+	if [ "$FSTYP" != "xfs" ]; then
+		return
+	fi
 
-    cd $here
+	cd $here
+
+	if [ -n "$DEBUGDUMP" ]; then
+		# save it for inspection
+		for dir in /var/xfsdump/inventory /var/lib/xfsdump/inventory; do
+			[ -d $dir ] || continue
+			tar -cvf $seqres.inventory.tar $dir
+			ls -nR $dir >$seqres.inventory.ls
+		done
+	fi
 
-    if [ -n "$DEBUGDUMP" ]; then
-	# save it for inspection
+	# put inventory dir back
 	for dir in /var/xfsdump/inventory /var/lib/xfsdump/inventory; do
-	    [ -d $dir ] || continue
-	    tar -cvf $seqres.inventory.tar $dir
-	    ls -nR $dir >$seqres.inventory.ls
+		[ -d $dir.$seq ] || continue
+		rm -rf $dir		# get rid of new one
+		mv $dir.$seq $dir
 	done
-    fi
 
-    # put inventory dir back
-    for dir in /var/xfsdump/inventory /var/lib/xfsdump/inventory; do
-	[ -d $dir.$seq ] || continue
-	rm -rf $dir		# get rid of new one
-	mv $dir.$seq $dir
-    done
+	if [ -f ${RESULT_DIR}/require_scratch ] && [ $status -ne $NOTRUNSTS ]; then
+		# Sleep added to stop _check_scratch_fs from complaining that
+		# the scratch_dev is still busy
+		sleep 10
 
-    if [ -f ${RESULT_DIR}/require_scratch ] && [ $status -ne $NOTRUNSTS ]; then
-	# Sleep added to stop _check_scratch_fs from complaining that the
-	# scratch_dev is still busy
-	sleep 10
+		_check_scratch_fs
+	fi
 
-	_check_scratch_fs
-    fi
+	_cleanup
 }
 
 #
diff --git a/tests/xfs/022 b/tests/xfs/022
index e9310365..2d124709 100755
--- a/tests/xfs/022
+++ b/tests/xfs/022
@@ -9,20 +9,11 @@
 #
 # Use fsstress to create a directory structure with a mix of files
 #
-seqfull=$0
 . ./common/preamble
 _begin_fstest dump ioctl tape
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
@@ -42,4 +33,5 @@ _do_restore | sed -e "/entries processed$/s/[0-9][0-9]*/NUM/g"
 _ls_compare_sub
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/023 b/tests/xfs/023
index 1019831d..e2b9ba6f 100755
--- a/tests/xfs/023
+++ b/tests/xfs/023
@@ -7,21 +7,11 @@
 # To test xfsdump/restore to tape using a directory with
 # files with data created by src/fill.
 #
-seqfull=$0
 . ./common/preamble
 _begin_fstest dump ioctl tape
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
@@ -38,4 +28,5 @@ _diff_compare_sub
 _ls_compare_sub
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/024 b/tests/xfs/024
index dcb6b9fc..920bacb2 100755
--- a/tests/xfs/024
+++ b/tests/xfs/024
@@ -9,17 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl tape
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
@@ -42,4 +33,5 @@ _do_restore
 _diff_compare
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/025 b/tests/xfs/025
index dd3c8588..479c51b4 100755
--- a/tests/xfs/025
+++ b/tests/xfs/025
@@ -9,17 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl tape
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
@@ -35,4 +26,5 @@ _do_restore_min
 _diff_compare
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/026 b/tests/xfs/026
index 18529003..0daa7c88 100755
--- a/tests/xfs/026
+++ b/tests/xfs/026
@@ -9,17 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
@@ -33,4 +24,5 @@ _do_restore_file
 _diff_compare
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/027 b/tests/xfs/027
index df6ee2ac..58e9ec68 100755
--- a/tests/xfs/027
+++ b/tests/xfs/027
@@ -9,17 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
@@ -32,4 +23,5 @@ _do_dump_restore
 _diff_compare_sub
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/028 b/tests/xfs/028
index d0518317..be7453d4 100755
--- a/tests/xfs/028
+++ b/tests/xfs/028
@@ -9,17 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
@@ -56,4 +47,5 @@ _do_invutil -F
 _dump_inventory
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/035 b/tests/xfs/035
index 6461884b..29168c5a 100755
--- a/tests/xfs/035
+++ b/tests/xfs/035
@@ -10,16 +10,8 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest dump ioctl tape auto
 
-# Override the default cleanup function.
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/036 b/tests/xfs/036
index becbc83c..ab3cbf3b 100755
--- a/tests/xfs/036
+++ b/tests/xfs/036
@@ -10,15 +10,8 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest dump ioctl remote tape
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/037 b/tests/xfs/037
index 0cbd0b16..9deff09e 100755
--- a/tests/xfs/037
+++ b/tests/xfs/037
@@ -9,16 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl remote tape
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
-
+_register_cleanup _cleanup_dump
 # real QA test starts here
 _supported_fs xfs
 
diff --git a/tests/xfs/038 b/tests/xfs/038
index da5507af..e868df79 100755
--- a/tests/xfs/038
+++ b/tests/xfs/038
@@ -9,15 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl remote tape
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/039 b/tests/xfs/039
index 69a1092d..1499d1ec 100755
--- a/tests/xfs/039
+++ b/tests/xfs/039
@@ -10,15 +10,8 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest dump ioctl remote tape
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/043 b/tests/xfs/043
index 7ce74539..6cc264b0 100755
--- a/tests/xfs/043
+++ b/tests/xfs/043
@@ -12,15 +12,8 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest dump ioctl tape
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/046 b/tests/xfs/046
index 3ac4a180..8db91972 100755
--- a/tests/xfs/046
+++ b/tests/xfs/046
@@ -9,15 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/047 b/tests/xfs/047
index c2f66e31..a0aaf3d2 100755
--- a/tests/xfs/047
+++ b/tests/xfs/047
@@ -9,15 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/055 b/tests/xfs/055
index d663bfab..eaf807d2 100755
--- a/tests/xfs/055
+++ b/tests/xfs/055
@@ -10,15 +10,8 @@ seqfull=$0
 . ./common/preamble
 _begin_fstest dump ioctl remote tape
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/056 b/tests/xfs/056
index 7a4b2423..0ecb8503 100755
--- a/tests/xfs/056
+++ b/tests/xfs/056
@@ -10,17 +10,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/059 b/tests/xfs/059
index 9428a9da..d405bdea 100755
--- a/tests/xfs/059
+++ b/tests/xfs/059
@@ -9,17 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
@@ -36,4 +27,5 @@ _ls_compare_sub
 _diff_compare
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/060 b/tests/xfs/060
index b5939f67..4aca8943 100755
--- a/tests/xfs/060
+++ b/tests/xfs/060
@@ -9,17 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
@@ -42,4 +33,5 @@ _ls_compare_sub
 _diff_compare
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/061 b/tests/xfs/061
index dcaac20c..1ff3857a 100755
--- a/tests/xfs/061
+++ b/tests/xfs/061
@@ -9,17 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
@@ -40,4 +31,5 @@ _diff_compare_sub
 _ls_nodate_compare_sub
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/063 b/tests/xfs/063
index 9193745a..a4c2b1ea 100755
--- a/tests/xfs/063
+++ b/tests/xfs/063
@@ -9,16 +9,11 @@
 . ./common/preamble
 _begin_fstest dump attr auto quick
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
+. ./common/dump
+_register_cleanup _cleanup_dump
 
 # Import common functions.
 . ./common/filter
-. ./common/dump
 . ./common/attr
 
 # real QA test starts here
diff --git a/tests/xfs/064 b/tests/xfs/064
index e332daee..19d4d8fc 100755
--- a/tests/xfs/064
+++ b/tests/xfs/064
@@ -9,16 +9,11 @@
 . ./common/preamble
 _begin_fstest dump auto
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
+. ./common/dump
+_register_cleanup _cleanup_dump
 
 # Import common functions.
 . ./common/filter
-. ./common/dump
 
 _ls_size_filter()
 {
diff --git a/tests/xfs/065 b/tests/xfs/065
index 9b31ff34..f7f2ab35 100755
--- a/tests/xfs/065
+++ b/tests/xfs/065
@@ -12,16 +12,11 @@
 . ./common/preamble
 _begin_fstest dump auto
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
+. ./common/dump
+_register_cleanup _cleanup_dump
 
 # Import common functions.
 . ./common/filter
-. ./common/dump
 . ./common/quota
 
 #
diff --git a/tests/xfs/066 b/tests/xfs/066
index 22eb10cc..2e7b67e0 100755
--- a/tests/xfs/066
+++ b/tests/xfs/066
@@ -9,16 +9,11 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-# Import common functions.
-. ./common/filter
 . ./common/dump
+_register_cleanup _cleanup_dump
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
+# Import common functions.
+. ./common/filter
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/068 b/tests/xfs/068
index ed281881..26957adc 100755
--- a/tests/xfs/068
+++ b/tests/xfs/068
@@ -10,20 +10,11 @@
 # Test for regression caused by
 # c7cb51d xfs: fix error handling at xfs_inumbers
 #
-seqfull=$0
 . ./common/preamble
 _begin_fstest auto stress dump
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
@@ -44,4 +35,5 @@ _count_restoredir_files | tee $tmp.after >> $seqres.full
 diff -u $tmp.before $tmp.after
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/266 b/tests/xfs/266
index 1a57f644..1be1ecc5 100755
--- a/tests/xfs/266
+++ b/tests/xfs/266
@@ -9,14 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
+. ./common/dump
+_register_cleanup _cleanup_dump
 
 #
 # Add a new file and append a subset of the fill'ed files
@@ -44,9 +38,6 @@ filter_cumulative_quota_updates() {
 	{print}'
 }
 
-# Import common functions.
-. ./common/dump
-
 # real QA test starts here
 _supported_fs xfs
 _require_scratch
@@ -71,4 +62,5 @@ _ls_compare_sub
 _diff_compare
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/267 b/tests/xfs/267
index 19e1f030..4bfffad7 100755
--- a/tests/xfs/267
+++ b/tests/xfs/267
@@ -9,16 +9,9 @@
 . ./common/preamble
 _begin_fstest dump ioctl tape
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
+. ./common/dump
+_register_cleanup _cleanup_dump
 
-#
 # create a 40 MiB file with an extended attr.
 # xfsdump writes file data in "extent groups", currently 16 MiB in size. After
 # writing an extent group or finishing a file, xfsdump will start a new media
@@ -38,7 +31,6 @@ End-of-File
 }
 
 # Import common functions.
-. ./common/dump
 . ./common/attr
 
 # real QA test starts here
@@ -59,4 +51,5 @@ _diff_compare
 _diff_compare_eas
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/268 b/tests/xfs/268
index fd668856..77fca55d 100755
--- a/tests/xfs/268
+++ b/tests/xfs/268
@@ -11,14 +11,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl tape
 
-status=0	# success is the default!
-
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
+. ./common/dump
+_register_cleanup _cleanup_dump
 
 # create two 12 MiB files with extended attrs.
 # xfsdump writes file data in "extent groups", currently 16 MiB in size. After
@@ -40,7 +34,6 @@ End-of-File
 }
 
 # Import common functions.
-. ./common/dump
 . ./common/attr
 
 # real QA test starts here
@@ -61,4 +54,5 @@ _diff_compare
 _diff_compare_eas
 
 # success, all done
+status=0
 exit
diff --git a/tests/xfs/281 b/tests/xfs/281
index eba8e39c..b33df7ed 100755
--- a/tests/xfs/281
+++ b/tests/xfs/281
@@ -9,15 +9,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/282 b/tests/xfs/282
index 53c7dc49..5d234de5 100755
--- a/tests/xfs/282
+++ b/tests/xfs/282
@@ -11,15 +11,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/283 b/tests/xfs/283
index 6d377615..7a145d65 100755
--- a/tests/xfs/283
+++ b/tests/xfs/283
@@ -11,15 +11,8 @@
 . ./common/preamble
 _begin_fstest dump ioctl auto quick
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
-
-# Import common functions.
 . ./common/dump
+_register_cleanup _cleanup_dump
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/287 b/tests/xfs/287
index fea453f5..ae97f0cc 100755
--- a/tests/xfs/287
+++ b/tests/xfs/287
@@ -10,16 +10,11 @@
 . ./common/preamble
 _begin_fstest auto dump quota quick
 
-# Import common functions.
-. ./common/quota
 . ./common/dump
+_register_cleanup _cleanup_dump
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
+# Import common functions.
+. ./common/quota
 
 _print_projid()
 {
diff --git a/tests/xfs/296 b/tests/xfs/296
index 96268cee..18889788 100755
--- a/tests/xfs/296
+++ b/tests/xfs/296
@@ -9,20 +9,13 @@
 . ./common/preamble
 _begin_fstest dump auto quick
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
+. ./common/dump
+_register_cleanup _cleanup_dump
 
 # Import common functions.
 . ./common/filter
-. ./common/dump
 
 # real QA test starts here
-
-# Modify as appropriate.
 _supported_fs xfs
 _require_scratch
 _require_command "$SETCAP_PROG" setcap
diff --git a/tests/xfs/301 b/tests/xfs/301
index 12e8bc1a..3d94e3a4 100755
--- a/tests/xfs/301
+++ b/tests/xfs/301
@@ -9,21 +9,14 @@
 . ./common/preamble
 _begin_fstest auto dump
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
+. ./common/dump
+_register_cleanup _cleanup_dump
 
 # Import common functions.
 . ./common/filter
-. ./common/dump
 . ./common/attr
 
 # real QA test starts here
-
-# Modify as appropriate.
 _supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
diff --git a/tests/xfs/302 b/tests/xfs/302
index 14907273..319ffb62 100755
--- a/tests/xfs/302
+++ b/tests/xfs/302
@@ -9,20 +9,13 @@
 . ./common/preamble
 _begin_fstest auto dump
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
-_register_cleanup _dump_cleanup
+. ./common/dump
+_register_cleanup _cleanup_dump
 
 # Import common functions.
 . ./common/filter
-. ./common/dump
 
 # real QA test starts here
-
-# Modify as appropriate.
 _supported_fs xfs
 _require_scratch
 _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
diff --git a/tests/xfs/544 b/tests/xfs/544
index f76aaa24..92036250 100755
--- a/tests/xfs/544
+++ b/tests/xfs/544
@@ -10,27 +10,21 @@
 . ./common/preamble
 _begin_fstest auto quick dump
 
-_dump_cleanup()
-{
-	_cleanup_dump
-	_cleanup
-}
+. ./common/dump
 
 local_cleanup()
 {
 	$UMOUNT_PROG $TEST_DIR/dest.$seq 2> /dev/null
 	rmdir $TEST_DIR/src.$seq 2> /dev/null
 	rmdir $TEST_DIR/dest.$seq 2> /dev/null
-	_dump_cleanup
+	_cleanup_dump
 }
 _register_cleanup local_cleanup
 
 # Import common functions.
 . ./common/filter
-. ./common/dump
 
 # real QA test starts here
-
 _supported_fs xfs
 
 # Setup
-- 
2.35.1

