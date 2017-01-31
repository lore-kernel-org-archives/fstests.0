Received: from mail-lf0-f42.google.com ([209.85.215.42]:33504 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdAaRna (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2017 12:43:30 -0500
Received: by mail-lf0-f42.google.com with SMTP id x1so128645372lff.0
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2017 09:43:25 -0800 (PST)
From: Dmitry Monakhov <dmongw@gmail.com>
Subject: [PATCH 1/2] check: prepare test report generator infrastructure
Date: Tue, 31 Jan 2017 21:43:20 +0400
Message-Id: <1485884601-21651-2-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1485884601-21651-1-git-send-email-dmonakhov@openvz.org>
References: <1485884601-21651-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

Save testcase data which later may be used by report generators
- Save failure reason to $err_msg variable
- Save number of notrun tests to $n_notrun counter, similar to $n_try,$n_bad

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 check        | 32 ++++++++++++++++++++++----------
 common/btrfs | 12 ++++++------
 common/rc    | 20 +++++++++++++-------
 common/xfs   | 33 +++++++++++++++++----------------
 4 files changed, 58 insertions(+), 39 deletions(-)

diff --git a/check b/check
index 5a93c94..edc0899 100755
--- a/check
+++ b/check
@@ -28,6 +28,7 @@ try=""
 n_bad=0
 sum_bad=0
 bad=""
+n_notrun=0
 notrun=""
 interrupt=true
 diff="diff -u"
@@ -37,6 +38,7 @@ randomize=false
 export here=`pwd`
 xfile=""
 brief_test_summary=false
+err_msg=""
 
 DUMP_OUTPUT=false
 
@@ -368,6 +370,7 @@ _wipe_counters()
 {
 	n_try="0"
 	n_bad="0"
+	n_notrun="0"
 	unset try notrun bad
 }
 
@@ -596,6 +599,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	for seq in $list
 	do
 	    err=false
+	    err_msg=""
 	    if [ ! -f $seq ]; then
 	        # Try to get full name in case the user supplied only seq id
 	        # and the test has a name. A bit of hassle to find really
@@ -629,14 +633,17 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	    echo -n "$seqnum"
 
-		if $showme; then
-			echo
-			continue
-		fi
+	    if $showme; then
+		echo
+		start=0
+		stop=0
+		n_notrun=`expr $n_notrun + 1`
+		continue
+	    fi
 
-		if [ ! -f $seq ]; then
-			echo " - no such test?"
-		else
+	    if [ ! -f $seq ]; then
+		echo " - no such test?"
+	    else
 		# really going to try and run this one
 		#
 		rm -f $seqres.out.bad
@@ -684,7 +691,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 		if [ -f core ]
 		then
-		    echo -n " [dumped core]"
+		    err_msg="[dumped core]"
+		    echo -n " $err_msg"
 		    mv core $RESULT_BASE/$seqnum.core
 		    err=true
 		fi
@@ -695,15 +703,18 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		    $timestamp && echo " [not run]" && echo -n "	$seqnum -- "
 		    cat $seqres.notrun
 		    notrun="$notrun $seqnum"
+		    n_notrun=`expr $n_notrun + 1`
 		else
 		    if [ $sts -ne 0 ]
 		    then
-			echo -n " [failed, exit status $sts]"
+			err_msg="[failed, exit status $sts]"
+			echo -n " $err_msg"
 			err=true
 		    fi
 		    if [ ! -f $seq.out ]
 		    then
-			echo " - no qualified output"
+			err_msg="no qualified output"
+			echo "- $err_msg"
 			err=true
 		    else
 
@@ -733,6 +744,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 						" to see the entire diff)"
 				fi; } | \
 				sed -e 's/^\(.\)/    \1/'
+			    err_msg="output mismatch (see $diff $seq.out $seqres.out.bad)"
 			    err=true
 			fi
 		    fi
diff --git a/common/btrfs b/common/btrfs
index 96c3635..64c40bd 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -105,24 +105,24 @@ _check_btrfs_filesystem()
 	if [ -f ${RESULT_DIR}/require_scratch.require_qgroup_report ]; then
 		$BTRFS_UTIL_PROG check $device --qgroup-report > $tmp.qgroup_report 2>&1
 		if grep -qE "Counts for qgroup.*are different" $tmp.qgroup_report ; then
-			echo "_check_btrfs_filesystem: filesystem on $device has wrong qgroup numbers (see $seqres.full)"
-			echo "_check_btrfs_filesystem: filesystem on $device has wrong qgroup numbers" \
-				>> $seqres.full
+			msg="_check_btrfs_filesystem: filesystem on $device has wrong qgroup numbers"
+			echo "$msg"					>> $seqres.full
 			echo "*** qgroup_report.$FSTYP output ***"	>>$seqres.full
 			cat $tmp.qgroup_report				>>$seqres.full
 			echo "*** qgroup_report.$FSTYP output ***"	>>$seqres.full
+			err_msg="$msg (see $seqres.full)"
 		fi
 		rm -f $tmp.qgroup_report
 	fi
 
 	$BTRFS_UTIL_PROG check $device >$tmp.fsck 2>&1
 	if [ $? -ne 0 ]; then
-		echo "_check_btrfs_filesystem: filesystem on $device is inconsistent (see $seqres.full)"
-
-		echo "_check_btrfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
+		msg="_check_btrfs_filesystem: filesystem on $device is inconsistent"
+		echo "$msg"				>>$seqres.full
 		echo "*** fsck.$FSTYP output ***"	>>$seqres.full
 		cat $tmp.fsck				>>$seqres.full
 		echo "*** end fsck.$FSTYP output"	>>$seqres.full
+		err_msg="$msg (see $seqres.full)"
 
 		ok=0
 	fi
diff --git a/common/rc b/common/rc
index 7e2eaee..f97b4d2 100644
--- a/common/rc
+++ b/common/rc
@@ -1017,7 +1017,10 @@ _repair_scratch_fs()
 		_scratch_xfs_repair "$@" 2>&1
 		res=$?
 	fi
-	test $res -ne 0 && >&2 echo "xfs_repair failed, err=$res"
+	if [ test $res -ne 0]; then
+		err_msg="xfs_repair failed, err=$res"
+		>&2 echo "$err_msg"
+	fi
 	return $res
         ;;
     *)
