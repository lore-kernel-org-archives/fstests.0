Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC213D518
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683257; cv=none; b=XRSKdLPtVID33Ontk8Zo7Wtv3y38nzGUJQkfZsmyIBg/OjpyzKFicgJE7fdogrGz1DwaUt3q0KJBgbIErY6G0Rixg6H28tbwK8aI0L8LBCqvoT9YoLR+SQFsAcwCxgmFymGHADGUEgZbgIKADxswMWdfKEN2/Pm+WLtZlrAW4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683257; c=relaxed/simple;
	bh=MinR9SLx2+HYuNc5PpG33kxYhJF+oCkH9ld9ubI3juY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu2y/n2xytO8KB2GSboeHXkb/OyQoDPZ2Kh3AZq9CGOj836cFvZaiEV/A5sJoJp8+n6KvHO0wXFYk4uk+BNrbNAH5DVb67Iey1JikKcsLtWal40+D+hSzHzzF7JKYIDEDhlFMErXo6cfUHH6ODvJqSmCGym/SY5Tu0t93w5y3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Nc6v0qAt; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Nc6v0qAt"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71d5fddef37so555438a34.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683253; x=1733288053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlYOOQi3LBzeiPZZz70g4V5HovvqpPLZ362Jl1DFWzA=;
        b=Nc6v0qAtnwupNV8Jmy/Qio7KvFrJ9zU6uEbNk1PB+S/qc5q5itTC+h5D3vpAoHamLr
         0KA61n0c2WpccqQFaJCgsqIwk5uTrRYYXY/2yycRL7fY6O4mkhG8dirhnMpULz6xYoHk
         07RpotB/tshUv1uXNFiD0vP5xFTgnUjOO35s9PrTHjX2X3P7qkVrMklYrnxSX06exZfn
         VBQw927YFxzZxV3iLb+/y9VY/SE5yBvY0zGsQkVUsAi71LtMVWd3qxPzTMvbpdgsqOM6
         oChLMGTRtWCscmDZ3a4ywUcn0wOiYuHd+N3uxOJW5mcKkxkoFq1Ww+Reaz2eWhGteLrZ
         csEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683253; x=1733288053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlYOOQi3LBzeiPZZz70g4V5HovvqpPLZ362Jl1DFWzA=;
        b=ZjgNz2kRmM0XPlj/Gr8AjTAeOSwUKRS3JK7AtWhsKvEc+Gvef1G5Uvy079Um/oX0CY
         hkfyN62L949P1ih21BdQ2BD7nI4Pn+v2WvmI2pz3spMYr9goF/OHFeJYZYeCA7spCAD1
         4oHNLMmlUimCdsNuyj4iCihcxFVDINzOvGY05GQXiBbdORc1LLRsAswpTlMKASNwfinZ
         9GwjEmnKRFayb7jTBFdGNo/XsGEKIua0Oel9aUp2iOHf0EAG3FpxJsFrg1Hg+bK+Gt9b
         sroyu5YQ5LmEu1a85m83q//DlqthW6dGB675KlbWJGVOV0WqbmmVqaICOdvFHNu7eDO4
         7L5Q==
X-Gm-Message-State: AOJu0YwKvtUPCOjSUJU32rXKENWMkvRBVAXjoINn9+LnleAQfIlEBOBc
	q0npPlAUoFL8q5mhVpuXtWIm3VB+qAlcqQpJ608i8nxuuCGu789G0l7atvk8B7jzuAYGnHrp4aE
	4
X-Gm-Gg: ASbGnct0yAv398SYlXdRRGOfyTbCq4Hzrb2ZQlPnqAWD5klYwhVmNEIgrjuoxr/kXFj
	NRZZnvIri3x2YHaUDXTyw/PHpmGVDt3DcQM5fT3GVY8GChTcD6YJCCUW2zh7bVdgVjtAjl/lgPR
	/iPyroDv/WEBGanjOozO1aO0JJkZyZpKrB58jQ7HC91wwqCKDlPIahNE/jebMXxyLOFcd9Z+YYS
	XQ4RQK5ri9lQeEfik9lKM6MtD139NYmNusueCaYAUKVnKd2cwrhoCugNPb+urq9mnZ4oDuWqaxj
	ao7tk1S+Hg27kVf1+GiwUStF
X-Google-Smtp-Source: AGHT+IG1VK/YeKeN3dki9kcangs0uLLuFK9EZZwV0ON0DC/DH67II8w3fEwP3hMPMiqViJz1fEZ3fg==
X-Received: by 2002:a05:6830:2655:b0:71d:572f:66c3 with SMTP id 46e09a7af769-71d65d0983dmr1598233a34.30.1732683253167;
        Tue, 26 Nov 2024 20:54:13 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc3e26sm8297600a12.9.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:10 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZUa-0gEs
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQeO-19Mf
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 12/40] fstests: clean up mount and unmount operations
Date: Wed, 27 Nov 2024 15:51:42 +1100
Message-ID: <20241127045403.3665299-13-david@fromorbit.com>
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

The way tests run unmount is, at times, completely random.
Sometimes they call the correct _scratch_unmount function, sometimes
they open code it with a direct call to UMOUNT_PROG <dir>, sometimes
they run umount directly.

This makes it really hard to instrument unmount operations when
trying to work out why transient, unpredictable failures like
this occur randomly during a test run:

umount: /mnt/xfs/runner-17/test: target is busy.

Sometimes it happens on a test device mount, sometimes a scratch
device mount.  Sometimes it happens to a test specific dm or loop
device mount. But without instrumenting every single unmount call in
every test, it's impossible to capture these failures easily.

Solve this problem by introducing the _unmount() wrapper. It is
simply a call to UMOUNT_PROG <dir>, but it provides a single point
were -every- unmount operation funnels through.

We already have a _mount wrapper for this reason. However, in trying
to work out why mounts were failing (because unmounts were failing),
I discovered that that_mount() is used inconsistently as well.

Sort this all out by adding and _unmount() wrapper to go with
_mount() and use them everywhere consistently.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/btrfs       |  4 ++--
 common/dmdelay     |  4 ++--
 common/dmdust      |  4 ++--
 common/dmerror     |  4 ++--
 common/dmflakey    |  4 ++--
 common/dmhugedisk  |  2 +-
 common/dmlogwrites |  4 ++--
 common/dmthin      |  4 ++--
 common/overlay     | 10 +++++-----
 common/populate    |  8 ++++----
 common/rc          | 42 +++++++++++++++++++++++++-----------------
 tests/generic/042  |  4 ++--
 tests/generic/050  |  3 ++-
 tests/generic/067  |  6 +++---
 tests/generic/081  |  2 +-
 tests/generic/085  |  6 +++---
 tests/generic/108  |  2 +-
 tests/generic/171  |  2 +-
 tests/generic/172  |  2 +-
 tests/generic/173  |  2 +-
 tests/generic/174  |  2 +-
 tests/generic/306  |  2 +-
 tests/generic/332  |  2 +-
 tests/generic/361  |  2 +-
 tests/generic/373  |  2 +-
 tests/generic/374  |  2 +-
 tests/generic/395  |  2 +-
 tests/generic/459  |  2 +-
 tests/generic/563  | 10 +++++-----
 tests/generic/604  |  2 +-
 tests/generic/631  |  2 +-
 tests/generic/648  |  6 +++---
 tests/generic/698  |  4 ++--
 tests/generic/699  |  8 ++++----
 tests/generic/704  |  2 +-
 tests/generic/717  |  2 +-
 tests/generic/730  |  2 +-
 tests/generic/731  |  2 +-
 tests/generic/732  |  4 ++--
 tests/generic/741  |  2 +-
 tests/generic/744  |  6 +++---
 tests/generic/746  |  8 ++++----
 tests/xfs/014      |  6 +++---
 tests/xfs/073      | 20 ++++++++++----------
 tests/xfs/074      |  2 +-
 tests/xfs/078      |  6 +++---
 tests/xfs/148      |  6 +++---
 tests/xfs/149      |  4 ++--
 tests/xfs/186      |  4 ++--
 tests/xfs/216      | 10 ++++++++--
 tests/xfs/217      |  4 ++--
 tests/xfs/250      |  7 ++++---
 tests/xfs/289      |  4 ++--
 tests/xfs/507      |  2 +-
 tests/xfs/513      |  4 ++--
 tests/xfs/544      |  2 +-
 tests/xfs/606      |  2 +-
 tests/xfs/613      |  4 ++--
 58 files changed, 149 insertions(+), 133 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 95a9c8e6c..4a2c9886e 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -352,7 +352,7 @@ _btrfs_stress_subvolume()
 	while [ ! -e $stop_file ]; do
 		$BTRFS_UTIL_PROG subvolume create $btrfs_mnt/$subvol_name
 		$MOUNT_PROG -o subvol=$subvol_name $btrfs_dev $subvol_mnt
