Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22651D5CCD
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859540; cv=none; b=iaOA2/25X9r3uEikWltIyJVfsL3q6KKNEziOewRXppTj0m4Cfx+rfB16kfzwCmXX3tDGJnLiqL0GiDrJXLZc24A2w+F50jDaUF/nmxWX/srgEwh4SCyaCb52s/mP5/M7ftFSzkqbLmc5SrPi5fUdlwrh7iDhymm9V7g6XDQtU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859540; c=relaxed/simple;
	bh=EdjYyBRBZ2BhY6rDpIi4nIF00I9iFRGHGfEZ/datDXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyKOpYy6OCnfpyxMX6PFejJqPuNpjjsJ3WyXWQC9BYW7b+bSw2J5IL55/mOYbPTXAto3iiBkhqQb9b03J7vrq/obElYQtjB/QeWG23UAK0vKN8/gOYRF4CI6Q0al/Qb+k+kbEsziJP9r+ZoHNRCPPnk2BKnQdpy/x2oNXm1MaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZKXpCLVr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZKXpCLVr"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736b34a71a1so322482b3a.0
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859538; x=1745464338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G39zxaPHNS9CEv517kypQbCAYiguEY9hCQNzcZ9YJhU=;
        b=ZKXpCLVrKejd+9Xdxd1TR5cWFW7HzvSFNMLBbLHWfC1BxfnagOOBTD0MHFZAc3WgDl
         oamFxBFaj7Dgf0p2PDWj5P5v8kjSn8BEvfHNnyXHmIT0yhu5xYF4kIxJMO7tbnwKNJ4G
         mf8Um+i45KwaB7+LKFPsz6zt4cQjUxENfYnUFb6cAsKm9jyY6lf/qrkQPLpTexdhVBI9
         G4rcfZuaeF0orapAeOHeX7ijHXXHtCrcSHYWF9koX+gveerN+/YDEdzs1KvbUpSz7NIa
         E+9v2JPPbPIMLk2tBwolmH94lEzkbebtNxTrbAPk5km68Ro4AN34D/nJJvQwbAxoz+mx
         9RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859538; x=1745464338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G39zxaPHNS9CEv517kypQbCAYiguEY9hCQNzcZ9YJhU=;
        b=C9NocL3smswu4svUxjdbOtqdCyBw5sGgH8HqbzpGecnxb9PyqFG5aE2CODOcSDaD8E
         g/PV6VDC5DefcY69WLIbnka7y26UAcHuYMpeWMBcRnwinSFHOcB3f8YZsSCbdCO8MQvL
         h3b7BGEfQ+GcbatNBgAJosoPYXSu5s5hX/UVV4hZb+YmqCgcmcJJAe0iJP28GGhED4N+
         xjMNNY55RMYCAjfPImBNpL3UmdYCnlrPk60NBIQGxpdCjMlxLsWn8Lw0kKrCU9pEaXi2
         9N1lX9AkF7zAsZqkMxC+iZ0F3a7G0oRHxUbVlqIa2KYsyMnqudOAtwV6c5NDAD1Bwo/G
         fHiA==
X-Gm-Message-State: AOJu0YyDCzK7zuWsvy7strY0diL/VSsvpjHKVgEVLWKvWvITKZ9Rt8J6
	2aE/noB43z4aWlPrDv5O5+GguuJ/3wBk68M/ZflxPUQ0KU48PwQsXV//JoPfr38ZzKZMTtLlWLz
	E
