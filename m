Received: from mx1.redhat.com ([209.132.183.28]:40282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753591AbcLAEWa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 30 Nov 2016 23:22:30 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F07537AE81
        for <fstests@vger.kernel.org>; Thu,  1 Dec 2016 04:22:29 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] common: cleanups after common/rc split
Date: Thu,  1 Dec 2016 12:22:13 +0800
Message-Id: <20161201042213.16859-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Fix code style issues after the common/rc split, e.g. use tab
indention, fix if-then-else format, fix while-do and for-do format
and various whitespace issues. No functional changes.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

This is a follow-up patch to Dave's "make common/rc easier to manage" patchset.

 common/btrfs |  87 ++++++-------
 common/xfs   | 404 +++++++++++++++++++++++++++++------------------------------
 2 files changed, 239 insertions(+), 252 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 7cc4f5d..ab6497d 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -68,53 +68,49 @@ _require_btrfs_fs_feature()
 
 _check_btrfs_filesystem()
 {
-    device=$1
-
-    # If type is set, we're mounted
-    type=`_fs_type $device`
-    ok=1
-
-    if [ "$type" = "$FSTYP" ]
-    then
-        # mounted ...
-        mountpoint=`_umount_or_remount_ro $device`
-    fi
-
-    btrfsck $device >$tmp.fsck 2>&1
-    if [ $? -ne 0 ]
-    then
-        echo "_check_btrfs_filesystem: filesystem on $device is inconsistent (see $seqres.full)"
-
-        echo "_check_btrfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
-        echo "*** fsck.$FSTYP output ***"	>>$seqres.full
-        cat $tmp.fsck				>>$seqres.full
-        echo "*** end fsck.$FSTYP output"	>>$seqres.full
-
-        ok=0
-    fi
-    rm -f $tmp.fsck
-
-    if [ $ok -eq 0 ]
-    then
-        echo "*** mount output ***"		>>$seqres.full
-        _mount					>>$seqres.full
-        echo "*** end mount output"		>>$seqres.full
-    elif [ "$type" = "$FSTYP" ]
-    then
-	# was mounted ...
-	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
-	ok=$?
-    fi
-
-    if [ $ok -eq 0 ]; then
-	status=1
-	if [ "$iam" != "check" ]; then
-		exit 1
+	device=$1
+
+	# If type is set, we're mounted
+	type=`_fs_type $device`
+	ok=1
+
+	if [ "$type" = "$FSTYP" ]; then
+		# mounted ...
+		mountpoint=`_umount_or_remount_ro $device`
 	fi
-	return 1
-    fi
 
-    return 0
+	btrfsck $device >$tmp.fsck 2>&1
+	if [ $? -ne 0 ]; then
+		echo "_check_btrfs_filesystem: filesystem on $device is inconsistent (see $seqres.full)"
+
+		echo "_check_btrfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
+		echo "*** fsck.$FSTYP output ***"	>>$seqres.full
+		cat $tmp.fsck				>>$seqres.full
+		echo "*** end fsck.$FSTYP output"	>>$seqres.full
+
+		ok=0
+	fi
+	rm -f $tmp.fsck
+
+	if [ $ok -eq 0 ]; then
+		echo "*** mount output ***"		>>$seqres.full
+		_mount					>>$seqres.full
+		echo "*** end mount output"		>>$seqres.full
+	elif [ "$type" = "$FSTYP" ]; then
+		# was mounted ...
+		_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
+		ok=$?
+	fi
+
+	if [ $ok -eq 0 ]; then
+		status=1
+		if [ "$iam" != "check" ]; then
+			exit 1
+		fi
+		return 1
+	fi
+
+	return 0
 }
 
 _require_btrfs_dev_del_by_devid()
@@ -332,4 +328,3 @@ _reload_btrfs_ko()
 	modprobe -r btrfs || _fail "btrfs unload failed"
 	modprobe btrfs || _fail "btrfs load failed"
 }
