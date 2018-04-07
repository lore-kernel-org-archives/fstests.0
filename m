Received: from mail-pl0-f68.google.com ([209.85.160.68]:39385 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeDGCgI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Apr 2018 22:36:08 -0400
Received: by mail-pl0-f68.google.com with SMTP id s24-v6so1725911plq.6
        for <fstests@vger.kernel.org>; Fri, 06 Apr 2018 19:36:08 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 2/2] common/rc: fix up variable naming
Date: Fri,  6 Apr 2018 19:35:30 -0700
Message-Id: <20180407023530.121746-2-ebiggers@google.com>
In-Reply-To: <20180407023530.121746-1-ebiggers@google.com>
References: <20180407023530.121746-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Remove the leading underscore from local variable names, and add a
leading underscore to $err_msg to reflect its status as a global
variable shared by 'check' and 'common/report'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 check         |  14 ++---
 common/rc     | 140 +++++++++++++++++++++++++-------------------------
 common/report |   6 +--
 3 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/check b/check
index 546683c5..933e6d86 100755
--- a/check
+++ b/check
@@ -38,7 +38,7 @@ randomize=false
 export here=`pwd`
 xfile=""
 brief_test_summary=false
-err_msg=""
+_err_msg=""
 do_report=false
 DUMP_OUTPUT=false
 
@@ -634,7 +634,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	for seq in $list
 	do
 	    err=false
-	    err_msg=""
+	    _err_msg=""
 	    if [ ! -f $seq ]; then
 	        # Try to get full name in case the user supplied only seq id
 	        # and the test has a name. A bit of hassle to find really
@@ -732,8 +732,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 		if [ -f core ]
 		then
-		    err_msg="[dumped core]"
-		    echo -n " $err_msg"
+		    _err_msg="[dumped core]"
+		    echo -n " $_err_msg"
 		    mv core $RESULT_BASE/$seqnum.core
 		    err=true
 		fi
@@ -749,8 +749,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		else
 		    if [ $sts -ne 0 ]
 		    then
-			err_msg="[failed, exit status $sts]"
-			echo -n " $err_msg"
+			_err_msg="[failed, exit status $sts]"
+			echo -n " $_err_msg"
 			err=true
 		    fi
 		    if [ ! -f $seq.out ]
@@ -785,7 +785,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 						" to see the entire diff)"
 				fi; } | \
 				sed -e 's/^\(.\)/    \1/'
-			    err_msg="output mismatch (see $diff $seq.out $seqres.out.bad)"
+			    _err_msg="output mismatch (see $diff $seq.out $seqres.out.bad)"
 			    err=true
 			fi
 		    fi
diff --git a/common/rc b/common/rc
index 37133ffd..f83d506d 100644
--- a/common/rc
+++ b/common/rc
@@ -122,20 +122,20 @@ fi
 
 _dump_err()
 {
-    err_msg="$*"
-    echo "$err_msg"
+    _err_msg="$*"
+    echo "$_err_msg"
 }
 
 _dump_err2()
 {
-    err_msg="$*"
-    >2& echo "$err_msg"
+    _err_msg="$*"
+    >2& echo "$_err_msg"
 }
 
 _log_err()
 {
-    err_msg="$*"
-    echo "$err_msg" | tee -a $seqres.full
+    _err_msg="$*"
+    echo "$_err_msg" | tee -a $seqres.full
     echo "(see $seqres.full for details)"
 }
 
@@ -1317,13 +1317,13 @@ _is_block_dev()
 	exit 1
     fi
 
-    local _dev=$1
-    if [ -L "${_dev}" ]; then
-        _dev=`readlink -f "${_dev}"`
+    local dev=$1
+    if [ -L "$dev" ]; then
+        dev=`readlink -f "$dev"`
     fi
 
-    if [ -b "${_dev}" ]; then
-        src/lstat64 "${_dev}" | $AWK_PROG '/Device type:/ { print $9 }'
+    if [ -b "$dev" ]; then
+        src/lstat64 "$dev" | $AWK_PROG '/Device type:/ { print $9 }'
     fi
 }
 
@@ -1336,13 +1336,13 @@ _is_char_dev()
 		exit 1
 	fi
 
-	local _dev=$1
-	if [ -L "${_dev}" ]; then
-		_dev=`readlink -f "${_dev}"`
+	local dev=$1
+	if [ -L "$dev" ]; then
+		dev=`readlink -f "$dev"`
 	fi
 
-	if [ -c "${_dev}" ]; then
-		src/lstat64 "${_dev}" | $AWK_PROG '/Device type:/ { print $9 }'
+	if [ -c "$dev" ]; then
+		src/lstat64 "$dev" | $AWK_PROG '/Device type:/ { print $9 }'
 	fi
 }
 
