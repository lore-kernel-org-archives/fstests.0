Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972C225388
	for <fstests@vger.kernel.org>; Sat, 10 May 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746886103; cv=none; b=aTht5URIfODGVgr8T75YcO0pewlmFsAyZrYeRelq7desAZmEIV3tfd5eYPHyaMg18n1ehuosdLkgi256eHfAqhFQ86rQRVwx+yLsPF9J8IObJ3AwS5uZB3Yo7Sb1x8yAY045y1PHSnZFC8LDE/21BMFDneP3XyIN2pJdSZ5xRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746886103; c=relaxed/simple;
	bh=r8fo8xeFvchb2iXTsAsT1BoUSdYQrMq1P8qScX37qSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=csN90rRiTspwSg/Se3GN45KtVb4i/5z+/8dhWyWONgrDEbhpNAeVkA9eQ5bmnAkeZuaoYiN8OwGRGMyugQrdtp2IiX2ue+pJLQgrezKvtJxzpYimru9pG64kr5v1WX6izLST6UnzHBr+u7sLmTq9xCziUZWM28+Ya5uE23bSlZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H18Zv7QO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H18Zv7QO"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b1fcb97d209so3717853a12.1
        for <fstests@vger.kernel.org>; Sat, 10 May 2025 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746886100; x=1747490900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRkTp9rS738SYMbDElgNVfjcX8biMQPbshlyXjhHKts=;
        b=H18Zv7QO+r/t3EcfoZB6TmyqPAoc0wiGALkT/z5b5rEKnEhl7hUSMNS1jVMH4PclWV
         E7KNNPFCfRz1LqUBlfe65bFp+EFh9gBkkFk2ktCbq6nDmGcOFC8fNXf9vRXR/p9Ui78D
         5J8c6A8qejXSpWffEUU5fS9AzoyRt0gt4dgov6tzINXRj4grQTQ0Nw/aqGLCCjXyCA7F
         /JsIS5CxcesqpfitLHYI5aJYJ3XqVNL/OsbyFH9KNqXxGIwvZYk1IJXw1PD8rz/v+FOi
         4xWvBxBLEUyi/MwnwMeY0un51TftN588yNomNJPnA6cyazr3NmjZDLkUJq70XG1yDPi3
         YcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746886100; x=1747490900;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VRkTp9rS738SYMbDElgNVfjcX8biMQPbshlyXjhHKts=;
        b=d0sN8kwa+oSusRZPJFuC8lNlo2oBq3F0dXQg5mpm1BXbo4u5ce9rSde2vEzOCWu9BO
         XThxbh7DwwJ0dOhgM+CagosPj0ud38MIItqn2DXbAvfhWXD7eQR+ZDX09qlluNI5dGPt
         UgIeAOoWoXix6neF7cXi2teNYgJbjBuUCTYNKfphExmksbRhXb8axRd7rLJ0QARNWbzb
         IitorxTacFS97B3YFqCQUyRIGpFkUECmjjnnJwyja3ssL28SHw9tfmFcClKJUCmv2jVA
         cH5lIEm9UvzYa5I+7rONb5zRZ3fIjLgOsl8P/RAi0pUWhbgRcebgM3IreYlaBhIzBPAj
         nePw==
X-Forwarded-Encrypted: i=1; AJvYcCU/KqkOs/S4DHnbKtYSaaU/TF4U9+Zui+/64AL1Xiw4M+lfkk//3QjrX+pJT9XYuBfUBp8LmxVa@vger.kernel.org
X-Gm-Message-State: AOJu0YzZsuj46+6t2UU4DLwzaycUt9fLBtETg2mY1/fUYP+1yY68pfDW
	Le25GuEedRkf1V4+Ctg078/XD8mQTIWd0bnGRXiuLtTIiQ1le1FPoUUoNA==
X-Gm-Gg: ASbGnctoiznFOIg/vIzJ8NpdHcbSo6MlVcOBARUXsaOXvRtHvLTgyDI0v+h8xF0wTdC
	0Kx5akYjPNv4iFj6pRBw0Wr9GmNE8ty+fuIu/+FnRv1QdKk/NpHIHaef+1eF26Nhr4EMPCAfxxO
	+GwjBhoLtV4pE0gF3YvW3pJ5TzBRkmx+PZnysmF5N3tYK9joxKAl2/MNuFJ9lfhxtS7dmmpB04H
	pU1Pf7cGfYCnsjWJwjnGZgf0fqDPe6D2rJcd5PmkzXNUmITWuNMQX4Kx8qKGxaltW3GlVMWAoK1
	L4h0ppxAA6LIsbMuRPFrMq0RJrJhFst5UFQx72SK3KxvQIcX8Po+3MoPyp3ei9LBlizS5XOOR+C
	A9vkGSdodxyueHBCBeknwQzb3BQBE