X-Gm-Gg: ASbGncvwTYztKRYTl43lGcPbrs4hvTGa2f0VPGNkyKMjLvIzNq7UGmY0ndyDfrkBluQ
	nurQFSGCXX3q6uEC0FXw3wwnwVTZUPzFUqtWbCv69uoW53uPy1wEmnEs5rzJkRDnSLL49F0wF4J
	+2DGEaP6sSNbP4SwbAjoccXONw5dlEmaJcsK80xGTQ/f0wDW9oGG78KarL5rjz5F01wvRWFzsIY
	qpNge5nH3tgDaVLu4o46RfXqEJJfMolKvLgn4i9CMiwqBsO9AKy6O98IvdHY0/Jt+6gZilk/rEx
	hpFUe+KNv4LQO8x/1lKqdQ1h25ISJeTkr3W+hwE3RsEGG7hFsWY1CQnSmXJBPxLiGJasUPdUOUE
	rh7DGCUivD5aP
X-Google-Smtp-Source: AGHT+IHIUb3u2ii2020thbvtgdYa/6E75QXhbMezgnDnWvTVmlD4DHNOAu6to7yKm+5j8f90fcI+xw==
X-Received: by 2002:a05:6a00:3a13:b0:730:8a0a:9f09 with SMTP id d2e1a72fcca58-73c267d39ebmr6243071b3a.18.1744859537784;
        Wed, 16 Apr 2025 20:12:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b220cb76fsm1663035a12.30.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:14 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YAD-1OpG;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mEy-2IAG;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 14/28] fstests: further separate sourcing common/rc and common/config from initialisation
Date: Thu, 17 Apr 2025 13:00:55 +1000
Message-ID: <20250417031208.1852171-15-david@fromorbit.com>
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

The sourcing of common/rc still causes code to be run, partially
because it sources common/config and partially because there is some
in-line code amongst all the function definitions inside common/rc

This is messy, and re-sourcing those files also does an awful
lot of setup work that isn't actually required.

common/config only needs to be included once - everything that
scripts then depend on should be exported by it, and hence it should
only be included once from check/check-parallel to set up all the
environmental parameters for the entire run.

common/rc also only needs to be included once per context, but it
does not need to directly include common config nor does it need to
run init_rc in each individual test context.

Seperate out this mess. Include common/config directly where needed
and only use it to set up the environment. Move all the code that is
in common/config to common/rc so that common/config is not needed
for any purpose other than setting up the initial environment.
Move the initialisation functions to the scripts that include
common/config.

Config file and config section parsing can be run directly from check
and/or check-parallel; this is not needed for every context that
needs to know how what XFS_MKFS_PROG is set to...

Similarly, include common/rc only once, and only call init_rc or
_source_specific_fs() from the contexts that actually need that code
to be run.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check           |  23 ++---
 common/config   | 212 --------------------------------------------
 common/preamble |  18 +++-
 common/rc       | 227 ++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 240 insertions(+), 240 deletions(-)

diff --git a/check b/check
index 0b489cb4b..fea86f7b9 100755
--- a/check
+++ b/check
@@ -46,6 +46,9 @@ rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
 . ./common/exit
 . ./common/test_names
 . ./common/test_list