@@ -1359,18 +1359,18 @@ _is_char_dev()
 _do()
 {
     if [ $# -eq 1 ]; then
-	local _cmd=$1
+	local cmd=$1
     elif [ $# -eq 2 ]; then
-	local _note=$1
-	local _cmd=$2
-	echo -n "$_note... "
+	local note=$1
+	local cmd=$2
+	echo -n "$note... "
     else
 	echo "Usage: _do [note] cmd" 1>&2
 	status=1; exit
     fi
 
-    (eval "echo '---' \"$_cmd\"") >>$seqres.full
-    (eval "$_cmd") >$tmp._out 2>&1
+    (eval "echo '---' \"$cmd\"") >>$seqres.full
+    (eval "$cmd") >$tmp._out 2>&1
     local ret=$?
     cat $tmp._out | _fix_malloc >>$seqres.full
     rm -f $tmp._out
@@ -1386,7 +1386,7 @@ _do()
 	    -o \( $# -eq 2 -a "$_do_die_on_error" = "message_only" \) ]
     then
 	[ $# -ne 2 ] && echo
-	eval "echo \"$_cmd\" failed \(returned $ret\): see $seqres.full"
+	eval "echo \"$cmd\" failed \(returned $ret\): see $seqres.full"
 	status=1; exit
     fi
 
@@ -1805,16 +1805,16 @@ _require_no_realtime()
 _require_command()
 {
 	if [ $# -eq 2 ]; then
-		local _name="$2"
+		local name="$2"
 	elif [ $# -eq 1 ]; then
-		local _name="$1"
+		local name="$1"
 	else
 		_fail "usage: _require_command <command> [<name>]"
 	fi
 
-	local _command=`echo "$1" | awk '{ print $1 }'`
-	if [ ! -x "$_command" ]; then
-		_notrun "$_name utility required, skipped this test"
+	local command=`echo "$1" | awk '{ print $1 }'`
+	if [ ! -x "$command" ]; then
+		_notrun "$name utility required, skipped this test"
 	fi
 }
 
@@ -1862,7 +1862,7 @@ _require_sane_bdev_flush()
 # this test requires a specific device mapper target
 _require_dm_target()
 {
-	local _target=$1
+	local target=$1
 
 	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
 	# behaviour
@@ -1870,11 +1870,11 @@ _require_dm_target()
 	_require_sane_bdev_flush $SCRATCH_DEV
 	_require_command "$DMSETUP_PROG" dmsetup
 
-	modprobe dm-$_target >/dev/null 2>&1
+	modprobe dm-$target >/dev/null 2>&1
 
-	$DMSETUP_PROG targets 2>&1 | grep -q ^$_target
+	$DMSETUP_PROG targets 2>&1 | grep -q ^$target
 	if [ $? -ne 0 ]; then
-		_notrun "This test requires dm $_target support"
+		_notrun "This test requires dm $target support"
 	fi
 }
 
@@ -2948,15 +2948,15 @@ _require_scratch_dev_pool()
 # must be called after _require_scratch_dev_pool
 _require_scratch_dev_pool_equal_size()
 {
-	local _size
-	local _newsize
-	local _dev
+	local size
+	local newsize
+	local dev
 
 	# SCRATCH_DEV has been set to the first device in SCRATCH_DEV_POOL
-	_size=`_get_device_size $SCRATCH_DEV`
-	for _dev in $SCRATCH_DEV_POOL; do
-		_newsize=`_get_device_size $_dev`
-		if [ $_size -ne $_newsize ]; then
+	size=`_get_device_size $SCRATCH_DEV`
+	for dev in $SCRATCH_DEV_POOL; do
+		newsize=`_get_device_size $dev`
+		if [ $size -ne $newsize ]; then
 			_notrun "This test requires devices in SCRATCH_DEV_POOL have the same size"
 		fi
 	done
@@ -3498,59 +3498,59 @@ _check_dmesg()
 # capture the kmemleak report
 _capture_kmemleak()
 {
-	local _kern_knob="${DEBUGFS_MNT}/kmemleak"
-	local _leak_file="$1"
+	local kern_knob="${DEBUGFS_MNT}/kmemleak"
+	local leak_file="$1"
 
 	# Tell the kernel to scan for memory leaks.  Apparently the write
 	# returns before the scan is complete, so do it twice in the hopes
 	# that twice is enough to capture all the leaks.
-	echo "scan" > "${_kern_knob}"
-	cat "${_kern_knob}" > /dev/null
-	echo "scan" > "${_kern_knob}"
-	cat "${_kern_knob}" > "${_leak_file}.tmp"
-	if [ -s "${_leak_file}.tmp" ]; then
-		cat > "${_leak_file}" << ENDL
+	echo "scan" > "$kern_knob"
+	cat "$kern_knob" > /dev/null
+	echo "scan" > "$kern_knob"
+	cat "$kern_knob" > "$leak_file.tmp"
+	if [ -s "$leak_file.tmp" ]; then
+		cat > "$leak_file" << ENDL
 EXPERIMENTAL kmemleak reported some memory leaks!  Due to the way kmemleak
 works, the leak might be from an earlier test, or something totally unrelated.
 ENDL
-		cat "${_leak_file}.tmp" >> "${_leak_file}"
-		rm -rf "${_leak_file}.tmp"
+		cat "$leak_file.tmp" >> "$leak_file"
+		rm -rf "$leak_file.tmp"
 	fi
-	echo "clear" > "${_kern_knob}"
+	echo "clear" > "$kern_knob"
 }
 
 # set up kmemleak
 _init_kmemleak()
 {
-	local _kern_knob="${DEBUGFS_MNT}/kmemleak"
+	local kern_knob="${DEBUGFS_MNT}/kmemleak"
 
-	if [ ! -w "${_kern_knob}" ]; then
+	if [ ! -w "$kern_knob" ]; then
 		return 0
 	fi
 
 	# Disable the automatic scan so that we can control it completely,
 	# then dump all the leaks recorded so far.
-	echo "scan=off" > "${_kern_knob}"
+	echo "scan=off" > "$kern_knob"
 	_capture_kmemleak /dev/null
 }
 
 # check kmemleak log
 _check_kmemleak()
 {
-	local _kern_knob="${DEBUGFS_MNT}/kmemleak"
-	local _leak_file="${seqres}.kmemleak"
+	local kern_knob="${DEBUGFS_MNT}/kmemleak"
+	local leak_file="${seqres}.kmemleak"
 
-	if [ ! -w "${_kern_knob}" ]; then
+	if [ ! -w "$kern_knob" ]; then
 		return 0
 	fi
 
 	# Capture and report any leaks
-	_capture_kmemleak "${_leak_file}"
-	if [ -s "${_leak_file}" ]; then
-		_dump_err "_check_kmemleak: something found in kmemleak (see ${_leak_file})"
+	_capture_kmemleak "$leak_file"
+	if [ -s "$leak_file" ]; then
+		_dump_err "_check_kmemleak: something found in kmemleak (see $leak_file)"
 		return 1
 	else
-		rm -f "${_leak_file}"
+		rm -f "$leak_file"
 		return 0
 	fi
 }
@@ -3631,11 +3631,11 @@ init_rc()
 # get real device path name by following link
 _real_dev()
 {
-	local _dev=$1
-	if [ -b "$_dev" ] && [ -L "$_dev" ]; then
-		_dev=`readlink -f "$_dev"`
+	local dev=$1
+	if [ -b "$dev" ] && [ -L "$dev" ]; then
+		dev=`readlink -f "$dev"`
 	fi
-	echo $_dev
+	echo $dev
 }
 
 # basename of a device
@@ -3646,12 +3646,12 @@ _short_dev()
 
 _sysfs_dev()
 {
-	local _dev=`_real_dev $1`
-	local _maj=$(stat -c%t $_dev | tr [:lower:] [:upper:])
-	local _min=$(stat -c%T $_dev | tr [:lower:] [:upper:])
-	_maj=$(echo "ibase=16; $_maj" | bc)
-	_min=$(echo "ibase=16; $_min" | bc)
-	echo /sys/dev/block/$_maj:$_min
+	local dev=`_real_dev $1`
+	local maj=$(stat -c%t $dev | tr [:lower:] [:upper:])
+	local min=$(stat -c%T $dev | tr [:lower:] [:upper:])
+	maj=$(echo "ibase=16; $maj" | bc)
+	min=$(echo "ibase=16; $min" | bc)
+	echo /sys/dev/block/$maj:$min
 }
 
 # Get the minimum block size of a file.  Usually this is the
diff --git a/common/report b/common/report
index 058c0bba..ffa23719 100644
--- a/common/report
+++ b/common/report
@@ -105,10 +105,10 @@ _xunit_make_testcase_report()
 		echo -e "\t\t<skipped/>" >> $report
 		;;
 	"fail")
-		if [ -z "$err_msg" ]; then
-			err_msg="Test $sequm failed, reason unknown"
+		if [ -z "$_err_msg" ]; then
+			_err_msg="Test $sequm failed, reason unknown"
 		fi
-		echo -e "\t\t<failure message=\"$err_msg\" type=\"TestFail\" />" >> $report
+		echo -e "\t\t<failure message=\"$_err_msg\" type=\"TestFail\" />" >> $report
 		if [ -s $seqres.full ]; then
 			echo -e "\t\t<system-out>" >> $report
 			printf	'<![CDATA[\n' >>$report
-- 
2.17.0.484.g0c8726318c-goog

