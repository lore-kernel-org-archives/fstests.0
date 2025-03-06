Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DFC2135A3
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297170; cv=none; b=iUK9pobMgR/yUgfJgL45/QsScwFZe/SfKtYRPkMPPTXUdxveaTvC/AWth6dmOyNXu4a93QlQQpogmb8oAfit7SGHCvvgQRg/SKMR1ft5M81mwkt0Axbns24Kha8HarDqSZaWSXYH/gNsQY8nlhmtaVkg5HVvUEtLzrmzTAil06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297170; c=relaxed/simple;
	bh=eCntKfcnKcAoTACNRtfbYRoUkJYxKPLidqc8ENdI7vs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOQzq6mp9AyReIePH7RXtRU36v969cODME2RV0jDTi36qDlYelSaYfP4nGXIA93TQWYfBr3VMoecVpzj5Ci6T03qxaKOswmIiFT2rFm2EIrOfwT0qmgyHq+tY/HuvG7cYbDpjeJZvEN9qQ0lg/ppX1YAbom84wbYNDcwJT0vLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=UW5A4r1A; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="UW5A4r1A"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2234e4b079cso21307365ad.1
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 13:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741297167; x=1741901967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTPSLjVBQ+MFaQOuOxS6Bl/h8Mkm+ykxeSkcWemwpLs=;
        b=UW5A4r1AqIbbicwsAa6d3CKpL1gH2ytj9CfhXb92C5N2+CfkDW5007k5onCh1kYH0V
         YKeSAMlFRoumYQNrTtDdTU3sWxV9E786V2I42wvbnrmGo7l4miB7kilYUXnX0985Unw7
         8KFGm3bTXvZus2bRIZ9TVvaKFd8GuahSkIfXnYMtTn4n9j6v/3jpRCtAewjoODbydtqL
         lli0QKznDkYrKlzYtReuzUPzGtxREAiuitpDW23mJB2HzrCc3/7iBKe8JRt+ZpK5bWGA
         rRoRrUZVTo+DAEKcxOVF8M6fvJHFKasC+TdMzTqksLtZzoG74imIKdVyFG8jS24mijJM
         I4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297167; x=1741901967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTPSLjVBQ+MFaQOuOxS6Bl/h8Mkm+ykxeSkcWemwpLs=;
        b=DWkP4kwKaXkmcxAq/ZV8MDOZ53AKs6XR9A+1C8Tx7IQy6G/UfVxbJMyU36OYRoX7MY
         QdpUDzT/Wmr5e3H7sgMcrBW2TwP4RtE4Dsj4BazEp4Bvf1Mam5jT3uHrw//X/KXqDOHE
         SDliKCKoyg+mQacDLwcqNbkOEfV936hlpFK83HE4vbi2UUoI1A9jxVwZSKNcg1u/wWY4
         AdDXPU/5pPeJs8M1IRz7hn5v9VKdafFVSWn9lK/o+T1xlgPIzt+TudeQ5MwcH2DcGL4h
         D4YqLO+RkvMfSe+NVwTQqIp1MudumHWRKu8JjQumLbbSGkK9zJvX9ybMxO+EbFml4WC5
         E7pQ==
X-Gm-Message-State: AOJu0YyqTBk5Wmi6L0ifYANWVURH8m+XmJrh+5rh/TGs+aQwyJmPvnBm
	cEt27qM9mmLC7dunBsDtgWrukTwB2NIQwVmtzy25qXdcsybXSuiH1JvFRmN+3HGGoDdV9B+va6j
	6