-		$UMOUNT_PROG $subvol_mnt
+		_unmount $subvol_mnt
 		$BTRFS_UTIL_PROG subvolume delete $btrfs_mnt/$subvol_name
 	done
 }
@@ -368,7 +368,7 @@ _btrfs_kill_stress_subvolume_pid()
 	# Ignore if process already died.
 	wait $subvol_pid &> /dev/null
 	rm -f $stop_file
-	$UMOUNT_PROG $subvol_mnt &> /dev/null
+	_unmount $subvol_mnt &> /dev/null
 }
 
 # stress btrfs by running scrub in a loop
diff --git a/common/dmdelay b/common/dmdelay
index 1c4fca6e9..848afb993 100644
--- a/common/dmdelay
+++ b/common/dmdelay
@@ -28,7 +28,7 @@ _mount_delay()
 
 _unmount_delay()
 {
-	$UMOUNT_PROG $SCRATCH_MNT
+	_unmount $SCRATCH_MNT
 }
 
 _cleanup_delay()
@@ -36,7 +36,7 @@ _cleanup_delay()
 	# If dmsetup load fails then we need to make sure to do resume here
 	# otherwise the umount will hang
 	$DMSETUP_PROG resume $DELAY_NAME > /dev/null 2>&1
-	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	_unmount $SCRATCH_MNT > /dev/null 2>&1
 	_dmsetup_remove $DELAY_NAME
 }
 
diff --git a/common/dmdust b/common/dmdust
index 37bb865c8..55bbc84db 100644
--- a/common/dmdust
+++ b/common/dmdust
@@ -24,7 +24,7 @@ _mount_dust()
 
 _unmount_dust()
 {
-	$UMOUNT_PROG $SCRATCH_MNT
+	_unmount $SCRATCH_MNT
 }
 
 _cleanup_dust()
@@ -32,6 +32,6 @@ _cleanup_dust()
 	# If dmsetup load fails then we need to make sure to do resume here
 	# otherwise the umount will hang
 	$DMSETUP_PROG resume $DUST_NAME > /dev/null 2>&1
-	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	_unmount $SCRATCH_MNT > /dev/null 2>&1
 	_dmsetup_remove $DUST_NAME
 }
diff --git a/common/dmerror b/common/dmerror
index 97796b38e..309129c03 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -101,7 +101,7 @@ _dmerror_mount()
 
 _dmerror_unmount()
 {
-	umount $SCRATCH_MNT
+	_unmount $SCRATCH_MNT
 }
 
 _dmerror_cleanup()
@@ -110,7 +110,7 @@ _dmerror_cleanup()
 	test -n "$NON_ERROR_RTDEV" && $DMSETUP_PROG resume $DMERROR_RTNAME &>/dev/null
 	$DMSETUP_PROG resume $DMERROR_NAME > /dev/null 2>&1
 
-	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	_unmount $SCRATCH_MNT > /dev/null 2>&1
 
 	test -n "$NON_ERROR_LOGDEV" && _dmsetup_remove $DMERROR_LOGNAME
 	test -n "$NON_ERROR_RTDEV" && _dmsetup_remove $DMERROR_RTNAME
diff --git a/common/dmflakey b/common/dmflakey
index 75a0a67c8..7368a3e5b 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -71,7 +71,7 @@ _mount_flakey()
 
 _unmount_flakey()
 {
-	$UMOUNT_PROG $SCRATCH_MNT
+	_unmount $SCRATCH_MNT
 }
 
 _cleanup_flakey()
@@ -82,7 +82,7 @@ _cleanup_flakey()
 	test -n "$NON_FLAKEY_RTDEV" && $DMSETUP_PROG resume $FLAKEY_RTNAME &> /dev/null
 	$DMSETUP_PROG resume flakey-test > /dev/null 2>&1
 
-	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	_unmount $SCRATCH_MNT > /dev/null 2>&1
 
 	_dmsetup_remove $FLAKEY_NAME
 	test -n "$NON_FLAKEY_LOGDEV" && _dmsetup_remove $FLAKEY_LOGNAME
diff --git a/common/dmhugedisk b/common/dmhugedisk
index 0757e1908..2d23f436c 100644
--- a/common/dmhugedisk
+++ b/common/dmhugedisk
@@ -42,7 +42,7 @@ _dmhugedisk_init()
 
 _dmhugedisk_cleanup()
 {
-	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	_unmount $SCRATCH_MNT > /dev/null 2>&1
 	_dmsetup_remove $DMHUGE_TEST
 	_dmsetup_remove $DMHUGE_TEST_ZERO
 }
diff --git a/common/dmlogwrites b/common/dmlogwrites
index c1c85de9d..a27e1966a 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -110,7 +110,7 @@ _log_writes_mount()
 
 _log_writes_unmount()
 {
-	$UMOUNT_PROG $SCRATCH_MNT
+	_unmount $SCRATCH_MNT
 }
 
 # _log_writes_replay_log <mark>
@@ -141,7 +141,7 @@ _log_writes_remove()
 
 _log_writes_cleanup()
 {
-	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	_unmount $SCRATCH_MNT > /dev/null 2>&1
 	_log_writes_remove
 }
 
diff --git a/common/dmthin b/common/dmthin
index f2c00f5a7..453e43a04 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -23,7 +23,7 @@ DMTHIN_VOL_DEV="/dev/mapper/$DMTHIN_VOL_NAME"
 
 _dmthin_cleanup()
 {
-	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	_unmount $SCRATCH_MNT > /dev/null 2>&1
 	_dmsetup_remove $DMTHIN_VOL_NAME
 	_dmsetup_remove $DMTHIN_POOL_NAME
 	_dmsetup_remove $DMTHIN_META_NAME
@@ -32,7 +32,7 @@ _dmthin_cleanup()
 
 _dmthin_check_fs()
 {
-	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	_unmount $SCRATCH_MNT > /dev/null 2>&1
 	_check_scratch_fs $DMTHIN_VOL_DEV
 }
 
diff --git a/common/overlay b/common/overlay
index faa9339a6..01b6622f5 100644
--- a/common/overlay
+++ b/common/overlay
@@ -142,18 +142,18 @@ _overlay_base_unmount()
 
 	[ -n "$dev" -a -n "$mnt" ] || return 0
 
-	$UMOUNT_PROG $mnt
+	_unmount $mnt
 }
 
 _overlay_test_unmount()
 {
-	$UMOUNT_PROG $TEST_DIR
+	_unmount $TEST_DIR
 	_overlay_base_unmount "$OVL_BASE_TEST_DEV" "$OVL_BASE_TEST_DIR"
 }
 
 _overlay_scratch_unmount()
 {
-	$UMOUNT_PROG $SCRATCH_MNT
+	_unmount $SCRATCH_MNT
 	_overlay_base_unmount "$OVL_BASE_SCRATCH_DEV" "$OVL_BASE_SCRATCH_MNT"
 }
 
