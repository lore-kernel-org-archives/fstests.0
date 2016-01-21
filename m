Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:33544 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752562AbcAUBoF (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Jan 2016 20:44:05 -0500
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1aM4HL-0001zv-9K
	for fstests@vger.kernel.org; Thu, 21 Jan 2016 12:43:15 +1100
Received: from dave by disappointment with local (Exim 4.86)
	(envelope-from <dave@disappointment.disaster>)
	id 1aM4HL-0002gn-8W
	for fstests@vger.kernel.org; Thu, 21 Jan 2016 12:43:15 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/3] xfs: support realtime/log device setup changes in config sections
Date: Thu, 21 Jan 2016 12:43:11 +1100
Message-Id: <1453340593-10236-2-git-send-email-david@fromorbit.com>
In-Reply-To: <1453340593-10236-1-git-send-email-david@fromorbit.com>
References: <1453340593-10236-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Currently changing the devices used by "USE_EXTERNAL" environmental
variable is not supported by the config section parsing. Add the
functionality so that we can use config sections to test external
device configs successfully.

This required tracking down a bug in _check_xfs_filesystem() which
was causing a log device to be passed to a test device without an
external log device. This was caused by an uninitialised variable in
the function. I also added full output file removals to the first
couple of generic tests that were failing, because that's where the
check failure output ends up in this case.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/config     | 63 +++++++++++++++++++++++++++++++++++++++----------------
 common/dmflakey   |  3 ++-
 common/rc         |  1 +
 tests/generic/002 |  2 ++
 tests/generic/004 |  2 ++
 5 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/common/config b/common/config
index cb34fd7..477753e 100644
--- a/common/config
+++ b/common/config
@@ -416,6 +416,30 @@ if [ -f "$HOST_OPTIONS" ]; then
 	fi
 fi
 
+_check_device()
+{
+	local name=$1
+	local dev_needed=$2
+	local dev=$3
+
+	if [ -z "$dev" ]; then
+		if [ "$dev_needed" == "required" ]; then 
+			_fatal "common/config: $name is required but not defined!"
+		fi
+		return
+	fi
+
+	echo $dev | grep -qE ":|//" > /dev/null 2>&1
+	network_dev=$?
+	if [ "$FSTYP" == "overlay" ]; then
+		if [ ! -d "$dev" ]; then
+			_fatal "common/config: $name ($dev) is not a directory for overlay"
+		fi
+	elif [ ! -b "$dev" -a "$network_dev" != "0" ]; then
+		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
+	fi
+}
+
 # Parse config section options. This function will parse all the configuration
 # within a single section which name is passed as an argument. For section
 # name format see comments in get_config_sections().