-
diff --git a/common/xfs b/common/xfs
index 0dde83f..53cd4de 100644
--- a/common/xfs
+++ b/common/xfs
@@ -135,44 +135,43 @@ _scratch_mkfs_xfs()
 # maintain the current verification levels.
 _xfs_check()
 {
-    OPTS=" "
-    DBOPTS=" "
-    USAGE="Usage: xfs_check [-fsvV] [-l logdev] [-i ino]... [-b bno]... special"
-
-    while getopts "b:fi:l:stvV" c
-    do
-        case $c in
-            s) OPTS=$OPTS"-s ";;
-            t) OPTS=$OPTS"-t ";;
-            v) OPTS=$OPTS"-v ";;
-            i) OPTS=$OPTS"-i "$OPTARG" ";;
-            b) OPTS=$OPTS"-b "$OPTARG" ";;
-            f) DBOPTS=$DBOPTS" -f";;
-            l) DBOPTS=$DBOPTS" -l "$OPTARG" ";;
-            V) $XFS_DB_PROG -p xfs_check -V
-                return $?
-                ;;
-        esac
-    done
-    set -- extra $@
-    shift $OPTIND
-    case $# in
-        1)    ${XFS_DB_PROG}${DBOPTS} -F -i -p xfs_check -c "check$OPTS" $1
-               status=$?
-               ;;
-        2)    echo $USAGE 1>&1
-              status=2
-              ;;
-    esac
-    return $status
+	OPTS=" "
+	DBOPTS=" "
+	USAGE="Usage: xfs_check [-fsvV] [-l logdev] [-i ino]... [-b bno]... special"
+
+	while getopts "b:fi:l:stvV" c; do
+		case $c in
+			s) OPTS=$OPTS"-s ";;
+			t) OPTS=$OPTS"-t ";;
+			v) OPTS=$OPTS"-v ";;
+			i) OPTS=$OPTS"-i "$OPTARG" ";;
+			b) OPTS=$OPTS"-b "$OPTARG" ";;
+			f) DBOPTS=$DBOPTS" -f";;
+			l) DBOPTS=$DBOPTS" -l "$OPTARG" ";;
+			V) $XFS_DB_PROG -p xfs_check -V
+			   return $?
+			   ;;
+		esac
+	done
+	set -- extra $@
+	shift $OPTIND
+	case $# in
+		1) ${XFS_DB_PROG}${DBOPTS} -F -i -p xfs_check -c "check$OPTS" $1
+		   status=$?
+		   ;;
+		2) echo $USAGE 1>&1
+		   status=2
+		   ;;
+	esac
+	return $status
 }
 
 _scratch_xfs_db_options()
 {
-    SCRATCH_OPTIONS=""
-    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
-        SCRATCH_OPTIONS="-l$SCRATCH_LOGDEV"
-    echo $SCRATCH_OPTIONS $* $SCRATCH_DEV
+	SCRATCH_OPTIONS=""
+	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
+		SCRATCH_OPTIONS="-l$SCRATCH_LOGDEV"
+	echo $SCRATCH_OPTIONS $* $SCRATCH_DEV
 }
 
 _scratch_xfs_db()
@@ -182,10 +181,10 @@ _scratch_xfs_db()
 
 _scratch_xfs_logprint()
 {
-    SCRATCH_OPTIONS=""
-    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
-        SCRATCH_OPTIONS="-l$SCRATCH_LOGDEV"
-    $XFS_LOGPRINT_PROG $SCRATCH_OPTIONS $* $SCRATCH_DEV
+	SCRATCH_OPTIONS=""
+	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
+		SCRATCH_OPTIONS="-l$SCRATCH_LOGDEV"
+	$XFS_LOGPRINT_PROG $SCRATCH_OPTIONS $* $SCRATCH_DEV
 }
 
 _test_xfs_logprint()
@@ -198,23 +197,23 @@ _test_xfs_logprint()
 
 _scratch_xfs_check()
 {
-    SCRATCH_OPTIONS=""
-    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
-        SCRATCH_OPTIONS="-l $SCRATCH_LOGDEV"
-    [ "$LARGE_SCRATCH_DEV" = yes ] && \
-        SCRATCH_OPTIONS=$SCRATCH_OPTIONS" -t"
-    _xfs_check $SCRATCH_OPTIONS $* $SCRATCH_DEV
+	SCRATCH_OPTIONS=""
+	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
+		SCRATCH_OPTIONS="-l $SCRATCH_LOGDEV"
+	[ "$LARGE_SCRATCH_DEV" = yes ] && \
+		SCRATCH_OPTIONS=$SCRATCH_OPTIONS" -t"
+	_xfs_check $SCRATCH_OPTIONS $* $SCRATCH_DEV
 }
 
 _scratch_xfs_repair()
 {
-    SCRATCH_OPTIONS=""
-    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
-        SCRATCH_OPTIONS="-l$SCRATCH_LOGDEV"
-    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ] && \
-        SCRATCH_OPTIONS=$SCRATCH_OPTIONS" -r$SCRATCH_RTDEV"
-    [ "$LARGE_SCRATCH_DEV" = yes ] && SCRATCH_OPTIONS=$SCRATCH_OPTIONS" -t"
-    $XFS_REPAIR_PROG $SCRATCH_OPTIONS $* $SCRATCH_DEV
+	SCRATCH_OPTIONS=""
+	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
+		SCRATCH_OPTIONS="-l$SCRATCH_LOGDEV"
+	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ] && \
+		SCRATCH_OPTIONS=$SCRATCH_OPTIONS" -r$SCRATCH_RTDEV"
+	[ "$LARGE_SCRATCH_DEV" = yes ] && SCRATCH_OPTIONS=$SCRATCH_OPTIONS" -t"
+	$XFS_REPAIR_PROG $SCRATCH_OPTIONS $* $SCRATCH_DEV
 }
 
 # this test requires the projid32bit feature to be available in mkfs.xfs.
