Return-Path: <SRS0=OCqJ=YZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FD5CA9ECF
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Nov 2019 10:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A9321835
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Nov 2019 10:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfKAK2f (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:28:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728711AbfKAK2e (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 1 Nov 2019 06:28:34 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5200D4C1C67F53296CFA;
        Fri,  1 Nov 2019 18:28:32 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Fri, 1 Nov 2019 18:28:23 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        "Chao Yu" <yuchao0@huawei.com>
Subject: [PATCH v4] common/rc: generalize _get_filesize()
Date:   Fri, 1 Nov 2019 18:28:21 +0800
Message-ID: <20191101102821.14315-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There are some testcases use below two kind of commands to get file
size, generalize the second way as global function _get_filesize()
to simply codes.

1. ls -l $1 | $AWK_PROG '{print $5}'
2. stat -c %s $1

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v4:
- let _get_filesize() to cover more codes.
 common/populate   | 2 +-
 common/rc         | 5 +++++
 common/verity     | 4 ++--
 tests/btrfs/086   | 2 +-
 tests/generic/013 | 5 -----
 tests/generic/275 | 2 +-
 tests/generic/286 | 8 ++++----
 tests/generic/297 | 2 +-
 tests/generic/298 | 2 +-
 tests/generic/315 | 2 +-
 tests/generic/399 | 2 +-
 tests/generic/497 | 8 ++++----
 tests/generic/514 | 2 +-
 tests/generic/572 | 4 ++--
 tests/overlay/060 | 2 +-
 tests/xfs/014     | 2 +-
 tests/xfs/076     | 2 +-
 tests/xfs/306     | 2 +-
 18 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/common/populate b/common/populate
index eeac66d7..0b036051 100644
--- a/common/populate
+++ b/common/populate
@@ -777,7 +777,7 @@ _fill_fs()
 		fi
 
 		if [ -f $dir/$file_count ]; then
-			bytes_written=$(stat -c '%s' $dir/$file_count)
+			bytes_written=$(_get_filesize $dir/$file_count)
 		fi
 
 		# If there was no room to make the file, then divide it in
diff --git a/common/rc b/common/rc
index a2a28f32..06611e0c 100644
--- a/common/rc
+++ b/common/rc
@@ -165,6 +165,11 @@ if [ ! -z "$REPORT_LIST" ]; then
 	_assert_report_list
 fi
 
+_get_filesize()
+{
+    stat -c %s "$1"
+}
+
 _mount()
 {
     $MOUNT_PROG `_mount_ops_filter $*`
diff --git a/common/verity b/common/verity
index bcb5670d..1261dfb4 100644
--- a/common/verity
+++ b/common/verity
@@ -154,7 +154,7 @@ _fsv_scratch_corrupt_bytes()
 	sync	# Sync to avoid unwritten extents
 
 	cat > $tmp.bytes
-	local end=$(( offset + $(stat -c %s $tmp.bytes ) ))
+	local end=$(( offset + $(_get_filesize $tmp.bytes ) ))
 
 	# For each extent that intersects the requested range in order, add a
 	# command that writes the next part of the data to that extent.
@@ -205,7 +205,7 @@ _fsv_scratch_corrupt_merkle_tree()
 	ext4|f2fs)
 		# ext4 and f2fs store the Merkle tree after the file contents
 		# itself, starting at the next 65536-byte aligned boundary.
-		(( offset += ($(stat -c %s $file) + 65535) & ~65535 ))
+		(( offset += ($(_get_filesize $file) + 65535) & ~65535 ))
 		_fsv_scratch_corrupt_bytes $file $offset
 		;;
 	*)
diff --git a/tests/btrfs/086 b/tests/btrfs/086
index 750b54de..f80134a3 100755
--- a/tests/btrfs/086
+++ b/tests/btrfs/086
@@ -54,7 +54,7 @@ touch $SCRATCH_MNT/bar
 # supposed to happen and for example it made inode eviction enter an infinite
 # loop that dumped a warning trace on each iteration.
 $CLONER_PROG -s 0 -d 65536 -l 0 $SCRATCH_MNT/foo $SCRATCH_MNT/bar
-echo "bar file size after clone operation: $(stat -c %s $SCRATCH_MNT/bar)"
+echo "bar file size after clone operation: `_get_filesize $SCRATCH_MNT/bar`"
 
 status=0
 exit
diff --git a/tests/generic/013 b/tests/generic/013
index 9e533ee8..bc596102 100755
--- a/tests/generic/013
+++ b/tests/generic/013
@@ -24,11 +24,6 @@ _cleanup()
     rm -rf $TEST_DIR/fsstress.$$.*
 }
 