@@ -1029,7 +1032,8 @@ _repair_scratch_fs()
 		res=0
 		;;
 	*)
-		>&2 echo "fsck.$FSTYP failed, err=$res"
+		err_msg="fsck.$FSTYP failed, err=$res"
+		>&2 echo "$err_msg"
 		;;
 	esac
 	return $res
@@ -2130,7 +2134,8 @@ _mount_or_remount_rw()
 			_overlay_mount $device $mountpoint
 		fi
 		if [ $? -ne 0 ]; then
-			echo "!!! failed to remount $device on $mountpoint"
+			err_msg="!!! failed to remount $device on $mountpoint"
+			echo "$err_msg"
 			return 0 # ok=0
 		fi
 	else
@@ -2164,12 +2169,12 @@ _check_generic_filesystem()
     fsck -t $FSTYP $FSCK_OPTIONS $device >$tmp.fsck 2>&1
     if [ $? -ne 0 ]
     then
-        echo "_check_generic_filesystem: filesystem on $device is inconsistent (see $seqres.full)"
-
-        echo "_check_generic filesystem: filesystem on $device is inconsistent" >>$seqres.full
+	msg="_check_generic_filesystem: filesystem on $device is inconsistent"
+	echo "$msg"				>>$seqres.full
         echo "*** fsck.$FSTYP output ***"	>>$seqres.full
         cat $tmp.fsck				>>$seqres.full
         echo "*** end fsck.$FSTYP output"	>>$seqres.full
+	err_msg="$msg (see $seqres.full)"
 
         ok=0
     fi
@@ -3023,7 +3028,8 @@ _check_dmesg()
 	     -e "general protection fault:" \
 	     $seqres.dmesg
 	if [ $? -eq 0 ]; then
-		echo "_check_dmesg: something found in dmesg (see $seqres.dmesg)"
+		err_msg="_check_dmesg: something found in dmesg (see $seqres.dmesg)"
+		echo "$err_msg"
 		return 1
 	else
 		rm -f $seqres.dmesg