X-Google-Smtp-Source: AGHT+IHUg4zAeSm3zF1jYcoCkY+mdqDUFfNQgzkgo8VPAibz42MWKMHWkbGGU7DVxlRN1hrtSQ2FtQ==
X-Received: by 2002:a17:902:f607:b0:215:9eac:1857 with SMTP id d9443c01a7336-22e846e0394mr166750705ad.5.1746886100167;
        Sat, 10 May 2025 07:08:20 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544f94sm33454265ad.21.2025.05.10.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 07:08:19 -0700 (PDT)
Message-ID: <1c854d51fe389f488b4f1fa09ebb23892279ac39.camel@gmail.com>
Subject: Re: [PATCH 14/28] fstests: further separate sourcing common/rc and
 common/config from initialisation
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Sat, 10 May 2025 19:38:16 +0530
In-Reply-To: <20250417031208.1852171-15-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-15-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The sourcing of common/rc still causes code to be run, partially
> because it sources common/config and partially because there is some
> in-line code amongst all the function definitions inside common/rc
> 
> This is messy, and re-sourcing those files also does an awful
> lot of setup work that isn't actually required.
> 
> common/config only needs to be included once - everything that
> scripts then depend on should be exported by it, and hence it should
> only be included once from check/check-parallel to set up all the
> environmental parameters for the entire run.
> 
> common/rc also only needs to be included once per context, but it
> does not need to directly include common config nor does it need to
> run init_rc in each individual test context.
> 
> Seperate out this mess. Include common/config directly where needed
> and only use it to set up the environment. Move all the code that is
> in common/config to common/rc so that common/config is not needed
> for any purpose other than setting up the initial environment.
> Move the initialisation functions to the scripts that include
> common/config.
> 
> Config file and config section parsing can be run directly from check
> and/or check-parallel; this is not needed for every context that
> needs to know how what XFS_MKFS_PROG is set to...
> 
> Similarly, include common/rc only once, and only call init_rc or
> _source_specific_fs() from the contexts that actually need that code
> to be run.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check           |  23 ++---
>  common/config   | 212 --------------------------------------------
>  common/preamble |  18 +++-
>  common/rc       | 227 ++++++++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 240 insertions(+), 240 deletions(-)
> 
> diff --git a/check b/check
> index 0b489cb4b..fea86f7b9 100755
> --- a/check
> +++ b/check
> @@ -46,6 +46,9 @@ rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>  . ./common/exit
>  . ./common/test_names
>  . ./common/test_list
> +. ./common/config
> +. ./common/config-sections
> +. ./common/rc
>  
>  usage()
>  {
> @@ -183,15 +186,17 @@ while [ $# -gt 0 ]; do
>  	shift
>  done
>  
> -# we need common/rc, that also sources common/config. We need to source it
> -# after processing args, overlay needs FSTYP set before sourcing common/config
> -if ! . ./common/rc; then
> -	echo "check: failed to source common/rc"
> -	exit 1
> -fi
> -
> +# now we have done argument parsing, overlay has FSTYP set and we can now
> +# start processing the config files and setting up devices.
> +_config_section_setup
> +_canonicalize_devices
>  init_rc
>  
> +if [ ! -z "$REPORT_LIST" ]; then
> +	. ./common/report
> +	_assert_report_list
> +fi
> +
>  # If the test config specified a soak test duration, see if there are any
>  # unit suffixes that need converting to an integer seconds count.
>  if [ -n "$SOAK_DURATION" ]; then
> @@ -553,10 +558,6 @@ function run_section()
>  			status=1
>  			exit
>  		fi
> -		# Previous FSTYP derived from TEST_DEV could be changed, source
> -		# common/rc again with correct FSTYP to get FSTYP specific configs,
> -		# e.g. common/xfs
> -		. common/rc
>  		_tl_prepare_test_list
>  	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>  		# Unmount TEST_DEV to apply the updated mount options.
> diff --git a/common/config b/common/config
> index f90a66862..b93a6c0d3 100644
> --- a/common/config
> +++ b/common/config
> @@ -41,7 +41,6 @@
>  
>  . common/test_names
>  . common/exit
> -. common/config-sections
>  
>  # all tests should use a common language setting to prevent golden
>  # output mismatches.
> @@ -342,214 +341,3 @@ if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
>  	: ${SELINUX_MOUNT_OPTIONS:="-o context=$(stat -c %C /)"}
>  	export SELINUX_MOUNT_OPTIONS
>  fi
> -
> -_common_mount_opts()
> -{
> -	case $FSTYP in
> -	9p)
> -		echo $PLAN9_MOUNT_OPTIONS
> -		;;
> -	fuse)
> -		echo $FUSE_MOUNT_OPTIONS
> -		;;
> -	xfs)
> -		echo $XFS_MOUNT_OPTIONS
> -		;;
> -	udf)
> -		echo $UDF_MOUNT_OPTIONS
> -		;;
> -	nfs)
> -		echo $NFS_MOUNT_OPTIONS
> -		;;
> -	afs)
> -		echo $AFS_MOUNT_OPTIONS
> -		;;
> -	cifs)
> -		echo $CIFS_MOUNT_OPTIONS
> -		;;
> -	ceph)
> -		echo $CEPHFS_MOUNT_OPTIONS
> -		;;
> -	glusterfs)
> -		echo $GLUSTERFS_MOUNT_OPTIONS
> -		;;
> -	overlay)
> -		echo $OVERLAY_MOUNT_OPTIONS
> -		;;
> -	ext2|ext3|ext4)
> -		# acls & xattrs aren't turned on by default on ext$FOO
> -		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
> -		;;
> -	f2fs)
> -		echo "-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
> -		;;
> -       reiser4)
> -		# acls & xattrs aren't supported by reiser4
> -		echo $REISER4_MOUNT_OPTIONS
> -		;;
> -	gfs2)
> -		# acls aren't turned on by default on gfs2
> -		echo "-o acl $GFS2_MOUNT_OPTIONS"
> -		;;
> -	tmpfs)
> -		# We need to specify the size at mount, use 1G by default
> -		echo "-o size=1G $TMPFS_MOUNT_OPTIONS"
> -		;;
> -	ubifs)
> -		echo $UBIFS_MOUNT_OPTIONS
> -		;;
> -	*)
> -		;;
> -	esac
> -}
> -
> -_mount_opts()
> -{
> -	export MOUNT_OPTIONS=$(_common_mount_opts)
> -}
> -
> -_test_mount_opts()
> -{
> -	export TEST_FS_MOUNT_OPTS=$(_common_mount_opts)
> -}
> -
> -_mkfs_opts()
> -{
> -	case $FSTYP in
> -	xfs)
> -		export MKFS_OPTIONS=$XFS_MKFS_OPTIONS
> -		;;
> -	udf)
> -		[ ! -z "$udf_fsize" ] && \
> -			UDF_MKFS_OPTIONS="$UDF_MKFS_OPTIONS -s $udf_fsize"
> -		export MKFS_OPTIONS=$UDF_MKFS_OPTIONS
> -		;;
> -	nfs)
> -		export MKFS_OPTIONS=$NFS_MKFS_OPTIONS
> -		;;
> -	afs)
> -		export MKFS_OPTIONS=$AFS_MKFS_OPTIONS
> -		;;
> -	cifs)
> -		export MKFS_OPTIONS=$CIFS_MKFS_OPTIONS
> -		;;
> -	ceph)
> -		export MKFS_OPTIONS=$CEPHFS_MKFS_OPTIONS
> -		;;
> -       reiser4)
> -		export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
> -		;;
> -	gfs2)
> -		export MKFS_OPTIONS="$GFS2_MKFS_OPTIONS -O -p lock_nolock"
> -		;;
> -	jfs)
> -		export MKFS_OPTIONS="$JFS_MKFS_OPTIONS -q"
> -		;;
> -	f2fs)
> -		export MKFS_OPTIONS="$F2FS_MKFS_OPTIONS"
> -		;;
> -	btrfs)
> -		export MKFS_OPTIONS="$BTRFS_MKFS_OPTIONS"
> -		;;
> -	bcachefs)
> -		export MKFS_OPTIONS=$BCACHEFS_MKFS_OPTIONS
> -		;;
> -	*)
> -		;;
> -	esac
> -}
> -
> -_fsck_opts()
> -{
> -	case $FSTYP in
> -	ext2|ext3|ext4)
> -		export FSCK_OPTIONS="-nf"
> -		;;
> -	reiser*)
> -		export FSCK_OPTIONS="--yes"
> -		;;
> -	f2fs)
> -		export FSCK_OPTIONS=""
> -		;;
> -	*)
> -		export FSCK_OPTIONS="-n"
> -		;;
> -	esac
> -}
> -
> -# check necessary running dependences then source sepcific fs helpers
> -_source_specific_fs()
> -{
> -	local fs=$1
> -
> -	if [ -z "$fs" ];then
> -		fs=$FSTYP
> -	fi
> -
> -	case "$fs" in
> -	xfs)
> -		[ "$XFS_LOGPRINT_PROG" = "" ] && _fatal "xfs_logprint not found"
> -		[ "$XFS_REPAIR_PROG" = "" ] && _fatal "xfs_repair not found"
> -		[ "$XFS_DB_PROG" = "" ] && _fatal "xfs_db not found"
> -		[ "$MKFS_XFS_PROG" = "" ] && _fatal "mkfs_xfs not found"
> -		[ "$XFS_INFO_PROG" = "" ] && _fatal "xfs_info not found"
> -
> -		. ./common/xfs
> -		;;
> -	udf)
> -		[ "$MKFS_UDF_PROG" = "" ] && _fatal "mkfs_udf/mkudffs not found"
> -		;;
> -	btrfs)
> -		[ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
> -
> -		. ./common/btrfs
> -		;;
> -	ext4)
> -		[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
> -		. ./common/ext4
> -		;;
> -	ext2|ext3)
> -		. ./common/ext4
> -		;;
> -	f2fs)
> -		[ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
> -		;;
> -	nfs)
> -		. ./common/nfs
> -		;;
> -	afs)
> -		;;
> -	cifs)
> -		;;
> -	9p)
> -		;;
> -	fuse)
> -		;;
> -	ceph)
> -		. ./common/ceph
> -		;;
> -	glusterfs)
> -		;;
> -	overlay)
> -		. ./common/overlay
> -		;;
> -	reiser4)
> -		[ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
> -		;;
> -	pvfs2)
> -		;;
> -	ubifs)
> -		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
> -		. ./common/ubifs
> -		;;
> -	esac
> -}
> -
> -_config_section_setup
> -_canonicalize_devices
> -# mkfs.xfs checks for TEST_DEV before permitting < 300M filesystems. TEST_DIR
> -# and QA_CHECK_FS are also checked by mkfs.xfs, but already exported elsewhere.
> -export TEST_DEV
> -
> -# make sure this script returns success
> -/bin/true
> diff --git a/common/preamble b/common/preamble
> index 0b684cc33..265b5649f 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -51,7 +51,23 @@ _begin_fstest()
>  
>  	. ./common/exit
>  	. ./common/rc
> -	init_rc
> +
> +	# Explicitly source the filesystem specific functions the test may need.
> +	# This opens the door for template-file based functionality using
> +	# function redfinition (e.g. to provide _scratch_mkfs()), rather than
> +	# having everyting FSTYP specific being implemented in common/rc with
> +	# massive case statements.
> +	_source_specific_fs $FSTYP
> +
> +	# Always mount the test device because there many feature checks (i.e.
> +	# _requires_....() functions) that assume the TEST_DIR is mounted. Lots
> +	# of tests do not call _require_test to actually mount the test device
> +	# first, so if we don't mount the test device then the _requires...
> +	# checks are not probing the correct filesystem for support.
> +	_check_if_dev_already_mounted $TEST_DEV $TEST_DIR
> +	if [ $? -eq 1 ]; then
_check_if_dev_already_mounted can return 1 (not mounted) or 2 (wrong mount) - in that case shouldn't
we check for $? -ne 0 ?