+. ./common/config
+. ./common/config-sections
+. ./common/rc
 
 usage()
 {
@@ -183,15 +186,17 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
-# we need common/rc, that also sources common/config. We need to source it
-# after processing args, overlay needs FSTYP set before sourcing common/config
-if ! . ./common/rc; then
-	echo "check: failed to source common/rc"
-	exit 1
-fi
-
+# now we have done argument parsing, overlay has FSTYP set and we can now
+# start processing the config files and setting up devices.
+_config_section_setup
+_canonicalize_devices
 init_rc
 
+if [ ! -z "$REPORT_LIST" ]; then
+	. ./common/report
+	_assert_report_list
+fi
+
 # If the test config specified a soak test duration, see if there are any
 # unit suffixes that need converting to an integer seconds count.
 if [ -n "$SOAK_DURATION" ]; then
@@ -553,10 +558,6 @@ function run_section()
 			status=1
 			exit
 		fi
-		# Previous FSTYP derived from TEST_DEV could be changed, source
-		# common/rc again with correct FSTYP to get FSTYP specific configs,
-		# e.g. common/xfs
-		. common/rc
 		_tl_prepare_test_list
 	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
 		# Unmount TEST_DEV to apply the updated mount options.
diff --git a/common/config b/common/config
index f90a66862..b93a6c0d3 100644
--- a/common/config
+++ b/common/config
@@ -41,7 +41,6 @@
 
 . common/test_names
 . common/exit
-. common/config-sections
 
 # all tests should use a common language setting to prevent golden
 # output mismatches.
@@ -342,214 +341,3 @@ if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
 	: ${SELINUX_MOUNT_OPTIONS:="-o context=$(stat -c %C /)"}
 	export SELINUX_MOUNT_OPTIONS
 fi
-
-_common_mount_opts()
-{
-	case $FSTYP in
-	9p)
-		echo $PLAN9_MOUNT_OPTIONS
-		;;
-	fuse)
-		echo $FUSE_MOUNT_OPTIONS
-		;;
-	xfs)
-		echo $XFS_MOUNT_OPTIONS
-		;;
-	udf)
-		echo $UDF_MOUNT_OPTIONS
-		;;
-	nfs)
-		echo $NFS_MOUNT_OPTIONS
-		;;
-	afs)
-		echo $AFS_MOUNT_OPTIONS
-		;;
-	cifs)
-		echo $CIFS_MOUNT_OPTIONS
-		;;
-	ceph)
-		echo $CEPHFS_MOUNT_OPTIONS
-		;;
-	glusterfs)
-		echo $GLUSTERFS_MOUNT_OPTIONS
-		;;
-	overlay)
-		echo $OVERLAY_MOUNT_OPTIONS
-		;;
-	ext2|ext3|ext4)
-		# acls & xattrs aren't turned on by default on ext$FOO
-		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
-		;;
-	f2fs)
-		echo "-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
-		;;
-       reiser4)
-		# acls & xattrs aren't supported by reiser4
-		echo $REISER4_MOUNT_OPTIONS
-		;;
-	gfs2)
-		# acls aren't turned on by default on gfs2
-		echo "-o acl $GFS2_MOUNT_OPTIONS"
-		;;
-	tmpfs)
-		# We need to specify the size at mount, use 1G by default
-		echo "-o size=1G $TMPFS_MOUNT_OPTIONS"
-		;;
-	ubifs)
-		echo $UBIFS_MOUNT_OPTIONS
-		;;
-	*)
-		;;
-	esac
-}
-
-_mount_opts()
-{
-	export MOUNT_OPTIONS=$(_common_mount_opts)
-}
-
-_test_mount_opts()
-{
-	export TEST_FS_MOUNT_OPTS=$(_common_mount_opts)
-}
-
-_mkfs_opts()
-{
-	case $FSTYP in
-	xfs)
-		export MKFS_OPTIONS=$XFS_MKFS_OPTIONS
-		;;
-	udf)
-		[ ! -z "$udf_fsize" ] && \
-			UDF_MKFS_OPTIONS="$UDF_MKFS_OPTIONS -s $udf_fsize"
-		export MKFS_OPTIONS=$UDF_MKFS_OPTIONS
-		;;
-	nfs)
-		export MKFS_OPTIONS=$NFS_MKFS_OPTIONS
-		;;
-	afs)
-		export MKFS_OPTIONS=$AFS_MKFS_OPTIONS
-		;;
-	cifs)
-		export MKFS_OPTIONS=$CIFS_MKFS_OPTIONS
-		;;
-	ceph)
-		export MKFS_OPTIONS=$CEPHFS_MKFS_OPTIONS
-		;;
-       reiser4)
-		export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
-		;;
-	gfs2)
-		export MKFS_OPTIONS="$GFS2_MKFS_OPTIONS -O -p lock_nolock"
-		;;
-	jfs)
-		export MKFS_OPTIONS="$JFS_MKFS_OPTIONS -q"
-		;;
-	f2fs)
-		export MKFS_OPTIONS="$F2FS_MKFS_OPTIONS"
-		;;
-	btrfs)
-		export MKFS_OPTIONS="$BTRFS_MKFS_OPTIONS"
-		;;
-	bcachefs)
-		export MKFS_OPTIONS=$BCACHEFS_MKFS_OPTIONS
-		;;
-	*)
-		;;
-	esac
-}
-
-_fsck_opts()
-{
-	case $FSTYP in
-	ext2|ext3|ext4)
-		export FSCK_OPTIONS="-nf"
-		;;
-	reiser*)
-		export FSCK_OPTIONS="--yes"
-		;;
-	f2fs)
-		export FSCK_OPTIONS=""
-		;;
-	*)
-		export FSCK_OPTIONS="-n"
-		;;
-	esac
-}
-
-# check necessary running dependences then source sepcific fs helpers
-_source_specific_fs()
-{
-	local fs=$1
-
-	if [ -z "$fs" ];then
-		fs=$FSTYP
-	fi
-
-	case "$fs" in
-	xfs)
-		[ "$XFS_LOGPRINT_PROG" = "" ] && _fatal "xfs_logprint not found"
-		[ "$XFS_REPAIR_PROG" = "" ] && _fatal "xfs_repair not found"
-		[ "$XFS_DB_PROG" = "" ] && _fatal "xfs_db not found"
-		[ "$MKFS_XFS_PROG" = "" ] && _fatal "mkfs_xfs not found"
-		[ "$XFS_INFO_PROG" = "" ] && _fatal "xfs_info not found"
-
-		. ./common/xfs
-		;;
-	udf)
-		[ "$MKFS_UDF_PROG" = "" ] && _fatal "mkfs_udf/mkudffs not found"
-		;;
-	btrfs)
-		[ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
-
-		. ./common/btrfs
-		;;
-	ext4)
-		[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
-		. ./common/ext4
-		;;
-	ext2|ext3)
-		. ./common/ext4
-		;;
-	f2fs)
-		[ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
-		;;
-	nfs)
-		. ./common/nfs
-		;;
-	afs)
-		;;
-	cifs)
-		;;
-	9p)
-		;;
-	fuse)
-		;;
-	ceph)
-		. ./common/ceph
-		;;
-	glusterfs)
-		;;
-	overlay)
-		. ./common/overlay
-		;;
-	reiser4)
-		[ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
-		;;
-	pvfs2)
-		;;
-	ubifs)
-		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
-		. ./common/ubifs
-		;;
-	esac
-}
-
-_config_section_setup
-_canonicalize_devices
-# mkfs.xfs checks for TEST_DEV before permitting < 300M filesystems. TEST_DIR
-# and QA_CHECK_FS are also checked by mkfs.xfs, but already exported elsewhere.
-export TEST_DEV
-
-# make sure this script returns success
-/bin/true
diff --git a/common/preamble b/common/preamble
index 0b684cc33..265b5649f 100644
--- a/common/preamble
+++ b/common/preamble
@@ -51,7 +51,23 @@ _begin_fstest()
 
 	. ./common/exit
 	. ./common/rc
