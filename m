Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2764689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683560; cv=none; b=FiaSdAj7QDi9bXRkl/wnURTXD4eq1WcPNIbqqNR08gnC/N+e5XEZ+PlKfWwx+OKHViW1grK2w7/sxZGChl1kK2/BJTKxJ7Dyjkalg6sQa1hWybSbs3Hs1PQ07L3K5xOwAmb6x/au02Kqtw+OWSDC4DQX1p7hNlgYCZgnYg46Bkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683560; c=relaxed/simple;
	bh=/aioeyQvFoc6B1SqBzxOODsYSdbUgcHCGBITxzlht9M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBoT9/UhM5DTDXMEgZywXPxfSJYBqqIMPat3WMwJ0GPgJe1gZeRkFbrHWYCrdNSxSzCaQ/9AMlcrH+rG+oN6w2mlJz+l0BIH8xuISZvCt2RUCDZbQ0wDZoM1hXKXSEenn7nTz+GcGOzOpeeYLqcKR+1cX0K6ZPI4X8hhnAGZCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=jvzr+G39; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="jvzr+G39"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ed91d2a245so3458469a91.3
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683558; x=1733288358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0o756Sv1FWMDVCjaqmEybhTcLEwYqubtWxCFzLHBkqk=;
        b=jvzr+G399n6EM7hQOXDkyPrDIFG9DnzgiVM+z75fz7kK1xaEE986bD9BLH/LDvOiLX
         hDqAj+jqFPu4b5BwErv6A8YtvG1SXff7ciM06dFXheUvBVf8Z+CSLUAG3foozoVauQMj
         QhYxjXta+T7xrznxUP5sN8q8EFosaMb6qdrPSxLdtJJwQ4BhhSiYmHlMF5PY0dav9Ivt
         IzO+2Uk2jemZfzhIuvsPISrlqsGvslAfTHrU3SZfcrdBDgLwefkEV4ZEx8jG7b6kBp4I
         H3EMz0u9aYSbeSEDU6khHn3hp96NGSM6f8CJjienfhv16JXV7EvGzMoswlXp0L2QxITY
         hR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683558; x=1733288358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o756Sv1FWMDVCjaqmEybhTcLEwYqubtWxCFzLHBkqk=;
        b=lrJ9bqzEn+3iSP54Afx6gtv0eDQeU2hbJDnaI2jTUFCd1BA6mOMLJsQZB0qSf5B6t9
         hjZjlwtAhwPBCsPxivoKI5nznmI9QTAZPDSW6Mazuxlz60RauOO2P783RMtULCGjDAiK
         I+JmUCLOY3OOm0pCwfC2OZ+KIBSOqOFixnqANBxdBInCs0D5oc5Y25p3LB3J2re8SKxT
         E2rcxHYPSF8jUcv2iK5A6IK8dx43J1kacsAKdG+A7l6KFide7Z2wh3MKJfw5jqSCrABn
         P9zoCL+JX44ucVQl97IU7XasQWA8jvv6tRq2dlI0sIOsWCWFog2X/zv5IDnv792H43NR
         z2vg==
X-Gm-Message-State: AOJu0YzJoQJRaffR7sZPGJFZQkmGvI4fm6eAoi4mn77UbYdnA+5HVZgP
	Q12bZcgEvA4EEW6Bjj8sHXYp1dB58I47pJ2UmlUJ6U8i2m7UWNmbMnj9dUL2MpxR6dYAMUfzLHy
	u
X-Gm-Gg: ASbGncuqKh9ZsFMIgC2yFNr1MQQI0LcZzzNs6wyK9uHwwMM8Y9T0XcTqGsYj8lMkdrU
	+zupiRyRrGgnlqgVvdVrZOmwGL9f8X8SXH7eV81Ywy8dYkWBbPabcwCSVnIBU471CBdQFkaenAl
	1uBDWgN9rmAx+P0NC8wkuLPBAY6hgmYEDBLqtg6KJPwIl9EQQ8MwvQ3uj3Itzg+fDSeAO0fqrmv
	O8XwDEDdaAiQ2n6Nx+r1TNAkBJPwNW30+0ZVmS3nqudQmrmf65zJO9Nh+r5y27Quf0cl2JKc5X/
	1O1pRuKfs39Sgg==