-_filesize()
-{
-    ls -l $1 | $AWK_PROG '{print "    filesize = " $5}'
-}
-
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
diff --git a/tests/generic/275 b/tests/generic/275
index a934c19c..adc82856 100755
--- a/tests/generic/275
+++ b/tests/generic/275
@@ -73,7 +73,7 @@ echo "Bytes written until ENOSPC:" >>$seqres.full
 du $SCRATCH_MNT/tmp1 >>$seqres.full
 
 # And at least some of it should succeed.
-_filesize=`ls -l $SCRATCH_MNT/tmp1 | awk '{print $5}'`
+_filesize=`_get_filesize $SCRATCH_MNT/tmp1`
 [ $_filesize -lt $((128 * 1024)) ] && \
 	_fail "Partial write until enospc failed; wrote $_filesize bytes."
 
diff --git a/tests/generic/286 b/tests/generic/286
index 0d980e79..00cb87b7 100755
--- a/tests/generic/286
+++ b/tests/generic/286
@@ -57,7 +57,7 @@ test01()
 
 	$here/src/seek_copy_test $src $dest
 	
-	test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
+	test $(_get_filesize $src) = $(_get_filesize $dest) ||
 		_fail "TEST01: file size check failed"
 
 	cmp $src $dest || _fail "TEST01: file bytes check failed"
@@ -85,7 +85,7 @@ test02()
 
 	$here/src/seek_copy_test $src $dest
 
-	test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
+	test $(_get_filesize $src) = $(_get_filesize $dest) ||
 		_fail "TEST02: file size check failed"
 
 	cmp $src $dest || _fail "TEST02: file bytes check failed"
@@ -127,7 +127,7 @@ test03()
 	echo >>$seqres.full
 	$here/src/seek_copy_test $src $dest
 
-	test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
+	test $(_get_filesize $src) = $(_get_filesize $dest) ||
 		_fail "TEST03: file size check failed"
 
 	cmp $src $dest || _fail "TEST03: file bytes check failed"
@@ -169,7 +169,7 @@ test04()
 	echo >>$seqres.full
 	$here/src/seek_copy_test $src $dest
 
-	test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
+	test $(_get_filesize $src) = $(_get_filesize $dest) ||
 		_fail "TEST04: file size check failed"
 
 	cmp $src $dest || _fail "TEST04: file bytes check failed"
diff --git a/tests/generic/297 b/tests/generic/297
index 5950a8da..eb08a9e3 100755
--- a/tests/generic/297
+++ b/tests/generic/297
@@ -66,7 +66,7 @@ done
 
 echo "Try to kill reflink after a shorter period of time"
 kill_after=2	# give us a shorter time to die
-n=$(stat -c '%s' $testdir/file1)
+n=$(_get_filesize $testdir/file1)
 echo "performing kill test on $n bytes..." >> $seqres.full
 touch $TEST_DIR/before
 $TIMEOUT_PROG -s INT ${kill_after}s $XFS_IO_PROG -f -c "reflink $testdir/file1 0 $n $n" $testdir/file1 >> $seqres.full 2>&1
diff --git a/tests/generic/298 b/tests/generic/298
index b87012dd..8b9cb7d6 100755
--- a/tests/generic/298
+++ b/tests/generic/298
@@ -66,7 +66,7 @@ done
 
 echo "Try to kill reflink after a shorter period of time"
 kill_after=2	# give us a shorter time to die