@@ -342,7 +342,7 @@ _overlay_check_scratch_dirs()
 
 	# Need to umount overlay for scratch dir check
 	local ovl_mounted=`_is_dir_mountpoint $SCRATCH_MNT`
-	[ -z "$ovl_mounted" ] || $UMOUNT_PROG $SCRATCH_MNT
+	[ -z "$ovl_mounted" ] || _unmount $SCRATCH_MNT
 
 	# Check dirs with extra overlay options
 	_overlay_check_dirs $lowerdir $upperdir $workdir $*
@@ -387,7 +387,7 @@ _overlay_check_fs()
 	else
 		# Check and umount overlay for dir check
 		ovl_mounted=`_is_dir_mountpoint $ovl_mnt`
-		[ -z "$ovl_mounted" ] || $UMOUNT_PROG $ovl_mnt
+		[ -z "$ovl_mounted" ] || _unmount $ovl_mnt
 	fi
 
 	_overlay_check_dirs $base_mnt/$OVL_LOWER $base_mnt/$OVL_UPPER \
diff --git a/common/populate b/common/populate
index 88c8ba2b3..4cf9c0691 100644
--- a/common/populate
+++ b/common/populate
@@ -517,7 +517,7 @@ _scratch_xfs_populate() {
 	__populate_fragment_file "${SCRATCH_MNT}/RTRMAPBT"
 	__populate_fragment_file "${SCRATCH_MNT}/REFCOUNTBT"
 
-	umount "${SCRATCH_MNT}"
+	_scratch_unmount
 }
 
 # Populate an ext4 on the scratch device with (we hope) all known
@@ -619,7 +619,7 @@ _scratch_ext4_populate() {
 	# Make sure we get all the fragmentation we asked for
 	__populate_fragment_file "${SCRATCH_MNT}/S_IFREG.FMT_ETREE"
 
-	umount "${SCRATCH_MNT}"
+	_scratch_unmount
 }
 
 # Find the inode number of a file
@@ -772,7 +772,7 @@ _scratch_xfs_populate_check() {
 	dblksz="$(_xfs_get_dir_blocksize "$SCRATCH_MNT")"
 	leaf_lblk="$((32 * 1073741824 / blksz))"
 	node_lblk="$((64 * 1073741824 / blksz))"
-	umount "${SCRATCH_MNT}"
+	_scratch_unmount
 
 	__populate_check_xfs_dformat "${extents_file}" "extents"
 	__populate_check_xfs_dformat "${btree_file}" "btree"
@@ -885,7 +885,7 @@ _scratch_ext4_populate_check() {
 	extents_slink="$(__populate_find_inode "${SCRATCH_MNT}/S_IFLNK.FMT_EXTENTS")"
 	local_attr="$(__populate_find_inode "${SCRATCH_MNT}/ATTR.FMT_LOCAL")"
 	block_attr="$(__populate_find_inode "${SCRATCH_MNT}/ATTR.FMT_BLOCK")"
-	umount "${SCRATCH_MNT}"
+	_scratch_unmount
 
 	__populate_check_ext4_dformat "${extents_file}" "extents"
 	__populate_check_ext4_dformat "${etree_file}" "etree"
diff --git a/common/rc b/common/rc
index 6f939e3b5..3f35da7fe 100644
--- a/common/rc
+++ b/common/rc
@@ -301,7 +301,7 @@ _put_mount()
 	local last_mnt=`echo $MOUNTED_POINT_STACK | awk '{print $1}'`
 
 	if [ -n "$last_mnt" ]; then
-		$UMOUNT_PROG $last_mnt
+		_unmount $last_mnt
 	fi
 	MOUNTED_POINT_STACK=`echo $MOUNTED_POINT_STACK | cut -d\  -f2-`
 }
@@ -310,7 +310,7 @@ _put_mount()
 _clear_mount_stack()
 {
 	if [ -n "$MOUNTED_POINT_STACK" ]; then
-		$UMOUNT_PROG $MOUNTED_POINT_STACK
+		_unmount -R $MOUNTED_POINT_STACK
 	fi
 	MOUNTED_POINT_STACK=""
 }
@@ -448,6 +448,14 @@ _scratch_mount_idmapped()
 	fi
 }
 
+# Unmount the filesystem based on the directory or device passed.
+_unmount()
+{
+	local args="$*"
+
+	$UMOUNT_PROG $args >> $seqres.full 2>&1
+}
+
 _scratch_unmount()
 {
 	case "$FSTYP" in
@@ -455,20 +463,20 @@ _scratch_unmount()
 		_overlay_scratch_unmount
 		;;
 	btrfs)
-		$UMOUNT_PROG $SCRATCH_MNT
+		_unmount $SCRATCH_MNT
 		;;
 	tmpfs)
-		$UMOUNT_PROG $SCRATCH_MNT
+		_unmount $SCRATCH_MNT
 		;;
 	*)
-		$UMOUNT_PROG $SCRATCH_DEV
+		_unmount $SCRATCH_DEV
 		;;
 	esac
 }
 
 _scratch_umount_idmapped()
 {
-	$UMOUNT_PROG $SCRATCH_MNT
+	_unmount $SCRATCH_MNT
 }
 
 _scratch_remount()
@@ -492,7 +500,7 @@ _scratch_cycle_mount()
         ;;
     overlay)
         if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
-            $UMOUNT_PROG $SCRATCH_MNT
+            _unmount $SCRATCH_MNT
             unmounted=true
         fi
         ;;
@@ -540,9 +548,9 @@ _move_mount()
 
 	# Replace $mnt with $tmp. Use a temporary bind-mount because
 	# mount --move will fail with certain mount propagation layouts.
-	$UMOUNT_PROG $mnt || _fail "Failed to unmount $mnt"
+	_unmount $mnt || _fail "Failed to unmount $mnt"
 	_mount --bind $tmp $mnt || _fail "Failed to bind-mount $tmp to $mnt"
-	$UMOUNT_PROG $tmp || _fail "Failed to unmount $tmp"
+	_unmount $tmp || _fail "Failed to unmount $tmp"
 	rmdir $tmp
 }
 
@@ -608,7 +616,7 @@ _test_unmount()
 	if [ "$FSTYP" == "overlay" ]; then
 		_overlay_test_unmount
 	else
-		$UMOUNT_PROG $TEST_DEV
+		_unmount $TEST_DEV
 	fi
 }
 
@@ -622,7 +630,7 @@ _test_cycle_mount()
         ;;
     overlay)
         if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
-            $UMOUNT_PROG $TEST_DIR
+            _unmount $TEST_DIR
             unmounted=true
         fi
         ;;
@@ -1376,7 +1384,7 @@ _repair_scratch_fs()
 			_scratch_xfs_repair -L 2>&1
 			echo "log zap returns $?"
 		else
-			umount "$SCRATCH_MNT"
+			_unmount "$SCRATCH_MNT"
 		fi
 		_scratch_xfs_repair "$@" 2>&1
 		res=$?
@@ -1408,7 +1416,7 @@ _repair_scratch_fs()
 		# Fall through to repair base fs
 		dev=$OVL_BASE_SCRATCH_DEV
 		fstyp=$OVL_BASE_FSTYP
-		$UMOUNT_PROG $OVL_BASE_SCRATCH_MNT
+		_unmount $OVL_BASE_SCRATCH_MNT
 	fi
 	# Let's hope fsck -y suffices...
 	fsck -t $fstyp -y $dev 2>&1
@@ -1441,7 +1449,7 @@ _repair_test_fs()
 				_test_xfs_repair -L >>$tmp.repair 2>&1
 				echo "log zap returns $?" >> $tmp.repair
 			else
-				umount "$TEST_DEV"
+				_unmount "$TEST_DEV"
 			fi
 			_test_xfs_repair "$@" >>$tmp.repair 2>&1
 			res=$?
@@ -2222,7 +2230,7 @@ _require_logdev()
         _notrun "This test requires USE_EXTERNAL to be enabled"
 
     # ensure its not mounted
