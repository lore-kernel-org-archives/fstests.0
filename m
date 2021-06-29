Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DBFC11F66
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Jun 2021 07:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4529661D9E
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Jun 2021 07:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhF2Hfo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Jun 2021 03:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhF2Hfo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Jun 2021 03:35:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F34C061574
        for <fstests@vger.kernel.org>; Tue, 29 Jun 2021 00:33:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j34so199849wms.5
        for <fstests@vger.kernel.org>; Tue, 29 Jun 2021 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVPaXhP4cBtgjlb3v53mLCu2tWlftpcFw5j8V8nNMIA=;
        b=UkSHadrU0Q0KJ0zFdVRBAxAOlHigugZhJP771c8NC4++Q1z5QFXd7vl7ZOjEkZjnZk
         pcTKRlJWJQ38vbwjkGb6ZMFe4m2XojrgCWp/JA5PnhNTW7VhE74ZvUjPnvbXyvD4eaFo
         8TfnLp89OkfJ8zAWzhlRsc7ujc6KU/FiYXCCT9fxP/HK2MNbCxOkgdiYqU+r+6gvlSok
         y+ZMXiUNgdx3zV7uCk0InDsj3YDC+XiG0yUoD+0ncawixNYdKxBgBhonfiV3JcjSgI9f
         YGrF2JBP5ekh4WGC7UafjYovtT8/PLUw3VthxAtb9uDZq1MP4ozr/wGfS+dusRAI8vRE
         ckTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVPaXhP4cBtgjlb3v53mLCu2tWlftpcFw5j8V8nNMIA=;
        b=Ct0h2DmxmLuGaQonQy5Yf8Jw1H0uleyp7XTONs0rDZRM3hV0CoLJ95TMGIToJr067M
         fCK9QrU+Kkhj8GCfahXUlhA1GYJXNN+NEOLDix8Afpi1MTI9H6G4+XL6AMtwjyZJqOme
         oiDYU0rcoknnvnLO74E7RaYaCrdwEfAL0zkN+3ElFiLAN2iq/ZHE6IqlM3P6xKqnsz9z
         CQV26YWI+hz2QUWF3CoJBopC7scLPRwxeBTezfGP1gURfsQixV01eO+geNpDctE8+9zW
         TXeAtw8I5w5+yHenxz0FG6tyMVsfIyQtjR75GgGpCsD1sJqI8h+zcconR+f3a3JaVFcb
         pfSQ==
X-Gm-Message-State: AOAM531men7OpY9DWK63eXczdUPJWGGKM+OJP06iya4+VUc4RT5UC/ue
        YgU7UKhZfBwWnLPeLLhZJz/V6A0C66gbtA==
X-Google-Smtp-Source: ABdhPJyCzc0PriWhSl/+KELkxgYCRDYxGb6cxKF9feJUfmHk5QfZrytSUCnrX9/6HMrHzmZ4bDWfdQ==
X-Received: by 2002:a1c:21c5:: with SMTP id h188mr31414843wmh.165.1624951995326;
        Tue, 29 Jun 2021 00:33:15 -0700 (PDT)
Received: from uvv-2004-vm.localdomain (dslb-002-205-007-071.002.205.pools.vodafone-ip.de. [2.205.7.71])
        by smtp.gmail.com with ESMTPSA id m7sm15239771wms.24.2021.06.29.00.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 00:33:14 -0700 (PDT)
From:   Vyacheslav Yurkov <uvv.mail@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>
Subject: [PATCH] Revert "build: Use the original install-sh file from SGI"
Date:   Tue, 29 Jun 2021 09:32:47 +0200
Message-Id: <20210629073247.230001-1-uvv.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>

This reverts commit da7916f72206750cce0d0d306d3ba9094a375880.

Old install-sh fails in cross-compilation environments like yocto.

Signed-off-by: Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>
---
 Makefile           |   1 -
 include/install-sh | 352 ---------------------------------------------
 2 files changed, 353 deletions(-)
 delete mode 100755 include/install-sh

diff --git a/Makefile b/Makefile
index 86a2d399..c52daeb8 100644
--- a/Makefile
+++ b/Makefile
@@ -61,7 +61,6 @@ endif
 
 configure: configure.ac
 	libtoolize -cfi
-	cp include/install-sh .
 	aclocal -I m4
 	autoheader
 	autoconf
