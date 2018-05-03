Received: from imap.thunk.org ([74.207.234.97]:56228 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751993AbeECDnm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 2 May 2018 23:43:42 -0400
Date: Wed, 2 May 2018 23:43:40 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: [PATCH] common: add support for the "local" file system type
Message-ID: <20180503034340.GA20908@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

About a year and half ago, I sent the patch attached below to add
support for a "local" file system type where the file system could not
be mounted or dismounted, but where writes to TEST_DIR and SCRATCH_MNT
would be testing the file system in question.  At the time, I couldn't
describe the use case in any greater detail than what I had in the
commit description, and Dave Chinner at the time rejected the patch
since he didn't like xfstests being used to test a proprietary file
system for which I was not able to explain the details of what we were
trying to do.

Not a big deal, I just kept the patch in my private fork[1] of
xfstests on github.

[1] https://github.com/tytso/xfstests

However, happily, we can now talk a lot more about what the "local"
file system type in xfstests was used to test.  Earlier today, Google
announced gVisor[2], and published it as open source on github[3].
gVisor works much like User Mode Linux, and I suspect much like the
Windows Subsystem for Linux in that it uses the x86_64's hardware
virtualization extensions (so it has the security fencing much like a
VM) but instead of emulating hardware, instead the emulation layer is
done at the system call level (so it's more efficient than a VM, since
there is no guest kernel).

[2] https://cloudplatform.googleblog.com/2018/05/Open-sourcing-gVisor-a-sandboxed-container-runtime.html
[3] https://github.com/google/gvisor

File systems can be implemented using Gophers[4] in a separate
process, where the communication between the gVisor sandbox and the
Gopher is via the 9P2000.L protocol.  This means that if you want to
try to exploit a buffer overflow in the userspace file system, first
you have to get past the system call validation checks done by the
gVisor Sentry process (which is written in Go which makes this rather
more difficult, especially since the Sentry process itself is
protected using seccomp[5]).  Then the buffer overflow attack has to
make it past the 9P protocol encoding/decoding, and then survive the
9P protocol validation checks in the Gopher.  The Gopher process
provides an emulated file system service using the Cloud Provider's
internal cluster storage services, much like in GCE, the Persistent
Disk service provides an emulated block device service.

[4] https://news.ycombinator.com/item?id=16979126
[5] https://news.ycombinator.com/item?id=16976557

This whole system was designed with security first and foremost.  Of
course, we also want it to pass the file system checks, which is why
were using xfstests.

The way we actually tested the gVisor file system was via a Docker
container (the Dockerfile[6] is in the xfstests-bld git repo) which
would then get consumed by gVisor's Docker/Kubernetes integration
layer.

[6] https://github.com/tytso/xfstests-bld/blob/master/Dockerfile

Anyway, back in September, 2016, Dave Chinner was peeved that I
couldn't give this full description, and I'm glad to say, now we can
finally rectify that gap.  :-)

Could this commit therefore please be considered for inclusion in
xfstests upstream?

Many thanks!

						- Ted


>From 8b40b28866dca119d0c807c31ae48f153ec2dc53 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 17 Sep 2016 19:08:18 -0400
Subject: [PATCH] common: add support for the "local" file system type

It is sometimes useful to be able to test the local file system
provided in a restricted execution environment (such as that which is
provided by Docker, for example) where it is not possible to mount and
unmount the file system under test.

To support this test case, add support for a new file system type
called "local".  The TEST_DEV and SCRATCH_DEV should be have a
non-block device format (e.g., local:/test or local:/scratch), and the
TEST_DIR and SCRATCH_MNT directories should be pre-existing
directories provided by the execution environment.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 9ffab7fd..d5cb0fe4 100644
--- a/common/rc
+++ b/common/rc
@@ -351,6 +351,18 @@ _supports_filetype()
 	esac
 }
 
+_local_validate_mount_opt()
+{
+    case "$*" in
+	ro|ro,*|*,ro) _notrun "ro mount option not supported" ;;
+	*nosuid*) _notrun "nosuid mount option not supported" ;;
+	*noatime*) _notrun "noatime mount option not supported" ;;
+	*relatime*) _notrun "relatime mount option not supported" ;;
+	*diratime*) _notrun "diratime mount option not supported" ;;
+	*strictatime*) _notrun "strictatime mount option not supported" ;;
+    esac
+}
+
 # mount scratch device with given options but don't check mount status
 _try_scratch_mount()
 {
@@ -376,6 +388,9 @@ _scratch_unmount()
 	btrfs)
 		$UMOUNT_PROG $SCRATCH_MNT
 		;;