@@ -449,10 +473,13 @@ get_next_config() {
 	local OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
 	local OLD_MKFS_OPTIONS=$MKFS_OPTIONS
 	local OLD_FSCK_OPTIONS=$FSCK_OPTIONS
+	local OLD_USE_EXTERNAL=$USE_EXTERNAL
 
 	unset MOUNT_OPTIONS
 	unset MKFS_OPTIONS
 	unset FSCK_OPTIONS
+	unset USE_EXTERNAL
+
 	# We might have deduced SCRATCH_DEV from the SCRATCH_DEV_POOL in the previous
 	# run, so we have to unset it now.
 	if [ "$SCRATCH_DEV_NOT_SET" == "true" ]; then
@@ -466,11 +493,20 @@ get_next_config() {
 		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
 		[ -z "$MKFS_OPTIONS" ] && _mkfs_opts
 		[ -z "$FSCK_OPTIONS" ] && _fsck_opts
+
+		# clear the external devices if we are not using them
+		if [ -z "$USE_EXTERNAL" ]; then
+			unset TEST_RTDEV
+			unset TEST_LOGDEV
+			unset SCRATCH_RTDEV
+			unset SCRATCH_LOGDEV
+		fi
 	else
 		[ -z "$MOUNT_OPTIONS" ] && export MOUNT_OPTIONS=$OLD_MOUNT_OPTIONS
 		[ -z "$TEST_FS_MOUNT_OPTS" ] && export TEST_FS_MOUNT_OPTS=$OLD_TEST_FS_MOUNT_OPTS
 		[ -z "$MKFS_OPTIONS" ] && export MKFS_OPTIONS=$OLD_MKFS_OPTIONS
 		[ -z "$FSCK_OPTIONS" ] && export FSCK_OPTIONS=$OLD_FSCK_OPTIONS
+		[ -z "$USE_EXTERNAL" ] && export USE_EXTERNAL=$OLD_USE_EXTERNAL
 	fi
 
 	# set default RESULT_BASE
@@ -491,15 +527,7 @@ get_next_config() {
 		exit 1
 	fi
 
-	echo $TEST_DEV | grep -qE ":|//" > /dev/null 2>&1
-	if [ ! -b "$TEST_DEV" -a "$?" != "0" -a "$FSTYP" != "overlay" ]; then
-		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a network filesystem"
-		exit 1
-	elif [ "$FSTYP" == "overlay" -a ! -d "$TEST_DEV" ]; then
-		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a directory for overlay"
-		exit 1
-	fi
-
+	_check_device TEST_DEV required $TEST_DEV
 	if [ ! -d "$TEST_DIR" ]; then
 		echo "common/config: Error: \$TEST_DIR ($TEST_DIR) is not a directory"
 		exit 1
@@ -517,19 +545,18 @@ get_next_config() {
 		export SCRATCH_DEV_NOT_SET=true
 	fi
 
-	echo $SCRATCH_DEV | grep -qE ":|//" > /dev/null 2>&1
-	if [ ! -z "$SCRATCH_DEV" -a ! -b "$SCRATCH_DEV" -a "$?" != "0" -a "$FSTYP" != "overlay" ]; then
-		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a network filesystem"
-		exit 1
-	elif [ ! -z "$SCRATCH_DEV" -a "$FSTYP" == "overlay" -a ! -d "$SCRATCH_DEV" ]; then
-		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a directory for overlay"
-		exit 1
-	fi
-
+	_check_device SCRATCH_DEV optional $SCRATCH_DEV
 	if [ ! -z "$SCRATCH_MNT" -a ! -d "$SCRATCH_MNT" ]; then
 		echo "common/config: Error: \$SCRATCH_MNT ($SCRATCH_MNT) is not a directory"
 		exit 1
 	fi
+
+	if [ -n "$USE_EXTERNAL" ]; then
+		_check_device TEST_RTDEV optional $TEST_RTDEV
+		_check_device TEST_LOGDEV optional $TEST_LOGDEV
+		_check_device SCRATCH_RTDEV optional $SCRATCH_RTDEV
+		_check_device SCRATCH_LOGDEV optional $SCRATCH_LOGDEV
+	fi
 }
 
 if [ -z "$CONFIG_INCLUDED" ]; then
diff --git a/common/dmflakey b/common/dmflakey
index 5a45d14..3b6521a 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -39,7 +39,8 @@ _init_flakey()
 
 _mount_flakey()
 {
-	mount -t $FSTYP $MOUNT_OPTIONS $FLAKEY_DEV $SCRATCH_MNT
+	_scratch_options mount
+	mount -t $FSTYP $SCRATCH_OPTIONS $MOUNT_OPTIONS $FLAKEY_DEV $SCRATCH_MNT
 }
 
 _unmount_flakey()
diff --git a/common/rc b/common/rc
index 5135260..716c215 100644
--- a/common/rc
+++ b/common/rc
@@ -2017,6 +2017,7 @@ _check_xfs_filesystem()
     fi
 
     extra_mount_options=""
+    extra_log_options=""
     extra_options=""
     device=$1
     if [ -f $device ];then
diff --git a/tests/generic/002 b/tests/generic/002
index f63b208..0433882 100755
--- a/tests/generic/002
+++ b/tests/generic/002
@@ -45,6 +45,8 @@ _supported_fs generic
 _supported_os IRIX Linux
 _require_test
 
+rm -f $seqres.full
+
 echo "Silence is goodness ..."
 
 # ensure target directory exists
diff --git a/tests/generic/004 b/tests/generic/004
index c7aa473..d0926f1 100755
--- a/tests/generic/004
+++ b/tests/generic/004
@@ -47,6 +47,8 @@ _supported_os Linux
 _require_test
 _require_xfs_io_command "flink"
 
+rm -f $seqres.full
+
 testfile="${TEST_DIR}/tst-tmpfile-flink"
 
 # test creating a r/w tmpfile, do I/O and link it into the namespace
-- 
2.5.0