-	init_rc
+
+	# Explicitly source the filesystem specific functions the test may need.
+	# This opens the door for template-file based functionality using
+	# function redfinition (e.g. to provide _scratch_mkfs()), rather than
+	# having everyting FSTYP specific being implemented in common/rc with
+	# massive case statements.
+	_source_specific_fs $FSTYP
+
+	# Always mount the test device because there many feature checks (i.e.
+	# _requires_....() functions) that assume the TEST_DIR is mounted. Lots
+	# of tests do not call _require_test to actually mount the test device
+	# first, so if we don't mount the test device then the _requires...
+	# checks are not probing the correct filesystem for support.
+	_check_if_dev_already_mounted $TEST_DEV $TEST_DIR
+	if [ $? -eq 1 ]; then
+		_test_mount || _fail "Cannot mount $TEST_DEV on $TEST_DIR"
+	fi
 
 	# remove previous $seqres.full before test
 	rm -f $seqres.full $seqres.hints
diff --git a/common/rc b/common/rc
index 94c00d890..be6cd92c4 100644
--- a/common/rc
+++ b/common/rc
@@ -2,10 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
 
-. common/config
-
 BC="$(type -P bc)" || BC=
 
+# make sure we have a standard umask
+umask 022
+
 # Don't use sync(1) directly if at all possible. In most cases we only need to
 # sync the fs under test, so we use syncfs if it is supported to prevent
 # disturbance of other tests that may be running concurrently.