-n=$(stat -c '%s' $testdir/file1)
+n=$(_get_filesize $testdir/file1)
 echo "performing kill test on $n bytes..." >> $seqres.full
 touch $TEST_DIR/before
 urk=$($TIMEOUT_PROG -s KILL ${kill_after}s $XFS_IO_PROG -f -c "reflink $testdir/file1 0 $n $n" $testdir/file1 >> $seqres.full 2>&1)
diff --git a/tests/generic/315 b/tests/generic/315
index fd49b579..808d7d74 100755
--- a/tests/generic/315
+++ b/tests/generic/315
@@ -52,7 +52,7 @@ $XFS_IO_PROG -f -c 'falloc -k 0 $(($avail_begin/2))' \
 	$TEST_DIR/testfile.$seq >>$seqres.full 2>&1
 
 # Verify the file size, it should keep unchanged as 0 in this case
-fsize=`ls -l $TEST_DIR/testfile.$seq | awk '{print $5}'`
+fsize=`_get_filesize $TEST_DIR/testfile.$seq`
 [ "$fsize" -eq 0 ] || _fail "File size is changed to ($fsize Bytes)"
 
 # Truncate the file size back to 0
diff --git a/tests/generic/399 b/tests/generic/399
index b2aaac13..a9b3997a 100755
--- a/tests/generic/399
+++ b/tests/generic/399
@@ -89,7 +89,7 @@ while true; do
 
 	file_size=0
 	if [ -e $file ]; then
-		file_size=$(stat -c %s $file)
+		file_size=$(_get_filesize $file)
 	fi
 
 	# We shouldn't have been able to write more data than we had space for.