X-Google-Smtp-Source: AGHT+IFPngOa+Iv92XOEVCsfcovFTjhfi2SAvZ7P0IA1zWxb2+UrpyixAx98xvf4EF1/RG5xffDhnA==
X-Received: by 2002:a17:90b:1a8e:b0:2ea:4290:7274 with SMTP id 98e67ed59e1d1-2ee08e9fe02mr2457168a91.10.1732683558431;
        Tue, 26 Nov 2024 20:59:18 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa480e3sm502038a91.17.2024.11.26.20.59.17
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:17 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZV6-1uhf
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQf3-2VLA
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 20/40] fstests: remove uses of killall where possible
Date: Wed, 27 Nov 2024 15:51:50 +1100
Message-ID: <20241127045403.3665299-21-david@fromorbit.com>
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

there are many unnecessary uses of killall and stale checks for it's
existence. Parallel check execution means killall is considered
harmful, so get rid of these unneccesary uses.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/config                |  1 -
 common/fuzzy                 |  6 +++---
 doc/requirement-checking.txt |  6 +++---
 tests/btrfs/192              |  1 -
 tests/btrfs/212              |  2 --
 tests/generic/270            |  1 -
 tests/generic/310            | 22 +++++++++++++++++-----
 tests/generic/751            |  1 -
 tests/overlay/058            | 12 ++++++++----
 tests/xfs/011                |  1 -
 tests/xfs/013                |  1 -
 tests/xfs/051                |  1 -
 tests/xfs/057                |  1 -
 tests/xfs/070                |  9 +++++----
 tests/xfs/079                |  1 -
 tests/xfs/141                |  1 -
 tests/xfs/167                |  3 ---
 tests/xfs/297                |  2 --
 tests/xfs/442                |  1 -
 19 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/common/config b/common/config
index 41b8f29d1..6f531c43d 100644
--- a/common/config
+++ b/common/config
@@ -182,7 +182,6 @@ export CHACL_PROG="$(type -P chacl)"
 export ATTR_PROG="$(type -P attr)"
 export QUOTA_PROG="$(type -P quota)"
 export XFS_QUOTA_PROG="$(type -P xfs_quota)"
-export KILLALL_PROG="$(type -P killall)"
 export INDENT_PROG="$(type -P indent)"
 export XFS_COPY_PROG="$(type -P xfs_copy)"
 export FSTRIM_PROG="$(type -P fstrim)"