@@ -246,17 +247,6 @@ _log_err()
     echo "(see $seqres.full for details)"
 }
 
-# make sure we have a standard umask
-umask 022
-
-# check for correct setup and source the $FSTYP specific functions now
-_source_specific_fs $FSTYP
-
-if [ ! -z "$REPORT_LIST" ]; then
-	. ./common/report
-	_assert_report_list
-fi
-
 _get_filesize()
 {
     stat -c %s "$1"
@@ -4934,6 +4924,8 @@ init_rc()
 		_exit 1
 	fi
 
+	_source_specific_fs $FSTYP
+
 	# if $TEST_DEV is not mounted, mount it now as XFS
 	if [ -z "`_fs_type $TEST_DEV`" ]
 	then
@@ -4973,6 +4965,11 @@ init_rc()
 	# it is supported.
 	$XFS_IO_PROG -i -c quit 2>/dev/null && \
 		export XFS_IO_PROG="$XFS_IO_PROG -i"
+
+	# mkfs.xfs checks for TEST_DEV before permitting < 300M filesystems.
+	# TEST_DIR and QA_CHECK_FS are also checked by mkfs.xfs, but already
+	# exported elsewhere.
+	export TEST_DEV
 }
 
 # get real device path name by following link
@@ -5844,6 +5841,204 @@ _require_program() {
 	_have_program "$1" || _notrun "$tag required"
 }
 