Also, TEST_DEV is always mounted by "check", right? Is this just a paranoic check?
> +		_test_mount || _fail "Cannot mount $TEST_DEV on $TEST_DIR"
> +	fi
>  
>  	# remove previous $seqres.full before test
>  	rm -f $seqres.full $seqres.hints
> diff --git a/common/rc b/common/rc
> index 94c00d890..be6cd92c4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2,10 +2,11 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
>  
> -. common/config
> -
>  BC="$(type -P bc)" || BC=
>  
> +# make sure we have a standard umask
> +umask 022
> +
>  # Don't use sync(1) directly if at all possible. In most cases we only need to
>  # sync the fs under test, so we use syncfs if it is supported to prevent
>  # disturbance of other tests that may be running concurrently.
> @@ -246,17 +247,6 @@ _log_err()
>      echo "(see $seqres.full for details)"
>  }
>  
> -# make sure we have a standard umask
> -umask 022
> -
> -# check for correct setup and source the $FSTYP specific functions now
> -_source_specific_fs $FSTYP
> -
> -if [ ! -z "$REPORT_LIST" ]; then
> -	. ./common/report
> -	_assert_report_list
> -fi
> -
>  _get_filesize()
>  {
>      stat -c %s "$1"
> @@ -4934,6 +4924,8 @@ init_rc()
>  		_exit 1
>  	fi
>  
> +	_source_specific_fs $FSTYP
> +
>  	# if $TEST_DEV is not mounted, mount it now as XFS
>  	if [ -z "`_fs_type $TEST_DEV`" ]
>  	then
> @@ -4973,6 +4965,11 @@ init_rc()
>  	# it is supported.
>  	$XFS_IO_PROG -i -c quit 2>/dev/null && \
>  		export XFS_IO_PROG="$XFS_IO_PROG -i"
> +
> +	# mkfs.xfs checks for TEST_DEV before permitting < 300M filesystems.
> +	# TEST_DIR and QA_CHECK_FS are also checked by mkfs.xfs, but already
> +	# exported elsewhere.
> +	export TEST_DEV
>  }
>  
>  # get real device path name by following link
> @@ -5844,6 +5841,204 @@ _require_program() {
>  	_have_program "$1" || _notrun "$tag required"
>  }
>  
> -################################################################################
> -# make sure this script returns success
> -/bin/true
> +_common_mount_opts()
> +{
> +	case $FSTYP in
> +	9p)
> +		echo $PLAN9_MOUNT_OPTIONS
> +		;;
> +	fuse)
> +		echo $FUSE_MOUNT_OPTIONS
> +		;;
> +	xfs)
> +		echo $XFS_MOUNT_OPTIONS
> +		;;
> +	udf)
> +		echo $UDF_MOUNT_OPTIONS
> +		;;
> +	nfs)
> +		echo $NFS_MOUNT_OPTIONS
> +		;;
> +	afs)
> +		echo $AFS_MOUNT_OPTIONS
> +		;;
> +	cifs)
> +		echo $CIFS_MOUNT_OPTIONS
> +		;;
> +	ceph)
> +		echo $CEPHFS_MOUNT_OPTIONS
> +		;;
> +	glusterfs)
> +		echo $GLUSTERFS_MOUNT_OPTIONS
> +		;;
> +	overlay)
> +		echo $OVERLAY_MOUNT_OPTIONS
> +		;;
> +	ext2|ext3|ext4)
> +		# acls & xattrs aren't turned on by default on ext$FOO
> +		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
> +		;;
> +	f2fs)
> +		echo "-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
> +		;;
> +	reiser4)
> +		# acls & xattrs aren't supported by reiser4
> +		echo $REISER4_MOUNT_OPTIONS
> +		;;
> +	gfs2)
> +		# acls aren't turned on by default on gfs2
> +		echo "-o acl $GFS2_MOUNT_OPTIONS"
> +		;;
> +	tmpfs)
> +		# We need to specify the size at mount, use 1G by default
> +		echo "-o size=1G $TMPFS_MOUNT_OPTIONS"
> +		;;
> +	ubifs)
> +		echo $UBIFS_MOUNT_OPTIONS
> +		;;
> +	*)
> +		;;
> +	esac
> +}
> +
> +_mount_opts()
> +{
> +	export MOUNT_OPTIONS=$(_common_mount_opts)
> +}
> +
> +_test_mount_opts()
> +{
> +	export TEST_FS_MOUNT_OPTS=$(_common_mount_opts)
> +}
> +
> +_mkfs_opts()
> +{
> +	case $FSTYP in
> +	xfs)
> +		export MKFS_OPTIONS=$XFS_MKFS_OPTIONS
> +		;;
> +	udf)
> +		[ ! -z "$udf_fsize" ] && \
> +			UDF_MKFS_OPTIONS="$UDF_MKFS_OPTIONS -s $udf_fsize"
> +		export MKFS_OPTIONS=$UDF_MKFS_OPTIONS
> +		;;
> +	nfs)
> +		export MKFS_OPTIONS=$NFS_MKFS_OPTIONS
> +		;;
> +	afs)
> +		export MKFS_OPTIONS=$AFS_MKFS_OPTIONS
> +		;;
> +	cifs)
> +		export MKFS_OPTIONS=$CIFS_MKFS_OPTIONS
> +		;;
> +	ceph)
> +		export MKFS_OPTIONS=$CEPHFS_MKFS_OPTIONS
> +		;;
> +	reiser4)
> +		export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
> +		;;
> +	gfs2)
> +		export MKFS_OPTIONS="$GFS2_MKFS_OPTIONS -O -p lock_nolock"
> +		;;
> +	jfs)
> +		export MKFS_OPTIONS="$JFS_MKFS_OPTIONS -q"
> +		;;
> +	f2fs)
> +		export MKFS_OPTIONS="$F2FS_MKFS_OPTIONS"
> +		;;
> +	btrfs)
> +		export MKFS_OPTIONS="$BTRFS_MKFS_OPTIONS"
> +		;;
> +	bcachefs)
> +		export MKFS_OPTIONS=$BCACHEFS_MKFS_OPTIONS
> +		;;
> +	*)
> +		;;
> +	esac
> +}
> +
> +_fsck_opts()
> +{
> +	case $FSTYP in
> +	ext2|ext3|ext4)
> +		export FSCK_OPTIONS="-nf"
> +		;;
> +	reiser*)
> +		export FSCK_OPTIONS="--yes"
> +		;;
> +	f2fs)
> +		export FSCK_OPTIONS=""
> +		;;
> +	*)
> +		export FSCK_OPTIONS="-n"
> +		;;
> +	esac
> +}
> +
> +# check necessary running dependences then source sepcific fs helpers
> +_source_specific_fs()
> +{
> +	local fs=$1
> +
> +	if [ -z "$fs" ];then
> +		fs=$FSTYP
> +	fi
> +
> +	case "$fs" in
> +	xfs)
> +		[ "$XFS_LOGPRINT_PROG" = "" ] && _fatal "xfs_logprint not found"
> +		[ "$XFS_REPAIR_PROG" = "" ] && _fatal "xfs_repair not found"
> +		[ "$XFS_DB_PROG" = "" ] && _fatal "xfs_db not found"
> +		[ "$MKFS_XFS_PROG" = "" ] && _fatal "mkfs_xfs not found"
> +		[ "$XFS_INFO_PROG" = "" ] && _fatal "xfs_info not found"
> +
> +		. ./common/xfs
> +		;;
> +	udf)
> +		[ "$MKFS_UDF_PROG" = "" ] && _fatal "mkfs_udf/mkudffs not found"
> +		;;
> +	btrfs)
> +		[ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
> +
> +		. ./common/btrfs
> +		;;
> +	ext4)
> +		[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
> +		. ./common/ext4
> +		;;
> +	ext2|ext3)
> +		. ./common/ext4
> +		;;
> +	f2fs)
> +		[ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
> +		;;
> +	nfs)
> +		. ./common/nfs
> +		;;
> +	afs)
> +		;;
> +	cifs)
> +		;;
> +	9p)
> +		;;
> +	fuse)
> +		;;
> +	ceph)
> +		. ./common/ceph
> +		;;
> +	glusterfs)
> +		;;
> +	overlay)
> +		. ./common/overlay
> +		;;
> +	reiser4)
> +		[ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
> +		;;
> +	pvfs2)
> +		;;
> +	ubifs)
> +		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
> +		. ./common/ubifs
> +		;;
> +	esac
> +}
So the logic behind moving the above functions from common/config to common/rc is because we want
the configuration work done only once (functions in common/config) and so we include common/config
only once per check/check-parallel context and the above functions (like _source_specific_fs(),
_fsck_opts() etc) are needed for each test - so we factor them into common/rc and include common/rc
per test instead of common/config which is not needed to be sourced for each test, am I correct?
--NR

