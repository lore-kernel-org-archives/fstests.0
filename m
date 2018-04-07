Received: from mail-pf0-f194.google.com ([209.85.192.194]:39436 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeDGCgF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Apr 2018 22:36:05 -0400
Received: by mail-pf0-f194.google.com with SMTP id c78so2013745pfj.6
        for <fstests@vger.kernel.org>; Fri, 06 Apr 2018 19:36:05 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 1/2] common/rc: add missing 'local' keywords
Date: Fri,  6 Apr 2018 19:35:29 -0700
Message-Id: <20180407023530.121746-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Many helper functions in xfstests are unnecessarily declaring variables
without the 'local' keyword, which pollutes the global namespace and can
collide with variables in tests.  Fix this for everything in common/rc
that I could find.

In _math(), just eliminate $result by removing the check for nonempty
$BC, which is redundant with _require_math() which the tests do.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/rc | 299 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 154 insertions(+), 145 deletions(-)

diff --git a/common/rc b/common/rc
index 6a91850c..37133ffd 100644
--- a/common/rc
+++ b/common/rc
@@ -53,12 +53,7 @@ _require_math()
 _math()
 {
 	[ $# -le 0 ] && return
-	if [ "$BC" ]; then
-		result=$(LANG=C echo "scale=0; $@" | "$BC" -q 2> /dev/null)
-	else
-		_notrun "this test requires 'bc' tool for doing math operations"
-	fi
-	echo "$result"
+	LANG=C echo "scale=0; $@" | "$BC" -q 2> /dev/null
 }
 
 dd()
@@ -86,22 +81,22 @@ _md5_checksum()
 
 # Write a byte into a range of a file
 _pwrite_byte() {
-	pattern="$1"
-	offset="$2"
-	len="$3"
-	file="$4"
-	xfs_io_args="$5"
+	local pattern="$1"
+	local offset="$2"
+	local len="$3"
+	local file="$4"
+	local xfs_io_args="$5"
 
 	$XFS_IO_PROG $xfs_io_args -f -c "pwrite -S $pattern $offset $len" "$file"
 }
 
 # mmap-write a byte into a range of a file
 _mwrite_byte() {
-	pattern="$1"
-	offset="$2"
-	len="$3"
-	mmap_len="$4"
-	file="$5"
+	local pattern="$1"
+	local offset="$2"
+	local len="$3"
+	local mmap_len="$4"
+	local file="$5"
 
 	$XFS_IO_PROG -f -c "mmap -rw 0 $mmap_len" -c "mwrite -S $pattern $offset $len" "$file"
 }
@@ -249,6 +244,8 @@ _clear_mount_stack()
 _scratch_options()
 {
     local type=$1
+    local rt_opt=""
+    local log_opt=""
     SCRATCH_OPTIONS=""
 
     if [ "$FSTYP" != "xfs" ]; then
@@ -274,7 +271,9 @@ _scratch_options()
 
 _test_options()
 {
-    type=$1
+    local type=$1
+    local rt_opt=""
+    local log_opt=""
     TEST_OPTIONS=""
 
     if [ "$FSTYP" != "xfs" ]; then
@@ -299,15 +298,15 @@ _test_options()
 
 _mount_ops_filter()
 {
-    params="$*"
-    
+    local params="$*"
+    local last_index=$(( $# - 1 ))
+
     #get mount point to handle dmapi mtpt option correctly
-    let last_index=$#-1
     [ $last_index -gt 0 ] && shift $last_index
-    FS_ESCAPED=$1
-    
+    local fs_escaped=$1
+
     echo $params | sed -e 's/dmapi/dmi/' \
-        | $PERL_PROG -ne "s#mtpt=[^,|^\n|^\s]*#mtpt=$FS_ESCAPED\1\2#; print;"
+        | $PERL_PROG -ne "s#mtpt=[^,|^\n|^\s]*#mtpt=$fs_escaped\1\2#; print;"
 
 }
 
@@ -506,9 +505,9 @@ _scratch_do_mkfs()
 
 _scratch_metadump()
 {
-	dumpfile=$1
+	local dumpfile=$1
 	shift
-	options=
+	local options=
 
 	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
 		options="-l $SCRATCH_LOGDEV"
@@ -518,7 +517,7 @@ _scratch_metadump()
 
 _setup_large_ext4_fs()
 {
-	fs_size=$1
+	local fs_size=$1
 	local tmp_dir=/tmp/
 
 	[ "$LARGE_SCRATCH_DEV" != yes ] && return 0
@@ -527,7 +526,7 @@ _setup_large_ext4_fs()
 
 	# Default free space in the FS is 50GB, but you can specify more via
 	# SCRATCH_DEV_EMPTY_SPACE
-	space_to_consume=$(($fs_size - 50*1024*1024*1024 - $SCRATCH_DEV_EMPTY_SPACE))
+	local space_to_consume=$(($fs_size - 50*1024*1024*1024 - $SCRATCH_DEV_EMPTY_SPACE))
 
 	# mount the filesystem and create 16TB - 4KB files until we consume
 	# all the necessary space.
@@ -541,8 +540,8 @@ _setup_large_ext4_fs()
 	fi
 	rm -f $tmp_dir/mnt.err
 
-	file_size=$((16*1024*1024*1024*1024 - 4096))
-	nfiles=0
+	local file_size=$((16*1024*1024*1024*1024 - 4096))
+	local nfiles=0
 	while [ $space_to_consume -gt $file_size ]; do
 
 		xfs_io -F -f \
@@ -593,7 +592,7 @@ _scratch_mkfs_ext4()
 
 	if [ $mkfs_status -eq 0 -a "$LARGE_SCRATCH_DEV" = yes ]; then
 		# manually parse the mkfs output to get the fs size in bytes
-		fs_size=`cat $tmp.mkfsstd | awk ' \
+		local fs_size=`cat $tmp.mkfsstd | awk ' \
 			/^Block size/ { split($2, a, "="); bs = a[2] ; } \
 			/ inodes, / { blks = $3 } \
 			/reserved for the super user/ { resv = $1 } \
@@ -929,8 +928,9 @@ _free_memory_bytes()
 # _scratch_mkfs_sized <size in bytes> [optional blocksize]
 _scratch_mkfs_sized()
 {
-    fssize=$1
-    blocksize=$2
+    local fssize=$1
+    local blocksize=$2
+    local def_blksz
 
     case $FSTYP in
     xfs)
@@ -948,7 +948,7 @@ _scratch_mkfs_sized()
     [ -z "$blocksize" ] && blocksize=4096
 
 
-    re='^[0-9]+$'
+    local re='^[0-9]+$'
     if ! [[ $fssize =~ $re ]] ; then
         _notrun "error: _scratch_mkfs_sized: fs size \"$fssize\" not an integer."
     fi
@@ -956,10 +956,10 @@ _scratch_mkfs_sized()
         _notrun "error: _scratch_mkfs_sized: block size \"$blocksize\" not an integer."
     fi
 
-    blocks=`expr $fssize / $blocksize`
+    local blocks=`expr $fssize / $blocksize`
 
     if [ "$HOSTOS" == "Linux" -a -b "$SCRATCH_DEV" ]; then
-	devsize=`blockdev --getsize64 $SCRATCH_DEV`
+	local devsize=`blockdev --getsize64 $SCRATCH_DEV`
 	[ "$fssize" -gt "$devsize" ] && _notrun "Scratch device too small"
     fi
 
@@ -982,12 +982,12 @@ _scratch_mkfs_sized()
 	# filesystem, which will cause mkfs.gfs2 to fail.  Until that's fixed,
 	# shrink the journal size to at most one eigth of the filesystem and at
 	# least 8 MiB, the minimum size allowed.
-	MIN_JOURNAL_SIZE=8
-	DEFAULT_JOURNAL_SIZE=128
-	if (( fssize/8 / (1024*1024) < DEFAULT_JOURNAL_SIZE )); then
-	    (( JOURNAL_SIZE = fssize/8 / (1024*1024) ))
-	    (( JOURNAL_SIZE >= MIN_JOURNAL_SIZE )) || JOURNAL_SIZE=$MIN_JOURNAL_SIZE
-	    MKFS_OPTIONS="-J $JOURNAL_SIZE $MKFS_OPTIONS"
+	local min_journal_size=8
+	local default_journal_size=128
+	if (( fssize/8 / (1024*1024) < default_journal_size )); then
+	    local journal_size=$(( fssize/8 / (1024*1024) ))
+	    (( journal_size >= min_journal_size )) || journal_size=$min_journal_size
+	    MKFS_OPTIONS="-J $journal_size $MKFS_OPTIONS"
 	fi
 	${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -O -b $blocksize $SCRATCH_DEV $blocks
 	;;
@@ -1015,11 +1015,11 @@ _scratch_mkfs_sized()
 	;;
     f2fs)
 	# mkfs.f2fs requires # of sectors as an input for the size
-	sector_size=`blockdev --getss $SCRATCH_DEV`
+	local sector_size=`blockdev --getss $SCRATCH_DEV`
 	$MKFS_F2FS_PROG $MKFS_OPTIONS $SCRATCH_DEV `expr $fssize / $sector_size`
 	;;
     tmpfs)
-	free_mem=`_free_memory_bytes`
+	local free_mem=`_free_memory_bytes`
 	if [ "$free_mem" -lt "$fssize" ] ; then
 	   _notrun "Not enough memory ($free_mem) for tmpfs with $fssize bytes"
 	fi
@@ -1035,13 +1035,13 @@ _scratch_mkfs_sized()
 # _scratch_mkfs_geom <sunit bytes> <swidth multiplier> [optional blocksize]
 _scratch_mkfs_geom()
 {
-    sunit_bytes=$1
-    swidth_mult=$2
-    blocksize=$3
+    local sunit_bytes=$1
+    local swidth_mult=$2
+    local blocksize=$3
     [ -z "$blocksize" ] && blocksize=4096
 
-    let sunit_blocks=$sunit_bytes/$blocksize
-    let swidth_blocks=$sunit_blocks*$swidth_mult
+    local sunit_blocks=$(( sunit_bytes / blocksize ))
+    local swidth_blocks=$(( sunit_blocks * swidth_mult ))
 
     case $FSTYP in
     xfs)
@@ -1061,9 +1061,9 @@ _scratch_mkfs_geom()
 # _scratch_mkfs_blocksized blocksize
 _scratch_mkfs_blocksized()
 {
-    blocksize=$1
+    local blocksize=$1
 
-    re='^[0-9]+$'
+    local re='^[0-9]+$'
     if ! [[ $blocksize =~ $re ]] ; then
         _notrun "error: _scratch_mkfs_sized: block size \"$blocksize\" not an integer."
     fi
@@ -1107,7 +1107,7 @@ _repair_scratch_fs()
     case $FSTYP in
     xfs)
         _scratch_xfs_repair "$@" 2>&1
-	res=$?
+	local res=$?
 	if [ "$res" -ne 0 ]; then
 		echo "xfs_repair returns $res; replay log?"
 		_try_scratch_mount
@@ -1130,7 +1130,7 @@ _repair_scratch_fs()
     *)
         # Let's hope fsck -y suffices...
         fsck -t $FSTYP -y $SCRATCH_DEV 2>&1
-	res=$?
+	local res=$?
 	case $res in
 	0|1|2)
 		res=0
@@ -1317,7 +1317,7 @@ _is_block_dev()
 	exit 1
     fi
 
-    _dev=$1
+    local _dev=$1
     if [ -L "${_dev}" ]; then
         _dev=`readlink -f "${_dev}"`
     fi
@@ -1336,7 +1336,7 @@ _is_char_dev()
 		exit 1
 	fi
 
-	_dev=$1
+	local _dev=$1
 	if [ -L "${_dev}" ]; then
 		_dev=`readlink -f "${_dev}"`
 	fi
@@ -1359,10 +1359,10 @@ _is_char_dev()
 _do()
 {
     if [ $# -eq 1 ]; then
-	_cmd=$1
+	local _cmd=$1
     elif [ $# -eq 2 ]; then
-	_note=$1
-	_cmd=$2
+	local _note=$1
+	local _cmd=$2
 	echo -n "$_note... "
     else
 	echo "Usage: _do [note] cmd" 1>&2
@@ -1370,7 +1370,8 @@ _do()
     fi
 
     (eval "echo '---' \"$_cmd\"") >>$seqres.full
-    (eval "$_cmd") >$tmp._out 2>&1; ret=$?
+    (eval "$_cmd") >$tmp._out 2>&1
+    local ret=$?
     cat $tmp._out | _fix_malloc >>$seqres.full
     rm -f $tmp._out
     if [ $# -eq 2 ]; then
@@ -1420,6 +1421,8 @@ _fail()
 #
 _supported_fs()
 {
+    local f
+
     for f
     do
 	if [ "$f" = "$FSTYP" -o "$f" = "generic" ]
@@ -1436,6 +1439,8 @@ _supported_fs()
 #
 _supported_os()
 {
+    local h
+
     for h
     do
 	if [ "$h" = "$HOSTOS" ]
@@ -1800,14 +1805,14 @@ _require_no_realtime()
 _require_command()
 {
 	if [ $# -eq 2 ]; then
-		_name="$2"
+		local _name="$2"
 	elif [ $# -eq 1 ]; then
-		_name="$1"
+		local _name="$1"
 	else
 		_fail "usage: _require_command <command> [<name>]"
 	fi
 
-	_command=`echo "$1" | awk '{ print $1 }'`
+	local _command=`echo "$1" | awk '{ print $1 }'`
 	if [ ! -x "$_command" ]; then
 		_notrun "$_name utility required, skipped this test"
 	fi
@@ -1857,7 +1862,7 @@ _require_sane_bdev_flush()
 # this test requires a specific device mapper target
 _require_dm_target()
 {
-	_target=$1
+	local _target=$1
 
 	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
 	# behaviour
@@ -1947,8 +1952,8 @@ _require_aiodio()
 #
 _require_test_program()
 {
-    SRC_TEST=src/$1
-    [ -x $SRC_TEST ] || _notrun "$SRC_TEST not built"
+    local prog=src/$1
+    [ -x $prog ] || _notrun "$prog not built"
 }
 
 # run an aio-dio program
@@ -1992,7 +1997,7 @@ _require_y2038()
 
 _filesystem_timestamp_range()
 {
-	device=${1:-$TEST_DEV}
+	local device=${1:-$TEST_DEV}
 	case $FSTYP in
 	ext4)
 		if [ $(dumpe2fs -h $device 2>/dev/null | grep "Inode size:" | cut -d: -f2) -gt 128 ]; then
@@ -2097,13 +2102,14 @@ _require_xfs_io_command()
 	local param_checked=0
 	local opts=""
 
-	testfile=$TEST_DIR/$$.xfs_io
+	local testfile=$TEST_DIR/$$.xfs_io
+	local testio
 	case $command in
 	"chproj")
 		testio=`$XFS_IO_PROG -F -f -c "chproj 0" $testfile 2>&1`
 		;;
 	"copy_range")
-		testcopy=$TEST_DIR/$$.copy.xfs_io
+		local testcopy=$TEST_DIR/$$.copy.xfs_io
 		$XFS_IO_PROG -F -f -c "pwrite 0 4k" $testfile > /dev/null 2>&1
 		testio=`$XFS_IO_PROG -F -f -c "copy_range $testfile" $testcopy 2>&1`
 		rm -f $testcopy > /dev/null 2>&1
@@ -2211,7 +2217,7 @@ _require_odirect()
 			_notrun "ext4 data journaling doesn't support O_DIRECT"
 		fi
 	fi
-	testfile=$TEST_DIR/$$.direct
+	local testfile=$TEST_DIR/$$.direct
 	$XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
 	if [ $? -ne 0 ]; then
 		_notrun "O_DIRECT is not supported"
@@ -2245,13 +2251,13 @@ _require_scratch_swapfile()
 #
 _require_fs_space()
 {
-	MNT=$1
-	BLOCKS=$2	# in units of 1024
-	let GB=$BLOCKS/1024/1024
+	local mnt=$1
+	local blocks=$2	# in units of 1024
+	local gb=$(( blocks / 1024 / 1024 ))
 
-	FREE_BLOCKS=`df -kP $MNT | grep -v Filesystem | awk '{print $4}'`
-	[ $FREE_BLOCKS -lt $BLOCKS ] && \
-		_notrun "This test requires at least ${GB}GB free on $MNT to run"
+	local free_blocks=`df -kP $mnt | grep -v Filesystem | awk '{print $4}'`
+	[ $free_blocks -lt $blocks ] && \
+		_notrun "This test requires at least ${gb}GB free on $mnt to run"
 }
 
 #
@@ -2418,8 +2424,8 @@ _remount()
 	echo "Usage: _remount device ro/rw" 1>&2
 	exit 1
     fi
-    device=$1
-    mode=$2
+    local device=$1
+    local mode=$2
 
     if ! mount -o remount,$mode $device
     then
@@ -2445,8 +2451,8 @@ _umount_or_remount_ro()
 	exit 1
     fi
 
-    device=$1
-    mountpoint=`_is_dev_mounted $device`
+    local device=$1
+    local mountpoint=`_is_dev_mounted $device`
 
     if [ $USE_REMOUNT -eq 0 ]; then
         $UMOUNT_PROG $device
@@ -2462,9 +2468,9 @@ _mount_or_remount_rw()
 		echo "Usage: _mount_or_remount_rw <opts> <dev> <mnt>" 1>&2
 		exit 1
 	fi
-	mount_opts=$1
-	device=$2
-	mountpoint=$3
+	local mount_opts=$1
+	local device=$2
+	local mountpoint=$3
 
 	if [ $USE_REMOUNT -eq 0 ]; then
 		if [ "$FSTYP" != "overlay" ]; then
@@ -2492,16 +2498,16 @@ _mount_or_remount_rw()
 #
 _check_generic_filesystem()
 {
-    device=$1
+    local device=$1
 
     # If type is set, we're mounted
-    type=`_fs_type $device`
-    ok=1
+    local type=`_fs_type $device`
+    local ok=1
 
     if [ "$type" = "$FSTYP" ]
     then
         # mounted ...
-        mountpoint=`_umount_or_remount_ro $device`
+        local mountpoint=`_umount_or_remount_ro $device`
     fi
 
     fsck -t $FSTYP $FSCK_OPTIONS $device >$tmp.fsck 2>&1
@@ -2566,16 +2572,15 @@ _check_udf_filesystem()
 	return
     fi
 
-    device=$1
-    if [ $# -eq 2 ];
-    then
-        LAST_BLOCK=`expr \( $2 - 1 \)`
-        OPT_ARG="-lastvalidblock $LAST_BLOCK"
+    local device=$1
+    local opt_arg=""
+    if [ $# -eq 2 ]; then
+	opt_arg="-lastvalidblock $(( $2 - 1 ))"
     fi
 
     rm -f $seqres.checkfs
     sleep 1 # Due to a problem with time stamps in udf_test
-    $here/src/udf_test $OPT_ARG $device | tee $seqres.checkfs | egrep "Error|Warning" | \
+    $here/src/udf_test $opt_arg $device | tee $seqres.checkfs | egrep "Error|Warning" | \
 	_udf_test_known_error_filter | \
 	egrep -iv "Error count:.*[0-9]+.*total occurrences:.*[0-9]+|Warning count:.*[0-9]+.*total occurrences:.*[0-9]+" && \
         echo "Warning UDF Verifier reported errors see $seqres.checkfs." && return 1
@@ -2628,20 +2633,20 @@ _check_test_fs()
 
 _check_scratch_fs()
 {
-    device=$SCRATCH_DEV
+    local device=$SCRATCH_DEV
     [ $# -eq 1 ] && device=$1
 
     case $FSTYP in
     xfs)
-	SCRATCH_LOG="none"
-	SCRATCH_RT="none"
+	local scratch_log="none"
+	local scratch_rt="none"
 	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
-	    SCRATCH_LOG="$SCRATCH_LOGDEV"
+	    scratch_log="$SCRATCH_LOGDEV"
 
 	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ] && \
-	    SCRATCH_RT="$SCRATCH_RTDEV"
+	    scratch_rt="$SCRATCH_RTDEV"
 
-	_check_xfs_filesystem $device $SCRATCH_LOG $SCRATCH_RT
+	_check_xfs_filesystem $device $scratch_log $scratch_rt
 	;;
     udf)
 	_check_udf_filesystem $device $udf_fsize
@@ -2704,10 +2709,10 @@ _full_fstyp_details()
 
 _full_platform_details()
 {
-     os=`uname -s`
-     host=`hostname -s`
-     kernel=`uname -r`
-     platform=`uname -m`
+     local os=`uname -s`
+     local host=`hostname -s`
+     local kernel=`uname -r`
+     local platform=`uname -m`
      echo "$os/$platform $host $kernel"
 }
 
@@ -2723,8 +2728,8 @@ _get_os_name()
 
 _link_out_file_named()
 {
-	export FEATURES=$2
-	SUFFIX=$(perl -e '
+	local features=$2
+	local suffix=$(FEATURES="$features" perl -e '
 		my %feathash;
 		my $feature, $result, $suffix, $opts;
 
@@ -2751,22 +2756,23 @@ _link_out_file_named()
 		print $result
 		' <$seqfull.cfg)
 	rm -f $1
-	SRC=$(basename $1)
-	ln -fs $SRC.$SUFFIX $1
+	ln -fs $(basename $1).$suffix $1
 }
 
 _link_out_file()
 {
+	local features
+
 	if [ $# -eq 0 ]; then
-		FEATURES="$(_get_os_name)"
+		features="$(_get_os_name)"
 		if [ -n "$MOUNT_OPTIONS" ]; then
-			FEATURES=$FEATURES,${MOUNT_OPTIONS##"-o "}
+			features=$features,${MOUNT_OPTIONS##"-o "}
 		fi
 	else
-		FEATURES=$1
+		features=$1
 	fi
 
-	_link_out_file_named $seqfull.out "$FEATURES"
+	_link_out_file_named $seqfull.out "$features"
 }
 
 _die()
@@ -2784,10 +2790,10 @@ _ddt()
 #takes files, randomdata
 _nfiles()
 {
-        f=0
+        local f=0
         while [ $f -lt $1 ]
         do
-                file=f$f
+                local file=f$f
                 echo > $file
                 if [ $size -gt 0 ]; then
                     if [ "$2" == "false" ]; then
@@ -2805,18 +2811,18 @@ _nfiles()
 # takes dirname, depth, randomdata
 _descend()
 {
-        dirname=$1; depth=$2; randomdata=$3
+        local dirname=$1 depth=$2 randomdata=$3
         mkdir $dirname  || die "mkdir $dirname failed"
         cd $dirname
 
         _nfiles $files $randomdata          # files for this dir and data type
 
         [ $depth -eq 0 ] && return
-	let deep=$depth-1 # go 1 down
+        local deep=$(( depth - 1 )) # go 1 down
 
         [ $verbose = true ] && echo "descending, depth from leaves = $deep"
 
-        d=0
+        local d=0
         while [ $d -lt $dirs ]
         do
                 _descend d$d $deep &
@@ -2831,14 +2837,15 @@ _descend()
 #
 _populate_fs()
 {
-    here=`pwd`
-    dirs=5          # ndirs in each subdir till leaves
-    size=0          # sizeof files in K
-    files=100       # num files in _each_ subdir
-    depth=2         # depth of tree from root to leaves
-    verbose=false
-    root=root       # path of initial root of directory tree
-    randomdata=false # -x data type urandom, zero or compressible
+    local here=`pwd`
+    local dirs=5          # ndirs in each subdir till leaves
+    local size=0          # sizeof files in K
+    local files=100       # num files in _each_ subdir
+    local depth=2         # depth of tree from root to leaves
+    local verbose=false
+    local root=root       # path of initial root of directory tree
+    local randomdata=false # -x data type urandom, zero or compressible
+    local c
 
     OPTIND=1
     while getopts "d:f:n:r:s:v:x:c" c
@@ -2867,8 +2874,8 @@ _populate_fs()
 #
 _test_inode_flag()
 {
-	flag=$1
-	file=$2
+	local flag=$1
+	local file=$2
 
 	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
 		return 0
@@ -2880,8 +2887,8 @@ _test_inode_flag()
 #
 _test_inode_extsz()
 {
-	file=$1
-	blocks=""
+	local file=$1
+	local blocks=""
 
 	blocks=`$XFS_IO_PROG -r -c 'stat' "$file" | \
 		awk '/^xattr.extsize =/ { print $3 }'`
@@ -2971,7 +2978,7 @@ _require_deletable_scratch_dev_pool()
 # Check that fio is present, and it is able to execute given jobfile
 _require_fio()
 {
-	job=$1
+	local job=$1
 
 	_require_command "$FIO_PROG" fio
 	if [ -z "$1" ]; then
@@ -2986,7 +2993,7 @@ _require_fio()
 _require_freeze()
 {
 	xfs_freeze -f "$TEST_DIR" >/dev/null 2>&1
-	result=$? 
+	local result=$?
 	xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
 	[ $result -eq 0 ] || _notrun "$FSTYP does not support freezing"
 }
@@ -3061,9 +3068,9 @@ _require_norecovery()
 _require_metadata_journaling()
 {
 	if [ -z $1 ]; then
-		DEV=$TEST_DEV
+		local dev=$TEST_DEV
 	else
-		DEV=$1
+		local dev=$1
 	fi
 
 	case "$FSTYP" in
@@ -3073,8 +3080,8 @@ _require_metadata_journaling()
 	ext4)
 		# ext4 could be mkfs'd without a journal...
 		_require_dumpe2fs
-		$DUMPE2FS_PROG -h $DEV 2>&1 | grep -q has_journal || \
-			_notrun "$FSTYP on $DEV not configured with metadata journaling"
+		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q has_journal || \
+			_notrun "$FSTYP on $dev not configured with metadata journaling"
 		# ext4 might not load a journal
 		_exclude_scratch_mount_option "noload"
 		;;
@@ -3140,10 +3147,12 @@ _devmgt_add()
 	echo ${tdl} >  /sys/class/scsi_host/host${h}/scan || _fail "Add disk failed"
 
 	# ensure the device comes online
-	dev_back_oneline=0
+	local dev_back_oneline=0
+	local i
 	for i in `seq 1 10`; do
 		if [ -d /sys/class/scsi_device/${1}/device/block ]; then
-			dev=`ls /sys/class/scsi_device/${1}/device/block`
+			local dev=`ls /sys/class/scsi_device/${1}/device/block`
+			local j
 			for j in `seq 1 10`;
 			do
 				stat /dev/$dev > /dev/null 2>&1
@@ -3257,20 +3266,20 @@ _require_userns()
 
 _create_loop_device()
 {
-	file=$1
+	local file=$1 dev
 	dev=`losetup -f --show $file` || _fail "Cannot assign $file to a loop device"
 	echo $dev
 }
 
 _destroy_loop_device()
 {
-	dev=$1
+	local dev=$1
 	losetup -d $dev || _fail "Cannot destroy loop device $dev"
 }
 
 _scale_fsstress_args()
 {
-    args=""
+    local args=""
     while [ $# -gt 0 ]; do
         case "$1" in
             -n) args="$args $1 $(($2 * $TIME_FACTOR))"; shift ;;
@@ -3288,7 +3297,7 @@ _scale_fsstress_args()
 #
 _min_dio_alignment()
 {
-    dev=$1
+    local dev=$1
 
     if [ -b "$dev" ]; then
         blockdev --getss $dev
@@ -3305,8 +3314,8 @@ run_check()
 
 _require_test_symlinks()
 {
-	target=`mktemp -p $TEST_DIR`
-	link=`mktemp -p $TEST_DIR -u`
+	local target=`mktemp -p $TEST_DIR`
+	local link=`mktemp -p $TEST_DIR -u`
 	ln -s `basename $target` $link
 	if [ "$?" -ne 0 ]; then
 		rm -f $target
@@ -3336,7 +3345,7 @@ _require_ofd_locks()
 
 _require_test_lsattr()
 {
-	testio=$(lsattr -d $TEST_DIR 2>&1)
+	local testio=$(lsattr -d $TEST_DIR 2>&1)
 	echo $testio | grep -q "Operation not supported" && \
 		_notrun "lsattr not supported by test filesystem type: $FSTYP"
 	echo $testio | grep -q "Inappropriate ioctl for device" && \
@@ -3353,9 +3362,9 @@ _require_chattr()
 
 	touch $TEST_DIR/syscalltest
 	chattr "+$attribute" $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
-	status=$?
+	local ret=$?
 	chattr "-$attribute" $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
-	if [ "$status" -ne 0 ]; then
+	if [ "$ret" -ne 0 ]; then
 		_notrun "file system doesn't support chattr +$attribute"
 	fi
 	cat $TEST_DIR/syscalltest.out >> $seqres.full
@@ -3462,7 +3471,7 @@ _check_dmesg()
 	# default filter is a simple cat command, caller could provide a
 	# customized filter and pass the name through the first argument, to
 	# filter out intentional WARNINGs or Oopses
-	filter=${1:-cat}
+	local filter=${1:-cat}
 
 	_dmesg_since_test_start | $filter >$seqres.dmesg
 	egrep -q -e "kernel BUG at" \
@@ -3680,7 +3689,7 @@ get_page_size()
 run_fsx()
 {
 	echo fsx $@
-	args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
+	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
 	set -- $here/ltp/fsx $args $FSX_AVOID $TEST_DIR/junk
 	echo "$@" >>$seqres.full
 	rm -f $TEST_DIR/junk
-- 
2.17.0.484.g0c8726318c-goog

