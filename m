Received: from mail-pf0-f193.google.com ([209.85.192.193]:35695 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdADDvS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Jan 2017 22:51:18 -0500
Received: by mail-pf0-f193.google.com with SMTP id i88so26359915pfk.2
        for <fstests@vger.kernel.org>; Tue, 03 Jan 2017 19:51:18 -0800 (PST)
From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v3] generic/390: Add tests for inode timestamp policy
Date: Tue,  3 Jan 2017 19:51:11 -0800
Message-Id: <1483501871-15389-1-git-send-email-deepa.kernel@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: arnd@arndb.de, y2038@lists.linaro.org
List-ID: <fstests@vger.kernel.org>

The test helps to validate clamping and mount behaviors
according to supported file system timestamp ranges.

Note that the test can fail on 32-bit systems for a
few file systems. This will be corrected when vfs is
transitioned to use 64-bit timestamps.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
The branch of the kernel tree can be located at

https://github.com/deepa-hub/vfs refs/heads/vfs_timestamp_policy

The xfs_io patch to add utimes is at

https://www.spinics.net/lists/linux-xfs/msg02952.html

Changes since v2:
* Refactored notrun handling
* Updated comments

Changes since v1:
* Use xfs_io utimes command
* Updated error handling
* Reorganized code according to review comments

 common/rc             |  48 +++++++++++++
 tests/generic/390     | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/390.out |   2 +
 tests/generic/group   |   1 +
 4 files changed, 243 insertions(+)
 create mode 100755 tests/generic/390
 create mode 100644 tests/generic/390.out

diff --git a/common/rc b/common/rc
index e3b54ec..17f025e 100644
--- a/common/rc
+++ b/common/rc
@@ -1960,6 +1960,51 @@ _run_aiodio()
     return $status
 }
 
+# this test requires y2038 sysfs switch and filesystem
+# timestamp ranges support.
+_require_y2038()
+{
+	local device=${1:-$TEST_DEV}
+	local sysfsdir=/proc/sys/fs/fs-timestamp-check-on
+
+	if [ ! -e $sysfsdir ]; then
+		_notrun "no kernel support for y2038 sysfs switch"
+	fi
+
+	local tsmin tsmax
+	read tsmin tsmax <<<$(_filesystem_timestamp_range $device)
+	if [ $tsmin -eq -1 -a $tsmax -eq -1 ]; then
+		_notrun "filesystem $FSTYP timestamp bounds are unknown"
+	fi
+}
+
+_filesystem_timestamp_range()
+{
+	device=${1:-$TEST_DEV}
+	case $FSTYP in
+	ext4)
+		if [ $(dumpe2fs -h $device 2>/dev/null | grep "Inode size:" | cut -d: -f2) -gt 128 ]; then
+			echo "-2147483648 15032385535"
+		else
+			echo "-2147483648 2147483647"
+		fi
+		;;
+
+	xfs)
+		echo "-2147483648 2147483647"
+		;;
+	jfs)
+		echo "0 4294967295"
+		;;
+	f2fs)
+		echo "-2147483648 2147483647"
+		;;
+	*)
+		echo "-1 -1"
+		;;
+	esac
+}
+
 # indicate whether YP/NIS is active or not
 #
 _yp_active()
@@ -2070,6 +2115,9 @@ _require_xfs_io_command()
 		echo $testio | egrep -q "Inappropriate ioctl" && \
 			_notrun "xfs_io $command support is missing"
 		;;
+	"utimes" )
+		testio=`$XFS_IO_PROG -f -c "utimes" 0 0 0 0 $testfile 2>&1`
+		;;
 	*)
 		testio=`$XFS_IO_PROG -c "$command help" 2>&1`
 	esac
