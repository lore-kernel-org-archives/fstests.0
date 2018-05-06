Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:29198 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751854AbeEFWpg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 May 2018 18:45:36 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fFSPL-0000Ui-4R
        for fstests@vger.kernel.org; Mon, 07 May 2018 08:45:31 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fFSPL-0000AX-3B
        for fstests@vger.kernel.org; Mon, 07 May 2018 08:45:31 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] fstests: remove old electric fence support
Date: Mon,  7 May 2018 08:45:31 +1000
Message-Id: <20180506224531.584-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Just not used anymore.

Signed-Off-By: Dave Chinner <dchinner@redhat.com>
---
 check         |  7 ++-----
 common/log    |  1 -
 common/rc     | 23 +----------------------
 common/xfs    |  9 ++++-----
 soak          |  6 +++---
 tools/auto-qa |  1 -
 6 files changed, 10 insertions(+), 37 deletions(-)

diff --git a/check b/check
index ee840115a14c..96198ac4714e 100755
--- a/check
+++ b/check
@@ -725,19 +725,16 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			touch ${RESULT_DIR}/check_dmesg
 		fi
 		if [ "$DUMP_OUTPUT" = true ]; then
-			./$seq 2>&1 | tee $tmp.rawout
+			./$seq 2>&1 | tee $tmp.out
 			# Because $? would get tee's return code
 			sts=${PIPESTATUS[0]}
 		else
-			./$seq >$tmp.rawout 2>&1
+			./$seq >$tmp.out 2>&1
 			sts=$?
 		fi
 		$timestamp && _timestamp
 		stop=`_wallclock`
 
-		_fix_malloc <$tmp.rawout >$tmp.out
-		rm -f $tmp.rawout
-
 		if [ -f core ]
 		then
 		    _err_msg="[dumped core]"
diff --git a/common/log b/common/log
index b48f6abade77..7a0a5f1f3b16 100644
--- a/common/log
+++ b/common/log
@@ -107,7 +107,6 @@ BEGIN {
 
 _filter_logprint()
 {
-    _fix_malloc |\
     sed '
         s/ver:[0-9]/ver:<VERS>/;
         s/version [0-9] format [0-9]/version <VERS> format <FORMAT>/;
diff --git a/common/rc b/common/rc
index 9ffab7fd0907..ee677e7dc6b2 100644
--- a/common/rc
+++ b/common/rc
@@ -1169,27 +1169,6 @@ _get_pids_by_name()
 	-e "/[0-9]:[0-9][0-9]  *$1 /s/ .*//p"
 }
 
-# fix malloc libs output
-#
-_fix_malloc()
-{
-    # filter out the Electric Fence notice
-    $PERL_PROG -e '
-        while (<>) {
-            if (defined $o && /^\s+Electric Fence/) {
-                chomp($o);
-                print "$o";
-                undef $o;
-                next;
-            }
-            print $o if (defined $o);
-
-            $o=$_;
-        }
-        print $o if (defined $o);
-    '
-}
-
 #
 # _df_device : get an IRIX style df line for a given device
 #
@@ -1372,7 +1351,7 @@ _do()
     (eval "echo '---' \"$cmd\"") >>$seqres.full
     (eval "$cmd") >$tmp._out 2>&1
     local ret=$?
-    cat $tmp._out | _fix_malloc >>$seqres.full
+    cat $tmp._out >>$seqres.full
     rm -f $tmp._out
     if [ $# -eq 2 ]; then
 	if [ $ret -eq 0 ]; then
diff --git a/common/xfs b/common/xfs
index e0bc3f43d3c5..92223513d561 100644
--- a/common/xfs
+++ b/common/xfs
@@ -393,8 +393,7 @@ _check_xfs_filesystem()
 	# option (-t) to avoid indexing the free space trees doesn't make it pass on
 	# large filesystems. Avoid it.
 	if [ "$LARGE_SCRATCH_DEV" != yes ]; then
-		_xfs_check $extra_log_options $device 2>&1 |\
-			_fix_malloc >$tmp.fs_check
+		_xfs_check $extra_log_options $device 2>&1 > $tmp.fs_check
 	fi
 	if [ -s $tmp.fs_check ]; then
 		_log_err "_check_xfs_filesystem: filesystem on $device is inconsistent (c)"
@@ -409,7 +408,7 @@ _check_xfs_filesystem()
 	if [ $? -ne 0 ]; then
 		_log_err "_check_xfs_filesystem: filesystem on $device is inconsistent (r)"
 		echo "*** xfs_repair -n output ***"	>>$seqres.full
-		cat $tmp.repair | _fix_malloc		>>$seqres.full
+		cat $tmp.repair				>>$seqres.full
 		echo "*** end xfs_repair output"	>>$seqres.full
 
 		ok=0
@@ -422,7 +421,7 @@ _check_xfs_filesystem()
 		if [ $? -ne 0 ]; then
 			_log_err "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild)"
 			echo "*** xfs_repair output ***"	>>$seqres.full
-			cat $tmp.repair | _fix_malloc		>>$seqres.full
+			cat $tmp.repair				>>$seqres.full
 			echo "*** end xfs_repair output"	>>$seqres.full
 
 			ok=0
@@ -433,7 +432,7 @@ _check_xfs_filesystem()
 		if [ $? -ne 0 ]; then
 			_log_err "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild-reverify)"
 			echo "*** xfs_repair -n output ***"	>>$seqres.full
-			cat $tmp.repair | _fix_malloc		>>$seqres.full
+			cat $tmp.repair				>>$seqres.full
 			echo "*** end xfs_repair output"	>>$seqres.full
 
 			ok=0
diff --git a/soak b/soak
index ec4fbb53ba1b..26b345a3e4a9 100755
--- a/soak
+++ b/soak
@@ -85,11 +85,11 @@ _log "***     (`date`)"
 _log "    *** init"
 _log "        *** unmounting scratch device"
 
-_scratch_unmount 2>&1 |  _fix_malloc >>$FULL
+_scratch_unmount 2>&1 >>$FULL
 
 _log "        *** clean scratch device"
 
-mkfs_xfs -f $SCRATCH_DEV 2>&1 |  _fix_malloc >>$FULL \
+mkfs_xfs -f $SCRATCH_DEV 2>&1 >>$FULL \
                         || _fail "            !!! failed to mkfs SCRATCH_DEV"
 
 pass=1
@@ -124,7 +124,7 @@ do
     
     _log "        *** stress"
     ltp/fsstress -d $SCRATCH_MNT/soak_test -p $proc -n $stress $FSSTRESS_AVOID 2>&1 | \
-        _fix_malloc >>$FULL
+        >>$FULL
 
     _log "        *** unmounting scratch device"
 
diff --git a/tools/auto-qa b/tools/auto-qa
index 8d8f5ef9fbf2..b81b0b5960c2 100755
--- a/tools/auto-qa
+++ b/tools/auto-qa
@@ -340,7 +340,6 @@ do
 		[ -d $WORKAREA/$pkg ] || continue
 		cd $WORKAREA/$pkg
 
-		# use e-fence - but this will only take effect on configure
 		make configure 2>&1 \
 			|| _fail "	    !!! configure $pkg failed"
 		make default 2>&1 \
-- 
2.17.0