diff --git a/common/xfs b/common/xfs
index 767a481..ad4c505 100644
--- a/common/xfs
+++ b/common/xfs
@@ -333,7 +333,8 @@ _check_xfs_filesystem()
 		if [ -n "$TEST_XFS_SCRUB" ] && [ -x "$XFS_SCRUB_PROG" ]; then
 			"$XFS_SCRUB_PROG" $scrubflag -vd $device >>$seqres.full
 			if [ $? -ne 0 ]; then
-				echo "filesystem on $device failed scrub (see $seqres.full)"
+				err_msg="filesystem on $device failed scrub (see $seqres.full)"
+				echo "$err_msg"
 				ok=0
 			fi
 		fi
@@ -344,12 +345,12 @@ _check_xfs_filesystem()
 	$XFS_LOGPRINT_PROG -t $extra_log_options $device 2>&1 \
 		| tee $tmp.logprint | grep -q "<CLEAN>"
 	if [ $? -ne 0 -a "$HOSTOS" = "Linux" ]; then
-		echo "_check_xfs_filesystem: filesystem on $device has dirty log (see $seqres.full)"
-
-		echo "_check_xfs_filesystem: filesystem on $device has dirty log"   >>$seqres.full
+		msg="_check_xfs_filesystem: filesystem on $device has dirty log"
+		echo "$msg"				>>$seqres.full
 		echo "*** xfs_logprint -t output ***"	>>$seqres.full
 		cat $tmp.logprint			>>$seqres.full
 		echo "*** end xfs_logprint output"	>>$seqres.full
+		err_msg="$msg (see $seqres.full)"
 
 		ok=0
 	fi
@@ -362,24 +363,24 @@ _check_xfs_filesystem()
 			_fix_malloc >$tmp.fs_check
 	fi
 	if [ -s $tmp.fs_check ]; then
-		echo "_check_xfs_filesystem: filesystem on $device is inconsistent (c) (see $seqres.full)"
-
-		echo "_check_xfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
+		msg="_check_xfs_filesystem: filesystem on $device is inconsistent (c)"
+		echo "$msg"	 			>>$seqres.full
 		echo "*** xfs_check output ***"		>>$seqres.full
 		cat $tmp.fs_check			>>$seqres.full
 		echo "*** end xfs_check output"		>>$seqres.full
+		err_msg="$msg (see $seqres.full)"
 
 		ok=0
 	fi
 
 	$XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
 	if [ $? -ne 0 ]; then
-		echo "_check_xfs_filesystem: filesystem on $device is inconsistent (r) (see $seqres.full)"
-
-		echo "_check_xfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
+		msg="_check_xfs_filesystem: filesystem on $device is inconsistent (r)"
+		echo "$msg"				>>$seqres.full
 		echo "*** xfs_repair -n output ***"	>>$seqres.full
 		cat $tmp.repair | _fix_malloc		>>$seqres.full
 		echo "*** end xfs_repair output"	>>$seqres.full
+		err_msg="$msg (see $seqres.full)"
 
 		ok=0
 	fi
@@ -389,12 +390,12 @@ _check_xfs_filesystem()
 	if [ -n "$TEST_XFS_REPAIR_REBUILD" ]; then
 		$XFS_REPAIR_PROG $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
 		if [ $? -ne 0 ]; then
-			echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild) (see $seqres.full)"
-
-			echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild)" >>$seqres.full
+			msg="_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild)"
+			echo "$msg"				>>$seqres.full
 			echo "*** xfs_repair output ***"	>>$seqres.full
 			cat $tmp.repair | _fix_malloc		>>$seqres.full
 			echo "*** end xfs_repair output"	>>$seqres.full
+			err_msg="$msg (see $seqres.full)"
 
 			ok=0
 		fi
@@ -402,12 +403,12 @@ _check_xfs_filesystem()
 
 		$XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
 		if [ $? -ne 0 ]; then
-			echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild-reverify) (see $seqres.full)"
-
-			echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild-reverify)" >>$seqres.full
+			err_msg="_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild-reverify)"
+			echo "$msg"				>>$seqres.full
 			echo "*** xfs_repair -n output ***"	>>$seqres.full
 			cat $tmp.repair | _fix_malloc		>>$seqres.full
 			echo "*** end xfs_repair output"	>>$seqres.full
+			err_msg="$msg (see $seqres.full)"
 
 			ok=0
 		fi
-- 
2.9.3

