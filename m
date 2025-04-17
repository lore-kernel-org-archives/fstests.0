Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397F1C863C
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859541; cv=none; b=WgTXfrfbXfbYdH+x2M9DjxLouT9SDu773NtIeRyYRsIM2KGce5NKHY3/gm/zEyOxPP3NMggJMGLD3YL4Zxez1peXthk1osHzDy/eLKxhwMm+2i71fiWZbSpzTShCNggsEbhcUT1KuOMHxhz10jVE6rP29JlgJ4fkYprKMQjcwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859541; c=relaxed/simple;
	bh=uuMPLIBU7cJDbcAkrJLkf0HsM2FHUQGeA/6b3R423F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5s/D1a+tS3VV2Y1ccAk4SkSKuX2WGwy3DF5Kry+nn9/mFLiJ7TX6ZQjb1YCOgz6BsgwHwcUiaPFjX0P260XO9PfXwK9k1HwGPkAQxWpnqPgMWGipSREp1bMeRwRH6vWBBvxSJVft9QegyxmgyrXzQnPsJmDAZYdckm0tjT9pyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QWGIR75N; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QWGIR75N"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30863b48553so1044925a91.0
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859538; x=1745464338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F40o/F8DHAUb7JGo1HgZQfhxrXurfruJpiclNcBOsWs=;
        b=QWGIR75NBTF91NCOFbpODLRbQtbOPGHP0GQvmkD3I73tO7DuR0Td/17x8XnMtWq+7V
         iWg5aqR+RPX+44zlCCXOpumEgJtzKBMHL9ha2jO4fv8CZl5hu5u7weGrGlXTn5Yg9IpI
         z+DIqF5CZwWcvw1MrckGGFjoti90eyVLvWdHwB1ObY7OjwZeG49uai3BTxSndh9mQvWu
         rlFz+y4/XODE34i8p3gZtdk547dwwLXP+Iqt2EihcecrGp5eIRxAgqOeLcc6CckOjTtW
         PE6IYW/QrDedK7gFbuU7Z2//w5w6mdmTon9pUO7SkKHwNJTsfTTsTYZk72jApklBdEqK
         7M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859538; x=1745464338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F40o/F8DHAUb7JGo1HgZQfhxrXurfruJpiclNcBOsWs=;
        b=uW+166SaK7QZQlVVEtZgU4L2lwoTYiKk2fPQ/ntjcARCBaelwsyOKU0zfyysZ6hAX0
         9u8OiRdxlMdmxN3x0/ajEXIDXGmG8ddXirYM1ro1OVzMXfrnE0ZBYx44MOOr5D/fT4f8
         8Ipo/0e3AfZp1t2ycuxs+9VVdfP79tY9u5r7NdfsjRos9lEXF9yARuT6ZetedGoT52L8
         F5SIiQVSVdju5Qc9WMOUCG1LVz70kdqkw/0LfQYIHn3bdcHUlEQc4pd4NHoqjwhfHDkk
         Q8vHexIyF1wmVQAZQaXvzyCL1P9+0bW0VVemDrFIXtC7gs+KMFPq9GR/ygBmPujfphWl
         dC7w==
X-Gm-Message-State: AOJu0Yw5Li9SVe/jdaN04YTFkmB3Py3mtdyEIqmaPQ6VelP6YqI3MOYu
	vT+zIGnfB+nHEfxwn+wS1aQ6F1iaQSeZhuP14LXKBowKtOIiYGLELR/ndG63JbF/KQTAaReWMPg
	R
X-Gm-Gg: ASbGncvvhzKuVLA/zcZibh+QEL4tdWeQDLOviiA5xDhM4FMrMkI3u4OVKNgJfGIJOKt
	2JjQtTmd8rT+hdkLO6yIi8mQQ+Xi4gKKRsubHaO1XlNEDcjPpYzdqkr71RSBDKGj9CJHs/oC8uV
	0RN+EQB67A473m+8XRANyR3E3TNn/vlz40j7jcyfbwOtvRCvQlYWSyzdu+yQguFARg1C7doCVNr
	dcEh41bGqgY9Nx+q1tPFC/HrejkX9vBrVVtLqKsXGiDRsM0xEt3Bzm3KQWFYZyOUEGwaJKhR19I
	/277GdT7/bDthXOW+NR1+JGFVuFZjz58mcWrM+GjznD2QJ5uOh933z/X2hMrsUlV14XKLVQrBbe
	7rkDQ2ZMgKp5s
X-Google-Smtp-Source: AGHT+IHBix3hEfImwdDLoQrY1FnTEqwcFCriP7LHSw2sxGEqWhgfTOFwRLE+IqGrrTl/S679RS+zDA==
X-Received: by 2002:a17:90b:1d48:b0:2f9:d0cd:3403 with SMTP id 98e67ed59e1d1-3086f6f68abmr1829013a91.16.1744859538279;
        Wed, 16 Apr 2025 20:12:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30861212ff4sm2465980a91.24.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:14 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YA5-195d;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mEp-21Lk;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 12/28] config: move config section code to it's own file