diff --git a/tests/generic/390 b/tests/generic/390
new file mode 100755
index 0000000..f68b931
--- /dev/null
+++ b/tests/generic/390
@@ -0,0 +1,192 @@
+#! /bin/bash
+# FS QA Test 390
+#
+# Tests to verify policy for filesystem timestamps for
+# supported ranges:
+# 1. Verify filesystem rw mount according to sysctl
+# timestamp_supported.
+# 2. Verify timestamp clamping for timestamps beyond max
+# timestamp supported.
+#
+# Exit status 1: either or both tests above fail.
+# Exit status 0: both the above tests pass.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Deepa Dinamani.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "exit \$status" 0 1 2 3 15
+
+# Get standard environment, filters and checks.
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Prerequisites for the test run.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_xfs_io_command utimes
+
+# Compare file timestamps obtained from stat
+# with a given timestamp.
+check_stat()
+{
+	file=$1
+	timestamp=$2
+
+	stat_timestamp=`stat -c"%X;%Y" $file`
+
+	prev_timestamp="$timestamp;$timestamp"
+	if [ $prev_timestamp != $stat_timestamp ]; then
+		echo "$prev_timestamp != $stat_timestamp" | tee -a $seqres.full
+	fi
+}
+
+run_test_individual()
+{
+	file=$1
+	timestamp=$2
+	update_time=$3
+
+	#check if the time needs update
+	if [ $update_time -eq 1 ]; then
+		echo "Updating file: $file to timestamp `date -d @$timestamp`"  >> $seqres.full
+		$XFS_IO_PROG -f -c "utimes $timestamp 0 $timestamp 0" $file
+		if [ $? -ne 0 ]; then
+			echo "Failed to update times on $file" | tee -a $seqres.full
+		fi
+	fi
+
+	tsclamp=$(($timestamp>$tsmax?$tsmax:$timestamp))
+	echo "Checking file: $file Updated timestamp is `date -d @$tsclamp`"  >> $seqres.full
+	check_stat $file $tsclamp
+}
+
+run_test()
+{
+	update_time=$1
+
+	n=1
+
+	for TIME in "${TIMESTAMPS[@]}"
+	do
+		#Run the test
+		run_test_individual ${SCRATCH_MNT}/test_$n $TIME $update_time
+
+		#update iterator
+		((n++))
+	done
+}
+
+_scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
+_require_y2038 $SCRATCH_DEV
+
+read tsmin tsmax <<<$(_filesystem_timestamp_range $SCRATCH_DEV)
+echo min supported timestamp $tsmin $(date --date=@$tsmin) >> $seqres.full
+echo max supported timestamp $tsmax $(date --date=@$tsmax) >> $seqres.full
+
+# Test timestamps array
+
+declare -a TIMESTAMPS=(
+	$tsmin
+	0
+	$tsmax
+	$((tsmax+1))
+	4294967295
+	8589934591
+	34359738367
+)
+
+# Max timestamp is hardcoded to Mon Jan 18 19:14:07 PST 2038
+sys_tsmax=2147483647
+echo "max timestamp that needs to be supported by fs for rw mount is" \
+	"$((sys_tsmax+1)) $(date --date=@$((sys_tsmax+1)))" >> $seqres.full
+
+read ts_check <<<$(cat /proc/sys/fs/fs-timestamp-check-on)
+
+_scratch_mount
+result=$?
+
+if [ $ts_check -ne 0 ]; then
+	echo "sysctl filesystem timestamp check is on" >> $seqres.full
+	# check for mount failure if the minimum requirement for max timestamp
+	# supported is not met.
+	if [ $sys_tsmax -ge $tsmax ]; then
+		if [ $result -eq 0 ]; then
+			echo "mount test failed"  | tee -a $seqres.full
+			exit
+		fi
+	else
+		if [ $result -ne 0 ]; then
+			echo "failed to mount $SCRATCH_DEV"  | tee -a $seqres.full
+			exit
+		fi
+	fi
+else
+	# if sysctl switch is off then mount should succeed always.
+	echo "sysctl filesystem timestamp check is off" >> $seqres.full
+	if [ $result -ne 0 ]; then
+		echo "failed to mount $SCRATCH_DEV and timestamp check is off"  >> $seqres.full
+		exit
+	fi
+fi
+
+# Begin test case 1
+echo "In memory timestamps update test start" >> $seqres.full
+
+# update time on the file
+update_time=1
+
+run_test $update_time
+
+echo "In memory timestamps update complete" >> $seqres.full
+
+echo "Unmounting and mounting scratch $SCRATCH_MNT" >> $seqres.full
+
+# unmount and remount $SCRATCH_DEV
+_scratch_cycle_mount
+
+# Begin test case 2
+
+n=1
+
+# Do not update time on the file this time, just read from disk
+update_time=0
+
+echo "On disk timestamps update test start" >> $seqres.full
+
+# Re-run test
+run_test $update_time
+
+echo "On disk timestamps update test complete" >> $seqres.full
+
+echo "y2038 inode timestamp tests completed successfully"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/390.out b/tests/generic/390.out
new file mode 100644
index 0000000..82bd4eb
--- /dev/null
+++ b/tests/generic/390.out
@@ -0,0 +1,2 @@
+QA output created by 390
+y2038 inode timestamp tests completed successfully
diff --git a/tests/generic/group b/tests/generic/group
index 08007d7..d137d01 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -392,3 +392,4 @@
 387 auto clone
 388 auto log metadata
 389 auto quick acl
+390 auto quick rw
-- 
2.7.4

