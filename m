Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD38513CFB8
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683256; cv=none; b=XsInbbnSMDS2MUaWtrhRB8EZy38gOVHOB13o9JCpJAHOjWf+AKh229WLx7a/abZVDuQzqaT8fbtIfAdU729RBvdEpDCzfrzK9t+8d1+yUjxwcUxl4DYdwLjfhvTI5gmu/yTqsUsJdcpvicx95npiVuYjF7zt37d0XZb4gjR4dow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683256; c=relaxed/simple;
	bh=DckRhDjs/2NlGG0N/9oDI0PIKIbmlqkGm72E4rgqk+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3g7w8U2HbbfnCMakswo7zjVvxZifJCvK0GlPHMQXM6T0/h+yp1Pvapc39h4KShhzlt+Ka9uUXfzwBXZWT21Ry+VWxD6fw4YnX8kpSu0nqRfzni0PCOfHObr8zn0LbfbVIU5iUekKADe/Y3LFjjjlFFObwl6hxLkhXvCxWRY0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HGIUYgaA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HGIUYgaA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7251abe0e69so2061795b3a.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683253; x=1733288053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDaNBLQxO7qhw0bLUuzh2sc8g1eQoqDd2mupKYSqaRA=;
        b=HGIUYgaA0Cuc681qJXetzgQBjfKNpw4z7Y2GR8UirOAbdSoA2HiOn3TDe/fJH5HscP
         H97h2yjYvnh6mY6V8l1XKvWVuToy2k+E2tvcYdRVHzPF1aqnK6+WRBuJlQ4I7B/MWnE5
         FcyThx3qYsANOuTmyBvD5G6LrPMCyEuFd6h9vjrmUtJIZARisN/+0ucu8G/6g7MO7STn
         N/5wI/hHv1YjGl+2iLLtwSG4hlVwS2CVBfao/xMzcPXjWVeiVnubk5D9XV7eyCO7CvaZ
         KIPQoeSdxlpWGhtMf/YaDFZsfkuVYuIPwCXom6Fpf66R7Bk/3ZfDIvAHP3EV4jjvVqnT
         +8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683253; x=1733288053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDaNBLQxO7qhw0bLUuzh2sc8g1eQoqDd2mupKYSqaRA=;
        b=YSOkjqX5HI5nVRCLqdkr55XRCcKae4mrjCZ7/KFTi4xyB6oYGTMkvHpRbLyI3oS0Nv
         OWKy1KB0yuasaFbIONQPxjlSOO48pzuwwARDxRF20PfWXIEba4AH7KlpYfzaoGzlbXcQ
         BbUbSSUch1HRcT5YDekTYVw92VQYUSyr4FCPOYYWoYLniduM0nQjcktI0jwKdudNfeET
         ohAZRaJhiNgQ2hlt5vJxMxlhkeJKQKh7KKJ3Jot0Y/d4bAkT7p9JehK+Q6haMeyll6UR
         dQgMdz9t91tkPo4P9T3Pr+aCDP70wXEMbB4lsMBWC8cvPgb9L2dRka938poSXJt4Zy3l
         dLSQ==
X-Gm-Message-State: AOJu0YywqCxudRhqdvr/EvvuaSQJKdhlyR7TdW/OipQfEbLBlvk4kX3I
	+wytSLR3bR7vUSUsrqWjZhpNwGrOelgdAfle2TGiW3UHPfcSnlEfdI/u6TwQh+Pj9WyFkY9pDpY
	t
X-Gm-Gg: ASbGncvVuHCWxlVPUtwgSx7jjmOeNjNMnWKj3q8zhYlPb7Al9tLpCHA93sTz4v24Sqj
	LQO6AX6AWrl3kkGYYXWSrtiMslujs/VV834iJaCN23eeGC8NnOSl2iB3kd4d4jlddhMHJVfuEui
	lZAAoUSepoPRt0KyOlvH3Rof4Q9eybZJB9GHBDBZ58lZLwuJyaUYZyzPztdDUkQU4NAuUuoUxDp
	GeO63Oa76yhfPKm3OLrQxSkpliek71RCObZJedGiVVT9pnYRGT8FWA5w23DZmRanu7uVEIUZK0r
	Hb5XYh6TXO6VfsEe45ZpAPcv
X-Google-Smtp-Source: AGHT+IHl6iCsdSp21v6TIR1lb6+xVSDtImCQO5ZbsMK9mAo0hEIsSCOnGklKaJiCPw32oAACMYHxIg==
X-Received: by 2002:a05:6a21:3987:b0:1d9:1a77:3875 with SMTP id adf61e73a8af0-1e0e0b7e159mr2692651637.42.1732683252669;
        Tue, 26 Nov 2024 20:54:12 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de45725dsm9255356b3a.16.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:10 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZUe-0u3L
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQeT-1Kgp
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 13/40] fstests: clean up loop device instantiation
Date: Wed, 27 Nov 2024 15:51:43 +1100
Message-ID: <20241127045403.3665299-14-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127045403.3665299-1-david@fromorbit.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Lots of tests do there own special thing with loop devices rather
than using _create_loop_device() and _destroy_loop_device(). This
oftens means they do not clean up after themselves properly,
leaving stale loop devices around that result in unmountable test or
scratch devices. This is common when tests are killed by user
interrupt.

Even the tests that do use _destroy_loop_device and try to clean up
often do it incorrectly, leading to spurious error messages.

Some tests try to use dynamic instantiation via "mount -o loop",
but then don't clean up in the correct order or hack around to find
the loop device that was instantiated because the test needs to know
the instantiated device name

Clean this up by converting all the tests to use
_create_loop_device() and _destroy_loop_device(). In all the tests,
use the variable "loop_dev" for the device consistently. In
_destroy_loop_device(), test that a device name has been passed
so that we don't try to clean up the same device twice (e.g. once
before test exit and again from the _cleanup() function). When we
destroy a loop device, unset the variable used to hold the loop
device name so that we don't try to destroy it twice.

This results in much more reliable cleanup and clean exit from
fstests when killed by the user.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/metadump   | 32 ++++++++++++--------------------
 tests/generic/067 | 11 ++++++++---
 tests/generic/361 |  6 +++++-
 tests/generic/563 | 14 +++++++++-----
 tests/generic/564 | 12 ++++++------
 tests/generic/590 |  9 ++++++---
 tests/generic/744 |  4 ++--
 tests/generic/746 |  6 +++++-
 tests/xfs/014     |  7 +++++--
 tests/xfs/049     | 35 +++++++++++++++++++++--------------
 tests/xfs/073     | 24 +++++++++++++-----------
 tests/xfs/074     | 21 ++++++++++++---------
 tests/xfs/078     | 16 +++++++++-------
 tests/xfs/148     | 23 ++++++++++++++---------
 tests/xfs/149     |  4 ++++
 tests/xfs/216     | 15 ++++++++++-----
 tests/xfs/217     | 22 ++++++++++++++++------
 tests/xfs/250     | 14 +++++++++-----
 tests/xfs/259     | 13 ++++++++-----
 tests/xfs/513     | 44 ++++++++++++++++++++------------------------
 tests/xfs/521     |  8 ++++++--
 tests/xfs/528     | 10 +++++++---
 tests/xfs/530     | 11 ++++++-----
 tests/xfs/606     | 12 ++++++++----
 tests/xfs/613     | 40 ++++++++++++++--------------------------
 tests/xfs/613.out |  1 -
 26 files changed, 235 insertions(+), 179 deletions(-)