Date: Thu, 17 Apr 2025 13:00:53 +1000
Message-ID: <20250417031208.1852171-13-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417031208.1852171-1-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Move the config section parsing, checking and setup code from
common/config to common/config-section so that it can be included
directly in contexts where the rest of common/config is not needed.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/config          | 382 +---------------------------------------
 common/config-sections | 390 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 392 insertions(+), 380 deletions(-)
 create mode 100644 common/config-sections

diff --git a/common/config b/common/config
index 5081c300a..f90a66862 100644
--- a/common/config
+++ b/common/config
@@ -41,6 +41,7 @@
 
 . common/test_names
 . common/exit
+. common/config-sections
 
 # all tests should use a common language setting to prevent golden
 # output mismatches.
@@ -544,386 +545,7 @@ _source_specific_fs()
 	esac
 }
 
-known_hosts()
-{
-	[ "$HOST_CONFIG_DIR" ] || HOST_CONFIG_DIR=`pwd`/configs
-
-	[ -f /etc/xfsqa.config ]             && export HOST_OPTIONS=/etc/xfsqa.config
-	[ -f $HOST_CONFIG_DIR/$HOST ]        && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST
-	[ -f $HOST_CONFIG_DIR/$HOST.config ] && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST.config
-}
-
-# Returns a list of sections in config file
-# Each section starts with the section name in the format
-# [section_name1]. Only alphanumeric characters and '_' is allowed
-# in the section name otherwise the section will not be resognised.
-# Section name must be contained between square brackets.
-get_config_sections() {
-	sed -n -e "s/^\[\([[:alnum:]_-]*\)\]/\1/p" < $1
-}
-
-if [ ! -f "$HOST_OPTIONS" ]; then
-	known_hosts
-fi
-
-export HOST_OPTIONS_SECTIONS="-no-sections-"
-export OPTIONS_HAVE_SECTIONS=false
-if [ -f "$HOST_OPTIONS" ]; then
-	export HOST_OPTIONS_SECTIONS=`get_config_sections $HOST_OPTIONS`
-	if [ -z "$HOST_OPTIONS_SECTIONS" ]; then
-		. $HOST_OPTIONS
-		export HOST_OPTIONS_SECTIONS="-no-sections-"
-	else
-		export OPTIONS_HAVE_SECTIONS=true
-	fi
-fi
-
-_check_device()
-{
-	local name=$1
-	local dev_needed=$2
-	local dev=$3
-
-	if [ -z "$dev" ]; then
-		if [ "$dev_needed" == "required" ]; then
-			_fatal "common/config: $name is required but not defined!"
-		fi
-		return 0
-	fi
-
-	if [ -b "$dev" ] || ( echo $dev | grep -qE ":|//" ); then
-		# block device or a network url
-		return 0
-	fi
-
-	case "$FSTYP" in
-	9p|fuse|tmpfs|virtiofs|afs)
-		# 9p, fuse, virtiofs and afs mount tags are just plain strings,
-		# so anything is allowed tmpfs doesn't use mount source, ignore
-		;;
-	ceph)
-		# ceph has two different possible syntaxes for mount devices. The
-		# network URL check above catches the legacy syntax. Check for the
-		# new-style syntax here.
-		if ( echo $dev | grep -qEv "=/" ); then
-			_fatal "common/config: $name ($dev) is not a valid ceph mount string"
-		fi
-		;;
-	overlay)
-		if [ ! -d "$dev" ]; then
-			_fatal "common/config: $name ($dev) is not a directory for overlay"
-		fi
-		;;
-	ubifs)
-		if [ ! -c "$dev" ]; then
-			_fatal "common/config: $name ($dev) is not a character device"
-		fi
-		;;
-	ceph-fuse)
-		;;
-	*)
-		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
-	esac
-}
-
-# check and return a canonical mount point path
-_canonicalize_mountpoint()
-{
-	local name=$1
-	local dir=$2
-
-	if [ -d "$dir" ]; then
-		# this follows symlinks and removes all trailing "/"s
-		readlink -e "$dir"
-		return 0
-	fi
-
-	if [ "$FSTYP" != "overlay" ] || [[ "$name" == OVL_BASE_* ]]; then
-		_fatal "common/config: $name ($dir) is not a directory"
-	fi
-
-	# base fs may not be mounted yet, so just check that parent dir
-	# exists (where base fs will be mounted) because we are going to
-	# mkdir the overlay mount point dir anyway
-	local base=`basename $dir`
-	local parent=`dirname $dir`
-	parent=`_canonicalize_mountpoint OVL_BASE_$name "$parent"`
-
-	# prepend the overlay mount point to canonical parent path
-	echo "$parent/$base"
-}
-
-# Enables usage of /dev/disk/by-id/ symlinks to persist target devices
-# over reboots
-_canonicalize_devices()
-{
-	if [ "$CANON_DEVS" != "yes" ]; then
-		return
-	fi
-	[ -L "$TEST_DEV" ]	&& TEST_DEV=$(readlink -e "$TEST_DEV")
-	[ -L "$SCRATCH_DEV" ]	&& SCRATCH_DEV=$(readlink -e "$SCRATCH_DEV")
-	[ -L "$TEST_LOGDEV" ]	&& TEST_LOGDEV=$(readlink -e "$TEST_LOGDEV")
-	[ -L "$TEST_RTDEV" ]	&& TEST_RTDEV=$(readlink -e "$TEST_RTDEV")
-	[ -L "$SCRATCH_RTDEV" ]	&& SCRATCH_RTDEV=$(readlink -e "$SCRATCH_RTDEV")
-	[ -L "$LOGWRITES_DEV" ]	&& LOGWRITES_DEV=$(readlink -e "$LOGWRITES_DEV")
-	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
-		local NEW_SCRATCH_POOL=""
-		for i in $SCRATCH_DEV_POOL; do
-			if [ -L $i ]; then
-				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $(readlink -e $i)"
-			else
-				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i"
-			fi
-		done
-		SCRATCH_DEV_POOL="$NEW_SCRATCH_POOL"
-	fi
-}
-
-# On check -overlay, for the non multi section config case, this
-# function is called on every test, before init_rc().
-# When SCRATCH/TEST_* vars are defined in config file, config file
-# is sourced on every test and this function overrides the vars
-# every time.
-# When SCRATCH/TEST_* vars are defined in evironment and not
-# in config file, this function is called after vars have already
-# been overriden in the previous test.
-# In that case, TEST_DEV is a directory and not a blockdev/chardev and
-# the function will return without overriding the SCRATCH/TEST_* vars.
-_overlay_config_override()
-{
-	# There are 2 options for configuring overlayfs tests:
-	#
-	# 1. (legacy) SCRATCH/TEST_DEV point to existing directories
-	#    on an already mounted fs.  In this case, the new
-	#    OVL_BASE_SCRATCH/TEST_* vars are set to use the legacy
-	#    vars values (even though they may not be mount points).
-	#
-	[ ! -d "$TEST_DEV" ] || export OVL_BASE_TEST_DIR="$TEST_DEV"
-	[ ! -d "$SCRATCH_DEV" ] || export OVL_BASE_SCRATCH_MNT="$SCRATCH_DEV"
-
-	# Config file may specify base fs type, but we obay -overlay flag
-	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
-	export FSTYP=overlay
-
-	# 2. SCRATCH/TEST_DEV point to the base fs partitions.  In this case,
-	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
-	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
-	#    overlayfs base and mount dirs inside base fs mount.
-	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
-
-	# Store original base fs vars
-	export OVL_BASE_TEST_DEV="$TEST_DEV"
-	export OVL_BASE_TEST_DIR="$TEST_DIR"
-	# If config does not set MOUNT_OPTIONS, its value may be
-	# leftover from previous _overlay_config_override, so
-	# don't use that value for base fs mount
-	[ "$MOUNT_OPTIONS" != "$OVERLAY_MOUNT_OPTIONS" ] || unset MOUNT_OPTIONS
-	export OVL_BASE_MOUNT_OPTIONS="$MOUNT_OPTIONS"
-
-	# Set TEST vars to overlay base and mount dirs inside base fs
-	export TEST_DEV="$OVL_BASE_TEST_DIR"
-	export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
-	export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
-
-	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
-
-	# Store original base fs vars
-	export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
-	export OVL_BASE_SCRATCH_MNT="$SCRATCH_MNT"
-
-	# Set SCRATCH vars to overlay base and mount dirs inside base fs
-	export SCRATCH_DEV="$OVL_BASE_SCRATCH_MNT"
-	export SCRATCH_MNT="$OVL_BASE_SCRATCH_MNT/$OVL_MNT"
-
-	# Set fsck options, use default if user not set directly.
-	export FSCK_OPTIONS="$OVERLAY_FSCK_OPTIONS"
-	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
-	export IDMAPPED_MOUNTS="$IDMAPPED_MOUNTS"
-}
-
-_overlay_config_restore()
-{
-	export OVERLAY=true
-	[ -z "$OVL_BASE_FSTYP" ] || export FSTYP=$OVL_BASE_FSTYP
-	[ -z "$OVL_BASE_TEST_DEV" ] || export TEST_DEV=$OVL_BASE_TEST_DEV
-	[ -z "$OVL_BASE_TEST_DIR" ] || export TEST_DIR=$OVL_BASE_TEST_DIR
-	[ -z "$OVL_BASE_SCRATCH_DEV" ] || export SCRATCH_DEV=$OVL_BASE_SCRATCH_DEV
-	[ -z "$OVL_BASE_SCRATCH_MNT" ] || export SCRATCH_MNT=$OVL_BASE_SCRATCH_MNT
-	[ -z "$OVL_BASE_MOUNT_OPTIONS" ] || export MOUNT_OPTIONS=$OVL_BASE_MOUNT_OPTIONS
-}
-
-# Parse config section options. This function will parse all the configuration
-# within a single section which name is passed as an argument. For section
-# name format see comments in get_config_sections().
-# Empty lines and everything after '#' will be ignored.
-# Configuration options should be defined in the format
-#
-# CONFIG_OPTION=value
-#
-# This 'CONFIG_OPTION' variable and will be exported as an environment variable.
-parse_config_section() {
-	SECTION=$1
-	if ! $OPTIONS_HAVE_SECTIONS; then
-		return 0
-	fi
-	eval `sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
-		-e 's/#.*$//' \
-		-e 's/[[:space:]]*$//' \
-		-e 's/^[[:space:]]*//' \
-		-e "s/^\([^=]*\)=\"\?'\?\([^\"']*\)\"\?'\?$/export \1=\"\2\"/" \
-		< $HOST_OPTIONS \
-		| sed -n -e "/^\[$SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}"`
-}
-
-get_next_config() {
-	if [ ! -z "$CONFIG_INCLUDED" ] && ! $OPTIONS_HAVE_SECTIONS; then
-		return 0
-	fi
-
-	# We might have overriden FSTYP and TEST/SCRATCH vars with overlay values
-	# in the previous section, so restore them to original values stored in
-	# OVL_BASE_*.
-	# We need to do this *before* old FSTYP and MOUNT_OPTIONS are recorded
-	# and *before* SCRATCH_DEV and MOUNT_OPTIONS are unset
-	if [ "$FSTYP" == "overlay" ]; then
-		_overlay_config_restore
-	fi
-
-	local OLD_FSTYP=$FSTYP
-	local OLD_MOUNT_OPTIONS=$MOUNT_OPTIONS
-	local OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
-	local OLD_MKFS_OPTIONS=$MKFS_OPTIONS
-	local OLD_FSCK_OPTIONS=$FSCK_OPTIONS
-	local OLD_USE_EXTERNAL=$USE_EXTERNAL
-
-	unset MOUNT_OPTIONS
-	unset TEST_FS_MOUNT_OPTS
-	unset MKFS_OPTIONS
-	unset FSCK_OPTIONS
-	unset USE_EXTERNAL
-
-	# We might have deduced SCRATCH_DEV from the SCRATCH_DEV_POOL in the previous
-	# run, so we have to unset it now.
-	if [ "$SCRATCH_DEV_NOT_SET" == "true" ]; then
-		unset SCRATCH_DEV
-	fi
-
-	parse_config_section $1
-	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
-		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
-		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
-		[ -z "$MKFS_OPTIONS" ] && _mkfs_opts
-		[ -z "$FSCK_OPTIONS" ] && _fsck_opts
-
-		# clear the external devices if we are not using them
-		if [ -z "$USE_EXTERNAL" ]; then
-			unset TEST_RTDEV
-			unset TEST_LOGDEV
-			unset SCRATCH_RTDEV
-			unset SCRATCH_LOGDEV
-		fi
-	else
-		[ -z "$MOUNT_OPTIONS" ] && export MOUNT_OPTIONS=$OLD_MOUNT_OPTIONS
-		[ -z "$TEST_FS_MOUNT_OPTS" ] && export TEST_FS_MOUNT_OPTS=$OLD_TEST_FS_MOUNT_OPTS
-		[ -z "$MKFS_OPTIONS" ] && export MKFS_OPTIONS=$OLD_MKFS_OPTIONS
-		[ -z "$FSCK_OPTIONS" ] && export FSCK_OPTIONS=$OLD_FSCK_OPTIONS
-		[ -z "$USE_EXTERNAL" ] && export USE_EXTERNAL=$OLD_USE_EXTERNAL
-	fi
-
-	# set default RESULT_BASE
-	if [ -z "$RESULT_BASE" ]; then
-		export RESULT_BASE="$here/results/"
-	fi
-
-	if [ "$FSTYP" == "tmpfs" ]; then
-		if [ -z "$TEST_DEV" ]; then
-			export TEST_DEV=tmpfs_test
-		fi
-		if [ -z "$SCRATCH_DEV" ]; then
-			export TEST_DEV=tmpfs_scratch
-		fi
-	fi
-
-	#  Mandatory Config values.
-	MC=""
-	[ -z "$EMAIL" ]          && MC="$MC EMAIL"
-	[ -z "$TEST_DIR" ]       && MC="$MC TEST_DIR"
-	[ -z "$TEST_DEV" ]       && MC="$MC TEST_DEV"
-
-	if [ -n "$MC" ]; then
-		echo "Warning: need to define parameters for host $HOST"
-		echo "       or set variables:"
-		echo "       $MC"
-		_exit 1
-	fi
-
-	_check_device TEST_DEV required $TEST_DEV
-	export TEST_DIR=`_canonicalize_mountpoint TEST_DIR $TEST_DIR`
-
-	# a btrfs tester will set only SCRATCH_DEV_POOL, we will put first of its dev
-	# to SCRATCH_DEV and rest to SCRATCH_DEV_POOL to maintain the backward compatibility
-	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
-		if [ ! -z "$SCRATCH_DEV" ]; then
-			echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) should be unset when \$SCRATCH_DEV_POOL ($SCRATCH_DEV_POOL) is set"
-			_exit 1
-		fi
-		SCRATCH_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
-		export SCRATCH_DEV
-		export SCRATCH_DEV_NOT_SET=true
-	fi
-
-	_check_device SCRATCH_DEV optional $SCRATCH_DEV
-	export SCRATCH_MNT=`_canonicalize_mountpoint SCRATCH_MNT $SCRATCH_MNT`
-
-	if [ -n "$USE_EXTERNAL" ]; then
-		_check_device TEST_RTDEV optional $TEST_RTDEV
-		_check_device TEST_LOGDEV optional $TEST_LOGDEV
-		_check_device SCRATCH_RTDEV optional $SCRATCH_RTDEV
-		_check_device SCRATCH_LOGDEV optional $SCRATCH_LOGDEV
-	fi
-
-	# Override FSTYP from config when running ./check -overlay
-	# and maybe override base fs TEST/SCRATCH_DEV with overlay base dirs.
-	# We need to do this *after* default mount options are set by base FSTYP
-	# and *after* SCRATCH_DEV is deduced from SCRATCH_DEV_POOL
-	if [ "$OVERLAY" == "true" -o "$FSTYP" == "overlay" ]; then
-		_overlay_config_override
-	fi
-}
-
-if [ -z "$CONFIG_INCLUDED" ]; then
-	get_next_config `echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "`
-	export CONFIG_INCLUDED=true
-
-	# Autodetect fs type based on what's on $TEST_DEV unless it's been set
-	# externally
-	if [ -z "$FSTYP" ] && [ ! -z "$TEST_DEV" ]; then
-		FSTYP=`blkid -c /dev/null -s TYPE -o value $TEST_DEV`
-	fi
-	FSTYP=${FSTYP:=xfs}
-	export FSTYP
-	[ -z "$MOUNT_OPTIONS" ] && _mount_opts
-	[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
-	[ -z "$MKFS_OPTIONS" ] && _mkfs_opts
-	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
-else
-	# We get here for the non multi section case, on every test that sources
-	# common/rc after re-sourcing the HOST_OPTIONS config file.
-	# Because of this re-sourcing, we need to re-canonicalize the configured
-	# mount points and re-override TEST/SCRATCH_DEV overlay vars.
-
-	# canonicalize the mount points
-	# this follows symlinks and removes all trailing "/"s
-	export TEST_DIR=`_canonicalize_mountpoint TEST_DIR $TEST_DIR`
-	export SCRATCH_MNT=`_canonicalize_mountpoint SCRATCH_MNT $SCRATCH_MNT`
-
-	# Override FSTYP from config when running ./check -overlay
-	# and maybe override base fs TEST/SCRATCH_DEV with overlay base dirs
-	if [ "$OVERLAY" == "true" -o "$FSTYP" == "overlay" ]; then
-		_overlay_config_override
-	fi
-fi
-
+_config_section_setup
 _canonicalize_devices
 # mkfs.xfs checks for TEST_DEV before permitting < 300M filesystems. TEST_DIR
 # and QA_CHECK_FS are also checked by mkfs.xfs, but already exported elsewhere.
diff --git a/common/config-sections b/common/config-sections
new file mode 100644
index 000000000..69a03375a
--- /dev/null
+++ b/common/config-sections
@@ -0,0 +1,390 @@
+##/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2000-2003,2006 Silicon Graphics, Inc.  All Rights Reserved.
+# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
+#
+# Config section parsing and setup code
+
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
+		return 0
+	fi
+
+	if [ -b "$dev" ] || ( echo $dev | grep -qE ":|//" ); then
+		# block device or a network url
+		return 0
+	fi
+
+	case "$FSTYP" in
+	9p|fuse|tmpfs|virtiofs|afs)
+		# 9p, fuse, virtiofs and afs mount tags are just plain strings,
+		# so anything is allowed tmpfs doesn't use mount source, ignore
+		;;
+	ceph)
+		# ceph has two different possible syntaxes for mount devices. The
+		# network URL check above catches the legacy syntax. Check for the
+		# new-style syntax here.
+		if ( echo $dev | grep -qEv "=/" ); then
+			_fatal "common/config: $name ($dev) is not a valid ceph mount string"
+		fi
+		;;
+	overlay)
+		if [ ! -d "$dev" ]; then
+			_fatal "common/config: $name ($dev) is not a directory for overlay"
+		fi
+		;;
+	ubifs)
+		if [ ! -c "$dev" ]; then
+			_fatal "common/config: $name ($dev) is not a character device"
+		fi
+		;;
+	ceph-fuse)
+		;;
+	*)
+		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
+	esac
+}
+
+# check and return a canonical mount point path
+_canonicalize_mountpoint()
+{
+	local name=$1
+	local dir=$2
+
+	if [ -d "$dir" ]; then
+		# this follows symlinks and removes all trailing "/"s
+		readlink -e "$dir"
+		return 0
+	fi
+
+	if [ "$FSTYP" != "overlay" ] || [[ "$name" == OVL_BASE_* ]]; then
+		_fatal "common/config: $name ($dir) is not a directory"
+	fi
+
+	# base fs may not be mounted yet, so just check that parent dir
+	# exists (where base fs will be mounted) because we are going to
+	# mkdir the overlay mount point dir anyway
+	local base=`basename $dir`
+	local parent=`dirname $dir`
+	parent=`_canonicalize_mountpoint OVL_BASE_$name "$parent"`
+
+	# prepend the overlay mount point to canonical parent path
+	echo "$parent/$base"
+}
+
+# Enables usage of /dev/disk/by-id/ symlinks to persist target devices
+# over reboots
+_canonicalize_devices()
+{
+	if [ "$CANON_DEVS" != "yes" ]; then
+		return
+	fi
+	[ -L "$TEST_DEV" ]	&& TEST_DEV=$(readlink -e "$TEST_DEV")
+	[ -L "$SCRATCH_DEV" ]	&& SCRATCH_DEV=$(readlink -e "$SCRATCH_DEV")
+	[ -L "$TEST_LOGDEV" ]	&& TEST_LOGDEV=$(readlink -e "$TEST_LOGDEV")
+	[ -L "$TEST_RTDEV" ]	&& TEST_RTDEV=$(readlink -e "$TEST_RTDEV")
+	[ -L "$SCRATCH_RTDEV" ]	&& SCRATCH_RTDEV=$(readlink -e "$SCRATCH_RTDEV")
+	[ -L "$LOGWRITES_DEV" ]	&& LOGWRITES_DEV=$(readlink -e "$LOGWRITES_DEV")
+	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
+		local NEW_SCRATCH_POOL=""
+		for i in $SCRATCH_DEV_POOL; do
+			if [ -L $i ]; then
+				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $(readlink -e $i)"
+			else
+				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i"
+			fi
+		done
+		SCRATCH_DEV_POOL="$NEW_SCRATCH_POOL"
+	fi
+}
+
+# On check -overlay, for the non multi section config case, this
+# function is called on every test, before init_rc().
+# When SCRATCH/TEST_* vars are defined in config file, config file
+# is sourced on every test and this function overrides the vars
+# every time.
+# When SCRATCH/TEST_* vars are defined in evironment and not
+# in config file, this function is called after vars have already
+# been overriden in the previous test.
+# In that case, TEST_DEV is a directory and not a blockdev/chardev and
+# the function will return without overriding the SCRATCH/TEST_* vars.
+_overlay_config_override()
+{
+	# There are 2 options for configuring overlayfs tests:
+	#
+	# 1. (legacy) SCRATCH/TEST_DEV point to existing directories
+	#    on an already mounted fs.  In this case, the new
+	#    OVL_BASE_SCRATCH/TEST_* vars are set to use the legacy
+	#    vars values (even though they may not be mount points).
+	#
+	[ ! -d "$TEST_DEV" ] || export OVL_BASE_TEST_DIR="$TEST_DEV"
+	[ ! -d "$SCRATCH_DEV" ] || export OVL_BASE_SCRATCH_MNT="$SCRATCH_DEV"
+
+	# Config file may specify base fs type, but we obay -overlay flag
+	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
+	export FSTYP=overlay
+
+	# 2. SCRATCH/TEST_DEV point to the base fs partitions.  In this case,
+	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
+	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
+	#    overlayfs base and mount dirs inside base fs mount.
+	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
+
+	# Store original base fs vars
+	export OVL_BASE_TEST_DEV="$TEST_DEV"
+	export OVL_BASE_TEST_DIR="$TEST_DIR"
+	# If config does not set MOUNT_OPTIONS, its value may be
+	# leftover from previous _overlay_config_override, so
+	# don't use that value for base fs mount
+	[ "$MOUNT_OPTIONS" != "$OVERLAY_MOUNT_OPTIONS" ] || unset MOUNT_OPTIONS
+	export OVL_BASE_MOUNT_OPTIONS="$MOUNT_OPTIONS"
+
+	# Set TEST vars to overlay base and mount dirs inside base fs
+	export TEST_DEV="$OVL_BASE_TEST_DIR"
+	export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
+	export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
+
+	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
+
+	# Store original base fs vars
+	export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
+	export OVL_BASE_SCRATCH_MNT="$SCRATCH_MNT"
+
+	# Set SCRATCH vars to overlay base and mount dirs inside base fs
+	export SCRATCH_DEV="$OVL_BASE_SCRATCH_MNT"
+	export SCRATCH_MNT="$OVL_BASE_SCRATCH_MNT/$OVL_MNT"
+
+	# Set fsck options, use default if user not set directly.
+	export FSCK_OPTIONS="$OVERLAY_FSCK_OPTIONS"
+	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
+	export IDMAPPED_MOUNTS="$IDMAPPED_MOUNTS"
+}
+
+_overlay_config_restore()
+{
+	export OVERLAY=true
+	[ -z "$OVL_BASE_FSTYP" ] || export FSTYP=$OVL_BASE_FSTYP
+	[ -z "$OVL_BASE_TEST_DEV" ] || export TEST_DEV=$OVL_BASE_TEST_DEV
+	[ -z "$OVL_BASE_TEST_DIR" ] || export TEST_DIR=$OVL_BASE_TEST_DIR
+	[ -z "$OVL_BASE_SCRATCH_DEV" ] || export SCRATCH_DEV=$OVL_BASE_SCRATCH_DEV
+	[ -z "$OVL_BASE_SCRATCH_MNT" ] || export SCRATCH_MNT=$OVL_BASE_SCRATCH_MNT
+	[ -z "$OVL_BASE_MOUNT_OPTIONS" ] || export MOUNT_OPTIONS=$OVL_BASE_MOUNT_OPTIONS
+}
+
+# Returns a list of sections in config file
+# Each section starts with the section name in the format
+# [section_name1]. Only alphanumeric characters and '_' is allowed
+# in the section name otherwise the section will not be resognised.
+# Section name must be contained between square brackets.
+get_config_sections() {
+	sed -n -e "s/^\[\([[:alnum:]_-]*\)\]/\1/p" < $1
+}
+
+# Parse config section options. This function will parse all the configuration
+# within a single section which name is passed as an argument. For section
+# name format see comments in get_config_sections().
+# Empty lines and everything after '#' will be ignored.
+# Configuration options should be defined in the format
+#
+# CONFIG_OPTION=value
+#
+# This 'CONFIG_OPTION' variable and will be exported as an environment variable.
+parse_config_section() {
+	SECTION=$1
+	if ! $OPTIONS_HAVE_SECTIONS; then
+		return 0
+	fi
+	eval `sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
+		-e 's/#.*$//' \
+		-e 's/[[:space:]]*$//' \
+		-e 's/^[[:space:]]*//' \
+		-e "s/^\([^=]*\)=\"\?'\?\([^\"']*\)\"\?'\?$/export \1=\"\2\"/" \
+		< $HOST_OPTIONS \
+		| sed -n -e "/^\[$SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}"`
+}
+
+get_next_config() {
+	if [ ! -z "$CONFIG_INCLUDED" ] && ! $OPTIONS_HAVE_SECTIONS; then
+		return 0
+	fi
+
+	# We might have overriden FSTYP and TEST/SCRATCH vars with overlay values
+	# in the previous section, so restore them to original values stored in
+	# OVL_BASE_*.
+	# We need to do this *before* old FSTYP and MOUNT_OPTIONS are recorded
+	# and *before* SCRATCH_DEV and MOUNT_OPTIONS are unset
+	if [ "$FSTYP" == "overlay" ]; then
+		_overlay_config_restore
+	fi
+
+	local OLD_FSTYP=$FSTYP
+	local OLD_MOUNT_OPTIONS=$MOUNT_OPTIONS
+	local OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
+	local OLD_MKFS_OPTIONS=$MKFS_OPTIONS
+	local OLD_FSCK_OPTIONS=$FSCK_OPTIONS
+	local OLD_USE_EXTERNAL=$USE_EXTERNAL
+
+	unset MOUNT_OPTIONS
+	unset TEST_FS_MOUNT_OPTS
+	unset MKFS_OPTIONS
+	unset FSCK_OPTIONS
+	unset USE_EXTERNAL
+
+	# We might have deduced SCRATCH_DEV from the SCRATCH_DEV_POOL in the previous
+	# run, so we have to unset it now.
+	if [ "$SCRATCH_DEV_NOT_SET" == "true" ]; then
+		unset SCRATCH_DEV
+	fi
+
+	parse_config_section $1
+	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
+		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
+		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
+		[ -z "$MKFS_OPTIONS" ] && _mkfs_opts
+		[ -z "$FSCK_OPTIONS" ] && _fsck_opts
+
+		# clear the external devices if we are not using them
+		if [ -z "$USE_EXTERNAL" ]; then
+			unset TEST_RTDEV
+			unset TEST_LOGDEV
+			unset SCRATCH_RTDEV
+			unset SCRATCH_LOGDEV
+		fi
+	else
+		[ -z "$MOUNT_OPTIONS" ] && export MOUNT_OPTIONS=$OLD_MOUNT_OPTIONS
+		[ -z "$TEST_FS_MOUNT_OPTS" ] && export TEST_FS_MOUNT_OPTS=$OLD_TEST_FS_MOUNT_OPTS
+		[ -z "$MKFS_OPTIONS" ] && export MKFS_OPTIONS=$OLD_MKFS_OPTIONS
+		[ -z "$FSCK_OPTIONS" ] && export FSCK_OPTIONS=$OLD_FSCK_OPTIONS
+		[ -z "$USE_EXTERNAL" ] && export USE_EXTERNAL=$OLD_USE_EXTERNAL
+	fi
+
+	# set default RESULT_BASE
+	if [ -z "$RESULT_BASE" ]; then
+		export RESULT_BASE="$here/results/"
+	fi
+
+	if [ "$FSTYP" == "tmpfs" ]; then
+		if [ -z "$TEST_DEV" ]; then
+			export TEST_DEV=tmpfs_test
+		fi
+		if [ -z "$SCRATCH_DEV" ]; then
+			export TEST_DEV=tmpfs_scratch
+		fi
+	fi
+
+	#  Mandatory Config values.
+	MC=""
+	[ -z "$EMAIL" ]          && MC="$MC EMAIL"
+	[ -z "$TEST_DIR" ]       && MC="$MC TEST_DIR"
+	[ -z "$TEST_DEV" ]       && MC="$MC TEST_DEV"
+
+	if [ -n "$MC" ]; then
+		echo "Warning: need to define parameters for host $HOST"
+		echo "       or set variables:"
+		echo "       $MC"
+		_exit 1
+	fi
+
+	_check_device TEST_DEV required $TEST_DEV
+	export TEST_DIR=`_canonicalize_mountpoint TEST_DIR $TEST_DIR`
+
+	# a btrfs tester will set only SCRATCH_DEV_POOL, we will put first of its dev
+	# to SCRATCH_DEV and rest to SCRATCH_DEV_POOL to maintain the backward compatibility
+	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
+		if [ ! -z "$SCRATCH_DEV" ]; then
+			echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) should be unset when \$SCRATCH_DEV_POOL ($SCRATCH_DEV_POOL) is set"
+			_exit 1
+		fi
+		SCRATCH_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
+		export SCRATCH_DEV
+		export SCRATCH_DEV_NOT_SET=true
+	fi
+
+	_check_device SCRATCH_DEV optional $SCRATCH_DEV
+	export SCRATCH_MNT=`_canonicalize_mountpoint SCRATCH_MNT $SCRATCH_MNT`
+
+	if [ -n "$USE_EXTERNAL" ]; then
+		_check_device TEST_RTDEV optional $TEST_RTDEV
+		_check_device TEST_LOGDEV optional $TEST_LOGDEV
+		_check_device SCRATCH_RTDEV optional $SCRATCH_RTDEV
+		_check_device SCRATCH_LOGDEV optional $SCRATCH_LOGDEV
+	fi
+
+	# Override FSTYP from config when running ./check -overlay
+	# and maybe override base fs TEST/SCRATCH_DEV with overlay base dirs.
+	# We need to do this *after* default mount options are set by base FSTYP
+	# and *after* SCRATCH_DEV is deduced from SCRATCH_DEV_POOL
+	if [ "$OVERLAY" == "true" -o "$FSTYP" == "overlay" ]; then
+		_overlay_config_override
+	fi
+}
+
+known_hosts()
+{
+	[ "$HOST_CONFIG_DIR" ] || HOST_CONFIG_DIR=`pwd`/configs
+
+	[ -f /etc/xfsqa.config ]             && export HOST_OPTIONS=/etc/xfsqa.config
+	[ -f $HOST_CONFIG_DIR/$HOST ]        && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST
+	[ -f $HOST_CONFIG_DIR/$HOST.config ] && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST.config
+}
+
+_config_section_setup()
+{
+	if [ ! -f "$HOST_OPTIONS" ]; then
+		known_hosts
+	fi
+
+	export HOST_OPTIONS_SECTIONS="-no-sections-"
+	export OPTIONS_HAVE_SECTIONS=false
+	if [ -f "$HOST_OPTIONS" ]; then
+		export HOST_OPTIONS_SECTIONS=`get_config_sections $HOST_OPTIONS`
+		if [ -z "$HOST_OPTIONS_SECTIONS" ]; then
+			. $HOST_OPTIONS
+			export HOST_OPTIONS_SECTIONS="-no-sections-"
+		else
+			export OPTIONS_HAVE_SECTIONS=true
+		fi
+	fi
+
+	if [ -z "$CONFIG_INCLUDED" ]; then
+		get_next_config `echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "`
+		export CONFIG_INCLUDED=true
+
+		# Autodetect fs type based on what's on $TEST_DEV unless it's
+		# been set externally
+		if [ -z "$FSTYP" ] && [ ! -z "$TEST_DEV" ]; then
+			FSTYP=`blkid -c /dev/null -s TYPE -o value $TEST_DEV`
+		fi
+		FSTYP=${FSTYP:=xfs}
+		export FSTYP
+		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
+		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
+		[ -z "$MKFS_OPTIONS" ] && _mkfs_opts
+		[ -z "$FSCK_OPTIONS" ] && _fsck_opts
+	else
+		# We get here for the non multi section case, on every test that
+		# sources common/rc after re-sourcing the HOST_OPTIONS config
+		# file.  Because of this re-sourcing, we need to re-canonicalize
+		# the configured mount points and re-override TEST/SCRATCH_DEV
+		# overlay vars.
+
+		# canonicalize the mount points
+		# this follows symlinks and removes all trailing "/"s
+		export TEST_DIR=`_canonicalize_mountpoint TEST_DIR $TEST_DIR`
+		export SCRATCH_MNT=`_canonicalize_mountpoint SCRATCH_MNT $SCRATCH_MNT`
+
+		# Override FSTYP from config when running ./check -overlay and
+		# maybe override base fs TEST/SCRATCH_DEV with overlay base dirs
+		if [ "$OVERLAY" == "true" -o "$FSTYP" == "overlay" ]; then
+			_overlay_config_override
+		fi
+	fi
+}
-- 
2.45.2