-    $UMOUNT_PROG $SCRATCH_LOGDEV 2>/dev/null
+    _unmount $SCRATCH_LOGDEV 2>/dev/null
 }
 
 # This test requires that an external log device is not in use
@@ -3309,7 +3317,7 @@ _umount_or_remount_ro()
     local mountpoint=`_is_dev_mounted $device`
 
     if [ $USE_REMOUNT -eq 0 ]; then
-        $UMOUNT_PROG $device
+	_unmount $device
     else
         _remount $device ro
     fi
@@ -3826,7 +3834,7 @@ _require_scratch_dev_pool()
 			_notrun "$i is part of TEST_DEV, this test requires unique disks"
 		fi
 		if _mount | grep -q $i; then
-			if ! $UMOUNT_PROG $i; then
+			if ! _unmount $i; then
 		            echo "failed to unmount $i - aborting"
 		            exit 1
 		        fi
diff --git a/tests/generic/042 b/tests/generic/042
index fd0ef705a..ced145dde 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -44,7 +44,7 @@ _crashtest()
 		_filter_xfs_io
 	$here/src/godown -f $mnt
 
-	$UMOUNT_PROG $mnt
+	_unmount $mnt
 	_mount $img $mnt
 
 	# We should /never/ see 0xCD in the file, because we wrote that pattern
@@ -54,7 +54,7 @@ _crashtest()
 		_hexdump $file
 	fi
 
-	$UMOUNT_PROG $mnt
+	_unmount $mnt
 }
 
 # Modify as appropriate.
diff --git a/tests/generic/050 b/tests/generic/050
index ca02d3092..8e9456db2 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -87,8 +87,9 @@ blockdev --setro $SCRATCH_DEV
 echo "mounting filesystem that needs recovery on a read-only device:"
 _try_scratch_mount 2>&1 | _filter_ro_mount | _filter_scratch
 
+# expects an error, so open code the unmount
 echo "unmounting read-only filesystem"
-_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
+$UMOUNT_PROG $SCRATCH_DEV 2>&1 | _filter_scratch | _filter_ending_dot
 
 #
 # This is the way out if the underlying device really is read-only.
diff --git a/tests/generic/067 b/tests/generic/067
index b561b7bc5..ccb1e3fbb 100755
--- a/tests/generic/067
+++ b/tests/generic/067
@@ -66,7 +66,7 @@ umount_symlink_device()
 	rm -f $symlink
 	echo "# umount symlink to device, which is not mounted" >>$seqres.full
 	ln -s $SCRATCH_DEV $symlink
-	$UMOUNT_PROG $symlink >>$seqres.full 2>&1
+	_unmount $symlink >>$seqres.full 2>&1
 }
 
 # umount a path name that is 256 bytes long, this should fail gracefully,
@@ -78,7 +78,7 @@ umount_toolong_name()
 	_scratch_mount 2>&1 | tee -a $seqres.full
 
 	echo "# umount a too-long name" >>$seqres.full
-	$UMOUNT_PROG $longname >>$seqres.full 2>&1
+	_unmount $longname >>$seqres.full 2>&1
 	_scratch_unmount 2>&1 | tee -a $seqres.full
 }
 
@@ -93,7 +93,7 @@ lazy_umount_symlink()
 	rm -f $symlink
 	ln -s $SCRATCH_MNT/testdir $symlink
 
-	$UMOUNT_PROG -l $symlink >>$seqres.full 2>&1
+	_unmount -l $symlink >>$seqres.full 2>&1
 	# _scratch_unmount should not be blocked
 	_scratch_unmount 2>&1 | tee -a $seqres.full
 }
diff --git a/tests/generic/081 b/tests/generic/081
index 468c87ac9..df17ab6c1 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -32,7 +32,7 @@ _cleanup()
 	# other tests to fail.
 	while test -e /dev/mapper/$vgname-$snapname || \
 	      test -e /dev/mapper/$vgname-$lvname; do
-		$UMOUNT_PROG $mnt >> $seqres.full 2>&1
+		_unmount $mnt >> $seqres.full 2>&1
 		$LVM_PROG lvremove -f $vgname/$snapname >>$seqres.full 2>&1
 		$LVM_PROG lvremove -f $vgname/$lvname >>$seqres.full 2>&1
 		$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
diff --git a/tests/generic/085 b/tests/generic/085
index cfe6112d6..8fbcdce2e 100755
--- a/tests/generic/085
+++ b/tests/generic/085
@@ -27,7 +27,7 @@ cleanup_dmdev()
 	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
 	[ -n "$pid" ] && kill -9 $pid 2>/dev/null
 	wait $pid
-	$UMOUNT_PROG $lvdev >/dev/null 2>&1
+	_unmount $lvdev >/dev/null 2>&1
 	_dmsetup_remove $node
 }
 
@@ -69,8 +69,8 @@ for ((i=0; i<100; i++)); do
 done &
 pid=$!
 for ((i=0; i<100; i++)); do
-	$MOUNT_PROG $lvdev $SCRATCH_MNT >/dev/null 2>&1
-	$UMOUNT_PROG $lvdev >/dev/null 2>&1
+	_mount $lvdev $SCRATCH_MNT >/dev/null 2>&1
+	_unmount $lvdev >/dev/null 2>&1
 done &
 pid="$pid $!"
 