X-Gm-Gg: ASbGnctYFTKUvnZfUMhem7Rd43quJ11CxMGUMfOEX1CCXEB2BVC6MiyGeIY76m7qJOc
	7T6+MEa+W8NP8PJottXoevUnG01CnBNYwrWbccwt/wn93mNdz/9IaQm9hsKF558PBAMnUVA7ymd
	LpMcIWvwH4pZKiEjvNd3P3EY1P7t1KHqKcHtIRG64WEeSZ/h55jNj2Zy54qHX20xAE+GjZ2PRKR
	12b9OcZC4V/perTHV9ca6BZLctzHX9TBFqLlTaFKMqArOEc2qoCOA0E3dGly91jlZ2OCS6NAdne
	VHERDTuen7RGwdpcqbzNw5kVqq34tqVILNe5+10CXgWVzputqBOSON3jM3pRsWBaJE7mwxe0zoU
	NMneTtNA5H09vTXM3V9U=
X-Google-Smtp-Source: AGHT+IEt+E+y2Pi6CQ317tY2I70l062g5qieFWw0vfA4SVn5Z6YgSAuZScuIoQxj/VoXmobd69smhw==
X-Received: by 2002:a05:6a00:1812:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-736aa9e954amr1160889b3a.10.1741297166615;
        Thu, 06 Mar 2025 13:39:26 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698243fcbsm1916459b3a.57.2025.03.06.13.39.25
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:39:25 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tqIw6-00000009lRd-2ZYf
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tqIw6-0000000FvrX-3SEF
	for fstests@vger.kernel.org;
	Fri, 07 Mar 2025 08:39:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 4/5] fstests: remove tools/auto-qa
Date: Fri,  7 Mar 2025 08:34:49 +1100
Message-ID: <20250306213921.3769440-5-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306213921.3769440-1-david@fromorbit.com>
References: <20250306213921.3769440-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

This is a 2000s era SGI test script that no-one uses anymore. It
likely doesn't even work because it is dependent on CVS and/or
the SGI proprietary ptools revision control system for source
control. Hence it clearly hasn't been used for years, so remove it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tools/auto-qa | 568 --------------------------------------------------
 1 file changed, 568 deletions(-)
 delete mode 100755 tools/auto-qa