diff --git a/common/metadump b/common/metadump
index 3373edfe9..bc3038e3b 100644
--- a/common/metadump
+++ b/common/metadump
@@ -24,17 +24,9 @@ _xfs_cleanup_verify_metadump()
 
 	test -n "$XFS_METADUMP_FILE" && rm -f "$XFS_METADUMP_FILE"
 
-	if [ -n "$XFS_METADUMP_IMG" ]; then
-		losetup -n -a -O BACK-FILE,NAME | grep "^$XFS_METADUMP_IMG" | while read backing ldev; do
-			losetup -d "$ldev"
-		done
-
-		# Don't call rm directly with a globbed argument here to avoid
-		# issues issues with variable expansions.
-		for img in "$XFS_METADUMP_IMG"*; do
-			test -e "$img" && rm -f "$img"
-		done
-	fi
+	[ -n "$md_data_loop_dev" ] && _destroy_loop_device $md_data_loop_dev
+	[ -n "$md_log_loop_dev" ] && _destroy_loop_device $md_log_loop_dev
+	rm -f $data_img $log_img
 }
 
 # Can xfs_metadump snapshot the fs metadata to a v1 metadump file?
@@ -122,25 +114,25 @@ _xfs_verify_metadump_v2()
 		_scratch_xfs_mdrestore $metadump_file
 
 	# Create loopdev for data device so we can mount the fs
-	data_loop=$(_create_loop_device $data_img)
+	md_data_loop_dev=$(_create_loop_device $data_img)
 
 	# Create loopdev for log device if we recovered anything
-	test -s "$log_img" && log_loop=$(_create_loop_device $log_img)
+	test -s "$log_img" && md_log_loop_dev=$(_create_loop_device $log_img)
 
 	# Mount fs, run an extra test, fsck, and unmount
-	SCRATCH_DEV=$data_loop SCRATCH_LOGDEV=$log_loop _scratch_mount
+	SCRATCH_DEV=$md_data_loop_dev SCRATCH_LOGDEV=$md_log_loop_dev _scratch_mount
 	if [ -n "$extra_test" ]; then
-		SCRATCH_DEV=$data_loop SCRATCH_LOGDEV=$log_loop $extra_test
+		SCRATCH_DEV=$md_data_loop_dev SCRATCH_LOGDEV=$md_log_loop_dev $extra_test
 	fi
-	SCRATCH_DEV=$data_loop SCRATCH_LOGDEV=$log_loop _check_xfs_scratch_fs
-	SCRATCH_DEV=$data_loop _scratch_unmount
+	SCRATCH_DEV=$md_data_loop_dev SCRATCH_LOGDEV=$md_log_loop_dev _check_xfs_scratch_fs
+	_unmount $md_data_loop_dev
 
 	# Tear down what we created
-	if [ -b "$log_loop" ]; then
-		_destroy_loop_device $log_loop
+	if [ -b "$md_log_loop_dev" ]; then
+		_destroy_loop_device $md_log_loop_dev
 		rm -f $log_img
 	fi
-	_destroy_loop_device $data_loop
+	_destroy_loop_device $md_data_loop_dev
 	rm -f $data_img
 }
 
diff --git a/tests/generic/067 b/tests/generic/067
index ccb1e3fbb..b45ae834f 100755
--- a/tests/generic/067
+++ b/tests/generic/067
@@ -37,13 +37,18 @@ mount_nonexistent_mnt()
 	$MOUNT_PROG $SCRATCH_DEV $TEST_DIR/nosuchdir >>$seqres.full 2>&1
 }
 
-# fs driver should be able to handle mounting a free loop device gracefully
-# xfs ever hung, "ec53d1d xfs: don't block on buffer read errors" fixed it
+# fs driver should be able to handle mounting a free loop device gracefully xfs
+# ever hung, "ec53d1d xfs: don't block on buffer read errors" fixed it
+#
+# Using 'losetup -f' like this is racy. We might end up mounting a real loop dev
+# here, so unmount $SCRATCH_MNT (not the loop dev we might not own!) and ignore
+# any error it might return.
 mount_free_loopdev()
 {
 	echo "# mount a free loop device" >>$seqres.full
 	loopdev=`losetup -f`
-	$MOUNT_PROG -t $FSTYP $loopdev $SCRATCH_MNT >>$seqres.full 2>&1
+	_mount $loopdev $SCRATCH_MNT >>$seqres.full 2>&1
+	_unmount $SCRATCH_MNT >> /dev/null 2>&1
 }
 
 # mount with wrong fs type specified.
diff --git a/tests/generic/361 b/tests/generic/361
index 7273dd056..e2b798436 100755
--- a/tests/generic/361
+++ b/tests/generic/361
@@ -17,7 +17,7 @@ _begin_fstest auto quick
 _cleanup()
 {
 	_unmount $fs_mnt
-	_destroy_loop_device $loop_dev
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
 	cd /
 	rm -f $tmp.*
 }
@@ -54,6 +54,10 @@ $XFS_IO_PROG -fc "pwrite 0 520m" $fs_mnt/testfile >>$seqres.full 2>&1
 # remount should not hang
 $MOUNT_PROG -o remount,ro $fs_mnt >>$seqres.full 2>&1
 
+_unmount $fs_mnt
+_destroy_loop_device $loop_dev
+unset loop_dev
+
 # success, all done
 echo "Silence is golden"
 status=0
diff --git a/tests/generic/563 b/tests/generic/563
index f0d2f404c..34d21170c 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -87,12 +87,12 @@ reset()
 
 # cgroup I/O accounting doesn't work on partitions. Use a loop device to rule
 # that out.
-LOOP_DEV=$(_create_loop_device $SCRATCH_DEV)
-smajor=$((0x`stat -L -c %t $LOOP_DEV`))
-sminor=$((0x`stat -L -c %T $LOOP_DEV`))
+loop_dev=$(_create_loop_device $SCRATCH_DEV)
+smajor=$((0x`stat -L -c %t $loop_dev`))
+sminor=$((0x`stat -L -c %T $loop_dev`))
 
-_mkfs_dev $LOOP_DEV >> $seqres.full 2>&1
-_mount $LOOP_DEV $SCRATCH_MNT || _fail "mount failed"
+_mkfs_dev $loop_dev >> $seqres.full 2>&1
+_mount $loop_dev $SCRATCH_MNT || _fail "mount failed"
 
 blksize=$(_get_block_size "$SCRATCH_MNT")
 
@@ -147,6 +147,10 @@ if [ "$drop_io_cgroup" = 1 ]; then
 	echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
 fi
 
+_unmount $SCRATCH_MNT
+_destroy_loop_device $loop_dev
+unset loop_dev
+
 # success, all done
 status=0
 exit
diff --git a/tests/generic/564 b/tests/generic/564
index 647472d78..b66b72496 100755
--- a/tests/generic/564
+++ b/tests/generic/564
@@ -19,7 +19,7 @@ _cleanup()
 {
 	cd /
 	rm -rf $tmp.*
-	[ -z "$loopdev" ] || _destroy_loop_device $loopdev
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
 }
 
 # Import common functions.
@@ -72,11 +72,11 @@ $XFS_IO_PROG -f -c "copy_range -l 32k $testdir" $testdir/copy
 echo
 echo source/destination as blkdev returns EINVAL
 $XFS_IO_PROG -f -c "truncate 128k" $testdir/img >> $seqres.full 2>&1