diff --git a/tests/generic/497 b/tests/generic/497
index 3d5502ef..faeaa142 100755
--- a/tests/generic/497
+++ b/tests/generic/497
@@ -60,9 +60,9 @@ swapfile_cycle() {
 # Create a swap file with a large discontiguous range(?)
 echo "large discontig swap" | tee -a $seqres.full
 _pwrite_byte 0x58 0 $((len * 2)) $swapfile >> $seqres.full
-old_sz="$(stat -c '%s' $swapfile)"
+old_sz="$(_get_filesize $swapfile)"
 $XFS_IO_PROG -c "fcollapse $((len / 2)) $len" $swapfile >> $seqres.full 2>&1
-new_sz="$(stat -c '%s' $swapfile)"
+new_sz="$(_get_filesize $swapfile)"
 if [ $old_sz -gt $new_sz ]; then
 	swapfile_cycle $swapfile
 fi
@@ -71,9 +71,9 @@ rm -f $swapfile
 # Create a swap file with a small discontiguous range(?)
 echo "small discontig swap" | tee -a $seqres.full
 _pwrite_byte 0x58 0 $((len + 1024)) $swapfile >> $seqres.full
-old_sz="$(stat -c '%s' $swapfile)"
+old_sz="$(_get_filesize $swapfile)"
 $XFS_IO_PROG -c "fcollapse 66560 1024" $swapfile >> $seqres.full 2>&1
-new_sz="$(stat -c '%s' $swapfile)"
+new_sz="$(_get_filesize $swapfile)"
 if [ $old_sz -gt $new_sz ]; then
 	swapfile_cycle $swapfile
 fi
diff --git a/tests/generic/514 b/tests/generic/514
index 0a71e382..550a6475 100755
--- a/tests/generic/514
+++ b/tests/generic/514
@@ -39,7 +39,7 @@ chmod a+rwx $SCRATCH_MNT
 $XFS_IO_PROG -f -c "pwrite -S 0x18 0 1m" $SCRATCH_MNT/foo >>$seqres.full
 su -s/bin/bash - $qa_user -c "ulimit -f 64 ; $XFS_IO_PROG -f -c \"reflink $SCRATCH_MNT/foo\" $SCRATCH_MNT/bar" >> $seqres.full 2>&1
 
-sz="$(stat -c '%s' $SCRATCH_MNT/bar)"
+sz="$(_get_filesize $SCRATCH_MNT/bar)"
 if [ "$sz" -ne 0 ] && [ "$sz" -ne 65536 ]; then
 	echo "Oddball file size $sz??"
 fi
diff --git a/tests/generic/572 b/tests/generic/572
index 382c4947..2e88302f 100755
--- a/tests/generic/572
+++ b/tests/generic/572
@@ -161,10 +161,10 @@ head -c 100000 /dev/urandom > $fsv_orig_file
 cp $fsv_orig_file $fsv_file
 _fsv_enable $fsv_file >> $seqres.full
 cmp $fsv_file $fsv_orig_file
-stat -c %s $fsv_file
+_get_filesize $fsv_file
 _scratch_cycle_mount
 cmp $fsv_file $fsv_orig_file
-stat -c %s $fsv_file
+_get_filesize $fsv_file
 
 _fsv_scratch_begin_subtest "Trying to measure non-verity file fails with ENODATA"
 echo foo > $fsv_file
diff --git a/tests/overlay/060 b/tests/overlay/060
index 77ff0148..34140e12 100755
--- a/tests/overlay/060
+++ b/tests/overlay/060
@@ -99,7 +99,7 @@ check_file_size()
 {
 	local target=$1 expected_size=$2 actual_size
 
-	actual_size=$(stat -c "%s" $target)
+	actual_size=$(_get_filesize $target)
 
 	[ "$actual_size" == "$expected_size" ] || echo "Expected file size $expected_size but actual size is $actual_size"
 }
diff --git a/tests/xfs/014 b/tests/xfs/014
index 84e4e71a..be470a2d 100755
--- a/tests/xfs/014
+++ b/tests/xfs/014
@@ -53,7 +53,7 @@ _spec_prealloc_file()
 	# write a 4k aligned amount of data to keep the calculations simple
 	$XFS_IO_PROG -c "pwrite 0 128m" $file >> $seqres.full
 
-	size=`stat -c "%s" $file`
+	size=`_get_filesize $file`
 	blocks=`stat -c "%b" $file`
 	blocksize=`stat -c "%B" $file`
 
diff --git a/tests/xfs/076 b/tests/xfs/076
index e8b191c4..2dcdd30c 100755
--- a/tests/xfs/076
+++ b/tests/xfs/076
@@ -93,7 +93,7 @@ _consume_freesp $SCRATCH_MNT/spc
 # space. Note that we start at the end of the file and work backwards as a
 # reverse allocation pattern increases the chances of both left and right sparse
 # record merges.
-offset=`stat -c "%s" $SCRATCH_MNT/spc`
+offset=`_get_filesize $SCRATCH_MNT/spc`
 offset=$((offset - $CHUNK_SIZE * 2))
 while [ $offset -ge 0 ]; do
 	$XFS_IO_PROG -c "fpunch $offset $CHUNK_SIZE" $SCRATCH_MNT/spc \
diff --git a/tests/xfs/306 b/tests/xfs/306
index b56b18f2..edbb6076 100755
--- a/tests/xfs/306
+++ b/tests/xfs/306
@@ -61,7 +61,7 @@ done
 $XFS_IO_PROG -xc "resblks 16" $SCRATCH_MNT >> $seqres.full 2>&1
 dd if=/dev/zero of=$SCRATCH_MNT/file bs=4k >> $seqres.full 2>&1
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/file >> $seqres.full 2>&1
-size=`stat -c %s $SCRATCH_MNT/file`
+size=`_get_filesize $SCRATCH_MNT/file`
 for i in $(seq 0 8192 $size); do
 	$XFS_IO_PROG -c "fpunch $i 4k" $SCRATCH_MNT/file >> $seqres.full 2>&1
 done
-- 
2.18.0.rc1