diff --git a/include/install-sh b/include/install-sh
deleted file mode 100755
index a19cbe31..00000000
--- a/include/install-sh
+++ /dev/null
@@ -1,352 +0,0 @@
-#! /bin/bash
-#
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This script emulates bsd install and also recognises
-# two environment variables, with the following semantics :-
-#
-# $DIST_MANIFEST - if set, the name of the file to append manifest
-#                  information in the following format:
-#                  File     :  f mode owner group src target
-#                  Directory:  d mode owner group target
-#                  Symlink  :  l linkval target
-#
-# $DIST_ROOT     - if set, prepend to target
-#
-# The sematics of all combinations of these two variables
-# are as follows:
-#
-# $DIST_MANIFEST?  $DIST_ROOT? |   Copy?  Append Manifest?
-# -----------------------------+--------------------------
-#       not set       not set  |    yes        no
-#       not set       set      |    yes        no
-#       set           not set  |    no         yes
-#       set           set      |    yes        yes
-#
-_usage() {
-    echo "Usage: $prog [-o owner] [-g group] [-m mode] -d directory"
-    echo "or     $prog [-D] [-o owner] [-g group] [-m mode] file directory/file"
-    echo "or     $prog [-o owner] [-g group] [-m mode] file [file ...] directory"
-    echo "or     $prog -S file target  (creates \"target\" symlink)"
-    echo "or     $prog -T lt_arg [-o owner] [-g group] [-m mode] libtool.lai directory"
-    echo ""
-    echo "The \$DIST_MANIFEST and \$DIST_ROOT environment variables affect the"
-    echo "behaviour of this command - see comments in the script."
-    echo "The -D flag is only available for the second usage, and causes"
-    echo "the target directory to be created before installing the file."
-    echo ""
-    exit 1
-}
-
-_chown ()
-{
-    _st=255
-    if [ $# -eq 3 ] ; then
-	chown $1:$2 $3
-	_st=$?
-	if [ $_st -ne 0 ] ; then
-	    if [ $REAL_UID != '0' ] ; then
-		if [ ! -f $DIST_ROOT/.chown.quiet ] ; then
-		    echo '==============================================='
-		    echo Ownership of files under ${DIST_ROOT:-/}
-		    echo cannot be changed
-		    echo '==============================================='
-		    if [ -n "$DIST_ROOT" ] ; then
-			touch $DIST_ROOT/.chown.quiet
-		    fi
-		fi
-	       _st=0
-	    fi
-	fi
-    fi
-
-    return $_st
-}
-
-
-_manifest ()
-{
-    echo $* | sed -e 's/\/\//\//g' >>${DIST_MANIFEST:-/dev/null}
-}
-
-prog=`basename $0`
-HERE=`pwd`
-dflag=false
-Dflag=false
-Sflag=false
-Tflag=false
-DIRMODE=755
-FILEMODE=644
-OWNER=`id -u`
-GROUP=`id -g`
-REAL_UID=$OWNER
-
-# default is to install and don't append manifest
-INSTALL=true
-MANIFEST=:
-
-: ${DIST_ROOT:=${DESTDIR}}
-
-[ -n "$DIST_MANIFEST" -a -z "$DIST_ROOT" ] && INSTALL=false
-[ -n "$DIST_MANIFEST" ] && MANIFEST="_manifest"
-
-[ $# -eq 0 ] && _usage
-
-if $INSTALL
-then
-    CP=cp; LN=ln; MKDIR=mkdir; CHMOD=chmod; CHOWN=_chown
-else
-    CP=true; LN=true; MKDIR=true; CHMOD=true; CHOWN=true
-fi
-
-[ -n "$DIST_ROOT" -a $REAL_UID -ne 0 ] && CHOWN=true
-
-while getopts "Dcm:d:S:o:g:T:" c $*
-do
-   case $c in
-   c)
-	;;
-   g)
-	GROUP=$OPTARG
-	;;
-   o)
-	OWNER=$OPTARG
-	;;
-   m)
-	DIRMODE=`expr $OPTARG`
-	FILEMODE=$DIRMODE
-	;;
-   D)
-	Dflag=true
-	;;
-   S)
-	symlink=$OPTARG
-	Sflag=true
-	;;
-   d)
-	dir=$DIST_ROOT/$OPTARG
-	dflag=true
-	;;
-   T)
-	lt_install=$OPTARG
-	Tflag=true
-	;;
-   *)
-	_usage
-	;;
-   esac
-done
-
-shift `expr $OPTIND - 1`
-
-status=0
-if $dflag
-then
-    #
-    # first usage
-    #
-    $MKDIR -p $dir
-    status=$?
-    if [ $status -eq 0 ]
-    then
-	$CHMOD $DIRMODE $dir
-	status=$?
-    fi
-    if [ $status -eq 0 ]
-    then
-	$CHOWN $OWNER $GROUP $dir
-	status=$?
-    fi
-    $MANIFEST d $DIRMODE $OWNER $GROUP ${dir#$DIST_ROOT}
-elif $Sflag
-then
-    #
-    # fourth usage (symlink)
-    #
-    if [ $# -ne 1 ]
-    then
-	_usage
-    else
-	target=$DIST_ROOT/$1
-    fi
-    $LN -s -f $symlink $target
-    status=$?
-    $MANIFEST l $symlink ${target#$DIST_ROOT}
-elif $Tflag
-then
-    #
-    # -T (install libs built by libtool)
-    #
-    if [ $# -ne 2 ]
-    then
-	_usage
-    else
-	libtool_lai=$1
-	# source the libtool variables
-	if [ ! -f $libtool_lai ]
-	then
-		echo "$prog: Unable to find libtool library file $libtool_lai"
-		exit 2
-	fi
-	. ./$libtool_lai
-	target=$DIST_ROOT/$2
-    fi
-    case $lt_install in
-    so_dot_version)
-	# Loop until we find libfoo.so.x.y.z, then break out.
-	for solib in $library_names
-	do
-		# does it have enough parts?  libfoo.so.x.y.z == 5
-		cnt=`echo "$solib" | sed -e 's/\./ /g' | wc -w`
-		if [ $cnt -eq 5 ]
-		then
-			install_name=$target/$solib
-			$CP $solib $install_name
-			status=$?
-			$MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$solib ${install_name#$DIST_ROOT}
-			break
-		fi
-	done
-	;;
-
-    so_*)
-	case $lt_install in
-	so_dot_current)
-		# ln -s libfoo.so.x.y.z to libfoo.so.x
-		from_parts=5  # libfoo.so.x.y.z
-		to_parts=3    # libfoo.so.x
-		;;
-	so_base)
-		# ln -s libfoo.so.x to libfoo.so
-		from_parts=3  # libfoo.so.x
-		to_parts=2    # libfoo.so
-		;;
-	*)
-		echo "$prog: -T $lt_install invalid"
-		exit 2
-		;;
-	esac
-
-	# Loop until we find the names, then break out.
-	for solib in $library_names
-	do
-		# does it have enough parts?
-		cnt=`echo "$solib" | sed -e 's/\./ /g' | wc -w`
-		if [ $cnt -eq $from_parts ]
-		then
-			from_name=$solib
-		elif [ $cnt -eq $to_parts ]
-		then
-			to_name=$solib
-		fi
-
-		if [ -n "$from_name" ] && [ -n "$to_name" ]
-		then
-			install_name=$target/$to_name
-			$LN -s -f $from_name $install_name
-			status=$?
-			$MANIFEST l $from_name ${install_name#$DIST_ROOT}
-			break
-		fi
-	done
-	;;
-    old_lib)
-	install_name=$target/$old_library
-	$CP $old_library $install_name
-	status=$?
-	$MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$old_library ${install_name#$DIST_ROOT}
-	;;
-    *)
-	echo "$prog: -T $lt_install invalid"
-	exit 2
-	;;
-    esac
-
-    case $lt_install in
-    old_lib|so_dot_version)
-	if [ $status -eq 0 ]
-	then
-		$CHMOD $FILEMODE $install_name
-		$CHOWN $OWNER $GROUP $install_name
-	fi
-	;;
-    esac
-
-else
-    list=""
-    dir=""
-    if [ $# -eq 2 ]
-    then
-	#
-	# second usage
-	#
-	f=$1
-	dir=$DIST_ROOT/$2
-	if $Dflag
-	then
-	    mkdir -p `dirname $dir`
-	fi
-	$CP $f $dir
-	status=$?
-	if [ $status -eq 0 ]
-	then
-	    if [ -f $dir/$f ]
-	    then
-		$CHMOD $FILEMODE $dir/$f
-		status=$?
-		if [ $status -eq 0 ]
-		then
-		    $CHOWN $OWNER $GROUP $dir/$f
-		    status=$?
-		fi
-		$MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$f ${dir#$DIST_ROOT}/$f
-	    else
-		$CHMOD $FILEMODE $dir
-		status=$?
-		if [ $status -eq 0 ]
-		then
-		    $CHOWN $OWNER $GROUP $dir
-		    status=$?
-		fi
-		$MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$dir ${dir#$DIST_ROOT}
-	    fi
-	fi
-    else
-	#
-	# third usage
-	#
-	n=1
-	while [ $# -gt 0 ]
-	do
-	    if [ $# -gt 1 ]
-	    then
-		list="$list $1"
-	    else
-		dir=$DIST_ROOT/$1
-	    fi
-	    shift
-	done
-
-	# echo DIR=$dir list=\"$list\"
-	for f in $list
-	do
-	    $CP $f $dir
-	    status=$?
-	    if [ $status -eq 0 ]
-	    then
-		$CHMOD $FILEMODE $dir/$f
-		status=$?
-		if [ $status -eq 0 ]
-		then
-		    $CHOWN $OWNER $GROUP $dir/$f
-		    status=$?
-		fi
-		$MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$f ${dir#$DIST_ROOT}/$f
-	    fi
-	    [ $status -ne 0 ] && break
-	done
-    fi
-fi
-
-exit $status
-- 
2.25.1