-loopdev=`_create_loop_device $testdir/img`
-$XFS_IO_PROG -c "copy_range -l 32k $testdir/file" $loopdev
-$XFS_IO_PROG -f -c "copy_range -l 32k $loopdev" $testdir/copy
-_destroy_loop_device $loopdev
-loopdev=
+loop_dev=`_create_loop_device $testdir/img`
+$XFS_IO_PROG -c "copy_range -l 32k $testdir/file" $loop_dev
+$XFS_IO_PROG -f -c "copy_range -l 32k $loop_dev" $testdir/copy
+_destroy_loop_device $loop_dev
+unset loop_dev
 
 echo
 echo source/destination as chardev returns EINVAL
diff --git a/tests/generic/590 b/tests/generic/590
index 2b7ccfb53..2eefa2c62 100755
--- a/tests/generic/590
+++ b/tests/generic/590
@@ -15,9 +15,10 @@ _begin_fstest auto prealloc preallocrw
 # Override the default cleanup function.
 _cleanup()
 {
+	_scratch_unmount
+	[ -n $loop_dev ] && _destroy_loop_device $loop_dev
 	cd /
 	rm -f $tmp.*
-	test -n "$loop" && _destroy_loop_device "$loop"
 	rm -f "$TEST_DIR/$seq"
 }
 
@@ -56,9 +57,9 @@ if [[ $FSTYP = xfs ]]; then
 		loopsz="$((filesz + (1 << 26)))"
 		_require_fs_space "$TEST_DIR" $((loopsz / 1024))
 		$XFS_IO_PROG -c "truncate $loopsz" -f "$TEST_DIR/$seq"
-		loop="$(_create_loop_device "$TEST_DIR/$seq")"
+		loop_dev="$(_create_loop_device "$TEST_DIR/$seq")"
 		USE_EXTERNAL=yes
-		SCRATCH_RTDEV="$loop"
+		SCRATCH_RTDEV="$loop_dev"
 		disabled_features=()
 
 		# disable reflink if not supported by realtime devices
@@ -114,6 +115,8 @@ $XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
 # We need to do this before the loop device gets torn down.
 _scratch_unmount
 _check_scratch_fs
+_destroy_loop_device $loop_dev
+unset loop_dev
 
 echo "Silence is golden"
 status=0
diff --git a/tests/generic/744 b/tests/generic/744
index df8f6ae9b..cda10e0f6 100755
--- a/tests/generic/744
+++ b/tests/generic/744
@@ -17,8 +17,8 @@ _cleanup()
 
 	_unmount $mnt2 &> /dev/null
 	_unmount $mnt1 &> /dev/null
-	[ -b "$loop_dev2" ] && losetup -d $loop_dev2
-	[ -b "$loop_dev1" ] && losetup -d $loop_dev1
+	[ -b "$loop_dev2" ] && _destroy_loop_device $loop_dev2
+	[ -b "$loop_dev1" ] && _destroy_loop_device $loop_dev1
 	[ -n "$seq" ] && rm -rf $TEST_DIR/$seq
 }
 