diff --git a/tests/generic/108 b/tests/generic/108
index da13715f2..2709472f6 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -18,7 +18,7 @@ _cleanup()
 {
 	cd /
 	echo running > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/state
-	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
+	_unmount $SCRATCH_MNT >>$seqres.full 2>&1
 	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
 	$LVM_PROG pvremove -f $SCRATCH_DEV $SCSI_DEBUG_DEV >>$seqres.full 2>&1
 	$UDEV_SETTLE_PROG
diff --git a/tests/generic/171 b/tests/generic/171
index 5c8504d26..8726ee61d 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -36,7 +36,7 @@ mkdir $testdir
 echo "Reformat with appropriate size"
 blksz="$(_get_block_size $testdir)"
 nr_blks=10240
-umount $SCRATCH_MNT
+_scratch_unmount
 sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
diff --git a/tests/generic/172 b/tests/generic/172
index 17f817805..b67e817b6 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -35,7 +35,7 @@ mkdir $testdir
 
 echo "Reformat with appropriate size"
 blksz="$(_get_block_size $testdir)"
-umount $SCRATCH_MNT
+_scratch_unmount
 
 file_size=$((768 * 1024 * 1024))
 fs_size=$((1024 * 1024 * 1024))
diff --git a/tests/generic/173 b/tests/generic/173
index d7ac7b15d..a19ff8070 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -36,7 +36,7 @@ mkdir $testdir
 echo "Reformat with appropriate size"
 blksz="$(_get_block_size $testdir)"
 nr_blks=10240
-umount $SCRATCH_MNT
+_scratch_unmount
 sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
diff --git a/tests/generic/174 b/tests/generic/174
index c7c62001d..32343d911 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -37,7 +37,7 @@ mkdir $testdir
 echo "Reformat with appropriate size"
 blksz="$(_get_block_size $testdir)"
 nr_blks=10240
-umount $SCRATCH_MNT
+_scratch_unmount
 sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
diff --git a/tests/generic/306 b/tests/generic/306
index a6ea654b6..8e118472d 100755
--- a/tests/generic/306
+++ b/tests/generic/306
@@ -12,7 +12,7 @@ _begin_fstest auto quick rw
 # Override the default cleanup function.
 _cleanup()
 {
-    umount $BINDFILE
+    _unmount $BINDFILE
     cd /
     rm -f $tmp.*
 }
diff --git a/tests/generic/332 b/tests/generic/332
index cb15e77bd..fef4eabb8 100755
--- a/tests/generic/332
+++ b/tests/generic/332
@@ -61,7 +61,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file2 | _filter_scratch
 
 echo "Check for damage"
-umount $SCRATCH_MNT
+_scratch_unmount
 _repair_scratch_fs >> $seqres.full
 
 # success, all done
diff --git a/tests/generic/361 b/tests/generic/361
index c56157391..7273dd056 100755
--- a/tests/generic/361
+++ b/tests/generic/361
@@ -16,7 +16,7 @@ _begin_fstest auto quick
 # Override the default cleanup function.
 _cleanup()
 {
-	$UMOUNT_PROG $fs_mnt
+	_unmount $fs_mnt
 	_destroy_loop_device $loop_dev
 	cd /
 	rm -f $tmp.*
diff --git a/tests/generic/373 b/tests/generic/373
index 3bd46963a..e6334398f 100755
--- a/tests/generic/373
+++ b/tests/generic/373
@@ -60,7 +60,7 @@ md5sum $testdir/file | _filter_scratch
 md5sum $othertestdir/otherfile | filter_otherdir
 
 echo "Unmount otherdir"
-$UMOUNT_PROG $otherdir
+_unmount $otherdir
 rm -rf $otherdir
 
 # success, all done
diff --git a/tests/generic/374 b/tests/generic/374
index acb23d172..e56521aa0 100755
--- a/tests/generic/374
+++ b/tests/generic/374
@@ -59,7 +59,7 @@ echo "Check output"
 md5sum $testdir/file $othertestdir/otherfile | filter_md5
 
 echo "Unmount otherdir"
-$UMOUNT_PROG $otherdir
+_unmount $otherdir
 rm -rf $otherdir
 
 # success, all done
diff --git a/tests/generic/395 b/tests/generic/395
index 45787fff0..f9c331adb 100755
--- a/tests/generic/395
+++ b/tests/generic/395
@@ -75,7 +75,7 @@ mount --bind $SCRATCH_MNT $SCRATCH_MNT/ro_bind_mnt
 mount -o remount,ro,bind $SCRATCH_MNT/ro_bind_mnt
 _set_encpolicy $SCRATCH_MNT/ro_bind_mnt/ro_dir |& _filter_scratch
 _get_encpolicy $SCRATCH_MNT/ro_bind_mnt/ro_dir |& _filter_scratch
-umount $SCRATCH_MNT/ro_bind_mnt
+_unmount $SCRATCH_MNT/ro_bind_mnt
 
 # success, all done
 status=0
diff --git a/tests/generic/459 b/tests/generic/459
index 98177f6b5..daccc80ce 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -28,7 +28,7 @@ _cleanup()
 	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
 	cd /
 	rm -f $tmp.*
-	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
+	_unmount $SCRATCH_MNT >>$seqres.full 2>&1
 	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
 	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
 	$UDEV_SETTLE_PROG
diff --git a/tests/generic/563 b/tests/generic/563
index e8db8acf0..f0d2f404c 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -16,13 +16,13 @@ _begin_fstest auto quick
 # Override the default cleanup function.
 _cleanup()
 {
+	echo $$ > $cgdir/cgroup.procs
+	rmdir $cgdir/$seq-cg* > /dev/null 2>&1
+	_unmount $SCRATCH_MNT > /dev/null 2>&1
+	_destroy_loop_device $LOOP_DEV > /dev/null 2>&1
 	cd /
 	rm -f $tmp.*
 
-	echo $$ > $cgdir/cgroup.procs
-	rmdir $cgdir/$seq-cg* > /dev/null 2>&1
-	umount $SCRATCH_MNT > /dev/null 2>&1
-	_destroy_loop_device $LOOP_DEV > /dev/null 2>&1
 }
 
 # Import common functions.
@@ -80,7 +80,7 @@ reset()
 	rmdir $cgdir/$seq-cg* > /dev/null 2>&1
 	$XFS_IO_PROG -fc "pwrite 0 $iosize" $SCRATCH_MNT/file \
 		>> $seqres.full 2>&1
-	umount $SCRATCH_MNT || _fail "umount failed"
+	_unmount $SCRATCH_MNT || _fail "umount failed"
 	_mount $LOOP_DEV $SCRATCH_MNT || _fail "mount failed"
 	stat $SCRATCH_MNT/file > /dev/null
 }
diff --git a/tests/generic/604 b/tests/generic/604
index c2e03c2ea..744d34565 100755
--- a/tests/generic/604
+++ b/tests/generic/604
@@ -26,7 +26,7 @@ done
 # mount the base fs.  Delay the mount attempt by a small amount in the hope
 # that the mount() call will try to lock s_umount /after/ umount has already
 # taken it.
-$UMOUNT_PROG $SCRATCH_MNT &
+_unmount $SCRATCH_MNT &
 sleep 0.01s ; _scratch_mount
 wait
 
diff --git a/tests/generic/631 b/tests/generic/631
index c7c95e560..642d47863 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -84,7 +84,7 @@ worker() {
 		touch $mergedir/etc/access.conf
 		mv $mergedir/etc/access.conf $mergedir/etc/access.conf.bak
 		touch $mergedir/etc/access.conf
-		umount $mergedir
+		_unmount $mergedir
 	done
 	rm -f $SCRATCH_MNT/workers/$tag
 }
diff --git a/tests/generic/648 b/tests/generic/648
index e4c9990e1..7473c9d33 100755
--- a/tests/generic/648
+++ b/tests/generic/648
@@ -18,7 +18,7 @@ _cleanup()
 {
 	_kill_fsstress
 	if [ -n "$loopmnt" ]; then
-		$UMOUNT_PROG $loopmnt 2>/dev/null
+		_unmount $loopmnt 2>/dev/null
 		rm -r -f $loopmnt
 	fi
 	_dmerror_unmount
@@ -102,7 +102,7 @@ while _soak_loop_running $((25 * TIME_FACTOR)); do
 
 	# Mount again to replay log after loading working table, so we have a
 	# consistent fs after test.
-	$UMOUNT_PROG $loopmnt
+	_unmount $loopmnt
 	is_unmounted=1
 	# We must unmount dmerror at here, or whole later testing will crash.
 	# So try to umount enough times, before we have no choice.
@@ -128,7 +128,7 @@ done
 # Make sure the fs image file is ok
 if [ -f "$loopimg" ]; then
 	if _mount $loopimg $loopmnt -o loop; then
-		$UMOUNT_PROG $loopmnt &> /dev/null
+		_unmount $loopmnt &> /dev/null
 	else
 		_metadump_dev $DMERROR_DEV $seqres.scratch.final.md
 		echo "final scratch mount failed"
diff --git a/tests/generic/698 b/tests/generic/698
index 28928b2fb..0029df90f 100755
--- a/tests/generic/698
+++ b/tests/generic/698
@@ -17,8 +17,8 @@ _begin_fstest auto quick perms attr idmapped mount
 _cleanup()
 {
 	cd /
-	$UMOUNT_PROG $SCRATCH_MNT/target-mnt 2>/dev/null
-	$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
+	_unmount $SCRATCH_MNT/target-mnt 2>/dev/null
+	_unmount $SCRATCH_MNT 2>/dev/null
 	rm -r -f $tmp.*
 }
 
diff --git a/tests/generic/699 b/tests/generic/699
index 677307538..3079a861d 100755
--- a/tests/generic/699
+++ b/tests/generic/699
@@ -15,9 +15,9 @@ _begin_fstest auto quick perms attr idmapped mount
 _cleanup()
 {
 	cd /
-	$UMOUNT_PROG $SCRATCH_MNT/target-mnt
-	$UMOUNT_PROG $SCRATCH_MNT/ovl-merge 2>/dev/null
-	$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
+	_unmount $SCRATCH_MNT/target-mnt
+	_unmount $SCRATCH_MNT/ovl-merge 2>/dev/null
+	_unmount $SCRATCH_MNT 2>/dev/null
 	rm -r -f $tmp.*
 }
 
@@ -113,7 +113,7 @@ setup_overlayfs_idmapped_lower_metacopy_on()
 
 reset_overlayfs()
 {
-	$UMOUNT_PROG $SCRATCH_MNT/ovl-merge 2>/dev/null
+	_unmount $SCRATCH_MNT/ovl-merge 2>/dev/null
 	rm -rf $upper $work $merge
 }
 
diff --git a/tests/generic/704 b/tests/generic/704
index f39d47066..f452f9e9c 100755
--- a/tests/generic/704
+++ b/tests/generic/704
@@ -14,7 +14,7 @@ _cleanup()
 {
 	cd /
 	rm -r -f $tmp.*
-	[ -d "$SCSI_DEBUG_MNT" ] && $UMOUNT_PROG $SCSI_DEBUG_MNT 2>/dev/null
+	[ -d "$SCSI_DEBUG_MNT" ] && _unmount $SCSI_DEBUG_MNT 2>/dev/null
 	_put_scsi_debug_dev
 }
 
diff --git a/tests/generic/717 b/tests/generic/717
index 4378e964a..2ecd2888d 100755
--- a/tests/generic/717
+++ b/tests/generic/717
@@ -85,7 +85,7 @@ mkdir -p $SCRATCH_MNT/xyz
 mount --bind $dir $SCRATCH_MNT/xyz --bind
 _pwrite_byte 0x60 0 $((blksz * (nrblks + 2))) $dir/c >> $seqres.full
 $XFS_IO_PROG -c "exchangerange $SCRATCH_MNT/xyz/c" $dir/a
-umount $SCRATCH_MNT/xyz
+_unmount $SCRATCH_MNT/xyz
 
 echo Swapping a file with itself
 $XFS_IO_PROG -c "exchangerange $dir/a" $dir/a
diff --git a/tests/generic/730 b/tests/generic/730
index 062314ea0..6251980e3 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -12,7 +12,7 @@ _begin_fstest auto quick
 _cleanup()
 {
 	cd /
-	$UMOUNT_PROG $SCSI_DEBUG_MNT >>$seqres.full 2>&1
+	_unmount $SCSI_DEBUG_MNT >>$seqres.full 2>&1
 	_put_scsi_debug_dev
 	rm -f $tmp.*
 }
diff --git a/tests/generic/731 b/tests/generic/731
index cd39e8b09..4ac5e1a3e 100755
--- a/tests/generic/731
+++ b/tests/generic/731
@@ -13,7 +13,7 @@ _begin_fstest auto quick
 _cleanup()
 {
 	cd /
-	$UMOUNT_PROG $SCSI_DEBUG_MNT >>$seqres.full 2>&1
+	_unmount $SCSI_DEBUG_MNT >>$seqres.full 2>&1
 	_put_scsi_debug_dev
 	rm -f $tmp.*
 }
diff --git a/tests/generic/732 b/tests/generic/732
index d08028c23..e907a009f 100755
--- a/tests/generic/732
+++ b/tests/generic/732
@@ -15,8 +15,8 @@ _begin_fstest auto quick rename
 # Override the default cleanup function.
 _cleanup()
 {
-	$UMOUNT_PROG $testdir1 2>/dev/null
-	$UMOUNT_PROG $testdir2 2>/dev/null
+	_unmount $testdir1 2>/dev/null
+	_unmount $testdir2 2>/dev/null
 	cd /
 	rm -r -f $tmp.*
 }
diff --git a/tests/generic/741 b/tests/generic/741
index 4b480b5a1..cac7045eb 100755
--- a/tests/generic/741
+++ b/tests/generic/741
@@ -13,7 +13,7 @@ _begin_fstest auto quick volume tempfsid
 # Override the default cleanup function.
 _cleanup()
 {
-	umount $extra_mnt &> /dev/null
+	_unmount $extra_mnt &> /dev/null
 	rm -rf $extra_mnt
 	_unmount_flakey
 	_cleanup_flakey
diff --git a/tests/generic/744 b/tests/generic/744
index a31d8d7a4..df8f6ae9b 100755
--- a/tests/generic/744
+++ b/tests/generic/744
@@ -15,8 +15,8 @@ _cleanup()
 	cd /
 	rm -r -f $tmp.*
 
-	$UMOUNT_PROG $mnt2 &> /dev/null
-	$UMOUNT_PROG $mnt1 &> /dev/null
+	_unmount $mnt2 &> /dev/null
+	_unmount $mnt1 &> /dev/null
 	[ -b "$loop_dev2" ] && losetup -d $loop_dev2
 	[ -b "$loop_dev1" ] && losetup -d $loop_dev1
 	[ -n "$seq" ] && rm -rf $TEST_DIR/$seq
@@ -42,7 +42,7 @@ clone_filesystem()
 
 	_mount $dev1 $mnt1
 	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo >> $seqres.full
-	$UMOUNT_PROG $mnt1
+	_unmount $mnt1
 
 	# device dump of $dev1 to $dev2
 	dd if=$dev1 of=$dev2 conv=fsync status=none || _fail "dd failed: $?"
diff --git a/tests/generic/746 b/tests/generic/746
index 5734f254d..671910606 100755
--- a/tests/generic/746
+++ b/tests/generic/746
@@ -38,7 +38,7 @@ esac
 # Override the default cleanup function.
 _cleanup()
 {
-	$UMOUNT_PROG $loop_dev &> /dev/null
+	_unmount $loop_mnt &> /dev/null
 	_destroy_loop_device $loop_dev
 	if [ $status -eq 0 ]; then
 		rm -rf $tmp
@@ -53,7 +53,7 @@ get_holes()
 	# in-core state that will perturb the free space map on umount.  Stick
 	# to established convention which requires the filesystem to be
 	# unmounted while we probe the underlying file.
-	$UMOUNT_PROG $loop_mnt
+	_unmount $loop_mnt
 
 	# FIEMAP only works on regular files, so call it on the backing file
 	# and not the loop device like everything else
@@ -66,7 +66,7 @@ get_free_sectors()
 {
 	case $FSTYP in
 	ext4)
-	$UMOUNT_PROG $loop_mnt
+	_unmount $loop_mnt
 	$DUMPE2FS_PROG $loop_dev  2>&1 | grep " Free blocks" | cut -d ":" -f2- | \
 		tr ',' '\n' | $SED_PROG 's/^ //' | \
 		$AWK_PROG -v spb=$sectors_per_block 'BEGIN{FS="-"};
@@ -80,7 +80,7 @@ get_free_sectors()
 	xfs)
 	agsize=`$XFS_INFO_PROG $loop_mnt | $SED_PROG -n 's/.*agsize=\(.*\) blks.*/\1/p'`
 	# Convert free space (agno, block, length) to (start sector, end sector)
-	$UMOUNT_PROG $loop_mnt
+	_unmount $loop_mnt
 	$XFS_DB_PROG -r -c "freesp -d" $loop_dev | $SED_PROG '/^.*from/,$d'| \
 		 $AWK_PROG -v spb=$sectors_per_block -v agsize=$agsize \
 		'{ print spb * ($1 * agsize + $2), spb * ($1 * agsize + $2 + $3) - 1 }'
diff --git a/tests/xfs/014 b/tests/xfs/014
index 098f64186..f638e4b16 100755
--- a/tests/xfs/014
+++ b/tests/xfs/014
@@ -22,7 +22,7 @@ _begin_fstest auto enospc quick quota prealloc
 _cleanup()
 {
 	cd /
-	umount $LOOP_MNT 2>/dev/null
+	_unmount $LOOP_MNT 2>/dev/null
 	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
@@ -168,13 +168,13 @@ LOOP_MNT=$SCRATCH_MNT/$seq.mnt
 $MKFS_XFS_PROG -d "file=1,name=$LOOP_FILE,size=10g" >> $seqres.full 2>&1
 
 mkdir -p $LOOP_MNT
-mount -t xfs -o loop,uquota,gquota $LOOP_FILE $LOOP_MNT || \
+_mount -o uquota,gquota $LOOP_FILE $LOOP_MNT || \
 	_fail "Failed to mount loop fs."
 
 _test_enospc $LOOP_MNT
 _test_edquot $LOOP_MNT
 
-umount $LOOP_MNT
+_unmount $LOOP_MNT
 
 echo $orig_sp_time > /proc/sys/fs/xfs/speculative_prealloc_lifetime
 
diff --git a/tests/xfs/073 b/tests/xfs/073
index 28f1fad08..e4b17c5e7 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -21,9 +21,9 @@ _cleanup()
 {
 	cd /
 	_scratch_unmount 2>/dev/null
-	umount $imgs.loop 2>/dev/null
+	_unmount $imgs.loop 2>/dev/null
+	_unmount $imgs.source_dir 2>/dev/null
 	[ -d $imgs.loop ] && rmdir $imgs.loop
-	umount $imgs.source_dir 2>/dev/null
 	[ -d $imgs.source_dir ] && rm -rf $imgs.source_dir
 	rm -f $imgs.* $tmp.* /var/tmp/xfs_copy.log.*
 }
@@ -65,10 +65,10 @@ _verify_copy()
 	rmdir $target_dir 2>/dev/null
 	mkdir $target_dir
 
-	mount -t xfs -o loop $target $target_dir 2>/dev/null
+	_mount -t xfs -o loop $target $target_dir 2>/dev/null
 	if [ $? -ne 0 ]; then
 		echo retrying mount with nouuid option >>$seqres.full
-		mount -t xfs -o loop -o nouuid $target $target_dir
+		_mount -t xfs -o loop -o nouuid $target $target_dir
 		if [ $? -ne 0 ]; then
 			echo mount failed - evil!
 			return
@@ -87,19 +87,19 @@ _verify_copy()
 
 	echo comparing new image geometry to old
 	$XFS_INFO_PROG $source_dir \
-		| _filter_copy $source $source_dir '/dev/loop.' '#' \
+		| _filter_copy $source $source_dir '/dev/loop[0-9]\+' '#' \
 		| tr -s ' ' \
 		> $tmp.geometry1
 	$XFS_INFO_PROG $target_dir \
-		| _filter_copy $target $target_dir '/dev/loop.' '#' \
+		| _filter_copy $target $target_dir '/dev/loop[0-9]\+' '#' \
 		| tr -s ' ' \
 		> $tmp.geometry2
 	[ -s $tmp.geometry1 ] || echo no geometry output
 	diff -u $tmp.geometry1 $tmp.geometry2
 
 	echo unmounting and removing new image
-	umount $source_dir
-	umount $target_dir > /dev/null 2>&1
+	_unmount $source_dir
+	_unmount $target_dir > /dev/null 2>&1
 	rm -f $target
 }
 
@@ -134,10 +134,10 @@ ${MKFS_XFS_PROG} -dfile,name=$imgs.source,size=100g \
 rmdir $imgs.source_dir 2>/dev/null
 mkdir $imgs.source_dir
 
-mount -t xfs -o loop $imgs.source $imgs.source_dir
+_mount -t xfs -o loop $imgs.source $imgs.source_dir
 loop2=`mount | grep $imgs.source | grep -o -e 'loop=.*[^),]' | grep -o -e '/.*$'`
 cp -a $here $imgs.source_dir
-mount -t xfs -o remount,ro $imgs.source $imgs.source_dir
+_mount -t xfs -o remount,ro $imgs.source $imgs.source_dir
 $XFS_COPY_PROG $imgs.source $imgs.image | _filter_copy '#' $imgs.image '#' '#'
 _verify_copy $imgs.image $imgs.source $imgs.source_dir
 
diff --git a/tests/xfs/074 b/tests/xfs/074
index 278f0ade6..6a03c8111 100755
--- a/tests/xfs/074
+++ b/tests/xfs/074
@@ -72,7 +72,7 @@ $XFS_IO_PROG -ft \
 	-c "falloc 1023m 2g" \
 	$LOOP_MNT/foo >> $seqres.full
 
-umount $LOOP_MNT
+_unmount $LOOP_MNT
 _check_xfs_filesystem $LOOP_DEV none none
 
 # success, all done
diff --git a/tests/xfs/078 b/tests/xfs/078
index 834c99a00..6b325e05f 100755
--- a/tests/xfs/078
+++ b/tests/xfs/078
@@ -16,7 +16,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
-	$UMOUNT_PROG $LOOP_MNT 2>/dev/null
+	_unmount $LOOP_MNT 2>/dev/null
 	[ -n "$LOOP_DEV" ] && _destroy_loop_device $LOOP_DEV 2>/dev/null
 	# try to keep the image file if test fails
 	[ $status -eq 0 ] && rm -f $LOOP_IMG
@@ -75,13 +75,13 @@ _grow_loop()
 	$XFS_IO_PROG -c "pwrite $new_size $bsize" $LOOP_IMG | _filter_io
 	LOOP_DEV=`_create_loop_device $LOOP_IMG`
 	echo "*** mount loop filesystem"
-	$MOUNT_PROG -t xfs $LOOP_DEV $LOOP_MNT
+	_mount -t xfs $LOOP_DEV $LOOP_MNT
 
 	echo "*** grow loop filesystem"
 	$XFS_GROWFS_PROG $LOOP_MNT 2>&1 |  _filter_growfs 2>&1
 
 	echo "*** unmount"
-	$UMOUNT_PROG -d $LOOP_MNT && LOOP_DEV=
+	_unmount $LOOP_MNT
 
 	# Large grows takes forever to check..
 	if [ "$check" -gt "0" ]
diff --git a/tests/xfs/148 b/tests/xfs/148
index 9e6798f99..c42c9b119 100755
--- a/tests/xfs/148
+++ b/tests/xfs/148
@@ -14,7 +14,7 @@ _begin_fstest auto quick fuzzers
 _cleanup()
 {
 	cd /
-	$UMOUNT_PROG $mntpt > /dev/null 2>&1
+	_unmount $mntpt > /dev/null 2>&1
 	_destroy_loop_device $loopdev > /dev/null 2>&1
 	rm -r -f $tmp.*
 }
@@ -90,7 +90,7 @@ cat $tmp.log >> $seqres.full
 cat $tmp.log | _filter_test_dir
 
 # Corrupt the entries
-$UMOUNT_PROG $mntpt
+_unmount $mntpt
 _destroy_loop_device $loopdev
 cp $imgfile $imgfile.old
 sed -b \
@@ -121,7 +121,7 @@ fi
 echo "does repair complain?" >> $seqres.full
 
 # Does repair complain about this?
-$UMOUNT_PROG $mntpt
+_unmount $mntpt
 $XFS_REPAIR_PROG -n $loopdev >> $seqres.full 2>&1
 res=$?
 test $res -eq 1 || \
diff --git a/tests/xfs/149 b/tests/xfs/149
index f1b2405e7..f2187109b 100755
--- a/tests/xfs/149
+++ b/tests/xfs/149
@@ -22,7 +22,7 @@ loop_symlink=$TEST_DIR/loop_symlink.$$
 # Override the default cleanup function.
 _cleanup()
 {
-    $UMOUNT_PROG $mntdir
+    _unmount $mntdir
     [ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
     rmdir $mntdir
     rm -f $loop_symlink
@@ -73,7 +73,7 @@ echo "=== xfs_growfs - check device symlink ==="
 $XFS_GROWFS_PROG -D 12288 $loop_symlink > /dev/null
 
 echo "=== unmount ==="
-$UMOUNT_PROG $mntdir || _fail "!!! failed to unmount"
+_unmount $mntdir || _fail "!!! failed to unmount"
 
 echo "=== mount device symlink ==="
 $MOUNT_PROG $loop_symlink $mntdir || _fail "!!! failed to loopback mount"
diff --git a/tests/xfs/186 b/tests/xfs/186
index 88f02585e..6f82e0cda 100755
--- a/tests/xfs/186
+++ b/tests/xfs/186
@@ -87,7 +87,7 @@ _do_eas()
 		_create_eas $2 $3
 	fi
 	echo ""
-	cd /; $UMOUNT_PROG $SCRATCH_MNT
+	cd /; _unmount $SCRATCH_MNT
 	_print_inode
 }
 
@@ -99,7 +99,7 @@ _do_dirents()
 	echo ""
 	_scratch_mount
 	_create_dirents $1 $2
-	cd /; $UMOUNT_PROG $SCRATCH_MNT
+	cd /; _unmount $SCRATCH_MNT
 	_print_inode
 }
 
diff --git a/tests/xfs/216 b/tests/xfs/216
index 680239b4e..6b8b2eb22 100755
--- a/tests/xfs/216
+++ b/tests/xfs/216
@@ -12,6 +12,12 @@ _begin_fstest log metadata auto quick
 # Import common functions.
 . ./common/filter
 
+_cleanup()
+{
+	_unmount $LOOP_MNT > /dev/null 2>&1
+	cd /
+	rm -f $tmp.*
+}
 
 _require_scratch
 _scratch_mkfs_xfs >/dev/null 2>&1
@@ -50,9 +56,9 @@ _do_mkfs()
 		echo -n "fssize=${i}g "
 		$MKFS_XFS_PROG -f -b size=4096 -l version=2 \
 			-d name=$LOOP_DEV,size=${i}g $loop_mkfs_opts |grep log
-		mount -o loop -t xfs $LOOP_DEV $LOOP_MNT
+		_mount -o loop -t xfs $LOOP_DEV $LOOP_MNT
 		echo "test write" > $LOOP_MNT/test
-		umount $LOOP_MNT > /dev/null 2>&1
+		_unmount $LOOP_MNT > /dev/null 2>&1
 	done
 }
 # make large holey file
diff --git a/tests/xfs/217 b/tests/xfs/217
index 41caaf738..b2eb34490 100755
--- a/tests/xfs/217
+++ b/tests/xfs/217
@@ -29,9 +29,9 @@ _do_mkfs()
 		echo -n "fssize=${i}g "
 		$MKFS_XFS_PROG -f -b size=4096 -l version=2 \
 			-d name=$LOOP_DEV,size=${i}g |grep log
-		mount -o loop -t xfs $LOOP_DEV $LOOP_MNT
+		_mount -o loop -t xfs $LOOP_DEV $LOOP_MNT
 		echo "test write" > $LOOP_MNT/test
-		umount $LOOP_MNT > /dev/null 2>&1
+		_unmount $LOOP_MNT > /dev/null 2>&1
 
 		# punch out the previous blocks so that we keep the amount of
 		# disk space the test requires down to a minimum.
diff --git a/tests/xfs/250 b/tests/xfs/250
index f8846be6e..4e3473ebc 100755
--- a/tests/xfs/250
+++ b/tests/xfs/250
@@ -13,9 +13,10 @@ _begin_fstest auto quick rw prealloc metadata
 _cleanup()
 {
 	cd /
-	umount $LOOP_MNT 2>/dev/null
+	_unmount $LOOP_MNT 2>/dev/null
 	rm -f $LOOP_DEV
 	rmdir $LOOP_MNT
+	rm -f $tmp.*
 }
 
 # Import common functions.
@@ -54,13 +55,13 @@ _test_loop()
 		| _filter_mkfs 2>/dev/null
 
 	echo "*** mount loop filesystem"
-	mount -t xfs -o loop $LOOP_DEV $LOOP_MNT
+	_mount -t xfs -o loop $LOOP_DEV $LOOP_MNT
 
 	echo "*** preallocate large file"
 	$XFS_IO_PROG -f -c "resvsp 0 $fsize" $LOOP_MNT/foo | _filter_io
 
 	echo "*** unmount loop filesystem"
-	umount $LOOP_MNT > /dev/null 2>&1
+	_unmount $LOOP_MNT > /dev/null 2>&1
 
 	echo "*** check loop filesystem"
 	 _check_xfs_filesystem $LOOP_DEV none none
diff --git a/tests/xfs/289 b/tests/xfs/289
index cf0f2883c..d234f212d 100755
--- a/tests/xfs/289
+++ b/tests/xfs/289
@@ -13,8 +13,8 @@ _begin_fstest growfs auto quick
 # Override the default cleanup function.
 _cleanup()
 {
-    $UMOUNT_PROG $tmpdir
-    $UMOUNT_PROG $tmpbind
+    _unmount $tmpdir
+    _unmount $tmpbind
     rmdir $tmpdir
     rm -f $tmpsymlink
     rmdir $tmpbind
diff --git a/tests/xfs/507 b/tests/xfs/507
index 75c183c07..52d9b94b4 100755
--- a/tests/xfs/507
+++ b/tests/xfs/507
@@ -22,7 +22,7 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
 	cd /
-	test -n "$loop_mount" && $UMOUNT_PROG $loop_mount > /dev/null 2>&1
+	test -n "$loop_mount" && _unmount $loop_mount > /dev/null 2>&1
 	test -n "$loop_dev" && _destroy_loop_device $loop_dev
 	rm -rf $tmp.*
 }
diff --git a/tests/xfs/513 b/tests/xfs/513
index 5585a9c8e..5895e6e2d 100755
--- a/tests/xfs/513
+++ b/tests/xfs/513
@@ -14,7 +14,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
-	$UMOUNT_PROG $LOOP_MNT 2>/dev/null
+	_unmount $LOOP_MNT 2>/dev/null
 	if [ -n "$LOOP_DEV" ];then
 		_destroy_loop_device $LOOP_DEV 2>/dev/null
 	fi
@@ -89,7 +89,7 @@ get_mount_info()
 
 force_unmount()
 {
-	$UMOUNT_PROG $LOOP_MNT >/dev/null 2>&1
+	_unmount $LOOP_MNT >/dev/null 2>&1
 }
 
 # _do_test <mount options> <should be mounted?> [<key string> <key should be found?>]
diff --git a/tests/xfs/544 b/tests/xfs/544
index bd694453d..b7eef51c7 100755
--- a/tests/xfs/544
+++ b/tests/xfs/544
@@ -15,7 +15,7 @@ _cleanup()
 	_cleanup_dump
 	cd /
 	rm -r -f $tmp.*
-	$UMOUNT_PROG $TEST_DIR/dest.$seq 2> /dev/null
+	_unmount $TEST_DIR/dest.$seq 2> /dev/null
 	rmdir $TEST_DIR/src.$seq 2> /dev/null
 	rmdir $TEST_DIR/dest.$seq 2> /dev/null
 }
diff --git a/tests/xfs/606 b/tests/xfs/606
index 02de601d6..f958bddd8 100755
--- a/tests/xfs/606
+++ b/tests/xfs/606
@@ -14,7 +14,7 @@ _begin_fstest auto quick growfs
 _cleanup()
 {
 	local dev
-	$UMOUNT_PROG $LOOP_MNT 2>/dev/null
+	_unmount $LOOP_MNT 2>/dev/null
 	dev=$(losetup -j testfile | cut -d: -f1)
 	losetup -d $dev 2>/dev/null
 	rm -rf $LOOP_IMG $LOOP_MNT
diff --git a/tests/xfs/613 b/tests/xfs/613
index 1947afec7..6ba3d87bf 100755
--- a/tests/xfs/613
+++ b/tests/xfs/613
@@ -14,7 +14,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
-	$UMOUNT_PROG $LOOP_MNT 2>/dev/null
+	_unmount $LOOP_MNT 2>/dev/null
 	if [ -n "$LOOP_DEV" ];then
 		_destroy_loop_device $LOOP_DEV 2>/dev/null
 	fi
@@ -90,7 +90,7 @@ get_mount_info()
 
 force_unmount()
 {
-	$UMOUNT_PROG $LOOP_MNT >/dev/null 2>&1
+	_unmount $LOOP_MNT >/dev/null 2>&1
 }
 
 # _do_test <mount options> <should be mounted?> [<key string> <key should be found?>]
-- 
2.45.2