+	local)
+                rm -rf $SCRATCH_MNT/*
+                ;;
 	*)
 		$UMOUNT_PROG $SCRATCH_DEV
 		;;
@@ -386,6 +401,10 @@ _scratch_remount()
 {
     local opts="$1"
 
+    if [ "$FSTYP" = "local" ]; then
+	_local_validate_mount_opt "$*"
+	return 0;
+    fi
     if test -n "$opts"; then
 	mount -o "remount,$opts" $SCRATCH_MNT
     fi
@@ -395,7 +414,7 @@ _scratch_cycle_mount()
 {
     local opts="$1"
 
-    if [ "$FSTYP" = tmpfs ]; then
+    if [ "$FSTYP" = "tmpfs" -o "$FSTYP" = "local" ] ; then
 	_scratch_remount "$opts"
 	return
     fi
@@ -429,6 +448,10 @@ _test_mount()
         _overlay_test_mount $*
         return $?
     fi
+    if [ "$FSTYP" == "local" ]; then
+        mkdir -p $TEST_DIR
+	return $?
+    fi
     _test_options mount
     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
 }
@@ -437,7 +460,7 @@ _test_unmount()
 {
 	if [ "$FSTYP" == "overlay" ]; then
 		_overlay_test_unmount
-	else
+	elif [ "$FSTYP" != "local" ]; then
 		$UMOUNT_PROG $TEST_DEV
 	fi
 }
@@ -723,7 +746,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p)
+	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|local)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1465,6 +1488,10 @@ _check_mounted_on()
 	local mnt=$4
 	local type=$5
 
+	if [ "$FSTYP" == "local" ]; then
+		return 0
+	fi
+
 	# find $dev as the source, and print result in "$dev $mnt" format
 	local mount_rec=`findmnt -rncv -S $dev -o SOURCE,TARGET`
 	[ -n "$mount_rec" ] || return 1 # 1 = not mounted
@@ -1562,6 +1589,13 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
+	local)
+		if [ -z "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
+		then
+		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
+		fi
+		return 0
+		;;
 	*)
 		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev "$SCRATCH_DEV"`" = "" ]
 		 then
@@ -1683,6 +1717,13 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
+	local)
+		if [ -z "$TEST_DEV" -o ! -d "$TEST_DIR" ];
+		then
+		    _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
+		fi
+		return 0
+		;;
 	*)
 		 if [ -z "$TEST_DEV" ] || [ "`_is_block_dev "$TEST_DEV"`" = "" ]
 		 then
@@ -2438,6 +2479,10 @@ _remount()
     local device=$1
     local mode=$2
 
+    if [ "$FSTYP" == "local" ] ; then
+       return 0
+    fi
+
     if ! mount -o remount,$mode $device
     then
         echo "_remount: failed to remount filesystem on $device as $mode"
@@ -2483,6 +2528,10 @@ _mount_or_remount_rw()
 	local device=$2
 	local mountpoint=$3
 
+	if [ "$FSTYP" == "local" ] ; then
+	    return 0
+	fi
+
 	if [ $USE_REMOUNT -eq 0 ]; then
 		if [ "$FSTYP" != "overlay" ]; then
 			_mount -t $FSTYP $mount_opts $device $mountpoint
@@ -2636,6 +2685,9 @@ _check_test_fs()
     ubifs)
 	# there is no fsck program for ubifs yet
 	;;
+    local)
+	# no way to check consistency for local
+	;;
     *)
 	_check_generic_filesystem $TEST_DEV
 	;;
@@ -2691,6 +2743,9 @@ _check_scratch_fs()
     ubifs)
 	# there is no fsck program for ubifs yet
 	;;
+    local)
+	# no way to check consistency for local
+	;;
     *)
 	_check_generic_filesystem $device
 	;;
@@ -3003,6 +3058,9 @@ _require_fio()
 # Does freeze work on this fs?
 _require_freeze()
 {
+	if [ "$FSTYP" == "local" ]; then
+		_notrun "local does not support freeze"
+	fi
 	xfs_freeze -f "$TEST_DIR" >/dev/null 2>&1
 	local result=$?
 	xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
@@ -3024,6 +3082,9 @@ _require_scratch_shutdown()
 {
 	[ -x src/godown ] || _notrun "src/godown executable not found"
 
+	if [ "$FSTYP" == "local" ]; then
+		_notrun "local does not support shutdown"
+	fi
 	_scratch_mkfs > /dev/null 2>&1 || _notrun "_scratch_mkfs failed on $SCRATCH_DEV"
 	_scratch_mount
 
@@ -3049,6 +3110,9 @@ _require_scratch_shutdown()
 # Does dax mount option work on this dev/fs?
 _require_scratch_dax()
 {
+	if [ "$FSTYP" == "local" ]; then
+		_notrun "local does not support dax"
+	fi
 	_require_scratch
 	_scratch_mkfs > /dev/null 2>&1
 	_try_scratch_mount -o dax || \
@@ -3063,6 +3127,9 @@ _require_scratch_dax()
 # Does norecovery support by this fs?
 _require_norecovery()
 {
+	if [ "$FSTYP" == "local" ]; then
+		_notrun "local does not support norecovery"
+	fi
 	_try_scratch_mount -o ro,norecovery || \
 		_notrun "$FSTYP does not support norecovery"
 	_scratch_unmount
-- 
2.16.1.72.g5be1f00a9a