-################################################################################
-# make sure this script returns success
-/bin/true
+_common_mount_opts()
+{
+	case $FSTYP in
+	9p)
+		echo $PLAN9_MOUNT_OPTIONS
+		;;
+	fuse)
+		echo $FUSE_MOUNT_OPTIONS
+		;;
+	xfs)
+		echo $XFS_MOUNT_OPTIONS
+		;;
+	udf)
+		echo $UDF_MOUNT_OPTIONS
+		;;
+	nfs)
+		echo $NFS_MOUNT_OPTIONS
+		;;
+	afs)
+		echo $AFS_MOUNT_OPTIONS
+		;;
+	cifs)
+		echo $CIFS_MOUNT_OPTIONS
+		;;
+	ceph)
+		echo $CEPHFS_MOUNT_OPTIONS
+		;;
+	glusterfs)
+		echo $GLUSTERFS_MOUNT_OPTIONS
+		;;
+	overlay)
+		echo $OVERLAY_MOUNT_OPTIONS
+		;;
+	ext2|ext3|ext4)
+		# acls & xattrs aren't turned on by default on ext$FOO
+		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
+		;;
+	f2fs)
+		echo "-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
+		;;
+	reiser4)
+		# acls & xattrs aren't supported by reiser4
+		echo $REISER4_MOUNT_OPTIONS
+		;;
+	gfs2)
+		# acls aren't turned on by default on gfs2
+		echo "-o acl $GFS2_MOUNT_OPTIONS"
+		;;
+	tmpfs)
+		# We need to specify the size at mount, use 1G by default
+		echo "-o size=1G $TMPFS_MOUNT_OPTIONS"
+		;;
+	ubifs)
+		echo $UBIFS_MOUNT_OPTIONS
+		;;
+	*)
+		;;
+	esac
+}
+
+_mount_opts()
+{
+	export MOUNT_OPTIONS=$(_common_mount_opts)
+}
+
+_test_mount_opts()
+{
+	export TEST_FS_MOUNT_OPTS=$(_common_mount_opts)
+}
+
+_mkfs_opts()
+{
+	case $FSTYP in
+	xfs)
+		export MKFS_OPTIONS=$XFS_MKFS_OPTIONS
+		;;
+	udf)
+		[ ! -z "$udf_fsize" ] && \
+			UDF_MKFS_OPTIONS="$UDF_MKFS_OPTIONS -s $udf_fsize"
+		export MKFS_OPTIONS=$UDF_MKFS_OPTIONS
+		;;
+	nfs)
+		export MKFS_OPTIONS=$NFS_MKFS_OPTIONS
+		;;
+	afs)
+		export MKFS_OPTIONS=$AFS_MKFS_OPTIONS
+		;;
+	cifs)
+		export MKFS_OPTIONS=$CIFS_MKFS_OPTIONS
+		;;
+	ceph)
+		export MKFS_OPTIONS=$CEPHFS_MKFS_OPTIONS
+		;;
+	reiser4)
+		export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
+		;;
+	gfs2)
+		export MKFS_OPTIONS="$GFS2_MKFS_OPTIONS -O -p lock_nolock"
+		;;
+	jfs)
+		export MKFS_OPTIONS="$JFS_MKFS_OPTIONS -q"
+		;;
+	f2fs)
+		export MKFS_OPTIONS="$F2FS_MKFS_OPTIONS"
+		;;
+	btrfs)
+		export MKFS_OPTIONS="$BTRFS_MKFS_OPTIONS"
+		;;
+	bcachefs)
+		export MKFS_OPTIONS=$BCACHEFS_MKFS_OPTIONS
+		;;
+	*)
+		;;
+	esac
+}
+
+_fsck_opts()
+{
+	case $FSTYP in
+	ext2|ext3|ext4)
+		export FSCK_OPTIONS="-nf"
+		;;
+	reiser*)
+		export FSCK_OPTIONS="--yes"
+		;;
+	f2fs)
+		export FSCK_OPTIONS=""
+		;;
+	*)
+		export FSCK_OPTIONS="-n"
+		;;
+	esac
+}
+
+# check necessary running dependences then source sepcific fs helpers
+_source_specific_fs()
+{
+	local fs=$1
+
+	if [ -z "$fs" ];then
+		fs=$FSTYP
+	fi
+
+	case "$fs" in
+	xfs)
+		[ "$XFS_LOGPRINT_PROG" = "" ] && _fatal "xfs_logprint not found"
+		[ "$XFS_REPAIR_PROG" = "" ] && _fatal "xfs_repair not found"
+		[ "$XFS_DB_PROG" = "" ] && _fatal "xfs_db not found"
+		[ "$MKFS_XFS_PROG" = "" ] && _fatal "mkfs_xfs not found"
+		[ "$XFS_INFO_PROG" = "" ] && _fatal "xfs_info not found"
+
+		. ./common/xfs
+		;;
+	udf)
+		[ "$MKFS_UDF_PROG" = "" ] && _fatal "mkfs_udf/mkudffs not found"
+		;;
+	btrfs)
+		[ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
+
+		. ./common/btrfs
+		;;
+	ext4)
+		[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
+		. ./common/ext4
+		;;
+	ext2|ext3)
+		. ./common/ext4
+		;;
+	f2fs)
+		[ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
+		;;
+	nfs)
+		. ./common/nfs
+		;;
+	afs)
+		;;
+	cifs)
+		;;
+	9p)
+		;;
+	fuse)
+		;;
+	ceph)
+		. ./common/ceph
+		;;
+	glusterfs)
+		;;
+	overlay)
+		. ./common/overlay
+		;;
+	reiser4)
+		[ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
+		;;
+	pvfs2)
+		;;
+	ubifs)
+		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
+		. ./common/ubifs
+		;;
+	esac
+}
-- 
2.45.2