@@ -309,8 +308,7 @@ _require_xfs_sparse_inodes()
 # check that xfs_db supports a specific command
 _require_xfs_db_command()
 {
-	if [ $# -ne 1 ]
-	then
+	if [ $# -ne 1 ]; then
 		echo "Usage: _require_xfs_db_command command" 1>&2
 		exit 1
 	fi
@@ -323,164 +321,157 @@ _require_xfs_db_command()
 # run xfs_check and friends on a FS.
 _check_xfs_filesystem()
 {
-    if [ $# -ne 3 ]
-    then
-	echo "Usage: _check_xfs_filesystem device <logdev>|none <rtdev>|none" 1>&2
-	exit 1
-    fi
-
-    extra_mount_options=""
-    extra_log_options=""
-    extra_options=""
-    device=$1
-    if [ -f $device ];then
-       extra_options="-f"
-    fi
-
-    if [ "$2" != "none" ]; then
-	extra_log_options="-l$2"
-        extra_mount_options="-ologdev=$2"
-    fi
-
-    if [ "$3" != "none" ]; then
-	extra_rt_options="-r$3"
-        extra_mount_options=$extra_mount_options" -ortdev=$3"
-    fi
-    extra_mount_options=$extra_mount_options" $MOUNT_OPTIONS"
-
-    [ "$FSTYP" != xfs ] && return 0
-
-    type=`_fs_type $device`
-    ok=1
-
-    if [ "$type" = "xfs" ]
-    then
-        if [ -n "$TEST_XFS_SCRUB" ] && [ -x "$XFS_SCRUB_PROG" ]; then
-            "$XFS_SCRUB_PROG" $scrubflag -vd $device >>$seqres.full
-            if [ $? -ne 0 ]; then
-                echo "filesystem on $device failed scrub (see $seqres.full)"
-                ok=0
-            fi
-        fi
-        # mounted ...
-        mountpoint=`_umount_or_remount_ro $device`
-    fi
-
-    $XFS_LOGPRINT_PROG -t $extra_log_options $device 2>&1 \
-                | tee $tmp.logprint | grep -q "<CLEAN>"
-    if [ $? -ne 0 -a "$HOSTOS" = "Linux" ]
-    then
-        echo "_check_xfs_filesystem: filesystem on $device has dirty log (see $seqres.full)"
-
-        echo "_check_xfs_filesystem: filesystem on $device has dirty log"   >>$seqres.full
-        echo "*** xfs_logprint -t output ***"	>>$seqres.full
-        cat $tmp.logprint			>>$seqres.full
-        echo "*** end xfs_logprint output"	>>$seqres.full
-
-        ok=0
-    fi
-
-    # xfs_check runs out of memory on large files, so even providing the test
-    # option (-t) to avoid indexing the free space trees doesn't make it pass on
-    # large filesystems. Avoid it.
-    if [ "$LARGE_SCRATCH_DEV" != yes ]; then
-	    _xfs_check $extra_log_options $device 2>&1 |\
-		 _fix_malloc >$tmp.fs_check
-    fi
-    if [ -s $tmp.fs_check ]
-    then
-        echo "_check_xfs_filesystem: filesystem on $device is inconsistent (c) (see $seqres.full)"
-
-        echo "_check_xfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
-        echo "*** xfs_check output ***"		>>$seqres.full
-        cat $tmp.fs_check			>>$seqres.full
-        echo "*** end xfs_check output"		>>$seqres.full
-
-        ok=0
-    fi
-
-    $XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
-    if [ $? -ne 0 ]
-    then
-        echo "_check_xfs_filesystem: filesystem on $device is inconsistent (r) (see $seqres.full)"
-
-        echo "_check_xfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
-        echo "*** xfs_repair -n output ***"	>>$seqres.full
-        cat $tmp.repair | _fix_malloc		>>$seqres.full
-        echo "*** end xfs_repair output"	>>$seqres.full
-
-        ok=0
-    fi
-    rm -f $tmp.fs_check $tmp.logprint $tmp.repair
-
-    # Optionally test the index rebuilding behavior.
-    if [ -n "$TEST_XFS_REPAIR_REBUILD" ]; then
-        $XFS_REPAIR_PROG $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
-        if [ $? -ne 0 ]; then
-            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild) (see $seqres.full)"
-
-            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild)" >>$seqres.full
-            echo "*** xfs_repair output ***"	>>$seqres.full
-            cat $tmp.repair | _fix_malloc		>>$seqres.full
-            echo "*** end xfs_repair output"	>>$seqres.full
-
-            ok=0
-        fi
-        rm -f $tmp.repair
-
-        $XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
-        if [ $? -ne 0 ]; then
-            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild-reverify) (see $seqres.full)"
-
-            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild-reverify)" >>$seqres.full
-            echo "*** xfs_repair -n output ***"	>>$seqres.full
-            cat $tmp.repair | _fix_malloc		>>$seqres.full
-            echo "*** end xfs_repair output"	>>$seqres.full
-
-            ok=0
-        fi
-        rm -f $tmp.repair
-    fi
-
-    if [ $ok -eq 0 ]
-    then
-        echo "*** mount output ***"		>>$seqres.full
-        _mount					>>$seqres.full
-        echo "*** end mount output"		>>$seqres.full
-    elif [ "$type" = "xfs" ]
-    then
-	_mount_or_remount_rw "$extra_mount_options" $device $mountpoint
-    fi
-
-    if [ $ok -eq 0 ]; then
-	status=1
-	if [ "$iam" != "check" ]; then
+	if [ $# -ne 3 ]; then
+		echo "Usage: _check_xfs_filesystem device <logdev>|none <rtdev>|none" 1>&2
 		exit 1
 	fi
-	return 1
-    fi
 
-    return 0
+	extra_mount_options=""
+	extra_log_options=""
+	extra_options=""
+	device=$1
+	if [ -f $device ]; then
+		extra_options="-f"
+	fi
+
+	if [ "$2" != "none" ]; then
+		extra_log_options="-l$2"
+		extra_mount_options="-ologdev=$2"
+	fi
+
+	if [ "$3" != "none" ]; then
+		extra_rt_options="-r$3"
+		extra_mount_options=$extra_mount_options" -ortdev=$3"
+	fi
+	extra_mount_options=$extra_mount_options" $MOUNT_OPTIONS"
+
+	[ "$FSTYP" != xfs ] && return 0
+
+	type=`_fs_type $device`
+	ok=1
+
+	if [ "$type" = "xfs" ]; then
+		if [ -n "$TEST_XFS_SCRUB" ] && [ -x "$XFS_SCRUB_PROG" ]; then
+			"$XFS_SCRUB_PROG" $scrubflag -vd $device >>$seqres.full
+			if [ $? -ne 0 ]; then
+				echo "filesystem on $device failed scrub (see $seqres.full)"
+				ok=0
+			fi
+		fi
+		# mounted ...
+		mountpoint=`_umount_or_remount_ro $device`
+	fi
+
+	$XFS_LOGPRINT_PROG -t $extra_log_options $device 2>&1 \
+		| tee $tmp.logprint | grep -q "<CLEAN>"
+	if [ $? -ne 0 -a "$HOSTOS" = "Linux" ]; then
+		echo "_check_xfs_filesystem: filesystem on $device has dirty log (see $seqres.full)"
+
+		echo "_check_xfs_filesystem: filesystem on $device has dirty log"   >>$seqres.full
+		echo "*** xfs_logprint -t output ***"	>>$seqres.full
+		cat $tmp.logprint			>>$seqres.full
+		echo "*** end xfs_logprint output"	>>$seqres.full
+
+		ok=0
+	fi
+
+	# xfs_check runs out of memory on large files, so even providing the test
+	# option (-t) to avoid indexing the free space trees doesn't make it pass on
+	# large filesystems. Avoid it.
+	if [ "$LARGE_SCRATCH_DEV" != yes ]; then
+		_xfs_check $extra_log_options $device 2>&1 |\
+			_fix_malloc >$tmp.fs_check
+	fi
+	if [ -s $tmp.fs_check ]; then
+		echo "_check_xfs_filesystem: filesystem on $device is inconsistent (c) (see $seqres.full)"
+
+		echo "_check_xfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
+		echo "*** xfs_check output ***"		>>$seqres.full
+		cat $tmp.fs_check			>>$seqres.full
+		echo "*** end xfs_check output"		>>$seqres.full
+
+		ok=0
+	fi
+
+	$XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
+	if [ $? -ne 0 ]; then
+		echo "_check_xfs_filesystem: filesystem on $device is inconsistent (r) (see $seqres.full)"
+
+		echo "_check_xfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
+		echo "*** xfs_repair -n output ***"	>>$seqres.full
+		cat $tmp.repair | _fix_malloc		>>$seqres.full
+		echo "*** end xfs_repair output"	>>$seqres.full
+
+		ok=0
+	fi
+	rm -f $tmp.fs_check $tmp.logprint $tmp.repair
+
+	# Optionally test the index rebuilding behavior.
+	if [ -n "$TEST_XFS_REPAIR_REBUILD" ]; then
+		$XFS_REPAIR_PROG $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
+		if [ $? -ne 0 ]; then
+			echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild) (see $seqres.full)"
+
+			echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild)" >>$seqres.full
+			echo "*** xfs_repair output ***"	>>$seqres.full
+			cat $tmp.repair | _fix_malloc		>>$seqres.full
+			echo "*** end xfs_repair output"	>>$seqres.full
+
+			ok=0
+		fi
+		rm -f $tmp.repair
+
+		$XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
+		if [ $? -ne 0 ]; then
+			echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild-reverify) (see $seqres.full)"
+
+			echo "_check_xfs_filesystem: filesystem on $device is inconsistent (rebuild-reverify)" >>$seqres.full
+			echo "*** xfs_repair -n output ***"	>>$seqres.full
+			cat $tmp.repair | _fix_malloc		>>$seqres.full
+			echo "*** end xfs_repair output"	>>$seqres.full
+
+			ok=0
+		fi
+		rm -f $tmp.repair
+	fi
+
+	if [ $ok -eq 0 ]; then
+		echo "*** mount output ***"		>>$seqres.full
+		_mount					>>$seqres.full
+		echo "*** end mount output"		>>$seqres.full
+	elif [ "$type" = "xfs" ]; then
+		_mount_or_remount_rw "$extra_mount_options" $device $mountpoint
+	fi
+
+	if [ $ok -eq 0 ]; then
+		status=1
+		if [ "$iam" != "check" ]; then
+			exit 1
+		fi
+		return 1
+	fi
+
+	return 0
 }
 
 _check_xfs_test_fs()
 {
-    TEST_LOG="none"
-    TEST_RT="none"
-    [ "$USE_EXTERNAL" = yes -a ! -z "$TEST_LOGDEV" ] && \
-        TEST_LOG="$TEST_LOGDEV"
-
-    [ "$USE_EXTERNAL" = yes -a ! -z "$TEST_RTDEV" ] && \
-        TEST_RT="$TEST_RTDEV"
-
-    _check_xfs_filesystem $TEST_DEV $TEST_LOG $TEST_RT
-
-    # check for ipath consistency
-    if $XFS_GROWFS_PROG -n $TEST_DIR | grep -q 'inode-paths=1'; then
-	# errors go to stderr
-	xfs_check_ipaths $TEST_DIR >/dev/null
-	xfs_repair_ipaths -n $TEST_DIR >/dev/null
-    fi
+	TEST_LOG="none"
+	TEST_RT="none"
+	[ "$USE_EXTERNAL" = yes -a ! -z "$TEST_LOGDEV" ] && \
+		TEST_LOG="$TEST_LOGDEV"
+
+	[ "$USE_EXTERNAL" = yes -a ! -z "$TEST_RTDEV" ] && \
+		TEST_RT="$TEST_RTDEV"
+
+	_check_xfs_filesystem $TEST_DEV $TEST_LOG $TEST_RT
+
+	# check for ipath consistency
+	if $XFS_GROWFS_PROG -n $TEST_DIR | grep -q 'inode-paths=1'; then
+		# errors go to stderr
+		xfs_check_ipaths $TEST_DIR >/dev/null
+		xfs_repair_ipaths -n $TEST_DIR >/dev/null
+	fi
 }
 
 _require_xfs_test_rmapbt()
@@ -505,7 +496,8 @@ _require_xfs_scratch_rmapbt()
 	_scratch_unmount
 }
 
-_xfs_bmapx_find() {
+_xfs_bmapx_find()
+{
 	case "$1" in
 	"attr")
 		param="a"
@@ -535,7 +527,7 @@ _reset_xfs_sysfs_error_handling()
 {
 	local dev=$1
 
-	if [ ! -b "$dev" -o "$FSTYP" != "xfs" ];then
+	if [ ! -b "$dev" -o "$FSTYP" != "xfs" ]; then
 		_fail "Usage: reset_xfs_sysfs_error_handling <device>"
 	fi
 
-- 
2.9.3