diff --git a/common/fuzzy b/common/fuzzy
index 3a7f04aae..534e91ded 100644
--- a/common/fuzzy
+++ b/common/fuzzy
@@ -1188,14 +1188,14 @@ _scratch_xfs_stress_scrub_cleanup() {
 	# a race condition that can hang fstests.
 	#
 	# If the xfs_io -c freeze process is asleep waiting for a write lock on
-	# s_umount or sb_write when the killall signal is delivered, it will
+	# s_umount or sb_write when the kill signal is delivered, it will
 	# not check for pending signals until after it has frozen the fs.  If
 	# even one thread of the stress test processes (xfs_io, fsstress, etc.)
-	# is waiting for read locks on sb_write when the killall signals are
+	# is waiting for read locks on sb_write when the kill signals are
 	# delivered, they will block in the kernel until someone thaws the fs,
 	# and the `wait' below will wait forever.
 	#
-	# Hence we issue the killall, wait for the freezer loop to exit, thaw
+	# Hence we issue the kill, wait for the freezer loop to exit, thaw
 	# the filesystem, and wait for the rest of the children.
 	if [ -n "$__SCRUB_STRESS_FREEZE_PID" ]; then
 		echo "Waiting for fs freezer $__SCRUB_STRESS_FREEZE_PID to exit at $(date)" >> $seqres.full
diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
index 802bf2a3f..78990fe9e 100644
--- a/doc/requirement-checking.txt
+++ b/doc/requirement-checking.txt
@@ -40,11 +40,11 @@ _require_command "$NAME_PROG" name
      should then be used to refer to the command when executing it.  For
      example:
 
-	_require_command "KILLALL_PROG" killall
+	_require_command "$XFS_DB_PROG" "xfs_db"
 
-     to locate the killall command and then:
+     to locate the xfs_db command and then:
 
-	$KILLALL_PROG -q $FSSTRESS_PROG
+	$XFS_DB_PROG -c "sb 0" -c "print" $SCRATCH_DEV
 
      to make use of it.
 
diff --git a/tests/btrfs/192 b/tests/btrfs/192
index cc8e1e003..0a8ab2c1b 100755
--- a/tests/btrfs/192
+++ b/tests/btrfs/192
@@ -27,7 +27,6 @@ _cleanup()
 . ./common/dmlogwrites
 
 
-_require_command "$KILLALL_PROG" killall
 _require_command "$BLKDISCARD_PROG" blkdiscard
 _require_btrfs_fs_feature "no_holes"
 _require_btrfs_mkfs_feature "no-holes"
diff --git a/tests/btrfs/212 b/tests/btrfs/212
index 745b9598a..80c702720 100755
--- a/tests/btrfs/212
+++ b/tests/btrfs/212
@@ -25,8 +25,6 @@ _cleanup()
 . ./common/filter
 
 _require_scratch
-_require_command "$KILLALL_PROG" killall
-
 _scratch_mkfs >> $seqres.full
 _scratch_mount
 
diff --git a/tests/generic/270 b/tests/generic/270
index aff379ac5..342ac8b5d 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -56,7 +56,6 @@ _workout()
 _require_quota
 _require_user
 _require_scratch
-_require_command "$KILLALL_PROG" killall
 _require_command "$SETCAP_PROG" setcap
 _require_attrs security
 
diff --git a/tests/generic/310 b/tests/generic/310
index 15e87aece..1ae9e0233 100755
--- a/tests/generic/310
+++ b/tests/generic/310
@@ -29,14 +29,19 @@ _begin_fstest auto
 # Override the default cleanup function.
 _cleanup()
 {
+	if [ -n "$readdir_pid" ]; then
+		pkill --parent "$readdir_pid" t_readdir > /dev/null 2>&1
+		kill -9 $readdir_pid > /dev/null 2>&1
+		wait
+	fi
 	rm -rf $TEST_DIR/tmp
+	rm -f $tmp.*
 }
 
 # Import common functions.
 . ./common/filter
 
 _require_test
-_require_command "$KILLALL_PROG" killall
 
 dmesg -c > /dev/null
 
@@ -80,9 +85,12 @@ done
 
 _test_read()
 {
-	$here/src/t_readdir_1 $SEQ_DIR &
+	$here/src/t_readdir_1 $SEQ_DIR > /dev/null 2>&1 &
+	readdir_pid=$!
 	sleep $RUN_TIME
-	$KILLALL_PROG t_readdir_1
+	kill $readdir_pid
+	unset readdir_pid
+	wait
 	check_kernel_bug
 	if [ $? -ne 0 ]; then
 		_fatal "kernel bug detected, check dmesg for more infomation."
@@ -91,9 +99,13 @@ _test_read()
 
 _test_lseek()
 {
-	$here/src/t_readdir_2 $SEQ_DIR &
+	$here/src/t_readdir_2 $SEQ_DIR > /dev/null 2>&1 &
+	readdir_pid=$!
 	sleep $RUN_TIME
-	$KILLALL_PROG t_readdir_2
+	kill $readdir_pid
+	unset readdir_pid
+	wait
+
 	check_kernel_bug
 	if [ $? -ne 0 ]; then
 		_fatal "kernel bug detected, check dmesg for more infomation."
diff --git a/tests/generic/751 b/tests/generic/751
index eac2d230a..892e59edf 100755
--- a/tests/generic/751
+++ b/tests/generic/751
@@ -80,7 +80,6 @@ fio_err=$tmp.fio.err
 _require_test
 _require_scratch
 _require_split_huge_pages_knob
-_require_command "$KILLALL_PROG" "killall"
 _fixed_by_git_commit kernel 2a0774c2886d \
 	"XArray: set the marks correctly when splitting an entry"
 
diff --git a/tests/overlay/058 b/tests/overlay/058
index b70e06638..b19a47e36 100755
--- a/tests/overlay/058
+++ b/tests/overlay/058
@@ -21,8 +21,10 @@ _begin_fstest auto quick exportfs
 # Override the default cleanup function.
 _cleanup()
 {
-	$KILLALL_PROG -9 open_by_handle >/dev/null 2>&1
-	wait
+	if [ -n "$pids" ]; then
+		kill -9 $pids >/dev/null 2>&1
+		wait
+	fi
 	cd /
 	rm -f $tmp.*
 }
@@ -36,7 +38,6 @@ _require_test_program "open_by_handle"
 # We need to require all features together, because nfs_export cannot
 # be enabled when index is disabled
 _require_scratch_overlay_features index nfs_export
-_require_command "$KILLALL_PROG" killall
 
 # All overlay dirs are on scratch partition
 lower=$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
@@ -89,9 +90,11 @@ test_file_handles $SCRATCH_MNT -rnp -i $tmp.lower_file_handles
 # overlay dentries in cache
 _scratch_cycle_mount "index=on,nfs_export=on"
 test_file_handles $SCRATCH_MNT -rnps -i $tmp.upper_file_handles &
+pids=$!
 # Give the above 1 second to get to sleep loop
 sleep 1
 test_file_handles $SCRATCH_MNT -rnps -i $tmp.lower_file_handles &
+pids="$pids $!"
 # Give the above 1 second to get to sleep loop
 sleep 1
 
@@ -105,8 +108,9 @@ test_file_handles $SCRATCH_MNT -rnp -i $tmp.upper_file_handles
 test_file_handles $SCRATCH_MNT -rnp -i $tmp.lower_file_handles
 
 # SIGPIPE avoids Terminated/Killed message from bash
-$KILLALL_PROG -q -13 open_by_handle
+kill -13 $pids > /dev/null 2>&1
 wait
+unset pids
 
 status=0
 exit
diff --git a/tests/xfs/011 b/tests/xfs/011
index ed69879c5..1192e75dd 100755
--- a/tests/xfs/011
+++ b/tests/xfs/011
@@ -14,7 +14,6 @@ _begin_fstest auto freeze log metadata quick
 _require_scratch
 _require_freeze
 _require_xfs_sysfs $(_short_dev $TEST_DEV)/log
-_require_command "$KILLALL_PROG" killall
 
 . ./common/filter
 
diff --git a/tests/xfs/013 b/tests/xfs/013
index c68c6ad85..fd3d8c64c 100755
--- a/tests/xfs/013
+++ b/tests/xfs/013
@@ -74,7 +74,6 @@ _cleaner()
 _require_scratch
 _require_xfs_mkfs_finobt
 _require_xfs_finobt
-_require_command "$KILLALL_PROG" killall
 
 _scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | \
 	_filter_mkfs 2>> $seqres.full
diff --git a/tests/xfs/051 b/tests/xfs/051
index bb9c36da8..fe3d75cab 100755
--- a/tests/xfs/051
+++ b/tests/xfs/051
@@ -19,7 +19,6 @@ _begin_fstest shutdown auto log metadata
 _require_scratch
 _require_dm_target flakey
 _require_xfs_sysfs debug/log_recovery_delay
-_require_command "$KILLALL_PROG" killall
 
 echo "Silence is golden."
 
diff --git a/tests/xfs/057 b/tests/xfs/057
index 62eb8b93c..da583e621 100755
--- a/tests/xfs/057
+++ b/tests/xfs/057
@@ -42,7 +42,6 @@ _cleanup()
 _require_xfs_io_error_injection log_item_pin
 _require_xfs_io_error_injection log_bad_crc
 _require_scratch
-_require_command "$KILLALL_PROG" killall
 
 echo "Silence is golden."
 
diff --git a/tests/xfs/070 b/tests/xfs/070
index d2bd7e2c4..143f56888 100755
--- a/tests/xfs/070
+++ b/tests/xfs/070
@@ -24,10 +24,10 @@ _begin_fstest auto quick repair
 # Override the default cleanup function.
 _cleanup()
 {
+	[ -n "$repair_pid" ] && kill -9 $repair_pid > /dev/null 2>&1
+	wait > /dev/null 2>&1
 	cd /
 	rm -f $tmp.*
-	$KILLALL_PROG -9 $XFS_REPAIR_PROG > /dev/null 2>&1
-	wait > /dev/null 2>&1
 }
 
 # Start and monitor an xfs_repair of the scratch device. This test can induce a
@@ -45,7 +45,8 @@ _xfs_repair_noscan()
 	repair_pid=$!
 
 	# monitor progress for as long as it is running
-	while [ `pgrep xfs_repair` ]; do
+	running=`pgrep xfs_repair`
+	while [ -n "$running" ]; do
 		grep "couldn't verify primary superblock" $tmp.repair \
 			> /dev/null 2>&1
 		if [ $? == 0 ]; then
@@ -58,6 +59,7 @@ _xfs_repair_noscan()
 		fi
 
 		sleep 1
+		running=`pgrep xfs_repair`
 	done
 
 	wait
@@ -72,7 +74,6 @@ _xfs_repair_noscan()
 
 # Modify as appropriate.
 _require_scratch_nocheck
-_require_command "$KILLALL_PROG" killall
 
 _scratch_mkfs | _filter_mkfs > /dev/null 2> $tmp.mkfs
 
diff --git a/tests/xfs/079 b/tests/xfs/079
index 794d2db49..4a1999bb8 100755
--- a/tests/xfs/079
+++ b/tests/xfs/079
@@ -23,7 +23,6 @@ _begin_fstest shutdown auto log quick
 # Modify as appropriate.
 _require_scratch
 _require_v2log
-_require_command "$KILLALL_PROG" killall
 
 echo "Silence is golden."
 
diff --git a/tests/xfs/141 b/tests/xfs/141
index b630ba10d..6aa844825 100755
--- a/tests/xfs/141
+++ b/tests/xfs/141
@@ -20,7 +20,6 @@ _begin_fstest auto log metadata
 # Modify as appropriate.
 _require_xfs_io_error_injection "log_bad_crc"
 _require_scratch
-_require_command "$KILLALL_PROG" killall
 
 echo "Silence is golden."
 
diff --git a/tests/xfs/167 b/tests/xfs/167
index 5ef2aa2ea..2a6e6b8d0 100755
--- a/tests/xfs/167
+++ b/tests/xfs/167
@@ -21,10 +21,7 @@ workout()
 # Import common functions.
 . ./common/filter
 
-
-_require_command "$KILLALL_PROG" killall
 _require_xfs_io_command "falloc"
-
 _require_scratch
 _scratch_mkfs_xfs >/dev/null 2>&1
 _scratch_mount
diff --git a/tests/xfs/297 b/tests/xfs/297
index 66c5d0cc7..f9cd2ff12 100755
--- a/tests/xfs/297
+++ b/tests/xfs/297
@@ -24,10 +24,8 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-
 _require_scratch
 _require_freeze
-_require_command "$KILLALL_PROG" killall
 
 logblks=$(_scratch_find_xfs_min_logblocks -d agcount=16,su=256k,sw=12 -l su=256k)
 _scratch_mkfs_xfs -d agcount=16,su=256k,sw=12 -l su=256k,size=${logblks}b >/dev/null 2>&1
diff --git a/tests/xfs/442 b/tests/xfs/442
index d539fa5e0..08f0aac40 100755
--- a/tests/xfs/442
+++ b/tests/xfs/442
@@ -21,7 +21,6 @@ _begin_fstest auto stress clone quota
 
 _require_scratch_reflink
 _require_quota
-_require_command "$KILLALL_PROG" "killall"
 
 report_quota_blocks() {
 	$XFS_QUOTA_PROG -x -c "report $1" $SCRATCH_MNT | \
-- 
2.45.2