diff --git a/tools/auto-qa b/tools/auto-qa
deleted file mode 100755
index 1beb28359..000000000
--- a/tools/auto-qa
+++ /dev/null
@@ -1,568 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# automatic qa system. 31/08/00 dxm@sgi.com
-#
-# Usage: auto_qa start-state [stop-state]
-# Do auto_qa from start-state up to stop-state inclusive
-# or if no stop-state given then do it until reach "done" state.
-#
-
-_log()
-{
-    echo "$*" >&2
-    echo "$*" >> $LOG
-    sync
-}
-
-_fail()
-{
-    if [ "$started" = "1" ] 
-    then
-	echo "auto-qa stopped" | wall
-	started=0
-    fi
-
-    _log "$*"
-    
-    # send special email if a cron'd qa run fails
-    case $state
-    in
-	cron*)
-	    mail -s "XFS QA status report" $EMAIL < $LOG 2>&1
-	;;
-    esac
-
-    status=1
-    exit 1
-}
-
-_get_kernel_version()
-{
-    [ -x "$KWORKAREA" ] || return
-    [ -r "$KWORKAREA/Makefile" ] \
-	|| _fail "can't read kernel makefile $KWORKAREA/Makefile"
-
-    eval `awk '
-	BEGIN { FS = "[ \t=]+" }
-	/^VERSION =/ { a=$2 }
-	/^PATCHLEVEL =/ { b=$2 }
-	/^SUBLEVEL =/ { c=$2 }
-	/^EXTRAVERSION =/ { d=$2 }
-	END { 
-	    print "VERSION=" a "." b "." c d " ; SVERSION=" a "." b "." c
-	}
-   ' < $KWORKAREA/Makefile`
-}
-
-# this should be constant
-
-ROOT="$HOME/qa"
-HOST=`hostname -s`
-if [ ! -z "$CVSROOT" ]; then
-    export WORKAREA="$ROOT/xfs-cmds"
-else
-    [ -z "$WORKAREA" ] && export WORKAREA="$ROOT/xfs-cmds"
-fi
-
-
-export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin/ptools:/usr/local/bin"
-STATE=$ROOT/qa.state
-QADIR="$WORKAREA/xfstests"
-SUDO="su -c"
-CONFIG="$ROOT/$HOST.config"
-COMMON_CONFIG="$QADIR/common/config"
-SH="/bin/sh"
-LOG="$ROOT/qa.log"
-
-# do some cleanup on exit
-
-_cleanup()
-{
-    umount $SCRATCH_DEV &> /dev/null
-    umount $TEST_DEV &> /dev/null
-    if [ "$started" = 1 ]
-    then
-	echo "auto-qa stopped" | wall
-	started=0
-    fi
-}
-status=1
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-# clean exit
-
-_success()
-{
-    status=0
-    exit 0
-}
-
-_get_state()
-{
-    state=`cat $STATE`
-}
-
-_set_state()
-{
-    echo $1 > $STATE
-    _get_state
-}
-
-_change_state()
-{
-    new=$1
-
-    # if have state XXXX-state then preserve XXXX-newstate
-    
-    case $state
-    in
-	*-*)
-	    case $new
-	    in
-		*-*)
-		    _set_state $new
-		    ;;
-		*)
-		    _set_state `echo $state | sed "s/-.*$/-$new/"`
-		    ;;
-	    esac
-	    ;;
-	*)
-	    _set_state $new
-	    ;;
-    esac
-}
-
-_sudo()
-{
-    $ROOT/su -c "$*" < /dev/null ;# HACK - we need a hacked su at the mo
-}
-
-_restart()
-{
-    exec $ROOT/su -c "(shutdown -r now \"auto-qa rebooting\" )&" < /dev/null
-}
-
-_update_workarea()
-{
-    if [ -z "$CVSROOT" ]; then
-	_log "	*** p_tupdate"
-	cd "$1"
-	WORKAREA="$1" p_tupdate 2>&1 \
-			|| _fail "	    !!! p_tupdate failed"
-
-	_log "	*** non-trunk files"
-	cd "$1"
-	WORKAREA="$1" p_list -c 2>&1 \
-			|| _fail "	    !!! p_list failed"
-    else
-	_log "	*** cvs update"
-	cd "$1"
-	cvs -z3 update -d
-    fi
-}
-
-_test_mkfs_xfs()
-{
-    TEST_OPTIONS=""
-    [ "$USE_EXTERNAL" = yes -a ! -z "$TEST_RTDEV" ] && \
-        TEST_OPTIONS="$TEST_OPTIONS -rrtdev=$TEST_RTDEV"
-    [ "$USE_EXTERNAL" = yes -a ! -z "$TEST_LOGDEV" ] && \
-        TEST_OPTIONS="$TEST_OPTIONS -llogdev=$TEST_LOGDEV"
-    _sudo /sbin/mkfs.xfs -f $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
-    mkfs_status=$?
-    if [ "$USE_BIG_LOOPFS" = yes ]; then
-        [ -z "$RETAIN_AG_BYTES" ] && RETAIN_AG_BYTES=0
-        _sudo $QADIR/tools/ag-wipe -q -r $RETAIN_AG_BYTES $TEST_DEV
-    fi
-    return $mkfs_status
-}
-
-_test_mount()
-{
-    TEST_OPTIONS=""
-    [ "$USE_EXTERNAL" = yes -a ! -z "$TEST_RTDEV" ] && \
-        TEST_OPTIONS="$TEST_OPTIONS -ortdev=$TEST_RTDEV"
-    [ "$USE_EXTERNAL" = yes -a ! -z "$TEST_LOGDEV" ] && \
-        TEST_OPTIONS="$TEST_OPTIONS -ologdev=$TEST_LOGDEV"
-    _sudo mount -t xfs $TEST_OPTIONS $MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
-}
-
-_i386_install()
-{
-    _sudo cp -f "$KWORKAREA/arch/i386/boot/bzImage" "$IMAGE" 2>&1 \
-		|| _fail "	    !!! install kernel failed"
-    _sudo cp -f "$KWORKAREA/System.map" "$SYSTEMMAP" 2>&1 \
-		|| _fail "	    !!! install kernel failed"
-    if [ -z "$KMODULES" -o "$KMODULES" = yes ]; then
-	_sudo make EXTRAVERSION=-$EXTRA modules_install 2>&1 \
-		|| _fail "	    !!! install modules failed"
-    fi
-
-
-    if [ -z "$KINSTALL" -o "$KINSTALL" = lilo ]; then
-	_log "	*** reinit lilo"
-	_sudo /sbin/lilo 2>&1 \
-		|| _fail "	    !!! reinit lilo failed"
-    fi
-}
-
-_i386_restart()
-{
-    if [ -z "$KINSTALL" -o "$KINSTALL" = lilo ]; then
-	_sudo /sbin/lilo -R $EXTRA $KERNEL_OPTIONS 2>&1 \
-		|| _fail "	    !!! lilo failed"
-    fi
-}
-
-_ia64_install()
-{
-    echo not yet implemented
-}
-
-_ia64_restart()
-{
-    echo not yet implemented
-}
-
-_check_kernel()
-{
-    [ -d "$KWORKAREA" ]	|| _fail "    !!! QA kernel workarea \"$KWORKAREA\" not found"
-    [ -r "$CONFIG" ]	|| _fail "    !!! Can't read config file $CONFIG"
-}
-
-
-_log "*** XFS QA (`date`)"
-
-_get_state
-
-# check preconditions for starting state
-case $1
-in
-    cron-init)
-	case $state
-	in
-	    *done)
-		;;
-	    *)
-		_fail "    !!! cron-init while not in \"*done\" state"
-		;;
-	esac
-	;;
-    cron-restarted)
-	# we don't auto restart after reboot, but cron the restart
-	# to happen a bit later - it's much easier and safer that way
-	if [ "$state" != "cron-restarted" ]
-	then
-	    _fail "    !!! cron-restarted while not in \"cron-restarted\" state"
-	fi
-	;;
-esac
-
-[ -n "$1" ] && _set_state $1
-[ -n "$2" ] && stop_state=$2
-
-[ "$UID" -eq 0 ]	&& _fail "    !!! QA most be run as a normal user"
-[ -d "$ROOT" ]		|| _fail "    !!! QA root \"$ROOT\" not found"
-[ -d "$WORKAREA" ]	|| _fail "    !!! QA workarea \"$WORKAREA\" not found"
-cd $QADIR
-. "$COMMON_CONFIG" 	|| _fail "    !!! Couldn't source $COMMON_CONFIG"
-
-_get_kernel_version
-IMAGE="$BOOT/vmlinuz-$EXTRA"
-SYSTEMMAP="$BOOT/System.map-$VERSION-$EXTRA"
-MODULES="/lib/modules/$SVERSION"
-
-cd $ROOT
-
-started=1
-echo "auto-qa started" | wall
-
-while true
-do
-    _get_state
-
-    _log "    *** state $state start (`date`)"
-    _log "	(user=$USER, host=$HOST)"
-    new_state=""
-
-    start_state=$state
-
-    case $state
-    in
-	*init)
-	    echo "" > $ROOT/qa.log
-	    echo "" > $ROOT/qa.full
-	    _log "******************************************************"
-	    _log "QA init $VERSION (`date`)"
-	    _log "******************************************************"
-	    new_state="updatetools"
-	    ;;
-	
-	*updatetools)
-	    _update_workarea "$WORKAREA"
-	    new_state="cleantools"
-	    ;;
-
-	*cleantools)
-	    # we need to configure or else we might fail to clean
-	    for pkg in attr acl xfsprogs xfsdump xfstests
-	    do
-		[ -d $WORKAREA/$pkg ] || continue
-		cd $WORKAREA/$pkg
-		_log "	*** clean $pkg tools"
-		make realclean 2>&1 \
-			|| _fail "	    !!! clean $pkg failed"
-	    done
-	    new_state="buildtools"
-	    ;;
-
-	*buildtools)
-	    _log "	*** build and install tools"
-	    for pkg in attr acl xfsprogs xfsdump xfstests 
-	    do
-		[ -d $WORKAREA/$pkg ] || continue
-		cd $WORKAREA/$pkg
-
-		make configure 2>&1 \
-			|| _fail "	    !!! configure $pkg failed"
-		make default 2>&1 \
-			|| _fail "	    !!! build $pkg failed"
-
-		_sudo make install install-dev 2>&1 \
-			|| _fail "	    !!! install $pkg failed"
-
-		# attr and acl now have install-lib targets as well
-		[ "$pkg" = "attr" -o "$pkg" = "acl" ] || continue
-		_sudo make install-lib 2>&1 \
-			|| _fail "	    !!! install $pkg failed"
-	    done
-
-	    new_state="updatekernel"
-	    ;;
-
-	*updatekernel)
-	    _check_kernel
-	    _update_workarea "$KWORKAREA"
-	    new_state="cleankernel"
-	    ;;
-
-	*cleankernel)
-	    _check_kernel
-	    _log "	*** clean kernel"
-	    cd "$KWORKAREA"
-	    make mrproper 2>&1 \
-			|| _fail "	    !!! clean kernel failed"
-
-	    _log "	*** install configuration file"
-	    cp -f $CONFIG "$KWORKAREA/.config" 2>&1 \
-			|| _fail "	    !!! failed to install config"
-	    
-	    _log "	*** remove version file"
-	    rm -f include/linux/version.h 2>&1 \
-			|| _fail "	    !!! failed to clean version"
-
-	    new_state="reconfig"
-	    ;;
-	    
-	*reconfig)
-	    _check_kernel
-	    _log "	*** reconfig kernel"
-	    
-	    # we better start from scratch if this fails
-	    _change_state "cleankernel"
-	    
-	    cd "$KWORKAREA"
-	    # we want to use default options for any new config options.
-	    echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" | \
-		make EXTRAVERSION=-$EXTRA oldconfig 2>&1 \
-			|| _fail "	    !!! reconfig oldconfig failed"
-	    make EXTRAVERSION=-$EXTRA dep 2>&1 \
-			|| _fail "	    !!! reconfig dep failed"
-
-	    new_state="buildkernel"
-	    ;;
-	    
-	*buildkernel)
-	    _check_kernel
-	    _log "	*** build kernel"
-	    _log "          --- kernel ($IMAGE)"
-	    [ -z "$KMODULES" -o "$KMODULES" = yes ] && \
-            _log "          --- modules ($MODULES)"
-	    
-	    _change_state "cleankernel" ; # we better start from scratch if this fails
-	    
-	    cd "$KWORKAREA"
-	    [ -z "$KTARGET" ] && KTARGET=bzImage
-	    [ -z "$KMODULES" -o "$KMODULES" = yes ] && \
-		KTARGET="$KTARGET modules"
-	    make -j4 EXTRAVERSION=-$EXTRA $KTARGET 2>&1 \
-			|| _fail "	    !!! build $KTARGET failed"
-	    new_state="install"
-	    ;;
-
-	*install)
-	    _check_kernel
-	    _log "	*** blat old modules"
-	    _sudo rm -rf $MODULES
-	    
-	    _log "	*** install kernel"
-	    cd "$KWORKAREA"
-	    case `uname -m`
-	    in
-		i386|i686)	_i386_install ;;
-		ia64)		_ia64_install ;;
-	    esac
-
-	    new_state="restart"
-	    ;;
-	    
-	*restart)
-	    _log "	    *** select qa kernel"
-	    case `uname -m`
-	    in
-		i386|i686)	_i386_restart ;;
-		ia64)		_ia64_restart ;;
-	    esac
-
-	    _log "	    *** prepare to restart"
-	    _change_state "restarted"
-	    
-	    _log "	    *** restarting"
-
-	    _restart # doesn't return
-	    ;;
-	    
-	*restarted)
-	    _log "	    *** QA reentered after restart"
-	    
-	    new_state="check"
-	    ;;
-	  
-	*check)
-	    uname=`uname -a`
-	    _log "	    *** uname $uname"
-
-	    if [ "$MODULAR" -eq 0 ]; then
-		new_state="reset"
-	    else
-		new_state="probe"
-	    fi
-	    ;;
-	    
-	*probe)
-	    _log "	    *** modules dependencies"
-	    _sudo depmod -a  2>&1 \
-			|| _fail "	    !!! failed to depmod -a" 
-	    
-	    _log "	    *** unmounting XFS mounts"
-	    _sudo umount -a -t xfs 2>&1
-	    
-	    _log "	    *** removing modules"
-	    for m in xfsidbg xfs kdbm_pg kdbm_vm
-	    do
-		_sudo rmmod $m 2> /dev/null
-	    done
-	    
-	    _log "	    *** installing modules"
-	    _sudo modprobe xfs 2>&1 \
-			|| _fail "	    !!! failed to modprobe xfs"
-
-	    new_state="reset"
-	    ;;
-	    
-	*reset)
-	    
-	    _log "	    *** unmounting TEST_DEV"
-	    _sudo umount $TEST_DEV 2>&1
-	    
-	    _log "	    *** unmounting SCRATCH_DEV"
-	    _sudo umount $SCRATCH_DEV 2>&1
-	    
-	    _log "	    *** clean TEST_DEV"
-	    _test_mkfs_xfs 2>&1 \
-			|| _fail "	    !!! failed to mkfs TEST_DEV"
-	    
-	    _log "	    *** mounting TEST_DEV"
-	    _test_mount 2>&1 \
-			|| _fail "	    !!! failed to mount"
-				    
-	    new_state="run"
-	    ;;
-	    
-	soak-run)
-	    cd $QADIR
-	    
-	    _log "	    *** run soak test"
-	    _sudo ./soak $SOAK_PASSES $SOAK_STRESS $SOAK_PROC \
-			|| _fail "	    !!! failed to run soak test"
-
-	    new_state="done"
-	    ;;
-	    
-	bench-run)
-	    cd $QADIR
-	    
-	    # $BENCHMARK is typically unset, which equates to "all"
-	    #
-	    _log "	    *** run benchmarks"
-	    _sudo ./bench $BENCH_PASSES `id -nu && id -ng` $BENCHMARK \
-			|| _fail "	    !!! failed to run benchmarks"
-
-	    _log ""
-	    _log "	    *** send results mail"
-	    mail -s "XFS QA benchmark results" $EMAIL < $QADIR/bench.out 2>&1
-	
-	    new_state="done"
-	    ;;
-	    
-	*run)
-	    cd $QADIR
-	    
-	    _log "	    *** run tests ($CHECK_OPTIONS)"
-	    _sudo ./check -l $CHECK_OPTIONS 2>&1 | tee $ROOT/qa.out
-	    
-	    _log ""
-	    _log "	    *** send status mail"
-	    mail -s "XFS QA status report" $EMAIL < $ROOT/qa.out 2>&1
-	
-	    new_state="done"
-	    ;;
-	    
-	*done)
-	    _log "*** requested QA state transitions complete"
-
-	    _success
-	    ;;
-	    
-	*nothing)
-	    new_state="done"
-	    _log "    *** do nothing"
-	    ;;
-	    
-	*)
-	    _fail "	   !!! unknown state $state"
-	    ;;
-    esac
-
-    _log "    *** state $state done (`date`)"
-    [ "$new_state" = "" ] && _fail "    !!! no new state set"
-
-    if [ -n "$stop_state" ]
-    then
-        # remove hyphen prefixes
-	s1=`echo $start_state | sed 's/.*-//'`
-	s2=`echo $stop_state | sed 's/.*-//'`
-
-	if [ $s1 = $s2 ]
-	then
-	    # we have been requested to stop here and not go on
-	    new_state="done"
-	fi
-    fi
-
-    _change_state $new_state
-    
-done
-- 
2.45.2

