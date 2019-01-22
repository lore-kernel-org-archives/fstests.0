Received: from szxga07-in.huawei.com ([45.249.212.35]:58372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfAVDUh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 22:20:37 -0500
From: zhengbin <zhengbin13@huawei.com>
Subject: [PATCH 3/6] squashfs: add metadata test
Date: Tue, 22 Jan 2019 11:24:05 +0800
Message-ID: <20190122032408.91336-4-zhengbin13@huawei.com>
In-Reply-To: <20190122032408.91336-1-zhengbin13@huawei.com>
References: <20190122032408.91336-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, guaneryu@gmail.com, fstests@vger.kernel.org
Cc: houtao1@huawei.com, zhaohongjiang@huawei.com, zhengbin13@huawei.com
List-ID: <fstests@vger.kernel.org>

This patch add metadata test(atime, uid, gid, file mode,
file type, lock, soft link, hard link).

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 tests/readonly/002     |  48 ++++++++++++
 tests/readonly/002.out |   6 ++
 tests/readonly/003     |  72 ++++++++++++++++++
 tests/readonly/003.out |   5 ++
 tests/readonly/004     |  50 +++++++++++++
 tests/readonly/004.out |   3 +
 tests/readonly/005     |  77 ++++++++++++++++++++
 tests/readonly/005.out |   2 +
 tests/readonly/006     |  48 ++++++++++++
 tests/readonly/006.out |   4 +
 tests/readonly/007     |  74 +++++++++++++++++++
 tests/readonly/007.out |   9 +++
 tests/readonly/008     | 193 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/readonly/008.out |  34 +++++++++
 tests/readonly/009     |  50 +++++++++++++
 tests/readonly/009.out |   2 +
 tests/readonly/010     |  49 +++++++++++++
 tests/readonly/010.out |   4 +
 tests/readonly/group   |   9 +++
 19 files changed, 739 insertions(+)
 create mode 100755 tests/readonly/002
 create mode 100644 tests/readonly/002.out
 create mode 100755 tests/readonly/003
 create mode 100644 tests/readonly/003.out
 create mode 100755 tests/readonly/004
 create mode 100644 tests/readonly/004.out
 create mode 100755 tests/readonly/005
 create mode 100644 tests/readonly/005.out
 create mode 100755 tests/readonly/006
 create mode 100644 tests/readonly/006.out
 create mode 100755 tests/readonly/007
 create mode 100644 tests/readonly/007.out
 create mode 100755 tests/readonly/008
 create mode 100644 tests/readonly/008.out
 create mode 100755 tests/readonly/009
 create mode 100644 tests/readonly/009.out
 create mode 100755 tests/readonly/010
 create mode 100644 tests/readonly/010.out

diff --git a/tests/readonly/002 b/tests/readonly/002
new file mode 100755
index 00000000..eb3824d2
--- /dev/null
+++ b/tests/readonly/002
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 002
+#
+# Test metadata write/soft link/hard link on a RO fs
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_DEV/testfile
+rm -f $testfile
+touch $testfile
+
+_scratch_mkfs  > /dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+
+chown 1 $testfile 2>&1 | _filter_scratch
+chgrp 1 $testfile 2>&1 | _filter_scratch
+chmod 777 $testfile 2>&1 | _filter_scratch
+
+ln -s $testfile $SCRATCH_MNT/linkfile 2>&1 | _filter_scratch
+ln $testfile $SCRATCH_MNT/hardfile 2>&1 | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/002.out b/tests/readonly/002.out
new file mode 100644
index 00000000..3e5132b2
--- /dev/null
+++ b/tests/readonly/002.out
@@ -0,0 +1,6 @@
+QA output created by 002
+chown: changing ownership of 'SCRATCH_MNT/testfile': Read-only file system
+chgrp: changing group of 'SCRATCH_MNT/testfile': Read-only file system
+chmod: changing permissions of 'SCRATCH_MNT/testfile': Read-only file system
+ln: failed to create symbolic link 'SCRATCH_MNT/linkfile': Read-only file system
+ln: failed to create hard link 'SCRATCH_MNT/hardfile': Read-only file system
diff --git a/tests/readonly/003 b/tests/readonly/003
new file mode 100755
index 00000000..fc9577cc
--- /dev/null
+++ b/tests/readonly/003
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2008 Silicon Graphics, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 003. Modifed from generic/192.
+#
+# Simple test of atime
+# - ensure it is persistent after unmount
+# - check atime not updated after cat in readonly fs
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+_access_time()
+{
+	stat -c %X $1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_atime
+
+delay=2
+testfile=$SCRATCH_DEV/testfile
+rm -f $testfile
+rm -f $seqres.full
+
+echo test >$testfile
+
+_scratch_mkfs > /dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+
+time1=`_access_time $testfile | tee -a $seqres.full`
+
+echo "sleep for $delay seconds"
+sleep $delay # sleep to allow time to move on for access
+cat $testfile
+time2=`_access_time $testfile | tee -a $seqres.full`
+
+cd /
+_scratch_cycle_mount
+time3=`_access_time $testfile | tee -a $seqres.full`
+
+delta1=`expr $time2 - $time1`
+delta2=`expr $time3 - $time1`
+
+# readonly file system do not update atime
+_within_tolerance "delta1" $delta1 0 0 0 -v
+_within_tolerance "delta2" $delta2 $delta1 0 0 -v
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/003.out b/tests/readonly/003.out
new file mode 100644
index 00000000..ae2fe728
--- /dev/null
+++ b/tests/readonly/003.out
@@ -0,0 +1,5 @@
+QA output created by 003
+sleep for 2 seconds
+test
+delta1 is in range
+delta2 is in range
diff --git a/tests/readonly/004 b/tests/readonly/004
new file mode 100755
index 00000000..352fbff1
--- /dev/null
+++ b/tests/readonly/004
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2011 Red Hat, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei, Inc.  All Rights Reserved.
+#
+# FS QA Test No. 004. Modifed from generic/258.
+#
+# Test timestamps prior to epoch
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/timestamp-test.txt
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+TESTFILE=$SCRATCH_DEV/timestamp-test.txt
+
+# Create a file with a timestamp prior to the epoch
+echo "Creating file with timestamp of Jan 1, 1960"
+touch -t 196001010101 $TESTFILE
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+TESTFILE=$SCRATCH_MNT/timestamp-test.txt
+
+# Should yield -315593940 (prior to epoch)
+echo "Testing for negative seconds since epoch"
+ts=`stat -c %X $TESTFILE`
+if [ "$ts" -ge 0 ]; then
+	echo "Timestamp wrapped: $ts"
+	_fail "Timestamp wrapped"
+fi
+
+status=0
+exit
diff --git a/tests/readonly/004.out b/tests/readonly/004.out
new file mode 100644
index 00000000..2935bba1
--- /dev/null
+++ b/tests/readonly/004.out
@@ -0,0 +1,3 @@
+QA output created by 004
+Creating file with timestamp of Jan 1, 1960
+Testing for negative seconds since epoch
diff --git a/tests/readonly/005 b/tests/readonly/005
new file mode 100755
index 00000000..2633a742
--- /dev/null
+++ b/tests/readonly/005
@@ -0,0 +1,77 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2014, Oracle and/or its affiliates.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 005. Modifed from generic/003.
+#
+# Access time should never be updated in readonly fs, despite the
+# strictatime mount option.
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/file1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+_stat() {
+	stat -c "%x;%y;%z" $1
+}
+
+_compare_stat_times() {
+	updated=$1	# 3 chars indicating if access, modify and
+			# change times should be updated (Y) or not (N)
+	IFS=';' read -a first_stat <<< "$2"   # Convert first stat to array
+	IFS=';' read -a second_stat <<< "$3"  # Convert second stat to array
+	test_step=$4	# Will be printed to output stream in case of an
+			# error, to make debugging easier
+	types=( access modify change )
+
+	for i in 0 1 2; do
+		if [ "${first_stat[$i]}" == "${second_stat[$i]}" ]; then
+			if [ "${updated:$i:1}" == "N" ]; then
+				continue;
+			fi
+			echo -n "ERROR: ${types[$i]} time has not been updated "
+			echo $test_step
+		elif [ "${updated:$i:1}" == "N" ]; then
+			echo -n "ERROR: ${types[$i]} time has changed "
+			echo $test_step
+		fi
+	done
+}
+
+rm -f $SCRATCH_DEV/file1
+echo "test" >$SCRATCH_DEV/file1
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount "-o strictatime"
+
+file1_stat_before_first_access=`_stat $SCRATCH_MNT/file1`
+
+sleep 2
+
+cat $SCRATCH_MNT/file1 > /dev/null
+file1_stat_after_first_access=`_stat $SCRATCH_MNT/file1`
+_compare_stat_times NNN "$file1_stat_before_first_access" \
+	"$file1_stat_after_first_access" "for file in read-only filesystem"
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/readonly/005.out b/tests/readonly/005.out
new file mode 100644
index 00000000..a5027f12
--- /dev/null
+++ b/tests/readonly/005.out
@@ -0,0 +1,2 @@
+QA output created by 005
+Silence is golden
diff --git a/tests/readonly/006 b/tests/readonly/006
new file mode 100755
index 00000000..05d2fd09
--- /dev/null
+++ b/tests/readonly/006
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 006
+#
+# uid/gid/access rights/soft link/hard link test
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_DEV/testfile
+rm -f $testfile
+
+echo "test" >$testfile
+chown 1 $testfile
+chgrp 2 $testfile
+chmod 421 $testfile
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+stat -c %u $testfile
+stat -c %g $testfile
+stat -c %a $testfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/006.out b/tests/readonly/006.out
new file mode 100644
index 00000000..9f773e99
--- /dev/null
+++ b/tests/readonly/006.out
@@ -0,0 +1,4 @@
+QA output created by 006
+1
+2
+421
diff --git a/tests/readonly/007 b/tests/readonly/007
new file mode 100755
index 00000000..811b44c6
--- /dev/null
+++ b/tests/readonly/007
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2016 CTERA Networks. All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 007. Modifed from generic/401.
+#
+# Test filetype feature
+#
+# This test does NOT require that file system support the d_type feature.
+# It verifies that file types are reported as either DT_UNKNOWN or as
+# the actual file type. For example, special dir entries . and .. MAY be
+# reported as DT_UNKNOWN IF filetype feature is disabled (ext4), but MAY
+# also be reported as DT_DIR in this case (xfs).
+#
+# For fs for which we know how to test the filetype feature (xfs|ext*)
+# verify getting DT_UNKNOWN IFF feature is disabled.
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $SCRATCH_DEV/find-by-type
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_test_program "t_dir_type"
+
+# Create our test files.
+testdir=$SCRATCH_DEV/find-by-type
+mkdir -p $testdir
+mkdir $testdir/d
+touch $testdir/f
+ln -s $testdir/f $testdir/l
+mknod $testdir/c c 1 1
+mknod $testdir/b b 1 1
+mknod $testdir/p p
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testdir=$SCRATCH_MNT/find-by-type
+
+# Test d_type of test files - it must be the actual file type on fs
+# with filetype support and it could be either the actual file type
+# or DT_UNKNOWN on fs without filetype support
+ftype=
+src/t_dir_type $SCRATCH_MNT u | wc -l > /dev/null && ftype=1
+src/t_dir_type $testdir | \
+while read name type; do
+	if [ "$ftype" != 1 -a "$type" = u ]; then
+		if [ "$name" = "." -o "$name" = ".." ]; then
+			type=d
+		else
+			type=$name
+		fi
+	fi
+	echo $name $type
+done | sort
+
+status=0
+exit
diff --git a/tests/readonly/007.out b/tests/readonly/007.out
new file mode 100644
index 00000000..798401ed
--- /dev/null
+++ b/tests/readonly/007.out
@@ -0,0 +1,9 @@
+QA output created by 007
+. d
+.. d
+b b
+c c
+d d
+f f
+l l
+p p
diff --git a/tests/readonly/008 b/tests/readonly/008
new file mode 100755
index 00000000..09da3215
--- /dev/null
+++ b/tests/readonly/008
@@ -0,0 +1,193 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test NO. 008. Modifed from generic/478.
+#
+# Test OFD lock. fcntl F_OFD_SETLK to set lock, then F_OFD_GETLK
+# to verify we are being given correct advice by kernel.
+#
+# OFD lock combines POSIX lock and BSD flock:
+#   + does not share between threads
+#   + byte granularity
+#            (both tested by LTP/fcntl3{4,6})
+#   + only release automatically after all open fd closed
+#
+# This test target the third one and expand a little bit.
+#
+# The basic idea is one setlk routine setting locks via fcntl
+# *_SETLK, followed by operations like clone, dup then close fd;
+# another routine getlk getting locks via fcntl *_GETLK.
+#
+# Firstly in setlk routine process P0, place a lock L0 on an
+# opened testfile, then
+#
+#   + clone() a child P1 to close the fd then tell getlk to go,
+#     parent P0 wait getlk done then close fd.
+# or
+#   + dup() fd to a newfd then close newfd then tell getlk to go,
+#     then wait getlk done then close fd.
+#
+# In getlk process P2, do fcntl *_GETLK with lock L1 after get
+# notified by setlk routine.
+#
+# In the end, getlk routine check the returned struct flock.l_type
+# to see if the lock mechanism works fine.
+#
+# When testing with clone,
+#    + CLONE_FILES set, close releases all locks;
+#    + CLONE_FILES not set, locks remain in P0;
+#
+# If L0 is a POSIX lock,
+#   + it is not inherited into P1
+#   + it is released after dup & close
+#
+# If L0 is a OFD lock,
+#   + it is inherited into P1
+#   + it is not released after dup & close
+#
+#  setlk routine:			 * getlk routine:
+#    start				 *   start
+#      |				 *     |
+#   open file				 *  open file
+#      |				 *     |
+#   init sem				 *     |
+#      |				 *     |
+#  wait init sem done			 * wait init sem done
+#      |				 *     |
+#    setlk L0                            *     |
+#      |				 *     |
+#      |---------clone()--------|	 *     |
+#      |                        |	 *     |
+#      |(child P1)   (parent P0)|	 *     | (P2)
+#      |                        |	 *     |
+#      |                   close fd	 *     |
+#      |                        |	 *     |
+#      |                 set sem0=0	 *  wait sem0==0
+#      |                        |	 *     |
+#      |                        |	 *   getlk L1
+#      |                        |	 *     |
+#   wait sem1==0                |    	 *  set sem1=0
+#      |                        |	 *     |
+#     exit                wait child 	 *     |
+#                               |	 *  check result
+#                           cleanup  	 *     |
+#                               |	 *     |
+#                             exit	 *    exit
+#
+# We can test combainations of:
+#	+ shared or exclusive lock
+#	+ these locks are conflicting or not
+#	+ one OFD lock and one POSIX lock
+#	+ that open testfile RDONLY or RDWR
+#	+ clone with CLONE_FILES or not
+#	+ dup and close newfd
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+rm -f $SCRATCH_DEV/testfile
+
+# prepare a 4k testfile in TEST_DIR
+$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
+	$SCRATCH_DEV/testfile >> $seqres.full 2>&1
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+do_test()
+{
+	local soptions="$1"
+	local goptions="$2"
+	# print options and getlk output for debug
+	echo $* >> $seqres.full 2>&1
+	# -s : do setlk
+	$here/src/t_ofd_locks $soptions $SCRATCH_MNT/testfile &
+	# -g : do getlk
+	$here/src/t_ofd_locks $goptions $SCRATCH_MNT/testfile | \
+		tee -a $seqres.full
+	wait $!
+
+	# add -F to clone with CLONE_FILES
+	soptions="$1 -F"
+	# with -F, new locks are always file to place
+	$here/src/t_ofd_locks $soptions $SCRATCH_MNT/testfile &
+	$here/src/t_ofd_locks $goptions $SCRATCH_MNT/testfile | \
+		tee -a $seqres.full
+	wait $!
+
+	# add -d to dup and close
+	soptions="$1 -d"
+	$here/src/t_ofd_locks $soptions $SCRATCH_MNT/testfile &
+	$here/src/t_ofd_locks $goptions $SCRATCH_MNT/testfile | \
+		tee -a $seqres.full
+	wait $!
+}
+
+# Always setlk at range [0,9], getlk at range [0,9] [5,24] or [20,29].
+# To open file RDONLY should not break the locks.
+# POSIX locks should be released after closed fd, so it wont conflict
+# with other locks in tests
+
+# -P : operate posix lock
+# -w : operate on F_WRLCK
+# -r : operate on F_RDLCK
+# -R : open file RDONLY
+# -W : open file RDWR
+# -o : file offset where the lock starts
+# -l : lock length
+# -F : clone with CLONE_FILES in setlk
+# -d : dup and close in setlk
+
+# setlk rdlck [0,9], getlk wrlck [0,9], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -w -o 0 -l 10 -R" "rdlck" "unlck" "rdlck"
+# setlk rdlck [0,9], getlk wrlck [5,24], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -w -o 5 -l 20 -R -P" "rdlck" "unlck" "rdlck"
+# setlk posix rdlck [0,9], getlk wrlck [5,24], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -P" "-g -w -o 5 -l 20 -R" "rdlck" "unlck" "unlck"
+# setlk rdlck [0,9], getlk wrlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -w -o 20 -l 10 -R" "unlck" "unlck" "unlck"
+# setlk posix rdlck [0,9], getlk wrlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -P" "-g -w -o 20 -l 10 -R" "unlck" "unlck" "unlck"
+
+# setlk rdlck [0,9], getlk rdlck [0,9], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 0 -l 10 -R" "unlck" "unlck" "unlck"
+# setlk rdlck [0,9], getlk posix rdlck [0,9], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 0 -l 10 -R -P" "unlck" "unlck" "unlck"
+# setlk posix rdlck [0,9], getlk rdlck [0,9], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -P" "-g -r -o 0 -l 10 -R" "unlck" "unlck" "unlck"
+
+# setlk rdlck [0,9], getlk rdlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 20 -l 10 -R" "unlck" "unlck" "unlck"
+# setlk rdlck [0,9], getlk posix rdlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 20 -l 10 -R -P" "unlck" "unlck" "unlck"
+# setlk posix rdlck [0,9], getlk rdlck [20,29], open RDONLY
+do_test "-s -r -o 0 -l 10 -R -P" "-g -r -o 20 -l 10 -R" "unlck" "unlck" "unlck"
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/008.out b/tests/readonly/008.out
new file mode 100644
index 00000000..d3ac560f
--- /dev/null
+++ b/tests/readonly/008.out
@@ -0,0 +1,34 @@
+QA output created by 008
+get rdlck
+lock could be placed
+get rdlck
+get rdlck
+lock could be placed
+get rdlck
+get rdlck
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
diff --git a/tests/readonly/009 b/tests/readonly/009
new file mode 100755
index 00000000..215fd136
--- /dev/null
+++ b/tests/readonly/009
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 RedHat Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test NO. 009. Modifed from generic/504.
+#
+# flock test(shared lock, exclusive lock)
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/flock_testfile_$seq
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_command "$FLOCK_PROG" "flock"
+
+testfile=$SCRATCH_DEV/flock_testfile_$seq
+rm -f $testfile
+touch $testfile
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/flock_testfile_$seq
+
+# test shared lock
+flock -sn $testfile -c "echo 'test' > /dev/null"
+
+# test exclusive lockflock
+flock -xn $testfile -c "echo 'test' > /dev/null"
+
+# success, all done
+status=0
+echo "Silence is golden"
+exit
diff --git a/tests/readonly/009.out b/tests/readonly/009.out
new file mode 100644
index 00000000..7e977155
--- /dev/null
+++ b/tests/readonly/009.out
@@ -0,0 +1,2 @@
+QA output created by 009
+Silence is golden
diff --git a/tests/readonly/010 b/tests/readonly/010
new file mode 100755
index 00000000..9821cec0
--- /dev/null
+++ b/tests/readonly/010
@@ -0,0 +1,49 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 010
+#
+# soft link/hard link test
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+	rm -f $SCRATCH_DEV/hardlink
+	rm -f $SCRATCH_DEV/softlink
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_DEV/testfile
+rm -f $testfile
+
+echo "test" >$testfile
+ln -s $testfile $SCRATCH_DEV/softlink
+ln $testfile $SCRATCH_DEV/hardlink
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+cat $SCRATCH_MNT/softlink
+cat $SCRATCH_MNT/hardlink
+stat -c %h $testfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/010.out b/tests/readonly/010.out
new file mode 100644
index 00000000..c40989d5
--- /dev/null
+++ b/tests/readonly/010.out
@@ -0,0 +1,4 @@
+QA output created by 010
+test
+test
+2
diff --git a/tests/readonly/group b/tests/readonly/group
index dc21c93d..f87b1fc3 100644
--- a/tests/readonly/group
+++ b/tests/readonly/group
@@ -4,3 +4,12 @@
 # - comment line before each group is "new" description
 #
 001 auto
+002 auto
+003 auto
+004 auto
+005 auto
+006 auto
+007 auto
+008 auto
+009 auto
+010 auto
--
2.16.2.dirty