diff --git a/tests/generic/746 b/tests/generic/746
index 671910606..ba8ed25e8 100755
--- a/tests/generic/746
+++ b/tests/generic/746
@@ -39,7 +39,7 @@ esac
 _cleanup()
 {
 	_unmount $loop_mnt &> /dev/null
-	_destroy_loop_device $loop_dev
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
 	if [ $status -eq 0 ]; then
 		rm -rf $tmp
 		rm $img_file
@@ -223,5 +223,9 @@ while read line; do
 done < $fiemap_after
 echo "done."
 
+_unmount $loop_mnt
+_destroy_loop_device $loop_dev
+unset loop_dev
+
 status=0
 exit
diff --git a/tests/xfs/014 b/tests/xfs/014
index f638e4b16..39ea40e2a 100755
--- a/tests/xfs/014
+++ b/tests/xfs/014
@@ -23,6 +23,7 @@ _cleanup()
 {
 	cd /
 	_unmount $LOOP_MNT 2>/dev/null
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
 	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
@@ -166,19 +167,21 @@ LOOP_FILE=$SCRATCH_MNT/$seq.fs
 LOOP_MNT=$SCRATCH_MNT/$seq.mnt
 
 $MKFS_XFS_PROG -d "file=1,name=$LOOP_FILE,size=10g" >> $seqres.full 2>&1
+loop_dev=$(_create_loop_device $LOOP_FILE)
 
 mkdir -p $LOOP_MNT
-_mount -o uquota,gquota $LOOP_FILE $LOOP_MNT || \
+_mount -o uquota,gquota $loop_dev $LOOP_MNT || \
 	_fail "Failed to mount loop fs."
 
 _test_enospc $LOOP_MNT
 _test_edquot $LOOP_MNT
 
 _unmount $LOOP_MNT
+_destroy_loop_device $loop_dev
+unset loop_dev
 
 echo $orig_sp_time > /proc/sys/fs/xfs/speculative_prealloc_lifetime
 
 _scratch_unmount
-
 status=0
 exit
diff --git a/tests/xfs/049 b/tests/xfs/049
index 4163a144f..cdcddf764 100755
--- a/tests/xfs/049
+++ b/tests/xfs/049
@@ -12,16 +12,17 @@ _begin_fstest rw auto quick
 # Override the default cleanup function.
 _cleanup()
 {
-    cd /
-    umount $SCRATCH_MNT/test2 > /dev/null 2>&1
-    umount $SCRATCH_MNT/test > /dev/null 2>&1
-    rm -f $tmp.*
+	cd /
+	_unmount $SCRATCH_MNT/test2 > /dev/null 2>&1
+	_unmount $SCRATCH_MNT/test > /dev/null 2>&1
+	[ -n "$loop_dev2" ] && _destroy_loop_device $loop_dev2
+	[ -n "$loop_dev1" ] && _destroy_loop_device $loop_dev1
+	rm -f $tmp.*
 
-    if [ -w $seqres.full ]
-    then
-        echo "--- mounts at end (after cleanup)" >> $seqres.full
-        mount >> $seqres.full
-    fi
+	if [ -w $seqres.full ]; then
+		echo "--- mounts at end (after cleanup)" >> $seqres.full
+		mount >> $seqres.full
+	fi
 }
 
 # Import common functions.
@@ -64,7 +65,8 @@ mkdir $SCRATCH_MNT/test $SCRATCH_MNT/test2 >> $seqres.full 2>&1 \
     || _fail "!!! failed to make mount points"
 
 _log "Mount xfs via loop"
-mount -t xfs -o loop $SCRATCH_MNT/test.xfs $SCRATCH_MNT/test >> $seqres.full 2>&1 \
+loop_dev1=$(_create_loop_device $SCRATCH_MNT/test.xfs)
+_mount $loop_dev1 $SCRATCH_MNT/test >> $seqres.full 2>&1 \
     || _fail "!!! failed to loop mount xfs"
 
 _log "stress"
@@ -80,11 +82,12 @@ dd if=/dev/zero of=$SCRATCH_MNT/test/test.ext2 bs=1024 count=10240 >> $seqres.fu
     || _fail "!!! create file failed"
 
 _log "Create ext2 fs in file on looped xfs"
-echo y | mkfs -t ext2 $SCRATCH_MNT/test/test.ext2 >> $seqres.full 2>&1 \
+loop_dev2=$(_create_loop_device $SCRATCH_MNT/test/test.ext2)
+echo y | mkfs -t ext2 $loop_dev2 >> $seqres.full 2>&1 \
     || _fail "!!! failed to mkfs ext2 on xfs"
 
 _log "Mount ext2 on xfs via loop"
-mount -t ext2 -o loop $SCRATCH_MNT/test/test.ext2 $SCRATCH_MNT/test2 >> $seqres.full 2>&1 \
+_mount $loop_dev2 $SCRATCH_MNT/test2 >> $seqres.full 2>&1 \
     || _fail "!!! failed to loop mount xfs"
 
 _log "stress ext2 on xfs via loop"
@@ -96,12 +99,16 @@ rm -rf $SCRATCH_MNT/test/* >> $seqres.full 2>&1 \
     || _fail "!!! clean failed"
 
 _log "umount ext2 on xfs"
-umount $SCRATCH_MNT/test2 >> $seqres.full 2>&1 \
+_unmount $SCRATCH_MNT/test2 >> $seqres.full 2>&1 \
     || _fail "!!! umount ext2 failed"
+_destroy_loop_device $loop_dev2
+unset loop_dev2
 
 _log "umount xfs"
-umount $SCRATCH_MNT/test >> $seqres.full 2>&1 \
+_unmount $SCRATCH_MNT/test >> $seqres.full 2>&1 \
     || _fail "!!! umount xfs failed"
+_destroy_loop_device $loop_dev1
+unset loop_dev1
 
 echo "--- mounts at end (before cleanup)" >> $seqres.full
 mount >> $seqres.full
diff --git a/tests/xfs/073 b/tests/xfs/073
index e4b17c5e7..2274079ef 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -23,6 +23,8 @@ _cleanup()
 	_scratch_unmount 2>/dev/null
 	_unmount $imgs.loop 2>/dev/null
 	_unmount $imgs.source_dir 2>/dev/null
+	[ -n "$loop_dev1" ] && _destroy_loop_device $loop_dev1
+	[ -n "$loop_dev2" ] && _destroy_loop_device $loop_dev2
 	[ -d $imgs.loop ] && rmdir $imgs.loop
 	[ -d $imgs.source_dir ] && rm -rf $imgs.source_dir
 	rm -f $imgs.* $tmp.* /var/tmp/xfs_copy.log.*
@@ -65,10 +67,11 @@ _verify_copy()
 	rmdir $target_dir 2>/dev/null
 	mkdir $target_dir
 
-	_mount -t xfs -o loop $target $target_dir 2>/dev/null
+	loop_dev1=$(_create_loop_device $target)
+	_mount $loop_dev1 $target_dir 2>/dev/null
 	if [ $? -ne 0 ]; then
 		echo retrying mount with nouuid option >>$seqres.full
-		_mount -t xfs -o loop -o nouuid $target $target_dir
+		_mount -o nouuid $loop_dev1 $target_dir
 		if [ $? -ne 0 ]; then
 			echo mount failed - evil!
 			return
@@ -100,6 +103,8 @@ _verify_copy()
 	echo unmounting and removing new image
 	_unmount $source_dir
 	_unmount $target_dir > /dev/null 2>&1
+	_destroy_loop_device $loop_dev1
+	unset loop_dev1
 	rm -f $target
 }
 
@@ -134,18 +139,15 @@ ${MKFS_XFS_PROG} -dfile,name=$imgs.source,size=100g \
 rmdir $imgs.source_dir 2>/dev/null
 mkdir $imgs.source_dir
 
-_mount -t xfs -o loop $imgs.source $imgs.source_dir
-loop2=`mount | grep $imgs.source | grep -o -e 'loop=.*[^),]' | grep -o -e '/.*$'`
+loop_dev2=$(_create_loop_device $imgs.source)
+_mount $loop_dev2 $imgs.source_dir
 cp -a $here $imgs.source_dir
-_mount -t xfs -o remount,ro $imgs.source $imgs.source_dir
-$XFS_COPY_PROG $imgs.source $imgs.image | _filter_copy '#' $imgs.image '#' '#'
+_mount -o remount,ro $loop_dev2 $imgs.source_dir
+$XFS_COPY_PROG $loop_dev2 $imgs.image 2> /dev/null | _filter_copy '#' $imgs.image '#' '#'
 _verify_copy $imgs.image $imgs.source $imgs.source_dir
 
-# HACK WARNING:
-#
-# We're done with the nested loop mount, now we have to clean
-# up the pieces that mount is incapable of doing.
-losetup -d $loop2 > /dev/null 2>&1
+_destroy_loop_device $loop_dev2
+unset loop_dev2
 
 echo
 echo === copying scratch device to multiple targets
diff --git a/tests/xfs/074 b/tests/xfs/074
index 6a03c8111..5df864fad 100755
--- a/tests/xfs/074
+++ b/tests/xfs/074
@@ -26,7 +26,7 @@ _begin_fstest quick auto prealloc rw
 _cleanup()
 {
 	cd /
-	_destroy_loop_device $LOOP_DEV
+	[ -n "$loop_dev" ] &&_destroy_loop_device $loop_dev
 	rm -f $tmp.* $LOOP_FILE
 }
 
@@ -45,10 +45,10 @@ LOOP_FILE=$TEST_DIR/$seq.img
 LOOP_MNT=$TEST_DIR/$seq.mnt
 mkdir -p $LOOP_MNT
 $XFS_IO_PROG -ft -c "truncate 1t" $LOOP_FILE >> $seqres.full
-LOOP_DEV=`_create_loop_device $LOOP_FILE`
+loop_dev=`_create_loop_device $LOOP_FILE`
 
-_mkfs_dev -d size=260g,agcount=2 $LOOP_DEV
-_mount $LOOP_DEV $LOOP_MNT
+_mkfs_dev -d size=260g,agcount=2 $loop_dev
+_mount $loop_dev $LOOP_MNT
 
 BLOCK_SIZE=$(_get_file_block_size $LOOP_MNT)
 
@@ -59,11 +59,11 @@ $XFS_IO_PROG -ft \
 	-c "falloc 0 $(($BLOCK_SIZE * 2097152))" \
 	$LOOP_MNT/foo >> $seqres.full
 
-umount $LOOP_MNT
-_check_xfs_filesystem $LOOP_DEV none none
+_unmount $LOOP_MNT
+_check_xfs_filesystem $loop_dev none none
 
-_mkfs_dev -f $LOOP_DEV
-_mount $LOOP_DEV $LOOP_MNT
+_mkfs_dev -f $loop_dev
+_mount $loop_dev $LOOP_MNT
 
 # check we trim both ends of the extent approproiately; this will fail
 # on 1k block size filesystems without the correct fixes in place.
@@ -73,7 +73,10 @@ $XFS_IO_PROG -ft \
 	$LOOP_MNT/foo >> $seqres.full
 
 _unmount $LOOP_MNT
-_check_xfs_filesystem $LOOP_DEV none none
+_check_xfs_filesystem $loop_dev none none
+
+_destroy_loop_device $loop_dev
+unset loop_dev
 
 # success, all done
 echo "Silence is golden"
diff --git a/tests/xfs/078 b/tests/xfs/078
index 6b325e05f..0d3c2eb23 100755
--- a/tests/xfs/078
+++ b/tests/xfs/078
@@ -17,7 +17,7 @@ _cleanup()
 	cd /
 	rm -f $tmp.*
 	_unmount $LOOP_MNT 2>/dev/null
-	[ -n "$LOOP_DEV" ] && _destroy_loop_device $LOOP_DEV 2>/dev/null
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev 2>/dev/null
 	# try to keep the image file if test fails
 	[ $status -eq 0 ] && rm -f $LOOP_IMG
 	rmdir $LOOP_MNT
@@ -55,7 +55,7 @@ _grow_loop()
 	agsize=$5
 
 	$XFS_IO_PROG -f -c "truncate $original" $LOOP_IMG
-	LOOP_DEV=`_create_loop_device $LOOP_IMG`
+	loop_dev=`_create_loop_device $LOOP_IMG`
 
 	dparam=""
 	if [ -n "$agsize" ]; then
@@ -67,15 +67,15 @@ _grow_loop()
 	echo
 
 	echo "*** mkfs loop file (size=$original)"
-	$MKFS_XFS_PROG -b size=$bsize $dparam $LOOP_DEV | \
+	$MKFS_XFS_PROG -b size=$bsize $dparam $loop_dev | \
 		_filter_mkfs 2>/dev/null
 
 	echo "*** extend loop file"
-	_destroy_loop_device $LOOP_DEV
+	_destroy_loop_device $loop_dev
 	$XFS_IO_PROG -c "pwrite $new_size $bsize" $LOOP_IMG | _filter_io
-	LOOP_DEV=`_create_loop_device $LOOP_IMG`
+	loop_dev=`_create_loop_device $LOOP_IMG`
 	echo "*** mount loop filesystem"
-	_mount -t xfs $LOOP_DEV $LOOP_MNT
+	_mount $loop_dev $LOOP_MNT
 
 	echo "*** grow loop filesystem"
 	$XFS_GROWFS_PROG $LOOP_MNT 2>&1 |  _filter_growfs 2>&1
@@ -87,9 +87,11 @@ _grow_loop()
 	if [ "$check" -gt "0" ]
 	then
 		echo "*** check"
-		_check_xfs_filesystem $LOOP_IMG none none
+		_check_xfs_filesystem $loop_dev none none
 	fi
 
+	_destroy_loop_device $loop_dev
+	unset loop_dev
 	rm -f $LOOP_IMG
 }
 
diff --git a/tests/xfs/148 b/tests/xfs/148
index c42c9b119..4d2f7a808 100755
--- a/tests/xfs/148
+++ b/tests/xfs/148
@@ -15,7 +15,7 @@ _cleanup()
 {
 	cd /
 	_unmount $mntpt > /dev/null 2>&1
-	_destroy_loop_device $loopdev > /dev/null 2>&1
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
 	rm -r -f $tmp.*
 }
 
@@ -48,12 +48,12 @@ rm -f $imgfile $imgfile.old
 # even when security xattrs are present so we are always doing name matches on
 # lookup and not name hash compares as leaf/node forms will do.
 $XFS_IO_PROG -f -c 'truncate 40m' $imgfile
-loopdev=$(_create_loop_device $imgfile)
-MKFS_OPTIONS="-m crc=0 -i size=512" _mkfs_dev $loopdev >> $seqres.full
+loop_dev=$(_create_loop_device $imgfile)
+MKFS_OPTIONS="-m crc=0 -i size=512" _mkfs_dev $loop_dev >> $seqres.full
 
 # Mount image file
 mkdir -p $mntpt
-_mount $loopdev $mntpt
+_mount $loop_dev $mntpt
 
 echo "creating entries" >> $seqres.full
 
@@ -91,7 +91,8 @@ cat $tmp.log | _filter_test_dir
 
 # Corrupt the entries
 _unmount $mntpt
-_destroy_loop_device $loopdev
+_destroy_loop_device $loop_dev
+unset loop_dev
 cp $imgfile $imgfile.old
 sed -b \
 	-e "s/$nullstr/too_many\x00beans/g" \
@@ -99,8 +100,9 @@ sed -b \
 	-i $imgfile
 test "$(md5sum < $imgfile)" != "$(md5sum < $imgfile.old)" ||
 	_fail "sed failed to change the image file?"
-loopdev=$(_create_loop_device $imgfile)
-_mount $loopdev $mntpt
+
+loop_dev=$(_create_loop_device $imgfile)
+_mount $loop_dev $mntpt
 
 # Try to access the corrupt metadata
 echo "++ ACCESSING BAD METADATA" | tee -a $seqres.full
@@ -111,7 +113,7 @@ cat $tmp.log | _filter_test_dir | sed -e '/Could not list/d'
 echo "does scrub complain?" >> $seqres.full
 
 # Does scrub complain about this?
-if _supports_xfs_scrub $mntpt $loopdev; then
+if _supports_xfs_scrub $mntpt $loop_dev; then
 	$XFS_SCRUB_PROG -n $mntpt >> $seqres.full 2>&1
 	res=$?
 	test $((res & 1)) -eq 0 && \
@@ -122,11 +124,14 @@ echo "does repair complain?" >> $seqres.full
 
 # Does repair complain about this?
 _unmount $mntpt
-$XFS_REPAIR_PROG -n $loopdev >> $seqres.full 2>&1
+$XFS_REPAIR_PROG -n $loop_dev >> $seqres.full 2>&1
 res=$?
 test $res -eq 1 || \
 	echo "repair failed to report corruption ($res)"
 
+_destroy_loop_device $loop_dev
+unset loop_dev
+
 # success, all done
 status=0
 exit
diff --git a/tests/xfs/149 b/tests/xfs/149
index f2187109b..9a96f82ed 100755
--- a/tests/xfs/149
+++ b/tests/xfs/149
@@ -84,6 +84,10 @@ $XFS_GROWFS_PROG -D 16384 $loop_symlink > /dev/null
 echo "=== xfs_growfs - check device node ==="
 $XFS_GROWFS_PROG -D 20480 $loop_dev > /dev/null
 
+_unmount $mntdir
+_destroy_loop_device $loop_dev
+unset loop_dev
+
 # success, all done
 status=0
 exit
diff --git a/tests/xfs/216 b/tests/xfs/216
index 6b8b2eb22..091c11d08 100755
--- a/tests/xfs/216
+++ b/tests/xfs/216
@@ -15,6 +15,7 @@ _begin_fstest log metadata auto quick
 _cleanup()
 {
 	_unmount $LOOP_MNT > /dev/null 2>&1
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
 	cd /
 	rm -f $tmp.*
 }
@@ -24,7 +25,7 @@ _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
 
 _require_loop
-LOOP_DEV=$SCRATCH_MNT/test_fs
+LOOP_IMG=$SCRATCH_MNT/test_fs
 LOOP_MNT=$SCRATCH_MNT/test_fs_dir
 
 loop_mkfs_opts=
@@ -55,22 +56,26 @@ _do_mkfs()
 	for i in $*; do
 		echo -n "fssize=${i}g "
 		$MKFS_XFS_PROG -f -b size=4096 -l version=2 \
-			-d name=$LOOP_DEV,size=${i}g $loop_mkfs_opts |grep log
-		_mount -o loop -t xfs $LOOP_DEV $LOOP_MNT
+			-d size=${i}g $loop_mkfs_opts $loop_dev |grep log
+		_mount $loop_dev $LOOP_MNT
 		echo "test write" > $LOOP_MNT/test
 		_unmount $LOOP_MNT > /dev/null 2>&1
 	done
 }
 # make large holey file
-$XFS_IO_PROG -f -c "truncate 256g" $LOOP_DEV
+$XFS_IO_PROG -f -c "truncate 256g" $LOOP_IMG
 
-choose_golden_output $0 $LOOP_DEV
+choose_golden_output $0 $LOOP_IMG
 
 #make loopback mount dir
 mkdir $LOOP_MNT
 
+loop_dev=$(_create_loop_device $LOOP_IMG)
+
 # walk over standard sizes (up to 256GB)
 _do_mkfs 1 2 4 8 16 32 64 128 256
 
+_destroy_loop_device $loop_dev
+unset loop_dev
 status=0
 exit
diff --git a/tests/xfs/217 b/tests/xfs/217
index b2eb34490..dae6ce55f 100755
--- a/tests/xfs/217
+++ b/tests/xfs/217
@@ -12,6 +12,12 @@ _begin_fstest log metadata auto
 # Import common functions.
 . ./common/filter
 
+_cleanup()
+{
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
+	cd /
+	rm -f $tmp.*
+}
 
 _require_scratch
 _scratch_mkfs_xfs >/dev/null 2>&1
@@ -20,7 +26,7 @@ _scratch_mount
 _require_fs_space $SCRATCH_MNT 2202000
 
 _require_loop
-LOOP_DEV=$SCRATCH_MNT/test_fs
+LOOP_IMG=$SCRATCH_MNT/test_fs
 LOOP_MNT=$SCRATCH_MNT/test_fs_dir
 
 _do_mkfs()
@@ -28,28 +34,30 @@ _do_mkfs()
 	for i in $*; do
 		echo -n "fssize=${i}g "
 		$MKFS_XFS_PROG -f -b size=4096 -l version=2 \
-			-d name=$LOOP_DEV,size=${i}g |grep log
-		_mount -o loop -t xfs $LOOP_DEV $LOOP_MNT
+			-d size=${i}g $loop_dev |grep log
+		_mount $loop_dev $LOOP_MNT
 		echo "test write" > $LOOP_MNT/test
 		_unmount $LOOP_MNT > /dev/null 2>&1
 
 		# punch out the previous blocks so that we keep the amount of
 		# disk space the test requires down to a minimum.
-		$XFS_IO_PROG -f -c "unresvsp 0 16383g" $LOOP_DEV
+		$XFS_IO_PROG -f -c "unresvsp 0 16383g" $LOOP_IMG
 	done
 }
 # make large holey file
-$XFS_IO_PROG -f -c "truncate 16383g" $LOOP_DEV
+$XFS_IO_PROG -f -c "truncate 16383g" $LOOP_IMG
 
 #make loopback mount dir
 mkdir $LOOP_MNT
 
 # test if large logs are supported
-$MKFS_XFS_PROG -f -l size=256m -d name=$LOOP_DEV,size=10g > /dev/null 2>&1
+$MKFS_XFS_PROG -f -l size=256m -d name=$LOOP_IMG,size=10g > /dev/null 2>&1
 if [ $? -ne 0 ]; then
 	_notrun "large log sizes not supported by mkfs"
 fi
 
+loop_dev=$(_create_loop_device $LOOP_IMG)
+
 #
 # walk over "new" sizes supported by recent xfsprogs.
 # Note that the last test is for 16TB-1GB as 32bit platforms only support
@@ -57,5 +65,7 @@ fi
 #
 _do_mkfs 512 1024 2048 4096 8192 16383
 
+_destroy_loop_device $loop_dev
+unset loop_dev
 status=0
 exit
diff --git a/tests/xfs/250 b/tests/xfs/250
index 4e3473ebc..2554e1e91 100755
--- a/tests/xfs/250
+++ b/tests/xfs/250
@@ -14,7 +14,8 @@ _cleanup()
 {
 	cd /
 	_unmount $LOOP_MNT 2>/dev/null
-	rm -f $LOOP_DEV
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
+	rm -f $LOOP_IMG
 	rmdir $LOOP_MNT
 	rm -f $tmp.*
 }
@@ -26,7 +27,7 @@ _require_test
 _require_loop
 _require_xfs_io_command "falloc"
 
-LOOP_DEV=$TEST_DIR/$seq.fs
+LOOP_IMG=$TEST_DIR/$seq.fs
 LOOP_MNT=$TEST_DIR/$seq.mnt
 
 _filter_io()
@@ -45,7 +46,7 @@ _test_loop()
 	agsize=$2
 	fsize=$3
 
-	dparam="file,name=$LOOP_DEV,size=$size"
+	dparam="file,name=$LOOP_IMG,size=$size"
 	if [ -n "$agsize" ]; then
 		dparam="$dparam,agsize=$agsize"
 	fi
@@ -55,7 +56,8 @@ _test_loop()
 		| _filter_mkfs 2>/dev/null
 
 	echo "*** mount loop filesystem"
-	_mount -t xfs -o loop $LOOP_DEV $LOOP_MNT
+	loop_dev=$(_create_loop_device $LOOP_IMG)
+	mount $loop_dev $LOOP_MNT
 
 	echo "*** preallocate large file"
 	$XFS_IO_PROG -f -c "resvsp 0 $fsize" $LOOP_MNT/foo | _filter_io
@@ -64,7 +66,9 @@ _test_loop()
 	_unmount $LOOP_MNT > /dev/null 2>&1
 
 	echo "*** check loop filesystem"
-	 _check_xfs_filesystem $LOOP_DEV none none
+	_check_xfs_filesystem $loop_dev none none
+	_destroy_loop_device $loop_dev
+	unset loop_dev
 }
 
 _test_loop 50g 16m 40G
diff --git a/tests/xfs/259 b/tests/xfs/259
index 0c8d6eb56..c2d26381a 100755
--- a/tests/xfs/259
+++ b/tests/xfs/259
@@ -12,7 +12,10 @@ _begin_fstest auto quick
 # Override the default cleanup function.
 _cleanup()
 {
-    rm -f "$testfile"
+	[ -n "$loop_dev" ] && _destroy_loop_device $testfile
+	rm -f "$testfile"
+	cd /
+	rm -f $tmp.*
 }
 
 # Import common functions.
@@ -45,13 +48,13 @@ for del in $sizes_to_check; do
 		rm -f "$testfile"
 		dd if=/dev/zero "of=$testfile" bs=1 count=0 seek=$ddseek \
 			>/dev/null 2>&1 || echo "dd failed"
-		lofile=$(losetup -f)
-		losetup $lofile "$testfile"
-		$MKFS_XFS_PROG -l size=32m -b size=$bs $lofile |  _filter_mkfs \
+		loop_dev=$(_create_loop_device $testfile)
+		$MKFS_XFS_PROG -l size=32m -b size=$bs $loop_dev |  _filter_mkfs \
 			>/dev/null 2> $tmp.mkfs || echo "mkfs failed!"
 		. $tmp.mkfs
 		sync
-		losetup -d $lofile
+		_destroy_loop_device $loop_dev
+		unset loop_dev
 	done
 done
 
diff --git a/tests/xfs/513 b/tests/xfs/513
index 5895e6e2d..0c0edc75e 100755
--- a/tests/xfs/513
+++ b/tests/xfs/513
@@ -15,12 +15,8 @@ _cleanup()
 	cd /
 	rm -f $tmp.*
 	_unmount $LOOP_MNT 2>/dev/null
-	if [ -n "$LOOP_DEV" ];then
-		_destroy_loop_device $LOOP_DEV 2>/dev/null
-	fi
-	if [ -n "$LOOP_SPARE_DEV" ];then
-		_destroy_loop_device $LOOP_SPARE_DEV 2>/dev/null
-	fi
+	[ -n $loop_dev ] &&_destroy_loop_device $loop_dev
+	[ -n $loop_spare_dev ] &&_destroy_loop_device $loop_spare_dev
 	rm -f $LOOP_IMG
 	rm -f $LOOP_SPARE_IMG
 	rmdir $LOOP_MNT
@@ -42,11 +38,11 @@ LOOP_MNT=$TEST_DIR/$seq.mnt
 
 echo "** create loop device"
 $XFS_IO_PROG -f -c "truncate 32g" $LOOP_IMG
-LOOP_DEV=`_create_loop_device $LOOP_IMG`
+loop_dev=`_create_loop_device $LOOP_IMG`
 
 echo "** create loop log device"
 $XFS_IO_PROG -f -c "truncate 1g" $LOOP_SPARE_IMG
-LOOP_SPARE_DEV=`_create_loop_device $LOOP_SPARE_IMG`
+loop_spare_dev=`_create_loop_device $LOOP_SPARE_IMG`
 
 echo "** create loop mount point"
 rmdir $LOOP_MNT 2>/dev/null
@@ -55,8 +51,8 @@ mkdir -p $LOOP_MNT || _fail "cannot create loopback mount point"
 filter_loop()
 {
 	sed -e "s,\B$LOOP_MNT,LOOP_MNT,g" \
-	    -e "s,\B$LOOP_DEV,LOOP_DEV,g" \
-	    -e "s,\B$LOOP_SPARE_DEV,LOOP_SPARE_DEV,g"
+	    -e "s,\B$loop_dev,LOOP_DEV,g" \
+	    -e "s,\B$loop_spare_dev,LOOP_SPARE_DEV,g"
 }
 
 filter_xfs_opt()
@@ -69,22 +65,22 @@ MKFS_OPTIONS=""
 do_mkfs()
 {
 	echo "FORMAT: $@" | filter_loop | tee -a $seqres.full
-	$MKFS_XFS_PROG -f $* $LOOP_DEV | _filter_mkfs >>$seqres.full 2>$tmp.mkfs
+	$MKFS_XFS_PROG -f $* $loop_dev | _filter_mkfs >>$seqres.full 2>$tmp.mkfs
 	if [ "${PIPESTATUS[0]}" -ne 0 ]; then
-		_fail "Fails on _mkfs_dev $* $LOOP_DEV"
+		_fail "Fails on _mkfs_dev $* $loop_dev"
 	fi
 	. $tmp.mkfs
 }
 
 is_dev_mounted()
 {
-	findmnt --source $LOOP_DEV >/dev/null
+	findmnt --source $loop_dev >/dev/null
 	return $?
 }
 
 get_mount_info()
 {
-	findmnt --source $LOOP_DEV -o OPTIONS -n
+	findmnt --source $loop_dev -o OPTIONS -n
 }
 
 force_unmount()
@@ -103,29 +99,29 @@ _do_test()
 	local info
 
 	# mount test
-	_mount $LOOP_DEV $LOOP_MNT $opts 2>>$seqres.full
+	_mount $loop_dev $LOOP_MNT $opts 2>>$seqres.full
 	rc=$?
 	if [ $rc -eq 0 ];then
 		if [ "${mounted}" = "fail" ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: expect mount to fail, but it succeeded"
 			return 1
 		fi
 		is_dev_mounted
 		if [ $? -ne 0 ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: fs not mounted even mount return 0"
 			return 1
 		fi
 	else
 		if [ "${mounted}" = "pass" ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: expect mount to succeed, but it failed"
 			return 1
 		fi
 		is_dev_mounted
 		if [ $? -eq 0 ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: fs is mounted even mount return non-zero"
 			return 1
 		fi
@@ -141,13 +137,13 @@ _do_test()
 	rc=$?
 	if [ $rc -eq 0 ];then
 		if [ "$found" != "true" ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: expected to find \"$key\" in mount info \"$info\""
 			return 1
 		fi
 	else
 		if [ "$found" != "false" ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: did not expect to find \"$key\" in \"$info\""
 			return 1
 		fi
@@ -253,9 +249,9 @@ do_test "-o logbsize=512k" fail
 # Test logdev
 do_mkfs
 do_test "" pass "logdev" "false"
-do_test "-o logdev=$LOOP_SPARE_DEV" fail
-do_mkfs -l logdev=$LOOP_SPARE_DEV
-do_test "-o logdev=$LOOP_SPARE_DEV" pass "logdev=$LOOP_SPARE_DEV" "true"
+do_test "-o logdev=$loop_spare_dev" fail
+do_mkfs -l logdev=$loop_spare_dev
+do_test "-o logdev=$loop_spare_dev" pass "logdev=$loop_spare_dev" "true"
 do_test "" fail
 
 # Test noalign
diff --git a/tests/xfs/521 b/tests/xfs/521
index 13982c440..c92c621a2 100755
--- a/tests/xfs/521
+++ b/tests/xfs/521
@@ -21,7 +21,7 @@ _cleanup()
 {
 	cd /
 	_scratch_unmount >> $seqres.full 2>&1
-	test -e "$rtdev" && losetup -d $rtdev >> $seqres.full 2>&1
+	[ -n "$rt_loop_dev" ] && _destroy_loop_device $rt_loop_dev
 	rm -f $tmp.* $TEST_DIR/$seq.rtvol
 }
 
@@ -35,7 +35,7 @@ _require_no_large_scratch_dev
 
 echo "Create fake rt volume"
 truncate -s 400m $TEST_DIR/$seq.rtvol
-rtdev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
+rt_loop_dev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
 
 echo "Format and mount 100m rt volume"
 export USE_EXTERNAL=yes
@@ -69,6 +69,10 @@ cp -p $testdir/original $testdir/copy3
 echo "Check filesystem"
 _check_scratch_fs
 
+_scratch_unmount
+_destroy_loop_device $rt_loop_dev
+unset rt_loop_dev
+
 # success, all done
 status=0
 exit
diff --git a/tests/xfs/528 b/tests/xfs/528
index 6ca9a2370..a1efbbd27 100755
--- a/tests/xfs/528
+++ b/tests/xfs/528
@@ -15,7 +15,7 @@ _cleanup()
 {
 	cd /
 	_scratch_unmount >> $seqres.full 2>&1
-	test -e "$rtdev" && losetup -d $rtdev >> $seqres.full 2>&1
+	[ -n "$rt_loop_dev" ] && _destroy_loop_device $rt_loop_dev
 	rm -f $tmp.* $TEST_DIR/$seq.rtvol
 }
 
@@ -155,11 +155,11 @@ test_ops() {
 
 echo "Create fake rt volume"
 $XFS_IO_PROG -f -c "truncate 400m" $TEST_DIR/$seq.rtvol
-rtdev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
+rt_loop_dev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
 
 echo "Make sure synth rt volume works"
 export USE_EXTERNAL=yes
-export SCRATCH_RTDEV=$rtdev
+export SCRATCH_RTDEV=$rt_loop_dev
 _scratch_mkfs > $seqres.full
 _try_scratch_mount || \
 	_notrun "Could not mount with synthetic rt volume"
@@ -170,6 +170,10 @@ test_ops 262144
 # not a power of two
 test_ops 327680
 
+_scratch_unmount
+_destroy_loop_device $rt_loop_dev
+unset rt_loop_dev
+
 # success, all done
 status=0
 exit
diff --git a/tests/xfs/530 b/tests/xfs/530
index 8a182bd6a..d0d0e2665 100755
--- a/tests/xfs/530
+++ b/tests/xfs/530
@@ -15,7 +15,7 @@ _cleanup()
 {
 	cd /
 	_scratch_unmount >> $seqres.full 2>&1
-	test -e "$rtdev" && losetup -d $rtdev >> $seqres.full 2>&1
+	[ -n "$rt_loop_dev" ] && _destroy_loop_device $rt_loop_dev
 	rm -f $tmp.* $TEST_DIR/$seq.rtvol
 }
 
@@ -52,12 +52,12 @@ fi
 
 rtdevsz=$((nr_bits * rtextsz))
 truncate -s $rtdevsz $TEST_DIR/$seq.rtvol
-rtdev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
+rt_loop_dev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
 
 echo "Format and mount rt volume"
 
 export USE_EXTERNAL=yes
-export SCRATCH_RTDEV=$rtdev
+export SCRATCH_RTDEV=$rt_loop_dev
 _scratch_mkfs -d size=$((1024 * 1024 * 1024)) \
 	      -r size=${rtextsz},extsize=${rtextsz} >> $seqres.full
 _try_scratch_mount || _notrun "Couldn't mount fs with synthetic rt volume"
@@ -116,8 +116,9 @@ done
 echo "Check filesystem"
 _check_scratch_fs
 
-losetup -d $rtdev
-rm -f $TEST_DIR/$seq.rtvol
+_scratch_unmount
+_destroy_loop_device $rt_loop_dev
+unset rt_loop_dev
 
 # success, all done
 status=0
diff --git a/tests/xfs/606 b/tests/xfs/606
index f958bddd8..b537ea145 100755
--- a/tests/xfs/606
+++ b/tests/xfs/606
@@ -13,10 +13,8 @@ _begin_fstest auto quick growfs
 
 _cleanup()
 {
-	local dev
 	_unmount $LOOP_MNT 2>/dev/null
-	dev=$(losetup -j testfile | cut -d: -f1)
-	losetup -d $dev 2>/dev/null
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
 	rm -rf $LOOP_IMG $LOOP_MNT
 	cd /
 	rm -f $tmp.*
@@ -40,7 +38,9 @@ $MKFS_XFS_PROG -f $LOOP_IMG >$seqres.full
 # Extend by just 8K, expected to start with the last full-size AG ends of
 # above 1G block device.
 $XFS_IO_PROG -f -c "truncate 1073750016" $LOOP_IMG
-_mount -oloop $LOOP_IMG $LOOP_MNT
+
+loop_dev=$(_create_loop_device $LOOP_IMG)
+_mount $loop_dev $LOOP_MNT
 # A known bug shows "XFS_IOC_FSGROWFSDATA xfsctl failed: No space left on
 # device" at here, refer to _fixed_by_kernel_commit above
 $XFS_GROWFS_PROG $LOOP_MNT >$seqres.full
@@ -48,6 +48,10 @@ if [ $? -ne 0 ];then
 	echo "xfs_growfs fails!"
 fi
 
+_unmount $LOOP_MNT
+_destroy_loop_device $loop_dev
+unset loop_dev
+
 echo "Silence is golden"
 # success, all done
 status=0
diff --git a/tests/xfs/613 b/tests/xfs/613
index 6ba3d87bf..b87cae91e 100755
--- a/tests/xfs/613
+++ b/tests/xfs/613
@@ -15,14 +15,8 @@ _cleanup()
 	cd /
 	rm -f $tmp.*
 	_unmount $LOOP_MNT 2>/dev/null
-	if [ -n "$LOOP_DEV" ];then
-		_destroy_loop_device $LOOP_DEV 2>/dev/null
-	fi
-	if [ -n "$LOOP_SPARE_DEV" ];then
-		_destroy_loop_device $LOOP_SPARE_DEV 2>/dev/null
-	fi
+	[ -n $loop_dev ] &&_destroy_loop_device $loop_dev
 	rm -f $LOOP_IMG
-	rm -f $LOOP_SPARE_IMG
 	rmdir $LOOP_MNT
 }
 
@@ -38,16 +32,11 @@ _require_loop
 _require_xfs_io_command "falloc"
 
 LOOP_IMG=$TEST_DIR/$seq.dev
-LOOP_SPARE_IMG=$TEST_DIR/$seq.logdev
 LOOP_MNT=$TEST_DIR/$seq.mnt
 
 echo "** create loop device"
 $XFS_IO_PROG -f -c "truncate 32g" $LOOP_IMG
-LOOP_DEV=`_create_loop_device $LOOP_IMG`
-
-echo "** create loop log device"
-$XFS_IO_PROG -f -c "truncate 1g" $LOOP_SPARE_IMG
-LOOP_SPARE_DEV=`_create_loop_device $LOOP_SPARE_IMG`
+loop_dev=`_create_loop_device $LOOP_IMG`
 
 echo "** create loop mount point"
 rmdir $LOOP_MNT 2>/dev/null
@@ -56,8 +45,7 @@ mkdir -p $LOOP_MNT || _fail "cannot create loopback mount point"
 filter_loop()
 {
 	sed -e "s,\B$LOOP_MNT,LOOP_MNT,g" \
-	    -e "s,\B$LOOP_DEV,LOOP_DEV,g" \
-	    -e "s,\B$LOOP_SPARE_DEV,LOOP_SPARE_DEV,g"
+	    -e "s,\B$loop_dev,LOOP_DEV,g"
 }
 
 filter_xfs_opt()
@@ -70,22 +58,22 @@ MKFS_OPTIONS=""
 do_mkfs()
 {
 	echo "FORMAT: $@" | filter_loop | tee -a $seqres.full
-	$MKFS_XFS_PROG -f $* $LOOP_DEV | _filter_mkfs >>$seqres.full 2>$tmp.mkfs
+	$MKFS_XFS_PROG -f $* $loop_dev | _filter_mkfs >>$seqres.full 2>$tmp.mkfs
 	if [ "${PIPESTATUS[0]}" -ne 0 ]; then
-		_fail "Fails on _mkfs_dev $* $LOOP_DEV"
+		_fail "Fails on _mkfs_dev $* $loop_dev"
 	fi
 	. $tmp.mkfs
 }
 
 is_dev_mounted()
 {
-	findmnt --source $LOOP_DEV >/dev/null
+	findmnt --source $loop_dev >/dev/null
 	return $?
 }
 
 get_mount_info()
 {
-	findmnt --source $LOOP_DEV -o OPTIONS -n
+	findmnt --source $loop_dev -o OPTIONS -n
 }
 
 force_unmount()
@@ -104,29 +92,29 @@ _do_test()
 	local info
 
 	# mount test
-	_mount $LOOP_DEV $LOOP_MNT $opts 2>>$seqres.full
+	_mount $loop_dev $LOOP_MNT $opts 2>>$seqres.full
 	rc=$?
 	if [ $rc -eq 0 ];then
 		if [ "${mounted}" = "fail" ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: expect mount to fail, but it succeeded"
 			return 1
 		fi
 		is_dev_mounted
 		if [ $? -ne 0 ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: fs not mounted even mount return 0"
 			return 1
 		fi
 	else
 		if [ "${mounted}" = "pass" ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: expect mount to succeed, but it failed"
 			return 1
 		fi
 		is_dev_mounted
 		if [ $? -eq 0 ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: fs is mounted even mount return non-zero"
 			return 1
 		fi
@@ -142,13 +130,13 @@ _do_test()
 	rc=$?
 	if [ $rc -eq 0 ];then
 		if [ "$found" != "true" ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: expected to find \"$key\" in mount info \"$info\""
 			return 1
 		fi
 	else
 		if [ "$found" != "false" ];then
-			echo "[FAILED]: mount $LOOP_DEV $LOOP_MNT $opts"
+			echo "[FAILED]: mount $loop_dev $LOOP_MNT $opts"
 			echo "ERROR: did not expect to find \"$key\" in \"$info\""
 			return 1
 		fi
diff --git a/tests/xfs/613.out b/tests/xfs/613.out
index 1624617ee..2a693c53c 100644
--- a/tests/xfs/613.out
+++ b/tests/xfs/613.out
@@ -1,6 +1,5 @@
 QA output created by 613
 ** create loop device
-** create loop log device
 ** create loop mount point
 ** start xfs mount testing ...
 FORMAT: -m crc=0
-- 
2.45.2

